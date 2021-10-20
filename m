Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9E68435105
	for <lists+bpf@lfdr.de>; Wed, 20 Oct 2021 19:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbhJTRPq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Oct 2021 13:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbhJTRPl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Oct 2021 13:15:41 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB9BFC06161C
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 10:13:25 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id t7so8656683pgl.9
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 10:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=R7FZNDGWYSj+gTynBtBtLFz7FKmihWutrq9t+5tRHyk=;
        b=CHwPViTh609SPU8ohKmyjRaX8V/esA6tz6CS6uDbj0YWKiwsy5QCKL8ak9oLTo3TWA
         1GzL48l5Ryo6YHe1GKAn3V5PNGEfM6GjeQpICZLQhHrq/iR8YiLt8JbcWM+gnAQigzSA
         dHlfDajRIGh91knKtjUjI59UFWGizQr4d1ahewrUFwvyNkRO5Wt8qHzexqh6EM9DZ4OJ
         79rE1nAxLxfgvhNJ0Onm13dRimXvPGXZnZ9zCttpXTDZcQuQIFxRDJe5b7azQYAtvJHB
         0b12rXLv1q45GbacGuMMtAladVUYi6ba12M8OG9dbOBS7dNDnQsLcvNHJ3ZYeiEyqMgP
         5F2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R7FZNDGWYSj+gTynBtBtLFz7FKmihWutrq9t+5tRHyk=;
        b=moTY55TJUxWy6KmvIpB4JkWkCSH5XuTL0Cw+12HFiimBEJfqwx8+MuBqCdbWqd8x9s
         tM9sIS/IlVWiPwpitpCgHsLeDeIlrlpjWTsccavX97xu/2lvUdt+cXq8qtb0lGmq+0/T
         sHU+0k8GKjrU+fPxPX+GaBzsZEJ3IhvoLCw6OiBbbAaukOmR9JYbdYZm9icWB6+sYB6D
         3z1zPCf8K8T+5QU92Ou7NSe5lwQYpHoZxyvIXmdk7YSZGXITps5H7+ZBRzd4+f+J69QP
         dn6buinqit62WR9+FotEZZxgg52pyv8XLvFmgVsE/Fy/HPnNCwXP6AMatRQxyhSthy8n
         di+Q==
X-Gm-Message-State: AOAM531xisenzUdIZC0zkytF5s3IGNBAxouamvbkxUCEZ3naPFDfknZF
        SX5Rnb2BApVmPHds8Q5uPlg=
X-Google-Smtp-Source: ABdhPJx9WdAUGDOPbBb6bAWmLjIUImkQldVWtdfU8PmXcZPTmdoq9OMz0N2ovXSg3ZW+rXrN5ff/YA==
X-Received: by 2002:aa7:9f05:0:b0:44c:619e:87da with SMTP id g5-20020aa79f05000000b0044c619e87damr246473pfr.42.1634750005070;
        Wed, 20 Oct 2021 10:13:25 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:b634])
        by smtp.gmail.com with ESMTPSA id h3sm3567886pfv.166.2021.10.20.10.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 10:13:23 -0700 (PDT)
Date:   Wed, 20 Oct 2021 10:13:21 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        bpf@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [RFC 6/9] bpf: split map modification structs
Message-ID: <20211020171321.4souubqtm3m4xjxr@ast-mbp.dhcp.thefacebook.com>
References: <20211014143436.54470-1-lmb@cloudflare.com>
 <20211014143436.54470-8-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014143436.54470-8-lmb@cloudflare.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 14, 2021 at 03:34:31PM +0100, Lorenz Bauer wrote:
> ---
>  include/uapi/linux/bpf.h | 51 +++++++++++++++++++++++------
>  kernel/bpf/syscall.c     | 70 ++++++++++++++++------------------------
>  2 files changed, 70 insertions(+), 51 deletions(-)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index f1c163778d7a..d3acd12d98c1 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1294,18 +1294,41 @@ struct bpf_map_create_attr {
>  						 */
>  };
>  
> +struct bpf_map_lookup_elem_attr {
> +	__u32 map_fd;
> +	__bpf_md_ptr(const void *, key);
> +	__bpf_md_ptr(void *, value);
> +	__u64 flags;
> +};
> +
> +struct bpf_map_update_elem_attr {
> +	__u32 map_fd;
> +	__bpf_md_ptr(const void *, key);
> +	__bpf_md_ptr(void *, value);
> +	__u64 flags;
> +};
> +
> +struct bpf_map_delete_elem_attr {
> +	__u32 map_fd;
> +	__bpf_md_ptr(const void *, key);
> +};
> +
> +struct bpf_map_get_next_key_attr {
> +	__u32 map_fd;
> +	__bpf_md_ptr(const void *, key);
> +	__bpf_md_ptr(void *, next_key);
> +};
> +
>  union bpf_attr {
>  	struct bpf_map_create_attr map_create;
>  
> -	struct { /* anonymous struct used by BPF_MAP_*_ELEM commands */
> -		__u32		map_fd;
> -		__aligned_u64	key;
> -		union {
> -			__aligned_u64 value;
> -			__aligned_u64 next_key;
> -		};
> -		__u64		flags;
> -	};
> +	struct bpf_map_lookup_elem_attr map_lookup_elem;
> +
> +	struct bpf_map_update_elem_attr map_update_elem;
> +
> +	struct bpf_map_delete_elem_attr map_delete_elem;
> +
> +	struct bpf_map_get_next_key_attr map_get_next_key;

I think such additions to bpf_attr are good. They do make it
the interface more obvious.
But please don't move or delete the existing anon struct.
Adding 'deprecated' comment won't make it deprecated.
It will be used regardless.
If we ever extend 'map_lookup' command we might even add
fields to both. tbd.
