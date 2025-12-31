Return-Path: <bpf+bounces-77565-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACC6CEB4CB
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 06:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E37133009976
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 05:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250FF1E9B37;
	Wed, 31 Dec 2025 05:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gEHRuaTq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4737945C0B
	for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 05:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767159382; cv=none; b=ddP99BkWVaJew+sm3oBmhuBKIOUpwPUvECbWAFSumjoFuyd4L+/fIH6sZjFeEoEM7hbNJCRs5iHqBg3XF/wjrU3lNkGEMD5Tr+CZtC4NuNAf4NkxkqJoHSsKm1t/vUttK8uPMtZYKwRV+bfotwoN+iMkeDserT5tvfYKbXJKym0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767159382; c=relaxed/simple;
	bh=FaroagIDXyL86Qdh4G6cyGeEDKIDBR+uHQ2nf9RUjL0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ph9TKn3eFAfBPRqTQm3dNi2CI92U/bkP4PlkdgtO6axBPxnOFVQ+/jun0DIbTdLsaZ9u2Q/LKe4k1BAkoJhNhp/KhOyqxhakAWJnYLUY/OTEJnzwR1C3/9VSOcQR2ZASaex9ZE/PswNJfjOKgGkjKYdBIO3E8i+gh1bLWyacaZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gEHRuaTq; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7e1651ae0d5so8165131b3a.1
        for <bpf@vger.kernel.org>; Tue, 30 Dec 2025 21:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767159380; x=1767764180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tMK865niip7vb2T7JaWZrhvkAXiAfWYuqyGxWDnlYnA=;
        b=gEHRuaTq7+XsBD908TUYy9hL1TS4yoBd00c0GLiNVVa4yHWFl4hBQEeAAWmrYjej6r
         6Bq6Cl8t55LAd9dDhdSrYDlVjlrKa0tw8NI3MpMKaXR+vuymbFhx3cEF1yvx1zpt8zC5
         WcCd2lvSMVJZ+XfBAHsMBmYwb3UzbnjgDl3EKHkfJXtcVQ+/dlLOsFNk4yTanBSDn7Kq
         lnyMX2EugKychGkAUliyaq++lY/4pkbaPg8iBQskYuHCuAXln+HITjqIXo53s0zwG03U
         OQGc+0mnqapVSpPvIT4n4F3yLh4B71pfF/bgMUZ8+vd8uxjIsP4Oy1WHtmXajpQgKmRZ
         mIQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767159380; x=1767764180;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tMK865niip7vb2T7JaWZrhvkAXiAfWYuqyGxWDnlYnA=;
        b=NsyPNTmjRHL0RMDy4JUhBF///cJdWgS5DbwdbCFsXIvRv2G6lCK384tDcVIkimlnOa
         9zVjdlDQ8jQWkKui49/RH0DggIzHTk3HgJ3kudxiKW6UTg5Q7tHdkakGLkycZpuMkIRI
         8uJLatuba9YDXzek9V5uzarIFKSHuEoVAeAdVJdpQK653RLBJO3TDHUcjqZ1LK/+/o4E
         F2fmbpTy0DVdit32d8LehRecHww8B/tGiO3Cj/N7r3MlKghCV4u/H3tcnqrxOTA3OD3S
         bjgGZZ5aZjrXa8nfnDtNRtFpvQDhU/96YraSjC3yg/BxTGrq2NmFO0+S0QF0TbVqvaJD
         Yo2Q==
X-Gm-Message-State: AOJu0YzkN2QXS24rBojTbAwJ+e1A/SOtRiaCzmbDogmyvBf5yqd82Yt0
	R3+VR4DvALVVBZFtUwbt9YqjO7DCurFzg5arB9Z6EpzVOUyLUyNIRsKQo/glVdU/
X-Gm-Gg: AY/fxX7EfGy0TmUWkCGk14r9UUb3g+WRcJzboWrG4IkZZ1inMiN8PtGdEMzn3/nP1HC
	7mWFEx8MvSpI72pFAGwPMhATvhxSRTr36XoDpcmelXgc/Ia0+erisSoIfBf1gu67LebxnOG2zFl
	RXSs2IG5Ri8qVgAErZVvGIf8B4clFC4TVtQ8hmO95OCQ/hkK1E710wSdQ/ZmekQe15o7mIzDLit
	n5FnfS5IOjszqHFOMUkrgN0J+vYPI6VMHdvY3xq5HEZr8Yn8keQiHHcFmvUfFtWpKiIfFA5IDAD
	McOngtn/n00vhDs4bmzFRwqynjhZf2B6dQYCGZFQX7gWV0Fws33HDOQNCO23tPeDNMAsm4B+a2C
	KawQba3H6rEFpZ2s5k3vf99C34HGceDbCJDDj09zZybVl8ySNOnfPnWLjEn8xcgf5YyMaeYbcqY
	cmbiVXS/9tyNp/J8c06CTSzty31PX2oAtBHA==
X-Google-Smtp-Source: AGHT+IH5bmutSaqk9AD+I2g/lWVCpAe5MgRYu8YkPiC8dF2PcpcihA/R106NruivtMGqDBOxZVeagw==
X-Received: by 2002:a05:6a00:418e:b0:7e8:4587:e8b3 with SMTP id d2e1a72fcca58-7ff65f74d85mr31094749b3a.38.1767159380338;
        Tue, 30 Dec 2025 21:36:20 -0800 (PST)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e197983sm34050165b3a.33.2025.12.30.21.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 21:36:20 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH bpf-next 0/2] bpf: unify state pruning handling of invalid/misc stack slots
Date: Tue, 30 Dec 2025 21:36:02 -0800
Message-ID: <20251230-loop-stack-misc-pruning-v1-0-585cfd6cec51@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20251230-loop-stack-misc-pruning-18b1ac62ae1a
Content-Transfer-Encoding: 8bit

This change unifies states pruning handling of NOT_INIT registers,
STACK_INVALID/STACK_MISC stack slots for regular and iterator/callback
based loop cases.

The change results in a modest verifier performance improvement:

========= selftests: master vs loop-stack-misc-pruning =========

File                             Program               Insns (A)  Insns (B)  Insns     (DIFF)
-------------------------------  --------------------  ---------  ---------  ----------------
test_tcp_custom_syncookie.bpf.o  tcp_custom_syncookie      38307      18430  -19877 (-51.89%)
xdp_synproxy_kern.bpf.o          syncookie_tc              23035      19067   -3968 (-17.23%)
xdp_synproxy_kern.bpf.o          syncookie_xdp             21022      18516   -2506 (-11.92%)

Total progs: 4173
Old success: 2520
New success: 2521
total_insns diff min:  -99.99%
total_insns diff max:    0.00%
0 -> value: 0
value -> 0: 0
total_insns abs max old: 837,487
total_insns abs max new: 837,487
-100 .. -90  %: 1
 -60 .. -50  %: 3
 -50 .. -40  %: 2
 -40 .. -30  %: 2
 -30 .. -20  %: 8
 -20 .. -10  %: 4
 -10 .. 0    %: 5
   0 .. 5    %: 4148

========= scx: master vs loop-stack-misc-pruning =========

File                       Program           Insns (A)  Insns (B)  Insns     (DIFF)
-------------------------  ----------------  ---------  ---------  ----------------
scx_arena_selftests.bpf.o  arena_selftest       257545     243678   -13867 (-5.38%)
scx_chaos.bpf.o            chaos_dispatch        13989      12804    -1185 (-8.47%)
scx_layered.bpf.o          layered_dispatch      27600      13925  -13675 (-49.55%)

Total progs: 305
Old success: 292
New success: 292
total_insns diff min:  -49.55%
total_insns diff max:    0.00%
0 -> value: 0
value -> 0: 0
total_insns abs max old: 257,545
total_insns abs max new: 243,678
 -50 .. -45  %: 7
 -30 .. -20  %: 5
 -20 .. -10  %: 14
 -10 .. 0    %: 18
   0 .. 5    %: 261

There is also a significant verifier performance improvement for some
bpf_loop() heavy Meta internal programs (~ -40% processed instructions).

---
Eduard Zingerman (2):
      bpf: allow states pruning for misc/invalid slots in iterator loops
      selftests/bpf: iterator based loop and STACK_MISC states pruning

 kernel/bpf/verifier.c                     | 10 ++---
 tools/testing/selftests/bpf/progs/iters.c | 65 +++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+), 6 deletions(-)
---
base-commit: ccaa6d2c9635a8db06a494d67ef123b56b967a78
change-id: 20251230-loop-stack-misc-pruning-18b1ac62ae1a

