Return-Path: <bpf+bounces-46981-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D819F1C9A
	for <lists+bpf@lfdr.de>; Sat, 14 Dec 2024 05:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C674188D8CC
	for <lists+bpf@lfdr.de>; Sat, 14 Dec 2024 04:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F0E74E09;
	Sat, 14 Dec 2024 04:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dp4m+iRx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3B718622;
	Sat, 14 Dec 2024 04:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734151876; cv=none; b=Wnd3aVz25f4hcf6SZGRv8h+DnrRS9gxQtcioHqUz1Xm3QFb+2q+x5CtLvow+CQ2QrTV5xs5IU1wbNfMZpcTchQ+5qqN9PqZbaCklA360PhcjGEsKll38v7y6VFENC4Bz336XjATFa5qALkDh8yfnaLhneUqc+7SGTWMB+B1AszM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734151876; c=relaxed/simple;
	bh=Cbdl76/0CAlwb95ux1AtI9RUbOj2IELwzkslvMHs1cY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TCNsdfawjark7wHCymkw0zGFEKYNvtuMLwvga3yklM7X0BqsRebIzAPM81AOQB0VzC98P7V3sZFBeJ+JVJyzYZrTOQuZVa9UcgJuDsxxkbl2F07OhQas2NsvdhDK6x5s5NINpW5taH29MtC+efqMp6mbwOt21O10VjCf/iWmHD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dp4m+iRx; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2167141dfa1so20852535ad.1;
        Fri, 13 Dec 2024 20:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734151875; x=1734756675; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VsPxLy75RjSRhwiVrC80G6MBE9thvtOk6W3+q+v/8VY=;
        b=Dp4m+iRxhokimR2A4HAwGfQNiyW9dJ5CGUMEHj/FKxUKNLyo/wMnmnUDsFoiEGPM9Z
         WN4AZ0f7u5EDh8NQ1o5ffOjCedQDrvnULqXwrW48FHltRNsFw5adhxf6JArzkgbIA59g
         3a2tRsi5uWH+XOSK7c4bG0HLNovUoEKI0x8hanOXyMkrzh7ouuA/FABMx+er/P3CJp8B
         V6/gI/ebo1okmyNujDucdnNqB4lkREskSkOxDVRlzUuEr9PtvDO2dfHn2OZI4W8rHEvF
         vxTnCdYvgUtvWCT2FNG5SOzsEZkRJuNQ04Zut3Ta+LpnSJI4oaaIEq1LJAGYz6/JHnFq
         ScTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734151875; x=1734756675;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VsPxLy75RjSRhwiVrC80G6MBE9thvtOk6W3+q+v/8VY=;
        b=IeSFcroaSXbTUMNU0FR8KqdWFn/W2PQINfkRatmyvB8zmlqmS18VYotSFSArtVu+4g
         fSm2w48BCxbCqp4YxWyqCBDIOQm4qMXWW5F9yxQ3s1GjDWz4OLZnE7iqcG8sZFpelrfF
         XNSJ0X5z+/iti7Je3QeIzI/GrJaUdnFNe2sEXhE9cZIZ0H7V7TuwCi2mdnHll+x0XAL3
         iCKJWYTlTKyYFPZSvKf5yxbxZQEbgwL0D32eKrqyiF5wn97+JWfEi2etKgJ/bbKtZSbq
         DALSLIMA3CD8XF2VJx9JvvJaUKHe5BgmYdWu29HQFVAVi7Qg/64iyDDRIzGd5+8Cbw2n
         4HRg==
X-Forwarded-Encrypted: i=1; AJvYcCWaC6pg64UVZIf63etTTLz4/EDhCfd/APQuxKxa/egrAi+wW5GC7fkYqtAf8rl2GlPAOtM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjp44LG0iiSm1HGyeU+8RD+OPlcbMzqxjmNb28CFTrKkrqKblY
	6AigvVVhAKHh/R8pilgj2gasxJa0N8z5xG3FH4myTb+B3vgc2b8e
X-Gm-Gg: ASbGncufQ2uRkyG3k6zgh2CVkxOvNnnfrWPOWoOr9MSu03xUbYz5iIL637JIgVMb1Sr
	MvQDuWhUZvfiewRXjnzfUoFs3VYecW91GJZPHbJFHxDfpVmaFoHLNgD4kgEW6TaJ0ZYDM95ztvL
	aC7EboayG7u9rf5alPcPEtnWwdELDutQp7St3h1tjTi9JclXUBLNZkKGwFFzEfihCQW3P51KlTc
	r/GxVnWgzX/h4oFYTRumKHWSX2TKInb3W+j48o889vx0lDIM0CxKZFrh4sYh6g=
X-Google-Smtp-Source: AGHT+IEJp9RdfXzuHqG9bMzpEvPNju21ExCDajs6Jqep/zQAJj9+QsgS7dtTx62/cUcXApgIV309MQ==
X-Received: by 2002:a17:902:d507:b0:215:7287:67bb with SMTP id d9443c01a7336-218939daad8mr80017695ad.0.1734151874663;
        Fri, 13 Dec 2024 20:51:14 -0800 (PST)
Received: from localhost ([2601:647:6881:9060:ede9:5cb0:814a:63a6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1dcb35esm5637215ad.62.2024.12.13.20.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 20:51:14 -0800 (PST)
Date: Fri, 13 Dec 2024 20:51:13 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Amery Hung <amery.hung@bytedance.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, alexei.starovoitov@gmail.com,
	martin.lau@kernel.org, sinquersw@gmail.com, toke@redhat.com,
	jhs@mojatatu.com, jiri@resnulli.us, stfomichev@gmail.com,
	ekarani.silvestre@ccc.ufcg.edu.br, yangpeihao@sjtu.edu.cn,
	yepeilin.cs@gmail.com, ameryhung@gmail.com
Subject: Re: [PATCH bpf-next v1 05/13] bpf: net_sched: Support implementation
 of Qdisc_ops in bpf
Message-ID: <Z10OwXiU/RTx3Qbe@pop-os.localdomain>
References: <20241213232958.2388301-1-amery.hung@bytedance.com>
 <20241213232958.2388301-6-amery.hung@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213232958.2388301-6-amery.hung@bytedance.com>

On Fri, Dec 13, 2024 at 11:29:50PM +0000, Amery Hung wrote:
> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index 4214e76c9168..eb16218fdf52 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -563,6 +563,7 @@ const char *btf_name_by_offset(const struct btf *btf, u32 offset);
>  const char *btf_str_by_offset(const struct btf *btf, u32 offset);
>  struct btf *btf_parse_vmlinux(void);
>  struct btf *bpf_prog_get_target_btf(const struct bpf_prog *prog);
> +u32 get_ctx_arg_idx(struct btf *btf, const struct btf_type *func_proto, int off);
>  u32 *btf_kfunc_id_set_contains(const struct btf *btf, u32 kfunc_btf_id,
>  			       const struct bpf_prog *prog);
>  u32 *btf_kfunc_is_modify_return(const struct btf *btf, u32 kfunc_btf_id,
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index a05ccf9ee032..f733dbf24261 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -6375,8 +6375,8 @@ static bool is_int_ptr(struct btf *btf, const struct btf_type *t)
>  	return btf_type_is_int(t);
>  }
>  
> -static u32 get_ctx_arg_idx(struct btf *btf, const struct btf_type *func_proto,
> -			   int off)
> +u32 get_ctx_arg_idx(struct btf *btf, const struct btf_type *func_proto,
> +		    int off)
>  {
>  	const struct btf_param *args;
>  	const struct btf_type *t;

Maybe separate this piece out as a separate patch?


> diff --git a/net/sched/Kconfig b/net/sched/Kconfig
> index 8180d0c12fce..ccd0255da5a5 100644
> --- a/net/sched/Kconfig
> +++ b/net/sched/Kconfig
> @@ -403,6 +403,18 @@ config NET_SCH_ETS
>  
>  	  If unsure, say N.
>  
> +config NET_SCH_BPF
> +	bool "BPF-based Qdisc"
> +	depends on BPF_SYSCALL && BPF_JIT && DEBUG_INFO_BTF

I think new features should be default to n, unless you have reasons not
to do so.

> +	help
> +	  This option allows BPF-based queueing disiplines. With BPF struct_ops,
> +	  users can implement supported operators in Qdisc_ops using BPF programs.
> +	  The queue holding skb can be built with BPF maps or graphs.
> +
> +	  Say Y here if you want to use BPF-based Qdisc.
> +
> +	  If unsure, say N.
> +
>  menuconfig NET_SCH_DEFAULT
>  	bool "Allow override default queue discipline"
>  	help

[...]

> diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
> index 2eefa4783879..f074053c4232 100644
> --- a/net/sched/sch_api.c
> +++ b/net/sched/sch_api.c
> @@ -25,6 +25,7 @@
>  #include <linux/hrtimer.h>
>  #include <linux/slab.h>
>  #include <linux/hashtable.h>
> +#include <linux/bpf.h>
>  
>  #include <net/net_namespace.h>
>  #include <net/sock.h>
> @@ -358,7 +359,7 @@ static struct Qdisc_ops *qdisc_lookup_ops(struct nlattr *kind)
>  		read_lock(&qdisc_mod_lock);
>  		for (q = qdisc_base; q; q = q->next) {
>  			if (nla_strcmp(kind, q->id) == 0) {
> -				if (!try_module_get(q->owner))
> +				if (!bpf_try_module_get(q, q->owner))
>  					q = NULL;
>  				break;
>  			}
> @@ -1287,7 +1288,7 @@ static struct Qdisc *qdisc_create(struct net_device *dev,
>  				/* We will try again qdisc_lookup_ops,
>  				 * so don't keep a reference.
>  				 */
> -				module_put(ops->owner);
> +				bpf_module_put(ops, ops->owner);
>  				err = -EAGAIN;
>  				goto err_out;
>  			}
> @@ -1398,7 +1399,7 @@ static struct Qdisc *qdisc_create(struct net_device *dev,
>  	netdev_put(dev, &sch->dev_tracker);
>  	qdisc_free(sch);
>  err_out2:
> -	module_put(ops->owner);
> +	bpf_module_put(ops, ops->owner);
>  err_out:
>  	*errp = err;
>  	return NULL;
> diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
> index 38ec18f73de4..1e770ec251a0 100644
> --- a/net/sched/sch_generic.c
> +++ b/net/sched/sch_generic.c
> @@ -24,6 +24,7 @@
>  #include <linux/if_vlan.h>
>  #include <linux/skb_array.h>
>  #include <linux/if_macvlan.h>
> +#include <linux/bpf.h>
>  #include <net/sch_generic.h>
>  #include <net/pkt_sched.h>
>  #include <net/dst.h>
> @@ -1083,7 +1084,7 @@ static void __qdisc_destroy(struct Qdisc *qdisc)
>  		ops->destroy(qdisc);
>  
>  	lockdep_unregister_key(&qdisc->root_lock_key);
> -	module_put(ops->owner);
> +	bpf_module_put(ops, ops->owner);
>  	netdev_put(dev, &qdisc->dev_tracker);
>  
>  	trace_qdisc_destroy(qdisc);

Maybe this piece should be separated out too? Ideally this patch should
only have bpf_qdisc.c and its Makefile and Kconfig changes.

Regards.

