Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658CA68C28A
	for <lists+bpf@lfdr.de>; Mon,  6 Feb 2023 17:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbjBFQIp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Feb 2023 11:08:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbjBFQIh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Feb 2023 11:08:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80752135
        for <bpf@vger.kernel.org>; Mon,  6 Feb 2023 08:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675699675;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=eGfmMkW0/IkNO+6gsud37g3q2ocmic9bPukgp7KqTXI=;
        b=blw1xUxzHSROE9hBPxMRSTOaCiwEEZlZQxSuUdr5brE4bZhEztNzZ0jaNrHdzeIwHJPJaw
        ObNHEA1uNai5GXierK9JJBQs/MQOwL7iEMe2r7SkMi7qJ0wVq8nvRkpsYl237UAGrLYMCh
        41lcExYA0KZa5L5vcjURxIPi34KwAgE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-251-rgnx-7UmMqyWQQBzag8BwA-1; Mon, 06 Feb 2023 11:07:52 -0500
X-MC-Unique: rgnx-7UmMqyWQQBzag8BwA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C30BD85CBE2;
        Mon,  6 Feb 2023 16:07:51 +0000 (UTC)
Received: from thinkpad.redhat.com (ovpn-192-133.brq.redhat.com [10.40.192.133])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 93EA640CF8E2;
        Mon,  6 Feb 2023 16:07:49 +0000 (UTC)
From:   Felix Maurer <fmaurer@redhat.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, mykolal@fb.com, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org
Subject: [PATCH bpf-next] selftests: bpf: Use BTF map in sk_assign
Date:   Mon,  6 Feb 2023 17:07:36 +0100
Message-Id: <4ebd4e68dec83863c51a9114e6507524c8feafb7.1675698070.git.fmaurer@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The sk_assign selftest uses tc to load the BPF object file for the test. If
tc is linked against libbpf 1.0+, this test failed, because the BPF file
used the legacy maps section. This approach is considered legacy by libbpf
and tc (see examples/bpf/README in the iproute2 repo).

Therefore, switch to the approach recommended by iproute2 and use a BTF
defined map. This is also well supported by libbpf.

Signed-off-by: Felix Maurer <fmaurer@redhat.com>
---
 .../selftests/bpf/progs/test_sk_assign.c      | 24 +++++--------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_sk_assign.c b/tools/testing/selftests/bpf/progs/test_sk_assign.c
index 98c6493d9b91..b0536bdc002b 100644
--- a/tools/testing/selftests/bpf/progs/test_sk_assign.c
+++ b/tools/testing/selftests/bpf/progs/test_sk_assign.c
@@ -16,25 +16,13 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
 
-/* Pin map under /sys/fs/bpf/tc/globals/<map name> */
-#define PIN_GLOBAL_NS 2
-
-/* Must match struct bpf_elf_map layout from iproute2 */
 struct {
-	__u32 type;
-	__u32 size_key;
-	__u32 size_value;
-	__u32 max_elem;
-	__u32 flags;
-	__u32 id;
-	__u32 pinning;
-} server_map SEC("maps") = {
-	.type = BPF_MAP_TYPE_SOCKMAP,
-	.size_key = sizeof(int),
-	.size_value  = sizeof(__u64),
-	.max_elem = 1,
-	.pinning = PIN_GLOBAL_NS,
-};
+	__uint(type, BPF_MAP_TYPE_SOCKMAP);
+	__uint(key_size, sizeof(int));
+	__uint(value_size, sizeof(__u64));
+	__uint(max_entries, 1);
+	__uint(pinning, LIBBPF_PIN_BY_NAME);
+} server_map SEC(".maps");
 
 char _license[] SEC("license") = "GPL";
 
-- 
2.39.1

