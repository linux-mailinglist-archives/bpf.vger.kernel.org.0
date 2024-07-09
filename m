Return-Path: <bpf+bounces-34283-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8081992C4D1
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 22:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B233C1C210C4
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 20:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFCC182A64;
	Tue,  9 Jul 2024 20:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dkcW2G9R"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D76180056
	for <bpf@vger.kernel.org>; Tue,  9 Jul 2024 20:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720557771; cv=none; b=fls6QAyPBI85b05wiyJ147Jk2bMSkRzLZ200gjmyVWiX2gCDbKj0pjDvQziA+3r4S6zYI6RQ1vDnNF2PlYl7JATLpXlVAFGfCFr3j1YNnov2ZFiYVZ30f5DmTgu/N9zNqT/3lcjptXalq6WAm8nrgBanplmn8LQiHYLpBS6ZRd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720557771; c=relaxed/simple;
	bh=NzFd7/N3dtVr8i5r6QNxUqTOXBxNxROsAYCor52Ghrc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D46I68Xu87hRa2OVpkihWlcv7dYVLev6a9iho6+WCcjFtznuQzT+T9G1UmHnxOSuFRPMxJkHkoGtfDDH5yR1d4EdP4NmFJgaq7Gx+MGa77tNV7KsRG880xdsZ2VYIEwxosEYk2DA9UXDcnfvS2FnV0puju+6IbQR9NJK32jbDes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dkcW2G9R; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fb05b0be01so33328705ad.2
        for <bpf@vger.kernel.org>; Tue, 09 Jul 2024 13:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720557769; x=1721162569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IClM+nkNh3bQyMb1SpTr5S0Y3fVSw1KJe9ktaS1rz2Q=;
        b=dkcW2G9R0uxdWnZnyrbMHLHkBAvfmy84GKC/vFqTxwRk84nyU4wLYWSN9xviZNRPtg
         c1ZMHoJKUhKHGX8H89JHUZDBE0nWgdBz1Aj2sCQP5zGL6OGYILE2vcCxCmQtm/gx5e0u
         8dmGTeMVvqqvMpYM0l4Dt1UKimh4jhCtBz/4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720557769; x=1721162569;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IClM+nkNh3bQyMb1SpTr5S0Y3fVSw1KJe9ktaS1rz2Q=;
        b=RBSMLjEi3/Fx2RUaKCHg5W5dPo2HRMj+G6D5t6ipPgYUg4Xmp4kjXur38eE4oVS5YF
         4+CQJ/Sy0N+iVPjl65QOfDWqO4HA5nWSsqsWdxro4+j0DTisO9DyOK8FWTS1V84MHDaB
         u0/knlNGeHxiv54G7Gm4YWdJhXq6GSXVgzhE1JYsoAko+2f3mCL+ukN+MOlRY4hpPpmQ
         P2TsiwO0Yjf0zZz0gwGvqVC/Z4QDHmS4riKyry2DqRaGIU9bdeQKCURorzzdDyLcIYdS
         FGq+H9UOO/Ccq88uax7EiULJJnmWDFX3FTqNSydb/2m9XMe5FV4FWqx78Z20UbGRvGPh
         UUHg==
X-Forwarded-Encrypted: i=1; AJvYcCW0pHR5p2b4H8Hp3TvyXm3VN5RobXM6AQeX1MJQX9LRWjPOxzlUFI0lPvINX3MgG0fZXG/KsE3Onv9FWW8I/KJOpgwK
X-Gm-Message-State: AOJu0YwRznkyCA2H6i/o+3VcIpXpYuLmNnuL5YgNFU7N+CAwLlbph5ec
	ndS2q1rrubPg/+oxaBh8pu56qcUxIbC18xys+uRlPds61BfPXIU4l1FU3UZh8Q==
X-Google-Smtp-Source: AGHT+IGoLgQUOgFZQ37HZfVJhxLYUs8U/Kuzkwqzf3f2LTNflHkGkZ0CMMSP3/cENo3kBdzUxltHGA==
X-Received: by 2002:a17:902:d50c:b0:1fb:5f82:6a5d with SMTP id d9443c01a7336-1fbb6d44060mr37343645ad.21.1720557769407;
        Tue, 09 Jul 2024 13:42:49 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:4d59:98c6:8095:9b12])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-1fbb6ab6d80sm20322515ad.170.2024.07.09.13.42.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 13:42:49 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Arnaldo Carvalho de Melo <acme@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH v3 0/3] tools build: Incorrect fixdep dependencies
Date: Tue,  9 Jul 2024 13:41:50 -0700
Message-ID: <20240709204203.1481851-1-briannorris@chromium.org>
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

Changes in v3:
 - Drop unnecessary tools/build/Build

Changes in v2:
 - also fix libbpf shared library rules
 - ensure OUTPUT is always set, and always an absolute path
 - add backup $(Q) definition in tools/build/Makefile.include

Brian Norris (3):
  tools build: Correct libsubcmd fixdep dependencies
  tools build: Avoid circular .fixdep-in.o.cmd issues
  tools build: Correct bpf fixdep dependencies

 tools/build/Build            |  3 ---
 tools/build/Makefile         | 11 ++---------
 tools/build/Makefile.include | 12 +++++++++++-
 tools/lib/bpf/Makefile       | 14 ++++++++++++--
 tools/lib/subcmd/Makefile    |  2 +-
 5 files changed, 26 insertions(+), 16 deletions(-)
 delete mode 100644 tools/build/Build

-- 
2.45.2.803.g4e1b14247a-goog


