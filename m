Return-Path: <bpf+bounces-65171-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47457B1CFFA
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 03:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D43CB3B7B04
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 01:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3809678F24;
	Thu,  7 Aug 2025 01:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DK6nJuGB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6789A1F95C
	for <bpf@vger.kernel.org>; Thu,  7 Aug 2025 01:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754528542; cv=none; b=Sg9mHNyt9yivxpMQmJOKcLomqexSM0CTEdr7xlvrjjrj/GV43mpjm0s1Fy1wseiZWRsOBoqNmGwOmx75+asm4A12llr81QtMnJVtyGjao67mKNAfkM4ZTB+mn7IuDo7FkDnGlX6GnJplBDI6ZiOUHJunnZpGiH9gB3dfoZ9RmMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754528542; c=relaxed/simple;
	bh=+b8v73mSkuKQY+B6Eid5doLON3Gsblh0LL0hIp+Fu74=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=is1incWqbKixHvOhcWoqirXQ50TkalVSEagL7FaAeB5BPUVqQ2vRusx7x+rZYFKFKijsM11yhasxuiG5Xt75XITBkl/BXhzu1XLib6sLiRrzJbY4AxXgwpVPUOSTH66daA2Qw95Lu+18m5rLmU6tzSeqELdq+VlnxeKBNP29MgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DK6nJuGB; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-31f325c1bc1so504315a91.1
        for <bpf@vger.kernel.org>; Wed, 06 Aug 2025 18:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754528539; x=1755133339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aRTN25qSRzglQmQ9CA1ITNchv+NdEx13TqUaapLSAlk=;
        b=DK6nJuGB/5qSQefW/Q/3KqicoedNYneGNSOhwDJBBHti1SRFRVLUEch7uvLxpZMx6J
         s2JKaQ6mThYXShKJHPmJdwqBdmkriTwJBP7QGcgdom4rMqi6QBf2p3DEWEO+EwDvho7v
         pY/QYWDwTrAgpYnLxHcn3e66fCOaYggw/osfAeFUKum+q2yn4EnY5Bg+V/QX/DQJPJ7j
         OtZmv+hjI3jer7TIJP+u/X2LFL9wKgKiuy5hIZeOo0UmgcM56ILmhH/jRmTRD97aVXMA
         Ewmw+/DpunuNlN8i9ju1blOIJudbH2vNfxBV7vdEjHKwPWeU3E1e2CdMJneEpQWoKIEz
         XqBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754528539; x=1755133339;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aRTN25qSRzglQmQ9CA1ITNchv+NdEx13TqUaapLSAlk=;
        b=r7jB+FORRVBzjenPnr8RbCs9m8FeYS4GPjUBF6oEe/snGdd0ZE+0VprqXOPH53ThDA
         R7Bp8p57lJv+MbRL49qVHW/tspGJNAlw8lCOByPO+WZXSgfuDDMnD+0ovD5Lko3n5t1s
         E9zoCnCHMCZL0GU4x9EAYjOyqFpdaoUoYhCkGp0qFv4xP4w66kf/hyYMXKf7rYL15GAj
         EDSryrzXoeXK32AMwtXa32AUKY7aehrPeEg8vK0gskV/kPseDiu7ILMvnFnlnoUlVT2o
         WE2CgMA69n4sKgdQCFwm6rGvNLPPHASgiAwBE8NUvjsNtmKEqlN9vXA2XFwGZr+H/FFz
         bSUw==
X-Gm-Message-State: AOJu0YwqvNjnJg3A8sPU+0+nH+ojve7B4BVdsTKWa/cEs9xFxHa8z7EH
	ALfzceCSNwuiay4WhrBIhu27aD/fBwYdBl3IzpFFPtez3FdPHZ15t2FaWtTp2ZmZ
X-Gm-Gg: ASbGncvHYaC9S7EspSP3pW4Nliho6ybFgg8qRx/JLQsZ7WezPnLs7oNnAVKZCcltDRm
	Kg7agKy/UPs8QvR1anP+Q7y9K9ZLiWhltdNTQw55Zb+nC90CgCpIdzmO2/h7BcCY5FV+Ij2oh4b
	1fHq7ytgVPP5bz+4l2aVZyURnhhhh6H/aTq4kTgGlJsVbgRn/H/NlmGMOoDhPGfUp9qZOTNocXr
	P6XB3sbfZvPmiMlt+Xcx/PVYf1l93wnZUObtw/C/ON9yKfCaSaYT+ZdIgUDOWCtWCS4Sh1UfVka
	niY4uETVBHQHbeNTTSFhlp+AEGoYpvW3yxjzt8Sbg1Aqg1cxJWthaCKJFU8fHShstdyotOuVqzF
	oedR5v11WGw6Jqu8bv9ECTICNaxnyWChj1HtXJyJqtnnCkBL2/vCAY7o=
X-Google-Smtp-Source: AGHT+IHN8/Nb7/k1uUmre/sVgRwCWhEF92khxoCIhMe7Eggz+yfbxprboLiFsbOgIezQ4eHSqWMezQ==
X-Received: by 2002:a17:90b:1a8b:b0:31f:12f:ffaa with SMTP id 98e67ed59e1d1-32166dfaea0mr5772336a91.6.1754528539280;
        Wed, 06 Aug 2025 18:02:19 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:600::1:e57])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422b7828a0sm14483348a12.2.2025.08.06.18.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 18:02:18 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH bpf-next v2 0/2] bpf: use vrealloc() in bpf_patch_insn_data()
Date: Wed,  6 Aug 2025 18:02:03 -0700
Message-ID: <20250807010205.3210608-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Function bpf_patch_insn_data() uses vzalloc/vfree pair to allocate
memory for updated insn_aux_data. These operations are expensive for
big programs where a lot of rewrites happen, e.g. for pyperf180 test
case. The pair can be replaced with a call to vrealloc in order to
reduce the number of actual memory allocations.

Perf stat w/o this patch:

  $ perf stat -B --all-kernel -r10 -- ./veristat -q pyperf180.bpf.o
    ...
           2201.25 msec task-clock                       #    0.973 CPUs utilized               ( +-  2.20% )
               188      context-switches                 #   85.406 /sec                        ( +-  9.29% )
                15      cpu-migrations                   #    6.814 /sec                        ( +-  5.64% )
                 5      page-faults                      #    2.271 /sec                        ( +-  3.27% )
        4315057974      instructions                     #    1.28  insn per cycle
                                                  #    0.33  stalled cycles per insn     ( +-  0.03% )
        3366141387      cycles                           #    1.529 GHz                         ( +-  0.21% )
        1420810964      stalled-cycles-frontend          #   42.21% frontend cycles idle        ( +-  0.23% )
        1049956791      branches                         #  476.981 M/sec                       ( +-  0.03% )
          60591781      branch-misses                    #    5.77% of all branches             ( +-  0.07% )

            2.2632 +- 0.0527 seconds time elapsed  ( +-  2.33% )

Perf stat with this patch:

           1227.15 msec task-clock                       #    0.963 CPUs utilized               ( +-  2.27% )
               170      context-switches                 #  138.532 /sec                        ( +-  5.62% )
                 2      cpu-migrations                   #    1.630 /sec                        ( +- 33.37% )
                 5      page-faults                      #    4.074 /sec                        ( +-  4.47% )
        3312254304      instructions                     #    2.17  insn per cycle
                                                  #    0.15  stalled cycles per insn     ( +-  0.03% )
        1528944717      cycles                           #    1.246 GHz                         ( +-  0.31% )
         501475146      stalled-cycles-frontend          #   32.80% frontend cycles idle        ( +-  0.50% )
         730426891      branches                         #  595.222 M/sec                       ( +-  0.03% )
          17372363      branch-misses                    #    2.38% of all branches             ( +-  0.16% )

            1.2744 +- 0.0301 seconds time elapsed  ( +-  2.36% )

Changelog:
v1: https://lore.kernel.org/bpf/20250806200928.3080531-1-eddyz87@gmail.com/T/#t
v1 -> v2:
- added missing memset(0) in adjust_insn_aux_data(),
  this fixes CI failure reported in [1].

[1] https://github.com/kernel-patches/bpf/actions/runs/16787563163/job/47542309875

Eduard Zingerman (2):
  bpf: removed unused 'env' parameter from is_reg64 and insn_has_def32
  bpf: use realloc in bpf_patch_insn_data

 kernel/bpf/verifier.c | 39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

-- 
2.47.3


