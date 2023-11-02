Return-Path: <bpf+bounces-13935-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F9E7DEFAB
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 11:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A8CF2811BD
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 10:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E9A134BD;
	Thu,  2 Nov 2023 10:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TJFDrfDG"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4735C10969
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 10:17:31 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5858418A
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 03:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698920248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W/Wg2X4YPo+Bjzx5La1XsB4E8EgNOpRP54tEssaUvFk=;
	b=TJFDrfDGxE0sBbLY3b4vCaA+Cjuef4KbwVEoesfMxn/5Vrf0+YG/gznQFKXRQfAWXO6VAq
	j2/5lVZtPVSIm+PWAnYphREM3ChonbX6ekbdgwEH6jgogTnk3aiepAevckfbqB7oseCDty
	kIvZDyNPQPZi4rypxC2ucv1MMC7V8b4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-cbC_AFCQMyO5BuUwryHOKg-1; Thu, 02 Nov 2023 06:17:27 -0400
X-MC-Unique: cbC_AFCQMyO5BuUwryHOKg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4083a0fb583so825045e9.1
        for <bpf@vger.kernel.org>; Thu, 02 Nov 2023 03:17:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698920246; x=1699525046;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W/Wg2X4YPo+Bjzx5La1XsB4E8EgNOpRP54tEssaUvFk=;
        b=Zrr6EiKFJpSEdsXWyj8LKS7bfLy/FjlQYCiv0MTwDPvqlbm6eEHVAY6ckWmftTSZdy
         ke68SULitG+vLEpePz9path7ES4gCOGJo9itqIO6h69oK27/J6uWd25VxVhutT0FU9SO
         n2CfsJ3Gm1PLAHoedbUj9dTCpIL8DjwEwrecfwBwKao3XSJxkdaHOwNJ2WCNIzv6RtIx
         v9BbihUK99Hn4Udai8Wdcjz1rRK+iHbrlHnGWJ0/q0uozJMjkl0SUjoSLiSkAdRwMoYt
         UdZvqjzY5SfY4Xlp6JyPoYS3TjPhJl1PHW5EbiE/H5uAqOss1E4qnCpdWVPrJUqKcagB
         EsEw==
X-Gm-Message-State: AOJu0YweNmavDYJSWj6qGkaXveoSIyeeF2QetX+uSKlqeUJyqR253WOv
	QkpwafsfHtL0W2ymvzZtGbM+f+pZsxJq9ChHiCxq5w4CfwcF4rpufB7sMDqNTK1mylCrKKjd9vm
	Co6HmHDCrwSmr
X-Received: by 2002:a05:600c:3b8a:b0:408:3a29:d7e8 with SMTP id n10-20020a05600c3b8a00b004083a29d7e8mr14602889wms.3.1698920246009;
        Thu, 02 Nov 2023 03:17:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8JtjjJhmTWfixm105iEMyvMB1gRRMVzmXNWbA4dx+U8ZluROzNae9MKjaEt3KfuC5KAanWg==
X-Received: by 2002:a05:600c:3b8a:b0:408:3a29:d7e8 with SMTP id n10-20020a05600c3b8a00b004083a29d7e8mr14602871wms.3.1698920245582;
        Thu, 02 Nov 2023 03:17:25 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-226-153.dyn.eolo.it. [146.241.226.153])
        by smtp.gmail.com with ESMTPSA id o20-20020a05600c511400b004078d71be9csm2431299wms.13.2023.11.02.03.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 03:17:25 -0700 (PDT)
Message-ID: <5ca2062477738b804ce805847f7aec024ad5988c.camel@redhat.com>
Subject: Re: [PATCH net-next] net, sched: Fix SKB_NOT_DROPPED_YET splat
 under debug config
From: Paolo Abeni <pabeni@redhat.com>
To: Daniel Borkmann <daniel@iogearbox.net>, Jamal Hadi Salim
 <jhs@mojatatu.com>
Cc: kuba@kernel.org, idosch@idosch.org, netdev@vger.kernel.org, 
	bpf@vger.kernel.org
Date: Thu, 02 Nov 2023 11:17:23 +0100
In-Reply-To: <5ab182b6-6ac7-16f7-7eae-7001be2b6da7@iogearbox.net>
References: <20231027135142.11555-1-daniel@iogearbox.net>
	 <CAM0EoMm9K=jS=JZUNXo+C6qs=p=r7CtjWK20ocmTKEDxN3Bz-w@mail.gmail.com>
	 <5ab182b6-6ac7-16f7-7eae-7001be2b6da7@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2023-10-27 at 20:21 +0200, Daniel Borkmann wrote:
> On 10/27/23 7:24 PM, Jamal Hadi Salim wrote:
> > On Fri, Oct 27, 2023 at 9:51=E2=80=AFAM Daniel Borkmann <daniel@iogearb=
ox.net> wrote:
> > >=20
> > > Ido reported:
> > >=20
> > >    [...] getting the following splat [1] with CONFIG_DEBUG_NET=3Dy an=
d this
> > >    reproducer [2]. Problem seems to be that classifiers clear 'struct
> > >    tcf_result::drop_reason', thereby triggering the warning in
> > >    __kfree_skb_reason() due to reason being 'SKB_NOT_DROPPED_YET' (0)=
. [...]
> > >=20
> > >    [1]
> > >    WARNING: CPU: 0 PID: 181 at net/core/skbuff.c:1082 kfree_skb_reaso=
n+0x38/0x130
> > >    Modules linked in:
> > >    CPU: 0 PID: 181 Comm: mausezahn Not tainted 6.6.0-rc6-custom-ge43e=
6d9582e0 #682
> > >    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2=
-1.fc37 04/01/2014
> > >    RIP: 0010:kfree_skb_reason+0x38/0x130
> > >    [...]
> > >    Call Trace:
> > >     <IRQ>
> > >     __netif_receive_skb_core.constprop.0+0x837/0xdb0
> > >     __netif_receive_skb_one_core+0x3c/0x70
> > >     process_backlog+0x95/0x130
> > >     __napi_poll+0x25/0x1b0
> > >     net_rx_action+0x29b/0x310
> > >     __do_softirq+0xc0/0x29b
> > >     do_softirq+0x43/0x60
> > >     </IRQ>
> > >=20
> > >    [2]
> > >    #!/bin/bash
> > >=20
> > >    ip link add name veth0 type veth peer name veth1
> > >    ip link set dev veth0 up
> > >    ip link set dev veth1 up
> > >    tc qdisc add dev veth1 clsact
> > >    tc filter add dev veth1 ingress pref 1 proto all flower dst_mac 00=
:11:22:33:44:55 action drop
> > >    mausezahn veth0 -a own -b 00:11:22:33:44:55 -q -c 1
> > >=20
> > > What happens is that inside most classifiers the tcf_result is copied=
 over
> > > from a filter template e.g. *res =3D f->res which then implicitly ove=
rrides
> > > the prior SKB_DROP_REASON_TC_{INGRESS,EGRESS} default drop code which=
 was
> > > set via sch_handle_{ingress,egress}() for kfree_skb_reason().
> > >=20
> > > Add a small helper tcf_set_result() and convert classifiers over to i=
t.
> > > The latter leaves the drop code intact and classifiers, actions as we=
ll
> > > as the action engine in tcf_exts_exec() can then in future make use o=
f
> > > tcf_set_drop_reason(), too.
> > >=20
> > > Tested that the splat is fixed under CONFIG_DEBUG_NET=3Dy with the re=
pro.
> > >=20
> > > Fixes: 54a59aed395c ("net, sched: Make tc-related drop reason more fl=
exible")
> > > Reported-by: Ido Schimmel <idosch@idosch.org>
> > > Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> > > Cc: Jamal Hadi Salim <jhs@mojatatu.com>
> > > Cc: Jakub Kicinski <kuba@kernel.org>
> > > Link: https://lore.kernel.org/netdev/ZTjY959R+AFXf3Xy@shredder
> > > ---
> > >   include/net/pkt_cls.h    | 12 ++++++++++++
> > >   net/sched/cls_basic.c    |  2 +-
> > >   net/sched/cls_bpf.c      |  2 +-
> > >   net/sched/cls_flower.c   |  2 +-
> > >   net/sched/cls_fw.c       |  2 +-
> > >   net/sched/cls_matchall.c |  2 +-
> > >   net/sched/cls_route.c    |  4 ++--
> > >   net/sched/cls_u32.c      |  2 +-
> > >   8 files changed, 20 insertions(+), 8 deletions(-)
> > >=20
> > > diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
> > > index a76c9171db0e..31d8e8587824 100644
> > > --- a/include/net/pkt_cls.h
> > > +++ b/include/net/pkt_cls.h
> > > @@ -160,6 +160,18 @@ static inline void tcf_set_drop_reason(struct tc=
f_result *res,
> > >          res->drop_reason =3D reason;
> > >   }
> > >=20
> > > +static inline void tcf_set_result(struct tcf_result *to,
> > > +                                 const struct tcf_result *from)
> > > +{
> > > +       /* tcf_result's drop_reason which is the last member must be
> > > +        * preserved and cannot be copied from the cls'es tcf_result
> > > +        * template given this is carried all the way and potentially
> > > +        * set to a concrete tc drop reason upon error or intentional
> > > +        * drop. See tcf_set_drop_reason() locations.
> > > +        */
> > > +       memcpy(to, from, offsetof(typeof(*to), drop_reason));
> > > +}
> >=20
> > I believe our bigger issue here is we are using this struct now for
> > both policy set by the control plane and for runtime decisions
>=20
> Hm, but that was also either way in the original rfc.
>=20
> > (drop_reason) - whereas the original assumption was this struct only
> > held set policy. In retrospect we should have put the verdict(which is
> > policy) here and return the error code (as was in the first patch). I
> > am also not sure humans would not make a mistake on "this field must
> > be at the end of the struct". Can we put some assert (or big comment
> > on the struct) to make sure someone does not overwrite this field?
>=20
> Yeah that can be done.

FTR, I agree the comment or even better a build_bug_on() somewhere
should be better.

Thanks!

Paolo


