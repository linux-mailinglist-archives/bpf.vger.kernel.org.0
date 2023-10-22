Return-Path: <bpf+bounces-12907-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A02F7D2093
	for <lists+bpf@lfdr.de>; Sun, 22 Oct 2023 03:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 532932817F0
	for <lists+bpf@lfdr.de>; Sun, 22 Oct 2023 01:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C27805;
	Sun, 22 Oct 2023 01:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ihZ06ME6"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5FA36A
	for <bpf@vger.kernel.org>; Sun, 22 Oct 2023 01:08:47 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED23D99
	for <bpf@vger.kernel.org>; Sat, 21 Oct 2023 18:08:45 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9c773ac9b15so241805966b.2
        for <bpf@vger.kernel.org>; Sat, 21 Oct 2023 18:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697936924; x=1698541724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D+0GGusGg2nWONPcwtwTqAoEP7QDq6T8+gyJFbZT/i8=;
        b=ihZ06ME6YeETmMISdxmNjlFvZVukpW9VyaXv7FpKL4jzR8+VM/Wg9xIc3t7mkrI1tq
         ltbkjxCIF5tAvzlTfRQB2DVZMlTJwiiV5wGHUME6ImeqkABo/P3GnevAQ/VtOtO1PuWC
         ByNeAKbxktCBMWH0qD/I5BnN6I1AOzLQfLn2GYAweKOOAeH5xzCxOL1Mm5KmIc8fTHaa
         ixsst4iRlBexTdiYOd3jPxlkut1yRkxgw5R8GUuQyGG7aybeojYs+ou6JeCSzMxwfNmv
         tSqnqUdr83+mZnbPZlReqvxiJym98DGY0TubRYYd7WZkigIC8UHU8h9rfN2t/n9WKbrw
         DYcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697936924; x=1698541724;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D+0GGusGg2nWONPcwtwTqAoEP7QDq6T8+gyJFbZT/i8=;
        b=YisY60Phv2BCaiQZ3Tg3pUMzmHthxphPSdgi1PlJoeH8NFSVBuMTnPsLxppH+eQBUu
         rVplYsDC/Bg1qPr13dp1aC1QAdqWzSrBEyRSPe2KwqhETcW+SrP+PXaCaxWgMyfYb/wQ
         If3FV0Ip/8N/StDantKqf8ArDhBDvsqRe5qIsVyGRpfLZYtffkNLitWiSb+IuB3wvtE4
         Hds0SsQO0IpRtBuFbnE2Opg/dI9gRbKMcUDQxzJf/SfK38KOEKPO+XblDEp8KPshW/n6
         NB7qrEgX/f3K7dz/2JlTSB/YVZ8N2/nyCrGphat7tT2UmHhwMdgzZ7NMj7VjAFkqvG81
         v2ew==
X-Gm-Message-State: AOJu0YxQdakL7KzII/efICqH8ij7SaF55Jm1K7Z3BwXSj+8p+WqKB++m
	u2YhchzDNvXaNshhMsy0O+tqlR9qyYO0uPN8
X-Google-Smtp-Source: AGHT+IFbUF+rHhHELEs8BrU8riwwUT5MoFDEswdmEkaQ/RfaVe//2+T21HyZCriQj9Hqu/3uxsZmBw==
X-Received: by 2002:a17:906:da82:b0:9ad:a4bd:dc67 with SMTP id xh2-20020a170906da8200b009ada4bddc67mr4831197ejb.50.1697936923803;
        Sat, 21 Oct 2023 18:08:43 -0700 (PDT)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id u16-20020a170906655000b009c3f1b3e988sm4276143ejn.90.2023.10.21.18.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Oct 2023 18:08:43 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 0/7] exact states comparison for iterator convergence checks
Date: Sun, 22 Oct 2023 04:08:05 +0300
Message-ID: <20231022010812.9201-1-eddyz87@gmail.com>
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
V1 -> V2 [2], applied changes suggested by Alexei offlist:
- __explored_state() function removed;
- same_callsites() function is now used in clean_live_states();
- patches #1,2 are added as preparatory code movement;
- in process_iter_next_call() a safeguard is added to verify that
  cur_st->parent exists and has expected insn index / call sites.

[1] https://lore.kernel.org/bpf/97a90da09404c65c8e810cf83c94ac703705dc0e.camel@gmail.com/
[2] https://lore.kernel.org/bpf/20231021005939.1041-1-eddyz87@gmail.com/

Eduard Zingerman (7):
  bpf: move explored_state() closer to the beginning of verifier.c
  bpf: extract same_callsites() as utility function
  bpf: exact states comparison for iterator convergence checks
  selftests/bpf: tests with delayed read/precision makrs in loop body
  bpf: correct loop detection for iterators convergence
  selftests/bpf: test if state loops are detected in a tricky case
  bpf: print full verifier states on infinite loop detection

 include/linux/bpf_verifier.h                  |  16 +
 kernel/bpf/verifier.c                         | 469 +++++++++++--
 tools/testing/selftests/bpf/progs/iters.c     | 620 ++++++++++++++++++
 .../selftests/bpf/progs/iters_task_vma.c      |   1 +
 4 files changed, 1053 insertions(+), 53 deletions(-)

-- 
2.42.0


