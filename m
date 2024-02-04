Return-Path: <bpf+bounces-21152-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FEEE848D55
	for <lists+bpf@lfdr.de>; Sun,  4 Feb 2024 13:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EC20B2212D
	for <lists+bpf@lfdr.de>; Sun,  4 Feb 2024 12:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2806E22097;
	Sun,  4 Feb 2024 12:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/1ADFYP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f195.google.com (mail-lj1-f195.google.com [209.85.208.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084712230F
	for <bpf@vger.kernel.org>; Sun,  4 Feb 2024 12:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707048132; cv=none; b=NzCsvtejm7QUTlsmcS7HHwUb9T/yNH3sbgTIeumG26szbgZOCQ4Tz88PEx8aeciLq8LMezwRpGf/a6XKcWZm96ANRljzOUw/T3BJOx/m8SHgQdWstrhJgrsGwCG9hj6pA6WnJV8jbPF96wpzb+P2J/P8rIB1VB3NkE9efAS29ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707048132; c=relaxed/simple;
	bh=a5xq/8jsaTzfPNMgE9Dah/ig1iTcamwYlP2JMXfX3Uo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fJNfsuRFdg1zirQwkwTEAUZo6TdBCJCz6S/oUrU2mGkDPjcZBRhmchflcuss200W5fOQ/gIicLVcW5s3GLEHgCEnGCAs4C8ZwCUsEzNMgeUPKkIIJP4Wc6lqhjfpmX3Vj3bMRe444XpLyTJaiTl7qTlvRShGbv54AihH82gSEOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F/1ADFYP; arc=none smtp.client-ip=209.85.208.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f195.google.com with SMTP id 38308e7fff4ca-2d09b21a8bbso9337601fa.3
        for <bpf@vger.kernel.org>; Sun, 04 Feb 2024 04:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707048128; x=1707652928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SM+gvq5r/vTwrZuKLYrqFzG5A7vkeyhUQjADLI5JO70=;
        b=F/1ADFYPiVqUI/r6qOMQCQwR4ttvJ7Ro+PQw2vC7R5KtNaHVdFDNziW7Y0z6rlKD27
         HS/qENkp+TM3tnodJeu/2LXBZUqtdqUzq2PnKBrEtFl6OHWrWnFJqqmTnvRn5+qRC5t3
         42FOFS7K/LNfxZUFgwfAGOf1Ohmu+OkZbjpqdAktM7lz2pSPqYz1I70/NS9XVtImBlbl
         wG+RVBG1UE0SvIGAKqMUU19Bppar3ZtjUDMmvSMC2YZtlzmsUACG1dZetSrJDoBlCuKg
         fbKT8T8kZfuQVdLWfva4SAONPrddi2Jz/rYlHiH9G8JUJM4nvxyrI6GeYXpN+9CVXAfj
         XE6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707048128; x=1707652928;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SM+gvq5r/vTwrZuKLYrqFzG5A7vkeyhUQjADLI5JO70=;
        b=I3qWA92o58QhH6c4ls2iwL6onT/BbHERi2bZD2wdSQKlA3nw2tDRepaX0ACtzbYapK
         UK3Xil2hwPzDeSJqYauXquJ04DUJsjdOgr5v+oQOQu2zMXwVwU4Z6WYshmY2FV0Wh1j/
         nLwNR5F6NaOKiJtDh1N0JTryowpNNyiYtTNckuJQ2uDtYuAZx7y13HyehkDkht8mcPX7
         AqtqN7vZXBoKaHbuqyKVYdT5KTTgAu8cU5ERPTTt0X05SfWSME/VKptLdLAtRixyiSJ4
         cJ/5XIulGXusIeRvuuyClf377OCuUnHfzOFMjDYS/QrcAvtWyQK9d6Rt1gTaddJDxBWd
         FSIQ==
X-Gm-Message-State: AOJu0Yy5w4t/TElCbVbheE5QM7yjwaipXaV/bxj4bYENMS6ieVa1YhDs
	IK4e7pxeiwXW6AZTsyMYqDd+C6162y4zKLGKO/3ED7cCfOyFU8NfhyIi87XYAsw=
X-Google-Smtp-Source: AGHT+IEby+hCGeZc7PR/Ggy39Y/UTVePGq9mwgVdYGkXNH18QvsVjcX2F7uKnahhi0/90KpHj3qrAg==
X-Received: by 2002:a2e:3203:0:b0:2d0:a069:72a1 with SMTP id y3-20020a2e3203000000b002d0a06972a1mr1643721ljy.22.1707048128048;
        Sun, 04 Feb 2024 04:02:08 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUQNrUHkc1cabDx8mAKw47MX/dvB+8GJtwlkM+mkyci7JAogDUinfK5wMvilh//Vjm4x6JAFYWHVwbe10+Ed8IfER+It8mYeZoV91YREOSFKOPsTsPhCu2RDtTU+BcweyHFB5Zq1KdFesGW/Fde2iy063Z+AqsJcRRnr4Yu1Sjb1rAqBYF3GpRR845CHbcYACGH7uY1y8ujMyq7shXV9f2i/3Q=
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id er23-20020a056402449700b0055823c2ae17sm2527328edb.64.2024.02.04.04.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 04:02:07 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Barret Rhoden <brho@google.com>,
	David Vernet <void@manifault.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf-next v1 0/2] Enable static subprog calls in spin lock critical sections
Date: Sun,  4 Feb 2024 12:02:04 +0000
Message-Id: <20240204120206.796412-1-memxor@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1460; i=memxor@gmail.com; h=from:subject; bh=a5xq/8jsaTzfPNMgE9Dah/ig1iTcamwYlP2JMXfX3Uo=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBlv3qD6CFcqWQjEiSuGlidL1ASHdr+9KD7NvFzq MmiYbCv7vCJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZb96gwAKCRBM4MiGSL8R ymHaD/93xjcOYYEkozDRg3dNhL1/fo9XhaQ7TF9bmWGEL8rGjL9rQ9zHIicFf/MT/pVGM8cxbJV tUmojE2iTehLmKRdu1LcZ5t19NfJT1HiqIiiW7rMkxo0ebch4MNFGShkmZARDKPvPr78MfxvKWH XrwC7LG/dfbufDic+5/lI/OT79TVQasI/XGre3HHwYEF5u94l5I5x5uxkH4NdLPwbbviYC4x5WA rsGObiaJSM1KyV76zt7pU+ykCdCwlVJu7SYwbQJCOqwzuizxOSe1VnJHWBk6JShinHHDIX/zkCF jP8C0WAG236A2zi1j25fY5aD8stvkfEnz7Et6AeciphBo4Lj5AY0h8ccyzMJ9SdJKM+70Ihj82A UlQy0WjzSoSepNYxSOVnCnmyIBepZPzpo6H95yjo7T3zLUlyN9VR1zKJuFWjuWbydeHDdCMY6fh RoHGA5RPWCPUZIX/MNEwZ1m40NqOZXbAwXFZwfcX9cW5acEIiJNMHzmg9Fd6Ye9t7SUBdSjvmb+ Lp7NzDpv0CqfTOzAEPRW4sq45Su7jbm54ef/g+wMjZZ7jL3rdQPFp6poiA8adgdPwqW4et/iqHX Isf1ga8c82ey9nV5fOMRPQkJt9Fd+aG869wAyTDQNpAvXeasfw2uoHC6E3d1oLw4IFyk4OIp9f6 nnfxMvUT3IcS92A==
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

Kumar Kartikeya Dwivedi (2):
  bpf: Allow calling static subprogs while holding a bpf_spin_lock
  selftests/bpf: Add test for static subprog call in lock cs

 kernel/bpf/verifier.c                         | 10 ++-
 .../selftests/bpf/prog_tests/spin_lock.c      |  2 +
 .../selftests/bpf/progs/test_spin_lock.c      | 65 +++++++++++++++++++
 .../selftests/bpf/progs/test_spin_lock_fail.c | 44 +++++++++++++
 .../selftests/bpf/progs/verifier_spin_lock.c  |  2 +-
 5 files changed, 119 insertions(+), 4 deletions(-)


base-commit: 2a79690eae953daaac232f93e6c5ac47ac539f2d
-- 
2.40.1


