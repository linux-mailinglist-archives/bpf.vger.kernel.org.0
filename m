Return-Path: <bpf+bounces-61523-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A52CAE837E
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 14:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 862117B794C
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 12:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2685A26156B;
	Wed, 25 Jun 2025 12:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nUPdAewk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127D025C711;
	Wed, 25 Jun 2025 12:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750856358; cv=none; b=c7rUFthS7+Ys7gjHd/xtN5wUtuu2zpSSiVo8cVz3YJuX/6LNUgkkPaxv3Dw2tQisaL6dyC8Gcncxj74iInSrirj27dEaWwz8ewyeYjmnracpWQHPCKkAU59vRCxdf5ItgMH32608gI3uUtxdvSPU6rNUITSmWFEsXDwSVWSF4bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750856358; c=relaxed/simple;
	bh=3ZiR3kldQGRT+JR9d+Zx8f32CMuMhnHnVPXPztjL2Bk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hb97clcw2NGQ4DLEzMgvxJJ71rPk9e/2wMpm2veHwszmPjvwI8ku5vX+ckGRF95zVWGRApE650M2EBdmbBWHPMsRYEbYcAxFVnHUe2iDgG71q4cZgSwMJOshHTDsECSnEQZ0a2owGGFFMh5PZyQDqPDZ3RkO5eWhKV7B41FU3II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nUPdAewk; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3df34b727dcso6648665ab.2;
        Wed, 25 Jun 2025 05:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750856356; x=1751461156; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fh536MjySsyUDG6DwugOcuSs/2WVvy3wzmDmQ2Jwj6c=;
        b=nUPdAewkXh37JWzsHvzDzdjCAsuvQzAjs+U85ODaOa8018ciJanSHUtEL2UUnjsLav
         SjwC+u+nmQl0cXtbdaCcXOMw/fdJBOIc8mnBV0RbnPoSpclKTFnfunuvKAHaqK/A5D8T
         J1116uMsECG+fQ0ImJBSHjT6I4uJ9it4ti6XI1riBypZI1FT5jixfpX1lLe1EC8TOtP/
         GzncLtPebm73cTQcghVSLBPUv6KFSO+mvxDY9zBL96Wa+ylPymLLhd5UxEc/IEdYIoD7
         Xl6Eamg3FgLKmyroDO90C2nl2ALIrvjV0Wpd/q4EfUY1PxtXHoAyxtSrOSEWGG/leUW8
         Mbfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750856356; x=1751461156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fh536MjySsyUDG6DwugOcuSs/2WVvy3wzmDmQ2Jwj6c=;
        b=Cs7hlsl7Y4avyeGIAgafZeUAHw70lFe/JKTgroWOj3KRfYqhIO1ihPp4mCuF2eRVsv
         wnP+6NitGffRW7Gg239d4hSre90i9B4N4MycMbQKpeV8n6h1cFKC3fqop3JFauSGE2eF
         sANI3XZA8+B0IsH3XAEn+eKpBLO1WREsMaMdVBzIllcB6/g47vNMUB+W+Set3p18M04y
         kRrBLkUJfcBHLh8TV7uFDq8gR0k3AezHrmqdulZHPu4dfm4JzIHiAOaYH03IDo1gogby
         yXsmhYnV7sNnNT6/zUWsB/MjyhbfBosH0B0C/nJwXx/4/JZ7TO3FDkhvyjAIyaTvkGET
         2FHA==
X-Forwarded-Encrypted: i=1; AJvYcCWqXI8TjRsWSwELVo5bjbmRDE9vSJW0t87jmoAJ8kEuZE/G/BHrIBtFfyDjrMahx8KqAJg=@vger.kernel.org, AJvYcCXPNGb1uR2jHr/McPtkQS6NvY/pHeALy/Ajcw7rN3wQPchEQr6py5yjTerhoHs3CsaMk73omsim@vger.kernel.org
X-Gm-Message-State: AOJu0YykefNYy/Ure5BoNMinjubsdr+DG8E87LoxdjzK4K19mVV2ElFu
	q2cdjGJfMiKXrkZ1xl0GdVjAflVd0SqDnMVQHXPKs/pXGuN7GYNqkNI99fN0uZlRHA/3r7nY4P3
	9t9/CAZCk6yzbJPyPsBJSBS1aSdOOWrw=
X-Gm-Gg: ASbGncsso4eWxIkakNVA/D/JnTNFMNpToMsYlZLvZmv/GkafpM8U20+4fVInWJYltws
	7fRZ5P0NIMVmnHT6dvRXJMVaK7R43zfW6uzezTxu2qGQPK16u+inIjG6s+jDsvS4OveLMj+R6EI
	UdkyIU+0wQIWv0V09b+0HrZbpt7glY/LylmTBoXdxTw8w=
X-Google-Smtp-Source: AGHT+IHcj0Wi0q1qsCWQgcLKjBYRLK6d4aCDMlhtkBlDngn2ZSxF6+rM4rPI3mZ19aCAuZeA1q5CknXX7b1BFWLNSl0=
X-Received: by 2002:a05:6e02:1a0f:b0:3de:281b:d0e4 with SMTP id
 e9e14a558f8ab-3df327fc2a2mr37898315ab.2.1750856356061; Wed, 25 Jun 2025
 05:59:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625101014.45066-1-kerneljasonxing@gmail.com>
 <20250625101014.45066-3-kerneljasonxing@gmail.com> <aFvpNHqvZp0eishZ@boxer>
In-Reply-To: <aFvpNHqvZp0eishZ@boxer>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 25 Jun 2025 20:58:39 +0800
X-Gm-Features: Ac12FXxFypVXdF1IXodPoD1OAx-EOH19pnFfEcLY20vyroa5yGzPf5knCklbQK4
Message-ID: <CAL+tcoBOpBxJN=S8FWgz++WxTzFP0rG-d+HRhSfZ6DLQjNuYtQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/2] selftests/bpf: check if the global
 consumer of tx queue updates after send call
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, joe@dama.to, 
	willemdebruijn.kernel@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 25, 2025 at 8:19=E2=80=AFPM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Wed, Jun 25, 2025 at 06:10:14PM +0800, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > The subtest sends 33 packets at one time on purpose to see if xsk
> > exitting __xsk_generic_xmit() updates the global consumer of tx queue
> > when reaching the max loop (max_tx_budget, 32 by default). The number 3=
3
> > can avoid xskq_cons_peek_desc() updates the consumer, to accurately
> > check if the issue that the first patch resolves remains.
> >
> > Speaking of the selftest implementation, it's not possible to use the
> > normal validation_func to check if the issue happens because the whole
> > send packets logic will call the sendto multiple times such that we're
> > unable to detect in time.
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >  tools/testing/selftests/bpf/xskxceiver.c | 30 ++++++++++++++++++++++--
> >  1 file changed, 28 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/s=
elftests/bpf/xskxceiver.c
> > index 0ced4026ee44..f7aa83706bc7 100644
> > --- a/tools/testing/selftests/bpf/xskxceiver.c
> > +++ b/tools/testing/selftests/bpf/xskxceiver.c
> > @@ -109,6 +109,8 @@
> >
> >  #include <network_helpers.h>
> >
> > +#define MAX_TX_BUDGET_DEFAULT 32
>
> and what if in the future you would increase the generic xmit budget on
> the system? it would be better to wait with test addition when you
> introduce the setsockopt patch.
>
> plus keep in mind that xskxceiver tests ZC drivers as well. so either we
> should have a test that serves all modes or keep it for skb mode only.
>
> > +
> >  static bool opt_verbose;
> >  static bool opt_print_tests;
> >  static enum test_mode opt_mode =3D TEST_MODE_ALL;
> > @@ -1323,7 +1325,8 @@ static int receive_pkts(struct test_spec *test)
> >       return TEST_PASS;
> >  }
> >
> > -static int __send_pkts(struct ifobject *ifobject, struct xsk_socket_in=
fo *xsk, bool timeout)
> > +static int __send_pkts(struct test_spec *test, struct ifobject *ifobje=
ct,
> > +                    struct xsk_socket_info *xsk, bool timeout)
> >  {
> >       u32 i, idx =3D 0, valid_pkts =3D 0, valid_frags =3D 0, buffer_len=
;
> >       struct pkt_stream *pkt_stream =3D xsk->pkt_stream;
> > @@ -1437,9 +1440,21 @@ static int __send_pkts(struct ifobject *ifobject=
, struct xsk_socket_info *xsk, b
> >       }
> >
> >       if (!timeout) {
> > +             int prev_tx_consumer;
> > +
> > +             if (!strncmp("TX_QUEUE_CONSUMER", test->name, MAX_TEST_NA=
ME_SIZE))
> > +                     prev_tx_consumer =3D *xsk->tx.consumer;
> > +
> >               if (complete_pkts(xsk, i))
> >                       return TEST_FAILURE;
> >
> > +             if (!strncmp("TX_QUEUE_CONSUMER", test->name, MAX_TEST_NA=
ME_SIZE)) {
> > +                     int delta =3D *xsk->tx.consumer - prev_tx_consume=
r;
>
> hacking the data path logic for single test purpose is rather not good.
> I am also not really sure if this deserves a standalone test case or coul=
d
> we just introduce a check in data path in appropriate place.

The big headache is that if we expect to detect such a case, we have
to re-invent a similar send packet logic or hack the data path (a bit
like this patch). I admit it's ugly as I mentioned yesterday.

Sorry, Stanislav, no offense here. If you read this, please don't
blame me. I know you wish me to add one related test case. So here we
are. Since Maciej brought up the similar thought, I keep wondering if
we should give up such a standalone test patch? Honestly it already
involved more time than expected. The primary reason for me is that
the issue doesn't cause much trouble to the application.

Thanks,
Jason

>
> > +
> > +                     if (delta !=3D MAX_TX_BUDGET_DEFAULT)
> > +                             return TEST_FAILURE;
> > +             }
> > +
> >               usleep(10);
> >               return TEST_PASS;
> >       }
> > @@ -1492,7 +1507,7 @@ static int send_pkts(struct test_spec *test, stru=
ct ifobject *ifobject)
> >                               __set_bit(i, bitmap);
> >                               continue;
> >                       }
> > -                     ret =3D __send_pkts(ifobject, &ifobject->xsk_arr[=
i], timeout);
> > +                     ret =3D __send_pkts(test, ifobject, &ifobject->xs=
k_arr[i], timeout);
> >                       if (ret =3D=3D TEST_CONTINUE && !test->fail)
> >                               continue;
> >
> > @@ -2613,6 +2628,16 @@ static int testapp_adjust_tail_grow_mb(struct te=
st_spec *test)
> >                                  XSK_UMEM__LARGE_FRAME_SIZE * 2);
> >  }
> >
> > +static int testapp_tx_queue_consumer(struct test_spec *test)
> > +{
> > +     int nr_packets =3D MAX_TX_BUDGET_DEFAULT + 1;
> > +
> > +     pkt_stream_replace(test, nr_packets, MIN_PKT_SIZE);
> > +     test->ifobj_tx->xsk->batch_size =3D nr_packets;
> > +
> > +     return testapp_validate_traffic(test);
> > +}
> > +
> >  static void run_pkt_test(struct test_spec *test)
> >  {
> >       int ret;
> > @@ -2723,6 +2748,7 @@ static const struct test_spec tests[] =3D {
> >       {.name =3D "XDP_ADJUST_TAIL_SHRINK_MULTI_BUFF", .test_func =3D te=
stapp_adjust_tail_shrink_mb},
> >       {.name =3D "XDP_ADJUST_TAIL_GROW", .test_func =3D testapp_adjust_=
tail_grow},
> >       {.name =3D "XDP_ADJUST_TAIL_GROW_MULTI_BUFF", .test_func =3D test=
app_adjust_tail_grow_mb},
> > +     {.name =3D "TX_QUEUE_CONSUMER", .test_func =3D testapp_tx_queue_c=
onsumer},
> >       };
> >
> >  static void print_tests(void)
> > --
> > 2.41.3
> >

