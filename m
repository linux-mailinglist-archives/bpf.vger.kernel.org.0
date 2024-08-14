Return-Path: <bpf+bounces-37142-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CAB29512DF
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 05:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48831283446
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 03:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A732D364AE;
	Wed, 14 Aug 2024 03:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GvFlf4LE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDA021345
	for <bpf@vger.kernel.org>; Wed, 14 Aug 2024 03:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723604687; cv=none; b=gSzbVH/TwcXosg8JgODzSqrpPicXx8oby7++GxvKfTG7iZALXQvduxsfbbjGepuGR+VthdtFGGp2HZx2BwVJ/jeOywEJmTXRuGI4A8qevsg9u/Krvkz4nG/BhCUqm9ixTRn6EhLpO19KW0ifcP59yLcwrxJit+DPmrC7ONnkguQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723604687; c=relaxed/simple;
	bh=7UJu/2PsOEHOhwnyEG3i9TZeYYxvGGCWRhh8Ql7+FLA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o/R6LQ3+TRKoJuQoiNsBBhCFO3NHEgqrZRVqgFSupmFEI18GCjc06TOGEXa+8T2lI0oVKkBFS1dHyfe+Z9/27bmGN79p8VKJzcKM+LZMtTU3Ly5kQqQhsfZjzkiXBOlHlD8n0IHIqR9iahIPQ6Q0IRcUoUG1qJRWfGSVXhe75TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GvFlf4LE; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7093abb12edso4504922a34.3
        for <bpf@vger.kernel.org>; Tue, 13 Aug 2024 20:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723604685; x=1724209485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v3J0fEUvbHMhAPJWdImRyNu59MSY0IJb+fU9MhfF+WQ=;
        b=GvFlf4LELb7hvUwyw9IbuQOancOinDUCXXJCwyXf8m+LSkF/v6ywPb7d9rZQ7D+m9j
         zMmzj9K164tFZdbOL/u6CHErU/gA0LVmgDTtQ/8D/QohjONUWpeM679zo3k8E9QmFzx1
         TiPhjCfRR6qYbtwkvlh9AvtjWZy8T7AkfbIPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723604685; x=1724209485;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v3J0fEUvbHMhAPJWdImRyNu59MSY0IJb+fU9MhfF+WQ=;
        b=FZy7lwSa/UIHS5irInXyamzka47VEYKVi4ymxIE/kePUZaSlysWEnivPBZ+L5kRHll
         yTVSOuTB/jC4iYckuiyiGz+MF9JwSq/gCq2EUJ+mKf749U1Dc/QyeoICHHvf4mbjELDl
         dX3XVHpMWTMRF5K3C0MraI64rfU7ThFpyMz9C59jxhzeNmChtYJbapBV0Ofa+46yZ0ri
         47IYYzoj2GwA1GFl9k5hSky7BeEASFC0VY4+/TK763PlohIlv5cyy7vP33qxOh9wnVkn
         1S2Sejjt9EX+4GzLnIcXfqz/X5s5f6NPrZ5BBScenyt31WSXZ3cZLuRGLzYfFUMs/VGA
         470g==
X-Gm-Message-State: AOJu0Yy/nflHAR2SjA7EJaxcWElfUM9MUz1PaqjOfRdSLmy2GRR07YCS
	yHAEk41j05DHB8mmvYuNq9ui7HC7M3tP41KIr+Q6ul6SJ0/QY3kMbypuZZJS54o+Rb2XuV/ytPo
	=
X-Google-Smtp-Source: AGHT+IEuPm6gxy7zj+fU+81SpVfOU29yyUWzz3ZXSQQZUPg354kPeGsGkveX0zmBzn6UCnv07eUfFA==
X-Received: by 2002:a05:6358:3110:b0:1aa:ba92:e7be with SMTP id e5c5f4694b2df-1b1aad69299mr154584955d.30.1723604684705;
        Tue, 13 Aug 2024 20:04:44 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:517b:be8c:b248:98cf])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-7c6979d4b3asm2182709a12.4.2024.08.13.20.04.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 20:04:43 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: bpf@vger.kernel.org,
	Thorsten Leemhuis <linux@leemhuis.info>,
	linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	Jiri Olsa <jolsa@kernel.org>,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH] tools build: Respect HOSTCFLAGS in 'fixdep' compilation
Date: Tue, 13 Aug 2024 20:03:51 -0700
Message-ID: <20240814030436.2022155-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When refactoring the Makefile rules for 'fixdep', I open-coded the
compilation rule (avoiding the "Build" recursive make, and therefore
tools/build/Build.include). In doing so, I omitted HOSTCFLAGS, which was
previously part of the host_c_flags definition.

Add that back in, so builds get a matching set of host CFLAGS and
LDFLAGS for this step.

Reported-by: Thorsten Leemhuis <linux@leemhuis.info>
Closes: https://lore.kernel.org/lkml/99ae0d34-ed76-4ca0-a9fd-c337da33c9f9@leemhuis.info/
Tested-by: Thorsten Leemhuis <linux@leemhuis.info>
Fixes: ea974028a049 ("tools build: Avoid circular .fixdep-in.o.cmd issues")
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 tools/build/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/build/Makefile b/tools/build/Makefile
index fea3cf647f5b..85321c7b6804 100644
--- a/tools/build/Makefile
+++ b/tools/build/Makefile
@@ -44,4 +44,4 @@ ifneq ($(wildcard $(TMP_O)),)
 endif
 
 $(OUTPUT)fixdep: $(srctree)/tools/build/fixdep.c
-	$(QUIET_CC)$(HOSTCC) $(KBUILD_HOSTLDFLAGS) -o $@ $<
+	$(QUIET_CC)$(HOSTCC) $(HOSTCFLAGS) $(KBUILD_HOSTLDFLAGS) -o $@ $<
-- 
2.46.0.76


