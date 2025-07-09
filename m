Return-Path: <bpf+bounces-62727-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4F2AFDD15
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 03:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D95AF4A55C0
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 01:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2581865EE;
	Wed,  9 Jul 2025 01:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="UOWQr2LS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3838B182
	for <bpf@vger.kernel.org>; Wed,  9 Jul 2025 01:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752025809; cv=none; b=uAJN75y9vIXF81N1YKRUCMvvAnP9pIHCE82X9z8A67Tqb5awVZWZ5/52wqn0hXItRY0sbBGCoy2TvePP/pntHObhw6RfE4Scj7WMQ6kwF9+niRchQ3SYZ4xFh7pqTv2JUZGrB0R2Vdgff5ZkNxAJdUO0nrEjUOoldvhnbCE5aH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752025809; c=relaxed/simple;
	bh=8UGBh04GSEM2s/kIzogcZGUCKwcGdjonoEjn4iR2nTc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=blPYLdMH985mypRlLgPRqqYzNY1/pbf92gpr6sKRDCNX0DLDxMBCKQtm9egtsZa7a9Ygz6ymfSif2rbjPOvHKGTciR3mCH216fjNl0AxBPRepbAmkvoc+lE8JeFIUM2gyiXQ1NafoDOyWZDws2j0oLHTx1OFIBdkPnkieKSJwCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=UOWQr2LS; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7d5bf3300e0so510016585a.0
        for <bpf@vger.kernel.org>; Tue, 08 Jul 2025 18:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1752025806; x=1752630606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=txvo3nm8dgl/cq5q/N5b6v/u+1SWhRQosPYsPVn6BPI=;
        b=UOWQr2LSCqPMXHRDfVBHVOaHMZZ8aQ62heTuZ2Pa1GUD8cTBBIbsKpPOzSpXIAp7rz
         bg9Xz25rozfoc47FQjSSNyZUI11WdPW/5HcVdz8q3jheSkTC/4OcYbprYRljjon2zWR+
         fic8L7rAzHQZuRn6fFHw6aSUxQQ3z08+DuOenYF5cwmTyzHXry9q4K7jrjjzxWzQM48H
         7qYXt0lneAnzYYsfSHROS4xn9oVvDHP4BrJvfOBCy+h3jCUb06INgVfjswkTILgiQWUQ
         GVHn4wlYLMtHUMuFJ/ukNJk/Ti4zPRxy2b/2wt8CtAkk3liuY0TV8TO9lYLTRzky5B6z
         J38A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752025806; x=1752630606;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=txvo3nm8dgl/cq5q/N5b6v/u+1SWhRQosPYsPVn6BPI=;
        b=pZi5WLMmT+RHMlD4xdfni81JYIZ7aKLYPCKFTLJfI1HxdEkOIgdxEGMv6/X+rOkrMk
         HaB//87b2vIndqaNnivPsPZwfKkYAXcZ/7p43MzsCXFp3LsR0TSP3HABJR+R6+His6UZ
         CEgrtLuERmzAUpUW+6qXdZLnNga1lV+SbxV3Y14j8VUrx0Vi7LnRQpS0kEAzwOZxtvqM
         oX2Jwg43fMayw7RveNVep7BEUqi3hBHAqORI0Gvs5cQuf0/2em09BNfYq7Lezdo7jCJ7
         ZW/9i/9nUtpWPsddgFc4ORvgk0qTpUVNNpyuLSci5M6YFn1zOI3woDGbTosLtonBmQXQ
         TIoQ==
X-Gm-Message-State: AOJu0YwnwcsixEVu8+gOKMP7ozDgm4MeDtU3emurHMoP4rs+5x/cIzT4
	CiT4ZckA+tYLz/7qJhd8EMZx1c5QFQ8Tl9AbFlY9bBFoh2EEXWVGyFSAzhTxWcDuWjBMLrbpNF9
	Pq/ULe68=
X-Gm-Gg: ASbGncvrPC7H/e1pzjKrykysovk/FXRcDwFlX5mLUqZmu5c2bwYYGzr7z9SwmEnLHPS
	At6T6K/rKC8jG4Fnp7oU16go+UjikBpgi3trcMCuCI5TcymOINwHxtToxKgMyiqnSk5f6P58ewS
	W84T3MSR2TgzmPsNRdYA/FEORUzlr9nkA0r5ZZQPalPrqdb4r7Av/bU+9ogg+mjsLcWKJf+BdQ/
	FcYCc94CzRaqth93SlAQgtYxreRa18VBEJEt0P4wnAsdhgL8vs+rszvQkhAA7oc7Uz8JlCXYHVJ
	B1R1zakrugM6hE36SKBbaFlghejAyurv/wPERKTDE4ZwvmjbCiCiYN6vGb8=
X-Google-Smtp-Source: AGHT+IFmMFc14jD19x8RSwCkbApk42LnoLHZXhUMJ72dE+G1B0UWW9SrbtVGRNgPSGqlB89qG8+KcQ==
X-Received: by 2002:a05:620a:298f:b0:7ce:c471:2b8e with SMTP id af79cd13be357-7db7fad169fmr120883885a.10.1752025805906;
        Tue, 08 Jul 2025 18:50:05 -0700 (PDT)
Received: from boreas.. ([140.174.215.70])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d5dbeaf5a0sm861080885a.102.2025.07.08.18.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 18:50:05 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	memxor@gmail.com,
	yonghong.song@linux.dev,
	sched-ext@meta.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH v3 0/2] bpf/arena: Add kfunc for reserving arena memory
Date: Tue,  8 Jul 2025 21:49:46 -0400
Message-ID: <20250709014948.96438-1-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new kfunc for BPF arenas that reserves a region of the mapping
to prevent it from being mapped. These regions serve as guards against
out-of-bounds accesses and are useful for debugging arena-related code.

CHANGELOG
=========

>From v2 (20250702003351.197234-1-emil@etsalapatis.com)
------------------------------------------------------

- Removed -EALREADY and replaced with -EINVAL to bring error handling in
  line with the rest of the BPF code (Alexei).

>From v1 (20250620031118.245601-1-emil@etsalapatis.com)
------------------------------------------------------

- Removed the additional guard range tree. Adjusted tests accordingly. 
  Reserved regions now behave like allocated regions, and can be 
  unreserved using bpf_arena_free_pages(). They can also be allocated 
  from userspace through minor faults. It is up to the user to prevent 
  erroneous frees and/or use the BPF_F_SEGV_ON_FAULT flag to catch 
  stray userspace accesses (Alexei).
- Changed terminology from guard pages to reserved pages (Alexei,
  Kartikeya).

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>

Emil Tsalapatis (2):
  bpf/arena: add bpf_arena_reserve_pages kfunc
  selftests/bpf: add selftests for bpf_arena_reserve_pages

 kernel/bpf/arena.c                            |  43 +++++++
 .../testing/selftests/bpf/bpf_arena_common.h  |   3 +
 .../selftests/bpf/progs/verifier_arena.c      | 106 ++++++++++++++++++
 .../bpf/progs/verifier_arena_large.c          |  95 ++++++++++++++++
 4 files changed, 247 insertions(+)

-- 
2.49.0


