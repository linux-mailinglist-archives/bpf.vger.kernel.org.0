Return-Path: <bpf+bounces-46442-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D17159EA3EF
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 01:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B562F18826CD
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 00:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582D32EB10;
	Tue, 10 Dec 2024 00:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/2URD3y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9D23C0C;
	Tue, 10 Dec 2024 00:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733792112; cv=none; b=BW8yl4qq1AqrZdDZYSpxG0gHvQ8IXZV1Qo7PbswGy6yIO9kSK4sqPYLMXD4uRF0/WwYYT6ZXydc3hOzFO7TDNcksL+8Y8aLQFMQ0A0OUPKXXFLwg5ZSZ64iMM7lyWLLyyskdAAfkdk+R5SqzFP6/OqhxyMYc4/mtsKy5YBckrEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733792112; c=relaxed/simple;
	bh=boq/ye7PO9PoIgAzqFV+pTvqHtk4MpiX+xbOXYpT+I4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F6YJ7S2AyPOH9qCDdKyetdajSlgi7MWMTkxhB5jON1bnyrTJEdqikPWgmHV9w3EJ/+qNjV5Viy9uSovgwwXRY/PSIuTby5X8MjFj/s/4K2ALg/o6CmYIgW4ogVZl+Ipcl4vQBg1rYdjgsxTuc+bdrZ8DMATmsxzC71spCUlTAKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e/2URD3y; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-385e2880606so4122614f8f.3;
        Mon, 09 Dec 2024 16:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733792109; x=1734396909; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=boq/ye7PO9PoIgAzqFV+pTvqHtk4MpiX+xbOXYpT+I4=;
        b=e/2URD3ytBA6g1LKirtTsE9u16omVlM4FaVjd3GzC1WYzZSb8L4pV79HjzZyYkFeFl
         mhX+rCJBUdyQ7+WlCzqIIbUqnXg64sL47+JAstUfzWCwIBYxNNopo5EQeFN70tMWj4Wd
         kUMEytE/Pvr60Dw8WZubsqNr5s65XEZ/grygK7c/5JYIwp0KC/1jXm3xLGJAZvadnzqy
         +flP0chsDM2AJqqwJxwKqQ0ntSzjFp3HdkjXhiNMEX1dfuN60rGaI/bcFqzKjN51WWvd
         5V4i1Uo7GtzOPwgkgTJvA5/HdWUMGY1vuQ2uslkzwPUfR/7EhWyVPlT9gPCGRJkE+5O+
         AGcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733792109; x=1734396909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=boq/ye7PO9PoIgAzqFV+pTvqHtk4MpiX+xbOXYpT+I4=;
        b=ZW5ik024QiUGyFOEwnWyGzJoBbGskL8nwehE7wI/KQW7OscR7hMqD23OJe+tC7VMt3
         mwqofUVLKFP9nvOQyV/AJ2Ib6bISDw9Hx9/gsamAyDYSTAhq72G8rMknLf6PQWev5hU0
         NQeVZ3KdkwOyeYwnlLldj8K0r41BcwIfz0Ywwhp/pab83ZfYD1PWA9qY9XNztZEfsyn8
         vHQCl8hRsrGhnPjV8to/fwCSL0ta2Cxn11P3UiNhx8y4Aj714GpB5QUCnq3jJi6hshlA
         iTXlzha8QkzGrkoYRYlCY3KE65nby8gXZFIO61tkNo+NuXOWUscBiskjNQVvLl6ZsEji
         CTvg==
X-Forwarded-Encrypted: i=1; AJvYcCX552uri6c5tanuUnpaPUa9Db24Z/BHfnmBmGjGABygRd52R9DTgcSawf9H0j6sUqzcGg+/Vx7qv4NZF66N@vger.kernel.org, AJvYcCXNQWxLg2O1lgf8yd3zraksVLfgeTP62+u5nmtLnq+0aAVj1bpBlVfPr5zRoE705rmCfV8=@vger.kernel.org, AJvYcCXQ8IRJIQjLKRvmseP9/t/Z+QnAgJJMKC/FSYE552/V31AWh+ciRFQ1t6r5KbzNSPGjQtPDhIKs@vger.kernel.org, AJvYcCXZ9144oMc2vBBlK0r3LurzZ1Ehh4GbtTF+eC2x8iLLGRloq/MKo/4gBcrqzkweYU6LAKoOFTr4zJTG4X99hcc4XgIu@vger.kernel.org
X-Gm-Message-State: AOJu0YwG+qxEJmu5fDKRiuLMA/8ZmOOAM6KEb7/DGDF7GPCoqsMTcJuF
	Gvn7X0fUIZ75P9kR5JeSC14/84P4Dpxo5sCPx90pZ5g0187iYdmPPW6vJQmvKYnWG5zoyzLGLRt
	z1H6uR5cQTG6PF17kbP2ynLXKegA=
X-Gm-Gg: ASbGncuipN86jIRKpjljilfUpzu58YP91g8koQ3m6Ml/U9iJUrTNEESwS8CYaS5+ixj
	ywBzHE3baks6T/Aycs0AbQtIOZXCr8+PiA3Mv7Kmv8zk73QNVaak=
X-Google-Smtp-Source: AGHT+IG8axsEndvXuoPkC8p+vwh99ZMJK/1WzuRhn68RFvJiGxFaSRJKeeUzI7NxPzu+eY7U5xB7avCHwEO3py1fnMk=
X-Received: by 2002:a05:6000:1868:b0:385:fd24:3317 with SMTP id
 ffacd0b85a97d-386453cf868mr2754572f8f.1.1733792109319; Mon, 09 Dec 2024
 16:55:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206-bpf-fix-uprobe-uaf-v2-1-4c75c54fe424@google.com>
 <CAEf4BzYxaKd8Gv5g8PBY6zaQukYKSjjtaSgYMjJxL-PZ0dLrbQ@mail.gmail.com>
 <CAG48ez3i5haHCc8EQMVNjKnd9xYwMcp4sbW_Y8DRpJCidJotjw@mail.gmail.com>
 <CAEf4BzYkGQ0sw9JEeAMLAfcQbzxwg46c487kBD_LcbZSaTKD5Q@mail.gmail.com>
 <CAG48ez1LRsuew4y_KQxPHNipA68hhm+iJohHbk6=1cwv5QPCxQ@mail.gmail.com>
 <CAG48ez2+3TTbWNNO4aqxFAX8Cd4COaayRxoy1V2xvM9oS2_ygQ@mail.gmail.com>
 <CAEf4BzbhDkFq9DB2VKxsHmffynQBvbD_RVKTUm3zCqvO_e1dug@mail.gmail.com>
 <CAG48ez2LW9zyiptNq8jApD3zeS05wvNPs-jj2zOeaCDQbZnD4g@mail.gmail.com>
 <CAEf4BzbVqfWZUJUkUwJvfaGViwiP8cnVAYAWX67LP-ejPvmAPA@mail.gmail.com> <CAEf4BzbzXT6e-dKtxr6SDzekXC+Zu45uX10dL+DuTA8Xn=cgjw@mail.gmail.com>
In-Reply-To: <CAEf4BzbzXT6e-dKtxr6SDzekXC+Zu45uX10dL+DuTA8Xn=cgjw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 9 Dec 2024 16:54:57 -0800
Message-ID: <CAADnVQJ9grJJs4s_eBBk7iL136FNKt3ahhaLLDo1igrBBscxYA@mail.gmail.com>
Subject: Re: [PATCH bpf v2] bpf: Fix prog_array UAF in __uprobe_perf_func()
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jann Horn <jannh@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Delyan Kratunov <delyank@fb.com>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 2:45=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> Ok, weeding through the perf/uprobe plumbing for BPF, I think we avoid
> this problem with uprobe BPF link because uprobe_unregister_sync()
> waits for RCU Tasks Trace GP, and so once we finish uprobe
> unregistration, we have a guarantee that there is no more uprobe that
> might dereference our BPF program. (I might have thought about this
> problem when fixing BPF link for sleepable tracepoints, but I missed
> the legacy perf_event attach/detach case).
>
> With legacy perf event perf_event_detach_bpf_prog() we don't do any of
> that, we just NULL out pointer and do bpf_prog_put(), not caring
> whether this is uprobe, kprobe, or tracepoint...
>
> So one way to solve this is to either teach
> perf_event_detach_bpf_prog() to delay bpf_prog_put() until after RCU
> Tasks Trace GP (which is what we do with bpf_prog_array, but not the
> program itself),

since this is a legacy prog detach api I would just add sync_rcu_tt
there. It's a backportable one line change.

> or add prog->aux->sleepable_hook flag in addition to
> prog->aux->sleepable, and then inside bpf_prog_put() check
> (prog->aux->sleepable || prog->aux->sleepable_hook) and do RCU Tasks
> Trace delay (in addition to normal call_rcu()).

That sounds like more work and if we introduce sleepable_hook
we would better generalize it and rely on it everywhere.
Which makes it even more work and certainly not for stable.

> Third alternative would be to have something like
> bpf_prog_put_sleepable() (just like we have
> bpf_prog_array_free_sleepable()), where this would do additional
> call_rcu_tasks_trace() even if BPF program itself isn't sleepable.

Sounds like less work than 2, but conceptually it's the same as 1.
Just call_rcu_tt vs sync_rcu_tt.
And we can wait just fine in that code path.
So I'd go with 1.

