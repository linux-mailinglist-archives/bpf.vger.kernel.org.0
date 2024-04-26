Return-Path: <bpf+bounces-27935-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9B18B3C62
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 18:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 552B81F20FF9
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 16:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F3D14D433;
	Fri, 26 Apr 2024 16:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TPU4+B7W"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BB6148FE6;
	Fri, 26 Apr 2024 16:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714147535; cv=none; b=Oyn+kIazoRXlrhm8UJg+Z55hS4YbOrBBFbAWLvIa6KEB1PcAbZXYthuIPxTILVG+zHgm0hjO0QzC+OrTDPxACSUQl6D8WBaQ8lnrM87KomC8aawBLi8HwvJOXmtt5IQH705oX4SXIcOEONbxqa+wzE9gXfNtemmqPjI6g+OFTcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714147535; c=relaxed/simple;
	bh=pCmo0dT/Gsu+6RLe7nZNoKJbxPJXRUw66bKGetjoYIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Exi5UIhIrMXz3rK+Fz+Ybdm8+stcHLVCvF6Bq72jt2UCF+Pk8moAD8rGfedV05HJI7OtLaSd8VG03ghGX2xM5+MpXM0T96OKVjx8TtprFBh4Q0B7j8v9ZoeeWXdEI/Ow9ft/Tw8GZrwuQQxzzEELA2m+Aw3IiECscLoXoo5ub3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TPU4+B7W; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2a4df5d83c7so1665575a91.0;
        Fri, 26 Apr 2024 09:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714147533; x=1714752333; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AyIMrxnja/Bg703ebPVu+Brz/SLHCcvD3Jb/4/FNiPU=;
        b=TPU4+B7WYvpJMnXgmoMIoBaIvdwrGYarcFbXa+/hasklmGNCq5s8N9Nj9Tf2ukF6xs
         g7l2QVR5pYjA+UCBo7K08PTBluRbHjSZdQxTp8I+3VSwtGso3Qf1UZpNyu+Sab2yqEE4
         MwEilnkjesBjvu93sJ060xmh4ZkCgSZxJOlbNwesMiLxudBfQVdxbS3P9KiyxucywFu3
         mbcRkN5GP3mkE3QqAt8WdIFplY1BZwH6ScFPIuNV0vHb6DsNLqvo2eZ91J6GkIv3E6Xb
         U36vx/8JMXiUQmHRjT4DU/k0a5EAcAGerQ2qKG7qkt0VzTfB5R/3iQ+2MoKPwktWXSpd
         0a1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714147533; x=1714752333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AyIMrxnja/Bg703ebPVu+Brz/SLHCcvD3Jb/4/FNiPU=;
        b=lLVCCeuC0CKl4A0yrbXHbqJD+K68QMGD77an2tKeUSpPNA0gArVouk+Ci8muKC94Hx
         gVnGeKqK0BqnMXEvY23EdkXERrgnKyfLUEn4xaD/8vZrBUKq3CRYbFyumA7xzmqYE1B+
         oz98WR7GV/fLxFwbdjHgPrm4fqeSDXex9feyUJGdaQPKtK3Nzs+kRrzRL6GNtlOhkkbR
         dQFTSZP6dveXW7cUj6pJ2fWmoaQMdsnueyBTnWHo1mvqTIZqbvNW0ERQC8JCyI6KZsJu
         8LAz9GVWuIZMa4XIqLsuWvpHj2TONkQ+vcFywa/zssE676i714Hj0UQOF9jJbPX5E9pM
         1CTw==
X-Forwarded-Encrypted: i=1; AJvYcCVzxAkOtezQZqK6gprPUArK/qWuPpFCvhVSvFrXwsZhDHal6wVlhb+4QHyZbG/B3Rx/h+xVZPiCPs/giLw44FOwxl1vGyV1H5+n0Yl3/ozZHeKTpFwTUrniCMT9+uhokcTJKDfZuRGS
X-Gm-Message-State: AOJu0YwbWrHLyl2jZpbpRPkR0fy2eiMhJlVSFILNSjgcEtQSkdtzpVZN
	i5L6k5/tc3TrLXLvh4bgi3+VDzPyZZ6PHchSLSPRZLKf/kqGTQZJ8zZaCH1sWerS7KmR1t9VfB0
	1GeFjckr9UW0LgndEoA7ITzD9bhw=
X-Google-Smtp-Source: AGHT+IEHU2zZDgEuGFNLk6tA0ADcBtSjTNHwh8PQMPTnA+zJYoABysh6anb0FdLp0vLlKhPUxfTHV4bO+EQg3GE9uCM=
X-Received: by 2002:a17:90b:1d01:b0:2af:4a3f:df62 with SMTP id
 on1-20020a17090b1d0100b002af4a3fdf62mr3474508pjb.6.1714147533391; Fri, 26 Apr
 2024 09:05:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424215214.3956041-1-andrii@kernel.org> <20240426232539.faf453fb71e6af7017c7967b@kernel.org>
In-Reply-To: <20240426232539.faf453fb71e6af7017c7967b@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 26 Apr 2024 09:05:20 -0700
Message-ID: <CAEf4Bza43G3Yk9fngeh3AmZpnOu_yjSMp3oJrqK22cvRU6=DYA@mail.gmail.com>
Subject: Re: [PATCH 0/2] Objpool performance improvements
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	rostedt@goodmis.org, bpf@vger.kernel.org, 
	"wuqiang.matt" <wuqiang.matt@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 7:25=E2=80=AFAM Masami Hiramatsu <mhiramat@kernel.o=
rg> wrote:
>
> Hi Andrii,
>
> On Wed, 24 Apr 2024 14:52:12 -0700
> Andrii Nakryiko <andrii@kernel.org> wrote:
>
> > Improve objpool (used heavily in kretprobe hot path) performance with t=
wo
> > improvements:
> >   - inlining performance critical objpool_push()/objpool_pop() operatio=
ns;
> >   - avoiding re-calculating relatively expensive nr_possible_cpus().
>
> Thanks for optimizing objpool. Both looks good to me.

Great, thanks for applying.

>
> BTW, I don't intend to stop this short-term optimization attempts,
> but I would like to ask you check the new fgraph based fprobe
> (kretprobe-multi)[1] instead of objpool/rethook.

You can see that I did :) There is tons of code and I'm not familiar
with internals of function_graph infra, but you can see I did run
benchmarks, so I'm paying attention.

But as for the objpool itself, I think it's a performant and useful
internal building block, and we might use it outside of rethook as
well, so I think making it as fast as possible is good regardless.

>
> [1] https://lore.kernel.org/all/171318533841.254850.15841395205784342850.=
stgit@devnote2/
>
> I'm considering to obsolete the kretprobe (and rethook) with fprobe
> and eventually remove it. Those have similar feature and we should
> choose safer one.
>

Yep, I had a few more semi-ready patches, but I'll hold off for now
given this move to function graph, plus some of the changes that Jiri
is making in multi-kprobe code. I'll wait for things to settle down a
bit before looking again.

But just to give you some context, I'm an author of retsnoop tool, and
one of the killer features of it is LBR capture in kretprobes, which
is a tremendous help in investigating kernel failures, especially in
unfamiliar code (LBR allows to "look back" and figure out "how did we
get to this condition" after the fact). And so it's important to
minimize the amount of wasted LBR records between some kernel function
returns error (and thus is "an interesting event" and BPF program that
captures LBR is triggered). Big part of that is ftrace/fprobe/rethook
infra, so I was looking into making that part as "minimal" as
possible, in the sense of eliminating as many function calls and jump
as possible. This has an added benefit of making this hot path faster,
but my main motivation is LBR.

Anyways, just a bit of context for some of the other patches (like
inlining arch_rethook_trampoline_callback).

> Thank you,
>
> >
> > These opportunities were found when benchmarking and profiling kprobes =
and
> > kretprobes with BPF-based benchmarks. See individual patches for detail=
s and
> > results.
> >
> > Andrii Nakryiko (2):
> >   objpool: enable inlining objpool_push() and objpool_pop() operations
> >   objpool: cache nr_possible_cpus() and avoid caching nr_cpu_ids
> >
> >  include/linux/objpool.h | 105 +++++++++++++++++++++++++++++++++++--
> >  lib/objpool.c           | 112 +++-------------------------------------
> >  2 files changed, 107 insertions(+), 110 deletions(-)
> >
> > --
> > 2.43.0
> >
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

