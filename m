Return-Path: <bpf+bounces-6195-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A19DA766C80
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 14:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2A321C218B4
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 12:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B58012B8A;
	Fri, 28 Jul 2023 12:05:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D9B12B7A;
	Fri, 28 Jul 2023 12:05:03 +0000 (UTC)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634B049CA;
	Fri, 28 Jul 2023 05:04:43 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-316feb137a7so2112767f8f.1;
        Fri, 28 Jul 2023 05:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690545872; x=1691150672;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4bcvalQ+R6YdM9yrzOg4XrhvGqh24IDmYkzpcPKdELc=;
        b=nb82M6d6yvRXevHSaIDKKsI3HduyPBC/rXmwVMh8ZR5qYTOwSvmrtocJBg+8vhDA6j
         tPLm+qZe+ZghpVj9OM2605RYTK8/Q85ZQSQ2J9sADO3/SLMd3mXUH6pvkQmo4SZrvEPs
         tRM86iMyqvXRZojI8LnQdxHpYH1KxVmSx5hvyqW0Z1/6Oe0ZvCSSA7fg+ADkQ19QS/8O
         QHmGbiTQXxCbTQFYGNug4ye+qmy5JCMeNw+rCwLWxlZQUAhwGLbXK1YSFHFX0/Q95oZH
         pDBhAAoiOULixpyAsC4alKyTjtUymM63puzqjKaEEZgiRSC16kfVXpIiLKoqkrG5KGm7
         kiAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690545872; x=1691150672;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4bcvalQ+R6YdM9yrzOg4XrhvGqh24IDmYkzpcPKdELc=;
        b=ShHs0D5X/zhOvDUDnQ2ySKYkUkTWzqCXWhQP5HZU0rSbBc2O35epBmmCh96cyahHEz
         8vO5QHn9Uz9GLtWw7NjzdGmuhAeIGUSuhql7NgrKW0uWMhadyXy8CnlBboYNR/icmkJM
         iNH0CZImVQgp5ieQrpSyn0NUmA//ZJDmH6Cy+/MMCFvUI8AteZBMqNQ1fZHoVM75AZwK
         drpkzIgMBxnpMfaTVjNPqccatT84G5lT7RxifMKL3gO3di+LZ+Se1pwi9s6zor1AJEQP
         u5HdbIYyvrYRS4TkrsvROpkLz49RI/Fw5N1XN4h57+odKXRofEfhGwWXBoO0FZJMtUfM
         gU2A==
X-Gm-Message-State: ABy/qLYrfBZaINEEqI8U7dkA+7PwOFxVkF/wwhesqL0aSn1fZoGwwnaR
	aUsOI4rzMZBnXsPrKyJtroM=
X-Google-Smtp-Source: APBJJlE0KS7BJHu0X4z9vKRfl/JOa76cofZp5VWVGy6RqX4NIgtoSa2M9nW+5b5KLgJeM+okKJNITg==
X-Received: by 2002:a5d:6082:0:b0:314:54f0:df35 with SMTP id w2-20020a5d6082000000b0031454f0df35mr2009125wrt.16.1690545871547;
        Fri, 28 Jul 2023 05:04:31 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id d12-20020a5d644c000000b003142e438e8csm4709975wrw.26.2023.07.28.05.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 05:04:31 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 28 Jul 2023 14:04:28 +0200
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn.topel@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	houtao1@huawei.com
Subject: Re: [PATCH bpf-next 1/2] bpf, cpumap: Remove unused cmap field from
 bpf_cpu_map_entry
Message-ID: <ZMOuzBkjFGzHjJNI@krava>
References: <20230728014942.892272-1-houtao@huaweicloud.com>
 <20230728014942.892272-2-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728014942.892272-2-houtao@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 28, 2023 at 09:49:41AM +0800, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> Since commit cdfafe98cabe ("xdp: Make cpumap flush_list common for all
> map instances"), cmap is no longer used, so just remove it.

nit, should it have Fixes: cdfafe98cabe ?

same for the other patch, other than that for the patchset:

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> 
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  kernel/bpf/cpumap.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
> index 6ae02be7a48e..0a16e30b16ef 100644
> --- a/kernel/bpf/cpumap.c
> +++ b/kernel/bpf/cpumap.c
> @@ -60,8 +60,6 @@ struct bpf_cpu_map_entry {
>  	/* XDP can run multiple RX-ring queues, need __percpu enqueue store */
>  	struct xdp_bulk_queue __percpu *bulkq;
>  
> -	struct bpf_cpu_map *cmap;
> -
>  	/* Queue with potential multi-producers, and single-consumer kthread */
>  	struct ptr_ring *queue;
>  	struct task_struct *kthread;
> @@ -588,7 +586,6 @@ static long cpu_map_update_elem(struct bpf_map *map, void *key, void *value,
>  		rcpu = __cpu_map_entry_alloc(map, &cpumap_value, key_cpu);
>  		if (!rcpu)
>  			return -ENOMEM;
> -		rcpu->cmap = cmap;
>  	}
>  	rcu_read_lock();
>  	__cpu_map_entry_replace(cmap, key_cpu, rcpu);
> -- 
> 2.29.2
> 

