Return-Path: <bpf+bounces-13556-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 704647DA822
	for <lists+bpf@lfdr.de>; Sat, 28 Oct 2023 18:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E15A5B2133C
	for <lists+bpf@lfdr.de>; Sat, 28 Oct 2023 16:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C6917731;
	Sat, 28 Oct 2023 16:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="alhpMBys"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49FBF9D6
	for <bpf@vger.kernel.org>; Sat, 28 Oct 2023 16:51:09 +0000 (UTC)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94709E5
	for <bpf@vger.kernel.org>; Sat, 28 Oct 2023 09:51:07 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-579de633419so25909927b3.3
        for <bpf@vger.kernel.org>; Sat, 28 Oct 2023 09:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1698511867; x=1699116667; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eoinu6yRueI2SYBE35N9c7itP0m0Gy5PTpBS8WGI/0k=;
        b=alhpMBysYlFNxqK5hNn4PTc3Tb6aKsqkedVQ6CFPsz4pjv3fJfOjNPWc9KwD3OUlwE
         UkoBrQ6tlKFkTdO9s5yep7Bilis2XMNOBKAPj1DUJA/bdbuOU7CxPcwjelH1BlzP/gKt
         zwvcs9GirXh2eu5xA2mHmeJO4uMdZUHLu9HeuUR8WzxZfr+ho8EQZFRmvnW1LUbpi+Pm
         AzWWMET87kd9dENamf5a6Wzet7ymZC4bkKzPragf/3+jGRoHaeaf3/8f4oyK7s+GYErq
         Ocz7BySWiKIjhMTnAJEeKPFabanFnuhEGwSgiOY9sLneVsSbPVELD7UI455S1lj0Y2VY
         +lLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698511867; x=1699116667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eoinu6yRueI2SYBE35N9c7itP0m0Gy5PTpBS8WGI/0k=;
        b=NaWAOjXnsbnIPimBaxyro20illit3RwynNPX9JXjR14nnwoBWbQusYVRkXswgGNHeV
         PoY0AlvzpBsdj6IIvXcYBL+DUfzW4yqbeEflH2qpL+STvSkggLUk8hisRinqfrZ+Bix4
         MVgNV0OI0fj4zlOKd1d1agEppNxCSsOAuK1CAlX7Xl1hXAKZymtuc+gPiIWZSU0gF1xC
         jx9iKR0N8KDkjGRa2IsYMy5SsCS23sUAY0xcDs0upYWmaNwZNIhNLqLomFhGwN9bbAAT
         45KFLdU4jz3L9exyiruRzYPdozK752WX8WFCglRcfEDBIkuEOKXIfyl+k/8uQLLYvSsQ
         qdsA==
X-Gm-Message-State: AOJu0YyxIcNOB79XtsWcLpdD+EIjy79IBAoa69bzytcm2WwO6NK4Btak
	qYcqMTVbtCUXHpaDfpMirx7CJ4R70nPnqnB/GvOXKw==
X-Google-Smtp-Source: AGHT+IEunwFLPXvkpcQ8RI6w/kS57M0Sxj4TgEGHrVzOfhuN+JVm9ZFE0cT/p5Pou6zOyaeszVvvF4io6zdcj4Pnkyw=
X-Received: by 2002:a25:68cd:0:b0:da0:4453:8f10 with SMTP id
 d196-20020a2568cd000000b00da044538f10mr4777268ybc.43.1698511866663; Sat, 28
 Oct 2023 09:51:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231027135142.11555-1-daniel@iogearbox.net> <CAM0EoMm9K=jS=JZUNXo+C6qs=p=r7CtjWK20ocmTKEDxN3Bz-w@mail.gmail.com>
 <5ab182b6-6ac7-16f7-7eae-7001be2b6da7@iogearbox.net>
In-Reply-To: <5ab182b6-6ac7-16f7-7eae-7001be2b6da7@iogearbox.net>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 28 Oct 2023 12:50:55 -0400
Message-ID: <CAM0EoM=-UYDxdzXVWwv=aNYTbhogNdSO9xJ-MijCmOPnvKnLRg@mail.gmail.com>
Subject: Re: [PATCH net-next] net, sched: Fix SKB_NOT_DROPPED_YET splat under
 debug config
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: kuba@kernel.org, idosch@idosch.org, netdev@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 27, 2023 at 2:21=E2=80=AFPM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> On 10/27/23 7:24 PM, Jamal Hadi Salim wrote:
> > On Fri, Oct 27, 2023 at 9:51=E2=80=AFAM Daniel Borkmann <daniel@iogearb=
ox.net> wrote:
> >>
> >> Ido reported:
> >>
> >>    [...] getting the following splat [1] with CONFIG_DEBUG_NET=3Dy and=
 this
> >>    reproducer [2]. Problem seems to be that classifiers clear 'struct
> >>    tcf_result::drop_reason', thereby triggering the warning in
> >>    __kfree_skb_reason() due to reason being 'SKB_NOT_DROPPED_YET' (0).=
 [...]
> >>
> >>    [1]
> >>    WARNING: CPU: 0 PID: 181 at net/core/skbuff.c:1082 kfree_skb_reason=
+0x38/0x130
> >>    Modules linked in:
> >>    CPU: 0 PID: 181 Comm: mausezahn Not tainted 6.6.0-rc6-custom-ge43e6=
d9582e0 #682
> >>    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-=
1.fc37 04/01/2014
> >>    RIP: 0010:kfree_skb_reason+0x38/0x130
> >>    [...]
> >>    Call Trace:
> >>     <IRQ>
> >>     __netif_receive_skb_core.constprop.0+0x837/0xdb0
> >>     __netif_receive_skb_one_core+0x3c/0x70
> >>     process_backlog+0x95/0x130
> >>     __napi_poll+0x25/0x1b0
> >>     net_rx_action+0x29b/0x310
> >>     __do_softirq+0xc0/0x29b
> >>     do_softirq+0x43/0x60
> >>     </IRQ>
> >>
> >>    [2]
> >>    #!/bin/bash
> >>
> >>    ip link add name veth0 type veth peer name veth1
> >>    ip link set dev veth0 up
> >>    ip link set dev veth1 up
> >>    tc qdisc add dev veth1 clsact
> >>    tc filter add dev veth1 ingress pref 1 proto all flower dst_mac 00:=
11:22:33:44:55 action drop
> >>    mausezahn veth0 -a own -b 00:11:22:33:44:55 -q -c 1
> >>
> >> What happens is that inside most classifiers the tcf_result is copied =
over
> >> from a filter template e.g. *res =3D f->res which then implicitly over=
rides
> >> the prior SKB_DROP_REASON_TC_{INGRESS,EGRESS} default drop code which =
was
> >> set via sch_handle_{ingress,egress}() for kfree_skb_reason().
> >>
> >> Add a small helper tcf_set_result() and convert classifiers over to it=
.
> >> The latter leaves the drop code intact and classifiers, actions as wel=
l
> >> as the action engine in tcf_exts_exec() can then in future make use of
> >> tcf_set_drop_reason(), too.
> >>
> >> Tested that the splat is fixed under CONFIG_DEBUG_NET=3Dy with the rep=
ro.
> >>
> >> Fixes: 54a59aed395c ("net, sched: Make tc-related drop reason more fle=
xible")
> >> Reported-by: Ido Schimmel <idosch@idosch.org>
> >> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> >> Cc: Jamal Hadi Salim <jhs@mojatatu.com>
> >> Cc: Jakub Kicinski <kuba@kernel.org>
> >> Link: https://lore.kernel.org/netdev/ZTjY959R+AFXf3Xy@shredder
> >> ---
> >>   include/net/pkt_cls.h    | 12 ++++++++++++
> >>   net/sched/cls_basic.c    |  2 +-
> >>   net/sched/cls_bpf.c      |  2 +-
> >>   net/sched/cls_flower.c   |  2 +-
> >>   net/sched/cls_fw.c       |  2 +-
> >>   net/sched/cls_matchall.c |  2 +-
> >>   net/sched/cls_route.c    |  4 ++--
> >>   net/sched/cls_u32.c      |  2 +-
> >>   8 files changed, 20 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
> >> index a76c9171db0e..31d8e8587824 100644
> >> --- a/include/net/pkt_cls.h
> >> +++ b/include/net/pkt_cls.h
> >> @@ -160,6 +160,18 @@ static inline void tcf_set_drop_reason(struct tcf=
_result *res,
> >>          res->drop_reason =3D reason;
> >>   }
> >>
> >> +static inline void tcf_set_result(struct tcf_result *to,
> >> +                                 const struct tcf_result *from)
> >> +{
> >> +       /* tcf_result's drop_reason which is the last member must be
> >> +        * preserved and cannot be copied from the cls'es tcf_result
> >> +        * template given this is carried all the way and potentially
> >> +        * set to a concrete tc drop reason upon error or intentional
> >> +        * drop. See tcf_set_drop_reason() locations.
> >> +        */
> >> +       memcpy(to, from, offsetof(typeof(*to), drop_reason));
> >> +}
> >
> > I believe our bigger issue here is we are using this struct now for
> > both policy set by the control plane and for runtime decisions
>
> Hm, but that was also either way in the original rfc.
>

I lost track of the different versions, but one of the earlier ones did.

> > (drop_reason) - whereas the original assumption was this struct only
> > held set policy. In retrospect we should have put the verdict(which is
> > policy) here and return the error code (as was in the first patch). I
> > am also not sure humans would not make a mistake on "this field must
> > be at the end of the struct". Can we put some assert (or big comment
> > on the struct) to make sure someone does not overwrite this field?
>
> Yeah that can be done.
>
> > Also what happens if "from" above has a set drop_reason - is that
> > lost? Do you need an assert there as well?
>
> Why it's needed, do you have a use case for it?
>

I dont have an exact use case - more like making the API more future proof.

> > BTW: The simple patch i posted fixes the problem as well (i actually
> > tested it minus the typo i sent).
>
> It didn't compile for me, but if you think it's a better approach, yes,
> feel free to post it as a proper patch then.
>

Sorry, yes - what i posted wouldnt have compiled, it was just to
illustrate the idea (but i did test it after). In regards to the other
point you made on the action code the idea was Victor was going to
post a patch afterwards to cover other cases that are not covered in
the current case. But i can add the one check and will let Victor take
care of the rest.

> What I'm not quite following though is, I thought your original use case
> was that you want to be able to troubleshoot drops from unexpected
> locations (aka not policy) in the tc engine so won't this miss cases when
> you would then want to use tcf_set_drop_reason() e.g. from tcf_action_exe=
c()
> upon 'exception' cases (like the one for example I pointed out)? With the
> diff you proposed it will basically fallback to SKB_DROP_REASON_TC_{INGRE=
SS,
> EGRESS}, so override anything that would have been set from there.

The initial motivation was to deal with syzkaller injecting trickery
where the distinction between a verdict and a failure was in the grey
zone. CBQ for example was so susceptible we ended just deleting it
(well, it was also not really being used that much otherwise we would
have seen bug reports over the years).
This evolved to us wanting to track more where the errors were
happening in the code path (and tracing the return codes) to
eventually deciding what we needed was drop reason(and now drop
monitor).
The initialization you have is fine - if we go the tc_cb field setup
then we could initialize to SKB_DROP_REASON_TC_EGRESS for the other
qdiscs.

cheers,
jamal
> Thanks,
> Daniel

