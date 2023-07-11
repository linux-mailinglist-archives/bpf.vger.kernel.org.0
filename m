Return-Path: <bpf+bounces-4806-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD2E74FB78
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 00:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25499280C75
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 22:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D581ED30;
	Tue, 11 Jul 2023 22:57:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5321ED2C;
	Tue, 11 Jul 2023 22:57:03 +0000 (UTC)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42B1E60;
	Tue, 11 Jul 2023 15:57:02 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-2633fe9b6c0so83644a91.1;
        Tue, 11 Jul 2023 15:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689116222; x=1691708222;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CfgWvCSpj+DnZbG1Qs16+JDRZWOQUcuTeLj26an4Qb4=;
        b=EKLeOSrMbEdpdXS5iI5K4XUsy+PK7ZSQEjEsd2EvVXWQOxssw6gy1bPGaRgT7/GNBG
         ox0FHFiiJJF3BfzaofDW/MqJ47WhJ6IgrxYR9gMcaKI2vHj2RJ2O+bUmU+4MgAjy7NQL
         vccQlQtWOTWYwQIo9rLBiMIYFgfv5d/vHUQ5Rl7BLo2CAucMMv+B5m+uPvDy+49GEu3w
         P7aHpwGOH8OOkkLYtdMG5XBnKtuX1wORDmMMbfwmBhCp8LOaQQAbpd6LwWLVtqCbo0t2
         XnN6FJr/ts3U9SsznT4bUZwLENRAvh3MkbfDXhMN6Tw1qImI0UAaqwCZsCIC7gKt6sJN
         qFJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689116222; x=1691708222;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CfgWvCSpj+DnZbG1Qs16+JDRZWOQUcuTeLj26an4Qb4=;
        b=QBfu5KU5WZgrXNNyTaleKs/hYP5z4jZHygpGbp6peDdTTnEy6aauRaoaiHM6/pwbt6
         PuykBvtLdEbs769Oxrw3bLTo2xwuWg2Au564m0H9Cs/iu1q7wrpetfiHIxcDW9oMEm6r
         k0YzW11y03nxCAY29xU66OjM66sEq2JUXfzBvdQAd9rF14q680c0SG1o5yxZTncpkNYa
         r1MrTCi+Xj9+Kir0fcqu0TCuicUzUaj9+xPTXk+FnK8bQlGCfxoMStCmtEdmzwChHC2J
         FJmZypkRYy0WnQRdQ/fsN+62Wd0aaeaaKfn9FBm19TpA9wAUtOj00yH85D3rTQt3JPY/
         76XA==
X-Gm-Message-State: ABy/qLZFKLzSwI7NaaX5KFXNlhf9kyoi75Vrwh7ts3nhgjKCdOMHhiz2
	dP9D+/1uSRMSmM+KBsgFnHw=
X-Google-Smtp-Source: APBJJlFkylwSDW71IOV/B8MI99JwzyWyjeYA9e6v1H+tWWxuQvNREarIGbloXFKxpKL8mcsiGhVMNA==
X-Received: by 2002:a17:90a:b30d:b0:262:d8e7:abfc with SMTP id d13-20020a17090ab30d00b00262d8e7abfcmr156063pjr.17.1689116221988;
        Tue, 11 Jul 2023 15:57:01 -0700 (PDT)
Received: from MacBook-Pro-8.local ([2620:10d:c090:400::5:f81])
        by smtp.gmail.com with ESMTPSA id i3-20020a17090a7e0300b0026358dfd2a3sm8617227pjl.24.2023.07.11.15.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 15:57:01 -0700 (PDT)
Date: Tue, 11 Jul 2023 15:56:57 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Stanislav Fomichev <sdf@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
	yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
	haoluo@google.com, jolsa@kernel.org, kuba@kernel.org,
	toke@kernel.org, willemb@google.com, dsahern@kernel.org,
	magnus.karlsson@intel.com, bjorn@kernel.org,
	maciej.fijalkowski@intel.com, hawk@kernel.org,
	netdev@vger.kernel.org, xdp-hints@xdp-project.net
Subject: Re: [RFC bpf-next v3 09/14] net/mlx5e: Implement devtx kfuncs
Message-ID: <20230711225657.kuvkil776fajonl5@MacBook-Pro-8.local>
References: <20230707193006.1309662-1-sdf@google.com>
 <20230707193006.1309662-10-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707193006.1309662-10-sdf@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 07, 2023 at 12:30:01PM -0700, Stanislav Fomichev wrote:
> +
> +static int mlx5e_devtx_request_l4_checksum(const struct devtx_ctx *_ctx,
> +					   u16 csum_start, u16 csum_offset)
> +{
> +	const struct mlx5e_devtx_ctx *ctx = (void *)_ctx;
> +	struct mlx5_wqe_eth_seg *eseg;
> +
> +	if (unlikely(!ctx->wqe))
> +		return -ENODATA;
> +
> +	eseg = &ctx->wqe->eth;
> +
> +	switch (csum_offset) {
> +	case sizeof(struct ethhdr) + sizeof(struct iphdr) + offsetof(struct udphdr, check):
> +	case sizeof(struct ethhdr) + sizeof(struct ipv6hdr) + offsetof(struct udphdr, check):
> +		/* Looks like HW/FW is doing parsing, so offsets are largely ignored. */
> +		eseg->cs_flags = MLX5_ETH_WQE_L3_CSUM | MLX5_ETH_WQE_L4_CSUM;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}

I think this proves my point: csum is not generalizable even across veth and mlx5.
Above is a square peg that tries to fit csum_start/offset api (that makes sense from SW pov)
into HW that has different ideas about csum-ing.

Here is what mlx5 does:
mlx5e_txwqe_build_eseg_csum(struct mlx5e_txqsq *sq, struct sk_buff *skb,
                            struct mlx5e_accel_tx_state *accel,
                            struct mlx5_wqe_eth_seg *eseg)
{
        if (unlikely(mlx5e_ipsec_txwqe_build_eseg_csum(sq, skb, eseg)))
                return;

        if (likely(skb->ip_summed == CHECKSUM_PARTIAL)) {
                eseg->cs_flags = MLX5_ETH_WQE_L3_CSUM;
                if (skb->encapsulation) {
                        eseg->cs_flags |= MLX5_ETH_WQE_L3_INNER_CSUM |
                                          MLX5_ETH_WQE_L4_INNER_CSUM;
                        sq->stats->csum_partial_inner++;
                } else {
                        eseg->cs_flags |= MLX5_ETH_WQE_L4_CSUM;
                        sq->stats->csum_partial++;
                }

How would you generalize that into csum api that will work across NICs ?

My answer stands: you cannot.

My proposal again:
add driver specifc kfuncs and hooks for things like csum.

Kuba,
since you nacked driver specific stuff please suggest a way to unblock this stalemate.

