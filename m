Return-Path: <bpf+bounces-12878-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5417A7D1A23
	for <lists+bpf@lfdr.de>; Sat, 21 Oct 2023 03:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0F35B21576
	for <lists+bpf@lfdr.de>; Sat, 21 Oct 2023 01:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6A1655;
	Sat, 21 Oct 2023 01:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iV5HHyJD"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1974A37C
	for <bpf@vger.kernel.org>; Sat, 21 Oct 2023 01:00:16 +0000 (UTC)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34433D4C
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 18:00:15 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-5230a22cfd1so2082173a12.1
        for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 18:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697850013; x=1698454813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5qD6eC5f6UK8N81OYIQ+NqWlRdGs0KwvIQUqP7r0Aas=;
        b=iV5HHyJDf9n6/xMGd9Nn6RJpHbVxzfK2WMapx5U0SV80Dh1GD/16/PBIFoU7sokYIJ
         MxODXwoSy+/11IPS4EceRCPhYIsQ4BRTkRG3Ip1XOAvwgPvBYJwp5zB6P5N6PjfyQDtB
         QjFV36VI6bU76W/iJJf8bmUbMgleKbfBGLyxvZNNOy2eO/7cYn9/U4/C/DfO7R5tRGhz
         swryeU/gaxaS1IHkEUZS/eEf+Y0g9P+y29ZiY4rJ4dSMDfzjsT8V5b8E6qTRwc+7ZTIR
         VK3SDeY8AieXx8alGX6g8DnfzdOT1HwUVmrOJf2VXanZZ9LD8hhjJnV68vQ+fwp23mb8
         IBYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697850013; x=1698454813;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5qD6eC5f6UK8N81OYIQ+NqWlRdGs0KwvIQUqP7r0Aas=;
        b=DgaFz5voqV0FtLMLD963m/ptbQFIpcR+uwBs4PgCcFqrTqeg7utjS4GrlIH+pU1ygn
         fjhovP9aVwgS2SBGEELF9wz8npp2aOrZQ6GH6f5xMUBFNsHWdMHwYjIoRVgn5rKoXyHP
         foR7ihBmx/m80rzRwO/4KsuYGHWCBZM83+5dXuqYfIv9YWqXOAWt8KT8OuoA46R3NEAc
         TDMIIfsaEcgKK7ENRosdumGleDur6NYsxUoRLqVrMKRkrJPtLqFsmQ/WhHMYtIkYi9pT
         jjenCFUJQ7lv/Ul6ddgB645MEa3U/pXLVbPyj3vN2b9SMFhnOtLFhLPR5g2QkRJ48LxK
         LC9A==
X-Gm-Message-State: AOJu0YzFtwKNByyFSdKcwDa4/HFbNukn/ybuNL2KC+prNa4hHKgxluvg
	RyDcdknN3eByZr5OJtyRhpcRzJVfitxi6Tfi
X-Google-Smtp-Source: AGHT+IGHvGbIHUanf59uebuLHxK0Mf8wYo1LAQ+TJu4XCcs4cO2oAHShFDEfKEaZvHIr64ATxK0Pcg==
X-Received: by 2002:a50:a695:0:b0:530:bd6b:7a94 with SMTP id e21-20020a50a695000000b00530bd6b7a94mr2781724edc.24.1697850012970;
        Fri, 20 Oct 2023 18:00:12 -0700 (PDT)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id cf15-20020a0564020b8f00b0053deb97e8e6sm2370344edb.28.2023.10.20.18.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 18:00:11 -0700 (PDT)
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
Subject: [PATCH bpf-next 0/5] exact states comparison for iterator convergence checks
Date: Sat, 21 Oct 2023 03:59:34 +0300
Message-ID: <20231021005939.1041-1-eddyz87@gmail.com>
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
Commit message for patch #1 describes a program that exhibits such
behavior.

This patch-set aims to fix iterator convergence logic by adding notion
of exact states comparison. Exact comparison does not rely on presence
of read or precision marks and thus is more strict.
As explained in commit message for patch #1 exact comparisons require
addition of speculative register bounds widening. The end result for
BPF verifier users could be summarized as follows:

(!) After this update verifier would reject programs that conjure an
    imprecise value on first loop iteration and use it as precise on
    a second (for iterator based loops).

I urge people to at least skim over the commit message for patch #1.

Patches are organized as follows:
- patch #1: introduces exact mode for states comparison and adds
  widening heuristic;
- patch #2: adds test-cases that demonstrate why the series is
  necessary;
- patch #3: extends patch #1 with a notion of state loop entries,
  these entries have to be tracked to correctly identify that
  different verifier states belong to the same states loop;
- patch #4: adds a test-case that demonstrates a program
  which requires loop entry tracking for correct verification;
- patch #5: just adds a few debug prints.

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

[1] https://lore.kernel.org/bpf/97a90da09404c65c8e810cf83c94ac703705dc0e.camel@gmail.com/

Eduard Zingerman (5):
  bpf: exact states comparison for iterator convergence checks
  selftests/bpf: tests with delayed read/precision makrs in loop body
  bpf: correct loop detection for iterators convergence
  selftests/bpf: test if state loops are detected in a tricky case
  bpf: print full verifier states on infinite loop detection

 include/linux/bpf_verifier.h                  |  16 +
 kernel/bpf/verifier.c                         | 440 ++++++++++++-
 tools/testing/selftests/bpf/progs/iters.c     | 620 ++++++++++++++++++
 .../selftests/bpf/progs/iters_task_vma.c      |   1 +
 4 files changed, 1043 insertions(+), 34 deletions(-)

-- 
2.42.0


