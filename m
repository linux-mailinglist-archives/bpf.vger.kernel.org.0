Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F37D56612FE
	for <lists+bpf@lfdr.de>; Sun,  8 Jan 2023 03:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbjAHCPC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 7 Jan 2023 21:15:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231551AbjAHCPB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 7 Jan 2023 21:15:01 -0500
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A731215F01;
        Sat,  7 Jan 2023 18:15:00 -0800 (PST)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-14fb7fdb977so5575670fac.12;
        Sat, 07 Jan 2023 18:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TySYhQ0Jtcrqk14K9ELuTQHEFCCUvE5Ry0vMrhn1yNY=;
        b=JziVO8erlR05YSjzCQZt0BCL2ljqtoT13d1EiOPj3llCyuuzbjSXJ7y60dww0xtf5F
         gQqzj9T0z/iX+z5of9StpzewndFGf9XIqaIrDIOWPRBN2AWQgSv/wRC0BrfsLJelyowA
         odUSwyqGGkDxy/Scnm19JB+EapDjJzHjeFPfr8v+/5Jt/YUmg/JnJICbSRLoXtHxbAcV
         uU3PCSG5Ee9AW4mpw9vUUI5zdO+qc1y1dIP0ZlBZOpY1DbCmSt1HAgaEDfQLxJsInJ7D
         KbVhrKA0fF4HopRBbM4a8Lvdv2ytGiNx9rlzurPfQ3WHSJGWG9h5Zi2a04g1BtEh+TTk
         MdCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TySYhQ0Jtcrqk14K9ELuTQHEFCCUvE5Ry0vMrhn1yNY=;
        b=f9N2BknGMSTewWobKq10uEVqhc32s+R2z3qpq0sPWomHhekWDWEqdxH1q3PI8EsuG4
         8AqA4/jJdGw09wL1yl6BEw0BfM58+TJPCKohjRN9+CT081Yc/10dVX9ytIS431D7RL6t
         KCf+vpLzH1x6yl8qhJdKxKcI1Ot6SB/3UdW77nmgzrNT4OSoevUgQXoVFhJgdEOQ2Z1g
         9XEOd3x15xW8hi/R4rqxSHMzIfn1AV8cMBfP7M6KIaeRrdp4g9bk8vUP209mQKfd2ARI
         4K6S97YEkAUWKrDUP399N1vlg/MO0rOEdFd9rZfDuLi3kihyF6N2rb9RnISe/qIMqhot
         390Q==
X-Gm-Message-State: AFqh2kqBrG94okBqAVe3CWxwup0KvEB0H8arLjLwUdEz7D4yv56XClDa
        tcQd+TTupl2f67sU35NZfjELNSJKlnI=
X-Google-Smtp-Source: AMrXdXtvNAu/InEEZMh2ZA3QZA6lOgsvAL9gQeIyyXVpSYtju1tqLGs1k6LfnSyqsvvT9pMVy4No8w==
X-Received: by 2002:a05:6870:8a0a:b0:144:1ba:3c67 with SMTP id p10-20020a0568708a0a00b0014401ba3c67mr33940922oaq.51.1673144099655;
        Sat, 07 Jan 2023 18:14:59 -0800 (PST)
Received: from tx3000mach.io (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id y6-20020a056870418600b00144e18d8525sm2367553oac.25.2023.01.07.18.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jan 2023 18:14:59 -0800 (PST)
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Eric Curtin <ecurtin@redhat.com>, Neal Gompa <neal@gompa.dev>,
        bpf@vger.kernel.org, rust-for-linux@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Yonghong Song <yhs@fb.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: [PATCH v2] scripts: Exclude Rust CUs with pahole
Date:   Sat,  7 Jan 2023 23:14:50 -0300
Message-Id: <20230108021450.120791-1-yakoyoku@gmail.com>
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
V1 -> V2: Removed dependency on auto.conf

 init/Kconfig              | 2 +-
 lib/Kconfig.debug         | 9 +++++++++
 scripts/Makefile.modfinal | 4 ++++
 scripts/link-vmlinux.sh   | 4 ++++
 4 files changed, 18 insertions(+), 1 deletion(-)

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
diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
index 25bedd83644b..a880f2d6918f 100644
--- a/scripts/Makefile.modfinal
+++ b/scripts/Makefile.modfinal
@@ -30,6 +30,10 @@ quiet_cmd_cc_o_c = CC [M]  $@
 
 ARCH_POSTLINK := $(wildcard $(srctree)/arch/$(SRCARCH)/Makefile.postlink)
 
+ifdef CONFIG_RUST
+PAHOLE_FLAGS += --lang_exclude=rust
+endif
+
 quiet_cmd_ld_ko_o = LD [M]  $@
       cmd_ld_ko_o +=							\
 	$(LD) -r $(KBUILD_LDFLAGS)					\
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 918470d768e9..69eb0bea89bf 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -122,6 +122,10 @@ gen_btf()
 		return 1
 	fi
 
+	if is_enabled CONFIG_RUST; then
+		PAHOLE_FLAGS="${PAHOLE_FLAGS} --lang_exclude=rust"
+	fi
+
 	vmlinux_link ${1}
 
 	info "BTF" ${2}
-- 
2.39.0

