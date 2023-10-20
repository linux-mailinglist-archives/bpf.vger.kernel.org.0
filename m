Return-Path: <bpf+bounces-12781-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 927DD7D0665
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 04:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC0671F22412
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 02:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB51380D;
	Fri, 20 Oct 2023 02:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZSCM7Yb"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AC7801
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 02:14:46 +0000 (UTC)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F949115
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 19:14:44 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-31427ddd3fbso245969f8f.0
        for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 19:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697768083; x=1698372883; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x9TdcZSdIoJE0d8tD/0ODaN6/BE6YiBRWclBhebOVK0=;
        b=LZSCM7Yb13MBkDkj1lKu33tl0Js8bB82kPLEWbLFMLBsZ3Qi8Ejh+nT4Ne13Pm0YfI
         pFNURhLuKt4/NrBYryq81AtZ3mhMZEsZ+SBQGvgFDVuZu5mrRFFGbzDhqkSC5Gw94jTt
         1tpaMfzs3SLsmDRCBaOvpngwYQCQ8uiL4nG5DCOkEVwyyuhDwRuiSsgj69EjrULhlQOV
         445bVIeh57MIcxdaph2Kw0dNGFkrLhYbc8DW5jctuyzY6acTbd5rVWrG4pFWfymdKq7a
         2GW9Fas6iMy2yFDnqDwGDS2OXZRfZeClDkf+UefN+859h0kpmksynRbSibUA5Un3eQ+Q
         Kqdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697768083; x=1698372883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x9TdcZSdIoJE0d8tD/0ODaN6/BE6YiBRWclBhebOVK0=;
        b=U2FLfJoJ0HpdEjxGIeZ+yCUavaXe1Iqu2jo4BEZ3h3B3d//QzyRY3k0/K2cwKZ+E2E
         cBZ9G/ZWswBpqEHundhtRlGaQB7lvzISrbSyhUrMfEzWSD3iao67yxP+0oTya0/zGunl
         uTOj2HL99gHt6t8/MO0lIQk72kbhrhBrmA2+QeZMzDVnBOQvLOsfv+uJd6j9ssxbwBZV
         ZFh+Zk9aOG7h+9xDoHhPjTn3Ew3sqG/KYwksuIqowcgHsuylSQOV32bROQldcJZCuNkF
         uZgg+aEYLxCg8h/yqlThY92YG7LOOhlInTB+RoXHFgMlXXyVouSPZY7V9jw63EXCX+Rf
         AYDQ==
X-Gm-Message-State: AOJu0YwutsSdayXaFElr2LW1llj+vawE3qcUpdKzVRHhgDbK3Ix2km+Q
	N8kamGDuBWIrTjyOZBLvaEc3Nlj0OVhPqwhQnNo=
X-Google-Smtp-Source: AGHT+IGbm5GlofpHhJJvRROSNTKzUWVZrHtrT38+huvSiZPrfoPjqTOeYRAascjrHEatLc7GBRfvnGwvHvQC2Q/BAr0=
X-Received: by 2002:adf:e702:0:b0:319:7472:f0b6 with SMTP id
 c2-20020adfe702000000b003197472f0b6mr387959wrm.15.1697768082643; Thu, 19 Oct
 2023 19:14:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231020014214.2471419-1-houtao@huaweicloud.com> <20231020014214.2471419-2-houtao@huaweicloud.com>
In-Reply-To: <20231020014214.2471419-2-houtao@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 19 Oct 2023 19:14:31 -0700
Message-ID: <CAADnVQK9BzHfAwnws+XhwL_zz9wvSAUaK0HSFWHGUQeD4LWO8w@mail.gmail.com>
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

On Thu, Oct 19, 2023 at 6:41=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
> From: Hou Tao <houtao1@huawei.com>
>
> When there are concurrent uref release and bpf timer init operations,
> the following sequence diagram is possible and it will lead to memory
> leak:
>
> bpf program X
>
> bpf_timer_init()
>   lock timer->lock
>     read timer->timer as NULL
>     read map->usercnt !=3D 0
>
>                 process Y
>
>                 close(map_fd)
>                   // put last uref
>                   bpf_map_put_uref()
>                     atomic_dec_and_test(map->usercnt)
>                       array_map_free_timers()
>                         bpf_timer_cancel_and_free()
>                           // just return and lead to memory leak
>                           read timer->timer is NULL
>
>     t =3D bpf_map_kmalloc_node()
>     timer->timer =3D t
>   unlock timer->lock
>
> Fix the problem by checking map->usercnt again after timer->timer is
> assigned, so when there are concurrent uref release and bpf timer init,
> either bpf_timer_cancel_and_free() from uref release reads a no-NULL
> timer and the newly-added check of map->usercnt reads a zero usercnt.
>
> Because atomic_dec_and_test(map->usercnt) and READ_ONCE(timer->timer)
> in bpf_timer_cancel_and_free() are not protected by a lock, so add
> a memory barrier to guarantee the order between map->usercnt and
> timer->timer. Also use WRITE_ONCE(timer->timer, x) to match the lockless
> read of timer->timer.
>
> Reported-by: Hsin-Wei Hung <hsinweih@uci.edu>
> Closes: https://lore.kernel.org/bpf/CABcoxUaT2k9hWsS1tNgXyoU3E-=3DPuOgMn7=
37qK984fbFmfYixQ@mail.gmail.com
> Fixes: b00628b1c7d5 ("bpf: Introduce bpf timers.")
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  kernel/bpf/helpers.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 757b99c1e613f..a7d92c3ddc3dd 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1156,7 +1156,7 @@ BPF_CALL_3(bpf_timer_init, struct bpf_timer_kern *,=
 timer, struct bpf_map *, map
>            u64, flags)
>  {
>         clockid_t clockid =3D flags & (MAX_CLOCKS - 1);
> -       struct bpf_hrtimer *t;
> +       struct bpf_hrtimer *t, *to_free =3D NULL;
>         int ret =3D 0;
>
>         BUILD_BUG_ON(MAX_CLOCKS !=3D 16);
> @@ -1197,9 +1197,21 @@ BPF_CALL_3(bpf_timer_init, struct bpf_timer_kern *=
, timer, struct bpf_map *, map
>         rcu_assign_pointer(t->callback_fn, NULL);
>         hrtimer_init(&t->timer, clockid, HRTIMER_MODE_REL_SOFT);
>         t->timer.function =3D bpf_timer_cb;
> -       timer->timer =3D t;
> +       WRITE_ONCE(timer->timer, t);
> +       /* Guarantee order between timer->timer and map->usercnt. So when
> +        * there are concurrent uref release and bpf timer init, either
> +        * bpf_timer_cancel_and_free() called by uref release reads a no-=
NULL
> +        * timer or atomic64_read() below reads a zero usercnt.
> +        */
> +       smp_mb();
> +       if (!atomic64_read(&map->usercnt)) {
> +               WRITE_ONCE(timer->timer, NULL);
> +               to_free =3D t;

just kfree(t); here.

> +               ret =3D -EPERM;
> +       }

This will add a second atomic64_read(&map->usercnt) in the same function.
Let's remove the first one ?

>  out:
>         __bpf_spin_unlock_irqrestore(&timer->lock);
> +       kfree(to_free);
>         return ret;
>  }
>
> @@ -1372,7 +1384,7 @@ void bpf_timer_cancel_and_free(void *val)
>         /* The subsequent bpf_timer_start/cancel() helpers won't be able =
to use
>          * this timer, since it won't be initialized.
>          */
> -       timer->timer =3D NULL;
> +       WRITE_ONCE(timer->timer, NULL);
>  out:
>         __bpf_spin_unlock_irqrestore(&timer->lock);
>         if (!t)
> --
> 2.29.2
>

