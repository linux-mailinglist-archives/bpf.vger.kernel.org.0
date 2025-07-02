Return-Path: <bpf+bounces-62207-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E375AF6611
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 01:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2065524970
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 23:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFDC72D9EE1;
	Wed,  2 Jul 2025 23:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D93QC3r5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F16923A99D;
	Wed,  2 Jul 2025 23:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751497788; cv=none; b=tDc4+yaL/FAxLWoTQmXfsT7UJ/OgYkPRTtPx/iDDDtmrngeZxJZXLJZfVEyC1jekbYF1xGgciQv4s5hGfVwE2IbrD73YQ1TmM4IxbcLImcpZJWmogIVN7xiqjqWONQSUVX7x466blmh4VrDuN8AQAjq+XnX3tGJ8KQ8QGgxhknI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751497788; c=relaxed/simple;
	bh=uV4TkIxeORJ/qxzbkqXuZTta57Z8XxAbEdAXYELhZEk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M1Q4UUXDJnfgZo7/jzjhFdw7hQirSbKd0sHGN0CXX/tTEBYXTeQ6IYZLCN/zQAyVZfWM1OD4bvPhBTxbhUT7iJpv0QsE5hbkzLSdTtWvE69S59HS3grW/lNC6l+rHjk5nhgkNVDPFltGPszHYcIfB5Kmi3i7CGZ2LadQ91ul04M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D93QC3r5; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3df2d111fefso39946465ab.1;
        Wed, 02 Jul 2025 16:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751497786; x=1752102586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i3V/myxnyhBIMC4Q6lSBl6y0IMakKN7MT0xQVmCqag0=;
        b=D93QC3r5bscmQ9e7AbpnLuiPCPPOe5bGwpjMY7bo35Y8j06bfHDRuh0gmcDy5BcnMo
         lIu0qwbtw+XIIEuO765/DmFaVT6x3vDCVKLTSWPQfgPtdD4ZqW13E7pxMpAXJ2odj0jB
         qp7mnCMB3yy7fvQFdVI7mG/IjsObQjqunBRdIrL0ScypngW9eZDTqzoIXC7aItfewymV
         4yJlZ6hwCVi332W5ADnRVIlqxUJwdw2xvd0StcJud/qLa0ZoKLWeR4DZLq0twgPSZ59n
         pPGfwZDN0ZnH+SARdRLLR2g6kiK/ZPfVFv4/aqUMlxnzH9GJW/wlC2xP8kYgAPeu4Kv2
         aS9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751497786; x=1752102586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i3V/myxnyhBIMC4Q6lSBl6y0IMakKN7MT0xQVmCqag0=;
        b=qfKYFVYJSBsxHAOw/Wp6T25zCphUBIvC8bCjucICcXrnM0tLo9huigWo54aUSrxI3E
         QR34dRM8m62EpWYiqHo3/6qUNjjvBXpCPOTo3mjxYtirCBR9dGyRhSh3hhcBNyE1LnLM
         M7b127dzfFrDnxlKcU2qJVKZY64YW+2xOh6n1cSvDanL0ySfen2k6ysh3Xobvr70nj5H
         19LB0ZeX4I9PyDV2Fk59ttCjke8OHSe6aRlJRho237arUbZUlFAmxlzzc22ATFZ6pSVR
         /40DIRlq9unSruvTBHHEqLu/PJTF6Y2rx3LKxkCoKCw+BBZqY7xGO+Xvi+4fuBt/j/3f
         r3PQ==
X-Forwarded-Encrypted: i=1; AJvYcCUL5tHOd/PVHBCrakUcchBWTQN9m6TDOscFUkaiMib36k8DtAAN24fNLn5zguxf7NIL06o=@vger.kernel.org, AJvYcCW7uCea5BC9gBHHzhlscj8IGkUB6zav7Ei2roAAOJEiKUNp+MWbUYXWEQoIeQO9eGjOGpqXB9jV@vger.kernel.org
X-Gm-Message-State: AOJu0YyrzrjLpqduRaZsTdGUAyBk9VKfqZHTd2F5kQcj1yDNUP9B0NbM
	XgeSrcnS8pwfF4IMrWTfaMR1NE9UzqeAOMSPZhoc9LLN4L6FJwtoke21Sfx2Zu3JTHvbGWYFrAp
	Kf3mzL0Xl6XviGLNvj7QK6Xr3q/K+uDE=
X-Gm-Gg: ASbGncuwDc6QB7/Bv/hOOEoizsSBVOw0hi5ZPHVUjsuaA9j6iEEf9QiCYIVswm7Cvmk
	VgyBprSTJqTXO+NUAUD3j+MddpMZLPg8UgQwGyUg0E7JN8bi1EAi/GliSyVK8Nj79RVwl3uNkjB
	wXingxJ5/EESZGsbxsn8OTDWtvJVJldlWkxZ/QW4+DvMpwTTF7OFIN
X-Google-Smtp-Source: AGHT+IFkvbaStjGGGI2HKxZVMVKV5CbKnEr7Zc62b3ighPgrOj72EIBtD/5b+d1D12SnxC/TN8hbhTifhllpqiCkgMM=
X-Received: by 2002:a05:6e02:b42:b0:3e0:4f66:310a with SMTP id
 e9e14a558f8ab-3e05c323ff8mr20922075ab.16.1751497785720; Wed, 02 Jul 2025
 16:09:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702112815.50746-1-kerneljasonxing@gmail.com>
 <20250702112815.50746-3-kerneljasonxing@gmail.com> <aGVYNMZEZQV1SetF@mini-arch>
In-Reply-To: <aGVYNMZEZQV1SetF@mini-arch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 3 Jul 2025 07:09:09 +0800
X-Gm-Features: Ac12FXxGYI4c5qaS-XudzBLVLvLszNKYomzklNbPRmW-W3YC7WTpytTAUoeXCCw
Message-ID: <CAL+tcoA8Yhk85mkOBE9jEx7fd1s5rAW+Y8Uf2DAaNR3-9DW0Vg@mail.gmail.com>
Subject: Re: [PATCH net-next v5 2/2] selftests/bpf: add a new test to check
 the consumer update case
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, joe@dama.to, willemdebruijn.kernel@gmail.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 3, 2025 at 12:03=E2=80=AFAM Stanislav Fomichev <stfomichev@gmai=
l.com> wrote:
>
> On 07/02, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > The subtest sends 33 packets at one time on purpose to see if xsk
> > exitting __xsk_generic_xmit() updates the global consumer of tx queue
> > when reaching the max loop (max_tx_budget, 32 by default). The number 3=
3
> > can avoid xskq_cons_peek_desc() updates the consumer when it's about to
> > quit sending, to accurately check if the issue that the first patch
> > resolves remains. The new case will not check this issue in zero copy
> > mode.
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> > v5
> > Link: https://lore.kernel.org/all/20250627085745.53173-1-kerneljasonxin=
g@gmail.com/
> > 1. use the initial approach to add a new testcase
> > 2. add a new flag 'check_consumer' to see if the check is needed
> > ---
> >  tools/testing/selftests/bpf/xskxceiver.c | 51 +++++++++++++++++++++++-
> >  tools/testing/selftests/bpf/xskxceiver.h |  1 +
> >  2 files changed, 51 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/s=
elftests/bpf/xskxceiver.c
> > index 0ced4026ee44..ed12a55ecf2a 100644
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
> > @@ -1091,11 +1093,45 @@ static bool is_pkt_valid(struct pkt *pkt, void =
*buffer, u64 addr, u32 len)
> >       return true;
> >  }
> >
> > +static u32 load_value(u32 *counter)
> > +{
> > +     return __atomic_load_n(counter, __ATOMIC_ACQUIRE);
> > +}
> > +
> > +static bool kick_tx_with_check(struct xsk_socket_info *xsk, int *ret)
> > +{
> > +     u32 max_budget =3D MAX_TX_BUDGET_DEFAULT;
> > +     u32 cons, ready_to_send;
> > +     int delta;
> > +
> > +     cons =3D load_value(xsk->tx.consumer);
> > +     ready_to_send =3D load_value(xsk->tx.producer) - cons;
> > +     *ret =3D sendto(xsk_socket__fd(xsk->xsk), NULL, 0, MSG_DONTWAIT, =
NULL, 0);
> > +
> > +     delta =3D load_value(xsk->tx.consumer) - cons;
> > +     /* By default, xsk should consume exact @max_budget descs at one
> > +      * send in this case where hitting the max budget limit in while
> > +      * loop is triggered in __xsk_generic_xmit(). Please make sure th=
at
> > +      * the number of descs to be sent is larger than @max_budget, or
> > +      * else the tx.consumer will be updated in xskq_cons_peek_desc()
> > +      * in time which hides the issue we try to verify.
> > +      */
> > +     if (ready_to_send > max_budget && delta !=3D max_budget)
> > +             return false;
> > +
> > +     return true;
> > +}
> > +
> >  static int kick_tx(struct xsk_socket_info *xsk)
> >  {
> >       int ret;
> >
> > -     ret =3D sendto(xsk_socket__fd(xsk->xsk), NULL, 0, MSG_DONTWAIT, N=
ULL, 0);
> > +     if (xsk->check_consumer) {
> > +             if (!kick_tx_with_check(xsk, &ret))
> > +                     return TEST_FAILURE;
> > +     } else {
> > +             ret =3D sendto(xsk_socket__fd(xsk->xsk), NULL, 0, MSG_DON=
TWAIT, NULL, 0);
> > +     }
> >       if (ret >=3D 0)
> >               return TEST_PASS;
> >       if (errno =3D=3D ENOBUFS || errno =3D=3D EAGAIN || errno =3D=3D E=
BUSY || errno =3D=3D ENETDOWN) {
> > @@ -2613,6 +2649,18 @@ static int testapp_adjust_tail_grow_mb(struct te=
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
> > +     if (!(test->mode & TEST_MODE_ZC))
> > +             test->ifobj_tx->xsk->check_consumer =3D true;
>
> The test looks good to me, thank you!

Thanks.

>
> One question here: why not exit/return for TEST_MODE_ZC instead
> of conditionally setting check_consumer?

As you said, yes, we could skip the zc test for this
testapp_tx_queue_consumer(). It doesn't affect the goal or result of
the subtest. So do you expect me to respin this patch or just leave it
as is?

Thanks,
Jason

