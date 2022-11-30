Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8064463CF60
	for <lists+bpf@lfdr.de>; Wed, 30 Nov 2022 07:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbiK3GzU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Nov 2022 01:55:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiK3GzT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Nov 2022 01:55:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61A14F18F
        for <bpf@vger.kernel.org>; Tue, 29 Nov 2022 22:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669791264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c9O5Aw7tkF9mUe77O9dqtCDvw6APFkrLSv7rvkAGt38=;
        b=BWTBEI+BdvL1AabbxDoio7yib89kM8Sk3VLLEZeD0KA8fHeTR9782483I8cifxpyKYcTa+
        9A5Jdgj1bUp1XbOf+90YXDyIdnH73J7p+Qjp1Dl2qsxZVNwnsyV49c2LJGnBGh4KsTz8LH
        NZKGWX5fBH2zT0cGANsXPfUUf3ief5k=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-13-nPNW590aMYaz0czb1SnYvA-1; Wed, 30 Nov 2022 01:54:19 -0500
X-MC-Unique: nPNW590aMYaz0czb1SnYvA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E8AFC38123A0;
        Wed, 30 Nov 2022 06:54:18 +0000 (UTC)
Received: from ovpn-192-146.brq.redhat.com (ovpn-192-146.brq.redhat.com [10.40.192.146])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D3152C15BA4;
        Wed, 30 Nov 2022 06:54:15 +0000 (UTC)
From:   Viktor Malik <vmalik@redhat.com>
To:     bpf@vger.kernel.org
Cc:     Martin KaFai Lau <martin.lau@linux.dev>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Viktor Malik <vmalik@redhat.com>
Subject: [PATCH bpf-next v2 2/3] bpf: Fix attaching fentry/fexit/fmod_ret/lsm to modules
Date:   Wed, 30 Nov 2022 07:54:03 +0100
Message-Id: <e7d42f8f48ab4323ba460b4c843c27f3c475f106.1669787912.git.vmalik@redhat.com>
In-Reply-To: <cover.1669787912.git.vmalik@redhat.com>
References: <cover.1669787912.git.vmalik@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When attaching fentry/fexit/fmod_ret/lsm to a function located in a
module without specifying the target program, the verifier tries to find
the address to attach to in kallsyms. This is always done by searching
the entire kallsyms, not respecting the module in which the function is
located.

This approach causes an incorrect attachment address to be computed if
the function to attach to is shadowed by a function of the same name
located earlier in kallsyms.

Since the attachment must contain the BTF of the program to attach to,
we may extract the module name from it (if the attach target is a
module) and search for the function address in the correct module.

Signed-off-by: Viktor Malik <vmalik@redhat.com>
---
 include/linux/btf.h   | 1 +
 kernel/bpf/btf.c      | 5 +++++
 kernel/bpf/verifier.c | 5 ++++-
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 9ed00077db6e..bdbf3eb7083d 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -187,6 +187,7 @@ u32 btf_obj_id(const struct btf *btf);
 bool btf_is_kernel(const struct btf *btf);
 bool btf_is_module(const struct btf *btf);
 struct module *btf_try_get_module(const struct btf *btf);
+const char *btf_module_name(const struct btf *btf);
 u32 btf_nr_types(const struct btf *btf);
 bool btf_member_is_reg_int(const struct btf *btf, const struct btf_type *s,
 			   const struct btf_member *m,
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index d11cbf8cece7..2815944ddfa4 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7206,6 +7206,11 @@ bool btf_is_module(const struct btf *btf)
 	return btf->kernel_btf && strcmp(btf->name, "vmlinux") != 0;
 }
 
+const char *btf_module_name(const struct btf *btf)
+{
+	return btf->name;
+}
+
 enum {
 	BTF_MODULE_F_LIVE = (1 << 0),
 };
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4e7f1d085e53..41f6a8722a97 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16451,7 +16451,10 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 			else
 				addr = (long) tgt_prog->aux->func[subprog]->bpf_func;
 		} else {
-			addr = kallsyms_lookup_name(tname);
+			if (btf_is_module(btf))
+				addr = kallsyms_lookup_name_in_module(btf_module_name(btf), tname);
+			else
+				addr = kallsyms_lookup_name(tname);
 			if (!addr) {
 				bpf_log(log,
 					"The address of function %s cannot be found\n",
-- 
2.38.1

