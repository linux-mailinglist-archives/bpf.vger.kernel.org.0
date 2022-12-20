Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 334466527FC
	for <lists+bpf@lfdr.de>; Tue, 20 Dec 2022 21:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234266AbiLTUj1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Dec 2022 15:39:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234273AbiLTUjX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Dec 2022 15:39:23 -0500
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61FB818695;
        Tue, 20 Dec 2022 12:39:21 -0800 (PST)
Received: by mail-oo1-xc30.google.com with SMTP id e12-20020a4ab98c000000b004a081e811beso2095181oop.2;
        Tue, 20 Dec 2022 12:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=azNFe5jU1dMrsdXR71DYBx3y6Kfnd/1t+DGsjCCu4wc=;
        b=hXY+HEF7dvemF+QWV9hnbVBwIDLBUPRBQz1HfIFoFKSJTD4TOIX9uMAEz44PV00fLJ
         qQFXcsQadCp6vJb55Td7Wnp0gEgqmXDWT9hVCjCl6xUUQkbrlH8h7P/zdSlOwJegWgqy
         XuVnETZDavc4yF/kn9ccDYwE4PpEkttD6CSD3iwdgx63sibf0CDrEJ0JiuxR41njHuIY
         ASEBYgejlWZuQfwLakLhIJ2gfJyl9u0fZlT6A/lEG0iiNtotPTmUDE2GPDFsS7VDQY3S
         9NQb9LcnzBgkQ3H8xI08Uz3kAjrWvLwQSqXAfy6nDtUwgZzghP5rVhevC0umBrooVDB9
         XK6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=azNFe5jU1dMrsdXR71DYBx3y6Kfnd/1t+DGsjCCu4wc=;
        b=xKicvnXNQ1X6n10/lNYU6aXgz/5etC+AD51xYOCyoooMAEzkwlDC3SPhVQaNvrVf/t
         njAQJ1GlL5K33yMYxYWqFDNL1Hy+2r7YAkhmzYTeyOdOOAUdrE7yYJ+yFHrEYVp0M/dh
         C1V/LHAlTWnf3s1LuU137RIBesfL0GpW8jpzEmvxArZa6seDOaTo25OgIto8kmjRseZX
         uOIEH8pigZV7NBxSYLD9V46Ovv/ymmNz6mJLgjSbddCF65cJqq1ho7Fe3caPDwAyGbEw
         /d9AlpsVJ1gz2mc6Hv1BZM3N0a8Z6tvN9GbJaAQWwCdzwmH+oCodB7SmR82fpLyJ5Mcb
         PY7A==
X-Gm-Message-State: ANoB5pnoBcOJaWYJQL7a0OK6Mp5yUCyfU+9IrtLEuOequIQP3lMqlXOH
        QwL5yapCD60HsQtjIXr8RjOVhf3LPTWrSA==
X-Google-Smtp-Source: AA0mqf5Z5q9oJWUtYllftjv0rAybh6GQEuV1X7jfUWoSrt7AJ3lOk4GXWUQ/Dwh28ObQWBEguL5nAw==
X-Received: by 2002:a4a:2c97:0:b0:4a3:6dd1:3f34 with SMTP id o145-20020a4a2c97000000b004a36dd13f34mr21644921ooo.5.1671568760393;
        Tue, 20 Dec 2022 12:39:20 -0800 (PST)
Received: from tx3000mach.io (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id a11-20020a4ab10b000000b0049fb39100a5sm5380714ooo.37.2022.12.20.12.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 12:39:19 -0800 (PST)
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
Date:   Tue, 20 Dec 2022 17:39:15 -0300
Message-Id: <20221220203915.1333444-1-yakoyoku@gmail.com>
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

