Return-Path: <bpf+bounces-11661-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 786A47BCEA1
	for <lists+bpf@lfdr.de>; Sun,  8 Oct 2023 15:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 871511C20A4E
	for <lists+bpf@lfdr.de>; Sun,  8 Oct 2023 13:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4A7C8E8;
	Sun,  8 Oct 2023 13:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uAc0d7Eu"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04FAC2D0;
	Sun,  8 Oct 2023 13:48:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C84B1C433C9;
	Sun,  8 Oct 2023 13:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696772911;
	bh=YqTjTo5qyvkFsUpprDwEhsylJzLXDife+dFG3kvmIos=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uAc0d7Eu3wsB7TPeiq8k9jJaW1Pux44ZYGjqdsRj/D/qotZsKSpRwF/mRF+5do/4L
	 vozcc4+E92ocPnK+oeNCSJhUHBUSciurAxrkapFAO9ulag/udKrJ+sECmiUfoYtCs/
	 BoJuz5pe6dJXd7osLrF5Q6xRWTML4LgfX5d+p/eCyAP/g5YCLsKUwXV/qKByy/JlyE
	 MPf/FgjZ+eH2bI4dzof8Uq6cz17B7GXqOp3XZfis0NgfXKxdojdYh7nCL5ejN6ojzZ
	 93OW06nc2lmB8OBelv4+PeoaI/iyLKVoA0QQSTpu9eC+OT4rKLPpVRKaft8kQgSwrg
	 Jr4evKXMXpyEA==
Date: Sun, 8 Oct 2023 15:48:24 +0200
From: Simon Horman <horms@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>, Hao Luo <haoluo@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Paolo Abeni <pabeni@redhat.com>, Song Liu <song@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v2] net: Add a warning if NAPI cb missed
 xdp_do_flush().
Message-ID: <20231008134824.GG831234@kernel.org>
References: <20230929165825.RvwBYGP1@linutronix.de>
 <20231004070926.5b4ba04c@kernel.org>
 <20231006154933.mQgxQHHt@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006154933.mQgxQHHt@linutronix.de>

On Fri, Oct 06, 2023 at 05:49:33PM +0200, Sebastian Andrzej Siewior wrote:
> A few drivers were missing a xdp_do_flush() invocation after
> XDP_REDIRECT.
> 
> Add three helper functions each for one of the per-CPU lists. Return
> true if the per-CPU list is non-empty and flush the list.
> Add xdp_do_check_flushed() which invokes each helper functions and
> creats a warning if one of the functions had a non-empty list.

nit: creates

> Hide everything behind CONFIG_DEBUG_NET.
> 
> Suggested-by: Jesper Dangaard Brouer <hawk@kernel.org>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

...

