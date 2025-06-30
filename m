Return-Path: <bpf+bounces-61820-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79394AEDCC2
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 14:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9950A3B74EE
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 12:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23ADF285C8D;
	Mon, 30 Jun 2025 12:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fj/xykQj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB1D27055A;
	Mon, 30 Jun 2025 12:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751286531; cv=none; b=k9seT1OChWMK8Rkjbwi4zpj9OJszSd33MbLq9bcK/oPqIoxnyERcuJJREDLdrSI47Uk6PfrfFssRoVJALnfncGcKduvz6gpBclN8+w5pWsnH+SWCPmnDPiV/qvuwrs8f2FKe3J0v4v66ZegiL7/hpEV/3xb0xnOLzefR8g03+AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751286531; c=relaxed/simple;
	bh=GqEGZN5fV4QTve/wWLhwxWc0UNDNh57LfRPNeuut5zo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WuD0CD+0NywxEEfra/wuRqksITjOORe+HzUENF4d3bQfEBzQIQf6BlEDnQYpgNgjHqW9TTMrAVf6QMdR3W1maOMs1cnN1puLzgakFakNvKeD41jH+vBsfkWBMoc+YWGjXT7EHvTiV7b53xuouGEv9lonvQ0gxF4puztSPjZbFCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fj/xykQj; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-86d0c598433so48874739f.3;
        Mon, 30 Jun 2025 05:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751286529; x=1751891329; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nlCtqtopdYKvjBv2GZ1LLi6Cxx9b4Hbtl7pDWVcHsy8=;
        b=fj/xykQj9T3btv/mjJR9wuSOSJZff+LYb+3WQUCXntQUnMEw6JbLVM40/2h/AeWzht
         WrGS6+ZRN1+3YHyVgO41l+uG92ymaHfhQPvKcNp3axN3eRxNzu/m5iZQ97ODDTzPl8N/
         0pLHOi9lZbTlYjGCauokfR5g2GBHRxhlAOBLrz92RSNXDzRC5HibAg15kyS8He1Nh6QX
         Gn3ez20w/OfgOfPAiGf8qm8VRNhEsSeYuzYG2z61XX4Jb1XNUedTLyql6pJs4bLYLl9c
         XHDOXIWuhWPoIpDeQRFSx0IiwuuidSsqJTsHvSUyvz5r2y0tkxto4oT1oANCr/Gp/Ct2
         gjlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751286529; x=1751891329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nlCtqtopdYKvjBv2GZ1LLi6Cxx9b4Hbtl7pDWVcHsy8=;
        b=JzJJY1aP3xb4MlAFGdCXpoSO0JcEE1dLmsfwS5l725szQHhU7LjlKCgFO9BIUWTBYg
         yKEZGtJ2p2tr+B/WuKrXjJczwCZJKstANECjW3HuHKmamOxkiCKCuxXSaW0ANn97JPZm
         zfCZwDvIZVFaOmOoGHObP5RkVotQK4ihApPvNpiJQ2JD82Sh0AMLaW5K/3Rl7dLwhZj2
         nxPG1I0y7QpVd9DmJ4UuUcQbG6VAF+6jx5Grc6+dMkHFEb+Uq0MyCqlJSppxTduggDB/
         H05De30lgAsKG4rsNN0dLjCgWThspn9wiXclTy/CJem3T7gAkvSnw/Gk5/WzN2/gmfev
         mu+A==
X-Forwarded-Encrypted: i=1; AJvYcCVtVyIuYvDibK7UUa/KfVPSCjEziQxohxilmSXDKRhZQFh+Y1ZMmUqgCoMDVucBxfJHK9Q=@vger.kernel.org, AJvYcCXwjFh1TCj28q5DkYEI/pCx8GFvC5eSPQi3+4Q4tbTCI3avs5oJEXmFx9lJ/t3+3ljnAPgUz2sv@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8/B5UZ9aI1K0AsKg3HYBXm0mN1ZRP0gX4sVWl95pbjADf0vgq
	I7Y8vVdEqc72MzAGti/k9I+UNZ4JZhKQ2uW4LCnze94JojgXlZ5Qc4MtYUBOOhhe0MiS625Tv6z
	DTzN8w+/0/CQV9HRcC1wJxtA670FaDlg=
X-Gm-Gg: ASbGncva7jDupZrgLs+gwNXOtNtNGmvINKPg8Z9etg7pwdDuREq7mflAzg3N12M5uYw
	s8JKjwWXtg9LUeTkGssWl5IUoUKe2fc/07e436qGwRduaD6wLqOFBB4JehfgNQg5AwXNn+as0B4
	2A0GsnjTeXtz5uNlaAGDoca8X/ZAgX0lv7h7B1DnDp9EA=
X-Google-Smtp-Source: AGHT+IGK/evr49z50keX0g9dRMoWNL54h8vNisHbsQVCOYx2Z7+C9W3/tCkX2pwQYY3rJ98TZeVCEdVbmw5UHxcOGTE=
X-Received: by 2002:a05:6e02:3801:b0:3dc:76ad:7990 with SMTP id
 e9e14a558f8ab-3df4aba113fmr152588925ab.15.1751286529040; Mon, 30 Jun 2025
 05:28:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627085745.53173-1-kerneljasonxing@gmail.com>
 <20250627085745.53173-3-kerneljasonxing@gmail.com> <aGJ9qiwNe5HBFxr2@boxer>
In-Reply-To: <aGJ9qiwNe5HBFxr2@boxer>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 30 Jun 2025 20:28:12 +0800
X-Gm-Features: Ac12FXyMatKHfCvYHdMiaKT2CvohIH_enxDb9alptyRxkQyx7HqwYXSYxj9tZDg
Message-ID: <CAL+tcoC1f+V5urtbWbTcnoPKZPAwZecarVf8oPuKynhHj8XvUg@mail.gmail.com>
Subject: Re: [PATCH net-next v4 2/2] selftests/bpf: check if the global
 consumer updates in time
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, joe@dama.to, 
	willemdebruijn.kernel@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2025 at 8:06=E2=80=AFPM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Fri, Jun 27, 2025 at 04:57:45PM +0800, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > This patch only checks non-zc mode and non STAT_TX_INVALID testcase. Th=
e
> > conditions are included in check_consumer().
> >
> > The policy of testing the issue is to recognize the max budget case whe=
re
> > the number of descs in the tx queue is larger than the default max budg=
et,
> > namely, 32, to make sure that 1) the max_batch error is triggered in
> > __xsk_generic_xmit(), 2) xskq_cons_peek_desc() doesn't have the chance
> > to update the global state of consumer at last. Hitting max budget case
> > is just one of premature exit cases but has the same result/action in
> > __xsk_generic_xmit().
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >  tools/testing/selftests/bpf/xskxceiver.c | 60 +++++++++++++++++++-----
> >  1 file changed, 48 insertions(+), 12 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/s=
elftests/bpf/xskxceiver.c
> > index 0ced4026ee44..694b0c0e1217 100644
> > --- a/tools/testing/selftests/bpf/xskxceiver.c
> > +++ b/tools/testing/selftests/bpf/xskxceiver.c
> > @@ -109,6 +109,8 @@
> >
> >  #include <network_helpers.h>
> >
> > +#define MAX_TX_BUDGET_DEFAULT 32
> > +
> >  static bool opt_verbose;
> >  static bool opt_print_tests;
> >  static enum test_mode opt_mode =3D TEST_MODE_ALL;
> > @@ -1091,11 +1093,34 @@ static bool is_pkt_valid(struct pkt *pkt, void =
*buffer, u64 addr, u32 len)
> >       return true;
> >  }
> >
> > -static int kick_tx(struct xsk_socket_info *xsk)
> > +static u32 load_value(u32 *a)
> >  {
> > -     int ret;
> > +     return __atomic_load_n(a, __ATOMIC_ACQUIRE);
> > +}
> > +
> > +static int kick_tx_with_check(struct xsk_socket_info *xsk)
> > +{
> > +     int ret, cons_delta;
> > +     u32 prev_cons;
> >
> > +     prev_cons =3D load_value(xsk->tx.consumer);
> >       ret =3D sendto(xsk_socket__fd(xsk->xsk), NULL, 0, MSG_DONTWAIT, N=
ULL, 0);
> > +     cons_delta =3D load_value(xsk->tx.consumer) - prev_cons;
> > +     if (cons_delta !=3D MAX_TX_BUDGET_DEFAULT)
> > +             return TEST_FAILURE;
> > +
> > +     return ret;
> > +}
> > +
> > +static int kick_tx(struct xsk_socket_info *xsk, bool check_cons)
> > +{
> > +     u32 ready_to_send =3D load_value(xsk->tx.producer) - load_value(x=
sk->tx.consumer);
> > +     int ret;
> > +
> > +     if (!check_cons || ready_to_send <=3D MAX_TX_BUDGET_DEFAULT)
> > +             ret =3D sendto(xsk_socket__fd(xsk->xsk), NULL, 0, MSG_DON=
TWAIT, NULL, 0);
> > +     else
> > +             ret =3D kick_tx_with_check(xsk);
> >       if (ret >=3D 0)
> >               return TEST_PASS;
> >       if (errno =3D=3D ENOBUFS || errno =3D=3D EAGAIN || errno =3D=3D E=
BUSY || errno =3D=3D ENETDOWN) {
> > @@ -1116,14 +1141,14 @@ static int kick_rx(struct xsk_socket_info *xsk)
> >       return TEST_PASS;
> >  }
> >
> > -static int complete_pkts(struct xsk_socket_info *xsk, int batch_size)
> > +static int complete_pkts(struct xsk_socket_info *xsk, int batch_size, =
bool check_cons)
>
> instead of sprinkling the booleans around the internals maybe you could
> achieve the same thing via flag added to xsk_socket_info?
>
> you could set this new flag to true for standalone test case then? so we
> would be sort of back to initial approach.
>
> now you have nicely narrowed it down to kick_tx() being modified. Just th=
e
> matter of passing the flag down.

I see. Thanks for the good suggestion.

Let me find out if it's easy to implement tomorrow morning.

Thanks,
Jason


>
> >  {
> >       unsigned int rcvd;
> >       u32 idx;
> >       int ret;
> >
> >       if (xsk_ring_prod__needs_wakeup(&xsk->tx)) {
> > -             ret =3D kick_tx(xsk);
> > +             ret =3D kick_tx(xsk, check_cons);
> >               if (ret)
> >                       return TEST_FAILURE;
> >       }
> > @@ -1323,7 +1348,17 @@ static int receive_pkts(struct test_spec *test)
> >       return TEST_PASS;
> >  }
> >
> > -static int __send_pkts(struct ifobject *ifobject, struct xsk_socket_in=
fo *xsk, bool timeout)
> > +bool check_consumer(struct test_spec *test)
> > +{
> > +     if (test->mode & TEST_MODE_ZC ||
> > +         !strncmp("STAT_TX_INVALID", test->name, MAX_TEST_NAME_SIZE))
> > +             return false;
> > +
> > +     return true;
> > +}
> > +
> > +static int __send_pkts(struct test_spec *test, struct ifobject *ifobje=
ct,
> > +                    struct xsk_socket_info *xsk, bool timeout)
> >  {
> >       u32 i, idx =3D 0, valid_pkts =3D 0, valid_frags =3D 0, buffer_len=
;
> >       struct pkt_stream *pkt_stream =3D xsk->pkt_stream;
> > @@ -1336,7 +1371,7 @@ static int __send_pkts(struct ifobject *ifobject,=
 struct xsk_socket_info *xsk, b
> >       /* pkts_in_flight might be negative if many invalid packets are s=
ent */
> >       if (pkts_in_flight >=3D (int)((umem_size(umem) - xsk->batch_size =
* buffer_len) /
> >           buffer_len)) {
> > -             ret =3D kick_tx(xsk);
> > +             ret =3D kick_tx(xsk, check_consumer(test));
> >               if (ret)
> >                       return TEST_FAILURE;
> >               return TEST_CONTINUE;
> > @@ -1365,7 +1400,7 @@ static int __send_pkts(struct ifobject *ifobject,=
 struct xsk_socket_info *xsk, b
> >                       }
> >               }
> >
> > -             complete_pkts(xsk, xsk->batch_size);
> > +             complete_pkts(xsk, xsk->batch_size, check_consumer(test))=
;
> >       }
> >
> >       for (i =3D 0; i < xsk->batch_size; i++) {
> > @@ -1437,7 +1472,7 @@ static int __send_pkts(struct ifobject *ifobject,=
 struct xsk_socket_info *xsk, b
> >       }
> >
> >       if (!timeout) {
> > -             if (complete_pkts(xsk, i))
> > +             if (complete_pkts(xsk, i, check_consumer(test)))
> >                       return TEST_FAILURE;
> >
> >               usleep(10);
> > @@ -1447,7 +1482,7 @@ static int __send_pkts(struct ifobject *ifobject,=
 struct xsk_socket_info *xsk, b
> >       return TEST_CONTINUE;
> >  }
> >
> > -static int wait_for_tx_completion(struct xsk_socket_info *xsk)
> > +static int wait_for_tx_completion(struct xsk_socket_info *xsk, bool ch=
eck_cons)
> >  {
> >       struct timeval tv_end, tv_now, tv_timeout =3D {THREAD_TMOUT, 0};
> >       int ret;
> > @@ -1466,7 +1501,7 @@ static int wait_for_tx_completion(struct xsk_sock=
et_info *xsk)
> >                       return TEST_FAILURE;
> >               }
> >
> > -             complete_pkts(xsk, xsk->batch_size);
> > +             complete_pkts(xsk, xsk->batch_size, check_cons);
> >       }
> >
> >       return TEST_PASS;
> > @@ -1492,7 +1527,7 @@ static int send_pkts(struct test_spec *test, stru=
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
> > @@ -1502,7 +1537,8 @@ static int send_pkts(struct test_spec *test, stru=
ct ifobject *ifobject)
> >                       if (ret =3D=3D TEST_PASS && timeout)
> >                               return ret;
> >
> > -                     ret =3D wait_for_tx_completion(&ifobject->xsk_arr=
[i]);
> > +                     ret =3D wait_for_tx_completion(&ifobject->xsk_arr=
[i],
> > +                                                  check_consumer(test)=
);
> >                       if (ret)
> >                               return TEST_FAILURE;
> >               }
> > --
> > 2.41.3
> >

