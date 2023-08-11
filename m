Return-Path: <bpf+bounces-7542-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0EC2778EF4
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 14:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E14391C21778
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 12:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D28D125C1;
	Fri, 11 Aug 2023 12:16:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD07125B5
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 12:16:56 +0000 (UTC)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982463C32
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 05:16:29 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-687ca37628eso1737975b3a.1
        for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 05:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691756167; x=1692360967;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wn8zm5UyBwuFQEHAFYhoUDQ4v8s58fct6XDVKmyqEDs=;
        b=IG+EEKMu2ASaVleoSGWUTOa4OyJOfCuU1TQMuLODFr7UJTCuFfNaIjuKccDT7l4PS/
         cmfF1C2W9L7XhthnyUXhfIWoreyKIIK8ajKpAS9UhF6UIf3eK9HV6qAum+EIjbNAfdHO
         fupD8ekA3iIanqlnI9O92hSUNcf0qKGDGuVgcuX7z1UzMr00BaarCyor+XJ7ME8JU45C
         U3AHwCy4jIsIvkkqKS18iozUmDsjYUpwvyxNVqKHD7E0pvOeowEVlFrDmbI2fwRCXLlO
         a58+p6AVW3N7I//mKwwv8glTk1NGGC/5qAiXypzyD3FHEh5ybF+s118ace2nnva9B26p
         kqPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691756167; x=1692360967;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wn8zm5UyBwuFQEHAFYhoUDQ4v8s58fct6XDVKmyqEDs=;
        b=bkO512NZ0Pk0ITeoPn28+scs4EcOFbq5H7pe987G9mJnSEQShhAdfEV/kGyh6ykexB
         pW41bjQM7E93DtECodgJdQ6CFoMv2hiJ0yWUMVQw7wTSRsE0XgOsjVVXX+tf7g2KG9cM
         b11agOKwPfJhKq+JtWJbhCKsPVXIaiWKP5conkzYEQrllF4Q8jiO+2XKn41qnPjJymjw
         zuIPEkvFxoxVydF/qQvEYYxX7SgsVkHT4apNAua/z1GF7d43sSRytlarBJ/ZkNVrAzvR
         Q7lkKYFkyhJ7iZePGaE1YUiJEp1mFJDWD3T6GG4riW7sZbE8oimVQaOZpRqeNhQFWOv8
         LRSA==
X-Gm-Message-State: AOJu0Yy0I3LoZlJqkPsjbqBT/TwG4OWHBoyK/ywm6Fu67nOAZGk3rcit
	uK3GGyWaQXcjwbotPeLUUd8IYibwfg==
X-Google-Smtp-Source: AGHT+IHfe6IcnGVkoVB+hnjl18Bby2VrUpXp/7zDVrBjZhPzYc6qGtioerkRptBE16hyqbfPAUCnhg==
X-Received: by 2002:a05:6a00:134c:b0:687:535f:6712 with SMTP id k12-20020a056a00134c00b00687535f6712mr2434644pfu.14.1691756167149;
        Fri, 11 Aug 2023 05:16:07 -0700 (PDT)
Received: from ubuntu2204.localdomain ([182.209.58.11])
        by smtp.gmail.com with ESMTPSA id k17-20020aa792d1000000b006879493aca0sm3197210pfa.26.2023.08.11.05.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 05:16:06 -0700 (PDT)
From: "Daniel T. Lee" <danieltimlee@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org
Subject: [PATCH] bpftool: fix perf help message
Date: Fri, 11 Aug 2023 21:16:03 +0900
Message-Id: <20230811121603.17429-1-danieltimlee@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Currently, bpftool perf subcommand has typo with the help message.

    $ tools/bpf/bpftool/bpftool perf help
    Usage: bpftool perf { show | list }
           bpftool perf help }

Since this bpftool perf subcommand help message has the extra bracket,
this commit fix the typo by removing the extra bracket.

Signed-off-by: Daniel T. Lee <danieltimlee@gmail.com>
---
 tools/bpf/bpftool/perf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/perf.c b/tools/bpf/bpftool/perf.c
index 91743445e4c7..80de2874dabe 100644
--- a/tools/bpf/bpftool/perf.c
+++ b/tools/bpf/bpftool/perf.c
@@ -236,7 +236,7 @@ static int do_help(int argc, char **argv)
 {
 	fprintf(stderr,
 		"Usage: %1$s %2$s { show | list }\n"
-		"       %1$s %2$s help }\n"
+		"       %1$s %2$s help\n"
 		"\n"
 		"       " HELP_SPEC_OPTIONS " }\n"
 		"",
-- 
2.34.1


