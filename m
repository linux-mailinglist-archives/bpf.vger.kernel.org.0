Return-Path: <bpf+bounces-51071-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64200A2FEC6
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 01:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 653E618854CC
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 00:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26CF322F19;
	Tue, 11 Feb 2025 00:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NjVg/TMV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BBB63A9;
	Tue, 11 Feb 2025 00:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739232228; cv=none; b=Inhw9y+uTYSijZv3qFt5CMaLXX9N9bQLYVK55ov9tCIDHWBlrELMYQ2qV7ubW9pteJpNDmRiD0Qu/QmD2oKyC4iFn9feybMQiWZdMG0z1uxwUxTffyaqNEMITdM/RYDnhK9++qxLIg1VwbGnJXcQyb81IIR09bU2ne7e7uWaSXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739232228; c=relaxed/simple;
	bh=AHcbXhi6dSa+mpZAj7DTaigbIId9wzJwRWlbVZ+b0Lk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Or6zjCqBvIuAREQeUJEEdP+bd+bh4yfTm/Ii6v6o6ftMnPHyXulbY34LK3p8V8vsY60p3hE8pnxg8089IsRDGnIYio+Jo5RzI8UGbglhWxrMZaoaTYGdk74iVGghJ6byKnyltFk9fBpird829PTiqVjMKHZeQYfQq/0KePutNI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NjVg/TMV; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3d13e4dd0f2so31494205ab.3;
        Mon, 10 Feb 2025 16:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739232226; x=1739837026; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZohEeUcSKrnIav5NVRGSk5ofMVc9bVcTIPZs18p57RI=;
        b=NjVg/TMV7QpkYeYzDess81YAAsjAM2gzp/sw7jWU2jj/4ODs+9ILu1hRfBALATYHai
         KcylPXA+MOzWAHEIOBukMGksWupZCR3RWg+aIu4S6qtr7nUy13t/GARHVsQGmts6tMAM
         tb4RRJs5KLgj7ujEdFVK8SD1ScxZiWN7VNyy6m7fRQiz/NhqnyVU9tpwzH27/ep4Z7wu
         RFGS95pjLUD09CGnfoai4yMVpuBgKSIwMZcVEvo/PU7uZNwassfZZVu/ThAjIuDposAs
         sZBO2yZnjIPdVnB2GWYJduQ9sg9hIZ+7W0dI198QxkRSIG9mCiOitAho60PuIJlFbOxN
         decA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739232226; x=1739837026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZohEeUcSKrnIav5NVRGSk5ofMVc9bVcTIPZs18p57RI=;
        b=FbkLbQ9Wo7oLJwoHM/TUPHLbiKsi/RFzRMr5sn1PU4PX/qIs4ntMPoLSKPc4EZPSHk
         jzkuG3CQ4BM9SKwmnwaOmZcAusFEhEI0UK7AyaBgVbPho8LOjGuDU4HsKai6B+tjwf4W
         p/C9hBIVcyRoEsk/f6x52WiTCehCXykC6pRbn0vy4fLe7xmXY0EPtXMcHetm/zV87Uub
         eZwKvD5+6YjLRqux44fbuTkkDJNnCwedmqUTeHnlcUjjjF8paWGsoXvO/jeNnNycTuxT
         VCa2Zv65RR1xYe/+PzI1+JOT+yGSbQyXgNaKHAyrzP/k9P9+UMIbsTdfbRTw9UTCtd0U
         5O/A==
X-Forwarded-Encrypted: i=1; AJvYcCU0OL0mJ47zYoVOXaRlLHJmDSfcDVda6hpoWFh3kX8yej6nt7DqwG5GgwzpcTp76lcf72o=@vger.kernel.org, AJvYcCXC/KSyYvGFK0/GZhl2v8KTm88Itaik/FuP2XR3gge3SsNczMWDw2dWyl3pAWunuMn21zZrrGo/@vger.kernel.org
X-Gm-Message-State: AOJu0YyB3Mm0J92akn5KV2c6U3NWeUdIHTTg8K8Jn59/j500hOTE2xFp
	waMbwVek6FBI65+y6R6OMRBK2HOaJH/vO+OZSt3sIhdKP0w0WUSrbQAjTNAj9wBAwyIjUuY2smL
	1IprOQ2GkAruKbSpK8mb4lstJpmo=
X-Gm-Gg: ASbGncuywJYnk0FeUMwqszsz+A5pkNiKQra5KleTpOyu4iQ1FSfXsQHT+tCaX5ghLXZ
	1HO46RtVRZzsiXcgLWVoe/A/E9AhU1fCdZ1oxBorDl9L2IiJvTlHANABCBMvj7mqENOmmFysn
X-Google-Smtp-Source: AGHT+IH3rS2ARMDjTTWkaZeryIRdyt1CSuPIVRVaf/Eh1Gef+3I0s6ghyRPnN9/7YM0v77SZQOXxAzP6zDBADXPGFf0=
X-Received: by 2002:a05:6e02:152a:b0:3d0:21aa:a756 with SMTP id
 e9e14a558f8ab-3d16e455f47mr13957185ab.5.1739232225866; Mon, 10 Feb 2025
 16:03:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250208103220.72294-1-kerneljasonxing@gmail.com> <a483c1dd-f593-4f6b-9afe-bfb6d43647bf@linux.dev>
In-Reply-To: <a483c1dd-f593-4f6b-9afe-bfb6d43647bf@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 11 Feb 2025 08:03:09 +0800
X-Gm-Features: AWEUYZmEleDujuqFNfO-DvfpnZrl3brcowtOKibx0r2n1MACG5GPsJm_Xlcea_U
Message-ID: <CAL+tcoCzpC=AZ04BVghUbxSYhkJcG5oNa1eNNuKy8pPjefiEKw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 00/12] net-timestamp: bpf extension to equip
 applications transparently
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com, 
	willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 7:37=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 2/8/25 2:32 AM, Jason Xing wrote:
> > "Timestamping is key to debugging network stack latency. With
> > SO_TIMESTAMPING, bugs that are otherwise incorrectly assumed to be
> > network issues can be attributed to the kernel." This is extracted
> > from the talk "SO_TIMESTAMPING: Powering Fleetwide RPC Monitoring"
> > addressed by Willem de Bruijn at netdevconf 0x17).
> >
> > There are a few areas that need optimization with the consideration of
> > easier use and less performance impact, which I highlighted and mainly
> > discussed at netconf 2024 with Willem de Bruijn and John Fastabend:
> > uAPI compatibility, extra system call overhead, and the need for
> > application modification. I initially managed to solve these issues
> > by writing a kernel module that hooks various key functions. However,
> > this approach is not suitable for the next kernel release. Therefore,
> > a BPF extension was proposed. During recent period, Martin KaFai Lau
> > provides invaluable suggestions about BPF along the way. Many thanks
> > here!
> >
> > In this series, only support foundamental codes and tx for TCP.
>
> typo: fundamental.... This had been brought up before (in v7?).

Oh, right!

>
> By fundamental, I suspect you meant (?) bpf timestamping infrastructure, =
like:
> "This series adds the BPF networking timestamping infrastructure. This se=
ries
> also adds TX timestamping support for TCP. The RX timestamping and UDP su=
pport
> will be added in the future."

Right!

>
> > This approach mostly relies on existing SO_TIMESTAMPING feature, users
>
> It reuses most of the tx timestamping callback that is currently enabled =
by the
> SO_TIMESTAMPING. However, I don't think there is a lot of overlap in term=
 of the
> SO_TIMESTAMPING api which does feel like API reuse when first reading thi=
s comment.

I'm going to refine them. Thanks for the review!

Thanks,
Jason

>
> > only needs to pass certain flags through bpf_setsocktopt() to a separat=
e
> > tsflags. Please see the last selftest patch in this series.
> >
> > ---
> > v8
> > Link: https://lore.kernel.org/all/20250128084620.57547-1-kerneljasonxin=
g@gmail.com/
> > 1. adjust some commit messages and titles
> > 2. add sk cookie in selftests
> > 3. handle the NULL pointer in hwstamp
> > 4. use kfunc to do selective sampling
> >
> > v7
> > Link: https://lore.kernel.org/all/20250121012901.87763-1-kerneljasonxin=
g@gmail.com/
> > 1. target bpf-next tree
> > 2. simplely and directly stop timestamping callbacks calling a few BPF
> > CALLS due to safety concern.
> > 3. add more new testcases and adjust the existing testcases
> > 4. revise some comments of new timestamping callbacks
> > 5. remove a few BPF CGROUP locks
> >
> > RFC v6
> > In the meantime, any suggestions and reviews are welcome!
> > Link: https://lore.kernel.org/all/20250112113748.73504-1-kerneljasonxin=
g@gmail.com/
> > 1. handle those safety problem by using the correct method.
> > 2. support bpf_getsockopt.
> > 3. adjust the position of BPF_SOCK_OPS_TS_TCP_SND_CB
> > 4. fix mishandling the hardware timestamp error
> > 5. add more corresponding tests
> >
> > v5
> > Link: https://lore.kernel.org/all/20241207173803.90744-1-kerneljasonxin=
g@gmail.com/
> > 1. handle the safety issus when someone tries to call unrelated bpf
> > helpers.
> > 2. avoid adding direct function call in the hot path like
> > __dev_queue_xmit()
> > 3. remove reporting the hardware timestamp and tskey since they can be
> > fetched through the existing helper with the help of
> > bpf_skops_init_skb(), please see the selftest.
> > 4. add new sendmsg callback in tcp_sendmsg, and introduce tskey_bpf use=
d
> > by bpf program to correlate tcp_sendmsg with other hook points in patch=
 [13/15].
> >
> > v4
> > Link: https://lore.kernel.org/all/20241028110535.82999-1-kerneljasonxin=
g@gmail.com/
> > 1. introduce sk->sk_bpf_cb_flags to let user use bpf_setsockopt() (Mart=
in)
> > 2. introduce SKBTX_BPF to enable the bpf SO_TIMESTAMPING feature (Marti=
n)
> > 3. introduce bpf map in tests (Martin)
> > 4. I choose to make this series as simple as possible, so I only suppor=
t
> > most cases in the tx path for TCP protocol.
> >
> > v3
> > Link: https://lore.kernel.org/all/20241012040651.95616-1-kerneljasonxin=
g@gmail.com/
> > 1. support UDP proto by introducing a new generation point.
> > 2. for OPT_ID, introducing sk_tskey_bpf_offset to compute the delta
> > between the current socket key and bpf socket key. It is desiged for
> > UDP, which also applies to TCP.
> > 3. support bpf_getsockopt()
> > 4. use cgroup static key instead.
> > 5. add one simple bpf selftest to show how it can be used.
> > 6. remove the rx support from v2 because the number of patches could
> > exceed the limit of one series.
> >
> > V2
> > Link: https://lore.kernel.org/all/20241008095109.99918-1-kerneljasonxin=
g@gmail.com/
> > 1. Introduce tsflag requestors so that we are able to extend more in th=
e
> > future. Besides, it enables TX flags for bpf extension feature separate=
ly
> > without breaking users. It is suggested by Vadim Fedorenko.
> > 2. introduce a static key to control the whole feature. (Willem)
> > 3. Open the gate of bpf_setsockopt for the SO_TIMESTAMPING feature in
> > some TX/RX cases, not all the cases.
> >
> > Jason Xing (12):
> >    bpf: add support for bpf_setsockopt()
> >    bpf: prepare for timestamping callbacks use
> >    bpf: stop unsafely accessing TCP fields in bpf callbacks
> >    bpf: stop calling some sock_op BPF CALLs in new timestamping callbac=
ks
> >    net-timestamp: prepare for isolating two modes of SO_TIMESTAMPING
> >    bpf: support SCM_TSTAMP_SCHED of SO_TIMESTAMPING
> >    bpf: support sw SCM_TSTAMP_SND of SO_TIMESTAMPING
> >    bpf: support hw SCM_TSTAMP_SND of SO_TIMESTAMPING
> >    bpf: support SCM_TSTAMP_ACK of SO_TIMESTAMPING
> >    bpf: add a new callback in tcp_tx_timestamp()
> >    bpf: support selective sampling for bpf timestamping
> >    selftests/bpf: add simple bpf tests in the tx path for timestamping
> >      feature
> >
> >   include/linux/filter.h                        |   1 +
> >   include/linux/skbuff.h                        |  12 +-
> >   include/net/sock.h                            |  10 +
> >   include/net/tcp.h                             |   5 +-
> >   include/uapi/linux/bpf.h                      |  30 ++
> >   kernel/bpf/btf.c                              |   1 +
> >   net/core/dev.c                                |   3 +-
> >   net/core/filter.c                             |  75 ++++-
> >   net/core/skbuff.c                             |  48 ++-
> >   net/core/sock.c                               |  15 +
> >   net/dsa/user.c                                |   2 +-
> >   net/ipv4/tcp.c                                |   4 +
> >   net/ipv4/tcp_input.c                          |   2 +
> >   net/ipv4/tcp_output.c                         |   2 +
> >   net/socket.c                                  |   2 +-
> >   tools/include/uapi/linux/bpf.h                |  23 ++
> >   .../bpf/prog_tests/so_timestamping.c          |  79 +++++
> >   .../selftests/bpf/progs/so_timestamping.c     | 312 +++++++++++++++++=
+
> >   18 files changed, 612 insertions(+), 14 deletions(-)
> >   create mode 100644 tools/testing/selftests/bpf/prog_tests/so_timestam=
ping.c
> >   create mode 100644 tools/testing/selftests/bpf/progs/so_timestamping.=
c
> >
>

