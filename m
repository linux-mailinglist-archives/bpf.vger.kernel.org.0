Return-Path: <bpf+bounces-61531-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62306AE874E
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 17:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B57467A8A84
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 14:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FBC1D79BE;
	Wed, 25 Jun 2025 15:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cir71NhG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E819886337;
	Wed, 25 Jun 2025 15:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750863632; cv=none; b=sTqUFvLp/sHEcm1Sr2IQXHOzFIud/G4D34QMRIK2TAYzY9AOUE7WTuspm+NZJPS3Q/CgJ7a7Y0577nADqw4ojxV941s6Pd+BXu/mk5HK4iTUFbP0I/FrSfdvMkVuGJo+0c0fKnNdItSJEqMGZagRqwscGddvw8p6ElnzCAt4vjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750863632; c=relaxed/simple;
	bh=04hZDSa5dfp5QBx/UKghRxt58+Rp5RuhRvj2FsZHUPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GgDJe2+X0g/tJFdObOjYKVBhybhnitmjhDCf+kgAcDlwbtPQoyqcpsVWTBsjWtf5K+lbxZp2YoY6jLd43tbXnv0F0aHhq0EQ6wN0tduLjdqO+oItWy3nRXONzucLUDmqW8Sg2bc+QH2pvtJ+eUkjaFMgi4/yZrwxJWCZFbS2hRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cir71NhG; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-236377f00easo77981445ad.1;
        Wed, 25 Jun 2025 08:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750863629; x=1751468429; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BpVDFsaxRO13hcMUIg0p/95ElwnYJ9p/X5LUJzR1M9o=;
        b=Cir71NhGSoc/kLU9TunN3vQzvl+35vYpNHtke0g57/Fqg8/DeKMKZVJE68STKXHuEd
         Ui1FNuHkuqlLruvWQJwI1SYG9fhUvGkvbdeVkKMZGc3Tvv/T9zya0YWyk3GYiw27taVQ
         kct+tUd3+i2XNcVOyLc+xZgmWh3Hv5yQV6w4t22F68ItJrTGI/RtahHSafkLZloN1V3o
         NIbewjA2FMS7D29enUioMZInZyvZR2IIX7ym+SkkA7gAYqoM2Wd6ksugomYtk2Gpc0Wm
         nnahcH4SbokNGlTHHzEb/EsKGjGg8HGK57sIYKGgmdO3KLIM5m9eHWPwPhYqe1txvP5k
         rWmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750863629; x=1751468429;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BpVDFsaxRO13hcMUIg0p/95ElwnYJ9p/X5LUJzR1M9o=;
        b=P0Dv0zSj0oCjqbyiBIZFPx7TUQqed6mG7PDreJmhu1dfj/q+xtHLd7EgtgedVTCn2F
         G19/wpczwntb3SsB1JvZ8dEIveA01iF86QPw3ExG97L2Oz4MioRDRiBLZVVE8pg9I0q8
         tJQmCAlAsUXqVMYRhJHuRezVWSdqdhcfau2NbPvl/eLhwB2aX4QJ4xViiEwkQd4FhrNj
         LeOZB5RiWTR416gtGBuRxHijf3/OW8M3XTQS0ZZyziF0Aqgy2EpC6fij0w0KpeNMorX8
         UALzX4ac59GPM6x0wVhGY8syvBXlmKQplEaHkNZ/wMM+bln7DVBRievT2YEHmgbG8YtN
         Dguw==
X-Forwarded-Encrypted: i=1; AJvYcCX5C5HVGGvNKve0v8vfE2iK9OrtPsSOPBnD8juR1LB+VCccnXr45wyEJcNMW5gUGyb5RESTkZ04@vger.kernel.org, AJvYcCXoWMQxuQJxCO8PCVnUB0lDYvj3eFwmhdweuvGpOIslDCMonxP0020kJlbMdmA0gG3JaCc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhx4lOiOSq4FFPaT9uQWo/HFyVeO9OzW+/XkuYH78fNqKc/Bcn
	Wzoty7fJv3aDzWLNt23af7+XOY7vaR8P+y7a24JEyIUyVwgNuixKyS5pMxkE
X-Gm-Gg: ASbGncsNzYrgYf9/WGO1KAPTCpRnqtMZIiMRYZmZDvXysi/AF4n2hG0m9ELD7SDEIVa
	zbpkXqubqCmga0dtfX5IQhh03sHt4bB+E8IYxVTEwerBblMjwoXXBnOnJundiJU0rRzKrs9jbWX
	U4qi4wlHAvx+Xyl2ubfp4vjpWanz1pIvz0iQ9j//LfeZKvGpgeQB1yR8MmY0IRESJ8lRrdfE2SU
	joAupTURondpYFuib3K8h4AafIqdrVoryEUnBsz+KXFruVqzQPZ4xMQcA8FbPfn/ngcmB78J0R4
	vNSeSYhQINrMQw7EwaL6kGTUPvp4ufsNnciEp5tNSXUFWEWREcXjYpLffueba2e0C0JDwSxMJNR
	rlPA6DhKD/67ye9WHR4kyGoI=
X-Google-Smtp-Source: AGHT+IH3C2HDdyZAVhghl52e1sdI8D71rgDIXzAD9AGVuXD18Ol/jkJ68CbU4ah5YIJ7mKRvVWyUsA==
X-Received: by 2002:a17:903:3c45:b0:235:a9b:21e0 with SMTP id d9443c01a7336-23823e4e1ccmr64319805ad.0.1750863628611;
        Wed, 25 Jun 2025 08:00:28 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-237d86e8fddsm134322065ad.210.2025.06.25.08.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 08:00:27 -0700 (PDT)
Date: Wed, 25 Jun 2025 08:00:26 -0700
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
Message-ID: <aFwPCsSFkLYYoFu9@mini-arch>
References: <20250625101014.45066-1-kerneljasonxing@gmail.com>
 <20250625101014.45066-3-kerneljasonxing@gmail.com>
 <aFvpNHqvZp0eishZ@boxer>
 <CAL+tcoBOpBxJN=S8FWgz++WxTzFP0rG-d+HRhSfZ6DLQjNuYtQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoBOpBxJN=S8FWgz++WxTzFP0rG-d+HRhSfZ6DLQjNuYtQ@mail.gmail.com>

On 06/25, Jason Xing wrote:
> On Wed, Jun 25, 2025 at 8:19 PM Maciej Fijalkowski
> <maciej.fijalkowski@intel.com> wrote:
> >
> > On Wed, Jun 25, 2025 at 06:10:14PM +0800, Jason Xing wrote:
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > The subtest sends 33 packets at one time on purpose to see if xsk
> > > exitting __xsk_generic_xmit() updates the global consumer of tx queue
> > > when reaching the max loop (max_tx_budget, 32 by default). The number 33
> > > can avoid xskq_cons_peek_desc() updates the consumer, to accurately
> > > check if the issue that the first patch resolves remains.
> > >
> > > Speaking of the selftest implementation, it's not possible to use the
> > > normal validation_func to check if the issue happens because the whole
> > > send packets logic will call the sendto multiple times such that we're
> > > unable to detect in time.
> > >
> > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > ---
> > >  tools/testing/selftests/bpf/xskxceiver.c | 30 ++++++++++++++++++++++--
> > >  1 file changed, 28 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
> > > index 0ced4026ee44..f7aa83706bc7 100644
> > > --- a/tools/testing/selftests/bpf/xskxceiver.c
> > > +++ b/tools/testing/selftests/bpf/xskxceiver.c
> > > @@ -109,6 +109,8 @@
> > >
> > >  #include <network_helpers.h>
> > >
> > > +#define MAX_TX_BUDGET_DEFAULT 32
> >
> > and what if in the future you would increase the generic xmit budget on
> > the system? it would be better to wait with test addition when you
> > introduce the setsockopt patch.

We can always update it to follow new budget. The purpose of the test
is to document/verify userspace expectations. Sincle even with the
setsockopt we are still gonna have the default budget.

> > plus keep in mind that xskxceiver tests ZC drivers as well. so either we
> > should have a test that serves all modes or keep it for skb mode only.
> >
> > > +
> > >  static bool opt_verbose;
> > >  static bool opt_print_tests;
> > >  static enum test_mode opt_mode = TEST_MODE_ALL;
> > > @@ -1323,7 +1325,8 @@ static int receive_pkts(struct test_spec *test)
> > >       return TEST_PASS;
> > >  }
> > >
> > > -static int __send_pkts(struct ifobject *ifobject, struct xsk_socket_info *xsk, bool timeout)
> > > +static int __send_pkts(struct test_spec *test, struct ifobject *ifobject,
> > > +                    struct xsk_socket_info *xsk, bool timeout)
> > >  {
> > >       u32 i, idx = 0, valid_pkts = 0, valid_frags = 0, buffer_len;
> > >       struct pkt_stream *pkt_stream = xsk->pkt_stream;
> > > @@ -1437,9 +1440,21 @@ static int __send_pkts(struct ifobject *ifobject, struct xsk_socket_info *xsk, b
> > >       }
> > >
> > >       if (!timeout) {
> > > +             int prev_tx_consumer;
> > > +
> > > +             if (!strncmp("TX_QUEUE_CONSUMER", test->name, MAX_TEST_NAME_SIZE))
> > > +                     prev_tx_consumer = *xsk->tx.consumer;
> > > +
> > >               if (complete_pkts(xsk, i))
> > >                       return TEST_FAILURE;
> > >
> > > +             if (!strncmp("TX_QUEUE_CONSUMER", test->name, MAX_TEST_NAME_SIZE)) {
> > > +                     int delta = *xsk->tx.consumer - prev_tx_consumer;
> >
> > hacking the data path logic for single test purpose is rather not good.
> > I am also not really sure if this deserves a standalone test case or could
> > we just introduce a check in data path in appropriate place.
> 
> The big headache is that if we expect to detect such a case, we have
> to re-invent a similar send packet logic or hack the data path (a bit
> like this patch). I admit it's ugly as I mentioned yesterday.
> 
> Sorry, Stanislav, no offense here. If you read this, please don't
> blame me. I know you wish me to add one related test case. So here we
> are. Since Maciej brought up the similar thought, I keep wondering if
> we should give up such a standalone test patch? Honestly it already
> involved more time than expected. The primary reason for me is that
> the issue doesn't cause much trouble to the application.

IIUC, Maciej does not suggest to completely drop the test but rather
to move this check (unconditionally and only for skb mode) somewhere
into __send_pkts/complete_pkts to make sure the number of completed
packets is always <= budget. Maciej correct me if I misread..

