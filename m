Return-Path: <bpf+bounces-49235-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D477BA1594F
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 23:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0651116856A
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 22:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28441B4231;
	Fri, 17 Jan 2025 22:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="FLf1eAGi"
X-Original-To: bpf@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F64215855E;
	Fri, 17 Jan 2025 22:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737151393; cv=none; b=ACw+f6DyG4wjhGma/4fXOrTJe3ZrWL+KS3CDA4HslFSVbJiSCcBytJMFQ7f2nmp/40whpwLKALXe5+K7XsYpp+FcZRfvreQwUya2+WVtueID3kkIihSvMjn5LcAvEkcJ92gsq+NFuToLpWDD3lm1HfgKTlbcKSdz5Dq6n5U+/Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737151393; c=relaxed/simple;
	bh=xY6e8RsoEZ6A+tJaci/cDSUApI6DhAPRsuEwbap3tgo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OGttgwWqviiW0EzjiDnhcPJ8ABlmJHUYKdLTkUFuT457ZvM5UaZixqgyavSxn3SaZnN8fYwhHLSPiNwnWHDfijI/xxo/oXxdzKMMY1MWQNeCtENIgvhtYYBzgN2sAh0JxJCmgyEBGNlCMZFHs+Be8yEyz5pt5XrYA0KPshGaDZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=FLf1eAGi; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tYuQl-008u7k-HI; Fri, 17 Jan 2025 23:03:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=M/reCYsLr6s08s3R0WErIkODtGqCjwAs+f2DwNyZQg8=; b=FLf1eAGim4Tnh+661wlmPJ+n1S
	yCa8uVopDrAmvazxt16YzB4jYlGXfgtAzjl5f4Apwm5xS4XxBWWPLFYHnDZm9Ft1ZQyGt3BW94Hdv
	K6CPNyCPpuaIibiuFu1gM5bbGOK4WUHVW3maLrgqmnU+Ls8WguohVomVYHnoqsVXOSiq9bNl/lVqd
	7qrmb3R3GH4Y768hXDBSw1RALrUe3yyD6aZdDN63L4rCFXIR20qFH4TnZDwLE3hkeuYmTljqxGyUB
	M+c3EVGzOThShKerEI2HtjWisX/xfgVB7dJVJIi7NpUK7M1Fak6/LSo59WuuL5w2mFIQXe9IVc54T
	ysJIkptg==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tYuQj-00059q-Um; Fri, 17 Jan 2025 23:03:06 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tYuQe-001shf-2d; Fri, 17 Jan 2025 23:03:00 +0100
Message-ID: <e3085fe8-3dae-40b2-970f-b8cda956a8f5@rbox.co>
Date: Fri, 17 Jan 2025 23:02:58 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/5] vsock/virtio: discard packets if the transport
 changes
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 Luigi Leonardi <leonardi@redhat.com>, "David S. Miller"
 <davem@davemloft.net>, Wongi Lee <qwerty@theori.io>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Eric Dumazet <edumazet@google.com>,
 kvm@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Simon Horman <horms@kernel.org>, Hyunwoo Kim <v4bel@theori.io>,
 Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux.dev,
 stable@vger.kernel.org
References: <1aa83abf-6baa-4cf1-a108-66b677bcfd93@rbox.co>
 <nedvcylhjxrkmkvgugsku2lpdjgjpo5exoke4o6clxcxh64s3i@jkjnvngazr5v>
 <CAGxU2F7BoMNi-z=SHsmCV5+99=CxHo4dxFeJnJ5=q9X=CM3QMA@mail.gmail.com>
 <cccb1a4f-5495-4db1-801e-eca211b757c3@rbox.co>
 <nzpj4hc6m4jlqhcwv6ngmozl3hcoxr6kehoia4dps7jytxf6df@iqglusiqrm5n>
 <903dd624-44e5-4792-8aac-0eaaf1e675c5@rbox.co>
 <5nkibw33isxiw57jmoaadizo3m2p76ve6zioumlu2z2nh5lwck@xodwiv56zrou>
 <7de34054-10cf-45d0-a869-adebb77ad913@rbox.co>
 <n2itoh23kikzszzgmyejfwe3mdf6fmxzwbtyo5ahtxpaco3euq@osupldmckz7p>
 <fb6f876f-a4eb-4005-bd76-fff0632291b8@rbox.co>
 <pl4mhcim7v3ukv6eseynh6x2r6nftf7yuayjzd3ftyupwy5r2h@ixmlevubqzb2>
From: Michal Luczaj <mhal@rbox.co>
Content-Language: pl-PL, en-GB
In-Reply-To: <pl4mhcim7v3ukv6eseynh6x2r6nftf7yuayjzd3ftyupwy5r2h@ixmlevubqzb2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/16/25 09:57, Stefano Garzarella wrote:
> On Tue, Jan 14, 2025 at 05:31:08PM +0100, Michal Luczaj wrote:
>>> ...
>>> Maybe we need to look better at the release, and prevent it from
>>> removing the socket from the lists as you suggested, maybe adding a
>>> function in af_vsock.c that all transports can call.
>>
>> I'd be happy to submit a proper patch, but it would be helpful to decide
>> how close to AF_INET/AF_UNIX's behaviour is close enough. Or would you
>> rather have that UAF plugged first?
>>
> 
> I'd say, let's fix the UAF first, then fix the behaviour (also in a
> single series, but I prefer 2 separate patches if possible).
> About that, AF_VSOCK was started with the goal of following AF_INET as
> closely as possible, and the test suite should serve that as well, so if
> we can solve this problem and get closer to AF_INET, possibly even
> adding a dedicated test, that would be ideal!

All right, so let's keep the binding and allow removal from (un)bound list
only on socket destruction. This is transport independent, changes are
pretty minimal and, well, keeps the binding. Mixes well with the connect()
behaviour fix.

Let me know what you think:
https://lore.kernel.org/netdev/20250117-vsock-transport-vs-autobind-v1-0-c802c803762d@rbox.co/

Thanks,
Michal


