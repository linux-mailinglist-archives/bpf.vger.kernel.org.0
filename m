Return-Path: <bpf+bounces-34845-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB9D931BE7
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 22:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C357A2827D8
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 20:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D098413C9D9;
	Mon, 15 Jul 2024 20:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RuqCN2nK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBA413AD05
	for <bpf@vger.kernel.org>; Mon, 15 Jul 2024 20:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721075631; cv=none; b=s9542/j2W/e2Fvw0dJfD2YtIp1kChTwSinhYTT19xO9AuKqprtE5r89OfmBZTRG28PB7UVeG1exeJI97CXm78Xv//XyPwokJHY89W80mcTKWdS8fg0gXWNwr1X62KfIfNTJ6KQwDaVzm0CqLHJvZMwy362prw3T8VYIRp+d4z0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721075631; c=relaxed/simple;
	bh=OtjVNwo381SC/keZfjeduCwHTRDWCVPReYZb0X3r5SY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DHqCbL8rrfCnuC/Z7MA18JPNIxRz7vQI2xWruqWeVQFScOHMgx3idh0rI58K4wJbwdfhzotmmzdiT+65vm9QyCQwhKSCEFNEOGthO0kN2y7siJB7zBlNdEHyxSp65vY70VO2WMwc9pdSFeluElvqM3ZsxP54VvgNl+NHwH5EBO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RuqCN2nK; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fafc9e07f8so33651745ad.0
        for <bpf@vger.kernel.org>; Mon, 15 Jul 2024 13:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1721075628; x=1721680428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fV8GQ3sNmW9UM2g7XLCappSiUKhDHjx9Q2PF1jfbifQ=;
        b=RuqCN2nKYmAeFZeV5ORARlvFXdYTO58s/TEUh+/PWf+++qzABqrk+aSp4p7Q5VeUXk
         VMB5cJ5euX2BFh0p70PjMxR6ajgFR5pjupEA2vj5+CL/HXoMC2arkEhjgEIM0GI/vPTv
         Q+1RldTDreJ+TNOdFBN+oVPV6cJxuKOoVvAKY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721075628; x=1721680428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fV8GQ3sNmW9UM2g7XLCappSiUKhDHjx9Q2PF1jfbifQ=;
        b=oipn3bnn9JLxIbDtXUV70HqDsJbQmfBF70R7/rInRbXSm6iC3AdW5Ac8Bc3tAJ564Y
         zVDSkXvX81p48ZIFfAqOwwJGctd9kwUG/tyBxcALfYz2QcCdowXJX9MCIo3285ksIM3E
         AX8m1GY1Ce6YKvFkQwxg22jDoYxdQBuXzqazasA0OA3wEenB0iqddU6Z+yvDjKi43hIT
         SBwi85vKkXVKp5eg5UBiLO/8RL8ui32Fp9dD153Ev6V+wx195HHpUEOK82SNmdXFOIQc
         BLSiy/+J2AICrFu611ojmHLmpp+UZUAkx0gAr2BIOLk7OUyGXiIzdQPGlUlx4xETZ5IM
         4iKw==
X-Forwarded-Encrypted: i=1; AJvYcCWXF5Eu8bPgOM1jlUpLEk5t37U4zOGqoU2x7IiLz2JcDhCFLF7nm5OmNome/uIpERz7YDPlYU6922lZa7YOSJ7JUYUR
X-Gm-Message-State: AOJu0YyICRbQYQ/7K43ZAy7eVQSMof86cNa8tDhmXKGcgauno3/Y4ABd
	LZW2uv4bybBc/0UzoCiLjz7EBcXQzAyLFI6DIE3DthUE69OB9vIxah4d/uxg5A==
X-Google-Smtp-Source: AGHT+IFRhxgNHjtN3riipF2pMHlSVgaaC2CKlJ6yHHSh/TXqNehk7BJcZJvHPomUNrJFu/h5juOz3w==
X-Received: by 2002:a17:902:ea07:b0:1fb:75b6:a43d with SMTP id d9443c01a7336-1fbb6d4c958mr208021045ad.32.1721075628124;
        Mon, 15 Jul 2024 13:33:48 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:9b77:1ea5:9de2:19a3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-1fc0bb9bf42sm45317405ad.79.2024.07.15.13.33.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 13:33:47 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Arnaldo Carvalho de Melo <acme@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	bpf@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>,
	Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH v4 1/3] tools build: Correct libsubcmd fixdep dependencies
Date: Mon, 15 Jul 2024 13:32:42 -0700
Message-ID: <20240715203325.3832977-2-briannorris@chromium.org>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
In-Reply-To: <20240715203325.3832977-1-briannorris@chromium.org>
References: <20240715203325.3832977-1-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All built targets need fixdep to be built first, before handling object
dependencies [1]. We're missing one such dependency before the libsubcmd
target.

This resolves .cmd file generation issues such that the following
sequence produces many fewer results:

  $ git clean -xfd tools/
  $ make tools/objtool
  $ grep "cannot find fixdep" $(find tools/objtool -name '*.cmd')

In particular, only a buggy tools/objtool/libsubcmd/.fixdep.o.cmd
remains, due to circular dependencies of fixdep on itself.

Such incomplete .cmd files don't usually cause a direct problem, since
they're designed to fail "open", but they can cause some subtle problems
that would otherwise be handled by proper fixdep'd dependency files. [2]

[1] This problem is better described in commit abb26210a395 ("perf
tools: Force fixdep compilation at the start of the build"). I don't
apply its solution here, because additional recursive make can be a bit
of overkill.

[2] Example failure case:

  cp -arl linux-src linux-src2
  cd linux-src2
  make O=/path/to/out
  cd ../linux-src
  rm -rf ../linux-src2
  make O=/path/to/out

Previously, we'd see errors like:

  make[6]: *** No rule to make target
  '/path/to/linux-src2/tools/include/linux/compiler.h', needed by
  '/path/to/out/tools/bpf/resolve_btfids/libsubcmd/exec-cmd.o'.  Stop.

Now, the properly-fixdep'd .cmd files will ignore a missing
/path/to/linux-src2/...

Link: https://lore.kernel.org/all/ZGVi9HbI43R5trN8@bhelgaas/
Link: https://lore.kernel.org/all/Zk-C5Eg84yt6_nml@google.com/
Signed-off-by: Brian Norris <briannorris@chromium.org>
Acked-by: Jiri Olsa <jolsa@kernel.org>
---

(no changes since v3)

Changes in v3:
 - update notes about failure cases
 - add Jiri's Acked-by

 tools/lib/subcmd/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/subcmd/Makefile b/tools/lib/subcmd/Makefile
index b87213263a5e..59b09f280e49 100644
--- a/tools/lib/subcmd/Makefile
+++ b/tools/lib/subcmd/Makefile
@@ -76,7 +76,7 @@ include $(srctree)/tools/build/Makefile.include
 
 all: fixdep $(LIBFILE)
 
-$(SUBCMD_IN): FORCE
+$(SUBCMD_IN): fixdep FORCE
 	@$(MAKE) $(build)=libsubcmd
 
 $(LIBFILE): $(SUBCMD_IN)
-- 
2.45.2.993.g49e7a77208-goog


