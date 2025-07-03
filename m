Return-Path: <bpf+bounces-62282-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 077E5AF753D
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 15:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E49056319A
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 13:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE46E4A1E;
	Thu,  3 Jul 2025 13:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UvZ5+Q5C"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2021DDD1;
	Thu,  3 Jul 2025 13:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751548636; cv=none; b=PHTtavwZmBS4jXXvfp4LaDEOLUPhK6sknhV8hfWVlMnEFOgGeQfgbA2nGRUy/yOmAzv3oaxpoSfPhI7mVdUCxVq596kCiFE2PXTu8EFW5S63Qg4mmo9audNurQEi4xOnj0GSC7eUqmkt20+1O1zTNMs5K76DmlXBym3hq70AkuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751548636; c=relaxed/simple;
	bh=N9vx4nN/TtiQ7kDCz3sMGAFcDb/bYgvtZpWErpPG28s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jDmRkswuJLjDKZD/FgWjlya2yHO8ZS8aAKnpeLw8QNX90A8yYC393NsSH+F3JbeUI35JAEWQEYhD0Dt+bBM47JRnnsXGQ0b8s1QKzYbWHkflDg7i9t7WOYcvxnA53gWwypKxmwQ2Bcmulqc4LwX5Osx9rqFTeQ74RFhM5ayuOKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UvZ5+Q5C; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3d948ce7d9dso31691325ab.2;
        Thu, 03 Jul 2025 06:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751548634; x=1752153434; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0YTKQYtfASLZ4WUpXznMDU4LflCg1MNaJpuSyTx8YzU=;
        b=UvZ5+Q5Cn7L6qPOcIDagKnHnfBUw6yNHhyHsm9hBmGZxWGGKTwjUT4bgf1yk6++VCD
         ZjYdrlk8RDtPjD+leRwzTjMEM7c9y91bhIJ6BQRbd1YWsWLxQ6X+/nG9PGv7PLE2JM5E
         mVr0egBy6Gd9QwyoDQTsSMxKBHs9uDZ46OwbYwMemi5OEQ5POY5Yz5I0q/HSzlCyUl4y
         jZorJ3i6Y+mpbd1SH04AmVIjlYzXud2tvhswHyfdwnxBLl4O+Czd72YcSX8u4dfFXGKg
         s39RM5aRe7nuatvrYD054p2rWbs9qqqQt1rGSGAynrv+darZESdR3S0gw4aCw5d4SJWi
         XeAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751548634; x=1752153434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0YTKQYtfASLZ4WUpXznMDU4LflCg1MNaJpuSyTx8YzU=;
        b=Ldg8kcWXj8kxoj/fCZMOYFCRS0CWf7vR3GGfXYhEuVbgWWuU5/XwS4YRCtxD0YC32J
         /u5GeLCzOdfWYerGdbASjbzjMEXHdB62r5Swim/Oczb1/groVsJGpXCM+IHvQa6bStP1
         UEFmV5vdVy5k/uCp3iKpeEPMnFtM4sQVQoPxLqAROxT2CNX//CVrapPLrz5yPXrQCKhQ
         ZDxtb8BoE8MS0yjNm3b6j/OZoBt7k+N/1qDlqJUU9A2stiaHjNmwHy1wHtM8FmlTI8PT
         qijY2nA5uD6HkggdGR58P6kIiWq7D2Dfz+Dw0DJ4OYtqMrpLnNsxVTfHpIGsZkveXsO6
         C2BQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIVXXmQMs3x7QdHjaRK9TkguTMi02ZikIBu/dgpwZ1CZYZRwNzdsngIssNOSbpwRaNnj6y8f5k@vger.kernel.org, AJvYcCXE8KQ0IvA+Guwz3l6H6/eQT3/KgwT7lxwVVLATKer0PxRboixTG+PfF0gOvNSG53zuITs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOsUPT6Rl0eS0fgJauFhwf2kvAnAfam1enDEVeMBigpj/ZvyiT
	0kRVR1Rm1XAXNRpfaeozBL/LhC6jmJgMOcl2hkYQ2Oe8DYtsFQxZm83nvXKUttd/0QLZNtKdCb/
	BEElhvkzEVXd7neA4EWKJsoonzTHG2g0=
X-Gm-Gg: ASbGncvwixOK73c96jtmgjDqQ/McYp/Loj366SagwFsj3oo6cl8oYp6zzV1fE2/opiU
	A1p/0v3AxrVDaZbnWq7Bt56PF/xevPmP7RfssCYUookuvuta+903PvqpztMOw7pzs9K6kPyV5ku
	Ho9ie6RHvLcFa+Rxfj+Lh+YDeRmOzdolkbkJixJ47nbw==
X-Google-Smtp-Source: AGHT+IHpZju9DDW3thyUnIqv/xSVWfyOkcFJ+jcMFY3JRyCJOE3oyLV/2Ns2ixq64cxok3+TlxmpwRsmiQAUNILWDKo=
X-Received: by 2002:a92:c269:0:b0:3df:45bb:28fe with SMTP id
 e9e14a558f8ab-3e054934d51mr77786645ab.1.1751548633602; Thu, 03 Jul 2025
 06:17:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702112815.50746-1-kerneljasonxing@gmail.com>
 <20250702112815.50746-3-kerneljasonxing@gmail.com> <aGVYNMZEZQV1SetF@mini-arch>
 <CAL+tcoA8Yhk85mkOBE9jEx7fd1s5rAW+Y8Uf2DAaNR3-9DW0Vg@mail.gmail.com> <aGZ5dq5P0G8e8A/J@boxer>
In-Reply-To: <aGZ5dq5P0G8e8A/J@boxer>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 3 Jul 2025 21:16:36 +0800
X-Gm-Features: Ac12FXwc8V4qfJJdWFJ9Ko5PqZxJI_ZHNvnMbieyJC1gDAgvtlEKHdimQfLCK4k
Message-ID: <CAL+tcoCkZSOHy4zteK-pw8JgRNDr6oz2aSMmZEsmrP4onXWsDg@mail.gmail.com>
Subject: Re: [PATCH net-next v5 2/2] selftests/bpf: add a new test to check
 the consumer update case
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Stanislav Fomichev <stfomichev@gmail.com>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, bjorn@kernel.org, 
	magnus.karlsson@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, joe@dama.to, willemdebruijn.kernel@gmail.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 3, 2025 at 8:37=E2=80=AFPM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Thu, Jul 03, 2025 at 07:09:09AM +0800, Jason Xing wrote:
> > On Thu, Jul 3, 2025 at 12:03=E2=80=AFAM Stanislav Fomichev <stfomichev@=
gmail.com> wrote:
> > >
> > > On 07/02, Jason Xing wrote:
> > > > From: Jason Xing <kernelxing@tencent.com>
> > > >
> > > > The subtest sends 33 packets at one time on purpose to see if xsk
> > > > exitting __xsk_generic_xmit() updates the global consumer of tx que=
ue
> > > > when reaching the max loop (max_tx_budget, 32 by default). The numb=
er 33
> > > > can avoid xskq_cons_peek_desc() updates the consumer when it's abou=
t to
> > > > quit sending, to accurately check if the issue that the first patch
> > > > resolves remains. The new case will not check this issue in zero co=
py
> > > > mode.
> > > >
> > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > ---
> > > > v5
> > > > Link: https://lore.kernel.org/all/20250627085745.53173-1-kerneljaso=
nxing@gmail.com/
> > > > 1. use the initial approach to add a new testcase
> > > > 2. add a new flag 'check_consumer' to see if the check is needed
> > > > ---
> > > >  tools/testing/selftests/bpf/xskxceiver.c | 51 ++++++++++++++++++++=
+++-
> > > >  tools/testing/selftests/bpf/xskxceiver.h |  1 +
> > > >  2 files changed, 51 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testi=
ng/selftests/bpf/xskxceiver.c
> > > > index 0ced4026ee44..ed12a55ecf2a 100644
> > > > --- a/tools/testing/selftests/bpf/xskxceiver.c
> > > > +++ b/tools/testing/selftests/bpf/xskxceiver.c
> > > > @@ -109,6 +109,8 @@
> > > >
> > > >  #include <network_helpers.h>
> > > >
> > > > +#define MAX_TX_BUDGET_DEFAULT 32
> > > > +
> > > >  static bool opt_verbose;
> > > >  static bool opt_print_tests;
> > > >  static enum test_mode opt_mode =3D TEST_MODE_ALL;
> > > > @@ -1091,11 +1093,45 @@ static bool is_pkt_valid(struct pkt *pkt, v=
oid *buffer, u64 addr, u32 len)
> > > >       return true;
> > > >  }
> > > >
> > > > +static u32 load_value(u32 *counter)
> > > > +{
> > > > +     return __atomic_load_n(counter, __ATOMIC_ACQUIRE);
> > > > +}
> > > > +
> > > > +static bool kick_tx_with_check(struct xsk_socket_info *xsk, int *r=
et)
> > > > +{
> > > > +     u32 max_budget =3D MAX_TX_BUDGET_DEFAULT;
> > > > +     u32 cons, ready_to_send;
> > > > +     int delta;
> > > > +
> > > > +     cons =3D load_value(xsk->tx.consumer);
> > > > +     ready_to_send =3D load_value(xsk->tx.producer) - cons;
> > > > +     *ret =3D sendto(xsk_socket__fd(xsk->xsk), NULL, 0, MSG_DONTWA=
IT, NULL, 0);
> > > > +
> > > > +     delta =3D load_value(xsk->tx.consumer) - cons;
> > > > +     /* By default, xsk should consume exact @max_budget descs at =
one
> > > > +      * send in this case where hitting the max budget limit in wh=
ile
> > > > +      * loop is triggered in __xsk_generic_xmit(). Please make sur=
e that
> > > > +      * the number of descs to be sent is larger than @max_budget,=
 or
> > > > +      * else the tx.consumer will be updated in xskq_cons_peek_des=
c()
> > > > +      * in time which hides the issue we try to verify.
> > > > +      */
> > > > +     if (ready_to_send > max_budget && delta !=3D max_budget)
> > > > +             return false;
> > > > +
> > > > +     return true;
> > > > +}
> > > > +
> > > >  static int kick_tx(struct xsk_socket_info *xsk)
> > > >  {
> > > >       int ret;
> > > >
> > > > -     ret =3D sendto(xsk_socket__fd(xsk->xsk), NULL, 0, MSG_DONTWAI=
T, NULL, 0);
> > > > +     if (xsk->check_consumer) {
> > > > +             if (!kick_tx_with_check(xsk, &ret))
> > > > +                     return TEST_FAILURE;
> > > > +     } else {
> > > > +             ret =3D sendto(xsk_socket__fd(xsk->xsk), NULL, 0, MSG=
_DONTWAIT, NULL, 0);
> > > > +     }
> > > >       if (ret >=3D 0)
> > > >               return TEST_PASS;
> > > >       if (errno =3D=3D ENOBUFS || errno =3D=3D EAGAIN || errno =3D=
=3D EBUSY || errno =3D=3D ENETDOWN) {
> > > > @@ -2613,6 +2649,18 @@ static int testapp_adjust_tail_grow_mb(struc=
t test_spec *test)
> > > >                                  XSK_UMEM__LARGE_FRAME_SIZE * 2);
> > > >  }
> > > >
> > > > +static int testapp_tx_queue_consumer(struct test_spec *test)
> > > > +{
> > > > +     int nr_packets =3D MAX_TX_BUDGET_DEFAULT + 1;
> > > > +
> > > > +     pkt_stream_replace(test, nr_packets, MIN_PKT_SIZE);
> > > > +     test->ifobj_tx->xsk->batch_size =3D nr_packets;
> > > > +     if (!(test->mode & TEST_MODE_ZC))
> > > > +             test->ifobj_tx->xsk->check_consumer =3D true;
> > >
> > > The test looks good to me, thank you!
> >
> > Thanks.
> >
> > >
> > > One question here: why not exit/return for TEST_MODE_ZC instead
> > > of conditionally setting check_consumer?
> >
> > As you said, yes, we could skip the zc test for this
> > testapp_tx_queue_consumer(). It doesn't affect the goal or result of
> > the subtest. So do you expect me to respin this patch or just leave it
> > as is?
>
> Yes I think it would be worth respinning and skipping it for zc. see how
> testapp_stats_rx_dropped() does it.

Got it. I see:
        if (test->mode =3D=3D TEST_MODE_ZC) {
                ksft_test_result_skip("Can not run RX_DROPPED test for
ZC mode\n");
                return TEST_SKIP;
        }

>
> Otherwise we would probably never change it and just keep on running this
> test case for zc which is not beneficial at this point.
>
> Besides LGTM!

Thanks. Will repost it soon :)

>
> >
> > Thanks,
> > Jason

