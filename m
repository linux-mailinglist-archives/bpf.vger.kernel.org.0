Return-Path: <bpf+bounces-4857-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01770750C5B
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 17:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31BE81C21147
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 15:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A66724179;
	Wed, 12 Jul 2023 15:23:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A16C24160
	for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 15:23:31 +0000 (UTC)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB1B1BE3
	for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 08:23:27 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fbc59de0e2so73100625e9.3
        for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 08:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1689175405; x=1691767405;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tZAhgoPSzSEiWvKzr5RiJMPCZbPpsp+Q46lwardwZDk=;
        b=RMtvVaZmdh8x4gharB/xiYRKLMK06DM+scVCIpJR/kv0hKC/9oOVu2jv6PayAgDCDj
         CTHRABouLovm/Z9i5oCt4m3i2YrN3ZzOnS0kBr9giN9JdcwjlNtsOLVzbs70HAX32XT7
         TyAVAv+UVy7mx8RV8rJbRCvrwbq4UHrMuUYoYdH6keUmjMtKdNtSvhzUqlMBMBWorShK
         MLnbYTy1gheDLHhbBQ5BSNz0CpHdyAf9B9tw2egab2WdVWqMZMs0ZGvX9xYYUZn+Iu3d
         lVaQtT+5OTwnTpt1LPM5+Cpkosfo/KWDjqIN0Wxjgy+uCDQOTdT4UjkWtxWDc2WNToe+
         rhFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689175405; x=1691767405;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tZAhgoPSzSEiWvKzr5RiJMPCZbPpsp+Q46lwardwZDk=;
        b=YGETmPqVBvIHaY9464l9GMgtLfbuBxU6oeiERwv9/HI9rciZB/qbGm+zwvyZJX2wd1
         6SxsCFNQedA/fV9lzF+AKH9tj2toyudOMMXM6kiuM3ObSuoFUOjsUHGXK57KBNkml38J
         98hP9bYY4LgaZzs3DS6F2ewney5WbC/M8HdXuVG4btPnAtU3GTouKuHxuxoUK853xzRb
         eL0f7d3dR/Qeg6xwWM5NPdutQ50ONfFJYejPva93YyugE+oigu7BJjSXlo5lbuyakaD8
         ogaIdePJSqU4ydlBMG6oNfJnSb5wQUKMrvMXgXjbdf+aRPH5mzOjCRHBC8mWntaglAZU
         OTrg==
X-Gm-Message-State: ABy/qLbbX0bYWsuYBmzm28Hfd0owDaA9HliBBs3Sa5y2NfkfmWKULzEO
	uRTgDpq81ON/UEjE5o9mzYJQcxdRaZozVf97A+Nfhg==
X-Google-Smtp-Source: APBJJlE9U7y37HChZC5gQddZb8Q7kqqjY29jmJmyJw15sJpchTLDnN1KRCwvZSTiy3oVLF0mTk56QQ==
X-Received: by 2002:a1c:f713:0:b0:3fb:adc0:609b with SMTP id v19-20020a1cf713000000b003fbadc0609bmr19008651wmh.13.1689175405687;
        Wed, 12 Jul 2023 08:23:25 -0700 (PDT)
Received: from harfang.fritz.box ([2a02:8011:e80c:0:2475:aa2b:f4f8:7680])
        by smtp.gmail.com with ESMTPSA id h25-20020a1ccc19000000b003fbcf032c55sm15985274wmb.7.2023.07.12.08.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 08:23:25 -0700 (PDT)
From: Quentin Monnet <quentin@isovalent.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next] bpftool: Use "fallthrough;" keyword instead of comments
Date: Wed, 12 Jul 2023 16:23:22 +0100
Message-Id: <20230712152322.81758-1-quentin@isovalent.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

After using "__fallthrough;" in a switch/case block in bpftool's
btf_dumper.c [0], and then turning it into a comment [1] to prevent a
merge conflict in linux-next when the keyword was changed into just
"fallthrough;" [2], we can now drop the comment and use the new keyword,
no underscores.

Also update the other occurrence of "/* fallthrough */" in bpftool.

[0] commit 9fd496848b1c ("bpftool: Support inline annotations when dumping the CFG of a program")
[1] commit 4b7ef71ac977 ("bpftool: Replace "__fallthrough" by a comment to address merge conflict")
[2] commit f7a858bffcdd ("tools: Rename __fallthrough to fallthrough")

Signed-off-by: Quentin Monnet <quentin@isovalent.com>
---
 tools/bpf/bpftool/btf_dumper.c | 2 +-
 tools/bpf/bpftool/feature.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/btf_dumper.c b/tools/bpf/bpftool/btf_dumper.c
index 294de231db99..1b7f69714604 100644
--- a/tools/bpf/bpftool/btf_dumper.c
+++ b/tools/bpf/bpftool/btf_dumper.c
@@ -835,7 +835,7 @@ static void dotlabel_puts(const char *s)
 		case '|':
 		case ' ':
 			putchar('\\');
-			/* fallthrough */
+			fallthrough;
 		default:
 			putchar(*s);
 		}
diff --git a/tools/bpf/bpftool/feature.c b/tools/bpf/bpftool/feature.c
index 0675d6a46413..edda4fc2c4d0 100644
--- a/tools/bpf/bpftool/feature.c
+++ b/tools/bpf/bpftool/feature.c
@@ -757,7 +757,7 @@ probe_helpers_for_progtype(enum bpf_prog_type prog_type,
 		case BPF_FUNC_probe_write_user:
 			if (!full_mode)
 				continue;
-			/* fallthrough */
+			fallthrough;
 		default:
 			probe_res |= probe_helper_for_progtype(prog_type, supported_type,
 						  define_prefix, id, prog_type_str,
-- 
2.34.1


