Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF62A6F0FE1
	for <lists+bpf@lfdr.de>; Fri, 28 Apr 2023 03:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344155AbjD1BIt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Apr 2023 21:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjD1BIs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Apr 2023 21:08:48 -0400
Received: from out-56.mta1.migadu.com (out-56.mta1.migadu.com [95.215.58.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3AFD268E
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 18:08:46 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1682644125;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=6+pEUaUKtIGoMuarDI0wyLSMFsoQrrZQFIxQAVVyIzQ=;
        b=PbyRsamN2hjh49w1/DFGh2JXq78ErWSPzmZ40H+ic6xe+gbu0yZcNueH/wo8OZ9PBZPBeB
        F+PSOiJYxGBdgnZsiq5o0rf2JtLlO8HBMahJ8nx7taqvnkM1xdjKMkIF1c2ckYtEz1h7IX
        kaBr+/B5CozQ++pc1KzhnLG7QjoTL9I=
From:   Martin KaFai Lau <martin.lau@linux.dev>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@meta.com
Subject: [PATCH bpf-next] libbpf: btf_dump_type_data_check_overflow needs to consider BTF_MEMBER_BITFIELD_SIZE
Date:   Thu, 27 Apr 2023 18:08:39 -0700
Message-Id: <20230428010839.1328507-1-martin.lau@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Martin KaFai Lau <martin.lau@kernel.org>

The btf_dump/struct_data selftest is failing with:
test_btf_dump_struct_data:FAIL:unexpected return value dumping fs_context unexpected unexpected return value dumping fs_context: actual -7 != expected 264

The reason is in btf_dump_type_data_check_overflow(). It does not use
BTF_MEMBER_BITFIELD_SIZE from the struct's member (btf_member). Instead,
it is using the enum size which is 4. It had been working till the recent
commit 4e04143c869c ("fs_context: drop the unused lsm_flags member")
removed an integer member which also removed the 4 bytes padding at the end
of the fs_context. Missing this 4 bytes padding exposed this bug.
In particular, when btf_dump_type_data_check_overflow() reaches
the member 'phase', -E2BIG is returned.

The fix is to pass bit_sz to btf_dump_type_data_check_overflow().
In btf_dump_type_data_check_overflow(), it does a different size
check when bit_sz is not zero.

The current fs_context:

[3600] ENUM 'fs_context_purpose' encoding=UNSIGNED size=4 vlen=3
	'FS_CONTEXT_FOR_MOUNT' val=0
	'FS_CONTEXT_FOR_SUBMOUNT' val=1
	'FS_CONTEXT_FOR_RECONFIGURE' val=2
[3601] ENUM 'fs_context_phase' encoding=UNSIGNED size=4 vlen=7
	'FS_CONTEXT_CREATE_PARAMS' val=0
	'FS_CONTEXT_CREATING' val=1
	'FS_CONTEXT_AWAITING_MOUNT' val=2
	'FS_CONTEXT_AWAITING_RECONF' val=3
	'FS_CONTEXT_RECONF_PARAMS' val=4
	'FS_CONTEXT_RECONFIGURING' val=5
	'FS_CONTEXT_FAILED' val=6
[3602] STRUCT 'fs_context' size=264 vlen=21
	'ops' type_id=3603 bits_offset=0
	'uapi_mutex' type_id=235 bits_offset=64
	'fs_type' type_id=872 bits_offset=1216
	'fs_private' type_id=21 bits_offset=1280
	'sget_key' type_id=21 bits_offset=1344
	'root' type_id=781 bits_offset=1408
	'user_ns' type_id=251 bits_offset=1472
	'net_ns' type_id=984 bits_offset=1536
	'cred' type_id=1785 bits_offset=1600
	'log' type_id=3621 bits_offset=1664
	'source' type_id=42 bits_offset=1792
	'security' type_id=21 bits_offset=1856
	's_fs_info' type_id=21 bits_offset=1920
	'sb_flags' type_id=20 bits_offset=1984
	'sb_flags_mask' type_id=20 bits_offset=2016
	's_iflags' type_id=20 bits_offset=2048
	'purpose' type_id=3600 bits_offset=2080 bitfield_size=8
	'phase' type_id=3601 bits_offset=2088 bitfield_size=8
	'need_free' type_id=67 bits_offset=2096 bitfield_size=1
	'global' type_id=67 bits_offset=2097 bitfield_size=1
	'oldapi' type_id=67 bits_offset=2098 bitfield_size=1

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 tools/lib/bpf/btf_dump.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index 580985ee5545..8f659ec8798d 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -2250,9 +2250,19 @@ static int btf_dump_type_data_check_overflow(struct btf_dump *d,
 					     const struct btf_type *t,
 					     __u32 id,
 					     const void *data,
-					     __u8 bits_offset)
+					     __u8 bits_offset,
+					     __u8 bit_sz)
 {
-	__s64 size = btf__resolve_size(d->btf, id);
+	__s64 size;
+
+	if (bit_sz) {
+		/* bits_offset is at most 7. bit_sz is at most 128. */
+		__u8 nr_bytes = (bits_offset + bit_sz + 7) / 8;
+
+		return data + nr_bytes > d->typed_dump->data_end ? -E2BIG : 0;
+	}
+
+	size = btf__resolve_size(d->btf, id);
 
 	if (size < 0 || size >= INT_MAX) {
 		pr_warn("unexpected size [%zu] for id [%u]\n",
@@ -2407,7 +2417,7 @@ static int btf_dump_dump_type_data(struct btf_dump *d,
 {
 	int size, err = 0;
 
-	size = btf_dump_type_data_check_overflow(d, t, id, data, bits_offset);
+	size = btf_dump_type_data_check_overflow(d, t, id, data, bits_offset, bit_sz);
 	if (size < 0)
 		return size;
 	err = btf_dump_type_data_check_zero(d, t, id, data, bits_offset, bit_sz);
-- 
2.34.1

