Return-Path: <bpf+bounces-12839-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D42F7D11F9
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 16:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7656282519
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 14:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4319F1DA30;
	Fri, 20 Oct 2023 14:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mqn4fmQ/"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97801199BE
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 14:58:16 +0000 (UTC)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1371EFA
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 07:58:13 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40651a726acso7545165e9.1
        for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 07:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697813891; x=1698418691; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xr4XT0H5H5s90ENHIQ4i1JDap0MUEcuZxPp9GsRehLE=;
        b=Mqn4fmQ/Kp5anX4MbmYxkxLJAf5fed46sAWJJ0NgdgS97nJWGw6Gt6QtxA5nJ+qbDZ
         diZUIYgu+9P/wpEncA4bDjBjdUgS1CVcOKyNnbFismDu97AhpDxw2CgAn0Zog3f5YueW
         gtADBjjW9WCbaS+gvIXVsibI8sb6d8O9G/AHrDwlrm21PhzmQF0l01M/fOmRZscTtk4f
         HfiZPNiaGRaC39ExSpO9TdHWkCTxEPaoCbLr42ut+TO1No4nE6kgxgO88tftUR+dJo+r
         CB7yQw9iakTzUznjj1aWNlYbuY1zeoRU0cGG3IWa3coRq7I9TL7bVjImLoQ5btoe+UjP
         Eniw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697813891; x=1698418691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xr4XT0H5H5s90ENHIQ4i1JDap0MUEcuZxPp9GsRehLE=;
        b=O6aAK3quFncKrvmNgZQCErqr0VD6/u/3rNTU24owAf4a3zjN93DSJ5GO8jQcm5bHgc
         UPchcfWYprx4I4124GR60rVakytW77bQm2Am6zNP2aKV23+17wee/ft7LFK6iK06Ovk+
         s09ZDTPVe1SRIG2j65z3KCAdVI0zW7//VovWv9CIr4nY3qe124GMwkDUYxj3y7+AAiS8
         XV2ayGTeCi18EHIQajypzebBaf5bgWlUdtwRP1SPe6w/dj40mq9ilgG1WPubtxnp++yR
         Lzf13lpWLwvc/JcHhfpLU0qwS2whmaM413ZFuRYyB+H36vYU9oYKku4wfr9muh2QdaGS
         oKRg==
X-Gm-Message-State: AOJu0YwLxOGnaG31uJgsgrUw+4x1orlaLr9oA4Zvvggu0nw10qnxQitG
	93q2vwHowLvUXTbdz9qi5h6l4995yYOaKuFI65g=
X-Google-Smtp-Source: AGHT+IGI2Tlv5L7OsVc+A0RdovcTka3Mq3ofUgfYTTNeCrnyBj2pokE7M4Qat2XewYAJIHYyhgmCCCZfldWlvZN+rmg=
X-Received: by 2002:a05:6000:1c14:b0:323:2d01:f043 with SMTP id
 ba20-20020a0560001c1400b003232d01f043mr2397331wrb.3.1697813891246; Fri, 20
 Oct 2023 07:58:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231020014214.2471419-1-houtao@huaweicloud.com>
 <20231020014214.2471419-2-houtao@huaweicloud.com> <CAADnVQK9BzHfAwnws+XhwL_zz9wvSAUaK0HSFWHGUQeD4LWO8w@mail.gmail.com>
 <42756ba7-191e-37a5-ee78-849e2f1d3d50@huaweicloud.com>
In-Reply-To: <42756ba7-191e-37a5-ee78-849e2f1d3d50@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 20 Oct 2023 07:57:59 -0700
Message-ID: <CAADnVQL0N=+3yk17iNHEJ2+12LuTj3A6T5mzb-jpy_z6GOD6LA@mail.gmail.com>
Subject: Re: [PATCH bpf v2 1/2] bpf: Check map->usercnt again after
 timer->timer is assigned
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Hsin-Wei Hung <hsinweih@uci.edu>, 
	Hou Tao <houtao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 20, 2023 at 12:31=E2=80=AFAM Hou Tao <houtao@huaweicloud.com> w=
rote:
>
> Hi,
>
> On 10/20/2023 10:14 AM, Alexei Starovoitov wrote:
> > On Thu, Oct 19, 2023 at 6:41=E2=80=AFPM Hou Tao <houtao@huaweicloud.com=
> wrote:
> >> From: Hou Tao <houtao1@huawei.com>
> >>
> >> When there are concurrent uref release and bpf timer init operations,
> >> the following sequence diagram is possible and it will lead to memory
> >> leak:
> >>
> >> bpf program X
> >>
> >> bpf_timer_init()
> >>   lock timer->lock
> >>     read timer->timer as NULL
> >>     read map->usercnt !=3D 0
> >>
> >>                 process Y
> >>
> >>                 close(map_fd)
> >>                   // put last uref
> >>                   bpf_map_put_uref()
> >>                     atomic_dec_and_test(map->usercnt)
> >>                       array_map_free_timers()
> >>                         bpf_timer_cancel_and_free()
> >>                           // just return and lead to memory leak
> >>                           read timer->timer is NULL
> >>
> >>     t =3D bpf_map_kmalloc_node()
> >>     timer->timer =3D t
> >>   unlock timer->lock
> >>
> >> Fix the problem by checking map->usercnt again after timer->timer is
> >> assigned, so when there are concurrent uref release and bpf timer init=
,
> >> either bpf_timer_cancel_and_free() from uref release reads a no-NULL
> >> timer and the newly-added check of map->usercnt reads a zero usercnt.
> >>
> >> Because atomic_dec_and_test(map->usercnt) and READ_ONCE(timer->timer)
> >> in bpf_timer_cancel_and_free() are not protected by a lock, so add
> >> a memory barrier to guarantee the order between map->usercnt and
> >> timer->timer. Also use WRITE_ONCE(timer->timer, x) to match the lockle=
ss
> >> read of timer->timer.
> >>
> >> Reported-by: Hsin-Wei Hung <hsinweih@uci.edu>
> >> Closes: https://lore.kernel.org/bpf/CABcoxUaT2k9hWsS1tNgXyoU3E-=3DPuOg=
Mn737qK984fbFmfYixQ@mail.gmail.com
> >> Fixes: b00628b1c7d5 ("bpf: Introduce bpf timers.")
> >> Signed-off-by: Hou Tao <houtao1@huawei.com>
> >> ---
> >>  kernel/bpf/helpers.c | 18 +++++++++++++++---
> >>  1 file changed, 15 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> >> index 757b99c1e613f..a7d92c3ddc3dd 100644
> >> --- a/kernel/bpf/helpers.c
> >> +++ b/kernel/bpf/helpers.c
> >> @@ -1156,7 +1156,7 @@ BPF_CALL_3(bpf_timer_init, struct bpf_timer_kern=
 *, timer, struct bpf_map *, map
> >>            u64, flags)
> >>  {
> >>         clockid_t clockid =3D flags & (MAX_CLOCKS - 1);
> >> -       struct bpf_hrtimer *t;
> >> +       struct bpf_hrtimer *t, *to_free =3D NULL;
> >>         int ret =3D 0;
> >>
> >>         BUILD_BUG_ON(MAX_CLOCKS !=3D 16);
> >> @@ -1197,9 +1197,21 @@ BPF_CALL_3(bpf_timer_init, struct bpf_timer_ker=
n *, timer, struct bpf_map *, map
> >>         rcu_assign_pointer(t->callback_fn, NULL);
> >>         hrtimer_init(&t->timer, clockid, HRTIMER_MODE_REL_SOFT);
> >>         t->timer.function =3D bpf_timer_cb;
> >> -       timer->timer =3D t;
> >> +       WRITE_ONCE(timer->timer, t);
> >> +       /* Guarantee order between timer->timer and map->usercnt. So w=
hen
> >> +        * there are concurrent uref release and bpf timer init, eithe=
r
> >> +        * bpf_timer_cancel_and_free() called by uref release reads a =
no-NULL
> >> +        * timer or atomic64_read() below reads a zero usercnt.
> >> +        */
> >> +       smp_mb();
> >> +       if (!atomic64_read(&map->usercnt)) {
> >> +               WRITE_ONCE(timer->timer, NULL);
> >> +               to_free =3D t;
> > just kfree(t); here.
>
> Will do. It is a slow path, so I think doing kfree() under spin-lock is
> acceptable.
> >
> >> +               ret =3D -EPERM;
> >> +       }
> > This will add a second atomic64_read(&map->usercnt) in the same functio=
n.
> > Let's remove the first one ?
>
> I prefer to still keep it. Because it can detect the release of map uref
> early and the handle of uref release is simple compared with the second
> atomic64_read(). Do you have a strong preference ?

I bet somebody will send a patch to remove the first one as redundant.
So let's do it now.
The only reason we do repeated early check is to avoid taking a lock.
Here doing an extra early check to avoid kmalloc is an overkill.
That check is highly unlikely to hit while for locks it's a likely one.
Hence extra check is justified for locks, but not here.

Reading your other email it looks like this patchset is incomplete anyway?

