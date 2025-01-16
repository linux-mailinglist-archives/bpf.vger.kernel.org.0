Return-Path: <bpf+bounces-49133-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1FAA146A8
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 00:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90B6B188D7AF
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 23:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF511F91D8;
	Thu, 16 Jan 2025 23:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aLCGqzfV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E2C1F91D4
	for <bpf@vger.kernel.org>; Thu, 16 Jan 2025 23:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737070659; cv=none; b=B20pPvWEZJxbq9DuGfWncY8OYYCVmD/+wkM6tntdjb0dX0k8zG8Bdjw/o4cj5q3ocjOApcsz6Cx4jkK7q8jWPTbH9f5AQmFSCAABlvT/r/pGcX6DSrt2hMDufXzwTl2YaYJLtU27EZqQpSWZAych4wqsOlKhRwAQVl9yG0IDE3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737070659; c=relaxed/simple;
	bh=NYBBOyltDyMIxB4ibD7jO32wOKX6gC2TzK6sgRymbPo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JQ3r2cIrSGf1Z2Jt0ZHLI6NPRgBqNReeSCFQsIycWdrY5VsIedZNtC7RD9MrmMaWoe1bIYzWq5t4Xrt37IiiTEh6PKQQixgR6STZrN2S5NOzjfnuVnFp3ln01ut2G6TXqt8zs69Kvqz/8Qp4/ef2H0DkiZ8kM7Tr7xgODiv2ycU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aLCGqzfV; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2f441791e40so2166735a91.3
        for <bpf@vger.kernel.org>; Thu, 16 Jan 2025 15:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737070657; x=1737675457; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bctk0HgKod5KRdU4XMl0eha7XAoEwgXzqLZsJyPMs7o=;
        b=aLCGqzfVcqr0QxGE+hTPkajs9HzVwvNUD8hOwzhzg40bxmXyudKn5egRmdjr4uu1DV
         cUDLOALzV79cqYUZxc2SY/yqrsQm3pvdn1AyBodOslAbAVgUKVtuCRGA/6UzKLUvK4RG
         IZ0JVfHIHIotYcaTVj4dWEnMXeQd1bLmu4XGIBnRR3FBpvBdat0ZqtTRMJz24hmHBHQD
         fDU84KvfxR0PyHnzDGOBsDjrZ1KbS7eUyfXWaQ/ATb2CfJzXghLKlQ35ATX0ITplzS7j
         nnvXZ9Owj4j9eVwTf4Buspe6Pepd07cgku6MBo5nNC2zDbLlcBDtTXmlZu3rBYtBWkCk
         gnpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737070657; x=1737675457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bctk0HgKod5KRdU4XMl0eha7XAoEwgXzqLZsJyPMs7o=;
        b=iPo6Eta79Aq/efVKFRC4AbI5zr4P6aUSUVJVxJQcm7nblKB+PzitftWKNJus+v2cS8
         niPAWtNmKAKIAm5rerwRqSYmz/D0yCjwFz4A2hSJ6g1IXLmMvN2h4UG/zg33ANGcnp49
         mU8BtGgO4EVnHnFCpi1YsKNrZZ6HsVJXu7N12mkP4p7ODiq5Q22uGUo2MEykoazkz00h
         hioqACUoTTdJFgk4zyHIWF+ZcnJuJg1W4PZI0vzFxvjD9WYhpRhLBq8QDbIlftzg7PVQ
         0485B4ZApAkpTdohwdcSWH6xH26RUAmCHdS+qZUOBaww/qeDMHqPrN5ujTOSjoGcu+6n
         5LMQ==
X-Gm-Message-State: AOJu0YyiOJ9w9EvupB7YdITL/eXcJqx0rlYiMYGQMHRrU9nbQNJ/1Uqq
	EpJCEdK1HBwCxQ7Z2EhaFLo+BmLnOHcLAOcde88HETqeAHrpsfgi4lU6URXfQWdX6NDQUbx7d8c
	ppgRLHU6vXh+xtuUUDc8ZKgTYWu4=
X-Gm-Gg: ASbGncswF5glefQdqt49cFFHW8LTa1YXMYPzUfyfH3amXNyAsf14mxXNwpWupFAZR1N
	SKYKZkUWOUYhS1MwmqaDnetYt2GBHWUzFkiWz
X-Google-Smtp-Source: AGHT+IGuUt9TGsMNgoO2yIhWHm4GYmkqF/yP2B1lcjDA/HZiW2/JxogH4mkQwTJkBFa0GMfovO9wrRqPzDh+In+i7ho=
X-Received: by 2002:a17:90a:c890:b0:2ee:cd83:8fe7 with SMTP id
 98e67ed59e1d1-2f782d9ee9amr616893a91.35.1737070657334; Thu, 16 Jan 2025
 15:37:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250113152437.67196-1-leon.hwang@linux.dev> <20250113152437.67196-2-leon.hwang@linux.dev>
 <CAEf4BzahZ04K5LDaqaToJnQ9yvRZ48yh-2+ywsKRgcj8whMheA@mail.gmail.com> <9872244c-0e3b-4e83-be1d-1503f7b086e6@linux.dev>
In-Reply-To: <9872244c-0e3b-4e83-be1d-1503f7b086e6@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 16 Jan 2025 15:37:25 -0800
X-Gm-Features: AbW1kvYqWTSWYYWDJkzGy4wtn1w8afyMXhkIz2cKBmf6zzIAg0y4uf_QjdN3kzw
Message-ID: <CAEf4BzaBXuztqhvAxPGi6nzebMVifx2cU1iFQqEo_GwF3z-ADg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 1/2] bpf: Introduce global percpu data
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, yonghong.song@linux.dev, song@kernel.org, 
	eddyz87@gmail.com, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 11:22=E2=80=AFPM Leon Hwang <leon.hwang@linux.dev> =
wrote:
>
> Hi,
>
> On 15/1/25 07:10, Andrii Nakryiko wrote:
> > On Mon, Jan 13, 2025 at 7:25=E2=80=AFAM Leon Hwang <leon.hwang@linux.de=
v> wrote:
> >>
> >> This patch introduces global per-CPU data, inspired by commit
> >> 6316f78306c1 ("Merge branch 'support-global-data'"). It enables the
> >> definition of global per-CPU variables in BPF, similar to the
> >> DEFINE_PER_CPU() macro in the kernel[0].
> >>
> >> For example, in BPF, it is able to define a global per-CPU variable li=
ke
> >> this:
> >>
> >> int percpu_data SEC(".data..percpu");
> >>
> >> With this patch, tools like retsnoop[1] and bpflbr[2] can simplify the=
ir
> >> BPF code for handling LBRs. The code can be updated from
> >>
> >> static struct perf_branch_entry lbrs[1][MAX_LBR_ENTRIES] SEC(".data.lb=
rs");
> >>
> >> to
> >>
> >> static struct perf_branch_entry lbrs[MAX_LBR_ENTRIES] SEC(".data..perc=
pu.lbrs");
> >>
> >> This eliminates the need to retrieve the CPU ID using the
> >> bpf_get_smp_processor_id() helper.
> >>
> >> Additionally, by reusing global per-CPU variables, sharing information
> >> between tail callers and callees or freplace callers and callees becom=
es
> >> simpler compared to using percpu_array maps.
> >>
> >> Links:
> >> [0] https://github.com/torvalds/linux/blob/fbfd64d25c7af3b8695201ebc85=
efe90be28c5a3/include/linux/percpu-defs.h#L114
> >> [1] https://github.com/anakryiko/retsnoop
> >> [2] https://github.com/Asphaltt/bpflbr
> >>
> >> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> >> ---
> >>  kernel/bpf/arraymap.c  |  39 +++++++++++++-
> >>  kernel/bpf/verifier.c  |  45 +++++++++++++++++
> >>  tools/lib/bpf/libbpf.c | 112 ++++++++++++++++++++++++++++++++--------=
-
> >>  3 files changed, 171 insertions(+), 25 deletions(-)
> >>
> >
> > So I think the feature overall makes sense, but we need to think
> > through at least libbpf's side of things some more. Unlike .data,
> > per-cpu .data section is not mmapable, and so that has implication on
> > BPF skeleton and we should make sure all that makes sense on BPF
> > skeleton side. In that sense, per-cpu global data is more akin to
> > struct_ops initialization image, which can be accessed by user before
> > skeleton is loaded to initialize the image.
> >
> > There are a few things to consider. What's the BPF skeleton interface?
> > Do we expose it as single struct and use that struct as initial image
> > for each CPU (which means user won't be able to initialize different
> > CPU data differently, at least not through BPF skeleton facilities)?
> > Or do we expose this as an array of structs and let user set each CPU
> > data independently?
> >
> > I feel like keeping it simple and having one image for all CPUs would
> > cover most cases. And users can still access the underlying
> > PERCPU_ARRAY map if they need more control.
>
> Agree. It is necessary to keep it simple.
>
> >
> > But either way, we need tests for skeleton, making sure we NULL-out
> > this per-cpu global data, but take it into account before the load.
> >
> > Also, this huge calloc for possible CPUs, I'd like to avoid it
> > altogether for the (probably very common) zero-initialized case.
>
> Ack.
>
> >
> > So in short, needs a bit of iteration to figure out all the
> > interfacing issues, but makes sense overall. See some more low-level
> > remarks below.
> >
>
> It is challenging to figure out them. I'll do my best to achieve it.
>
> > pw-bot: cr
> >
> >

[...]

> >
> >> @@ -516,6 +516,7 @@ struct bpf_struct_ops {
> >>  };
> >>
> >>  #define DATA_SEC ".data"
> >> +#define PERCPU_DATA_SEC ".data..percpu"
> >
> > I don't like this prefix, even if that's what we have in the kernel.
> > Something like just ".percpu" or ".percpu_data" or ".data_percpu" is
> > better, IMO.
>
> I tested ".percpu". It is OK to use it. But we have to update "bpftool
> gen" too, which relies on these section names.
>
> Is it better to keep ".data" prefix, like ".data.percpu", ".data_percpu"?
> Can keeping ".data" prefix reduce some works on bpftool, go-ebpf and
> akin bpf loaders?

It's literally two lines of code in gen.c, and that should actually be
a common array of known prefixes. Even if someone uses this new
.percpu section with old bpftool nothing will break, they just won't
have structure representing the initial per-CPU image. They will still
have the generic map pointer in the skeleton. So I think this is
acceptable.

I'd definitely go with a simple and less error-prone ".percpu" prefix.

[...]

