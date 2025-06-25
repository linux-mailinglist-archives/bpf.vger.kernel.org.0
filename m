Return-Path: <bpf+bounces-61627-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB06AE930F
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 01:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FC264A2594
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 23:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97EAC26E6EB;
	Wed, 25 Jun 2025 23:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ig1BzuB3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81ED6189F56;
	Wed, 25 Jun 2025 23:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750895744; cv=none; b=Ah0C/iD+UNbNokQjLlsJSbm7RGjtQ9YxU5GDPvWouJ1pBJCVAcg+PC2EUhgHnLh9yD4crxwPIta8+gLFwLfhlFZJeaVWXpcFTyhK2gfkfw0jK0Ub1gvbi+2VTrXSiH2LlLEstVEkepH0Ag5Sd7FnjSm8YUSLn4swp519hsNttu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750895744; c=relaxed/simple;
	bh=MYd6x/orymx3xvSlhnVj3nFRJLi4WcYAlXUp+eoRQog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UD38PIL33qQFaoYSAHlwDTmqRIAw/C6BdghzLnGMaR+l5DxHHt9diKPiG5/e9X0Vmix4s/bS38/fLCRBDknGR/WyxU8lRrDSZs8BBNbyaCO0oauEVcRUqvSkLMYXwNveI6myAQZ2/MrqV0Xdayna5X0yvdcdoB1uEh+acYtaMxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ig1BzuB3; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3df2d111fefso3488515ab.1;
        Wed, 25 Jun 2025 16:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750895741; x=1751500541; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VqE7yVyjqOjv8t4ldHQCRA7XDUn4eDEaJbZXqBDghbU=;
        b=Ig1BzuB3Rhogru1TGplMPEeg7JFdj15iP3U7vzW9kdIW6TLg9+Mm1TIo5RAlFPLVbq
         5nkipr5xjbeVvyISEX1hIpX4ZkuKRkR5SF3p2d8VVg4oaefYk5SjdJb4N1MyGsAUIpAv
         CJPD2b8oCbkaul1+DJJvCBEjwIDwGFjpsHT0TFfVp0l9op4heDSdouc3vZJpHUc5yKL7
         2//3BYzeAXGMMNXWMqUexiZmtWYoJ1CsSU5nDiiD72BNp0UhGnN04+o5OoHADFB2My8A
         /1j75i85i0YsELGdijWQXXhuADhFToE3UeOT1W0xO3NZ9hr2A/vXw/TCQJywkJvbTajC
         tjNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750895741; x=1751500541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VqE7yVyjqOjv8t4ldHQCRA7XDUn4eDEaJbZXqBDghbU=;
        b=HzOMu1ibQw3qO9yku2i+epmobHARcpayQ7e6RK/JnAEiajhI4Ti7GzZveKdXE2gbNd
         ktLcdhCAXfhNDCChWdusIdk4qo6tME7xa30WIogGaoMzWQF2DVbu95xIxm8MuBIkc9st
         eEpKfD4jBfRH17nWkRfJR24Q11F7o0AFEKKJ35FNtlBQQSUEnj+MCNSJBKD/C5BCK6y2
         8UeyZCn3pxO0k+WdcgVbTR54esaZ0109vGh5tARBkBotiNpobm0SC+c5Yzy1CwkZnUH2
         izZFhFqvOVQd7D58A6A/i4X4aVgHGvVDG+ec0FfGJUoMHehc4ornY92ZVB6lXt/kwBbb
         bhFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOS4NOYj8gNi2MyboMQHF8Rp58UFX6+8FGxVwHnOLR+FCNF6H8gFusae6gljHG+2VCssQ=@vger.kernel.org, AJvYcCWD684S8Q10N/yXzF0LdkMjjmvfBkrCwqEAqOq4F6G4mN53enXkfzwYq3dTcVRd5z0S7j2usBxo@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+p16ldDR2bnIWp8ka3+8Kpd+IyocO3RNHnCAlNj+yBGjW0Hn5
	CDkWKiTIPc26xw26kflwjFIuyGxqNGeNtB4RI3M1ZXLeabnKJ6tHrM6MMisUS+SEtMQMtXfFD9x
	Fu9UWpILzqWWTCTmHm7tHK4wQoQLdvL0=
X-Gm-Gg: ASbGncvpDFeLBTE8NbIw28BYtV29D1xHK6bjPNJar0A3tJV/Fn0bPBu/BlE+PuBS5fo
	R2eMuSNmxSPd/40Wo9yUgZYqkH36n0UCPYKBT3nSnr6Fs1sfwVpNPT3PLOYdQJPlx2WJTCWJSlB
	pu+tn4W3gbMU8PmlGN/sXn1fYGDuBKKr0eqTGwZVmUL5k=
X-Google-Smtp-Source: AGHT+IHpsYd6S2l9HTk1dMfyi4QiphFWxOk12tAZHe+eDvxymEmmr/KyfsAU4Z52QkyOdRzHcwKmS5v3QhBECakrKZw=
X-Received: by 2002:a05:6e02:170b:b0:3dd:c40d:787e with SMTP id
 e9e14a558f8ab-3df328503fbmr73283075ab.2.1750895741553; Wed, 25 Jun 2025
 16:55:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625101014.45066-1-kerneljasonxing@gmail.com>
 <20250625101014.45066-3-kerneljasonxing@gmail.com> <aFvpNHqvZp0eishZ@boxer>
 <CAL+tcoBOpBxJN=S8FWgz++WxTzFP0rG-d+HRhSfZ6DLQjNuYtQ@mail.gmail.com>
 <aFwPCsSFkLYYoFu9@mini-arch> <CAL+tcoCSkXTJMPA7NQ7yEObmd2+HZ7mmppknq+yUUk=H4qYNow@mail.gmail.com>
 <aFyJHm1yRo3o4X2K@mini-arch>
In-Reply-To: <aFyJHm1yRo3o4X2K@mini-arch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 26 Jun 2025 07:55:05 +0800
X-Gm-Features: Ac12FXwo86ufZJXJ1jVhvUv4B9MvYtT6RPkwkhk_Ofq1H2gIR_FmnPWc3-vYeIE
Message-ID: <CAL+tcoB5P=050--pFb4EWPukRCrgTjGkggORxy_eU8sD+giabA@mail.gmail.com>
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

On Thu, Jun 26, 2025 at 7:41=E2=80=AFAM Stanislav Fomichev <stfomichev@gmai=
l.com> wrote:
>
> On 06/25, Jason Xing wrote:
> > On Wed, Jun 25, 2025 at 11:00=E2=80=AFPM Stanislav Fomichev
> > <stfomichev@gmail.com> wrote:
> > >
> > > On 06/25, Jason Xing wrote:
> > > > On Wed, Jun 25, 2025 at 8:19=E2=80=AFPM Maciej Fijalkowski
> > > > <maciej.fijalkowski@intel.com> wrote:
> > > > >
> > > > > On Wed, Jun 25, 2025 at 06:10:14PM +0800, Jason Xing wrote:
> > > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > > >
> > > > > > The subtest sends 33 packets at one time on purpose to see if x=
sk
> > > > > > exitting __xsk_generic_xmit() updates the global consumer of tx=
 queue
> > > > > > when reaching the max loop (max_tx_budget, 32 by default). The =
number 33
> > > > > > can avoid xskq_cons_peek_desc() updates the consumer, to accura=
tely
> > > > > > check if the issue that the first patch resolves remains.
> > > > > >
> > > > > > Speaking of the selftest implementation, it's not possible to u=
se the
> > > > > > normal validation_func to check if the issue happens because th=
e whole
> > > > > > send packets logic will call the sendto multiple times such tha=
t we're
> > > > > > unable to detect in time.
> > > > > >
> > > > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > > > ---
> > > > > >  tools/testing/selftests/bpf/xskxceiver.c | 30 ++++++++++++++++=
++++++--
> > > > > >  1 file changed, 28 insertions(+), 2 deletions(-)
> > > > > >
> > > > > > diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/t=
esting/selftests/bpf/xskxceiver.c
> > > > > > index 0ced4026ee44..f7aa83706bc7 100644
> > > > > > --- a/tools/testing/selftests/bpf/xskxceiver.c
> > > > > > +++ b/tools/testing/selftests/bpf/xskxceiver.c
> > > > > > @@ -109,6 +109,8 @@
> > > > > >
> > > > > >  #include <network_helpers.h>
> > > > > >
> > > > > > +#define MAX_TX_BUDGET_DEFAULT 32
> > > > >
> > > > > and what if in the future you would increase the generic xmit bud=
get on
> > > > > the system? it would be better to wait with test addition when yo=
u
> > > > > introduce the setsockopt patch.
> > >
> > > We can always update it to follow new budget. The purpose of the test
> > > is to document/verify userspace expectations. Sincle even with the
> > > setsockopt we are still gonna have the default budget.
> > >
> > > > > plus keep in mind that xskxceiver tests ZC drivers as well. so ei=
ther we
> > > > > should have a test that serves all modes or keep it for skb mode =
only.
> > > > >
> > > > > > +
> > > > > >  static bool opt_verbose;
> > > > > >  static bool opt_print_tests;
> > > > > >  static enum test_mode opt_mode =3D TEST_MODE_ALL;
> > > > > > @@ -1323,7 +1325,8 @@ static int receive_pkts(struct test_spec =
*test)
> > > > > >       return TEST_PASS;
> > > > > >  }
> > > > > >
> > > > > > -static int __send_pkts(struct ifobject *ifobject, struct xsk_s=
ocket_info *xsk, bool timeout)
> > > > > > +static int __send_pkts(struct test_spec *test, struct ifobject=
 *ifobject,
> > > > > > +                    struct xsk_socket_info *xsk, bool timeout)
> > > > > >  {
> > > > > >       u32 i, idx =3D 0, valid_pkts =3D 0, valid_frags =3D 0, bu=
ffer_len;
> > > > > >       struct pkt_stream *pkt_stream =3D xsk->pkt_stream;
> > > > > > @@ -1437,9 +1440,21 @@ static int __send_pkts(struct ifobject *=
ifobject, struct xsk_socket_info *xsk, b
> > > > > >       }
> > > > > >
> > > > > >       if (!timeout) {
> > > > > > +             int prev_tx_consumer;
> > > > > > +
> > > > > > +             if (!strncmp("TX_QUEUE_CONSUMER", test->name, MAX=
_TEST_NAME_SIZE))
> > > > > > +                     prev_tx_consumer =3D *xsk->tx.consumer;
> > > > > > +
> > > > > >               if (complete_pkts(xsk, i))
> > > > > >                       return TEST_FAILURE;
> > > > > >
> > > > > > +             if (!strncmp("TX_QUEUE_CONSUMER", test->name, MAX=
_TEST_NAME_SIZE)) {
> > > > > > +                     int delta =3D *xsk->tx.consumer - prev_tx=
_consumer;
> > > > >
> > > > > hacking the data path logic for single test purpose is rather not=
 good.
> > > > > I am also not really sure if this deserves a standalone test case=
 or could
> > > > > we just introduce a check in data path in appropriate place.
> > > >
> > > > The big headache is that if we expect to detect such a case, we hav=
e
> > > > to re-invent a similar send packet logic or hack the data path (a b=
it
> > > > like this patch). I admit it's ugly as I mentioned yesterday.
> > > >
> > > > Sorry, Stanislav, no offense here. If you read this, please don't
> > > > blame me. I know you wish me to add one related test case. So here =
we
> > > > are. Since Maciej brought up the similar thought, I keep wondering =
if
> > > > we should give up such a standalone test patch? Honestly it already
> > > > involved more time than expected. The primary reason for me is that
> > > > the issue doesn't cause much trouble to the application.
> > >
> > > IIUC, Maciej does not suggest to completely drop the test but rather
> > > to move this check (unconditionally and only for skb mode) somewhere
> >
> > I prefer the former: make it suitable for all the cases. Whether it's
> > zero copy mode or non-zc one, the behaviour of the consumer should be
>
> But it does not work the same in zc and non-zc modes :-( There are
> a bunch of (uncodumented) quirks here and there. With a test case we
> can at least highlight/document them.

Oh, sorry, I didn't explain myself well. I was trying to say I would
add in the data path so that the new test patch can easily recognize
the problem for generic xmit path (in either mode just for
compatibility).

Do you have any good advice to continue to do such a thing you mentioned?

Thanks,
Jason

