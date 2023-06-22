Return-Path: <bpf+bounces-3187-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1630F73A941
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 21:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C29C7281AC8
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 19:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E282108B;
	Thu, 22 Jun 2023 19:58:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C212200C6;
	Thu, 22 Jun 2023 19:58:05 +0000 (UTC)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101832116;
	Thu, 22 Jun 2023 12:58:01 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1b52864b701so58103015ad.3;
        Thu, 22 Jun 2023 12:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687463880; x=1690055880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N+x18MbPYs9V+rBoSKHWH+hb3PjBj/UOGiK88eF8YxM=;
        b=KAfRwXKfbJhgepD4hlRzoOwmY1p9Qt33QHKLP7ZU+EjZV+9whhs/ZE8XfjXuc7Pqcu
         88rG2trZ1F+x0w/+GCzhm9VKTMG82romdey6VTjgjmzBSSBBw6K5pc0pWlxDDkh2Mlca
         3oxupctNT9iUMT7tseTJxExy5niMs9e6Rl40lGlf2crSyxF+SllN9jNGtMXbJtGU010u
         C92eN60EaRXWsrEu29KaZBLjOylTXizsaYPS760WcLWPlrvGavX4Y0PZV9wl/7djLo0Q
         ahhAQ6omiuHsCAWsjw6/Fhazl2NzZ8ejZ9Hjd7x9xuOQnpwKw0omFyeTcJcEV8qgCXeI
         PmbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687463880; x=1690055880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N+x18MbPYs9V+rBoSKHWH+hb3PjBj/UOGiK88eF8YxM=;
        b=M4Yg9dNaU/7kZlgsmi35vWO5Qkhz+LPNR40JmugpFua/gt3yVw9v8kJKk4P924yjVd
         YQ+lRsWvtlZ1QMrg+dFdw9QfNFWSateTxD2vaH5bzuOipGlUQJ9ds7W5d9yUZf3WGxR2
         iY3YGheG4hIJgAFSGCkkLYHLN+hLxLGEWNsdqDFJ2r75iozIu7UUSV8vPgBAPMpL62tH
         DbCfsfExUqdHZPOKriQkOvM3QouO71g8ixnK9upNF3b4revTB35gQJsHfJsP8tGA4Mt6
         iYa+VXWDEerUJuq2kQlEIhrTBrpJnUakYR+l6K0arvN0QVTU8nsynf8R7Msi3llOl+hT
         yQ3w==
X-Gm-Message-State: AC+VfDzxsAR950cVA8PHD7W/48G3KKTmLXLzdssN+2SWe1szsjzcBUt9
	vsZdoaOtRo3AokCqj3OKkUA=
X-Google-Smtp-Source: ACHHUZ7k2HkJNhodANf5mrluDeQGdXuDea+QD9+qf8ZuWGXquHlpyc1kciYrUmiLWwV47kLxIFdhvQ==
X-Received: by 2002:a17:902:d2c2:b0:1b6:9551:e2b8 with SMTP id n2-20020a170902d2c200b001b69551e2b8mr7977005plc.34.1687463880351;
        Thu, 22 Jun 2023 12:58:00 -0700 (PDT)
Received: from macbook-pro-8.dhcp.thefacebook.com ([2620:10d:c090:500::4:95b5])
        by smtp.gmail.com with ESMTPSA id c2-20020a170903234200b001b6740207d2sm5718364plh.215.2023.06.22.12.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 12:57:59 -0700 (PDT)
Date: Thu, 22 Jun 2023 12:57:57 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Stanislav Fomichev <sdf@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
	yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
	haoluo@google.com, jolsa@kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC bpf-next v2 11/11] net/mlx5e: Support TX timestamp metadata
Message-ID: <20230622195757.kmxqagulvu4mwhp6@macbook-pro-8.dhcp.thefacebook.com>
References: <20230621170244.1283336-1-sdf@google.com>
 <20230621170244.1283336-12-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621170244.1283336-12-sdf@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jun 21, 2023 at 10:02:44AM -0700, Stanislav Fomichev wrote:
> WIP, not tested, only to show the overall idea.
> Non-AF_XDP paths are marked with 'false' for now.
> 
> Cc: netdev@vger.kernel.org
> Signed-off-by: Stanislav Fomichev <sdf@google.com>
> ---
>  .../net/ethernet/mellanox/mlx5/core/en/txrx.h | 11 +++
>  .../net/ethernet/mellanox/mlx5/core/en/xdp.c  | 96 ++++++++++++++++++-
>  .../net/ethernet/mellanox/mlx5/core/en/xdp.h  |  9 +-
>  .../ethernet/mellanox/mlx5/core/en/xsk/tx.c   |  3 +
>  .../net/ethernet/mellanox/mlx5/core/en_tx.c   | 16 ++++
>  .../net/ethernet/mellanox/mlx5/core/main.c    | 26 ++++-
>  6 files changed, 156 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
> index 879d698b6119..e4509464e0b1 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
> @@ -6,6 +6,7 @@
>  
>  #include "en.h"
>  #include <linux/indirect_call_wrapper.h>
> +#include <net/devtx.h>
>  
>  #define MLX5E_TX_WQE_EMPTY_DS_COUNT (sizeof(struct mlx5e_tx_wqe) / MLX5_SEND_WQE_DS)
>  
> @@ -506,4 +507,14 @@ static inline struct mlx5e_mpw_info *mlx5e_get_mpw_info(struct mlx5e_rq *rq, int
>  
>  	return (struct mlx5e_mpw_info *)((char *)rq->mpwqe.info + array_size(i, isz));
>  }
> +
> +struct mlx5e_devtx_frame {
> +	struct devtx_frame frame;
> +	struct mlx5_cqe64 *cqe; /* tx completion */

cqe is only valid at completion.

> +	struct mlx5e_tx_wqe *wqe; /* tx */

wqe is only valid at submission.

imo that's a very clear sign that this is not a generic datastructure.
The code is trying hard to make 'frame' part of it look common,
but it won't help bpf prog to be 'generic'.
It is still going to precisely coded for completion vs submission.
Similarly a bpf prog for completion in veth will be different than bpf prog for completion in mlx5.
As I stated earlier this 'generalization' and 'common' datastructure only adds code complexity.

