Return-Path: <bpf+bounces-13238-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E26C47D69C2
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 13:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45343281BB5
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 11:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC70926E36;
	Wed, 25 Oct 2023 11:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="rsxYCkkr"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94B026E38
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 11:05:46 +0000 (UTC)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1C1128
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 04:05:45 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-d9a6399cf78so688184276.0
        for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 04:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1698231944; x=1698836744; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NXSe6IwmN/NPfSWKsgN8EzXesLS7X4/Oew8seILxOZ0=;
        b=rsxYCkkro5wyBGdYDqTuJjiDX1zEoqw57JkIVKnBu2hpPJ+mNE/wuBjt1J41ur+iv4
         jjwpL/C5HXITICNMcV8azhn7x/uv6wRdQtpJqcLJ45eVVNQoZkSgErS8A5senCTPJMAC
         dTkFHHHw1nqlz9amY24f0KJ2MM3pqsIXWiyCEH56pnz8z6O4DAV76RWtt4gu3cWyQgRo
         OnuqmP7+qT4FwN1zQelxu9TlyZIMilPudQzEzslDSJ2odhy0JvTR/44tTrln7Qk/g6MB
         XhyxsLyTbBZsOfJPPxxxPDSmlNl+HAsY8678qucKSdH5WVjUEAtLDFAp14FcfWQgG59Y
         lclg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698231944; x=1698836744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NXSe6IwmN/NPfSWKsgN8EzXesLS7X4/Oew8seILxOZ0=;
        b=K44MPnkB3km7DAuaqDoNGPMf84umTXKdq8QJZbuaYo3tp3veUo5sFLykMxUFyBCHWV
         P0cLI/L1qEfReZrslZyaFb8KKhLOW9gZlxlJOfv7oT1p5ti02lwMKNeOfkDThw9WHgG7
         5AIG1L8IsWT6OVOb9bHEqPDddCQR4lUvihL4OX/xUnbHkcE5JGEIufkmNc+oesyNvlEh
         /LWaTylS1FuFUnjDa54T6Hicf3RnnyLljEzzbERtyanFYnqDSYnhLkj9WJO/ybOOzp+N
         H9Us2Q+1I4A6f0HmV+PqyjB1K+ZoPcHh7GcsoE/oJminqNVxoSyrtHeiKixoSI5S1/QB
         sJ9g==
X-Gm-Message-State: AOJu0YxcKb6I6Y+ewYLt2VL7rV/+8jwnTqfj3pTBLEoqGfX3Im9aPfVC
	xf3/tZoBWbl5zQQ+tAWKLqWDY68nXil5YFAgakdP8g==
X-Google-Smtp-Source: AGHT+IEMD8tNi81oO0MJmIsLiHMPxHRnEPfOKhNSxjozsp8yaWIMRZN3ceHo5a0MoPfB62JI/QI4SUcV6qShkHAyIuM=
X-Received: by 2002:a25:ce47:0:b0:da0:77de:68d0 with SMTP id
 x68-20020a25ce47000000b00da077de68d0mr2381048ybe.26.1698231944336; Wed, 25
 Oct 2023 04:05:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231009092655.22025-1-daniel@iogearbox.net> <ZTjY959R+AFXf3Xy@shredder>
 <726368f0-bbe9-6aeb-7007-6f974ed075f2@iogearbox.net>
In-Reply-To: <726368f0-bbe9-6aeb-7007-6f974ed075f2@iogearbox.net>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 25 Oct 2023 07:05:32 -0400
Message-ID: <CAM0EoM=L3ft1zuXhMsKq=Z+u7asbvpBL-KJBXLCmHBg=6BLHzQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/2] net, sched: Make tc-related drop reason
 more flexible
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Ido Schimmel <idosch@idosch.org>, kuba@kernel.org, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, victor@mojatatu.com, martin.lau@linux.dev, dxu@dxuuu.xyz, 
	xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2023 at 6:01=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> Hi Ido,
>
> On 10/25/23 10:59 AM, Ido Schimmel wrote:
> > On Mon, Oct 09, 2023 at 11:26:54AM +0200, Daniel Borkmann wrote:
> >> diff --git a/net/core/dev.c b/net/core/dev.c
> >> index 606a366cc209..664426285fa3 100644
> >> --- a/net/core/dev.c
> >> +++ b/net/core/dev.c
> >> @@ -3910,7 +3910,8 @@ EXPORT_SYMBOL_GPL(netdev_xmit_skip_txqueue);
> >>   #endif /* CONFIG_NET_EGRESS */
> >>
> >>   #ifdef CONFIG_NET_XGRESS
> >> -static int tc_run(struct tcx_entry *entry, struct sk_buff *skb)
> >> +static int tc_run(struct tcx_entry *entry, struct sk_buff *skb,
> >> +              enum skb_drop_reason *drop_reason)
> >>   {
> >>      int ret =3D TC_ACT_UNSPEC;
> >>   #ifdef CONFIG_NET_CLS_ACT
> >> @@ -3922,12 +3923,14 @@ static int tc_run(struct tcx_entry *entry, str=
uct sk_buff *skb)
> >>
> >>      tc_skb_cb(skb)->mru =3D 0;
> >>      tc_skb_cb(skb)->post_ct =3D false;
> >> +    res.drop_reason =3D *drop_reason;
> >>
> >>      mini_qdisc_bstats_cpu_update(miniq, skb);
> >>      ret =3D tcf_classify(skb, miniq->block, miniq->filter_list, &res,=
 false);
> >>      /* Only tcf related quirks below. */
> >>      switch (ret) {
> >>      case TC_ACT_SHOT:
> >> +            *drop_reason =3D res.drop_reason;
> >
> > Daniel,
> >
> > Getting the following splat [1] with CONFIG_DEBUG_NET=3Dy and this
> > reproducer [2]. Problem seems to be that classifiers clear 'struct
> > tcf_result::drop_reason', thereby triggering the warning in
> > __kfree_skb_reason() due to reason being 'SKB_NOT_DROPPED_YET' (0).
> >
> > Fixed by maintaining the original drop reason if the one returned from
> > tcf_classify() is 'SKB_NOT_DROPPED_YET' [3]. I can submit this fix
> > unless you have a better idea.
>
> Thanks for catching this, looks reasonable to me as a fix.
>
> > [1]
> > WARNING: CPU: 0 PID: 181 at net/core/skbuff.c:1082 kfree_skb_reason+0x3=
8/0x130
> > Modules linked in:
> > CPU: 0 PID: 181 Comm: mausezahn Not tainted 6.6.0-rc6-custom-ge43e6d958=
2e0 #682
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-1.fc=
37 04/01/2014
> > RIP: 0010:kfree_skb_reason+0x38/0x130
> > [...]
> > Call Trace:
> >   <IRQ>
> >   __netif_receive_skb_core.constprop.0+0x837/0xdb0
> >   __netif_receive_skb_one_core+0x3c/0x70
> >   process_backlog+0x95/0x130
> >   __napi_poll+0x25/0x1b0
> >   net_rx_action+0x29b/0x310
> >   __do_softirq+0xc0/0x29b
> >   do_softirq+0x43/0x60
> >   </IRQ>
> >
> > [2]
> > #!/bin/bash
> >
> > ip link add name veth0 type veth peer name veth1
> > ip link set dev veth0 up
> > ip link set dev veth1 up
> > tc qdisc add dev veth1 clsact
> > tc filter add dev veth1 ingress pref 1 proto all flower dst_mac 00:11:2=
2:33:44:55 action drop
> > mausezahn veth0 -a own -b 00:11:22:33:44:55 -q -c 1
>
> I didn't know you're using mausezahn, nice :)
>
> > [3]
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index a37a932a3e14..abd0b13f3f17 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -3929,7 +3929,8 @@ static int tc_run(struct tcx_entry *entry, struct=
 sk_buff *skb,
> >          /* Only tcf related quirks below. */
> >          switch (ret) {
> >          case TC_ACT_SHOT:
> > -               *drop_reason =3D res.drop_reason;
> > +               if (res.drop_reason !=3D SKB_NOT_DROPPED_YET)
> > +                       *drop_reason =3D res.drop_reason;
> >                  mini_qdisc_qstats_cpu_drop(miniq);
> >                  break;
> >          case TC_ACT_OK:
> >


Out of curiosity - how does the policy say "drop" but drop_reason does
not reflect it?

cheers,
jamal


> When you submit feel free to add:
>
> Acked-by: Daniel Borkmann <daniel@iogearbox.net>

