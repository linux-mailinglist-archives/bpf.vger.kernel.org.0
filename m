Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89990665EFB
	for <lists+bpf@lfdr.de>; Wed, 11 Jan 2023 16:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236052AbjAKPVN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Jan 2023 10:21:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234134AbjAKPVB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Jan 2023 10:21:01 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DAD6616C;
        Wed, 11 Jan 2023 07:20:58 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id s66so12334809oib.7;
        Wed, 11 Jan 2023 07:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g1A7OF7t8dKNesifezT09S2y+QN0WpHYXu4atrcvTTM=;
        b=CMGbORzNMzYcom0X3Jn8dk/2VBwgk6V6YDK27MHBeUikK0WZs/AIIE4/ICH0+UFOID
         AP8p//rzuK4xzUZdZiGGSqiaNhMwJs8FHkjJtAyROh+FjPd2Fexczd3gR/cMa3raCyZA
         U4GsJDy30MVwZKYuQU8iyfq7rLWjLFLq9Ykzpvgk78xxFyiGVk2I/IBmVo2x9DebVoz6
         frnm3WTl7mLvGVLqWOXXtCjNV0jVGfIPj/xcuANAlXmq6Ix5wBlVkLa3htkK0OqEByS1
         TOLrevJ9Xam4/dNk/pCHNowLdNOVZEQJ0HDlvU3TR77K0lo3CTQ6HjdPPTB6GjESXhi3
         qVWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g1A7OF7t8dKNesifezT09S2y+QN0WpHYXu4atrcvTTM=;
        b=XoSm7lS9aRXBcu1NqmimJZXoZtWSfRYC/OGiCiQIJgurPxVo/NMSvXkQmxV4rXmW54
         Y7K2aCEn5c3euRwQEsMNW8Fecp6XAUiccfykYab5qmf3T65DKlz2hl9OH+Z0vd5AonC2
         +xXcMc4/kPFqDFzL8OM5727ZH8BqFfu+IZHAZir/NSxPMpXevDToKAEr0W1aBzzsgS4M
         rHJjNBvIOR2E/LXrQ2KudgqkCX3VxzEbHi7V7SvDK/BFw1vI6tX1jf6lWV+AkRTg+bHN
         721mATirvW01b9bcBnVK0/oe6yauUyssOefdq992pHprpS/YOHGgOkxv9huLsFtTxt1C
         VvSQ==
X-Gm-Message-State: AFqh2ko60qk33NZtWHk9eixeFTJQKrVict6s396gaB45SubduMlxMfmg
        skcn4vkYLyQPyR7Cn2PPexvr76AchyXKLg==
X-Google-Smtp-Source: AMrXdXsAIIoU2MBKLqNK+eH3to2M9xZjHfh/6lzyKP5PIB+/sO2dlnBtErRVfOgjk5pNEQQ14UzW3w==
X-Received: by 2002:a05:6808:18aa:b0:35e:1a0f:7dea with SMTP id bi42-20020a05680818aa00b0035e1a0f7deamr42754619oib.12.1673450457030;
        Wed, 11 Jan 2023 07:20:57 -0800 (PST)
Received: from tx3000mach.io (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id h10-20020a9d554a000000b0066e968701f8sm7834109oti.27.2023.01.11.07.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 07:20:56 -0800 (PST)
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Neal Gompa <neal@gompa.dev>, Eric Curtin <ecurtin@redhat.com>,
        bpf@vger.kernel.org, rust-for-linux@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Yonghong Song <yhs@fb.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: [PATCH v3] scripts: Exclude Rust CUs with pahole
Date:   Wed, 11 Jan 2023 12:20:50 -0300
Message-Id: <20230111152050.559334-1-yakoyoku@gmail.com>
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
(CUs) of specific languages [1] [2]. Rust, as of writing, is not
currently supported by pahole and if it's used with a build that has
BTF debugging enabled it results in malformed kernel and module
binaries [3]. So it's better for pahole to exclude Rust CUs until
support for it arrives.

Link: https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?id=49358dfe2aaae4e90b072332c3e324019826783f [1]
Link: https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?id=8ee363790b7437283c53090a85a9fec2f0b0fbc4 [2]
Link: https://github.com/Rust-for-Linux/linux/issues/735 [3]

Co-developed-by: Eric Curtin <ecurtin@redhat.com>
Signed-off-by: Eric Curtin <ecurtin@redhat.com>
Signed-off-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
---
V2 -> V3: Enable pahole option upon comparing with version 1.24
V1 -> V2: Removed dependency on auto.conf

 init/Kconfig            | 2 +-
 lib/Kconfig.debug       | 9 +++++++++
 scripts/pahole-flags.sh | 4 ++++
 3 files changed, 14 insertions(+), 1 deletion(-)

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
index 0d99ef17e4a5..1f1f1d397c39 100755
--- a/scripts/pahole-flags.sh
+++ b/scripts/pahole-flags.sh
@@ -19,5 +19,9 @@ fi
 if [ "${pahole_ver}" -ge "122" ]; then
 	extra_paholeopt="${extra_paholeopt} -j"
 fi
+if [ "${pahole_ver}" -ge "124" ]; then
+	# see PAHOLE_HAS_LANG_EXCLUDE
+	extra_paholeopt="${extra_paholeopt} --lang_exclude=rust"
+fi
 
 echo ${extra_paholeopt}
-- 
2.39.0

