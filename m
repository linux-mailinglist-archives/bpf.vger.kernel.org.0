Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB954C58FD
	for <lists+bpf@lfdr.de>; Sun, 27 Feb 2022 03:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbiB0Cpg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 26 Feb 2022 21:45:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiB0Cpg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 26 Feb 2022 21:45:36 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B361C885A
        for <bpf@vger.kernel.org>; Sat, 26 Feb 2022 18:45:01 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id cp23-20020a17090afb9700b001bbfe0fbe94so8301914pjb.3
        for <bpf@vger.kernel.org>; Sat, 26 Feb 2022 18:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=w8TCfKy8ImOuaWfyMUjdPIyIIUebuwNJCwVjU5dy5qs=;
        b=EeTNYC39QF06psWqna4paPelQwMD++57eiK9hRjbNQwxCWNltz0JC5VhhqdCZAmlG9
         V5M7krMo+gmOt02k2uUJChBUj7NkCW7p8SlcCHTy2d9z/SGeE6SqsiOmwMe1rpCumgVQ
         9fMwc18cyEMYNIKL41b87l8SOMtAiTt6nQM4sZ+8AOmD1Uailft0tF4+ckgs1lskwsj8
         CPV2ZWhSvFbyhihNNUJUKvixt6YZYnc4kT9ME2xMf1XDJmLmwbEwLj1aTP29jT+XKDZ4
         H2SI2hU0TTxPjsJ5Q/1/ARMH2JFsXTZ9R4Tk/1udwqWXvvubt/w6lMhLS8jqfX9x2Zyh
         kyHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w8TCfKy8ImOuaWfyMUjdPIyIIUebuwNJCwVjU5dy5qs=;
        b=GxPz6CNYuc5w9FrDkgiQZp3uZxHSnoHS8IvOyAKlfaQkd0M8/RQJ5ZoVYaPk5keihH
         Lta+1p7/emSifeiwjCGixcOEd3pLvEn5H6q5GiBaX4wWYz0vii2aXudcFQxl1UvaXzbn
         q8/chr8WqH3PH++RFkG1risOHDFKK3LK3r6ICLMGyF2KEGK6EbbxhltrJla2Z2erxJR8
         jsKifbVEZluSboPeYTdZtTudVg46sMbIAK+PiIss3qCOScEgnhrrQxov+bz5awVBbTUA
         mi1fFXoHIw21IlsbR1/Umc+329fMCYc7aPvKEFTaCwbh9+PX2yoTldGPJwV07+5BZgEK
         Folg==
X-Gm-Message-State: AOAM532nN2Hyjyx9kn1NBerfYsYcAP71JIpcUJWGLCeni+och3RlaG1u
        BVFHr93wgDjFKdQEq2ktpfQ=
X-Google-Smtp-Source: ABdhPJyOfKM8P6LZUGRDNsFRVkcXrkjDfW3FclV3YF36F8grOXqVGNMtzxS/ffcDV9j6l2k2LgpdVQ==
X-Received: by 2002:a17:902:d4cc:b0:151:3857:817b with SMTP id o12-20020a170902d4cc00b001513857817bmr8765889plg.139.1645929900365;
        Sat, 26 Feb 2022 18:45:00 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:6566])
        by smtp.gmail.com with ESMTPSA id pg14-20020a17090b1e0e00b001bbadc2205dsm6760282pjb.20.2022.02.26.18.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Feb 2022 18:44:59 -0800 (PST)
Date:   Sat, 26 Feb 2022 18:44:57 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Jakub Sitnicki <jakub@cloudflare.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH RFC bpf-next 2/3] bpf: Fix bpf_sk_lookup.remote_port on
 big-endian
Message-ID: <20220227024457.rv5zei6qk4d6wy6d@ast-mbp.dhcp.thefacebook.com>
References: <20220222182559.2865596-1-iii@linux.ibm.com>
 <20220222182559.2865596-3-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222182559.2865596-3-iii@linux.ibm.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FROM_FMBLA_NEWDOM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 22, 2022 at 07:25:58PM +0100, Ilya Leoshkevich wrote:
> On big-endian, the port is available in the second __u16, not the first
> one. Therefore, provide a big-endian-specific definition that reflects
> that. Also, define remote_port_compat in order to have nicer
> architecture-agnostic code in the verifier and in tests.
> 
> Fixes: 9a69e2b385f4 ("bpf: Make remote_port field in struct bpf_sk_lookup 16-bit wide")
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  include/uapi/linux/bpf.h       | 17 +++++++++++++++--
>  net/core/filter.c              |  5 ++---
>  tools/include/uapi/linux/bpf.h | 17 +++++++++++++++--
>  3 files changed, 32 insertions(+), 7 deletions(-)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index afe3d0d7f5f2..7b0e5efa58e0 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -10,6 +10,7 @@
>  
>  #include <linux/types.h>
>  #include <linux/bpf_common.h>
> +#include <asm/byteorder.h>
>  
>  /* Extended instruction set based on top of classic BPF */
>  
> @@ -6453,8 +6454,20 @@ struct bpf_sk_lookup {
>  	__u32 protocol;		/* IP protocol (IPPROTO_TCP, IPPROTO_UDP) */
>  	__u32 remote_ip4;	/* Network byte order */
>  	__u32 remote_ip6[4];	/* Network byte order */
> -	__be16 remote_port;	/* Network byte order */
> -	__u16 :16;		/* Zero padding */
> +	union {
> +		struct {
> +#if defined(__BYTE_ORDER) ? __BYTE_ORDER == __LITTLE_ENDIAN : defined(__LITTLE_ENDIAN)
> +			__be16 remote_port;	/* Network byte order */
> +			__u16 :16;		/* Zero padding */
> +#elif defined(__BYTE_ORDER) ? __BYTE_ORDER == __BIG_ENDIAN : defined(__BIG_ENDIAN)
> +			__u16 :16;		/* Zero padding */
> +			__be16 remote_port;	/* Network byte order */
> +#else
> +#error unspecified endianness
> +#endif
> +		};
> +		__u32 remote_port_compat;

Sorry this hack is not an option.
Don't have any suggestions at this point. Pls come up with something else.
