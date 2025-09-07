Return-Path: <bpf+bounces-67681-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C28B4812B
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 01:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D951176284
	for <lists+bpf@lfdr.de>; Sun,  7 Sep 2025 23:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EADFF221264;
	Sun,  7 Sep 2025 23:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWdfrsQP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BCF190477
	for <bpf@vger.kernel.org>; Sun,  7 Sep 2025 23:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757286273; cv=none; b=NjcciaM7PNr7zsJ4Bi0KMEI0NlDX1NcobrsJkYpGCA0E0AG/Qqiu+s/pCB85Gx9fgA330Q6RladEqvF2XnfSXrjNm5XMtevdzBaPzc9tzVUEumdKzklgnKNsVGVabbmu2Rwg+TLxJ8kELb7m9XaF0D4yenF/h2lhs4/J0oRHCw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757286273; c=relaxed/simple;
	bh=rU9ecupeuTYpUkGadCKZVtQ003JO/ou1uHOFpdnNYrY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X5zPzVjmE1REQ/7JOAOuoucbRckDyGuxkogU2MYYSQU0yyvM4Ob4bPu3NmNyQhGyETuP1+Wp99g/nGgXj/H+uQ5WuRFsmqOKTcG4lRdqwqTL2IM824LeGUNGmYciHjXIdCSFyMzkwVJwzSo4e7zfjpvmSfmmI2JRVmIKRNrkU2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VWdfrsQP; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b4d4881897cso2592182a12.0
        for <bpf@vger.kernel.org>; Sun, 07 Sep 2025 16:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757286271; x=1757891071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HzRLbWIl7wyhFpBbD5QXnxn/4iEmYfh2Cq6WciEMiUM=;
        b=VWdfrsQPZ3XDP6/I6fghpiY3PnMM4iPwPV3S+3mopOmLCaf3o71IylDiiquhUNR06s
         4oTJe/gVPdB/kf9NO81TfUbANvbu8ILRgAfQts9G4f+2cMj8vtf60kSThmhHlJkDrzc6
         7t9bNQj3eblsSNHeGV2B2wMihFKiC5JzdGnUu9etE7zURp+1YUT+SsSpE0BPC4LK9vZW
         W+Pd85Fchu9jvLusEKRjqzS0z8hGCfPxP1ctVi0n4vmsjr16IsVe4um48qNe1E15XfF4
         Nt2kqMBUvRE/YJE6d2ibIoJQ/J+vHo/VAhS8KiQsP2JewEErfiIN9V+3BsaIz4fu8ZS8
         ltPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757286271; x=1757891071;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HzRLbWIl7wyhFpBbD5QXnxn/4iEmYfh2Cq6WciEMiUM=;
        b=OgDjCEW8/pha1VEVJBjG4mHI63+jDd5fEZF4iamu93YNWjGFycfl0ANn8CHRC9wykG
         nfEaattx8F6MHa2slw3qo14ZVWrqS3loyHeyDOIl+1spdTLxQjMqnV/Gqy7iGyZfWLCd
         2k+/JcHC++6wNPSI2kAp8OlbQ4h1If0cqtrfxuU5EBLJoAPRZ+43wmbWTM7kphxbuLyB
         hn4vmh6RKuvKBoXtZL6hLvcxdpPzrjQ1LiiB4xIs1czJ9I97h312s125KFw6AN7WFJKl
         srzieym+ALP58ee7erM/j/2RqLSHbffVH3RE85aIfuS6kWur2t1HHBkltt8NxqgNm7cV
         c42Q==
X-Gm-Message-State: AOJu0YziYv/nMHwlmbPlqfjdYnRg9o0fRlwSuVf0qTmzSC91jAekRSSa
	gPmrm2vmJfpTAg+aXMqRikbnjzL7yF1GIP6Mb0FQK5dTLNb7jy1UpW2QXCRbCBoP
X-Gm-Gg: ASbGncvTCEc4K3iLu3d6elzyA0v5t58PbqECgnku4vDjYulGuX7VBIDq1dTN49peZ9h
	rC0/e88b5DhMmT7W3keUU3/57AcT+Vb560/2L4AC2pexEfJl9M9CXen6hyxGcgyQ0qjk7CzwDql
	1/lv7OnCe8d70Ce1p1Je0TPx5CD74NrLu/dY6PcAFO5wmP1lXwbkxxtHGIlxBNcwWx9C24g7Ztv
	oj2ip8J+dtAUMsNmo4Wft6sIo7olScYV2A5R5GYqUOUdLplPyLFZq1e6BiNm2AC5z3XzhZTAtbn
	weGQwXLqN0OfciIJubZlL2HsP312ZVC+DmAzLsvbv3UsznsBQ1aGdOCqrF+6yzF6M0rIX6F1Y5X
	5/aESb+zreZGfVGCcCLqAmDjPl3HXIUELQhGDgknZEkMHzHoP3PT3eyh7GZC2HHGoTlN9Ei9Rw+
	Wwb/gpVssBneQi+Gm3yRG5
X-Google-Smtp-Source: AGHT+IFiPIaOdbipPvjvPXFHg+Dcju59zWNm8G3HsjuSTFHoucBAOcECRq3ky/wEXxn4XCPig2xZHA==
X-Received: by 2002:a17:902:e881:b0:24c:ed9f:ba53 with SMTP id d9443c01a7336-251734f2f80mr81365735ad.29.1757286271211;
        Sun, 07 Sep 2025 16:04:31 -0700 (PDT)
Received: from sid-dev-env.cgrhrlrrq2nuffriizdlnb1x4b.xx.internal.cloudapp.net ([4.155.54.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24caf245690sm111254675ad.10.2025.09.07.16.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 16:04:30 -0700 (PDT)
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	djwillia@vt.edu,
	miloc@vt.edu,
	ericts@vt.edu,
	rahult@vt.edu,
	doniaghazy@vt.edu,
	quanzhif@vt.edu,
	jinghao7@illinois.edu,
	sidchintamaneni@gmail.com,
	memxor@gmail.com,
	egor@vt.edu,
	sairoop10@gmail.com,
	rjsu26@gmail.com
Subject: [PATCH 0/4] bpf: Fast-Path approach for BPF program termination
Date: Sun,  7 Sep 2025 23:04:11 +0000
Message-ID: <20250907230415.289327-1-sidchintamaneni@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is RFC v3 of
	https://lore.kernel.org/all/20250614064056.237005-1-sidchintamaneni@gmail.com/

The termination handler call from the softlockup detector is mainly for
the demonstration of the entire workflow and also serves as a potential
use case for discussion. However, the runtime mechanism is modular
enough to be ported to different scenarios such as deadlocks, page
faults, userspace BPF management tools, and stack overflows.

The main changes that we bring in this version are: We have avoided the
memory overhead caused by program cloning in previous versions. During
normal program execution, none of the termination logic causes any
additional overhead.

Change log:
v2 -> v3:
- Cloning of BPF programs has been removed.
- Created call sites table to maintain helper/ kfunc call instruction
  offsets.
- Termination is triggered inside the softlockup detector not affecting
  any fast path operations.

v1 -> v2:
- Patch generation has been moved after verification and before JIT.
	- Now patch generation handles both helpers and kfuncs.
	- Sanity check on original prog and patch prog after JIT.
- Runtime termination handler is now global termination mechanism using
  text_poke.
- Termination is triggered by watchdog timer.

 arch/x86/net/bpf_jit_comp.c                   | 141 ++++++++++++++++++
 include/linux/bpf.h                           |  77 ++++++----
 include/linux/bpf_verifier.h                  |   1 +
 include/linux/filter.h                        |   6 +
 kernel/bpf/core.c                             |  67 +++++++++
 kernel/bpf/verifier.c                         | 135 +++++++++++++++--
 kernel/watchdog.c                             |   8 +
 .../bpf/prog_tests/bpf_termination.c          |  39 +++++
 .../selftests/bpf/progs/bpf_termination.c     |  47 ++++++
 9 files changed, 482 insertions(+), 39 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_termination.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_termination.c

-- 
2.43.0


