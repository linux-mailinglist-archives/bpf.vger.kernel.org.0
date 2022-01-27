Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6D6D49E632
	for <lists+bpf@lfdr.de>; Thu, 27 Jan 2022 16:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238798AbiA0Phr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Jan 2022 10:37:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:29217 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229758AbiA0Phr (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 27 Jan 2022 10:37:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643297866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CnT5lZnpZRyC8Srri1l1kelJ+LyfIJz6wgUpbgpJ5Js=;
        b=gI2T463HxF0eccyecgpk2TT8UyscsqSI8tZ6+gQ8iAOU9ZthwP2/Z55ArD9wQkK+zFL7pH
        OxC31TO/ycl8s6pVwOOlFapD1U3CXQlo8EmviS7E+nTsxGBu1gEhZgI8sno7umvuQjcw3d
        2W95iXyH0kgALRjWtlKsAXWSV7/ifwo=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-5-_9fuFfk5OAyqafgLJRb__g-1; Thu, 27 Jan 2022 10:37:45 -0500
X-MC-Unique: _9fuFfk5OAyqafgLJRb__g-1
Received: by mail-ed1-f70.google.com with SMTP id f21-20020a50d555000000b00407a8d03b5fso1601397edj.9
        for <bpf@vger.kernel.org>; Thu, 27 Jan 2022 07:37:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=CnT5lZnpZRyC8Srri1l1kelJ+LyfIJz6wgUpbgpJ5Js=;
        b=kDQh0ybCnAnEuZToqAxIUPtJVvM4xqE3DOd410fRXV/RYlPILQkBKhmjegrW3r409D
         quVtpfr3mAHgbkS75LkAafzV0Cqgw0zNBeaLMSYgZVk187mNdMtYWh+aAc7Cijocmvja
         M09DnLghPaUzdUxXogq57lU6CkJ+B2daOgYJoQ5Syzj9mlEg0dBBAf+js5I6ndWM8wqk
         Vj945iH7O8uIEmDVWMyN/Ur5REJojoicDt6MYaa6ByAt/6vVEnmwx03KXcTNU/TW48m1
         H5xnETQwsvsI1pNuI7MjF5XJlcBzPE43ktRwqNcVXSv4yxhbV39KsJe7n7ECJp6ZeQLV
         g6UQ==
X-Gm-Message-State: AOAM532JdrxFjhkIFcb2qOItqoF4F/9zc9nqoEkvc88IpY9xMm6hNWbu
        l0ur6ILxG6uaAVWMiMNdYLHQO9DjmPNSs/QfVYiI0y8/iEtOVCaAuRLhZes52nTHOIdHDFJ43mV
        sGgNhXjc4XH18
X-Received: by 2002:aa7:dcd5:: with SMTP id w21mr4230259edu.97.1643297862993;
        Thu, 27 Jan 2022 07:37:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy+tXW4DIAeyLsfi0VqyyWOdrqByyXCrzCo8NJBrnurFZ3FLAlOU1eY8ANLWMp34UavbRccFQ==
X-Received: by 2002:aa7:dcd5:: with SMTP id w21mr4230227edu.97.1643297862486;
        Thu, 27 Jan 2022 07:37:42 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id s7sm8818119ejo.212.2022.01.27.07.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 07:37:41 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 50E6918044B; Thu, 27 Jan 2022 16:37:41 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, dsahern@kernel.org,
        brouer@redhat.com, lorenzo.bianconi@redhat.com, andrii@kernel.org,
        john.fastabend@gmail.com
Subject: Re: [PATCH bpf-next] libbpf: deprecate xdp_cpumap and xdp_devmap
 sec definitions
In-Reply-To: <d7f8f9e3370d33be0a3385c7604d8925e10c91d1.1643285321.git.lorenzo@kernel.org>
References: <d7f8f9e3370d33be0a3385c7604d8925e10c91d1.1643285321.git.lorenzo@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 27 Jan 2022 16:37:41 +0100
Message-ID: <87pmod196i.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> writes:

> Deprecate xdp_cpumap xdp_devmap sec definitions.
> Introduce xdp/devmap and xdp/cpumap definitions according to the standard
> for SEC("") in libbpf:
> - prog_type.prog_flags/attach_place
> Update cpumap/devmap samples and kselftests
>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  samples/bpf/xdp_redirect_cpu.bpf.c                   |  8 ++++----
>  samples/bpf/xdp_redirect_map.bpf.c                   |  2 +-
>  samples/bpf/xdp_redirect_map_multi.bpf.c             |  2 +-
>  tools/lib/bpf/libbpf.c                               | 12 ++++++++++--
>  .../bpf/progs/test_xdp_with_cpumap_frags_helpers.c   |  2 +-
>  .../bpf/progs/test_xdp_with_cpumap_helpers.c         |  2 +-
>  .../bpf/progs/test_xdp_with_devmap_frags_helpers.c   |  2 +-
>  .../bpf/progs/test_xdp_with_devmap_helpers.c         |  2 +-
>  .../selftests/bpf/progs/xdp_redirect_multi_kern.c    |  2 +-
>  9 files changed, 21 insertions(+), 13 deletions(-)
>
> diff --git a/samples/bpf/xdp_redirect_cpu.bpf.c b/samples/bpf/xdp_redirect_cpu.bpf.c
> index 25e3a405375f..87c54bfdbb70 100644
> --- a/samples/bpf/xdp_redirect_cpu.bpf.c
> +++ b/samples/bpf/xdp_redirect_cpu.bpf.c
> @@ -491,7 +491,7 @@ int  xdp_prognum5_lb_hash_ip_pairs(struct xdp_md *ctx)
>  	return bpf_redirect_map(&cpu_map, cpu_dest, 0);
>  }
>  
> -SEC("xdp_cpumap/redirect")
> +SEC("xdp/cpumap")
>  int xdp_redirect_cpu_devmap(struct xdp_md *ctx)
>  {
>  	void *data_end = (void *)(long)ctx->data_end;
> @@ -507,19 +507,19 @@ int xdp_redirect_cpu_devmap(struct xdp_md *ctx)
>  	return bpf_redirect_map(&tx_port, 0, 0);
>  }
>  
> -SEC("xdp_cpumap/pass")
> +SEC("xdp/cpumap")
>  int xdp_redirect_cpu_pass(struct xdp_md *ctx)
>  {
>  	return XDP_PASS;
>  }
>  
> -SEC("xdp_cpumap/drop")
> +SEC("xdp/cpumap")
>  int xdp_redirect_cpu_drop(struct xdp_md *ctx)
>  {
>  	return XDP_DROP;
>  }
>  
> -SEC("xdp_devmap/egress")
> +SEC("xdp/devmap")
>  int xdp_redirect_egress_prog(struct xdp_md *ctx)
>  {
>  	void *data_end = (void *)(long)ctx->data_end;
> diff --git a/samples/bpf/xdp_redirect_map.bpf.c b/samples/bpf/xdp_redirect_map.bpf.c
> index 59efd656e1b2..415bac1758e3 100644
> --- a/samples/bpf/xdp_redirect_map.bpf.c
> +++ b/samples/bpf/xdp_redirect_map.bpf.c
> @@ -68,7 +68,7 @@ int xdp_redirect_map_native(struct xdp_md *ctx)
>  	return xdp_redirect_map(ctx, &tx_port_native);
>  }
>  
> -SEC("xdp_devmap/egress")
> +SEC("xdp/devmap")
>  int xdp_redirect_map_egress(struct xdp_md *ctx)
>  {
>  	void *data_end = (void *)(long)ctx->data_end;
> diff --git a/samples/bpf/xdp_redirect_map_multi.bpf.c b/samples/bpf/xdp_redirect_map_multi.bpf.c
> index bb0a5a3bfcf0..8b2fd4ec2c76 100644
> --- a/samples/bpf/xdp_redirect_map_multi.bpf.c
> +++ b/samples/bpf/xdp_redirect_map_multi.bpf.c
> @@ -53,7 +53,7 @@ int xdp_redirect_map_native(struct xdp_md *ctx)
>  	return xdp_redirect_map(ctx, &forward_map_native);
>  }
>  
> -SEC("xdp_devmap/egress")
> +SEC("xdp/devmap")
>  int xdp_devmap_prog(struct xdp_md *ctx)
>  {
>  	void *data_end = (void *)(long)ctx->data_end;
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 4ce94f4ed34a..1d97bc346be6 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -237,6 +237,8 @@ enum sec_def_flags {
>  	SEC_SLOPPY_PFX = 16,
>  	/* BPF program support non-linear XDP buffer */
>  	SEC_XDP_FRAGS = 32,
> +	/* deprecated sec definitions not supposed to be used */
> +	SEC_DEPRECATED = 64,
>  };
>  
>  struct bpf_sec_def {
> @@ -6575,6 +6577,10 @@ static int libbpf_preload_prog(struct bpf_program *prog,
>  	if (prog->type == BPF_PROG_TYPE_XDP && (def & SEC_XDP_FRAGS))
>  		opts->prog_flags |= BPF_F_XDP_HAS_FRAGS;
>  
> +	if (def & SEC_DEPRECATED)
> +		pr_warn("sec '%s' is deprecated, please use new version instead\n",
> +			prog->sec_name);
> +

How is the user supposed to figure out what "the new version" is?

-Toke

