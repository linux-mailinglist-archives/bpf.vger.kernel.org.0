Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC516C88F2
	for <lists+bpf@lfdr.de>; Sat, 25 Mar 2023 00:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjCXXC1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Mar 2023 19:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjCXXC1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Mar 2023 19:02:27 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41D91DB88
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 16:02:25 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id q19so162566wrc.5
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 16:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1679698944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OzTnYTzHXCMtnD4fBRvpMdVZR/0u4+xwq2ZcAsfEd4Q=;
        b=MZV/+7t4zmPzqsU5ALkyzyVjWIWrGgN2iKVnFcGOLdK99GvoygF+qanR5hJ04DJHMA
         SIPaBukfnEddXrm6A5A1efwWs76ATSo0g4fic7hObNMMSwy6+X80CaMGncJ9luaBJkau
         tCfA1WLD0IfSNQAP7OIzQXxiWBkvmjlUjD9iw38Vt3Wr13IW7QWHo/aUMYL7m2DiB2Rc
         NibnthbX4OFN97mU+i4A/+fl39tGxhhj5Aj+g8YYoZKpmxAtpD25i2tkKEaTah2AR/Pg
         pURl1XjqM4YQ2XIoG6XMGGfy8PFLj4Obh4KAglTHbRfQ5PH7ZljMgJcGsuctGS6CQRsx
         IwRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679698944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OzTnYTzHXCMtnD4fBRvpMdVZR/0u4+xwq2ZcAsfEd4Q=;
        b=hE48b0MRQqgdm8Np5ZRezbAS0KXAVrGic9qV4c7EQLIMqQzNv865L9tm+yqgJp2Bw0
         7jqXU3Qk3Ju/SYePconQYpcrSDwW7xqO5seIjZbErBmzshPNU460iQBgeVRhhRK4yqv6
         hn+WbJDqJXosRfeRfZEr534Gn+egVU0gec1fq/f9F+DmqBqT7oWO4H9LRPee0nRkIAeQ
         Bm8fsYBeWuEIixI6reeUROjf3S/z/JdBX+RI4nXe7Cu4voTtXdN5fjXTbTJ28xqB/Vkg
         1fKOf71aqQd8SnGzmOqIa/wG8kdIsTI8gzVSl6Uy4g6rzAq53DCFJcrHYr1kBWZff02M
         TkiA==
X-Gm-Message-State: AAQBX9fdxTgHa629Fld+M798AyaNoIh6PGc1wjjT+KPqJaZYNdBWBQzA
        Mb5kuxKXTd2WcTrd7EtXntbjlg==
X-Google-Smtp-Source: AKy350ZckNTc80tn3U9XScbE0VsB8KTOAPK5sVYj0w3VZtdCLXMnioPgKPm2ymJ/e/XAfpDcdZws5g==
X-Received: by 2002:a5d:4ec9:0:b0:2c3:f79a:7319 with SMTP id s9-20020a5d4ec9000000b002c3f79a7319mr2932467wrv.17.1679698944126;
        Fri, 24 Mar 2023 16:02:24 -0700 (PDT)
Received: from harfang.fritz.box ([2a02:8011:e80c:0:c17f:3e3e:3455:90b])
        by smtp.gmail.com with ESMTPSA id c16-20020adffb50000000b002c56179d39esm19340342wrs.44.2023.03.24.16.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 16:02:23 -0700 (PDT)
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
Subject: [PATCH bpf-next 1/5] bpftool: Fix documentation about line info display for prog dumps
Date:   Fri, 24 Mar 2023 23:02:05 +0000
Message-Id: <20230324230209.161008-2-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230324230209.161008-1-quentin@isovalent.com>
References: <20230324230209.161008-1-quentin@isovalent.com>
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

