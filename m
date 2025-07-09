Return-Path: <bpf+bounces-62828-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BADD6AFF18B
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 21:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13A3A4A078A
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 19:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CAC423E334;
	Wed,  9 Jul 2025 19:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="z8OQ09AE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B40239E66
	for <bpf@vger.kernel.org>; Wed,  9 Jul 2025 19:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752088398; cv=none; b=jQYiNYvov4AicW1f+PWvJMH4aE2n455Nv2oaBfBIdEJLLZNd94i95oxFmMVym6JJ2SeXe9RbZVt6HQrpgnDNv98+w4FZz762hUzRUn4LrTU0zWx4XFxlQFjzCBpc8OBwhhAfZHmsFZwRWeLAdJp+nxvjIdL8I8DARs24DMns51k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752088398; c=relaxed/simple;
	bh=O+GEKrt5CQTz69YCt5vd/B3yDeSoUxEI9nwCLelXIm8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L7dhtETpfzHcfdGbqs6KQTmYChEb11199xLUTWmZOCdlrwtZK7lH0yuYhdt2K3CT6GpGFsIo7FE/vJVCAwfD/BHk3xtz8t74LDoYwq9Hods9ncA2PzarGHyHVVIYlXyNlc1Jo7CjC+R9jreJEzPC62fWqeD3otRdhu7+Onkj2+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=z8OQ09AE; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7d5df741f71so20338885a.3
        for <bpf@vger.kernel.org>; Wed, 09 Jul 2025 12:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1752088395; x=1752693195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zQO7ZjQBO5xR2dug8RhFlvrzUcYp9Y5JboWbqZ1zBBg=;
        b=z8OQ09AEKq58eNlI5JHKq2T9RZqMDsaV48CMwnuEsiGNUfpelqyEKWjxHJGTswKmDs
         UF3NSIUBMEucDe0AlRX7FSgExT9dl2e/m7bP8VZVq0Zxcfzb0abmuz6cLEsWvqfmUzoH
         b87FN7iex1S2O1AkNkceIlZr/aORTsqrNiFga/yp7E8SSglhClqA/wcEnE4vOysp0ein
         pRMCIujGFTQt54d3kotJAz4UeBiYHSGYpWhRuqiPCvgjj7XdPhDk/GCUXtozMFEyrxuj
         BQ/FpXRXdg0xNNFa7ylcrd9y7DaZ7/V4hPv+0oHZDTuJF3cIBhXfNZZnHJoNlUmXgMJA
         JF3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752088395; x=1752693195;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zQO7ZjQBO5xR2dug8RhFlvrzUcYp9Y5JboWbqZ1zBBg=;
        b=qFTa3+ARGJyOfIEU5sp6y3hhcuTHGm37FOfxUECrCNfcAQkqxgWKKqVFjxcJl0S1BR
         OkwNnRTfYtiJQ/1RDmg7/2uNj3PefnI9ycAdDtB8DpNt3MTAS1TMqFmRoXUb7CVXT/ID
         dM1LxcTt5mSrEZZrMee7R2kw96jtV/WpujPhczGOWBskZNJlRF9SE6KzAe18STNCdu6R
         tanAiTHaQ/pgteP06BtO53EKmZWhLYNGj70jVkWiCtX5J5w5yoZgVWVky0HriG6l3Qri
         aDkq9Slcl6Wlw87TM+so4tGI5VM/+EesaADtOFCZdfy8GoqstBJRtPGdeomhVHRXympl
         Nwvg==
X-Gm-Message-State: AOJu0YxJJnMp1iqkjlbeMqCZHQalaNARX/99hBIBoUEh3NrIcyls+ib6
	fd17TMm1RTA2IiJXVoKV6MdsrurkcJhIN/84TbQ+F7dwVVWOu4cFuN4pad6LrRqaS8akzyHkMDb
	QGdJ7+CQ=
X-Gm-Gg: ASbGncuGU6Mttd7ORK4Lu5fQv2kUoCkS5A0S9Pim7+FuaLJvQEbqMQ40Ff2x6QZ1Nfz
	CvoEjlNXW5bF3Fx3yNpnX3VODzsai9SQ8HFepP6J4AC5Pg4X5DgWkhgbT/r1KLxQJlehQYVd0P5
	58ZJw+JDjhqhfr+RmDfy7jVprWHGJKIMC4tbx//VREBS/lA+K19QSk4xUDUKFQ7dL6q1WKH6H+l
	lKURzkahfBnnMYj53K+IDq7dIWYzrPcNvLarQ/px0DGyeRbDnoJJS0mRscT1EcCjxbpCbNDUc80
	XUlk/r0R3hpPrdgNIraU1owy8alSxcT4i0QQgAb0RXv7IOFRApS18ai6CuU=
X-Google-Smtp-Source: AGHT+IGid5xA8QqgX7tSdmZmPkBiwVHm9PDG6Gm612Ale2Wv24VZVKyJpuyF22EDe8M1BaN436W/uA==
X-Received: by 2002:a05:620a:3193:b0:7d5:e3d5:1e73 with SMTP id af79cd13be357-7dc925c4fc0mr102255785a.3.1752088394650;
        Wed, 09 Jul 2025 12:13:14 -0700 (PDT)
Received: from boreas.. ([140.174.215.70])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d5dbe92c9bsm977186985a.91.2025.07.09.12.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 12:13:14 -0700 (PDT)
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
Subject: [PATCH v4 0/2] bpf/arena: Add kfunc for reserving arena memory
Date: Wed,  9 Jul 2025 15:13:10 -0400
Message-ID: <20250709191312.29840-1-emil@etsalapatis.com>
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

>From v3 (20250709015712.97099-1-emil@etsalapatis.com)
------------------------------------------------------

- Added Acked-by tags by Yonghong.
- Replace hardcoded error numbers in selftests (Yonghong).
- Fixed selftest for partially freeing a reserved region (Yonghong).

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
 .../bpf/progs/verifier_arena_large.c          |  98 ++++++++++++++++
 4 files changed, 250 insertions(+)

-- 
2.49.0


