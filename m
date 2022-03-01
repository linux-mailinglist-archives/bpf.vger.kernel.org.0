Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB70F4C82E6
	for <lists+bpf@lfdr.de>; Tue,  1 Mar 2022 06:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiCAFXL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Mar 2022 00:23:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbiCAFXI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Mar 2022 00:23:08 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE55261B
        for <bpf@vger.kernel.org>; Mon, 28 Feb 2022 21:22:26 -0800 (PST)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4K75Bg5NnRz9sRh;
        Tue,  1 Mar 2022 13:18:51 +0800 (CST)
Received: from huawei.com (10.67.174.197) by kwepemi500013.china.huawei.com
 (7.221.188.120) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 1 Mar
 2022 13:22:24 +0800
From:   Xu Kuohai <xukuohai@huawei.com>
To:     <bpf@vger.kernel.org>
CC:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Shuah Khan <shuah@kernel.org>, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>
Subject: [PATCH bpf-next v4 1/2] libbpf: Skip forward declaration when counting duplicated type names
Date:   Tue, 1 Mar 2022 00:32:49 -0500
Message-ID: <20220301053250.1464204-2-xukuohai@huawei.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220301053250.1464204-1-xukuohai@huawei.com>
References: <20220301053250.1464204-1-xukuohai@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.197]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500013.china.huawei.com (7.221.188.120)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently if a declaration appears in the BTF before the definition, the
definition is dumped as a conflicting name, eg:

    $ bpftool btf dump file vmlinux format raw | grep "'unix_sock'"
    [81287] FWD 'unix_sock' fwd_kind=struct
    [89336] STRUCT 'unix_sock' size=1024 vlen=14

    $ bpftool btf dump file vmlinux format c | grep "struct unix_sock"
    struct unix_sock;
    struct unix_sock___2 {	<--- conflict, the "___2" is unexpected
		    struct unix_sock___2 *unix_sk;

This causes a compilation error if the dump output is used as a header
file.

Fix it by skipping declaration when counting duplicated type names.

Fixes: 351131b51c7a ("libbpf: add btf_dump API for BTF-to-C conversion")
Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
Acked-by: Song Liu <songliubraving@fb.com>
---
 tools/lib/bpf/btf_dump.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index 07ebe70d3a30..6b1bc1f43728 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -1505,6 +1505,11 @@ static const char *btf_dump_resolve_name(struct btf_dump *d, __u32 id,
 	if (s->name_resolved)
 		return *cached_name ? *cached_name : orig_name;
 
+	if (btf_is_fwd(t) || (btf_is_enum(t) && btf_vlen(t) == 0)) {
+		s->name_resolved = 1;
+		return orig_name;
+	}
+
 	dup_cnt = btf_dump_name_dups(d, name_map, orig_name);
 	if (dup_cnt > 1) {
 		const size_t max_len = 256;
-- 
2.30.2

