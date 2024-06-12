Return-Path: <bpf+bounces-31958-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B54905912
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 18:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23607B25EF2
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 16:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A518C181BB6;
	Wed, 12 Jun 2024 16:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JXytlCIs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD3A181338
	for <bpf@vger.kernel.org>; Wed, 12 Jun 2024 16:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718210670; cv=none; b=r5XXd4cgGqpTJgdAMFYm0TfDwVoP8VtL6N30w4H2+U0SJED/pCXlDWNpTjOuEn09IxVEc9JSQgYr47HXHBtmL0WNRLexBT9Mu4NXFXumd5Y2Kqk+k83L+iTzH4w1moSgUI9A8U/hNrxAPnuT/FcL5VV8myO6h73ucgB4NGIodWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718210670; c=relaxed/simple;
	bh=SlEU1MuDMJHVwT8PA1nP1/rWP1O3aL+JyNeJd2Iu3m8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W865fp+WhqqfTij5Rl1L11PHDHVZmnmy2GR7pyl38H95s1Ueh898g365YBOQIEveAwC6R2eRaF8L+lBhOUWBBExIPiyFZQcCJ/z+FMHY/qLPzUVINwhfNp9YPASi/ypMVhQ9z2qkdwmPJMj/QWsCK6qRoo/1K/gufi3er7YT5VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JXytlCIs; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a6265d48ec3so17794966b.0
        for <bpf@vger.kernel.org>; Wed, 12 Jun 2024 09:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718210665; x=1718815465; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xIwSzPnNx2QwRA39p1mbrr9oOi6iv8ouljnrVionuME=;
        b=JXytlCIsA24eGMPUb+xStJDbviFGeL4GkPe455OgWaSIlt/MfvYXYO0AUBthNnsGlq
         bK0SajQaFoTJF9lBbPm3mVVPthWD5dV9gtQs35qWJ6ZmNSlx9mRwDyHHKpybKouAnv0b
         P5L1na56DsGJjXPXX9cuECGgVkFRBQhi66PeNZ76/aDlwchgwejai3momE2IZICCU25r
         yVKjH/An2nPQvN5lpB+01Hs44NCZG3ZJUnD0KryQcAIV3mw0AoubFr8xOvqdrTJ2rbje
         Etyp2y+JVnGIRc609nvNy5rYxsGMMvfw6zWCZSZ8/nJ2w661qdG5bmM756ASnFIBFbIx
         dgJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718210665; x=1718815465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xIwSzPnNx2QwRA39p1mbrr9oOi6iv8ouljnrVionuME=;
        b=YM0CQPiu0KLFkeJsSk/H8u4yxA/rIVSEe3cjFVYpc2Kk3zYIQFpJXP/jMrPtOqbAuz
         YxL+tZMvh3/pJ3JdXvP50sErncxyCaepUqJSkH91pFnwahFtNa9D9y4M64v58IHuF/VF
         J+XmJpKWnF7kIp/dU1LfMDEccy+PB3PwgwpMgKgJKS+Udnev9tJcD4xp8b9knoGUu79r
         UhlO249J0ZbUdubkGTP73YDsTiRu7gH+MfJiLOjxefkRQO/VO+z7FgHeb0eoOZfy7OXW
         bO/FOv+m0+MO47ELU6fha/7xNCLJwiO+ZKxOIljn/cLBujI0s+67p1u2wtXOtz5R7GdQ
         1qmg==
X-Forwarded-Encrypted: i=1; AJvYcCX4NJaicLtskGh11lJlGlZ1Qz11sXxOE98eAbwKqmii8R+5iO8acxMiPGShOCoyORIDOoP9J3ZmL3IlDzjUIwbfXNbr
X-Gm-Message-State: AOJu0Yx+5TermZh4REg4NB+0vm3vMCEOIFX97oqxNy43hxpblw/lwXy8
	BsFsYvdmFnC6HUYENPVPr28gD52YcC8qHkje/Zxi6IqsXUKElBXWIpUsM+opiVV0EnPyXJH5SCc
	cNr+kYEOud+24UnPRNtOZIGP4q4XSVLO92JoT
X-Google-Smtp-Source: AGHT+IE8KQdHxzENtMyeC2g3JNfrIzF38jPfhjhgCVHHrYlv3oCgd76fDNDcEJmVqK5YXil3DhDcAu1Qbz7awwf9zFE=
X-Received: by 2002:a17:907:72c5:b0:a69:13a2:4f6e with SMTP id
 a640c23a62f3a-a6f47d61fe0mr191429066b.74.1718210664983; Wed, 12 Jun 2024
 09:44:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1718138187.git.zhuyifei@google.com> <CAJ8uoz2-Kt2o-v3CuLpf2VDv2VtUJL2T307rp04di5hY2ihYHg@mail.gmail.com>
 <ZmmZY3zim4wG7pHR@boxer>
In-Reply-To: <ZmmZY3zim4wG7pHR@boxer>
From: YiFei Zhu <zhuyifei@google.com>
Date: Wed, 12 Jun 2024 09:44:13 -0700
Message-ID: <CAA-VZP=zpMeDamaKD60A3761N0CRUynWr54W3bzN5AK2CV4fOg@mail.gmail.com>
Subject: Re: [RFC PATCH net-next 0/3] selftests: Add AF_XDP functionality test
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Magnus Karlsson <magnus.karlsson@gmail.com>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Stanislav Fomichev <sdf@google.com>, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 5:50=E2=80=AFAM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Wed, Jun 12, 2024 at 01:47:06PM +0200, Magnus Karlsson wrote:
> > On Tue, 11 Jun 2024 at 22:43, YiFei Zhu <zhuyifei@google.com> wrote:
> > >
> > > We have observed that hardware NIC drivers may have faulty AF_XDP
> > > implementations, and there seem to be a lack of a test of various mod=
es
> > > in which AF_XDP could run. This series adds a test to verify that NIC
> > > drivers implements many AF_XDP features by performing a send / receiv=
e
> > > of a single UDP packet.
> > >
> > > I put the C code of the test under selftests/bpf because I'm not real=
ly
> > > sure how I'd build the BPF-related code without the selftests/bpf
> > > build infrastructure.
> >
> > Happy to see that you are contributing a number of new tests. Would it
> > be possible for you to integrate this into the xskxceiver framework?
> > You can find that in selftests/bpf too. By default, it will run its
> > tests using veth, but if you provide an interface name after the -i
> > option, it will run the tests over a real interface. I put the NIC in
> > loopback mode to use this feature, but feel free to add a new mode if
> > necessary. A lot of the setup and data plane code that you add already
> > exists in xskxceiver, so I would prefer if you could reuse it. Your
> > tests are new though and they would be valuable to have.
>
> +1
>
> I just don't believe that you guys were not aware that xskxceiver exist.
> Please provide us a proper explanation/justification why this was not
> fulfilling your needs and you decided to go with another test suite.

To answer this question, I can't speak for others, but I personally
was not fully aware.

Over a year ago when we were testing AF_XDP latency on internal NIC
drivers, we extended our internal latency test tool to support AF_XDP.
And that was when we observed the NICs we were testing had faulty
implementations - panics, packet corruptions, random drops; and we
decided to simplify the latency suite to add a simple pass/fail test
to our testing infrastructure, and we named it xsk_hw. The test was
specifically designed to test hardware NICs (rather than veth), and
there was a bunch of code around the test, to reserve & setup
machines, and to obtain information such as the IP addresses and the
host and next hop MACs addresses. At the time, the code was deemed too
dependent on our internal multi-machine-testing infrastructure to
upstream, but it has been running as part of our test suite since.

This brings us to recently. I was informed that upstream now have
drv-net, and now that upstream also has multi-machine testing, it's
time to upstream it. Hence this patch series, which I made after
adapting the code to use drv-net and network_helpers.

As for xskxceiver, for me personally, I discarded the idea after
reading the initial block comment of xskxceiver saying it spawns two
threads in a veth pair to test AF_XDP, which in my mind was like "okay
this doesn't test hardware NICs, and to extend that test to hardware
is probably a major rewrite that is probably not worth", so I did not
look too deeply into its code. I personally was unaware that it can
test a real interface, and that's partially my fault.

I'll take a look at xskxceiver and see how feasible it is to integrate
this into xskxceiver.

> >
> > You could make the default packet that is sent in xskxceiver be the
> > UDP packet that you want and then add all the other logic that you
> > have to a number of new tests that you introduce.
> >
> > > Tested on Google Cloud, with GVE:
> > >
> > >   $ sudo NETIF=3Dens4 REMOTE_TYPE=3Dssh \
> > >     REMOTE_ARGS=3D"root@10.138.15.235" \
> > >     LOCAL_V4=3D"10.138.15.234" \
> > >     REMOTE_V4=3D"10.138.15.235" \
> > >     LOCAL_NEXTHOP_MAC=3D"42:01:0a:8a:00:01" \
> > >     REMOTE_NEXTHOP_MAC=3D"42:01:0a:8a:00:01" \
> > >     python3 xsk_hw.py
> > >
> > >   KTAP version 1
> > >   1..22
> > >   ok 1 xsk_hw.ipv4_basic
> > >   ok 2 xsk_hw.ipv4_tx_skb_copy
> > >   ok 3 xsk_hw.ipv4_tx_skb_copy_force_attach
> > >   ok 4 xsk_hw.ipv4_rx_skb_copy
> > >   ok 5 xsk_hw.ipv4_tx_drv_copy
> > >   ok 6 xsk_hw.ipv4_tx_drv_copy_force_attach
> > >   ok 7 xsk_hw.ipv4_rx_drv_copy
> > >   [...]
> > >   # Exception| STDERR: b'/tmp/zzfhcqkg/pbgodkgjxsk_hw: recv_pfpacket:=
 Timeout\n'
> > >   not ok 8 xsk_hw.ipv4_tx_drv_zerocopy
> > >   ok 9 xsk_hw.ipv4_tx_drv_zerocopy_force_attach
> > >   ok 10 xsk_hw.ipv4_rx_drv_zerocopy
> > >   [...]
> > >   # Exception| STDERR: b'/tmp/zzfhcqkg/pbgodkgjxsk_hw: connect sync c=
lient: max_retries\n'
> > >   [...]
> > >   # Exception| STDERR: b'/linux/tools/testing/selftests/bpf/xsk_hw: o=
pen_xsk: Device or resource busy\n'
> > >   not ok 11 xsk_hw.ipv4_rx_drv_zerocopy_fill_after_bind
> > >   ok 12 xsk_hw.ipv6_basic # SKIP Test requires IPv6 connectivity
> > >   [...]
> > >   ok 22 xsk_hw.ipv6_rx_drv_zerocopy_fill_after_bind # SKIP Test requi=
res IPv6 connectivity
> > >   # Totals: pass:9 fail:2 xfail:0 xpass:0 skip:11 error:0
> > >
> > > YiFei Zhu (3):
> > >   selftests/bpf: Move rxq_num helper from xdp_hw_metadata to
> > >     network_helpers
> > >   selftests/bpf: Add xsk_hw AF_XDP functionality test
> > >   selftests: drv-net: Add xsk_hw AF_XDP functionality test
> > >
> > >  tools/testing/selftests/bpf/.gitignore        |   1 +
> > >  tools/testing/selftests/bpf/Makefile          |   7 +-
> > >  tools/testing/selftests/bpf/network_helpers.c |  27 +
> > >  tools/testing/selftests/bpf/network_helpers.h |  16 +
> > >  tools/testing/selftests/bpf/progs/xsk_hw.c    |  72 ++
> > >  tools/testing/selftests/bpf/xdp_hw_metadata.c |  27 +-
> > >  tools/testing/selftests/bpf/xsk_hw.c          | 844 ++++++++++++++++=
++
> > >  .../testing/selftests/drivers/net/hw/Makefile |   1 +
> > >  .../selftests/drivers/net/hw/xsk_hw.py        | 133 +++
> > >  9 files changed, 1102 insertions(+), 26 deletions(-)
> > >  create mode 100644 tools/testing/selftests/bpf/progs/xsk_hw.c
> > >  create mode 100644 tools/testing/selftests/bpf/xsk_hw.c
> > >  create mode 100755 tools/testing/selftests/drivers/net/hw/xsk_hw.py
> > >
> > > --
> > > 2.45.2.505.gda0bf45e8d-goog
> > >
> > >
> >

