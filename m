Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B01626D7D96
	for <lists+bpf@lfdr.de>; Wed,  5 Apr 2023 15:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237944AbjDENVl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Apr 2023 09:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238215AbjDENVj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Apr 2023 09:21:39 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C989926B8
        for <bpf@vger.kernel.org>; Wed,  5 Apr 2023 06:21:25 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id v14-20020a05600c470e00b003f06520825fso1071745wmo.0
        for <bpf@vger.kernel.org>; Wed, 05 Apr 2023 06:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1680700884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OzTnYTzHXCMtnD4fBRvpMdVZR/0u4+xwq2ZcAsfEd4Q=;
        b=YqRe9t40x9LMUeIwhC7rLF2ubu1tfu2uHWidiHIn4WGf3uFePP0AbI/hfcpyDx8nWT
         PMGh2ePXaEkTNxTVfm/rWWohPP+YdVbe12bO3hMmA7UzjZdrfBu9++kNXrMgLLpmZ04t
         +gsIScjttRzg+2Bir2eJ3uwpWAtM4sJym3Ip7mIBUujKQ9EiC/mW0OD4WVMtHLqkhPJE
         I4jzu2UYdoTiE5hXmmOjAJ4+ff73RdieF2bh/1OHgCHlhlJT6Jjzr1de3OZknzveMgm0
         n6GxZv4CdxZzn1D4xmInblUu8jLPuZ8BB8PfA5JRE5PY45cF01QvC0e51MSdsqL7kkXa
         ARzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680700884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OzTnYTzHXCMtnD4fBRvpMdVZR/0u4+xwq2ZcAsfEd4Q=;
        b=E/MoLI+bqxhNIUGRzSu+PCfHyGWNBnlA8+bpCwBKsEenNXHSm7j34WUb649R3Y0/wg
         74BWKbd7Zpiw4l/uc5UPwjD5XKZ2CbMPn3Qb4MgLXv7EP9yeU5rSAToAvEFo7H9jKxJc
         NLoA8gj0Xr0kUaPW41KvbE8mLX/bIIsB7nGYHw2gBgaFu/ImeXcJowM37WVlpIrjmqym
         h6pzjTx4MpgyjcOFPTWDC5Lnw/Qm9laEH/cu4nmZiynUUMTW0kV2mbr/FgqsnJoeVRw5
         VC2E9LyHMx2yAR3Jrjd6w0/3nGavfedKFxZKsZvPPNP/1MNtuuQb+MUaZ61mscyKuhn8
         9gYg==
X-Gm-Message-State: AAQBX9ciPVpenHvYWfiywnJijypIUoWd6SeoZWfkmMQgme94861nn8v8
        6eRw2GulqigjF4RZQVSFwhQXHg==
X-Google-Smtp-Source: AKy350atBpdQ+uY6z/dKh9wDwWdKcoCK8ww1Ae7PCOIyRffKayoqNJOh7SkyhyrV9DsBwYao2Py64A==
X-Received: by 2002:a1c:7309:0:b0:3ed:ec34:f1 with SMTP id d9-20020a1c7309000000b003edec3400f1mr4588576wmb.35.1680700884425;
        Wed, 05 Apr 2023 06:21:24 -0700 (PDT)
Received: from harfang.fritz.box ([2a02:8011:e80c:0:8147:b5f5:f4cc:b39b])
        by smtp.gmail.com with ESMTPSA id c22-20020a05600c0ad600b003ed243222adsm2147306wmr.42.2023.04.05.06.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 06:21:24 -0700 (PDT)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, Eduard Zingerman <eddyz87@gmail.com>,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next v3 1/7] bpftool: Fix documentation about line info display for prog dumps
Date:   Wed,  5 Apr 2023 14:21:14 +0100
Message-Id: <20230405132120.59886-2-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230405132120.59886-1-quentin@isovalent.com>
References: <20230405132120.59886-1-quentin@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The documentation states that when line_info is available when dumping a
program, the source line will be displayed "by default". There is no
notion of "default" here: the line is always displayed if available,
there is no way currently to turn it off.

In the next sentence, the documentation states that if "linum" is used
on the command line, the relevant filename, line, and column will be
displayed "on top of the source line". This is incorrect, as they are
currently displayed on the right side of the source line (or on top of
the eBPF instruction, not the source).

This commit fixes the documentation to address these points.

Signed-off-by: Quentin Monnet <quentin@isovalent.com>
---
 tools/bpf/bpftool/Documentation/bpftool-prog.rst | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-prog.rst b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
index 14de72544995..06d1e4314406 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-prog.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
@@ -106,9 +106,8 @@ DESCRIPTION
 		  CFG in DOT format, on standard output.
 
 		  If the programs have line_info available, the source line will
-		  be displayed by default.  If **linum** is specified,
-		  the filename, line number and line column will also be
-		  displayed on top of the source line.
+		  be displayed.  If **linum** is specified, the filename, line
+		  number and line column will also be displayed.
 
 	**bpftool prog dump jited**  *PROG* [{ **file** *FILE* | **opcodes** | **linum** }]
 		  Dump jited image (host machine code) of the program.
@@ -120,9 +119,8 @@ DESCRIPTION
 		  **opcodes** controls if raw opcodes will be printed.
 
 		  If the prog has line_info available, the source line will
-		  be displayed by default.  If **linum** is specified,
-		  the filename, line number and line column will also be
-		  displayed on top of the source line.
+		  be displayed.  If **linum** is specified, the filename, line
+		  number and line column will also be displayed.
 
 	**bpftool prog pin** *PROG* *FILE*
 		  Pin program *PROG* as *FILE*.
-- 
2.34.1

