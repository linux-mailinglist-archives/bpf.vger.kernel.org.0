Return-Path: <bpf+bounces-64826-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1EC0B1756A
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 19:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2690318C524D
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 17:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37C6241663;
	Thu, 31 Jul 2025 17:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G0ZCTUEK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC991DE8A8;
	Thu, 31 Jul 2025 17:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753981548; cv=none; b=XPZQXVKqzxxm0cKZRz+oGZ/8413KNN0ZsLsuaoZX3SKlZ3Wl2P+moBhKS8cjTfgrv+jmYCY8FA6sklRqezGajkPuRIrnu1R3rrjjpfWCifJa+97s75l925hBUIyoC4g50d8zrr3Kag5oyEuty+PULI5BCNBtrRPV4pg/J1wMCwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753981548; c=relaxed/simple;
	bh=cygdeMZgK8iW3+xuI2Q01zkcGjAmxwn4nIdnViALepc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tZyIcWKnBUqXTqeQKca8D7WnEWOPNaJxpEzMq6ODgPQNqUyMnq3/TrX2lSvXOZY3Srk97ql4AqyyLieEVKzIWIPmZ0JZz3vpxrgBvkOjDEYlf+Et2Yy8A6fvXAlUltnWUhhGLuUoQrMWIndc2Ql5TF0MBuqUyZTP5QTKpzZ1eM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G0ZCTUEK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09D6BC4CEEF;
	Thu, 31 Jul 2025 17:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753981548;
	bh=cygdeMZgK8iW3+xuI2Q01zkcGjAmxwn4nIdnViALepc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G0ZCTUEKD9dun9DBxQYzx4GHq2lIpW/KDI9pFeE32zJIBNpUzP/FFvrdecrjwQf84
	 Snz90sAhbikpsX3fCAvtqQoNR3Yl8YuLiqUxPCciFpUuiRnX08tO6sxyKF7IpEYKay
	 f3yvKnhu01DA9k4hwPs81dSCklqesFppVvmDhkQAKiugR48zYm890ZcmMWfHmLW+NS
	 VnJc2mvnvy986vxxBto1dpRoyZH7KTIYtRUSqgVcoU6RknqiBrdTIanBJb7FM5aYIq
	 OLyH7s5ANotGLlkRTto+hjErAZ07bXo2z5GGSRUYFjEfgGYMosqxpw43tMZzhRXjjI
	 0NwDzzdyIGzhA==
Date: Thu, 31 Jul 2025 10:05:47 -0700
From: Kees Cook <kees@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	Michal Kubiak <michal.kubiak@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	nxne.cnse.osdt.itp.upstreaming@intel.com, bpf@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH iwl-next v3 16/18] idpf: add support for XDP on Rx
Message-ID: <202507310955.03E47CFA4@keescook>
References: <20250730160717.28976-1-aleksander.lobakin@intel.com>
 <20250730160717.28976-17-aleksander.lobakin@intel.com>
 <20250731123734.GA8494@horms.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731123734.GA8494@horms.kernel.org>

On Thu, Jul 31, 2025 at 01:37:34PM +0100, Simon Horman wrote:
> While I appreciate the desire for improved performance and nicer code
> generation. I think the idea of writing 64 bits of data to the
> address of a 32 bit member of a structure goes against the direction
> of hardening work by Kees and others.

Agreed: it's better to avoid obscuring these details from the compiler
so it can have an "actual" view of the object sizes involved.

> Indeed, it seems to me this is the kind of thing that struct_group()
> aims to avoid.
> 
> In this case struct group() doesn't seem like the best option,
> because it would provide a 64-bit buffer that we can memcpy into.
> But it seems altogether better to simply assign u64 value to a u64 member.

Agreed: with struct_group you get a sized pointer, and while you can
provide a struct tag to make it an assignable object, it doesn't make
too much sense here.

> So I'm wondering if an approach along the following lines is appropriate
> (Very lightly compile tested only!).
> 
> And yes, there is room for improvement of the wording of the comment
> I included below.
> 
> diff --git a/include/net/libeth/xdp.h b/include/net/libeth/xdp.h
> index f4880b50e804..a7d3d8e44aa6 100644
> --- a/include/net/libeth/xdp.h
> +++ b/include/net/libeth/xdp.h
> @@ -1283,11 +1283,7 @@ static inline void libeth_xdp_prepare_buff(struct libeth_xdp_buff *xdp,
>  	const struct page *page = __netmem_to_page(fqe->netmem);
>  
>  #ifdef __LIBETH_WORD_ACCESS
> -	static_assert(offsetofend(typeof(xdp->base), flags) -
> -		      offsetof(typeof(xdp->base), frame_sz) ==
> -		      sizeof(u64));
> -
> -	*(u64 *)&xdp->base.frame_sz = fqe->truesize;
> +	xdp->base.frame_sz_le_qword = fqe->truesize;
>  #else
>  	xdp_init_buff(&xdp->base, fqe->truesize, xdp->base.rxq);
>  #endif
> diff --git a/include/net/xdp.h b/include/net/xdp.h
> index b40f1f96cb11..b5eedeb82c9b 100644
> --- a/include/net/xdp.h
> +++ b/include/net/xdp.h
> @@ -85,8 +85,19 @@ struct xdp_buff {
>  	void *data_hard_start;
>  	struct xdp_rxq_info *rxq;
>  	struct xdp_txq_info *txq;
> -	u32 frame_sz; /* frame size to deduce data_hard_end/reserved tailroom*/
> -	u32 flags; /* supported values defined in xdp_buff_flags */
> +	union {
> +		/* Allow setting frame_sz and flags as a single u64 on
> +		 * little endian systems. This may may give optimal
> +		 * performance. */
> +		u64 frame_sz_le_qword;
> +		struct {
> +			/* Frame size to deduce data_hard_end/reserved
> +			 * tailroom. */
> +			u32 frame_sz;
> +			/* Supported values defined in xdp_buff_flags. */
> +			u32 flags;
> +		};
> +	};
>  };

Yeah, this looks like a nice way to express this, and is way more
descriptive than "(u64 *)&xdp->base.frame_sz" :)

-- 
Kees Cook

