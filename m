Return-Path: <bpf+bounces-53693-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3F8A5890E
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 00:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 101393AC217
	for <lists+bpf@lfdr.de>; Sun,  9 Mar 2025 23:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D35522172B;
	Sun,  9 Mar 2025 23:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="VqVHu2yp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3381A9B34
	for <bpf@vger.kernel.org>; Sun,  9 Mar 2025 23:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741561487; cv=none; b=cO3qGZAV+1WEVozEpJ5XTxea0W1liloXRNHgaLdypuxNTXJKNR5IEjdxKaZ8eRP0PvHaSSPSwltm/DeXVlA2xpeb3HUGCnLvI2nVWN6c4FMEdy6rESlhK7pOvAgK3LxJXfLp+1uYyUZiIqmiOsHe4au9IHg93bwrRtbyGd5d1ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741561487; c=relaxed/simple;
	bh=JepZjQAVzy2YmSwWe4lKEnFzZkYKpUEQlh3v7tSkhNw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jMtz0cyckrMOvOtb5a9dOVL6Qjwnn5uo54WEQ3o6dm9/8M54jRYDjbgBOOUuDeyWp2netI3TSgLfigq5CmOjedYbsrJd6bc5Q5Paoh1LlvJcZ8n9R4Zf966yqIcG9UoTJDFtMrCo9y95kD/sJ399jJR05ZXLz3TbtaYXB73BMzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=VqVHu2yp; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6e8efefec89so30875126d6.3
        for <bpf@vger.kernel.org>; Sun, 09 Mar 2025 16:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1741561484; x=1742166284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WjoH6JQBGx/21iFHb+ePfnaCYwVXZSJcyXYGxo9Fyxk=;
        b=VqVHu2ypngiE4Oxit2qdx+Gk3bErrY/OX6r4E9lYjvfDlA40O4CQcgMotIMZ4Z0sNO
         uxqUi+l1zNcDsSooTZsak9fv/JGuQFHO99m4x+AQaTh2AzeYi9p25fhJwsRDrFJyavyn
         TSJiSg/mCepzS4HFEIJHkrqFm8wsOFQHIMBp2hPitw16uNmutjStH2+Q/5env03qGk5q
         bZxwSHHhyowHj2vk2tdets2Mxjj8k0pxqAGJG8gnjGAf5OIbuncrK2OZtJvtGWeuy7lM
         EAcvbZb6cXql5rdSyLG2PUIwyH2/+u8W3zAXfU8uclybRBAzfV2VD7RoG6d3iiQ2PXhY
         +HpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741561484; x=1742166284;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WjoH6JQBGx/21iFHb+ePfnaCYwVXZSJcyXYGxo9Fyxk=;
        b=BHIsXP+wQXUqt/kTjE13GhyUhFl6S2/w47rIYd2ohR1CB5HCQ0yZG+ll7BYD/Ktx0I
         ABbij6RgNY1lQldju6FMDjAf6WvhBqWO0gtJLEfrghpFrSz12V2gqkLB5cS83To8ZZPI
         IQnViqRU9Pnw/8/6Djdh0A/ZYT5OSh40vWnB7LX0RhJs0yPuwTxb69YfzFjFAAlI4/Wo
         aOF/PXmRGac6beOtL17uXJs+3jIMX36/yRX24jAiZKsNf4txOA0xljm5rfif2XU5yTth
         QDL7NBoNSf75u0RX0RPfwHtWiDapm0RYc1SCcIBKnH0fmcJ5RRH4qpGIAC9nIpIm5ZmJ
         05xw==
X-Gm-Message-State: AOJu0Yy+1PUctOFVcF8/WuLg7b7JPJB1EyPCDJoJnN/2PJlvvm/yZ7Ag
	Fni3WdF5X84efpVlI7v7fYmHEVdAqKU/EXQCZia6ipvoMrMex+FWwpAeF4zzkeX/Wy2Gwsm7L3/
	xnJj7bw==
X-Gm-Gg: ASbGncsfcnlssqndyDjiW5sodDa2sFz9hMjwpvpz2dFV4NiBFVf5dbWvV1bo687ENdA
	ipQa9nHC5VK3zeV6eqXDi35On728CnZAiSL6Koa2mabwn5RfL/CVbKBr42uJF8BElkt9Jzrnq06
	YlQrU1YkP4xZYCYdqQntDDfPk7yYcTuLHhM2nhU6uvGbwwFyEC9c+biDdRYxjQ3cXgjtQl9/VWB
	fSAuYKuHgXHTM5XBzagYSDxp/sBYFT9nbbVrQrzInXJjW+/m5Ym3vQi/Wlw+fvGkBbtk4yXJzrJ
	iVoA2mW33mhMOQ704HiKUyS0vLJNfw2C5a7jTPr2gQ==
X-Google-Smtp-Source: AGHT+IG0t2OfhiQ0guYjB/vBBR8Z5CCy4hen5S9WstwO7NPtagnlBJDVSvbPCMPZ2zP8gmPLXQzR2Q==
X-Received: by 2002:a05:6214:202d:b0:6e8:fb8c:e6dd with SMTP id 6a1803df08f44-6e9005d4b1fmr150862386d6.5.1741561484365;
        Sun, 09 Mar 2025 16:04:44 -0700 (PDT)
Received: from boreas.. ([140.174.215.88])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e9146790casm14378406d6.55.2025.03.09.16.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 16:04:44 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	tj@kernel.org,
	memxor@gmail.com,
	houtao@huaweicloud.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH v7 0/4] bpf: introduce helper for populating bpf_cpumask
Date: Sun,  9 Mar 2025 19:04:23 -0400
Message-ID: <20250309230427.26603-1-emil@etsalapatis.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some BPF programs like scx schedulers have their own internal CPU mask types, 
mask types, which they must transform into struct bpf_cpumask instances
before passing them to scheduling-related kfuncs. There is currently no
way to efficiently populate the bitfield of a bpf_cpumask from BPF memory, 
and programs must use multiple bpf_cpumask_[set, clear] calls to do so. 
Introduce a kfunc helper to populate the bitfield of a bpf_cpumask from valid 
BPF memory with a single call.

Changelog :
-----------
v6->v7
v6:https://lore.kernel.org/bpf/20250307153847.8530-1-emil@etsalapatis.com/

Addressed feedback by Hou Tao:
	* Removed RUN_TESTS invocation causing tests to run twice
	* Added is_test_task guard to new selftests
	* Removed extraneous __success attribute from existing selftests
	
v5->v6
v5:https://lore.kernel.org/bpf/20250307041738.6665-1-emil@etsalapatis.com/

Addressed feedback by Hou Tao:
	* Removed __success attributes from cpumask selftests
	* Fixed stale patch description that used old function name

v4->v5
v4: https://lore.kernel.org/bpf/20250305211235.368399-1-emil@etsalapatis.com/

Addressed feedback by Hou Tao:
	* Readded the tests in tools/selftests/bpf/prog_tests/cpumask.c,
	turns out the selftest entries were not duplicates.
	* Removed stray whitespace in selftest.
	* Add patch the missing selftest to prog_tests/cpumask.c
	* Explicitly annotate all cpumask selftests with __success

The last patch could very well be its own cleanup patch, but I rolled it into 
this series because it came up in the discussion. If the last patch in the
series has any issues I'd be fine with applying the first 3 patches and dealing 
with it separately.

v3->v4
v3: https://lore.kernel.org/bpf/20250305161327.203396-1-emil@etsalapatis.com/

	* Removed new tests from tools/selftests/bpf/prog_tests/cpumask.c because
they were being run twice.

Addressed feedback by Alexei Starovoitov:
	* Added missing return value in function kdoc
	* Added an additional patch fixing some missing kdoc fields in
	kernel/bpf/cpumask.c

Addressed feedback by Tejun Heo:
	* Renamed the kfunc to bpf_cpumask_populate to avoid confusion
	w/ bitmap_fill()

v2->v3
v2: https://lore.kernel.org/bpf/20250305021020.1004858-1-emil@etsalapatis.com/

Addressed feedback by Alexei Starovoitov:
	* Added back patch descriptions dropped from v1->v2
	* Elide the alignment check for archs with efficient
	  unaligned accesses

v1->v2
v1: https://lore.kernel.org/bpf/20250228003321.1409285-1-emil@etsalapatis.com/

Addressed feedback by Hou Tao:
	* Add check that the input buffer is aligned to sizeof(long)
	* Adjust input buffer size check to use bitmap_size()
	* Add selftest for checking the bit pattern of the bpf_cpumask
	* Moved all selftests into existing files

Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>

Emil Tsalapatis (4):
  bpf: add kfunc for populating cpumask bits
  selftests: bpf: add bpf_cpumask_populate selftests
  bpf: fix missing kdoc string fields in cpumask.c
  selftests: bpf: fix duplicate selftests in cpumask_success.

 kernel/bpf/cpumask.c                          |  53 ++++++++
 .../selftests/bpf/prog_tests/cpumask.c        |   5 +-
 .../selftests/bpf/progs/cpumask_common.h      |   1 +
 .../selftests/bpf/progs/cpumask_failure.c     |  38 ++++++
 .../selftests/bpf/progs/cpumask_success.c     | 120 +++++++++++++++++-
 5 files changed, 215 insertions(+), 2 deletions(-)

-- 
2.47.1


