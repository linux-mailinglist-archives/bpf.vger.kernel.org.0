Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A83C63A1F6
	for <lists+bpf@lfdr.de>; Mon, 28 Nov 2022 08:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbiK1H1j (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Nov 2022 02:27:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiK1H1i (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Nov 2022 02:27:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6E4A463
        for <bpf@vger.kernel.org>; Sun, 27 Nov 2022 23:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669620406;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6zK6dP0XpiEvbMh+MStSVKQQA+Ww92c90Z58azKzrgE=;
        b=SzM3zGMFDcFA9pOuvWH86DbE2rj0QNAsCVA/NrKJZHNv0QD9wMMp3BoIovOEGFKVqNWPT3
        zqWsOWc186CfCvFHlKS1DYhGs7wY4jxxLkm9niMxZS7ImguCFZ/PbbbJgMIhEFYipT7+Z3
        7wyOs3tZnMGnkLFTJnNk5e4o4vJOqPU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-308-UDWKSn34O86X-WCGqCa-1g-1; Mon, 28 Nov 2022 02:26:45 -0500
X-MC-Unique: UDWKSn34O86X-WCGqCa-1g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5DDF929AA3B5;
        Mon, 28 Nov 2022 07:26:44 +0000 (UTC)
Received: from ovpn-192-85.brq.redhat.com (ovpn-192-85.brq.redhat.com [10.40.192.85])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 620EC1415100;
        Mon, 28 Nov 2022 07:26:41 +0000 (UTC)
From:   Viktor Malik <vmalik@redhat.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Viktor Malik <vmalik@redhat.com>
Subject: [PATCH bpf-next 1/2] bpf: Fix attaching fentry/fexit/fmod_ret/lsm to modules
Date:   Mon, 28 Nov 2022 08:26:29 +0100
Message-Id: <2ec861621e283ba2a54f7e939eafed1c29f77bf4.1669216157.git.vmalik@redhat.com>
In-Reply-To: <cover.1669216157.git.vmalik@redhat.com>
References: <cover.1669216157.git.vmalik@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
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
 kernel/bpf/verifier.c | 9 ++++++++-
 3 files changed, 14 insertions(+), 1 deletion(-)

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
index 1a59cc7ad730..211fcbb7649d 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7192,6 +7192,11 @@ bool btf_is_module(const struct btf *btf)
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
index 9528a066cfa5..acbe62a73559 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16343,7 +16343,14 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 			else
 				addr = (long) tgt_prog->aux->func[subprog]->bpf_func;
 		} else {
-			addr = kallsyms_lookup_name(tname);
+			if (btf_is_module(btf)) {
+				char tmodname[MODULE_NAME_LEN + KSYM_NAME_LEN + 1];
+				snprintf(tmodname, sizeof(tmodname), "%s:%s",
+					 btf_module_name(btf), tname);
+				addr = module_kallsyms_lookup_name(tmodname);
+			}
+			else
+				addr = kallsyms_lookup_name(tname);
 			if (!addr) {
 				bpf_log(log,
 					"The address of function %s cannot be found\n",
-- 
2.38.1

