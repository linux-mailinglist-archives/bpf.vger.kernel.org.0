Return-Path: <bpf+bounces-33574-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FCBE91EBD4
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 02:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8DEEB22467
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 00:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C317BA954;
	Tue,  2 Jul 2024 00:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TNEZig+T"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF406FCB
	for <bpf@vger.kernel.org>; Tue,  2 Jul 2024 00:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719880316; cv=none; b=ZUBSoR9PWqUafrIBH26KYmnlVEn00jR+NBgRV0RQHFu96W0GKxbo2tYGuOnkO2CnHx2XF7h45AOpVLWuWUtj7ySysS/A0uX/iwYj/jBcTWYbNaWaDxqAy12Zhz7OqaAolt9NZtqMSS/koK+2LVfPH+bb2/cHZAidrSz9S1VArJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719880316; c=relaxed/simple;
	bh=8HQDcUJyiR3Sp+YMsdl/JN10m6JC1Nd5LCxw/vL7AZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bwTUolgvqRskx4HdPRT/oN9OVVwUxmxh9iNHRZOqx4FxeNlJxt7h13mW7ubAe/8Le52R6r26YxEcFC7RJcLtaNi7LvuXXxdEDPjqhv6EJG1dnkGki63xbzu1kijcjsLZPVgmUE+rvq9K42J13rSUuOxfWO4xAyP7qDmzl2WqoqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TNEZig+T; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2c8dccd0fa9so2193231a91.2
        for <bpf@vger.kernel.org>; Mon, 01 Jul 2024 17:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1719880314; x=1720485114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qAlkVJrx+iYmWBKocsaCYgwHSC8D9q+b05lcIvnmfRE=;
        b=TNEZig+TKe9CBmC+66rvahs7pCSmYR/nBUXd4uMwCebq9qOVvpVSqtoxK0LOrEy3yw
         63h+75x+ZZ4oRpg4Zvn4kWrd2xoTy+LOZqBk9YQSv2j/Bd7LENvfqMrgtjuQPrCg4Izi
         iUYDBa4iWjE1rvKkwuq8cQKNshw+inqARsClA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719880314; x=1720485114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qAlkVJrx+iYmWBKocsaCYgwHSC8D9q+b05lcIvnmfRE=;
        b=vIhakAclBoSmx//Bob5+0WkQaNCzffw2pA5Cu70M0eb3uhwjTX+O2AO3DVKj6tTjJM
         XdvS840Y5HUTlIL2UPLc0DjHkokVxDFRAbEPTH6jkpKQ/kLwCV10Si6Jc4wR7zR4FV69
         Uq5bCYKk5SNAmEbLHOVOOtdmFFUqeGR1n1/x9p7VPpSKyTmYlvkAHLjBJlLNEDtX373v
         EG0MQ+O4/FVm2+yImx9KiT0oPzJ/z1xtc3QxiBnn+F1i+GR5Y5ARNtnV7KWBVtToU7EC
         xuFrtxJWMWTOZut/b2I9j79mZtaNtAEEM8zMHzFYMqu4GZAcPXCWe+tPEzdkuACp3Ecc
         lkrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqF/GP8hnuKxapkFAIb3fPpkARNXbMoBLF/nzHtvp400/x+t6Lt++5KABmPws63AjUddrA6G3xU9trxsecbEpvSmUn
X-Gm-Message-State: AOJu0Yx0trPlrUngO1gmY32sukQH0E9CrSy+RrSG1zSIpSDw/FC0EiRN
	Z4TWi7SR66PDNq2G/uMVfPP8HUo6+kNxa+p22OrjauDE+kGu13h8Xn4h5wSHng==
X-Google-Smtp-Source: AGHT+IEPbJ83rT53lRqJR+7rdt2dy9mpXbHfafFyRHlD7BJqYvFTv1kZGuz2z3AUVjYaOCMrNG+7WA==
X-Received: by 2002:a17:90b:4a0f:b0:2c2:cd03:4758 with SMTP id 98e67ed59e1d1-2c93d6d3a6fmr4133666a91.1.1719880314184;
        Mon, 01 Jul 2024 17:31:54 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:32ea:b45d:f22f:94c0])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2c91ce6f6cbsm7458348a91.29.2024.07.01.17.31.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 17:31:53 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Arnaldo Carvalho de Melo <acme@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH 1/3] tools build: Correct libsubcmd fixdep dependencies
Date: Mon,  1 Jul 2024 17:29:15 -0700
Message-ID: <20240702003119.3641219-2-briannorris@chromium.org>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
In-Reply-To: <20240702003119.3641219-1-briannorris@chromium.org>
References: <20240702003119.3641219-1-briannorris@chromium.org>
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
that would otherwise be handled by proper fixdep'd dependency files.

[1] This problem is better described in commit abb26210a395 ("perf
tools: Force fixdep compilation at the start of the build"). I don't
apply its solution here, because additional recursive make can be a bit
of overkill.

Link: https://lore.kernel.org/all/ZGVi9HbI43R5trN8@bhelgaas/
Link: https://lore.kernel.org/all/Zk-C5Eg84yt6_nml@google.com/
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

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
2.45.2.803.g4e1b14247a-goog


