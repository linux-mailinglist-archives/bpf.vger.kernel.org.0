Return-Path: <bpf+bounces-21178-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 392FD849117
	for <lists+bpf@lfdr.de>; Sun,  4 Feb 2024 23:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A70FC1F21FC0
	for <lists+bpf@lfdr.de>; Sun,  4 Feb 2024 22:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B9B2C68E;
	Sun,  4 Feb 2024 22:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jzMNR4FO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E201B2BD1C
	for <bpf@vger.kernel.org>; Sun,  4 Feb 2024 22:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707085434; cv=none; b=HFORwQDuHk8guRxIn+wKZ7xR3wPAggDGJ2DkSLEgFGDeaTOCNRy9Wzw5JHF4S8ke5i1wT5IILnQ61LM9mr0y1ohYhYLsv2BgXQrFVZPe1ZHMcRZkGOECfwZMOCn9MNKRznNDqUidYfi4bz/yk2+v0FFtDq+lVYSqHiQYi+jS6EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707085434; c=relaxed/simple;
	bh=hZ0C+IU1ZS81U/hi1dLxeFFRHGKA9Db36LYKy0wa6Lc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lwzIVwLFhP+cTzmw2/FbTwZTPBScygzGpUqhor0D+NS3IZmqsMs2s4SzxyPQmFDCVCKbMO7WXeGvn+vrGLNvFB7hvNQK8mZp/i1fN27CLEGxcgZeLTuO3FlNUk4uhMaFHJCXAnocYeGd79Ez/gWaw6aOVJjz+MGkmjJX7FTH4ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jzMNR4FO; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-55ff5f6a610so2491540a12.3
        for <bpf@vger.kernel.org>; Sun, 04 Feb 2024 14:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707085430; x=1707690230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I7iVVsYr7oJQ+5LhMCWpUqmsZ4sfaxSQKSRTnwggcKM=;
        b=jzMNR4FO/GmcPTBvX//1JYqENFZBaaqu0N025r6B6yUvrjWDvaaLnbyUGwUY72cbOJ
         kuKzCq6XcESVDl0pKrMNr/MB7fIK6Ogg3Ald4nBal8XwgG/2m+31C+F6LGxGBu63dexu
         pxwAJ6KBA30to3jqLyMghCqo8I4fASR1QtQj6p6mIP/1t7MQn5QTFPpc65vRaMP63jSH
         WXg54sxpahrg23IjOdttOGNiH4R1eptjd+0cLmW2LDVVnRELShpCDL/C5fOxgYpsTe4v
         gjscKMjrshCtBQm0ponWp08H4EcpVktG1ac5z+RJmYAacnP22Rh2tnFrzJWysouWqoNI
         bFag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707085430; x=1707690230;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I7iVVsYr7oJQ+5LhMCWpUqmsZ4sfaxSQKSRTnwggcKM=;
        b=Iu1ZCT5SEYO7qi3DL8wLDMXO2rz1d8xNpr2Dn3i+2bnnu4C8hjTPl/9vmkn8qVA1g2
         58tTRFJcJksOp4/Xt7jp3/FmKusud76iH4jiRlDv8hqlA3qBvbN/LUA+MtZpoZ9eQ8gr
         qwBk9AJxD0SrmayaDh1xje6pqxiXxaejrLIfvhjY96Rg5XZlMkFiD19iU/56IyF80AuV
         2KWV6GXWKj0GXwR6EpBKDVCc9wddbR6c0y2EesUGcSHOxczUMcnuu32hPKeaaIXWavyz
         ha5FFuVuIKt9wvf5jOl1jpjS0tW0mWpY/T6bfMdP2FzmCd/opMJ5umtgDq70pbhMBB7z
         WNTA==
X-Gm-Message-State: AOJu0YzAZPtJT7lNpwkK1tstLLO4tsjLaKk1pitLpN3Cbdly7L4wzEea
	XigekVFqrUadF7Qf5pr2vzGFv4dCu270k0tNdBOzXdBOgQONh8STXWFqCFs1hn0=
X-Google-Smtp-Source: AGHT+IFmmHiuHFPzZjHo1Ak79PaOrGy/STRoHWUTC8v2z25IypOFu8UmFJIVxMNNXQOQBq8R6DMDHQ==
X-Received: by 2002:aa7:d804:0:b0:55d:3d64:3ba6 with SMTP id v4-20020aa7d804000000b0055d3d643ba6mr3785973edq.29.1707085430167;
        Sun, 04 Feb 2024 14:23:50 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXPPl2wfPJzphZWaj4Yk5w/tHtZquF5pX7u247FYtmSNvGBUml840u0VvHoKj4Du9F1bZ4MCfuwGFoxMgjj4B4n9kDVqtyzHAxfueoM5iudfwXb1mrSO7xcP3URLQlJhsiN21C9lk9B0GnkeTdDhUwjIu16ffUOGtlAGz+NGt+Cz8BaI3jn/B6Hxq6Y0NVBtZL75t454kKH1g3/gQvsBA8xjf8=
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id z4-20020aa7cf84000000b0055d19c9daf2sm3123195edx.15.2024.02.04.14.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 14:23:49 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Barret Rhoden <brho@google.com>,
	David Vernet <void@manifault.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf-next v2 0/2] Enable static subprog calls in spin lock critical sections
Date: Sun,  4 Feb 2024 22:23:47 +0000
Message-Id: <20240204222349.938118-1-memxor@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1684; i=memxor@gmail.com; h=from:subject; bh=hZ0C+IU1ZS81U/hi1dLxeFFRHGKA9Db36LYKy0wa6Lc=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBlwAwrpHaxhy9S7D+Sy9nqnQv3uR19Zksdp5LeL PpN9tR8816JAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZcAMKwAKCRBM4MiGSL8R yv9PD/9BrpYF1LhelczMeGrJD/p3yJ4lVqFIybg1iADwShJIyi+442nztEjdpMa0SpdFzT1oNFC qoxYdUyFgonbNsza6BVR79pIghcN8of+a8KYIRkeG2pq9UE3CVTz/im+E+c9uTyzu7yHH6n8CoT oGinrNL0AZA4RZgG10v3j4lv/g3NQl0nmyePjVOpNDGL5oiljKnBXhCtCT0FjvoO9e0qvyg+TEn 9SV3mbW8/iu9eiFL6WwVqNSJf7D8FDbbKjAcfKIFidrxlUsBGCwXNHM/1rKj5T7B/0SNkP2KBX3 1vickhpVJ9K1FNdOM0GrXVp+gQ/J6WStTFGFdsmY/tO59G0FGM8MCRVtHpUvHtZLMh8invO05Kb qC+8vhX8tGYeXl+aoOYyzMGRXKE+YOTSCqZfPhHLU/cIps9MNYstT1FMZULugI0m6AuLKT8Ffhm Ofsyzf3gQZe95GWH473P2oyXpBw15qxwqjaIEzdulYDJD1PQ6HEKFm6mHB9GJTp8eFqNaK3EbrC 16OKu35pOvS93bpAWyiW14IFGen+3Z5jAdVGVPFO+1M+Tw7e2quxmZf89NwaeZ1pOXu1nPOz4eM 51LxKh7B/pHbPe5bF+kx3pSWmYCl2Z+9gM1geu5IIi/LwsxnhV2B2V/1oKqAQQJHP8fL9aGOF77 XLKtixQ/Gjf0A6Q==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

This set allows a BPF program to make a call to a static subprog within
a bpf_spin_lock critical section. This problem has been hit in sched-ext
and ghOSt [0] as well, and is mostly an annoyance which is worked around
by inling the static subprog into the critical section.

In case of sched-ext, there are a lot of other helper/kfunc calls that
need to be allow listed for the support to be complete, but a separate
follow up will deal with that.

Unlike static subprogs, global subprogs cannot be allowed yet as the
verifier will not explore their body when encountering a call
instruction for them. Therefore, we would need an alternative approach
(some sort of function summarization to ensure a lock is never taken
from a global subprog and all its callees).

 [0]: https://lore.kernel.org/bpf/bd173bf2-dea6-3e0e-4176-4a9256a9a056@google.com

Changelog:
----------
v1 -> v2
v1: https://lore.kernel.org/bpf/20240204120206.796412-1-memxor@gmail.com

 * Indicate global function call in verifier error string (Yonghong, David)
 * Add Acks from Yonghong, David

Kumar Kartikeya Dwivedi (2):
  bpf: Allow calling static subprogs while holding a bpf_spin_lock
  selftests/bpf: Add test for static subprog call in lock cs

 kernel/bpf/verifier.c                         | 11 +++-
 .../selftests/bpf/prog_tests/spin_lock.c      |  2 +
 .../selftests/bpf/progs/test_spin_lock.c      | 65 +++++++++++++++++++
 .../selftests/bpf/progs/test_spin_lock_fail.c | 44 +++++++++++++
 .../selftests/bpf/progs/verifier_spin_lock.c  |  2 +-
 5 files changed, 120 insertions(+), 4 deletions(-)


base-commit: 2a79690eae953daaac232f93e6c5ac47ac539f2d
-- 
2.40.1


