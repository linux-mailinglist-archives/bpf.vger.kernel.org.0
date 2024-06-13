Return-Path: <bpf+bounces-32043-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57076906447
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 08:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1551284F6E
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 06:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC45913791B;
	Thu, 13 Jun 2024 06:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WwueXspO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FE81369B0;
	Thu, 13 Jun 2024 06:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718260992; cv=none; b=K1LYE6f/hBAbcsCKXVnzOqnpys9vdeUVB9GaK8/DlXUptzIK7ekgl8w1vNatVVPNNV0S3Hauvhlmr8jq1gA1fGfiBTPl0wTyqATxG9XwU8rMBmsywz0W76hDxJtM8RStuM0ruv/4pJ/7WTV9nbGxJvFkXQwLsisAxeneWXZZOUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718260992; c=relaxed/simple;
	bh=aVw2orsoCJBRLL7ubOJpxqa7rJllpYCo+Yila4F04Pw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rar/J3YkfAO8JWRnXt0eCo5OOq6HIf+lI9ZbpusNl0Ir7jhedJkMaE+M4A1hqL4XUoDCrHSfZB/mPLdordZPBcLMiWRisEkQ6jFGJlvWAOk9EWmMOWpVrCSTkVky2IOxAK291J4CruGJsUGSzkSf0kCDCVA4TFBmD/N7NpeGbWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WwueXspO; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-62f79de5f49so896607b3.2;
        Wed, 12 Jun 2024 23:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718260989; x=1718865789; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DIkEXiCbdHBjfOGWnmQQ77fch7SYE211jsaY4bM0/Dk=;
        b=WwueXspOfS9e4Rw4lbKYuh+b5p8BFh9wTvjVvx1kBI74wxAFCv3/7ZvXKi7KPFaQtW
         V8sVq80KPy5IvUpQSQSbKSTyOwHnlVyjlcv/eoDV7jXAOyzjWC7JreEfyYCz10eAD4vK
         ZaRWcH8X/IAHx7c5fX6lNmIjthM/OnjLL+HF9fp6G1Yhyhl1LGnFGany0lZ3JzveWrTS
         cburQL3GjUnNpjZyZpigqLqCXC9FtQ/uCmgVSiWTxEbuSySALh5RKyKHErQ+AfSP4jpC
         Bs/91eIFM5MeffbiTSOTsMoyF+e5FdkGjw9gAgKGv9InmmpTYJtwJqbeVuoucitMTJJv
         btJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718260989; x=1718865789;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DIkEXiCbdHBjfOGWnmQQ77fch7SYE211jsaY4bM0/Dk=;
        b=KgwWKCb9TOF0feiUcjyS9JRPT4nbdHAtlN/1jH0WVswZi7YczN+606iiplXqHxP1Ii
         RQpBOJV1JiqGsF6/oRZpjIPE3Klm2JXHvDWxYS7J+3bZjEibYDPIcqTCB/S0BKwUBZGh
         hZAztkoMDvvuPtIyoPm+6LGQJZb2dRQOVLc3QSFK0c54P+n0G5SKFxcJDkqihnQi4514
         beqItRwd44rPFm2igGlHGiMmnc8OZBB4ZxfdvIjlBdjkImc2OhAOlaGUGH68lAwQuQO6
         uB/qyOzmwyNuLdHKsCD0rnmz0KyoHyIZpkG0ivytn2pBkaYtClVpeV7monUUqsipwbZs
         LPmg==
X-Forwarded-Encrypted: i=1; AJvYcCUMQZpmRsFhOLhlXn63ppT2WFjPDEWi5ZW00tD3nZEp4wI+/+JADc1Ach2jlfgNWRhUJmczjH5wEAL4EmggLaalQrlZtae9sZiUa7CvwM0w2+8TfTxhKgxMh/oF
X-Gm-Message-State: AOJu0Yye6uNXUggGE+yERnjx9DxAamunUhn0rV8eQ/0PqzCxQHTvhTXL
	QHuHfemqudfNsAbBn4P3JNUDKzcL6NYm4+zl7hxSVPEVZj20/bu56W+t4adwZO+unMFDY/d6OyV
	bNc2wVSEOcCc3ZWb2xKCdxWruN2X/p5hwuWk=
X-Google-Smtp-Source: AGHT+IFeEaeognYjH08s2wzNCFZbv7yrug2rEv8hmtakpLvchqy0GdjckggcG+d+4SDUn6jR3cFihW8GmPUWPeKc1dw=
X-Received: by 2002:a25:1c4:0:b0:dfd:b41d:4a98 with SMTP id
 3f1490d57ef6-dfe69fca31bmr3184478276.3.1718260989517; Wed, 12 Jun 2024
 23:43:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1718138187.git.zhuyifei@google.com> <CAJ8uoz2-Kt2o-v3CuLpf2VDv2VtUJL2T307rp04di5hY2ihYHg@mail.gmail.com>
 <ZmmZY3zim4wG7pHR@boxer> <CAA-VZP=zpMeDamaKD60A3761N0CRUynWr54W3bzN5AK2CV4fOg@mail.gmail.com>
In-Reply-To: <CAA-VZP=zpMeDamaKD60A3761N0CRUynWr54W3bzN5AK2CV4fOg@mail.gmail.com>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Thu, 13 Jun 2024 08:42:58 +0200
Message-ID: <CAJ8uoz0ieQ0pX06A+-_idQFOO5Q+0R_jQZLk6wK7tq=7dHvJUg@mail.gmail.com>
Subject: Re: [RFC PATCH net-next 0/3] selftests: Add AF_XDP functionality test
To: YiFei Zhu <zhuyifei@google.com>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Stanislav Fomichev <sdf@google.com>, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 12 Jun 2024 at 18:44, YiFei Zhu <zhuyifei@google.com> wrote:
>
> On Wed, Jun 12, 2024 at 5:50=E2=80=AFAM Maciej Fijalkowski
> <maciej.fijalkowski@intel.com> wrote:
> >
> > On Wed, Jun 12, 2024 at 01:47:06PM +0200, Magnus Karlsson wrote:
> > > On Tue, 11 Jun 2024 at 22:43, YiFei Zhu <zhuyifei@google.com> wrote:
> > > >
> > > > We have observed that hardware NIC drivers may have faulty AF_XDP
> > > > implementations, and there seem to be a lack of a test of various m=
odes
> > > > in which AF_XDP could run. This series adds a test to verify that N=
IC
> > > > drivers implements many AF_XDP features by performing a send / rece=
ive
> > > > of a single UDP packet.
> > > >
> > > > I put the C code of the test under selftests/bpf because I'm not re=
ally
> > > > sure how I'd build the BPF-related code without the selftests/bpf
> > > > build infrastructure.
> > >
> > > Happy to see that you are contributing a number of new tests. Would i=
t
> > > be possible for you to integrate this into the xskxceiver framework?
> > > You can find that in selftests/bpf too. By default, it will run its
> > > tests using veth, but if you provide an interface name after the -i
> > > option, it will run the tests over a real interface. I put the NIC in
> > > loopback mode to use this feature, but feel free to add a new mode if
> > > necessary. A lot of the setup and data plane code that you add alread=
y
> > > exists in xskxceiver, so I would prefer if you could reuse it. Your
> > > tests are new though and they would be valuable to have.
> >
> > +1
> >
> > I just don't believe that you guys were not aware that xskxceiver exist=
.
> > Please provide us a proper explanation/justification why this was not
> > fulfilling your needs and you decided to go with another test suite.
>
> To answer this question, I can't speak for others, but I personally
> was not fully aware.
>
> Over a year ago when we were testing AF_XDP latency on internal NIC
> drivers, we extended our internal latency test tool to support AF_XDP.
> And that was when we observed the NICs we were testing had faulty
> implementations - panics, packet corruptions, random drops; and we
> decided to simplify the latency suite to add a simple pass/fail test
> to our testing infrastructure, and we named it xsk_hw. The test was
> specifically designed to test hardware NICs (rather than veth), and
> there was a bunch of code around the test, to reserve & setup
> machines, and to obtain information such as the IP addresses and the
> host and next hop MACs addresses. At the time, the code was deemed too
> dependent on our internal multi-machine-testing infrastructure to
> upstream, but it has been running as part of our test suite since.
>
> This brings us to recently. I was informed that upstream now have
> drv-net, and now that upstream also has multi-machine testing, it's
> time to upstream it. Hence this patch series, which I made after
> adapting the code to use drv-net and network_helpers.

I was not aware of drv-net. I think it would be a really good idea to
just hook up xskxceiver to this even without adding any new tests. If
this is something that is run automatically for drivers, perfect, we
should make use of it. Any idea what it would take to make xskxceiver
use drv-net?

> As for xskxceiver, for me personally, I discarded the idea after
> reading the initial block comment of xskxceiver saying it spawns two
> threads in a veth pair to test AF_XDP, which in my mind was like "okay
> this doesn't test hardware NICs, and to extend that test to hardware
> is probably a major rewrite that is probably not worth", so I did not
> look too deeply into its code. I personally was unaware that it can
> test a real interface, and that's partially my fault.

Or mine for not updating the initial block comment. In any case, no worries=
!

> I'll take a look at xskxceiver and see how feasible it is to integrate
> this into xskxceiver.

Thanks! Please keep the drv-net integration in mind. Hopefully it is
not that much work to tweak xskxceiver to fit into that.

> > >
> > > You could make the default packet that is sent in xskxceiver be the
> > > UDP packet that you want and then add all the other logic that you
> > > have to a number of new tests that you introduce.
> > >
> > > > Tested on Google Cloud, with GVE:
> > > >
> > > >   $ sudo NETIF=3Dens4 REMOTE_TYPE=3Dssh \
> > > >     REMOTE_ARGS=3D"root@10.138.15.235" \
> > > >     LOCAL_V4=3D"10.138.15.234" \
> > > >     REMOTE_V4=3D"10.138.15.235" \
> > > >     LOCAL_NEXTHOP_MAC=3D"42:01:0a:8a:00:01" \
> > > >     REMOTE_NEXTHOP_MAC=3D"42:01:0a:8a:00:01" \
> > > >     python3 xsk_hw.py
> > > >
> > > >   KTAP version 1
> > > >   1..22
> > > >   ok 1 xsk_hw.ipv4_basic
> > > >   ok 2 xsk_hw.ipv4_tx_skb_copy
> > > >   ok 3 xsk_hw.ipv4_tx_skb_copy_force_attach
> > > >   ok 4 xsk_hw.ipv4_rx_skb_copy
> > > >   ok 5 xsk_hw.ipv4_tx_drv_copy
> > > >   ok 6 xsk_hw.ipv4_tx_drv_copy_force_attach
> > > >   ok 7 xsk_hw.ipv4_rx_drv_copy
> > > >   [...]
> > > >   # Exception| STDERR: b'/tmp/zzfhcqkg/pbgodkgjxsk_hw: recv_pfpacke=
t: Timeout\n'
> > > >   not ok 8 xsk_hw.ipv4_tx_drv_zerocopy
> > > >   ok 9 xsk_hw.ipv4_tx_drv_zerocopy_force_attach
> > > >   ok 10 xsk_hw.ipv4_rx_drv_zerocopy
> > > >   [...]
> > > >   # Exception| STDERR: b'/tmp/zzfhcqkg/pbgodkgjxsk_hw: connect sync=
 client: max_retries\n'
> > > >   [...]
> > > >   # Exception| STDERR: b'/linux/tools/testing/selftests/bpf/xsk_hw:=
 open_xsk: Device or resource busy\n'
> > > >   not ok 11 xsk_hw.ipv4_rx_drv_zerocopy_fill_after_bind
> > > >   ok 12 xsk_hw.ipv6_basic # SKIP Test requires IPv6 connectivity
> > > >   [...]
> > > >   ok 22 xsk_hw.ipv6_rx_drv_zerocopy_fill_after_bind # SKIP Test req=
uires IPv6 connectivity
> > > >   # Totals: pass:9 fail:2 xfail:0 xpass:0 skip:11 error:0
> > > >
> > > > YiFei Zhu (3):
> > > >   selftests/bpf: Move rxq_num helper from xdp_hw_metadata to
> > > >     network_helpers
> > > >   selftests/bpf: Add xsk_hw AF_XDP functionality test
> > > >   selftests: drv-net: Add xsk_hw AF_XDP functionality test
> > > >
> > > >  tools/testing/selftests/bpf/.gitignore        |   1 +
> > > >  tools/testing/selftests/bpf/Makefile          |   7 +-
> > > >  tools/testing/selftests/bpf/network_helpers.c |  27 +
> > > >  tools/testing/selftests/bpf/network_helpers.h |  16 +
> > > >  tools/testing/selftests/bpf/progs/xsk_hw.c    |  72 ++
> > > >  tools/testing/selftests/bpf/xdp_hw_metadata.c |  27 +-
> > > >  tools/testing/selftests/bpf/xsk_hw.c          | 844 ++++++++++++++=
++++
> > > >  .../testing/selftests/drivers/net/hw/Makefile |   1 +
> > > >  .../selftests/drivers/net/hw/xsk_hw.py        | 133 +++
> > > >  9 files changed, 1102 insertions(+), 26 deletions(-)
> > > >  create mode 100644 tools/testing/selftests/bpf/progs/xsk_hw.c
> > > >  create mode 100644 tools/testing/selftests/bpf/xsk_hw.c
> > > >  create mode 100755 tools/testing/selftests/drivers/net/hw/xsk_hw.p=
y
> > > >
> > > > --
> > > > 2.45.2.505.gda0bf45e8d-goog
> > > >
> > > >
> > >

