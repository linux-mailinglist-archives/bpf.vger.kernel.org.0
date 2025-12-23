Return-Path: <bpf+bounces-77371-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BF0CDA032
	for <lists+bpf@lfdr.de>; Tue, 23 Dec 2025 18:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 255E0301ABD7
	for <lists+bpf@lfdr.de>; Tue, 23 Dec 2025 17:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A887E2ECD37;
	Tue, 23 Dec 2025 17:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HYnCITiX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521BB33985
	for <bpf@vger.kernel.org>; Tue, 23 Dec 2025 17:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766509250; cv=none; b=hUQZ+nlVDGWuYcwiVAtG9zuUyNc4ycvCVx2YxJFlU7P4P576OFxatxZdC+7mOBHY1ru1VuuRd3DZbnY/W2iKswGWnWQtTQX27CNPH9gyjxo1eZfabTNoBsj/YSoI34qVtqND+x0OTiOFk4fktXjx1+BJEK/y2mmtHaEsGyYsb5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766509250; c=relaxed/simple;
	bh=dTWw788i/aIQDj88gI6b3lkRd/WwANGU3kgKkaq9+sU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OAGcNKV6ciK6wWTj8LoPnxyExKVYG0Ztip6oVbMkKI5olFo2PPGCWOUcSbeRSMOQ/K1DEN3ybXzMTSpWeVyTmUO9XFGsWGeoCT/oGK6CKt8ZrLgaCIK+2hzwdjeyRKoc9xj69QV7G7lHgyGCX3j1arC/C9cW7UAQJUdh+AZcRJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HYnCITiX; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42e2d5e119fso2275377f8f.2
        for <bpf@vger.kernel.org>; Tue, 23 Dec 2025 09:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1766509247; x=1767114047; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+AMZ134fdqucwFPxdABRgu2JKtvYXYYhxBIYWyA0mN0=;
        b=HYnCITiXpeCQEThCcY3XsNdsKWlQwhv9yqOzjxrZf8YbvnmIBGV+iBoS21AroanS8J
         jX+m4+lAIAj8tHVrn2i59nKDJOXSQ84/e1IlifiFw3dHkPVmOf8OJQhza6SR09cYaMRX
         4eP0uluF6qEQLGsijhhKzw6kWgs55Bmnv7NTKVp7ciVzJTnRc0bSk0VjKweU3gNz+1Tq
         cDmci+S8YM2GuouLIZ5zRu0dL8c7DSCOFlngnj5ekVA6eTv2LnuWz5uLXoqDUXaQ+0tv
         ogoPASY7eO6bk3O2Kwi5ckzGglE0PITw/Sh6eE86I0iOylCOpw2vwmLvr6vZ3LFF247P
         7p1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766509247; x=1767114047;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+AMZ134fdqucwFPxdABRgu2JKtvYXYYhxBIYWyA0mN0=;
        b=pXGLmCotsO34UMlgtsxvTdCmHhqAZ2jIEcoOSnr3UM5cuwPjfix2baZnD/cm2wIW+c
         muynD6IBSD/XTqyJMnBDEd1DA9qBERf5WXtjFocVb6XaKMME8D5u/4sPlVWXED6rObjs
         pBIP4SQC1qUMNcPPCm8kMp/D+H8I26PH7LvdJhVvMmTyxPrU3TjA9lIOHuHMKoZfHmmT
         NqG5cqUSzJrYpZCyuKQ2OG7t2FNyHDLKgo2dZ2Nh3XLrtljoHsblI3Pr+zsM8YvR5NWk
         R1E9fWFoXiYR5ZIfJGmCac4h1Wx2STl9HLKB5TTxp68m2h7k1gmsTGILAgIoZhtmvf7V
         iFqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZfpLSKGrANygEo2Kk1TfGH3A9ZcJXjW9tk2qnN6zgfJHCm+XLYiCjGp15mfPRG/ozOMo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKd+StUtK9/2F01BafpGzwsNG5OFVlxoxA50vWkdHw/HB4S0z1
	b3v31T5DeEwI14iQgp+ytXAD4ERj54uocqJwnGwDq39sSkXaPQQh4AwnjGWni3DIyvM=
X-Gm-Gg: AY/fxX74Y48HdmvWN/4hT8dGiG6Ne5TlFU7UONyvmS41ejRtUiG6iTzTr2tFqw5yUJZ
	HIKYpocKDf7nnHavjEk526e+i7bQeVHqPKC+du2OzsYQ0NX2ijOYkV6Z26qn47QuctWHtAampgj
	fHBKOOPjhD4ikEGptWlamTGJa9tEClmefPi9g047S8D7q5fzEqA8YLcsG4e9P4FFLNV0hNtsqEb
	05DRFbyVypTQwn/wOwZiPOzw1PVyYsVKKDw7g2OWeeTADFBXpfrQpxpd1n+NwA+jMGrkO0i1cL8
	OBH7YvF4jG1YQ3P+ZH03b4Zi6i8Xpnsk8jnYy7YHp+GqTLZ/r6G49eBYoyLfty/jh1Z66XjE80N
	Si8hsXdYrLTwuY9PUf+rq+/T7YvJKz0WTcttfXMRojE3ot2FCIApBE4S8hwIrQdRL+h8W2UpBD4
	qLXcZoGqZZOxft8LsfSbIO
X-Google-Smtp-Source: AGHT+IF7/O/FFIayLKZhY9ZSqUb3Qa2CbWoPZO1if/TAVGsvjrw64xIReXR1i4g5vjHNjk3QtbjX2Q==
X-Received: by 2002:a05:6000:186f:b0:430:f879:a0ed with SMTP id ffacd0b85a97d-4324e4bf603mr17523279f8f.13.1766509246553;
        Tue, 23 Dec 2025 09:00:46 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea1aef7sm28895137f8f.7.2025.12.23.09.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 09:00:46 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Subject: [PATCH 0/5] perf build: nondistro build tidyups
Date: Tue, 23 Dec 2025 17:00:23 +0000
Message-Id: <20251223-james-libbfd-feat-check-v1-0-0e901ba32ed9@linaro.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKfKSmkC/x3MywrCMBBG4Vcps+5AMuJCX6V0kU7+mFF7ISkil
 L67weW3OOegimKodO8OKvhYtXVp8H1HmsPyAFtsJnFy9SIXfoYZld82TSlyQthZM/TFcBrdLYp
 6eGr1VpDs+z8P43n+AFknJcZpAAAA
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Leo Yan <leo.yan@arm.com>, 
 Justin Stitt <justinstitt@google.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Roberto Sassu <roberto.sassu@huawei.com>, 
 Alexei Starovoitov <ast@kernel.org>, Andres Freund <andres@anarazel.de>, 
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Nick Terrell <terrelln@fb.com>, 
 Song Liu <song@kernel.org>, bpf@vger.kernel.org, llvm@lists.linux.dev, 
 Arnaldo Carvalho de Melo <acme@redhat.com>, 
 James Clark <james.clark@linaro.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Quentin Monnet <qmo@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>
X-Mailer: b4 0.14.0

nondistro builds now require a specific version of libbfd, so this adds
an error when doing an explicit BUILD_NONDISTRO build and some other
related tidyups.

I'm not sure if the intention is to skip build-tests if something is
missing, but I see it was done for libbpf versions, so I added the same
for libbfd. This is the main thing that I hit, that build-test all of a
sudden stopped working for me.

The first commit is also a cherry pick of an old commit that seemed to
have been accidentally reverted in the unrelated change linked in the
trailers.

---
James Clark (4):
      perf build: Do all non-distro feature checks in one go
      perf build: Remove unused libbfd-buildid feature test
      perf build: Feature test for libbfd thread safety API
      perf build: Skip nondistro build test if libbfd is old

Roberto Sassu (1):
      perf build: Remove FEATURE_CHECK_LDFLAGS-disassembler-{four-args,init-styled} setting

 tools/build/Makefile.feature                 |  2 +-
 tools/build/feature/Makefile                 |  4 +--
 tools/build/feature/test-libbfd-buildid.c    |  8 -----
 tools/build/feature/test-libbfd-threadsafe.c | 18 ++++++++++
 tools/perf/Makefile.config                   | 54 ++++++++++------------------
 tools/perf/tests/make                        |  5 +++
 6 files changed, 45 insertions(+), 46 deletions(-)
---
base-commit: cbd41c6d4c26c161a2b0e70ad411d3885ff13507
change-id: 20251223-james-libbfd-feat-check-e0cd09d2c1e1

Best regards,
-- 
James Clark <james.clark@linaro.org>


