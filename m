Return-Path: <bpf+bounces-12407-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6FE7CC35A
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 14:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEEDB281A4B
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 12:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2645D41E2A;
	Tue, 17 Oct 2023 12:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lT4TZ6Ny"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB36642BF2;
	Tue, 17 Oct 2023 12:40:27 +0000 (UTC)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA0DB6;
	Tue, 17 Oct 2023 05:40:26 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-4083740f92dso1758245e9.3;
        Tue, 17 Oct 2023 05:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697546424; x=1698151224; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1go1+s1mgfonK9oITafKnNr2oyG8bY2MnLUtwcvNu/E=;
        b=lT4TZ6NyXzaLIy3wmI4cKHkE+veDxUoxVXlqwaTKNdz+LpuYu3pVkbhZvX8vzS8lXq
         cyYJDpBc1kIb3YpMt8QgysTxU0emriS0dzrkPmT6GXZZ4UmE9DxdLkq5Ds5kZhoLpJxj
         Jjgcbentw6UDi0cM4k7IWppz+rYR2I0/d+wE6/cWHNs876RWoFvdKZA+yBuzhskTajfa
         eIXb0xT8vuARO3CyllrUZ68t5wWQpL6khLnjjO1UnIKOaXfBajcpVSlSp0CD4MYBumYS
         RVIl+T7nuxHrtfg4wPcL1RcFRUu20c6ft7I48wOALpCEEe1iStWc4AMkcc1/1dKmanzt
         QRkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697546424; x=1698151224;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1go1+s1mgfonK9oITafKnNr2oyG8bY2MnLUtwcvNu/E=;
        b=i/ccfrT/zMkCko9Zku0DYYSDbYK50H2D60gSWcdsPvqjZXjdSeq6ImXa3IFCRhcqCH
         U2Bhx6nM4IFCLmL0PWJBBRTrUYObdfha6MnhNsPMin+lTr+NfYa+d9zX33yDtxKPrhUp
         CpQqiKEjfNG+J/lSkGQiniDDYpUwblypQTyiBthOtbH8ESowHF3Z91Ub0Unu/Dtf0sGV
         ws/Q8SfPqZWQoOktFNwpLjOriQTDSk7MJQofMm2jYQtji5hLq4fudxoWMSkOSlXyen06
         ETD4N5rm/BBjMFQMq8wFjHnG0R6cBnWhEouJgq/XmXFXdHKjeJ2UQ1HzJv/7VnPI0zME
         Bo2Q==
X-Gm-Message-State: AOJu0YzqW5fNKa2mLg8qFSXHPml8bmbceDsSlzomnyrMh9bHo6umuPEq
	fw+qtDJ3U/EP9BkARrpaIbg=
X-Google-Smtp-Source: AGHT+IFaACminfVZMAM6mi8DZGRoe9jf+PlS6ZoKsH1wa0bGwwiO0cZz0WNUKUK7Ha3vZTD7sQt0aQ==
X-Received: by 2002:a05:600c:245:b0:405:82c0:d9d9 with SMTP id 5-20020a05600c024500b0040582c0d9d9mr1650932wmj.41.1697546424222;
        Tue, 17 Oct 2023 05:40:24 -0700 (PDT)
Received: from [192.168.0.101] ([77.126.80.27])
        by smtp.gmail.com with ESMTPSA id u18-20020a05600c211200b00401d8181f8bsm9599250wml.25.2023.10.17.05.40.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 05:40:23 -0700 (PDT)
Message-ID: <3d82e9a0-bae2-48dd-9bd7-941570748076@gmail.com>
Date: Tue, 17 Oct 2023 15:40:19 +0300
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v6 14/18] mlx5: implement VLAN tag XDP hint
Content-Language: en-US
To: Larysa Zaremba <larysa.zaremba@intel.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 David Ahern <dsahern@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Willem de Bruijn <willemb@google.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Alexander Lobakin <alexandr.lobakin@intel.com>,
 Magnus Karlsson <magnus.karlsson@gmail.com>,
 Maryam Tahhan <mtahhan@redhat.com>, xdp-hints@xdp-project.net,
 netdev@vger.kernel.org, Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Simon Horman <simon.horman@corigine.com>, Tariq Toukan
 <tariqt@mellanox.com>, Saeed Mahameed <saeedm@mellanox.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>
References: <20231012170524.21085-1-larysa.zaremba@intel.com>
 <20231012170524.21085-15-larysa.zaremba@intel.com>
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20231012170524.21085-15-larysa.zaremba@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 12/10/2023 20:05, Larysa Zaremba wrote:
> Implement the newly added .xmo_rx_vlan_tag() hint function.
> 
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c | 15 +++++++++++++++
>   include/linux/mlx5/device.h                      |  2 +-
>   2 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
> index 12f56d0db0af..d7cd14687ce8 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
> @@ -256,9 +256,24 @@ static int mlx5e_xdp_rx_hash(const struct xdp_md *ctx, u32 *hash,
>   	return 0;
>   }
>   
> +static int mlx5e_xdp_rx_vlan_tag(const struct xdp_md *ctx, __be16 *vlan_proto,
> +				 u16 *vlan_tci)
> +{
> +	const struct mlx5e_xdp_buff *_ctx = (void *)ctx;
> +	const struct mlx5_cqe64 *cqe = _ctx->cqe;
> +

I see inconsistency in using/not using "const" between the different 
drivers.

Other than that, patch LGTM.

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>

> +	if (!cqe_has_vlan(cqe))
> +		return -ENODATA;
> +
> +	*vlan_proto = htons(ETH_P_8021Q);
> +	*vlan_tci = be16_to_cpu(cqe->vlan_info);
> +	return 0;
> +}
> +
>   const struct xdp_metadata_ops mlx5e_xdp_metadata_ops = {
>   	.xmo_rx_timestamp		= mlx5e_xdp_rx_timestamp,
>   	.xmo_rx_hash			= mlx5e_xdp_rx_hash,
> +	.xmo_rx_vlan_tag		= mlx5e_xdp_rx_vlan_tag,
>   };
>   
>   /* returns true if packet was consumed by xdp */
> diff --git a/include/linux/mlx5/device.h b/include/linux/mlx5/device.h
> index 8fbe22de16ef..0805f8231452 100644
> --- a/include/linux/mlx5/device.h
> +++ b/include/linux/mlx5/device.h
> @@ -916,7 +916,7 @@ static inline u8 get_cqe_tls_offload(struct mlx5_cqe64 *cqe)
>   	return (cqe->tls_outer_l3_tunneled >> 3) & 0x3;
>   }
>   
> -static inline bool cqe_has_vlan(struct mlx5_cqe64 *cqe)
> +static inline bool cqe_has_vlan(const struct mlx5_cqe64 *cqe)
>   {
>   	return cqe->l4_l3_hdr_type & 0x1;
>   }

