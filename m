Return-Path: <bpf+bounces-15769-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4C77F66AE
	for <lists+bpf@lfdr.de>; Thu, 23 Nov 2023 19:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2299B212B0
	for <lists+bpf@lfdr.de>; Thu, 23 Nov 2023 18:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9643FB28;
	Thu, 23 Nov 2023 18:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ebv3spVE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91E624A10;
	Thu, 23 Nov 2023 18:53:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16118C433CA;
	Thu, 23 Nov 2023 18:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700765588;
	bh=Y0PegqXIQ7kcn/YOYMXsf/jpB5XlhL7JeuQ0uTx82eQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ebv3spVE6vu1eBUphjcxy5N5+pwIFjshAp8CW9gpkSZJ5LhLDVtXTCCh64ZfSjwd9
	 jMIZFnD4sXryqZ02RfjwFfanRq2if+MWG0Z45C8nFn7ZQncB0AUhctKt9T+IR7XHqa
	 0CKXLjW0Rs16Cw9NOz4E2EnU6Vjg3UyyKQZmM0ylz+2ob06qJnzN31W4bAJWDPn3Bm
	 IrKq9hpsGTeGmVdCzE3XpPF5dWgVFPkIoTNSbMjmv6nC5xNUZYpiPd/CUA+eIFa/3A
	 VgHImhSpudi3FOLH4GKbTYHth3H9cs9lX+x2lKWy270jnxZN72H1b2T9+sHudUWaG8
	 aY3cijmN+ABHA==
Date: Thu, 23 Nov 2023 10:53:05 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Edward Cree <ecree.xilinx@gmail.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
 Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, netdev@vger.kernel.org,
 deb.chatterjee@intel.com, anjali.singhai@intel.com, Vipin.Jain@amd.com,
 namrata.limaye@intel.com, tom@sipanda.io, mleitner@redhat.com,
 Mahesh.Shirshyad@amd.com, tomasz.osinski@intel.com,
 xiyou.wangcong@gmail.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, vladbu@nvidia.com, horms@kernel.org,
 bpf@vger.kernel.org, khalidm@nvidia.com, toke@redhat.com,
 mattyk@nvidia.com, dan.daly@intel.com, chris.sommers@keysight.com,
 john.andy.fingerhut@intel.com
Subject: Re: [PATCH net-next v8 00/15] Introducing P4TC
Message-ID: <20231123105305.7edeab94@kernel.org>
In-Reply-To: <0d1d37f9-1ef1-4622-409e-a976c8061a41@gmail.com>
References: <ZV3JJQirPdZpbVIC@nanopsycho>
	<CAM0EoM=R1H1iGQDZs3m7tY7f++VWzPegvSdt=MfN0wvFXdT+Mg@mail.gmail.com>
	<ZV5I/F+b5fu58Rlg@nanopsycho>
	<CAM0EoM=RR6kcdHsGhFNUeDc96rSDa8S7SP7GQOeXrZBN_P7jtQ@mail.gmail.com>
	<ZV7y9JG0d4id8GeG@nanopsycho>
	<CAM0EoMkOvEnPmw=0qye9gWAqgbZjaTYZhiho=qmG1x4WiQxkxA@mail.gmail.com>
	<ZV9U+zsMM5YqL8Cx@nanopsycho>
	<CAM0EoMnFB0hgcVFj3=QN4114HiQy46uvYJKqa7=p2VqJTwqBsg@mail.gmail.com>
	<ZV9csgFAurzm+j3/@nanopsycho>
	<CAM0EoMkgD10dFvgtueDn7wjJTFTQX6_mkA4Kwr04Dnwp+S-u-A@mail.gmail.com>
	<ZV9vfYy42G0Fk6m4@nanopsycho>
	<CAM0EoMkC6+hJ0fb9zCU8bcKDjpnz5M0kbKZ=4GGAMmXH4_W8rg@mail.gmail.com>
	<0d1d37f9-1ef1-4622-409e-a976c8061a41@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Nov 2023 17:53:42 +0000 Edward Cree wrote:
> The kernel doesn't like to trust offload blobs from a userspace compiler,
>  because it has no way to be sure that what comes out of the compiler
>  matches the rules/tables/whatever it has in the SW datapath.
> It's also a support nightmare because it's basically like each user
>  compiling their own device firmware.  

Practically speaking every high speed NIC runs a huge binary blob of FW.
First, let's acknowledge that as reality.

Second, there is no equivalent for arbitrary packet parsing in the
kernel proper. Offload means take something form the host and put it
on the device. If there's nothing in the kernel, we can't consider
the new functionality an offload.

I understand that "we offload SW functionality" is our general policy,
but we should remember why this policy is in place, and not
automatically jump to the conclusion.

>  At least normally with device firmware the driver side is talking to
>  something with narrow/fixed semantics and went through upstream
>  review, even if the firmware side is still a black box.

We should be buildings things which are useful and open (as in
extensible by people "from the street"). With that in mind, to me,
a more practical approach would be to try to figure out a common
and rigid FW interface for expressing the parsing graph.

But that's an interface going from the binary blob to the kernel.

> Just to prove I'm not playing favourites: this is *also* a problem with
>  eBPF offloads like Nanotubes, and I'm not convinced we have a viable
>  solution yet.

BPF offloads are actual offloads. Config/state is in the kernel,
you need to pop it out to user space, then prove that it's what
user intended.

