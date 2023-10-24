Return-Path: <bpf+bounces-13075-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9467D43A9
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 02:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A60128168F
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 00:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6F71101;
	Tue, 24 Oct 2023 00:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FF2KMHpE"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0666CEDB
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 00:09:32 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B55810E
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 17:09:31 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9ae2cc4d17eso586278266b.1
        for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 17:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698106169; x=1698710969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FGpyXtWK9cwxb/Vk/l+V3m8hZz328hybd2VH725NpZI=;
        b=FF2KMHpETLcrwfM/WdmhLM/GmIBgcVUTUrLLq8OOclonK6XqTu8ZDulZSF6f0JHNft
         Qc9myoVnv3LluU0pPngjMFpbM/5B3uuNpPE8/N5bGJBECKuusTua9/LX+rLZ6yt1LNv4
         LOmYX2EaS8hNir3JICjxE4uGsP3m0CT5/Ar6osRwVdYEB43+HIycox0bG/m2GpotAkaN
         O+nkQxyOwPf/JRXVcPXPfG5vzTiPPBXxvPtOPNNRHGwkzs+wA85QJvAN95Sm9jQSG2bP
         6aNmYatNqk0Sfp0HY9eBXnMWFvrM/LoUFmg+5CqzFtSpkasq49dwYJ6rtwLqWmlykU3Z
         xMig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698106169; x=1698710969;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FGpyXtWK9cwxb/Vk/l+V3m8hZz328hybd2VH725NpZI=;
        b=JN1dm+yawINJ4W/ArseGePrz8b7Y3ngrvpGZlKg76LAcCBojZrADlfJ6BAbZ4yWrmt
         4/LCafLReXAoqV8R+0ZdNmswJA2FewY0s8guTL+TeslQ9l9Pcglva1GdmEiKNavtpbpE
         cBC+RpLSzd1ILvN9AgYoa+hegXUvRSM3RYvUD5lk/usqBiL/A+OcL2o35YmNL88o2UJk
         WMTWYNZLRAWrKHB8acsONRidmeBmvrerlsvsi0JtZRoM2PmWk104CXiz0CckznrxYx6w
         lQQSpVIlVfJSvwG22unYsbmL1W91qRj9chxx0xL2rtxwsD/7IJlD2168oAxY1pdch6+k
         RATQ==
X-Gm-Message-State: AOJu0Yyaq+jYRTQ5pQoGs2Wt351kY9w5tQ8ISeKqR1GOcYFug3KnQV41
	7RE4ZfdgiXYvVowESK4fKLm6sM2VSfsc4fGz
X-Google-Smtp-Source: AGHT+IG0MCXvljMf6IpN9q4SChjYxtySx8QW1M5krFkN4IkhDoni3jBXE6ciq7EPMnOUw6XieRIS8w==
X-Received: by 2002:a17:907:72d0:b0:99d:e617:abeb with SMTP id du16-20020a17090772d000b0099de617abebmr8043657ejc.23.1698106169107;
        Mon, 23 Oct 2023 17:09:29 -0700 (PDT)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id d13-20020a1709064c4d00b009a5f1d15642sm7264516ejw.158.2023.10.23.17.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 17:09:28 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	memxor@gmail.com,
	awerner32@gmail.com,
	john.fastabend@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 0/7] exact states comparison for iterator convergence checks
Date: Tue, 24 Oct 2023 03:09:10 +0300
Message-ID: <20231024000917.12153-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Iterator convergence logic in is_state_visited() uses state_equals()
for states with branches counter > 0 to check if iterator based loop
converges. This is not fully correct because state_equals() relies on
presence of read and precision marks on registers. These marks are not
guaranteed to be finalized while state has branches.
Commit message for patch #3 describes a program that exhibits such
behavior.

This patch-set aims to fix iterator convergence logic by adding notion
of exact states comparison. Exact comparison does not rely on presence
of read or precision marks and thus is more strict.
As explained in commit message for patch #3 exact comparisons require
addition of speculative register bounds widening. The end result for
BPF verifier users could be summarized as follows:

(!) After this update verifier would reject programs that conjure an
    imprecise value on the first loop iteration and use it as precise
    on the second (for iterator based loops).

I urge people to at least skim over the commit message for patch #3.

Patches are organized as follows:
- patches #1,2: moving/extracting utility functions;
- patch #3: introduces exact mode for states comparison and adds
  widening heuristic;
- patch #4: adds test-cases that demonstrate why the series is
  necessary;
- patch #5: extends patch #3 with a notion of state loop entries,
  these entries have to be tracked to correctly identify that
  different verifier states belong to the same states loop;
- patch #6: adds a test-case that demonstrates a program
  which requires loop entry tracking for correct verification;
- patch #7: just adds a few debug prints.

The following actions are planned as a followup for this patch-set:
- implementation has to be adapted for callbacks handling logic as a
  part of a fix for [1];
- it is necessary to explore ways to improve widening heuristic to
  handle iters_task_vma test w/o need to insert barrier_var() calls;
- explored states eviction logic on cache miss has to be extended
  to either:
  - allow eviction of checkpoint states -or-
  - be sped up in case if there are many active checkpoints associated
    with the same instruction.

The patch-set is a followup for mailing list discussion [1].

Changelog:
- V2 [3] -> V3:
  - correct check for stack spills in widen_imprecise_scalars(),
    added test case progs/iters.c:widen_spill to check the behavior
    (suggested by Andrii);
  - allow eviction of checkpoint states in is_state_visited() to avoid
    pathological verifier performance when iterator based loop does not
    converge (discussion with Alexei).
- V1 [2] -> V2, applied changes suggested by Alexei offlist:
  - __explored_state() function removed;
  - same_callsites() function is now used in clean_live_states();
  - patches #1,2 are added as preparatory code movement;
  - in process_iter_next_call() a safeguard is added to verify that
    cur_st->parent exists and has expected insn index / call sites.
  
[1] https://lore.kernel.org/bpf/97a90da09404c65c8e810cf83c94ac703705dc0e.camel@gmail.com/
[2] https://lore.kernel.org/bpf/20231021005939.1041-1-eddyz87@gmail.com/
[3] https://lore.kernel.org/bpf/20231022010812.9201-1-eddyz87@gmail.com/

Eduard Zingerman (7):
  bpf: move explored_state() closer to the beginning of verifier.c
  bpf: extract same_callsites() as utility function
  bpf: exact states comparison for iterator convergence checks
  selftests/bpf: tests with delayed read/precision makrs in loop body
  bpf: correct loop detection for iterators convergence
  selftests/bpf: test if state loops are detected in a tricky case
  bpf: print full verifier states on infinite loop detection

 include/linux/bpf_verifier.h                  |  16 +
 kernel/bpf/verifier.c                         | 475 ++++++++++--
 tools/testing/selftests/bpf/progs/iters.c     | 695 ++++++++++++++++++
 .../selftests/bpf/progs/iters_task_vma.c      |   1 +
 4 files changed, 1133 insertions(+), 54 deletions(-)

-- 
2.42.0


