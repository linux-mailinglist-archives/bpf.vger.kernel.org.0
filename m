Return-Path: <bpf+bounces-13945-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C647DF2B1
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 13:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A49AC1C20EED
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 12:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FCF6FA8;
	Thu,  2 Nov 2023 12:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="qaL5UL9r"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625CA2914
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 12:47:38 +0000 (UTC)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C72B136
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 05:47:36 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-d9ad67058fcso906199276.1
        for <bpf@vger.kernel.org>; Thu, 02 Nov 2023 05:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1698929255; x=1699534055; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N1zu9A/Y66l6k7HUDKBsy+9wtQVKOaiFBawPW4zOPhg=;
        b=qaL5UL9r0rw6Fe16B+uJA3rO2/TB+hCU+6QT0tHzf4aHuloRVAIJSVHmO98TEi+dLg
         lcXECUjPE/1NMStrL+gOK/nAKRmG1mwN0w9H9EzEwHz62zybyJCkeLsfdzs67e5bfmJH
         tHHPh1ksCy5cdNF6tQfxftpkTCEDQAMfuTF2O/xIXbKJZNh0O2iMoqS66LhESfgevJ+W
         ATgkjainWBfFUwZJocuGbSTaXQyDaUuP39qvLhw68/XqLWW0pnS3PIoK7CjJcqoZqtAi
         OS7sA3fTXbtpU5s62/7YSBtotqNmSiQoyEnGFhyEqhbsVgATcvdNnSO0Nn8W9cy8xA7H
         V8Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698929255; x=1699534055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N1zu9A/Y66l6k7HUDKBsy+9wtQVKOaiFBawPW4zOPhg=;
        b=whoIm3ox2UrXfMIQoPHpif3jvAcCQM0gWnPBhvG2XjSAebbHtrXAJbinDB34aMrwK7
         dWa86qNFZGsQbVXb84+rnpSPXZhN3SWI6JnpLNkXwFCkPHe1Agb87etjrrWaHwaq/gvQ
         43rweFRFjUX+SX9qjiSbWSkBE3kpWN9gsZNpf6LcJxIendSqSnfwd3WSjYNtIH99YS0s
         NIZneFVZrq3Asmrx7lKwgG8p+NcbCkPpxzT15EeR6FKozhWTu74A5LiuwaisQ/BebYVh
         spA3iHs8bDtChM866qhZ5OmIbvWmzuS0Lo2eVy3AVhzY5HhlKBEzkK2r+Py8Hf/9kNfh
         w42w==
X-Gm-Message-State: AOJu0Yx7sB7ONNbCQB4gYIC4lqwcQ6nGUDJCHzs9+Up3BTyUxNTJwJws
	6AaOWpLZsRAEbfYa1RK6WbX5aM5U9ZxQytTmo4aMVg==
X-Google-Smtp-Source: AGHT+IEkE3jWPdPwXl0jrSr0XIFQMIlrQgkSEBtgPFY35xhA+TgdPPOAdc268A07JS73sPKSarPqBBLr6+3M8XvRrjg=
X-Received: by 2002:a25:d8d0:0:b0:d86:9fd5:9350 with SMTP id
 p199-20020a25d8d0000000b00d869fd59350mr16876322ybg.59.1698929255445; Thu, 02
 Nov 2023 05:47:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231027135142.11555-1-daniel@iogearbox.net> <CAM0EoMm9K=jS=JZUNXo+C6qs=p=r7CtjWK20ocmTKEDxN3Bz-w@mail.gmail.com>
 <5ab182b6-6ac7-16f7-7eae-7001be2b6da7@iogearbox.net> <5ca2062477738b804ce805847f7aec024ad5988c.camel@redhat.com>
In-Reply-To: <5ca2062477738b804ce805847f7aec024ad5988c.camel@redhat.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 2 Nov 2023 08:47:24 -0400
Message-ID: <CAM0EoMnb8nGJ8U6czNix-qnf9pawZMzmdGKwyfAhbA3nsoWsRA@mail.gmail.com>
Subject: Re: [PATCH net-next] net, sched: Fix SKB_NOT_DROPPED_YET splat under
 debug config
To: Paolo Abeni <pabeni@redhat.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, kuba@kernel.org, idosch@idosch.org, 
	netdev@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 2, 2023 at 6:17=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On Fri, 2023-10-27 at 20:21 +0200, Daniel Borkmann wrote:
> > On 10/27/23 7:24 PM, Jamal Hadi Salim wrote:
> > > On Fri, Oct 27, 2023 at 9:51=E2=80=AFAM Daniel Borkmann <daniel@iogea=
rbox.net> wrote:
> > > >
> > > > Ido reported:
> > > >
> > > >    [...] getting the following splat [1] with CONFIG_DEBUG_NET=3Dy =
and this
> > > >    reproducer [2]. Problem seems to be that classifiers clear 'stru=
ct
> > > >    tcf_result::drop_reason', thereby triggering the warning in
> > > >    __kfree_skb_reason() due to reason being 'SKB_NOT_DROPPED_YET' (=
0). [...]
> > > >
> > > >    [1]
> > > >    WARNING: CPU: 0 PID: 181 at net/core/skbuff.c:1082 kfree_skb_rea=
son+0x38/0x130
> > > >    Modules linked in:
> > > >    CPU: 0 PID: 181 Comm: mausezahn Not tainted 6.6.0-rc6-custom-ge4=
3e6d9582e0 #682
> > > >    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16=
.2-1.fc37 04/01/2014
> > > >    RIP: 0010:kfree_skb_reason+0x38/0x130
> > > >    [...]
> > > >    Call Trace:
> > > >     <IRQ>
> > > >     __netif_receive_skb_core.constprop.0+0x837/0xdb0
> > > >     __netif_receive_skb_one_core+0x3c/0x70
> > > >     process_backlog+0x95/0x130
> > > >     __napi_poll+0x25/0x1b0
> > > >     net_rx_action+0x29b/0x310
> > > >     __do_softirq+0xc0/0x29b
> > > >     do_softirq+0x43/0x60
> > > >     </IRQ>
> > > >
> > > >    [2]
> > > >    #!/bin/bash
> > > >
> > > >    ip link add name veth0 type veth peer name veth1
> > > >    ip link set dev veth0 up
> > > >    ip link set dev veth1 up
> > > >    tc qdisc add dev veth1 clsact
> > > >    tc filter add dev veth1 ingress pref 1 proto all flower dst_mac =
00:11:22:33:44:55 action drop
> > > >    mausezahn veth0 -a own -b 00:11:22:33:44:55 -q -c 1
> > > >
> > > > What happens is that inside most classifiers the tcf_result is copi=
ed over
> > > > from a filter template e.g. *res =3D f->res which then implicitly o=
verrides
> > > > the prior SKB_DROP_REASON_TC_{INGRESS,EGRESS} default drop code whi=
ch was
> > > > set via sch_handle_{ingress,egress}() for kfree_skb_reason().
> > > >
> > > > Add a small helper tcf_set_result() and convert classifiers over to=
 it.
> > > > The latter leaves the drop code intact and classifiers, actions as =
well
> > > > as the action engine in tcf_exts_exec() can then in future make use=
 of
> > > > tcf_set_drop_reason(), too.
> > > >
> > > > Tested that the splat is fixed under CONFIG_DEBUG_NET=3Dy with the =
repro.
> > > >
> > > > Fixes: 54a59aed395c ("net, sched: Make tc-related drop reason more =
flexible")
> > > > Reported-by: Ido Schimmel <idosch@idosch.org>
> > > > Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> > > > Cc: Jamal Hadi Salim <jhs@mojatatu.com>
> > > > Cc: Jakub Kicinski <kuba@kernel.org>
> > > > Link: https://lore.kernel.org/netdev/ZTjY959R+AFXf3Xy@shredder
> > > > ---
> > > >   include/net/pkt_cls.h    | 12 ++++++++++++
> > > >   net/sched/cls_basic.c    |  2 +-
> > > >   net/sched/cls_bpf.c      |  2 +-
> > > >   net/sched/cls_flower.c   |  2 +-
> > > >   net/sched/cls_fw.c       |  2 +-
> > > >   net/sched/cls_matchall.c |  2 +-
> > > >   net/sched/cls_route.c    |  4 ++--
> > > >   net/sched/cls_u32.c      |  2 +-
> > > >   8 files changed, 20 insertions(+), 8 deletions(-)
> > > >
> > > > diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
> > > > index a76c9171db0e..31d8e8587824 100644
> > > > --- a/include/net/pkt_cls.h
> > > > +++ b/include/net/pkt_cls.h
> > > > @@ -160,6 +160,18 @@ static inline void tcf_set_drop_reason(struct =
tcf_result *res,
> > > >          res->drop_reason =3D reason;
> > > >   }
> > > >
> > > > +static inline void tcf_set_result(struct tcf_result *to,
> > > > +                                 const struct tcf_result *from)
> > > > +{
> > > > +       /* tcf_result's drop_reason which is the last member must b=
e
> > > > +        * preserved and cannot be copied from the cls'es tcf_resul=
t
> > > > +        * template given this is carried all the way and potential=
ly
> > > > +        * set to a concrete tc drop reason upon error or intention=
al
> > > > +        * drop. See tcf_set_drop_reason() locations.
> > > > +        */
> > > > +       memcpy(to, from, offsetof(typeof(*to), drop_reason));
> > > > +}
> > >
> > > I believe our bigger issue here is we are using this struct now for
> > > both policy set by the control plane and for runtime decisions
> >
> > Hm, but that was also either way in the original rfc.
> >
> > > (drop_reason) - whereas the original assumption was this struct only
> > > held set policy. In retrospect we should have put the verdict(which i=
s
> > > policy) here and return the error code (as was in the first patch). I
> > > am also not sure humans would not make a mistake on "this field must
> > > be at the end of the struct". Can we put some assert (or big comment
> > > on the struct) to make sure someone does not overwrite this field?
> >
> > Yeah that can be done.
>
> FTR, I agree the comment or even better a build_bug_on() somewhere
> should be better.

Paolo - Did you see the patch i posted? Ido/Daniel?

cheers,
jamal
>
> Thanks!
>
> Paolo
>

