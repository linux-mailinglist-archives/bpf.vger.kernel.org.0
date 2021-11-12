Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 066D844E00E
	for <lists+bpf@lfdr.de>; Fri, 12 Nov 2021 02:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbhKLCC2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Nov 2021 21:02:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbhKLCC2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Nov 2021 21:02:28 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53516C061766
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 17:59:38 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id r5so837540pgi.6
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 17:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+KcXGClM0aCpbQRU+vR/odFZJexM++iz9VeCV3vVOVg=;
        b=U6weuC4L6rWUB7knMLCOhFQ/XrUiG03/u13y9Bod5Gd9WLhgrfmFLjqMSdlt9lk86B
         hy+Ug8S4OsvBpp83vlgyfTnCBhlmnGpUajDYUqTZGIPht3kRIF8tPOGJA09YCYyRclim
         OArRsY/d+T/aRGC65lZSeFNiuoErzlCix5/o/XxuOeT7CP4rOahOKA951u80PtVrHHmk
         111smD8ARzHBu99fJCkt3MADEV0jdLj9J+aiKm8k9ohTEHKFHVtaSXQjXcVL2VcigayC
         AEXFnMStA9H9Pi2W3piOZqvpITdwHtgDmdQVE5T156+Wy7amhFSk3noF0GY5aAKzENBd
         QQEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+KcXGClM0aCpbQRU+vR/odFZJexM++iz9VeCV3vVOVg=;
        b=qYpJhTakBkuV3i5DI1VaZRp8HkZG0Sl3apVfEve8ErriIqTvxs4u+bHGULL6BG7aqZ
         RUZyVzPP93CYaWAyjpn4x/vtl6+iqU0TfRbF4Q2BjBYr5M7m5pgJ9hk3+HYghM/b7YxT
         SCc/vaqyjfqp3xjqS6zGMfXmrk/H9XpxIUBsWydpz2oAb1eOAiv5rrJl58TuMwmKeYNb
         TXv8Z2NkgMEcAteyxYHbFn8Hsm6v9hBAT3xSNoFUTlfIurOXHTAgQPwezTuAIHSLSWOJ
         BNUEEXDBKQ8BzQmOBmlIqPjoO6tjRLRKsdc+cyvInLOljVlVuNFwKlI+E6WUPYf69DWo
         hmIA==
X-Gm-Message-State: AOAM530JUsSbsbbZUYXJgbGuUfGmGpPVtIJAUVkAXVL4q9uSRJ3qR05a
        DjVWDcPKAeR0WyCdiDLnrW40eq3H+pkW6w==
X-Google-Smtp-Source: ABdhPJwqdKxEWuYSCaBceGEQWijcHM8UIAk6f7nXri2NSmNVyYRhdCIyujZyWPDXaK5filwQp77L8Q==
X-Received: by 2002:aa7:8611:0:b0:49f:a5b3:14b4 with SMTP id p17-20020aa78611000000b0049fa5b314b4mr10951085pfn.30.1636682377615;
        Thu, 11 Nov 2021 17:59:37 -0800 (PST)
Received: from localhost ([2405:201:6014:d064:3d4e:6265:800c:dc84])
        by smtp.gmail.com with ESMTPSA id n16sm4083154pfj.47.2021.11.11.17.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 17:59:37 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>
Subject: [PATCH bpf] bpf: Make CONFIG_DEBUG_INFO_BTF depend upon CONFIG_BPF_SYSCALL
Date:   Fri, 12 Nov 2021 07:29:34 +0530
Message-Id: <20211112015934.527181-1-memxor@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Vinicius Costa Gomes reported [0] that build fails when
CONFIG_DEBUG_INFO_BTF is enabled and CONFIG_BPF_SYSCALL is disabled.
This leads to btf.c not being compiled, and then no symbol being present
in vmlinux for the declarations in btf.h. Since BTF is not useful
without enabling BPF subsystem, disallow this combination.

However, theoretically disabling both now could still fail, as the
symbol for kfunc_btf_id_list variables is not available. This isn't a
problem as the compiler usually optimizes the whole register/unregister
call, but at lower optimization levels it can fail the build in linking
stage.

Fix that by adding dummy variables so that modules taking address of
them still work, but the whole thing is a noop.

  [0]: https://lore.kernel.org/bpf/20211110205418.332403-1-vinicius.gomes@intel.com

Fixes: 14f267d95fe4 ("bpf: btf: Introduce helpers for dynamic BTF set registration")
Reported-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/btf.h | 10 +++++++---
 lib/Kconfig.debug   |  1 +
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 203eef993d76..db935b9a0074 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -254,6 +254,9 @@ void unregister_kfunc_btf_id_set(struct kfunc_btf_id_list *l,
 				 struct kfunc_btf_id_set *s);
 bool bpf_check_mod_kfunc_call(struct kfunc_btf_id_list *klist, u32 kfunc_id,
 			      struct module *owner);
+
+extern struct kfunc_btf_id_list bpf_tcp_ca_kfunc_list;
+extern struct kfunc_btf_id_list prog_test_kfunc_list;
 #else
 static inline void register_kfunc_btf_id_set(struct kfunc_btf_id_list *l,
 					     struct kfunc_btf_id_set *s)
@@ -268,13 +271,14 @@ static inline bool bpf_check_mod_kfunc_call(struct kfunc_btf_id_list *klist,
 {
 	return false;
 }
+
+struct kfunc_btf_id_list {};
+static struct kfunc_btf_id_list bpf_tcp_ca_kfunc_list __maybe_unused;
+static struct kfunc_btf_id_list prog_test_kfunc_list __maybe_unused;
 #endif
 
 #define DEFINE_KFUNC_BTF_ID_SET(set, name)                                     \
 	struct kfunc_btf_id_set name = { LIST_HEAD_INIT(name.list), (set),     \
 					 THIS_MODULE }
 
-extern struct kfunc_btf_id_list bpf_tcp_ca_kfunc_list;
-extern struct kfunc_btf_id_list prog_test_kfunc_list;
-
 #endif
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 6fdbf9613aec..eae860c86e26 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -316,6 +316,7 @@ config DEBUG_INFO_BTF
 	bool "Generate BTF typeinfo"
 	depends on !DEBUG_INFO_SPLIT && !DEBUG_INFO_REDUCED
 	depends on !GCC_PLUGIN_RANDSTRUCT || COMPILE_TEST
+	depends on BPF_SYSCALL
 	help
 	  Generate deduplicated BTF type information from DWARF debug info.
 	  Turning this on expects presence of pahole tool, which will convert
-- 
2.33.1

