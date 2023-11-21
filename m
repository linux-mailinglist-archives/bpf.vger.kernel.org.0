Return-Path: <bpf+bounces-15566-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 787097F3548
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 18:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0831CB21A62
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 17:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1BE20DE4;
	Tue, 21 Nov 2023 17:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ElJNPp0P"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960EBE8
	for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 09:49:31 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40859c464daso27091945e9.1
        for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 09:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700588970; x=1701193770; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hL0M/HYGAdMcoY2+sgoCiKuBHOeQ87xoIjI/fSPPn7Y=;
        b=ElJNPp0P/e2HG5sh9LNDPD+nv5z0Q9TItWEGsGyScbwK186SHpDnBHnpZSbkp/QOjD
         S1OOaTrw3gvpmQteyqgtTcfF4FdWGCCkz5cMz78py6eUigG/T4jcAgWz20sPPStPt8Jx
         7I+RAJ+hq3oIof62hBuSrduUWaamje1QvLiPLmSL8AsGT5mMqIUJ1b9zFC4T6oDpdJU1
         92e+5JuqrYq1+FrNhHEZnLbiVcg6G5ExW8gLHDjZdGGfgFEmHyXohziPmWcw0lKNgoVT
         yqgt8AejxdPJWDooepfvh2rKL0EoW5V7kaiyAmuo3FmN5qU0zh4WxOKMlBrgiRvvCP6Y
         FzGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700588970; x=1701193770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hL0M/HYGAdMcoY2+sgoCiKuBHOeQ87xoIjI/fSPPn7Y=;
        b=Y1p1ZbytBvd5VGE1ku7S1w8PLBzcFWl4UkJbhwZ7JzaIhrY0rICHY8OEC6pFIYDcRq
         OQK0fgJcbDpcbx33K/XkFxr7iG9ed29EIaF6RhpdF6ZGcFgkuEvZA2o+UJLFTvRAidWQ
         GMYPKK6r5xNh4odI47zXbD+Y+0Fh4La3rZE0QKzoDBYsnRA1jUdDGNW8HQ93A4X2/JrX
         dcp4/3eFvU5wMJI5llBziKVWn+XNtPAOf6enmv4YGSarbhUA9GdUwInYWp0bxY2ezbIV
         +lFfWtj8Qi8OuMIYlSqBPXXNxGLzW79C+0fLfnr4M63+ebiqHdbez2XUDw/gVcO64cQN
         sI+Q==
X-Gm-Message-State: AOJu0YzN2XJojcboFhxyY35r7IGIwmSnHlwu7Gy6LEJJ7ZnFQpJbS0OF
	PLcwuJb9hQaMbduP4eX6U/70RasNs5WREoaD3ek=
X-Google-Smtp-Source: AGHT+IFe4+zRdBIoVKjutM1Ocoz3YLCvruhs0F4MzQeTnM6nCkjlTi7vzBwiIJ9alt2TjicBB29xE0u24TjvXTIrwIM=
X-Received: by 2002:a05:600c:1991:b0:405:82c0:d9d9 with SMTP id
 t17-20020a05600c199100b0040582c0d9d9mr41011wmq.41.1700588969650; Tue, 21 Nov
 2023 09:49:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231113123324.3914612-1-houtao@huaweicloud.com>
 <20231113123324.3914612-5-houtao@huaweicloud.com> <20231121051917.lbp6luone7pxqkvw@macbook-pro-49.dhcp.thefacebook.com>
 <96e07186-d497-8e41-edcd-a106bf87a548@huaweicloud.com>
In-Reply-To: <96e07186-d497-8e41-edcd-a106bf87a548@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 21 Nov 2023 09:49:18 -0800
Message-ID: <CAADnVQK=tJRhQY1zfLK2n7_tPA5+vN8+KqWmSLqjubUuh6UFAw@mail.gmail.com>
Subject: Re: [PATCH bpf v2 4/5] bpf: Optimize the free of inner map
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Hou Tao <houtao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 20, 2023 at 10:45=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> w=
rote:
>
> Hi Alexei,
>
> On 11/21/2023 1:19 PM, Alexei Starovoitov wrote:
> > On Mon, Nov 13, 2023 at 08:33:23PM +0800, Hou Tao wrote:
> >> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> >> index e2d2701ce2c45..5a7906f2b027e 100644
> >> --- a/kernel/bpf/syscall.c
> >> +++ b/kernel/bpf/syscall.c
> >> @@ -694,12 +694,20 @@ static void bpf_map_free_deferred(struct work_st=
ruct *work)
> >>  {
> >>      struct bpf_map *map =3D container_of(work, struct bpf_map, work);
> >>      struct btf_record *rec =3D map->record;
> >> +    int acc_ctx;
> >>
> >>      security_bpf_map_free(map);
> >>      bpf_map_release_memcg(map);
> >>
> >> -    if (READ_ONCE(map->free_after_mult_rcu_gp))
> >> -            synchronize_rcu_mult(call_rcu, call_rcu_tasks_trace);
> > The previous patch 3 is doing too much.
> > There is maybe_wait_bpf_programs() that will do synchronize_rcu()
> > when necessary.
> > The patch 3 could do synchronize_rcu_tasks_trace() only and it will sol=
ve the issue.
>
> I didn't follow how synchronize_rcu() in maybe_wait_bpf_programs() will
> help bpf_map_free_deferred() to defer the free of inner map. Could you
> please elaborate on that ? In my understanding, bpf_map_update_value()
> invokes maybe_wait_bpf_programs() after the deletion of old inner map
> from outer map completes. If the ref-count of inner map in the outer map
> is the last one, bpf_map_free_deferred() will be called when the
> deletion completes, so maybe_wait_bpf_programs() will run concurrently
> with bpf_map_free_deferred().

The code was quite different back then.
See commit 1ae80cf31938 ("bpf: wait for running BPF programs when
updating map-in-map")
that was added to specifically address the case where bpf prog is
looking at the old inner map.
The commit log talks about a little bit of a different issue,
but the end result was the same. It prevented UAF since map free
logic was waiting for normal RCU GP back then.
See this comment:
void bpf_map_fd_put_ptr(void *ptr)
{
        /* ptr->ops->map_free() has to go through one
         * rcu grace period by itself.
         */
        bpf_map_put(ptr);
}

that code was added when map-in-map was introduced.

Also see this commit:
https://lore.kernel.org/bpf/20220218181801.2971275-1-eric.dumazet@gmail.com=
/

In cases of batched updates (when multiple inner maps are deleted from
outer map) we should not call sync_rcu for every element being
deleted.
The introduced latency can be bad.

I guess maybe_wait_bpf_programs() was too much brute force.
It would call sync_rcu() regardless whether refcnt dropped to zero.
It mainly cares about user space assumptions.
This patch 3 and 4 will wait for sync_rcu only when refcnt=3D=3D0,
so it should be ok.

Now we don't have 'wait for rcu gp' in map_free, so
maybe_wait_bpf_programs() is racy as you pointed out.
bpf_map_put() will drop refcnt of inner map and it might proceed into
bpf_map_free_deferred()->*_map_free() while bpf prog is still observing
a pointer to that map.

We need to adjust a comment in maybe_wait_bpf_programs() to say
it will only wait for non-sleepable bpf progs.
Sleepable might still see 'old' inner map after syscall map_delete
returns to user space.


> >
> >> +    acc_ctx =3D atomic_read(&map->may_be_accessed_prog_ctx) & BPF_MAP=
_ACC_PROG_CTX_MASK;
> >> +    if (acc_ctx) {
> >> +            if (acc_ctx =3D=3D BPF_MAP_ACC_NORMAL_PROG_CTX)
> >> +                    synchronize_rcu();
> >> +            else if (acc_ctx =3D=3D BPF_MAP_ACC_SLEEPABLE_PROG_CTX)
> >> +                    synchronize_rcu_tasks_trace();
> >> +            else
> >> +                    synchronize_rcu_mult(call_rcu, call_rcu_tasks_tra=
ce);
> > and this patch 4 goes to far.
> > Could you add sleepable_refcnt in addition to existing refcnt that is i=
ncremented
> > in outer map when it's used by sleepable prog and when sleepable_refcnt=
 > 0
> > the caller of bpf_map_free_deferred sets free_after_mult_rcu_gp.
> > (which should be renamed to free_after_tasks_rcu_gp).
> > Patch 3 is simpler and patch 4 is simple too.
> > No need for atomic_or games.
> >
> > In addition I'd like to see an extra patch that demonstrates this UAF
> > when update/delete is done by syscall bpf prog type.
> > The test case in patch 5 is doing update/delete from user space.
>
> Do you mean update/delete operations on outer map, right ? Because in
> patch 5, inner map is updated from bpf program instead of user space.

patch 5 does:
bpf_map_update_elem(inner_map,...

That's only to trigger UAF.
We need a test that does bpf_map_update_elem(outer_map,...
from sleepable bpf prog to make sure we do _not_ have a code in
the kernel that synchronously waits for RCU tasks trace GP at that time.

So, you're correct, maybe_wait_bpf_programs() is not sufficient any more,
but we cannot delete it, since it addresses user space assumptions
on what bpf progs see when the inner map is replaced.

I still don't like atomic_or() logic and masks.
Why not to have sleepable_refcnt and
if (sleepable_refcnt > 0)
  synchronize_rcu_mult(call_rcu, call_rcu_tasks_trace);
else
  synchronize_rcu();

