Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 826E54B2BFB
	for <lists+bpf@lfdr.de>; Fri, 11 Feb 2022 18:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346242AbiBKRoe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Feb 2022 12:44:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243899AbiBKRoe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Feb 2022 12:44:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CD844CD5
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 09:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644601472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=jsDcn8MRjShFB11jPe5Y0VJvr05nd65Dh+NmbGGIti4=;
        b=TvhfvsS6emPddVqyAt9UmbJOOHuI9N3o4Zt3ipaAjw0hJzP14hAN5A2Y/xsjEnxXNrrYP2
        7fNIsLpRi60+fFVtRIbVz0xnBk8BYWSBgB5j/Zz4k1Dz7tkrFnliu7GEaNXFTV2qafnb9a
        UvDeZCaKxtyKzfsReFjgDGgN8lGcEn8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-279-6_-Azt_6P8WeNIsB0EEmgg-1; Fri, 11 Feb 2022 12:44:28 -0500
X-MC-Unique: 6_-Azt_6P8WeNIsB0EEmgg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A25BE84DA41;
        Fri, 11 Feb 2022 17:44:26 +0000 (UTC)
Received: from thinkpad.redhat.com (unknown [10.40.192.171])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D94972DE99;
        Fri, 11 Feb 2022 17:44:22 +0000 (UTC)
From:   Felix Maurer <fmaurer@redhat.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, davemarchevsky@fb.com
Subject: [PATCH bpf-next] selftests: bpf: Check bpf_msg_push_data return value
Date:   Fri, 11 Feb 2022 18:43:36 +0100
Message-Id: <89f767bb44005d6b4dd1f42038c438f76b3ebfad.1644601294.git.fmaurer@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

bpf_msg_push_data may return a non-zero value to indicate an error. The
return value should be checked to prevent undetected errors.

To indicate an error, the BPF programs now perform a different action
than their intended one to make the userspace test program notice the
error, i.e., the programs supposed to pass/redirect drop, the program
supposed to drop passes.

Fixes: 84fbfe026acaa ("bpf: test_sockmap add options to use msg_push_data")
Signed-off-by: Felix Maurer <fmaurer@redhat.com>
---
 .../selftests/bpf/progs/test_sockmap_kern.h   | 26 +++++++++++++------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_kern.h b/tools/testing/selftests/bpf/progs/test_sockmap_kern.h
index 2966564b8497..6c85b00f27b2 100644
--- a/tools/testing/selftests/bpf/progs/test_sockmap_kern.h
+++ b/tools/testing/selftests/bpf/progs/test_sockmap_kern.h
@@ -235,7 +235,7 @@ SEC("sk_msg1")
 int bpf_prog4(struct sk_msg_md *msg)
 {
 	int *bytes, zero = 0, one = 1, two = 2, three = 3, four = 4, five = 5;
-	int *start, *end, *start_push, *end_push, *start_pop, *pop;
+	int *start, *end, *start_push, *end_push, *start_pop, *pop, err = 0;
 
 	bytes = bpf_map_lookup_elem(&sock_apply_bytes, &zero);
 	if (bytes)
@@ -249,8 +249,11 @@ int bpf_prog4(struct sk_msg_md *msg)
 		bpf_msg_pull_data(msg, *start, *end, 0);
 	start_push = bpf_map_lookup_elem(&sock_bytes, &two);
 	end_push = bpf_map_lookup_elem(&sock_bytes, &three);
-	if (start_push && end_push)
-		bpf_msg_push_data(msg, *start_push, *end_push, 0);
+	if (start_push && end_push) {
+		err = bpf_msg_push_data(msg, *start_push, *end_push, 0);
+		if (err)
+			return SK_DROP;
+	}
 	start_pop = bpf_map_lookup_elem(&sock_bytes, &four);
 	pop = bpf_map_lookup_elem(&sock_bytes, &five);
 	if (start_pop && pop)
@@ -263,6 +266,7 @@ int bpf_prog6(struct sk_msg_md *msg)
 {
 	int zero = 0, one = 1, two = 2, three = 3, four = 4, five = 5, key = 0;
 	int *bytes, *start, *end, *start_push, *end_push, *start_pop, *pop, *f;
+	int err = 0;
 	__u64 flags = 0;
 
 	bytes = bpf_map_lookup_elem(&sock_apply_bytes, &zero);
@@ -279,8 +283,11 @@ int bpf_prog6(struct sk_msg_md *msg)
 
 	start_push = bpf_map_lookup_elem(&sock_bytes, &two);
 	end_push = bpf_map_lookup_elem(&sock_bytes, &three);
-	if (start_push && end_push)
-		bpf_msg_push_data(msg, *start_push, *end_push, 0);
+	if (start_push && end_push) {
+		err = bpf_msg_push_data(msg, *start_push, *end_push, 0);
+		if (err)
+			return SK_DROP;
+	}
 
 	start_pop = bpf_map_lookup_elem(&sock_bytes, &four);
 	pop = bpf_map_lookup_elem(&sock_bytes, &five);
@@ -338,7 +345,7 @@ SEC("sk_msg5")
 int bpf_prog10(struct sk_msg_md *msg)
 {
 	int *bytes, *start, *end, *start_push, *end_push, *start_pop, *pop;
-	int zero = 0, one = 1, two = 2, three = 3, four = 4, five = 5;
+	int zero = 0, one = 1, two = 2, three = 3, four = 4, five = 5, err = 0;
 
 	bytes = bpf_map_lookup_elem(&sock_apply_bytes, &zero);
 	if (bytes)
@@ -352,8 +359,11 @@ int bpf_prog10(struct sk_msg_md *msg)
 		bpf_msg_pull_data(msg, *start, *end, 0);
 	start_push = bpf_map_lookup_elem(&sock_bytes, &two);
 	end_push = bpf_map_lookup_elem(&sock_bytes, &three);
-	if (start_push && end_push)
-		bpf_msg_push_data(msg, *start_push, *end_push, 0);
+	if (start_push && end_push) {
+		err = bpf_msg_push_data(msg, *start_push, *end_push, 0);
+		if (err)
+			return SK_PASS;
+	}
 	start_pop = bpf_map_lookup_elem(&sock_bytes, &four);
 	pop = bpf_map_lookup_elem(&sock_bytes, &five);
 	if (start_pop && pop)
-- 
2.34.1

