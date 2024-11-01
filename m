Return-Path: <bpf+bounces-43680-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDC99B8774
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 01:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 426D41F226FA
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 00:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F482188915;
	Fri,  1 Nov 2024 00:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nTERldzO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C182714A4DE
	for <bpf@vger.kernel.org>; Fri,  1 Nov 2024 00:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730419226; cv=none; b=dKpTpDyR+XahGFaHANbyBdzJ2NHwRXwz1rgSjLrv4UZpzzeRdUe5Qtx/UJm3h4RFi7AQCPrSVef1jgQCov56FzLAbZazOJSq9adWSSFlkpVp1LfhGasbCGd5dE2TtMWCCDIWoUHydEdv6WaEQDuCcs7KCc3h2C3qiZ4/hlu9gcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730419226; c=relaxed/simple;
	bh=2vCxtsq/xzFl47El6NMyWW8yBm4Ex3jWE0vyGx+0hkw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NGvuRM1AA74GXn2bFdyZMZTIx7zJ4Q/9byzH9OuSXOgzdJTyYtuWTncLm1EEZelVSwv3YJDAvOlMZHBlGjjzGAsnepQOwA44J7sB3Zb7t0lScpR7tjVoPfnBmQ58obsp3oyJtqlIeo6wDNtwEoKgwH//ilHoXchn70vIcdibUbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nTERldzO; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-4314f38d274so15913175e9.1
        for <bpf@vger.kernel.org>; Thu, 31 Oct 2024 17:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730419219; x=1731024019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qdU7Tz65N/HlX1nb3Xxm/JMMrNarnRG1hlJNCo5uYno=;
        b=nTERldzOIJsF7PPeF61fa9m+EefJyf0267TZN/UdqEGi5uLLHsKzAkrz4fXCOnDIo0
         EeTHJ8CAgx4gvu/nxXj0cTAyg8WF8ifXl3JfKZQUikPxhxDfJ/qow7263JsJH+YmJH3N
         pL+Foy69isaVYPkHa0c6lvKyZpAWqplnVCNPWgbkhRNr3kI0jBuez7fPSr3y8TZBHTw3
         SLmrAhTsfVFc04759tnBrrKAdLBu0dBi0fD5tEIKzf1HG4E7S5YCZyMVxCPHj4KAINgJ
         ehq30R/DNVELOFhiyrmpOUXfHMC6yGPZSEpLsnYWhybymfweadycYf5JSpuHakkEjyy4
         xsrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730419219; x=1731024019;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qdU7Tz65N/HlX1nb3Xxm/JMMrNarnRG1hlJNCo5uYno=;
        b=J/CWHymUbOIYWtkEUhEyfn0pPNhStIeYjR8evaq58Ts9iuysOEAqmoVVeoA+tyCYq4
         8RJFjUTA3sCFUI5zT84epD/jRpL1+yo7KRbwIBnbPg42tdrjtMwpWW3IZSUsIP8gjnkx
         eQckqsYriBYZf4Wk9pLK4uTP+2NaR2yzKZxMCYQOcHmUDMH1wOLAQ3Etp4uuBC/ZETxc
         Czb0LQ9NQdfWQUZ1XsaUkY+KV4NayxCFctk1zjPtkWjKIE9wfbXlAAxcjbtSR+Pooyna
         cpAZhrma+AOC2lgAYMSGK/Cu0IoWs3Y4+sgNI4SP/NA98Fi7VK0btTmppo9gPTWSyJeP
         yFWg==
X-Gm-Message-State: AOJu0Yy4J0cu45jHzJA6gnTut7htDfKqHqKPXb+fw8uxDA/WmbtAG+tO
	jonmCrgK9I5k0iJut8kDa3WgdapAJbreVCuzj1qRJdWdzTSzJNVTRhrlHkD+0Qg=
X-Google-Smtp-Source: AGHT+IFhDpkhYqRVtx3vB8Gyu74XENJyOyXxHG+hnTTy6RsBzWtcuynkV/WGxidufcnpIlORLyrpng==
X-Received: by 2002:a05:600c:4455:b0:42c:b508:750e with SMTP id 5b1f17b1804b1-4328324ae6cmr15456285e9.11.1730419218450;
        Thu, 31 Oct 2024 17:00:18 -0700 (PDT)
Received: from localhost (fwdproxy-cln-031.fbsv.net. [2a03:2880:31ff:1f::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d685308sm40976885e9.33.2024.10.31.17.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 17:00:17 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Steven Rostedt <rostedt@goodmis.org>,
	Jiri Olsa <olsajiri@gmail.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v1 0/2] Handle possible NULL trusted raw_tp arguments
Date: Thu, 31 Oct 2024 17:00:15 -0700
Message-ID: <20241101000017.3424165-1-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2496; h=from:subject; bh=2vCxtsq/xzFl47El6NMyWW8yBm4Ex3jWE0vyGx+0hkw=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnJBnrYvTF6Qh2KjN8y6IlnvN0oo0576fC3Nxa15hZ rc0S0WOJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZyQZ6wAKCRBM4MiGSL8RyvFSD/ 479UTGvhiZARRK+PC9qm/dVCnhSLV1RU1qUPPHFOLeE1mYmnl03+U6CzOkK8VmaxhST1E2OD4NU2OL cXhA6p1SPW8QXYkFcTPUxZZXmCnqjS5pp6a+lanpzxIaBrAHKiPvVdGlLAfVK6b0YbnJRd/BtMuVAV zYIrTxBDXYt3Vh6BqNw7nWFtkGY1JRoBPkRKXGdOrlU8kqv7dmwUWoHPuUyRFcI45jG+DI+F5vgoDc 2mAVfTL18tSKOjvn1/Z8rai51H+/qtl6+4icgRmgJ6J7CbcjY/s5I3QitTdISusSKMmcXvYQ7tk+rc rNFM9OQiClpAJsYEmK6QF8Z95XGkM2nDTv2ooz+9Zk5p9nPKIxzoFUeruWDH4ec2V2lgw9jiM54e5X suHkE4B3NNxMlXBfGHL903FBQGhe7yrEviw6R/wsJxLqPDEPRyLO1CxqpNlT1ZGKsWmua9YqqFiBOr JTO9aMYXqvFiXapKKaql14YaRWRUoFzi9kVPCWU5m6KbOZUkl65Uou50M/uI5lKu1rh+pH5YxFuP7Z r6BhFB6RgyzheKZPCdy8ZR+47vj88308uGmQX5SnlsX6HkKc2QuDX5Kz1ZiF9GOh4lgwUYIgnNhSA7 diPm2rpcW5MbVGV4o9+Yyy7Gw6TQB8Y9jN28RH/u8LklqMkPDb9guoShhCNQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

More context is available in [0], but the TLDR; is that the verifier
incorrectly assumes that any raw tracepoint argument will always be
non-NULL. This means that even when users correctly check possible NULL
arguments, the verifier can remove the NULL check due to incorrect
knowledge of the NULL-ness of the pointer. Secondly, kernel helpers or
kfuncs taking these trusted tracepoint arguments incorrectly assume that
all arguments will always be valid non-NULL.

In this set, we mark raw_tp arguments as PTR_MAYBE_NULL on top of
PTR_TRUSTED, but special case their behavior when dereferencing them or
pointer arithmetic over them is involved. When passing trusted args to
helpers or kfuncs, raw_tp programs are permitted to pass possibly NULL
pointers in such cases.

Any loads into such maybe NULL trusted PTR_TO_BTF_ID is promoted to a
PROBE_MEM load to handle emanating page faults. The verifier will ensure
NULL checks on such pointers are preserved and do not lead to dead code
elimination.

This new behavior is not applied when ref_obj_id is non-zero, as those
pointers do not belong to raw_tp arguments, but instead acquired
objects.

Since helpers and kfuncs already require attention for PTR_TO_BTF_ID
(non-trusted) pointers, we do not implement any protection for such
cases in this patch set, and leave it as future work for an upcoming
series.

A selftest is included with this patch set to verify the new behavior,
and it crashes the kernel without the first patch.

 [0]: https://lore.kernel.org/bpf/CAADnVQLMPPavJQR6JFsi3dtaaLHB816JN4HCV_TFWohJ61D+wQ@mail.gmail.com

Kumar Kartikeya Dwivedi (2):
  bpf: Mark raw_tp arguments with PTR_MAYBE_NULL
  selftests/bpf: Add tests for raw_tp null handling

 include/linux/bpf.h                           |  6 ++
 kernel/bpf/btf.c                              |  5 +-
 kernel/bpf/verifier.c                         | 75 +++++++++++++++++--
 .../bpf/bpf_testmod/bpf_testmod-events.h      |  8 ++
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  2 +
 .../selftests/bpf/prog_tests/raw_tp_null.c    | 25 +++++++
 .../testing/selftests/bpf/progs/raw_tp_null.c | 27 +++++++
 .../bpf/progs/test_tp_btf_nullable.c          |  6 +-
 8 files changed, 145 insertions(+), 9 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/raw_tp_null.c
 create mode 100644 tools/testing/selftests/bpf/progs/raw_tp_null.c


base-commit: e626a13f6fbb4697f8734333432dca577628d09a
-- 
2.43.5


