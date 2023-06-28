Return-Path: <bpf+bounces-3674-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A394A74183C
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 20:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0A161C203C1
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 18:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486E110797;
	Wed, 28 Jun 2023 18:52:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FE0A923;
	Wed, 28 Jun 2023 18:52:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D745C433C0;
	Wed, 28 Jun 2023 18:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687978326;
	bh=gXKn5JYE56vUXL4So05eMKIhT6YmD5oAVfdokIcwQKw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jQUGa3JQBYAvNBRmP3/C0Eh/RBiRYubbVd2zfTYOPyr1poAD7xlsoKvLl8cdN7DRM
	 cDpjZe1xEdwG8CH6jk/+av8/8ONZXQkZ1mxljWbc2ACmEerDneL2HC0myc+fffpQJS
	 ms2XiwXC8qXlzVjfUOihA4BHJUAeECFQSuBcUmCy5WerKxdLEHjJBQpSaTV/70brXt
	 Sx4Xw1jdwc5v7LACcjHPMpldgxMTPrBrqFdqWjbvK6OzIF200Kt88Nb1xaWBWoyc6U
	 BDgTjZpPD5Z3X0N6OK5ORsVsXxYQq7qOGjdZeMgwgkMoRfJ/apae39NReEQWVzP9DM
	 wF+0fC4avKOLg==
Date: Wed, 28 Jun 2023 11:52:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: John Fastabend <john.fastabend@gmail.com>
Cc: Stanislav Fomichev <sdf@google.com>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Donald Hunter <donald.hunter@gmail.com>,
 bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Network Development
 <netdev@vger.kernel.org>
Subject: Re: [RFC bpf-next v2 11/11] net/mlx5e: Support TX timestamp
 metadata
Message-ID: <20230628115204.595dea8c@kernel.org>
In-Reply-To: <649b581ded8c1_75d8a208c@john.notmuch>
References: <20230622195757.kmxqagulvu4mwhp6@macbook-pro-8.dhcp.thefacebook.com>
	<CAKH8qBvJmKwgdrLkeT9EPnCiTu01UAOKvPKrY_oHWySiYyp4nQ@mail.gmail.com>
	<CAADnVQKfcGT9UaHtAmWKywtuyP9+_NX0_mMaR0m9D0-a=Ymf5Q@mail.gmail.com>
	<CAKH8qBuJpybiTFz9vx+M+5DoGuK-pPq6HapMKq7rZGsngsuwkw@mail.gmail.com>
	<CAADnVQ+611dOqVFuoffbM_cnOf62n6h+jaB1LwD2HWxS5if2CA@mail.gmail.com>
	<m2bkh69fcp.fsf@gmail.com>
	<649637e91a709_7bea820894@john.notmuch>
	<CAADnVQKUVDEg12jOc=5iKmfN-aHvFEtvFKVEDBFsmZizwkXT4w@mail.gmail.com>
	<20230624143834.26c5b5e8@kernel.org>
	<ZJeUlv/omsyXdO/R@google.com>
	<ZJoExxIaa97JGPqM@google.com>
	<CAADnVQKePtxk6Nn=M6in6TTKaDNnMZm-g+iYzQ=mPoOh8peoZQ@mail.gmail.com>
	<CAKH8qBv-jU6TUcWrze5VeiVhiJ-HUcpHX7rMJzN5o2tXFkS8kA@mail.gmail.com>
	<649b581ded8c1_75d8a208c@john.notmuch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Jun 2023 14:43:57 -0700 John Fastabend wrote:
> What I think would be the most straight-forward thing and most flexible
> is to create a <drvname>_devtx_submit_skb(<drivname>descriptor, sk_buff)
> and <drvname>_devtx_submit_xdp(<drvname>descriptor, xdp_frame) and then
> corresponding calls for <drvname>_devtx_complete_{skb|xdp}() Then you
> don't spend any cycles building the metadata thing or have to even
> worry about read kfuncs. The BPF program has read access to any
> fields they need. And with the skb, xdp pointer we have the context
> that created the descriptor and generate meaningful metrics.

Sorry but this is not going to happen without my nack. DPDK was a much
cleaner bifurcation point than trying to write datapath drivers in BPF.
Users having to learn how to render descriptors for all the NICs
and queue formats out there is not reasonable. Isovalent hired
a lot of former driver developers so you may feel like it's a good
idea, as a middleware provider. But for the rest of us the matrix
of HW x queue format x people writing BPF is too large. If we can
write some poor man's DPDK / common BPF driver library to be selected
at linking time - we can as well provide a generic interface in
the kernel itself. Again, we never merged explicit DPDK support, 
your idea is strictly worse.

