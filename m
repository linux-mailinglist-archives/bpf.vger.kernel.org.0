Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8606527F4
	for <lists+bpf@lfdr.de>; Tue, 20 Dec 2022 21:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234150AbiLTUjM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Dec 2022 15:39:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234004AbiLTUjL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Dec 2022 15:39:11 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B485BF76;
        Tue, 20 Dec 2022 12:39:10 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id r11so11582348oie.13;
        Tue, 20 Dec 2022 12:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=azNFe5jU1dMrsdXR71DYBx3y6Kfnd/1t+DGsjCCu4wc=;
        b=hAhGjIgzRay1apHu4prCOFQ3c6NxKdAB0LtX/NnTYrPZRnur2CUXDOuuZvoMTpeFLg
         D0HFFF3sQIm1TFHIEdgppK/hU3Y7xzwZHiBGTQDqCoMqnR+qWUVjqTa1s2EOPz7IQASH
         EXqI5TaulBTU89PARaJXMutfi5D1wqyQMK2WaDyU5ECTQjORHviv9PfKOd9+9riC6KgZ
         xO6BW9l+lMloV4zQDK6y3zkFj1/uKvAh6x2LBHpDJ78K0y/EZNdKaC2bsSvXrmXXkp97
         v0CyYT530McOocz5TxdxOLwlyehTPhAF4nnuws+KaVp/FuQlv5gpuZC8qOr2PhUKTiz1
         Nrzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=azNFe5jU1dMrsdXR71DYBx3y6Kfnd/1t+DGsjCCu4wc=;
        b=YeF3ST0C43vV0euyroKURWwchZvfsfo35FGHHIB0Al7bKHdmUxg/GAWDKCbq1Nnc6l
         rMC+i7df3dl5QvD+TUGWI0sW9N6k8QM7HqHcNktuGYIMrGLyRZyLvijc2jQUh+O3tYc3
         SJs1tjyFpOQrR1hGrYVAEsNw16fXcdSWuuoyknfQQ7h7TtvRFi0u9OtuPGaRqg0yXqvc
         MDuoaxbrYYn5VYhzMpZqmkeXQF/OhrDKFaZZKbFc2NS1rVVm90O1a1bwu6Pvn5m4BQVR
         ashqV7xsHxqopsDwbzStXQy8d/MUSedIaG8hzoiN1gpLfKm37irXUXu/aJGiph6d+j+/
         CxmA==
X-Gm-Message-State: AFqh2krTvFY79CzkcR/WFqkogvrKdHw2+gwnyuhzNxElBVf/I814GkfI
        k1Yw3STRBrf7YUpFxU6Cgx28cxPJmzc=
X-Google-Smtp-Source: AMrXdXvpgbo6jqWEEADkdNP4FXkTZgkcRr6MOkU69VfIfJr6/O3zUBnaUCKwwim6Ffzr7bEMEHgIfw==
X-Received: by 2002:a05:6808:3d9:b0:35b:ae91:db53 with SMTP id o25-20020a05680803d900b0035bae91db53mr6198909oie.42.1671568749518;
        Tue, 20 Dec 2022 12:39:09 -0800 (PST)
Received: from tx3000mach.io (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id bl14-20020a056808308e00b0035e7d07bf9dsm5965183oib.16.2022.12.20.12.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 12:39:09 -0800 (PST)
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     bpf@vger.kernel.org, rust-for-linux@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Yonghong Song <yhs@fb.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Eric Curtin <ecurtin@redhat.com>, Neal Gompa <neal@gompa.dev>
Subject: [PATCH bpf] scripts: Exclude Rust CUs with pahole
Date:   Tue, 20 Dec 2022 17:39:01 -0300
Message-Id: <20221220203901.1333304-1-yakoyoku@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Version 1.24 of pahole has the capability to exclude compilation units
(CUs) of specific languages. Rust, as of writing, is not currently
supported by pahole and if it's used with a build that has BTF debugging
enabled it results in malformed kernel and module binaries (see
Rust-for-Linux/linux#735). So it's better for pahole to exclude Rust
CUs until support for it arrives.

Reviewed-by: Eric Curtin <ecurtin@redhat.com>
Tested-by: Eric Curtin <ecurtin@redhat.com>
Reviewed-by: Neal Gompa <neal@gompa.dev>
Tested-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
---
 init/Kconfig            | 2 +-
 lib/Kconfig.debug       | 9 +++++++++
 scripts/pahole-flags.sh | 8 ++++++++
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/init/Kconfig b/init/Kconfig
index 694f7c160c9c..360aef8d7292 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1913,7 +1913,7 @@ config RUST
 	depends on !MODVERSIONS
 	depends on !GCC_PLUGINS
 	depends on !RANDSTRUCT
-	depends on !DEBUG_INFO_BTF
+	depends on !DEBUG_INFO_BTF || PAHOLE_HAS_LANG_EXCLUDE
 	select CONSTRUCTORS
 	help
 	  Enables Rust support in the kernel.
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index ea4c903c9868..d473d491e709 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -364,6 +364,15 @@ config PAHOLE_HAS_BTF_TAG
 	  btf_decl_tag) or not. Currently only clang compiler implements
 	  these attributes, so make the config depend on CC_IS_CLANG.
 
+config PAHOLE_HAS_LANG_EXCLUDE
+	def_bool PAHOLE_VERSION >= 124
+	help
+	  Support for the --lang_exclude flag which makes pahole exclude
+	  compilation units from the supplied language. Used in Kbuild to
+	  omit Rust CUs which are not supported in version 1.24 of pahole,
+	  otherwise it would emit malformed kernel and module binaries when
+	  using DEBUG_INFO_BTF_MODULES.
+
 config DEBUG_INFO_BTF_MODULES
 	def_bool y
 	depends on DEBUG_INFO_BTF && MODULES && PAHOLE_HAS_SPLIT_BTF
diff --git a/scripts/pahole-flags.sh b/scripts/pahole-flags.sh
index 0d99ef17e4a5..1071d2cd9b28 100755
--- a/scripts/pahole-flags.sh
+++ b/scripts/pahole-flags.sh
@@ -9,6 +9,10 @@ fi
 
 pahole_ver=$($(dirname $0)/pahole-version.sh ${PAHOLE})
 
+is_enabled() {
+	grep -q "^$1=y" include/config/auto.conf
+}
+
 if [ "${pahole_ver}" -ge "118" ] && [ "${pahole_ver}" -le "121" ]; then
 	# pahole 1.18 through 1.21 can't handle zero-sized per-CPU vars
 	extra_paholeopt="${extra_paholeopt} --skip_encoding_btf_vars"
@@ -19,5 +23,9 @@ fi
 if [ "${pahole_ver}" -ge "122" ]; then
 	extra_paholeopt="${extra_paholeopt} -j"
 fi
+if is_enabled CONFIG_RUST; then
+	# see PAHOLE_HAS_LANG_EXCLUDE
+	extra_paholeopt="${extra_paholeopt} --lang_exclude=rust"
+fi
 
 echo ${extra_paholeopt}
-- 
2.39.0

