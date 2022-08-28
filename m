Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB085A402B
	for <lists+bpf@lfdr.de>; Mon, 29 Aug 2022 01:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbiH1XdF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 28 Aug 2022 19:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiH1XdE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 28 Aug 2022 19:33:04 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D26D2ED6E
        for <bpf@vger.kernel.org>; Sun, 28 Aug 2022 16:33:03 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id h9-20020a9d5549000000b0063727299bb4so4869259oti.9
        for <bpf@vger.kernel.org>; Sun, 28 Aug 2022 16:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=Fm35/CU1uLUtEn3Jw7AMa0n8Ac2txvfggwTGpXk6YTI=;
        b=n+/g75+2yF3XFXskPs2/lVYXEQHMdriMAlCoGErMLagF1Bps2naRuxcZX8FtiV5pN4
         vicnhzue4rcMnFw4mYQr/ZqOlPYmH7p8GI1ZhAp1QDN/qpvSJtrNTPsYucRuhlZuLb1C
         Kh+31jMBHEMkXnQWHZ0ZmDJCvC9NpzGaC8UEprYkifpKjYVgoogDRrq9oD/kkCuOgMLP
         bHSo3dvAA14Hzm+kETKbhiDTp6vXSMWq54/QhyK/ZewcoAPer9UVMu1eoHnYJkMcQvrU
         c4TIJEspRHY+p/hug/B/GuGVokbisbvqkiP/Hnqla0ornqEqJaJJZqMjIczV/8pJ5zTl
         +ObQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=Fm35/CU1uLUtEn3Jw7AMa0n8Ac2txvfggwTGpXk6YTI=;
        b=YhDnwRMCw7K+PDFICdwJ+IzuaEJkq37nioKmoRpHY3UzYbe/KR4W8plNXfmK2Z9pk8
         wCqhUoiu+QKSNkQPhSW/aj5o/1cLNtUmsp4XqpHq6kCRc2ZovaRB3WzaPSXTagBkHkW/
         WWx8v0gE6428SnsPN+DinRHSknGunCKZfpYJxP8Gm5WT0kACfDxHT8rbkR5uhZuvWtrc
         X6I5nxxLycycZeiurSYRZY778A6kyJkXaZF5TmzKDS86jKLAacLuUJcW/rJyaTf/5PKk
         zNyXt/owm1OADEFBJSCN57DI1Yw2bU01dksN/Qjv461X9GL9EqousvpuaLkoI7Sh5cb+
         rEPw==
X-Gm-Message-State: ACgBeo3NX8ChH9xOV6bBV7Ua324FWYeNqlbN9ippJpWfbMEBl7UPxgSt
        OvlU8hr6izOTCT5qQIS6sMauhYYtgeI=
X-Google-Smtp-Source: AA6agR6DU3M7e3N0G632zVrwvpLj7dysu85Im4HxngDUEBwB9S4W+rcWwYQ518IitVKjF6eVAxLymA==
X-Received: by 2002:a9d:76cf:0:b0:639:67ca:439c with SMTP id p15-20020a9d76cf000000b0063967ca439cmr5627055otl.313.1661729582210;
        Sun, 28 Aug 2022 16:33:02 -0700 (PDT)
Received: from tx3000mach.io (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id p14-20020a9d744e000000b00637190319eesm4601514otk.29.2022.08.28.16.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Aug 2022 16:33:01 -0700 (PDT)
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Yonghong Song <yhs@fb.com>
Subject: [PATCH bpf v2] bpf: Add config for skipping BTF enum64s
Date:   Sun, 28 Aug 2022 20:33:17 -0300
Message-Id: <20220828233317.35464-1-yakoyoku@gmail.com>
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

After the release of pahole 1.24 some people in the dwarves mailing list
notified issues related to building the kernel with the BTF_DEBUG_INFO
option toggled. They seem to be happenning due to the kernel and
resolve_btfids interpreting btf types erroneously. In the dwarves list
I've proposed a change to the scripts that I've written while testing
the Rust kernel, it simply passes the --skip_encoding_btf_enum64 to
pahole if it has version 1.24.

v1 -> v2:
- Switch to off by default and remove the config option.
- Send it to stable instead.

Signed-off-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
---
 scripts/pahole-flags.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/pahole-flags.sh b/scripts/pahole-flags.sh
index 0d99ef17e4a5..0a48fd86bc68 100755
--- a/scripts/pahole-flags.sh
+++ b/scripts/pahole-flags.sh
@@ -19,5 +19,8 @@ fi
 if [ "${pahole_ver}" -ge "122" ]; then
 	extra_paholeopt="${extra_paholeopt} -j"
 fi
+if [ "${pahole_ver}" -ge "124" ]; then
+	extra_paholeopt="${extra_paholeopt} --skip_encoding_btf_enum64"
+fi
 
 echo ${extra_paholeopt}
-- 
2.37.2

