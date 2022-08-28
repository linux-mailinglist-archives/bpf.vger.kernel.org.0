Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E61A5A3EA3
	for <lists+bpf@lfdr.de>; Sun, 28 Aug 2022 18:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiH1QvN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 28 Aug 2022 12:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiH1QvM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 28 Aug 2022 12:51:12 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D411FCF8
        for <bpf@vger.kernel.org>; Sun, 28 Aug 2022 09:51:11 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id t11-20020a05683014cb00b0063734a2a786so4438739otq.11
        for <bpf@vger.kernel.org>; Sun, 28 Aug 2022 09:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=d1EStKx3f7VIZVZMTt/Wew/LD0EruE184U6/TOKO2Gc=;
        b=W4v/B4qEJUDkiqk2jJRTfarBCGKM2Ho6Nt16XhFoi2ku/3DfdgLLkTirdtZoszoYqc
         2aXPLrth75OPS5IF5uwZlMEZpCEDrOeNbUuTKk9uaPbNmU5r8/UIqJQltGA5qOiKYXUJ
         cD61o6OCnNzEokdOP2OQMtwHdlO0wVV023TVnjENZAVVFKxM4eQrTYSs3nwzIGgdUo3w
         hbkLnRMGToqezn6L2DasLjU2Y/eLLMYO+DndtlxvaeRlqiPxSXujhBFZ6lZUGVWr756/
         ewp5ZMU3+VqwlheSo2WMZa/tuFOxtB5V+cmgxP7BHhz9H0aMzX8bcqh+iWYU1mEjUOUW
         jesQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=d1EStKx3f7VIZVZMTt/Wew/LD0EruE184U6/TOKO2Gc=;
        b=WaKGDKuOsLL6ltHLeHm0uWh3T+X+DHbVVhfzb2xIXpnMpowioBv4FLmqssqAYrX8Rb
         GIPfwmC6VY1patr60h98JGoJ38Of24gmQtjb8Vln3SLoKRignXmm5OjqwMCCKbg1uIcz
         RkSVFuXjV8wflYwFFCioCPVsbV21/JFFHhuzUzMuI7murqcCnQRUUig0NjZlZ3dm/p7N
         suoG1Bv5oNsuC5OmBuB64u+asS1JEWC5Y2cGLnmgkF0K0eLp7Q1hS1O4dUh5fsU5Nepr
         IT53Zuao7dO/K+gC0vj6sV0/YGrdVkKpy7WwEu0v0pQqym7pnEJp4xXg3ENzHhF4Vw+/
         Feqg==
X-Gm-Message-State: ACgBeo1IJeRaWsL5VX+vYGPDujg6uQfjtjhitSUztj2hMwI2XORBoyHT
        NnXicH7zAQWvFezBKJT1jGzn8XKEFvU=
X-Google-Smtp-Source: AA6agR5KFlhdmWtwZLNZfNRgOATvFBT7eQFSIpTAr5WNgNSyUGACsggalWjsu46HufANCbME2HWQAQ==
X-Received: by 2002:a05:6830:3706:b0:61c:5d4c:7a26 with SMTP id bl6-20020a056830370600b0061c5d4c7a26mr4824561otb.250.1661705470276;
        Sun, 28 Aug 2022 09:51:10 -0700 (PDT)
Received: from tx3000mach.io (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id d3-20020a9d4f03000000b0063695ad0cbesm4089868otl.66.2022.08.28.09.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Aug 2022 09:51:09 -0700 (PDT)
From:   Martin Reboredo <yakoyoku@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Yonghong Song <yhs@fb.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Subject: [PATCH bpf-next] bpf: Add config for skipping BTF enum64s
Date:   Sun, 28 Aug 2022 13:51:24 -0300
Message-Id: <20220828165124.20261-1-yakoyoku@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Martin Rodriguez Reboredo <yakoyoku@gmail.com>

After the release of pahole 1.24 some people in the dwarves mailing list
notified issues related to building the kernel with the BTF_DEBUG_INFO
option toggled. They seem to be happenning due to the kernel and
resolve_btfids interpreting btf types erroneously. In the dwarves list
I've proposed a change to the scripts that I've written while testing
the Rust kernel, it simply passes the --skip_encoding_btf_enum64 to
pahole if it has version 1.24, but it might be desirable to have the
option to pass said flag.

Signed-off-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
---
 lib/Kconfig.debug       | 14 ++++++++++++++
 scripts/pahole-flags.sh |  7 +++++++
 2 files changed, 21 insertions(+)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 072e4b289c13..638a33cf9e57 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -356,6 +356,20 @@ config PAHOLE_HAS_BTF_TAG
 	  btf_decl_tag) or not. Currently only clang compiler implements
 	  these attributes, so make the config depend on CC_IS_CLANG.
 
+config PAHOLE_HAS_SKIP_ENCODING_BTF_ENUM64
+	def_bool PAHOLE_VERSION >= 124
+	help
+	  Encoding BTF enum64s can be skipped with the
+	  --skip_encoding_btf_enum64 pahole option.
+
+config DEBUG_INFO_BTF_SKIP_ENCODING_ENUM64
+	def_bool n
+	depends on DEBUG_INFO_BTF && PAHOLE_HAS_SKIP_ENCODING_BTF_ENUM64
+	help
+	  Omit the encoding of 64 bits enum values with pahole. With certain
+	  kernel configurations having ENUM64s enabled may result in malformed
+	  output binaries.
+
 config DEBUG_INFO_BTF_MODULES
 	def_bool y
 	depends on DEBUG_INFO_BTF && MODULES && PAHOLE_HAS_SPLIT_BTF
diff --git a/scripts/pahole-flags.sh b/scripts/pahole-flags.sh
index 0d99ef17e4a5..e44bc2a947ce 100755
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
@@ -19,5 +23,8 @@ fi
 if [ "${pahole_ver}" -ge "122" ]; then
 	extra_paholeopt="${extra_paholeopt} -j"
 fi
+if is_enabled DEBUG_INFO_BTF_SKIP_ENCODING_ENUM64; then
+	extra_paholeopt="${extra_paholeopt} --skip_encoding_btf_enum64"
+fi
 
 echo ${extra_paholeopt}
-- 
2.37.2

