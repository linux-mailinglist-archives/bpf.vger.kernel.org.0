Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B966CA21C
	for <lists+bpf@lfdr.de>; Mon, 27 Mar 2023 13:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbjC0LHM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Mar 2023 07:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232289AbjC0LHK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Mar 2023 07:07:10 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6F149E7
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 04:07:02 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id y14so8320301wrq.4
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 04:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1679915221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tdbq4lmxLHPeXEL0ChlDeaLo4kGZUdEE3QdxGLd/gz4=;
        b=KwoHvkNEqu9FCON162UXvg9k1YBDSUO2uZk7lVgJV1QweCLW5XY+g+1yfvNyB9NILg
         IfXWpXIfBoHyLBtVIKP9r8A0yI79+rJNS+7OYhoU7z6yd5UkB4nPQ1ZzKVRp9otVYg0T
         sSKvoAb03/8b7GD7qm1qjbwSFdwrnGg0zSJw+Gfs+MbDuxmEMuN78jiYxF6zfFHfYymA
         lYj8KvK3QWUvUnQgiD23UECNf5S3Nq/Hj9FCOqC6IrSue4qBmIq49VKJz0h8qiLxBvSt
         HkAMDSznBWKvCDMuPBvQfuNFrbtAU+aqm826VnAZa3r+AJJkn26Wi2xawvvnav9H8qcd
         O2bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679915221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tdbq4lmxLHPeXEL0ChlDeaLo4kGZUdEE3QdxGLd/gz4=;
        b=Yi/v/yu1dndjCdB/UA1jxKalC7skPkYv3xJqEal2wG3e9u4w5P29XhhUes2HXZXjYU
         kyiVU/r5ik8dOsCK5JQ5f5H5E/peO3ug/ZWj7J8F9s6hPH9wAHlTHqEeU4Yritu2QMA8
         ZM+FuAmF+2ClmJRkVHe3WGjOr6m8ckz40Js7sXtb/hfOfLL887ltADf8i5adXmhIIAHP
         nSCTeWqy/JvJGaPijKo6Q/9ek1FVuwiS1U3Y3wf/2BFoUS3i+4ucrkYPte1+l8a0bQt2
         purPiCrFp1aDxfDd1cNPsabxXSRauVEMKG/zHT3cu83JmMeox2cdpGT195ljIgvgpv1D
         AFZA==
X-Gm-Message-State: AAQBX9fCdv1TCP6vrtqcDlTwEgCOkvnzf8DrvdeEi/KCuI9FqvdT6NJR
        kN3EUdzEBleBPAYi1+GivamE0Q==
X-Google-Smtp-Source: AKy350aIj1D5H9+aEyITzaD6AtE8o0toVrpnZ+BlrXkLzX80/WGUmBPHavmH6g7WwXN25IxaUNigIg==
X-Received: by 2002:a5d:6dc5:0:b0:2cf:e3d8:5df9 with SMTP id d5-20020a5d6dc5000000b002cfe3d85df9mr8344253wrz.58.1679915220809;
        Mon, 27 Mar 2023 04:07:00 -0700 (PDT)
Received: from harfang.fritz.box ([2a02:8011:e80c:0:61cd:634a:c75b:ba10])
        by smtp.gmail.com with ESMTPSA id k10-20020a5d6e8a000000b002d1daafea30sm24772958wrz.34.2023.03.27.04.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 04:07:00 -0700 (PDT)
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
        bpf@vger.kernel.org, Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next v2 1/5] bpftool: Fix documentation about line info display for prog dumps
Date:   Mon, 27 Mar 2023 12:06:51 +0100
Message-Id: <20230327110655.58363-2-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230327110655.58363-1-quentin@isovalent.com>
References: <20230327110655.58363-1-quentin@isovalent.com>
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
Acked-by: Stanislav Fomichev <sdf@google.com>
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

