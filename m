Return-Path: <bpf+bounces-61626-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C030DAE92DA
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 01:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C84393BC1B9
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 23:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8402D3ECC;
	Wed, 25 Jun 2025 23:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MycPMkPC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA101DE3A4;
	Wed, 25 Jun 2025 23:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750894882; cv=none; b=UBuhCfsEIP41u5s87UDcCejJurpybwpm3ofzp/N5eF4D+9JNhwghkNgOCXN9eoS/UbVGMW594c0RNyC00BfEl1oF/fifOsL53emn2Mcw/2/3vqPSbPrHhKR/ZT9plXk4mRNVhPrefLMi1P6bdfhp5TNGmssUc4U12hceWuEKSxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750894882; c=relaxed/simple;
	bh=JcOvlzNvywVVK4jYxjySPpT1xRN6YSGsX17iC4VOaXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nZB4jLvGEo17Rfwea89LcJrkRSOEUOQ8+3PesxD0t2fK15TXpTST0qLkXS3qm5hbcvtzO08kuL5aDPnSTlQ6wtaHB0KrO/D5Fq0uSAjicQKtFaB8lAgZ8zQ6AjlnBNR43uhEIVIsBziur+93JOdGX4XUAPz5J4JXkI7LI+otrLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MycPMkPC; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-739b3fe7ce8so636886b3a.0;
        Wed, 25 Jun 2025 16:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750894879; x=1751499679; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=d2THfCYLCxcyS3MXgMktBYh70OnJHIOwL+35e7pIkkU=;
        b=MycPMkPC2PRYa93xInFFJeKKqDdTxcC9AGkEtdCMZdKqA6n2d1Gn4Z8ssPX0HQm8f8
         VMb45pY/Iw/v7ByhtNMg/FnGI4wkGyCMpDqc8jIoCmkbHGTZDP0PoPVP20XVjx8eG3Fn
         tpuQtL5etRu6rtZOz911mCuWtFUuuyVQLaD+f+yzOq4AOAKKGaIgAp8DiJUuQbhoBxX8
         BbtIQiAEyKl5zHc+6FBCPvT1zMwED8GqMHtxZQJpizFgzQbWccReDNUnDl+ZEC6Y7vD4
         Z6Psq5mPz0VEEbXsNjSHOncK1hxfEQJAwgecq559bpGxc8SIljffLhUA9Hj6FUfxTsFy
         40ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750894879; x=1751499679;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d2THfCYLCxcyS3MXgMktBYh70OnJHIOwL+35e7pIkkU=;
        b=JQiO/OTpkiyKdc+JeZuWOXwtSAJlhE13xbJNXRUXGkDsubNBdnHlYd8mB23azLerOP
         R3+IIEaaerX6wwlwuP4Thhqrertn2IwWDQ03pPWrAWehTiJdbX+oIUyzxTH4DAxiGH3A
         qFr378KlgsOGqCjRbdjwVjAARb0sDp/VbZkgMPktnOEBc2TAO8ByHPf9maSgGZTOqwWV
         VvyHxx1BowEQzX/4ko1QQAmedgy5f0XqzpySIG5BKjqQyUniQ2rMFWhFWGkcr8O7Kz+/
         q1Hp3GSdRyNMGUEhnc+TliVSCUoDyj4GOgMXzCjc12DEemkPGdO+oHqKsqmj7GOsWZeB
         KHHg==
X-Forwarded-Encrypted: i=1; AJvYcCXM+BOasE4o8ExdzW67eMxKPf11z6SDeyI6iAnFp1LgGoItgwipRV5H1znRHhcSAzd9TaY=@vger.kernel.org, AJvYcCXZiLAemmZWQv/9F0h7c1p1k0p45Nq8hE9ImKin87tXKO+NAgfGbw+CSH2aQoLPRF/diCEMNbc8@vger.kernel.org
X-Gm-Message-State: AOJu0YwMgv/IKXVDbzHqPp2ZZdBvsvPxRZRClgRIAIpovBc72FAcHlPN
	e2caTuCnHt9E49yPzWY8i++No22DJ1GkXIPy3Hd75DFhmTCq6wUY1m0=
X-Gm-Gg: ASbGncv9thCo9+BTkwAsRVstjo9TL7v/0LDGmFjed7iH2UbrczrM1vGH0SAkIJmh/DN
	SIuuW3VViY4QHeBjdccGz96Juq+SEJmSSOszqRuUj8UIPOKqRVswbEpTpmeYYlvveXmOXuxA6vE
	1p4vIA3EihSKqfQ7RmvogWPXU1If7b5S1EHbOTHJLv+U9B9Rj5or99xXKIgEje/0L/rBTuimsGa
	PS7WwOJcXeK8nrPkAdnhRb4raPpjx2ky0dJYlyQCPg5SEiDuPGf30kIOLWbkvIDklTLygqWAsSt
	9ytL0sDtaN6nX0SryvlzJb8M29KFn1O9mdG8GIREUWewAS8V8Yvc1TNNpasSS15hWPgHmGXeRsu
	3hjnUHxqzGP0MS1W17NYUmUcxZbJqbnd8EQ==
X-Google-Smtp-Source: AGHT+IFYzole3NxKvRbcluivn67Hopg+6YSUD3/SU6mAH6wtzQl4XA+Zu9raVQyvNA9n9cHkh38vYA==
X-Received: by 2002:a05:6a00:2295:b0:740:9d7c:aeb9 with SMTP id d2e1a72fcca58-74ad44feab8mr7471409b3a.21.1750894879313;
        Wed, 25 Jun 2025 16:41:19 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-749c88730d9sm5453575b3a.171.2025.06.25.16.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 16:41:18 -0700 (PDT)
Date: Wed, 25 Jun 2025 16:41:18 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	bjorn@kernel.org, magnus.karlsson@intel.com,
	jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org,
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
	joe@dama.to, willemdebruijn.kernel@gmail.com, bpf@vger.kernel.org,
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next v3 2/2] selftests/bpf: check if the global
 consumer of tx queue updates after send call
Message-ID: <aFyJHm1yRo3o4X2K@mini-arch>
References: <20250625101014.45066-1-kerneljasonxing@gmail.com>
 <20250625101014.45066-3-kerneljasonxing@gmail.com>
 <aFvpNHqvZp0eishZ@boxer>
 <CAL+tcoBOpBxJN=S8FWgz++WxTzFP0rG-d+HRhSfZ6DLQjNuYtQ@mail.gmail.com>
 <aFwPCsSFkLYYoFu9@mini-arch>
 <CAL+tcoCSkXTJMPA7NQ7yEObmd2+HZ7mmppknq+yUUk=H4qYNow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoCSkXTJMPA7NQ7yEObmd2+HZ7mmppknq+yUUk=H4qYNow@mail.gmail.com>

On 06/25, Jason Xing wrote:
> On Wed, Jun 25, 2025 at 11:00 PM Stanislav Fomichev
> <stfomichev@gmail.com> wrote:
> >
> > On 06/25, Jason Xing wrote:
> > > On Wed, Jun 25, 2025 at 8:19 PM Maciej Fijalkowski
> > > <maciej.fijalkowski@intel.com> wrote:
> > > >
> > > > On Wed, Jun 25, 2025 at 06:10:14PM +0800, Jason Xing wrote:
> > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > >
> > > > > The subtest sends 33 packets at one time on purpose to see if xsk
> > > > > exitting __xsk_generic_xmit() updates the global consumer of tx queue
> > > > > when reaching the max loop (max_tx_budget, 32 by default). The number 33
> > > > > can avoid xskq_cons_peek_desc() updates the consumer, to accurately
> > > > > check if the issue that the first patch resolves remains.
> > > > >
> > > > > Speaking of the selftest implementation, it's not possible to use the
> > > > > normal validation_func to check if the issue happens because the whole
> > > > > send packets logic will call the sendto multiple times such that we're
> > > > > unable to detect in time.
> > > > >
> > > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > > ---
> > > > >  tools/testing/selftests/bpf/xskxceiver.c | 30 ++++++++++++++++++++++--
> > > > >  1 file changed, 28 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
> > > > > index 0ced4026ee44..f7aa83706bc7 100644
> > > > > --- a/tools/testing/selftests/bpf/xskxceiver.c
> > > > > +++ b/tools/testing/selftests/bpf/xskxceiver.c
> > > > > @@ -109,6 +109,8 @@
> > > > >
> > > > >  #include <network_helpers.h>
> > > > >
> > > > > +#define MAX_TX_BUDGET_DEFAULT 32
> > > >
> > > > and what if in the future you would increase the generic xmit budget on
> > > > the system? it would be better to wait with test addition when you
> > > > introduce the setsockopt patch.
> >
> > We can always update it to follow new budget. The purpose of the test
> > is to document/verify userspace expectations. Sincle even with the
> > setsockopt we are still gonna have the default budget.
> >
> > > > plus keep in mind that xskxceiver tests ZC drivers as well. so either we
> > > > should have a test that serves all modes or keep it for skb mode only.
> > > >
> > > > > +
> > > > >  static bool opt_verbose;
> > > > >  static bool opt_print_tests;
> > > > >  static enum test_mode opt_mode = TEST_MODE_ALL;
> > > > > @@ -1323,7 +1325,8 @@ static int receive_pkts(struct test_spec *test)
> > > > >       return TEST_PASS;
> > > > >  }
> > > > >
> > > > > -static int __send_pkts(struct ifobject *ifobject, struct xsk_socket_info *xsk, bool timeout)
> > > > > +static int __send_pkts(struct test_spec *test, struct ifobject *ifobject,
> > > > > +                    struct xsk_socket_info *xsk, bool timeout)
> > > > >  {
> > > > >       u32 i, idx = 0, valid_pkts = 0, valid_frags = 0, buffer_len;
> > > > >       struct pkt_stream *pkt_stream = xsk->pkt_stream;
> > > > > @@ -1437,9 +1440,21 @@ static int __send_pkts(struct ifobject *ifobject, struct xsk_socket_info *xsk, b
> > > > >       }
> > > > >
> > > > >       if (!timeout) {
> > > > > +             int prev_tx_consumer;
> > > > > +
> > > > > +             if (!strncmp("TX_QUEUE_CONSUMER", test->name, MAX_TEST_NAME_SIZE))
> > > > > +                     prev_tx_consumer = *xsk->tx.consumer;
> > > > > +
> > > > >               if (complete_pkts(xsk, i))
> > > > >                       return TEST_FAILURE;
> > > > >
> > > > > +             if (!strncmp("TX_QUEUE_CONSUMER", test->name, MAX_TEST_NAME_SIZE)) {
> > > > > +                     int delta = *xsk->tx.consumer - prev_tx_consumer;
> > > >
> > > > hacking the data path logic for single test purpose is rather not good.
> > > > I am also not really sure if this deserves a standalone test case or could
> > > > we just introduce a check in data path in appropriate place.
> > >
> > > The big headache is that if we expect to detect such a case, we have
> > > to re-invent a similar send packet logic or hack the data path (a bit
> > > like this patch). I admit it's ugly as I mentioned yesterday.
> > >
> > > Sorry, Stanislav, no offense here. If you read this, please don't
> > > blame me. I know you wish me to add one related test case. So here we
> > > are. Since Maciej brought up the similar thought, I keep wondering if
> > > we should give up such a standalone test patch? Honestly it already
> > > involved more time than expected. The primary reason for me is that
> > > the issue doesn't cause much trouble to the application.
> >
> > IIUC, Maciej does not suggest to completely drop the test but rather
> > to move this check (unconditionally and only for skb mode) somewhere
> 
> I prefer the former: make it suitable for all the cases. Whether it's
> zero copy mode or non-zc one, the behaviour of the consumer should be

But it does not work the same in zc and non-zc modes :-( There are
a bunch of (uncodumented) quirks here and there. With a test case we
can at least highlight/document them.

