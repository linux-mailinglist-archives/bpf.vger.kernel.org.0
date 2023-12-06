Return-Path: <bpf+bounces-16858-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0B7806992
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 09:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 668C01F215DA
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 08:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A597F19455;
	Wed,  6 Dec 2023 08:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OnSx78k2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28CF20FA;
	Wed,  6 Dec 2023 08:25:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58B7DC433C8;
	Wed,  6 Dec 2023 08:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701851137;
	bh=Gknd/LliCTqqiN0PS1ZD5zwdKhx8CB6t/hKqkvIKlfQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OnSx78k205Z+lG9I8rtqIewDkbl2Mss77gcFrPGChnWxYdKJrLMdqrRvRiXeKi5dq
	 6ESnb1NR7EpnCQpiphIfZyG4ArDBik2F33dX2U/HSD+y/4RSMooRBTyajbLc8/+hKf
	 Kdo1arQfuvqB+wBenp0p+Y5QQGnyqaABDhUUrNH8hOFlQOkjllJq39U8hkgyYbxgqC
	 1NtFANabu+627SbLp/G9uqdbmNvNs0MZOI5eLg9Cadw1EsPCYK5/riZZwlzabGe08z
	 dP+BQ7Cdb6mW4LfdH5wBasWCq2IyKXUnaORhTHRjhyVc9mlbM4J0LSAEBv94n25ch7
	 +6TmKyCSz7LZQ==
Message-ID: <6aa4a628-01b3-4893-a1de-bbfee6216243@kernel.org>
Date: Wed, 6 Dec 2023 09:25:29 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v8 09/18] xdp: Add VLAN tag hint
Content-Language: en-US
To: Larysa Zaremba <larysa.zaremba@intel.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 David Ahern <dsahern@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Willem de Bruijn <willemb@google.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Alexander Lobakin <alexandr.lobakin@intel.com>,
 Magnus Karlsson <magnus.karlsson@gmail.com>,
 Maryam Tahhan <mtahhan@redhat.com>, xdp-hints@xdp-project.net,
 netdev@vger.kernel.org, Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Tariq Toukan <tariqt@mellanox.com>, Saeed Mahameed <saeedm@mellanox.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>
References: <20231205210847.28460-1-larysa.zaremba@intel.com>
 <20231205210847.28460-10-larysa.zaremba@intel.com>
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20231205210847.28460-10-larysa.zaremba@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/5/23 22:08, Larysa Zaremba wrote:
> Implement functionality that enables drivers to expose VLAN tag
> to XDP code.
> 
> VLAN tag is represented by 2 variables:
> - protocol ID, which is passed to bpf code in BE
> - VLAN TCI, in host byte order
> 
> Acked-by: Stanislav Fomichev <sdf@google.com>
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> ---

Small doc nitpicks below, but it can go in-as-is

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

>   Documentation/netlink/specs/netdev.yaml      |  4 +++
>   Documentation/networking/xdp-rx-metadata.rst |  8 ++++-
>   include/net/xdp.h                            |  6 ++++
>   include/uapi/linux/netdev.h                  |  3 ++
>   net/core/xdp.c                               | 33 ++++++++++++++++++++
>   tools/include/uapi/linux/netdev.h            |  3 ++
>   tools/net/ynl/generated/netdev-user.c        |  1 +
>   7 files changed, 57 insertions(+), 1 deletion(-)
[...]

> diff --git a/net/core/xdp.c b/net/core/xdp.c
> index b6f1d6dab3f2..4869c1c2d8f3 100644
> --- a/net/core/xdp.c
> +++ b/net/core/xdp.c
> @@ -736,6 +736,39 @@ __bpf_kfunc int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, u32 *hash,
>   	return -EOPNOTSUPP;
>   }
>   
> +/**
> + * bpf_xdp_metadata_rx_vlan_tag - Get XDP packet outermost VLAN tag
> + * @ctx: XDP context pointer.
> + * @vlan_proto: Destination pointer for VLAN Tag protocol identifier (TPID).

I would have written: Tag Protocol Identifier (TPID).
  - like e.g. CCNA exam https://study-ccna.com/ieee-802-1q/

Capital letters leading up to the short version, but I don't think this
is a requirement. I noticed that wikipedia also got this wrong. So, I it
doesn't really matter. If you need to do a respin, I would appreciate
this changed, but you got my ACK anyway.

> + * @vlan_tci: Destination pointer for VLAN TCI (VID + DEI + PCP)
> + *
> + * In case of success, ``vlan_proto`` contains *Tag protocol identifier (TPID)*,
> + * usually ``ETH_P_8021Q`` or ``ETH_P_8021AD``, but some networks can use
> + * custom TPIDs. ``vlan_proto`` is stored in **network byte order (BE)**
> + * and should be used as follows:
> + * ``if (vlan_proto == bpf_htons(ETH_P_8021Q)) do_something();``
> + *
> + * ``vlan_tci`` contains the remaining 16 bits of a VLAN tag.
> + * Driver is expected to provide those in **host byte order (usually LE)**,
> + * so the bpf program should not perform byte conversion.
> + * According to 802.1Q standard, *VLAN TCI (Tag control information)*
> + * is a bit field that contains:
> + * *VLAN identifier (VID)* that can be read with ``vlan_tci & 0xfff``,
> + * *Drop eligible indicator (DEI)* - 1 bit,

Drop Eligible Indicator (DEI)

> + * *Priority code point (PCP)* - 3 bits.

Priority Code Point (PCP)

> + * For detailed meaning of DEI and PCP, please refer to other sources.
> + *
> + * Return:
> + * * Returns 0 on success or ``-errno`` on error.
> + * * ``-EOPNOTSUPP`` : device driver doesn't implement kfunc
> + * * ``-ENODATA``    : VLAN tag was not stripped or is not available
> + */
> +__bpf_kfunc int bpf_xdp_metadata_rx_vlan_tag(const struct xdp_md *ctx,
> +					     __be16 *vlan_proto, u16 *vlan_tci)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
>   __bpf_kfunc_end_defs();

