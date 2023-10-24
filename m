Return-Path: <bpf+bounces-13110-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC05D7D4727
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 07:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1194F1C20B87
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 05:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00CC3CA51;
	Tue, 24 Oct 2023 05:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OoJ0woO+"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E6020F7
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 05:59:04 +0000 (UTC)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB12C0
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 22:59:03 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-507d7b73b74so5954337e87.3
        for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 22:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698127141; x=1698731941; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Gw+ecEsfLZ2dRrkCAFNiqKLqAZ4kEnwvk/XE6DPyIE=;
        b=OoJ0woO+AxAA4/0Mx/WtL+YllXFvDdQzvQf00z4T5EBWin5/ZCfx2wY3/1to08Jum7
         RZK4VXC0uZ5+zQ2xr9N7WH3Yor80wyW6+c3UQHZuMQkN2GJ7fgZIHOW0+wlRzjvulnXx
         mfV54UvMk/Kww8Kx2aJY67tLvTAdRAnW8RdaZN0R+QukvwjehMSkN7bFZMFi7g9rbeSB
         eZQaJIxMZShgrAutfinD+9ZnZE81eBhPBMWjicpIoX99340EBAnAjhH7sGY6oRfeGflf
         cU0+Ji7Sq9JGhNc8ZGKRtFarX0Xi5oiu/vxa7LehHWn7FuVtykELmz3L4A2vdij5LFJn
         zmRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698127141; x=1698731941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Gw+ecEsfLZ2dRrkCAFNiqKLqAZ4kEnwvk/XE6DPyIE=;
        b=lIZPy56kjnRmhoH5loKGHAY6yihD41aHaguR6MR9N6+lrcB+kbS5x+jHR2aWJyqmiT
         Nz58GTf3IYis4WvOVeBJ0sYctJ0RcT+X8ZEpJQr59hTaCvHnHdNdxM86h871oIQ1VL8a
         usyAiy/YhHzQ4Bwiaiimfb2uCp+hNNGA09t+BufnDf/12kp2vSSm0R4E0FHvQOFJeYzn
         t0W3VN3IduwK7iAMdlL0WGSJfJPzFrEs+Q7LDmsoWWhi39bBwG54TMDZqI8AJJ01BEpx
         E4h/gkTdwD/9stBSYoqlG+Tv3R3888evc+HloXa9u5OyI1CjLz5xmdpoAQfh8crpXLoG
         7rmA==
X-Gm-Message-State: AOJu0YylMh20fFVS19rrIN/VFLC+ows+EQykXuBzDOa4tEBi7xDn4whG
	9Ffe0lD8iQrJvhHR98srdCM7a6UNEN89dMIYgUNJW+8c
X-Google-Smtp-Source: AGHT+IHmwdMy9e7mOlwH1y9HDSCCA3fzGR7ChAIiSS6xYI2wYz8qrJMXc0BnAWsv/baLkn2EoztCdgfZB5cxh3GbaS4=
X-Received: by 2002:a19:504c:0:b0:504:7e90:e05b with SMTP id
 z12-20020a19504c000000b005047e90e05bmr7876881lfj.14.1698127141157; Mon, 23
 Oct 2023 22:59:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231024000917.12153-1-eddyz87@gmail.com>
In-Reply-To: <20231024000917.12153-1-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 23 Oct 2023 22:58:49 -0700
Message-ID: <CAEf4BzZKBq+nJdcUyD4_UcU1joojzuaHDaVp1Tb=MfXyUu-MLg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/7] exact states comparison for iterator
 convergence checks
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, memxor@gmail.com, awerner32@gmail.com, 
	john.fastabend@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 5:09=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> Iterator convergence logic in is_state_visited() uses state_equals()
> for states with branches counter > 0 to check if iterator based loop
> converges. This is not fully correct because state_equals() relies on
> presence of read and precision marks on registers. These marks are not
> guaranteed to be finalized while state has branches.
> Commit message for patch #3 describes a program that exhibits such
> behavior.
>
> This patch-set aims to fix iterator convergence logic by adding notion
> of exact states comparison. Exact comparison does not rely on presence
> of read or precision marks and thus is more strict.
> As explained in commit message for patch #3 exact comparisons require
> addition of speculative register bounds widening. The end result for
> BPF verifier users could be summarized as follows:
>
> (!) After this update verifier would reject programs that conjure an
>     imprecise value on the first loop iteration and use it as precise
>     on the second (for iterator based loops).
>
> I urge people to at least skim over the commit message for patch #3.
>
> Patches are organized as follows:
> - patches #1,2: moving/extracting utility functions;
> - patch #3: introduces exact mode for states comparison and adds
>   widening heuristic;
> - patch #4: adds test-cases that demonstrate why the series is
>   necessary;
> - patch #5: extends patch #3 with a notion of state loop entries,
>   these entries have to be tracked to correctly identify that
>   different verifier states belong to the same states loop;
> - patch #6: adds a test-case that demonstrates a program
>   which requires loop entry tracking for correct verification;
> - patch #7: just adds a few debug prints.
>
> The following actions are planned as a followup for this patch-set:
> - implementation has to be adapted for callbacks handling logic as a
>   part of a fix for [1];
> - it is necessary to explore ways to improve widening heuristic to
>   handle iters_task_vma test w/o need to insert barrier_var() calls;
> - explored states eviction logic on cache miss has to be extended
>   to either:
>   - allow eviction of checkpoint states -or-
>   - be sped up in case if there are many active checkpoints associated
>     with the same instruction.
>
> The patch-set is a followup for mailing list discussion [1].
>
> Changelog:
> - V2 [3] -> V3:
>   - correct check for stack spills in widen_imprecise_scalars(),
>     added test case progs/iters.c:widen_spill to check the behavior
>     (suggested by Andrii);
>   - allow eviction of checkpoint states in is_state_visited() to avoid
>     pathological verifier performance when iterator based loop does not
>     converge (discussion with Alexei).
> - V1 [2] -> V2, applied changes suggested by Alexei offlist:
>   - __explored_state() function removed;
>   - same_callsites() function is now used in clean_live_states();
>   - patches #1,2 are added as preparatory code movement;
>   - in process_iter_next_call() a safeguard is added to verify that
>     cur_st->parent exists and has expected insn index / call sites.
>
> [1] https://lore.kernel.org/bpf/97a90da09404c65c8e810cf83c94ac703705dc0e.=
camel@gmail.com/
> [2] https://lore.kernel.org/bpf/20231021005939.1041-1-eddyz87@gmail.com/
> [3] https://lore.kernel.org/bpf/20231022010812.9201-1-eddyz87@gmail.com/
>
> Eduard Zingerman (7):
>   bpf: move explored_state() closer to the beginning of verifier.c
>   bpf: extract same_callsites() as utility function
>   bpf: exact states comparison for iterator convergence checks
>   selftests/bpf: tests with delayed read/precision makrs in loop body
>   bpf: correct loop detection for iterators convergence
>   selftests/bpf: test if state loops are detected in a tricky case
>   bpf: print full verifier states on infinite loop detection
>
>  include/linux/bpf_verifier.h                  |  16 +
>  kernel/bpf/verifier.c                         | 475 ++++++++++--
>  tools/testing/selftests/bpf/progs/iters.c     | 695 ++++++++++++++++++
>  .../selftests/bpf/progs/iters_task_vma.c      |   1 +
>  4 files changed, 1133 insertions(+), 54 deletions(-)
>
> --
> 2.42.0
>

Thanks a lot for working on this and getting it to the end despite
many setbacks and ambiguity, great work!

