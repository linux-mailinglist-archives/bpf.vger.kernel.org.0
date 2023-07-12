Return-Path: <bpf+bounces-4821-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB57274FD6D
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 05:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17AB51C20E8D
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 03:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE2881E;
	Wed, 12 Jul 2023 03:07:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F0138F;
	Wed, 12 Jul 2023 03:07:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E4C6C433C8;
	Wed, 12 Jul 2023 03:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689131261;
	bh=uOoIoKaMaiPjbxEKLwffsfSd7isUyv91luMjnMlx8iI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=alvo3LKZuPmcu5955E9J9ZB+IPN6beiUyQ2ECUv0JGwmn+MPM8kRwx5Sg5P1tOENb
	 UZCnueAWtbS0qnwmUqP+cnCS9UYuVK4KYRs2maGz47TdpKQr1/l92g86hGUbeNXfdW
	 BvhNrSgaCvYzSmNEIggaJoa5KLbzDLEAYdffC9VA7HH9S3fnHDPkYB5NoZW1WPjPKy
	 Yg7Mj+NQg/zv61cHjaBVUk7EuReKdP1DmN7BHBOMoedN7vLXeJ9ri5+bX2yOEoAi9O
	 vVqVkc7Cqinsgf52YGE+5J8NPuodahImjXBfaZhQhXbFi3JLbG1MMKu6ZhwleZt7IS
	 CA+ieJG9u3Iig==
Date: Tue, 11 Jul 2023 20:07:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Stanislav Fomichev <sdf@google.com>, bpf <bpf@vger.kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh
 <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?=
 <toke@kernel.org>, Willem de Bruijn <willemb@google.com>, David Ahern
 <dsahern@kernel.org>, "Karlsson, Magnus" <magnus.karlsson@intel.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, "Fijalkowski, Maciej"
 <maciej.fijalkowski@intel.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Network Development <netdev@vger.kernel.org>, xdp-hints@xdp-project.net
Subject: Re: [RFC bpf-next v3 09/14] net/mlx5e: Implement devtx kfuncs
Message-ID: <20230711200740.236b0142@kernel.org>
In-Reply-To: <CAADnVQJ3iyoZaxaALWd4zTsDT3Z=czU4g7qpmBFWPUs5ucqCMg@mail.gmail.com>
References: <20230707193006.1309662-1-sdf@google.com>
	<20230707193006.1309662-10-sdf@google.com>
	<20230711225657.kuvkil776fajonl5@MacBook-Pro-8.local>
	<20230711173226.7e9cca4a@kernel.org>
	<CAADnVQJ3iyoZaxaALWd4zTsDT3Z=czU4g7qpmBFWPUs5ucqCMg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Jul 2023 19:37:23 -0700 Alexei Starovoitov wrote:
> > I hope I'm not misremembering but I think I suggested at the beginning
> > to create a structure describing packet geometry and requested offloads,
> > and for the prog fill that in.  
> 
> hmm. but that's what skb is for. skb == packet geometry ==
> layout of headers, payload, inner vs outer, csum partial, gso params.
> 
> bpf at tc layer supposed to interact with that correctly.
> If the packet is modified skb geometry should be adjusted accordingly.
> Like BPF_F_RECOMPUTE_CSUM flag in bpf_skb_store_bytes().
> 
> > All operating systems I know end up doing that, we'll end up doing
> > that as well. The question is whether we're willing to learn from
> > experience or prefer to go on a wild ride first...  
> 
> I don't follow. This thread was aimed to add xdp layer knobs.
> To me XDP is a driver level.

Driver is not a layer of the networking stack, I don't think it's 
a useful or meaningful anchor point for the mental model. 

We're talking about a set of functionality, we can look at how that
functionality was exposed in existing code.

> 'struct xdp_md' along with
> BPF_F_XDP_HAS_FRAGS is the best abstraction we could do generalizing
> dma-buffers (page and multi-page) that drivers operate on.

I think you're working against your own claim.
xdp frags explicitly reuse struct skb_shared_info.

> Everything else at driver level is too unique to generalize.
> skb layer is already doing its job.

How can you say that drivers are impossible to generalize and than
that the skb layer "is doing its job" ie. generalizes them?

> In that sense "generic XDP" is a feature for testing only.
> Trying to make "generic XDP" fast is missing the point of XDP.

That's a topic on its own.

> AF_XDP is a different concept. Exposing timestamp,
> csum, TSO to AF_XDP users is a different design challenge.
> I'm all for doing that, but trying to combine "timestamp in xdp tx"
> and "timestamp in AF_XDP" will lead to bad trade-off-s for both.
> Which I think this patchset demonstrates.

Too vague to agree or disagree with.

