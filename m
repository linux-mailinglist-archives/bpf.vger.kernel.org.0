Return-Path: <bpf+bounces-33691-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D98A924B22
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 00:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B02BFB23EC0
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 22:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CF41B11F6;
	Tue,  2 Jul 2024 21:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nQ5/FDKQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114DC1AEFE3
	for <bpf@vger.kernel.org>; Tue,  2 Jul 2024 21:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719957542; cv=none; b=qkwl7JRDmiEOYXLaaQ9uAnoKVQxTkEL1PtsdmSG4EqNv/J2N+sTrgbHgEmKeIUQ4shxdBQa4Qv/kgZkvYFESIZ7KKILXcu49SGNSvc++LEdRT26Z4iIi8F3kPexi3xwLscvpiqlArTAzYdMS2JbLeTAeV/sIU+JWxjFdb1lcX/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719957542; c=relaxed/simple;
	bh=M01YDRrouAlAzlCLyGiYQynak61DO+REujqSpJFVxvc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OfnezreWzXnW/sMcGaRt42lehKt7jkT96wy3ETUCnvt/tvwgevqmuQjUKlvDi1e622WuadZP4GDwtnox6h+rfbq+H+2y1DGVx4FdBzlfUE9rtRn5VysXMIIkgpsLS4keqgjULfqWH+MCrZtdW19AtX0zfFNRwZHCYuZcV9GOLGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nQ5/FDKQ; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7178727da84so2713321a12.0
        for <bpf@vger.kernel.org>; Tue, 02 Jul 2024 14:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1719957540; x=1720562340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FT7lewTlvqPcebAQ7sdKPrt4rD1V8IX/L9ApopkhaiM=;
        b=nQ5/FDKQuDGFbq6YERjqmx1aCEazsTVlIGLTAQdSU91Lz1MtBNw0Mo2hwYFWH/7xHz
         /YXLhTgI7uG88EpaDtc6KqoUjp0fRtnaNmlS5YMOFj70eV+xUjiO6aHHdPkZtfljT4VJ
         gt+ylu+d9ehfwRHPlWmTaw/wtbvJaFrUDJBJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719957540; x=1720562340;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FT7lewTlvqPcebAQ7sdKPrt4rD1V8IX/L9ApopkhaiM=;
        b=O6cvDNBzyyIWu8ySa8FWzTQ1wT3GsuW61ZHqNRGlqHNviY8IrTUVrOeMvD9hicdfIn
         m4QISP5tQRzSa83UA6oJJDE+fb57523opBtwy6wVixGkqkOulWkCa5PkTBp5AnLJ01/S
         X0t+jojwQLlpdSz6S1lZqs4IkYp2KuQ4Qpcf7XZZHAyHJyHEWKg0PUuWoXcaNGbaRZGj
         N/31l2ti+t/9CPZGC1EVvts0D5uRW0fjZIIbbI+ZGg+ig6bnyHVy+xES5OdtZ0q5H0mv
         zkaT19ugdV3EYa2CdpYEfJT+08RKqgC5NyMC2zK/E9oHOY/5YSEYUvzzKU6X46zNbSiT
         yUuw==
X-Forwarded-Encrypted: i=1; AJvYcCUuHupzS6Gi9xFxhVx+DBkJOnpSjjomTs9ZizhJIDLt+4e0HULoUXhDlb3hf4R2ktuszv11HLw1Obv9iFKqgKL0axd8
X-Gm-Message-State: AOJu0YxdNkqpIUzNzgQod0AHOeEhrPPUxak3WeqNy4SWDWFcfG14uvYi
	Y+cxMoQgYclqdNyGMdlrALvuzcS37ogMZMrjBwQUsokRLSdauSJFZWAUW6a/Yw==
X-Google-Smtp-Source: AGHT+IGeWRRAgVyeKiau5CRBkZj201MTdIub9SKabxaU3j/E01KOBS3aEn2OeI76DdOYFGg5Zmz1pw==
X-Received: by 2002:a05:6a20:7350:b0:1bd:207a:da31 with SMTP id adf61e73a8af0-1bef613f4b2mr10203315637.23.1719957540361;
        Tue, 02 Jul 2024 14:59:00 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:5fa9:4b10:46fe:4740])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7080246f656sm9018274b3a.65.2024.07.02.14.58.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 14:58:59 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Arnaldo Carvalho de Melo <acme@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2 0/3] tools build: Incorrect fixdep dependencies
Date: Tue,  2 Jul 2024 14:58:36 -0700
Message-ID: <20240702215854.408532-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

The following series consists of a few bugfixes on the topic of "misuse
of fixdep in the tools/ build tree." There is no listed maintainer for
tools/build, but there are for tools/bpf and tools/objtool, which are
the main pieces that affect most users, because they're built as part of
the main kernel build. I've addressed this series to a selection of
those maintainers, and those that have previously applied build changes
in tools/. I hope one of you can apply this series, pending favorable
review. Or feel free to point me to a different set of maintainers.

This patch series came out of poking around some build errors seen by me
and my coworkers, and I found that there were rather similar reports a
while back here:

    Subject: possible dependency error?
    https://lore.kernel.org/all/ZGVi9HbI43R5trN8@bhelgaas/

I reported some findings to that thread; see also subsequent discussion:

    https://lore.kernel.org/all/Zk-C5Eg84yt6_nml@google.com/

One element of that discussion: these problems are already solved
consistently in Kbuild. tools/build purposely borrows some from Kbuild,
but also purposely does not actually use Kbuild. While it'd make my life
easier if tools/ would just adopt Kbuild (at least for the tools which
are built during kernel builds), I've chosen a path that I hope will
yield less resistance -- simply hacking up the existing tools/ build
without major changes to its design.

NB: I've also CC'd Kbuild folks, since Masahiro has already been so
helpful here, but note that this is not really a "kbuild" patch series.

Regards,
Brian

Changes in v2:
 - also fix libbpf shared library rules
 - ensure OUTPUT is always set in lib/bpf, and always an absolute path
 - add backup $(Q) definition in tools/build/Makefile.include

Brian Norris (3):
  tools build: Correct libsubcmd fixdep dependencies
  tools build: Avoid circular .fixdep-in.o.cmd issues
  tools build: Correct bpf fixdep dependencies

 tools/build/Makefile         | 11 ++---------
 tools/build/Makefile.include | 12 +++++++++++-
 tools/lib/bpf/Makefile       | 14 ++++++++++++--
 tools/lib/subcmd/Makefile    |  2 +-
 4 files changed, 26 insertions(+), 13 deletions(-)

-- 
2.45.2.803.g4e1b14247a-goog


