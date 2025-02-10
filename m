Return-Path: <bpf+bounces-51038-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D17A2F72D
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 19:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6D013A3473
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 18:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8F9255E23;
	Mon, 10 Feb 2025 18:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="wdvvakOT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B64192B86
	for <bpf@vger.kernel.org>; Mon, 10 Feb 2025 18:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739212503; cv=none; b=goSBgOzqnhrTLk76+LkTO977WHeOLjcyCUD801Ug3ZcsGV9Cuu08BxdVZHpBaqN8VvRAEFeQ410hWkvCljj0IRfXVD4DTxAMwTDUc7UPpALKYdJJKY4iOjhzBTWaGo0GxC/o482PPdu56QhDVtKb0lxKV5YsC3ENV8fXE+gX2Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739212503; c=relaxed/simple;
	bh=Fet6okgf36tAqXpewfQLTQxQKGOhhrsK1Q0AOZ9/Pjs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bqM21boh7BgkCUTNyH67CesKNN1Qr2uk3bmKsfXOwLphCXEeQozASnnhFMfY96ipv5RGSs7boBd4nlKlepu0U9WHmR/rsktNwwgulV8NhQR7W8+/SEdgapDyNdOrFjS1hk037/Va7AhjQGV/wxHxwN22X66N8XzSOooFfrViiog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=wdvvakOT; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21f7f03d7c0so37189665ad.3
        for <bpf@vger.kernel.org>; Mon, 10 Feb 2025 10:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1739212501; x=1739817301; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RhlEJGyqamWG33JWVRBIx1wW5JbkDOwIRtN2Z4M+TTw=;
        b=wdvvakOT5i4wkWWew3IxRKeLgj5OCrPzweUevk8Iq3hGLguyraFOVVBHGkq1VZ4rxx
         xsNUzog/f+xrfJAVSm04dRMGghOwEYCnOXK37PtvD7+C/uEd8iZLCoFQ98ZPns0s+p14
         napg0JFTAN2KpQVdZDMIIczO8J8JCkBzHyOigUQp5Ur0lWjNBdruSVzCvYFGDHo3ok2G
         ZM7X4QqrBB1Yt8PMmkL49JVY5WA4jpABlcJxi3gIFEco7VjqK83RSMe1Q2eNKBCr/oHt
         2oXw8/tzg5tzQ0HU34XdbN9PB+YkHGWXEzbMfjvqOy7tpm6rIqPGtsOE072YFdwnX3XQ
         ORQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739212501; x=1739817301;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RhlEJGyqamWG33JWVRBIx1wW5JbkDOwIRtN2Z4M+TTw=;
        b=P/LrviTxXXa2VUpec79lpD0QgTls/DmHE6dUP5U61SU9c8eaRzGTQTQN0mcTb1/rOn
         ljpTu7pSQx1WZhP2Y1tABN6m09fXgWkgLrwcoDmiyrQJDw3pFmtr9g1R4TtnjzL6eAnA
         iOA0lfh0dlbCtEpIiG499N3X8Ky5IcrGH9nyeyWEo5LJlDwBQt2n11Vd/rb3Zb+keazj
         YYxQ9A92JqaqH3yrXd88hoUkQXa8yX/CvlP+YMP8rxWbmVi7ximU6IvnlswS50HC3Xxh
         om9lMJHdQaqKR7N/iah0HDtiQDTmDTU3g3I7eADQouICBW5keG2ciAG8PMD7gtOD00D5
         ckCA==
X-Gm-Message-State: AOJu0Yz4tdRYRKMugepZO4Et3fbYtXdK6TMhnlr9WIdw8Flr66gOpsr0
	cS3eK1iAld1FMWNyKa7vYyZm0EydBQVE9sNkrHfZqY/7vQG4Dzx/z9HDp9/DLIM=
X-Gm-Gg: ASbGnctrYRjIORQjCT7LYdvAUsCCGXJ4bFMZs7EwhtTrjGWGecvYi9eXk3w1rzfxaoK
	+PIYSdBn1tipR8r17+FxdKMrGCvzT9b+a63G41dR6iVyMjHeLSFJV/ubhm8NsJBiowG+XfZfX4K
	nU4NPMv/NfDmZADd+77idiIrWS+J72Xywokmgw9w5xEZlMtHM6REkG+RVaD1jXqeYjwv9Jd6aJy
	gxE2v9gE1YqKbUc/hMRSOHQPHsU1zO8+OS5T3e1o1jQnj6AuuyQ/45lG3FzyG+q5r7cXWpOem2/
	k45iDNJJlVp2w8MVFJ9+/zczLrQ39KI=
X-Google-Smtp-Source: AGHT+IGcshiyYeyUumTAxl/O5zl1bGxAtjZfhKbFcjYP8aCSk0OlMXDbqBJ+Y4zN2NdWMp46o5bnIA==
X-Received: by 2002:a17:902:dac7:b0:21f:b404:5110 with SMTP id d9443c01a7336-21fb40451d5mr20090975ad.34.1739212500849;
        Mon, 10 Feb 2025 10:35:00 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3650e6b5sm82534815ad.46.2025.02.10.10.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 10:35:00 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v2 0/2] tools: Unify top-level quiet infrastructure
Date: Mon, 10 Feb 2025 10:34:41 -0800
Message-Id: <20250210-quiet_tools-v2-0-b2f18cbf72af@rivosinc.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMFGqmcC/23M0QoCIRCF4VdZ5jrDNZTsqveIJUSndqC0HJNi8
 d2zve7yP3C+BRgzIcNhWCBjJaYUe6jNAH528YqCQm9QUmmp5E48X4TlXFK6sbDOoLPBaDda6I9
 Hxgu9V+009Z6JS8qfFa/jb/3v1FFIEZT2e6sNauuOmWpiin7r0x2m1toXG5jhDKkAAAA=
X-Change-ID: 20250203-quiet_tools-9a6ea9d65a19
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 Quentin Monnet <qmo@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
 Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
 Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2111; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=Fet6okgf36tAqXpewfQLTQxQKGOhhrsK1Q0AOZ9/Pjs=;
 b=owGbwMvMwCXWx5hUnlvL8Y3xtFoSQ/oqt1NPEzb84l/zyGE146GrwY9bFd7J1Dz3FjzpdTzr9
 dSmlEsXOkpZGMS4GGTFFFl4rjUwt97RLzsqWjYBZg4rE8gQBi5OAZjITgaG/9HW/y407VmbHOFu
 tFAyYTOXt7S4nZ4Nq+R7RasCqdXyMowMS3fb1G+rypyu+E5kzUbPPp1a85cX3rrwNm+x/jG595A
 wPwA=
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

The quiet infrastructure was moved out of Makefile.build to accomidate
the new syscall table generation scripts in perf. Syscall table
generation wanted to also be able to be quiet, so instead of again
copying the code to set the quiet variables, the code was moved into
Makefile.perf to be used globally. This was not the right solution. It
should have been moved even further upwards in the call chain.
Makefile.include is imported in many files so this seems like a proper
place to put it.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
Changes in v2:
- Fix spacing around Q= (Andrii)
- Link to v1: https://lore.kernel.org/r/20250203-quiet_tools-v1-0-d25c8956e59a@rivosinc.com

---
Charlie Jenkins (2):
      tools: Unify top-level quiet infrastructure
      tools: Remove redundant quiet setup

 tools/arch/arm64/tools/Makefile           |  6 -----
 tools/bpf/Makefile                        |  6 -----
 tools/bpf/bpftool/Documentation/Makefile  |  6 -----
 tools/bpf/bpftool/Makefile                |  6 -----
 tools/bpf/resolve_btfids/Makefile         |  2 --
 tools/bpf/runqslower/Makefile             |  5 +---
 tools/build/Makefile                      |  8 +-----
 tools/lib/bpf/Makefile                    | 13 ----------
 tools/lib/perf/Makefile                   | 13 ----------
 tools/lib/thermal/Makefile                | 13 ----------
 tools/objtool/Makefile                    |  6 -----
 tools/perf/Makefile.perf                  | 41 -------------------------------
 tools/scripts/Makefile.include            | 31 ++++++++++++++++++++++-
 tools/testing/selftests/bpf/Makefile.docs |  6 -----
 tools/testing/selftests/hid/Makefile      |  2 --
 tools/thermal/lib/Makefile                | 13 ----------
 tools/tracing/latency/Makefile            |  6 -----
 tools/tracing/rtla/Makefile               |  6 -----
 tools/verification/rv/Makefile            |  6 -----
 19 files changed, 32 insertions(+), 163 deletions(-)
---
base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
change-id: 20250203-quiet_tools-9a6ea9d65a19
-- 
- Charlie


