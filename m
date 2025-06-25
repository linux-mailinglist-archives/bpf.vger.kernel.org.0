Return-Path: <bpf+bounces-61538-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2149AE8864
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 17:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DED81C2027D
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 15:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E4E286D79;
	Wed, 25 Jun 2025 15:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gDJUwnA1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9301A1A5B8C;
	Wed, 25 Jun 2025 15:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750865763; cv=none; b=hr9DMIz6Ge61cJYLfU4l8wc4spY+obRBuflwfJlq5psZtnYXmk3HqiUQKg5pfYjLJCJHo2PCT92rKt6DGRimPqHsIuiYdWeQR6CFo4PQFfjEEgD1ktU+hByi//E0zIDFSLQN1YiM1z9dukxvxg2pAwDVmHN8+luRXgH7/WgpADA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750865763; c=relaxed/simple;
	bh=hAhusCY1UVLnO94T21z3T2KWMZUlcysfphh4UVB5qHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kPyyWZl3N+XrxE2EJv3q5mx9QrHg278ODBDHYpWmBN0BpB7oenKaZr5q9R0Dp/0US6Av5NBWvWC1RWDr754w37YbbMQNOq+T6ucAXCOgSIFTjfDRSKnb+M/Og2CZRNx8B0PLhkbirTo/4P97WIsqsWrMVykSE8shXG77KCjnuH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gDJUwnA1; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3df3891e28fso2476175ab.3;
        Wed, 25 Jun 2025 08:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750865760; x=1751470560; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NK9MPfAllBjkHvaYOVWvvQc2sKXH+SqHsWGRM8yc6ak=;
        b=gDJUwnA17xQPO5jrzBI3pSWK2U2AeD5oQa1YFZfcdChHg0VbAFxBkCqvVK4s9C3HAV
         0kqbTTMJPvVl/sPgVDioHWSW18NNU+Awhj8xloxJlaO8Obj7xXwk9X/TB3zJkTlTNfPd
         BsvB50KN+aEKsK0U0NVkxMbehjCEw5EFT9kYVO9dqPRES+LdaEWCw9UWERAkzWCERrNa
         WOoexQzIaitYkKdpKjOJs7x19r1Rtow+7fue6dz2pOBjaExx60ilTv+3+XL6NbpvYQuv
         PnHSO9OdiiCFQ+bkjFxVjc/x3Ur5dui20G1idSLcLB4NAH5MO6uRhX/f6Ff0g9fuF8rr
         s60w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750865760; x=1751470560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NK9MPfAllBjkHvaYOVWvvQc2sKXH+SqHsWGRM8yc6ak=;
        b=VdJ/G212ag8+FNva/cor2e1yIY4toiVstSBFcaTkDbRe1R2mhjThhvloshQCfit39k
         nbEb/ik+HQx6Nb6MSkOA37pAOd8fAjxTTwxJv5uwYvlHHITkAAe6ubpn39ulrJuixOCJ
         Blgh6cAv5EXdEt8EycKa+P2MCIyvhka3/LFx7B5/AU9yDhV2rff73digbvt3/afhu4/o
         T4LSmLPFmCDZVssiJkngrK2vRuHPyDEnhxQv6UpmPOEzVwI0ooeynwBiNM4HxJhqjKCy
         2vTAiFfSXsykgwBt0WRJesD2kMgV8lAomzG+4ROI/iTi9PRQWKNdT32sH4Ap6Nvrs6Td
         T4dA==
X-Forwarded-Encrypted: i=1; AJvYcCUm3VInRfZ5V74Xn31lC4GIFfwTigE3CqqUGP4bT4gUz11Pc/Ha7tfeyU7BCn+8qWgWJbM=@vger.kernel.org, AJvYcCVYN3DVbL1BsuKHcAS6/CWWYKcK83jYLfJyRSQxWz8g5UkgGm/sMxXsd8/OAGfSMAlTCyJjYqBM@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9Oe76Wzthr56lb5XNJJBRFMFoQKhgTOG3ViKeaJR3EU2v8lNZ
	4KURJRa/OISsh94aKTvqMbq1mBMtRPx8Wg3RdH2VqqKIy7NTxhZNjM7oczLKfGe8dEZ2O/sT8m+
	b/3EpRAfAvAf2smj7SyYtlnrNe5hkip8=
X-Gm-Gg: ASbGncuuAXGTVUYkOA5Z5+IxzbGvhuglcgk5DCDIRna+iEpQJOSRA8i+xsAbOyZz4LH
	PM3py6SheV2kJKf/p7eAp0K6fQjCXRnkedCoXHCwz3tRedE69vzCi8XNVc6grdAkvJGNcWma6UR
	92QdxcADfa9RWtzpfJDJmYvPp3pr9kb3j7ypT7nodFK1ZUEMMBT7xQ
X-Google-Smtp-Source: AGHT+IERgmnmOjY23EseJt15ylSqQKVtxKcAsqHnE3WPHQ9BBfbB7rHvb8+QCJvs8u+XEUcE2f7iWi4vkoJHv80dfG0=
X-Received: by 2002:a05:6e02:1aa5:b0:3df:3afa:28d6 with SMTP id
 e9e14a558f8ab-3df3afa2b15mr15671375ab.2.1750865760557; Wed, 25 Jun 2025
 08:36:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625101014.45066-1-kerneljasonxing@gmail.com>
 <20250625101014.45066-3-kerneljasonxing@gmail.com> <aFvpNHqvZp0eishZ@boxer>
 <CAL+tcoBOpBxJN=S8FWgz++WxTzFP0rG-d+HRhSfZ6DLQjNuYtQ@mail.gmail.com> <aFwPCsSFkLYYoFu9@mini-arch>
In-Reply-To: <aFwPCsSFkLYYoFu9@mini-arch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 25 Jun 2025 23:35:24 +0800
X-Gm-Features: Ac12FXzDIxa4RWiYBy3fCgTNd0fAGci_avC_xNybEZ33rwPKemMcbVgx6g99XgY
Message-ID: <CAL+tcoCSkXTJMPA7NQ7yEObmd2+HZ7mmppknq+yUUk=H4qYNow@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/2] selftests/bpf: check if the global
 consumer of tx queue updates after send call
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, bjorn@kernel.org, 
	magnus.karlsson@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, joe@dama.to, willemdebruijn.kernel@gmail.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 25, 2025 at 11:00=E2=80=AFPM Stanislav Fomichev
<stfomichev@gmail.com> wrote:
>
> On 06/25, Jason Xing wrote:
> > On Wed, Jun 25, 2025 at 8:19=E2=80=AFPM Maciej Fijalkowski
> > <maciej.fijalkowski@intel.com> wrote:
> > >
> > > On Wed, Jun 25, 2025 at 06:10:14PM +0800, Jason Xing wrote:
> > > > From: Jason Xing <kernelxing@tencent.com>
> > > >
> > > > The subtest sends 33 packets at one time on purpose to see if xsk
> > > > exitting __xsk_generic_xmit() updates the global consumer of tx que=
ue
> > > > when reaching the max loop (max_tx_budget, 32 by default). The numb=
er 33
> > > > can avoid xskq_cons_peek_desc() updates the consumer, to accurately
> > > > check if the issue that the first patch resolves remains.
> > > >
> > > > Speaking of the selftest implementation, it's not possible to use t=
he
> > > > normal validation_func to check if the issue happens because the wh=
ole
> > > > send packets logic will call the sendto multiple times such that we=
're
> > > > unable to detect in time.
> > > >
> > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > ---
> > > >  tools/testing/selftests/bpf/xskxceiver.c | 30 ++++++++++++++++++++=
++--
> > > >  1 file changed, 28 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testi=
ng/selftests/bpf/xskxceiver.c
> > > > index 0ced4026ee44..f7aa83706bc7 100644
> > > > --- a/tools/testing/selftests/bpf/xskxceiver.c
> > > > +++ b/tools/testing/selftests/bpf/xskxceiver.c
> > > > @@ -109,6 +109,8 @@
> > > >
> > > >  #include <network_helpers.h>
> > > >
> > > > +#define MAX_TX_BUDGET_DEFAULT 32
> > >
> > > and what if in the future you would increase the generic xmit budget =
on
> > > the system? it would be better to wait with test addition when you
> > > introduce the setsockopt patch.
>
> We can always update it to follow new budget. The purpose of the test
> is to document/verify userspace expectations. Sincle even with the
> setsockopt we are still gonna have the default budget.
>
> > > plus keep in mind that xskxceiver tests ZC drivers as well. so either=
 we
> > > should have a test that serves all modes or keep it for skb mode only=
.
> > >
> > > > +
> > > >  static bool opt_verbose;
> > > >  static bool opt_print_tests;
> > > >  static enum test_mode opt_mode =3D TEST_MODE_ALL;
> > > > @@ -1323,7 +1325,8 @@ static int receive_pkts(struct test_spec *tes=
t)
> > > >       return TEST_PASS;
> > > >  }
> > > >
> > > > -static int __send_pkts(struct ifobject *ifobject, struct xsk_socke=
t_info *xsk, bool timeout)
> > > > +static int __send_pkts(struct test_spec *test, struct ifobject *if=
object,
> > > > +                    struct xsk_socket_info *xsk, bool timeout)
> > > >  {
> > > >       u32 i, idx =3D 0, valid_pkts =3D 0, valid_frags =3D 0, buffer=
_len;
> > > >       struct pkt_stream *pkt_stream =3D xsk->pkt_stream;
> > > > @@ -1437,9 +1440,21 @@ static int __send_pkts(struct ifobject *ifob=
ject, struct xsk_socket_info *xsk, b
> > > >       }
> > > >
> > > >       if (!timeout) {
> > > > +             int prev_tx_consumer;
> > > > +
> > > > +             if (!strncmp("TX_QUEUE_CONSUMER", test->name, MAX_TES=
T_NAME_SIZE))
> > > > +                     prev_tx_consumer =3D *xsk->tx.consumer;
> > > > +
> > > >               if (complete_pkts(xsk, i))
> > > >                       return TEST_FAILURE;
> > > >
> > > > +             if (!strncmp("TX_QUEUE_CONSUMER", test->name, MAX_TES=
T_NAME_SIZE)) {
> > > > +                     int delta =3D *xsk->tx.consumer - prev_tx_con=
sumer;
> > >
> > > hacking the data path logic for single test purpose is rather not goo=
d.
> > > I am also not really sure if this deserves a standalone test case or =
could
> > > we just introduce a check in data path in appropriate place.
> >
> > The big headache is that if we expect to detect such a case, we have
> > to re-invent a similar send packet logic or hack the data path (a bit
> > like this patch). I admit it's ugly as I mentioned yesterday.
> >
> > Sorry, Stanislav, no offense here. If you read this, please don't
> > blame me. I know you wish me to add one related test case. So here we
> > are. Since Maciej brought up the similar thought, I keep wondering if
> > we should give up such a standalone test patch? Honestly it already
> > involved more time than expected. The primary reason for me is that
> > the issue doesn't cause much trouble to the application.
>
> IIUC, Maciej does not suggest to completely drop the test but rather
> to move this check (unconditionally and only for skb mode) somewhere

I prefer the former: make it suitable for all the cases. Whether it's
zero copy mode or non-zc one, the behaviour of the consumer should be
the same: update when finishing sending packets. I will give it a try
again tomorrow since it's too late for me right now. Sorry.

Thanks,
Jason

