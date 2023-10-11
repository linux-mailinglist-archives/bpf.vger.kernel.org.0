Return-Path: <bpf+bounces-11858-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 957F37C48D6
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 06:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2931F1C20EC7
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 04:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5BFD2E3;
	Wed, 11 Oct 2023 04:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uci-edu.20230601.gappssmtp.com header.i=@uci-edu.20230601.gappssmtp.com header.b="C/lJCd+K"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2137F2101
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 04:40:05 +0000 (UTC)
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F48F98
	for <bpf@vger.kernel.org>; Tue, 10 Oct 2023 21:40:04 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id a1e0cc1a2514c-7b3828115bcso2089574241.1
        for <bpf@vger.kernel.org>; Tue, 10 Oct 2023 21:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uci-edu.20230601.gappssmtp.com; s=20230601; t=1696999203; x=1697604003; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8JCPqFJuOWD5AIrVxgbMQdNFlmcqDi8bmPXrXr1vWgE=;
        b=C/lJCd+KQngu0zJTzRWTW4RIfp+B83gO7jNUbTCY8nczDYzrk+1FXOiKhnm1RNMyE3
         Jz60y4H28ge5w/5HIFqjpfjKhgHWsTvbmwYDI41OJyGu1n/1z9at5eV+yccvjmJNmjv3
         os75i1xLCchhFMErcO6V6uXbS7UpmfX5EoV7WBY8PZwNomT6cNRqfzocviVJSaC9aMYW
         Wk+w7muYFLiPjNfk98mPtFu1XJlSrOYH2FrIf5AzrImVwjsCn9UX0Rg43r24FdV6yz56
         4m97uVGLPhBm9hh4k0dmD3Zw2Gfcbsvwm2KTsgQGFbu9ZTWKqCGiKVIlsiyWz0rtPG7g
         eeag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696999203; x=1697604003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8JCPqFJuOWD5AIrVxgbMQdNFlmcqDi8bmPXrXr1vWgE=;
        b=oeswEUvJ+41XsB/DXKmfOYt27HSVkpNhn+CqBs4skrxw3md/EBqL3QtS2XRQz+UryM
         BC9t1majxD/AYaOlYXmoH6Y9iw2thRA82dyrS6/ULsmscUM6PaQTpPjYsr1Dmphdm61s
         R//BKl2rw238pyat9deBOe9C54u0uJ2VmzCj0Jm/ud4Myes/WGJj8Maay6Fw9OQeOCDX
         uH3VNfoigJiMNbVGPBhRKM4nrw8FO10v+204AeMYFyPF/ROhwqa0vkiq5SWLTXVQjyDb
         IIv6Oj292CgV55d95VzXu+/ozAUuXCwmlN4A6bKqT+79vpaKta9ZhkZQ7HctCtPT9UDS
         Yv5g==
X-Gm-Message-State: AOJu0Yw804wLXq6iSEKO8V1mWj5IFfp80CeV5dHp1GWIYWqFcIOff6Fe
	detc0/aggid+lTtF6oTu6sg48NZzyDE9GIzPCgC23w==
X-Google-Smtp-Source: AGHT+IGehzrfrJj5IjinQwii9iWbq5SlkuwG/tV321A0SUKh8JCF8vFNrmT5BnysytOcOZseH31tguGToU9On1H9wFg=
X-Received: by 2002:a05:6102:4b9:b0:454:6f12:3f67 with SMTP id
 r25-20020a05610204b900b004546f123f67mr20272013vsa.19.1696999203268; Tue, 10
 Oct 2023 21:40:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABcoxUaT2k9hWsS1tNgXyoU3E-=PuOgMn737qK984fbFmfYixQ@mail.gmail.com>
 <8bf09dbd-670d-a666-8dcd-fc3406fa7ada@huaweicloud.com>
In-Reply-To: <8bf09dbd-670d-a666-8dcd-fc3406fa7ada@huaweicloud.com>
From: Hsin-Wei Hung <hsinweih@uci.edu>
Date: Tue, 10 Oct 2023 21:39:28 -0700
Message-ID: <CABcoxUZU-+aaPw1VsqbYRsbCEq8R7Mb+aCCkq6M6zVoP3Oq36g@mail.gmail.com>
Subject: Re: Possible kernel memory leak in bpf_timer
To: Hou Tao <houtao@huaweicloud.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, 
	Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Oct 7, 2023 at 7:46=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wro=
te:
>
> Hi,
>
> On 9/27/2023 1:32 PM, Hsin-Wei Hung wrote:
> > Hi,
> >
> > We found a potential memory leak in bpf_timer in v5.15.26 using a
> > customized syzkaller for fuzzing bpf runtime. It can happen when
> > an arraymap is being released. An entry that has been checked by
> > bpf_timer_cancel_and_free() can again be initialized by bpf_timer_init(=
).
> > Since both paths are almost identical between v5.15 and net-next,
> > I suspect this problem still exists. Below are kmemleak report and
> > some additional printks I inserted.
> >
> > [ 1364.081694] array_map_free_timers map:0xffffc900005a9000
> > [ 1364.081730] ____bpf_timer_init map:0xffffc900005a9000
> > timer:0xffff888001ab4080
> >
> > *no bpf_timer_cancel_and_free that will kfree struct bpf_hrtimer*
> > at 0xffff888001ab4080 is called
>
> I think the kmemleak happened as follows:
>
> bpf_timer_init()
>   lock timer->lock
>     read timer->timer as NULL
>     read map->usercnt !=3D 0
>
>                 bpf_map_put_uref()
>                   // map->usercnt =3D 0
>                   atomic_dec_and_test(map->usercnt)
>                     array_map_free_timers()
>                     // just return and lead to mem leak
>                     find timer->timer is NULL
>
>     t =3D bpf_map_kmalloc_node()
>     timer->timer =3D t
>   unlock timer->lock
>
> Could you please try the attached patch to check whether the kmemleak
> problem has been fixed ?
>

Hi,

Sorry for the late reply to this thread.

KASAN is complaining about double-free/invalid-free in the kfree after
applying the patch. There are some cases that jump to "out" before the
bpf_hrtimer is allocated or when the bpf_hrtimer is already allocated.

I am still trying to have a standalone working POC. I think a key to
trigger this memory leak is to 1) have a large array map 2) a bpf
program init a timer in a small-index entry and then 3) release the
map.

-Amery


> >
> > [ 1383.907869] kmemleak: 1 new suspected memory leaks (see
> > /sys/kernel/debug/kmemleak)
> > BUG: memory leak
> > unreferenced object 0xffff888001ab4080 (size 96):
> >   comm "sshd", pid 279, jiffies 4295233126 (age 29.952s)
> >   hex dump (first 32 bytes):
> >     80 40 ab 01 80 88 ff ff 00 00 00 00 00 00 00 00  .@..............
> >     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >   backtrace:
> >     [<000000009d018da0>] bpf_map_kmalloc_node+0x89/0x1a0
> >     [<00000000ebcb33fc>] bpf_timer_init+0x177/0x320
> >     [<00000000fb7e90bf>] 0xffffffffc02a0358
> >     [<000000000c89ec4f>] __cgroup_bpf_run_filter_skb+0xcbf/0x1110
> >     [<00000000fd663fc0>] ip_finish_output+0x13d/0x1f0
> >     [<00000000acb3205c>] ip_output+0x19b/0x310
> >     [<000000006b584375>] __ip_queue_xmit+0x182e/0x1ed0
> >     [<00000000b921b07e>] __tcp_transmit_skb+0x2b65/0x37f0
> >     [<0000000026104b23>] tcp_write_xmit+0xf19/0x6290
> >     [<000000006dc71bc5>] __tcp_push_pending_frames+0xaf/0x390
> >     [<00000000251b364a>] tcp_push+0x452/0x6d0
> >     [<000000008522b7d3>] tcp_sendmsg_locked+0x2567/0x3030
> >     [<0000000038c644d2>] tcp_sendmsg+0x30/0x50
> >     [<000000009fe3413f>] inet_sendmsg+0xba/0x140
> >     [<0000000034d78039>] sock_sendmsg+0x13d/0x190
> >     [<00000000f55b8db6>] sock_write_iter+0x296/0x3d0
> >
> >
> > Thanks,
> > Hsin-Wei (Amery)
> >
> >
> > .
>

