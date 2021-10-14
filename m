Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7C6C42DBF7
	for <lists+bpf@lfdr.de>; Thu, 14 Oct 2021 16:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbhJNOpt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Oct 2021 10:45:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:36458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230198AbhJNOps (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Oct 2021 10:45:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 979C3610D1;
        Thu, 14 Oct 2021 14:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634222624;
        bh=UYtyoi8gKrsP7Y0RzouK8Alzo+3+8P9huq03sHBtVHI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K5PRjO90bIxkniL+X5mnog0uvhjB8Q7bCvVW9MeZKRCHaifqxxy/LN/cZW5QMhlBd
         ZU4zkP/NfCqU6FSXz78/LIkNbF1rc7YVVrynO3NL/7NUjjlzNZoySRNClOwppFp0EP
         t5q1bbhizyvMCYr/swQmC86nKg3nPhNsFHXQA6bI=
Date:   Thu, 14 Oct 2021 16:43:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        bpf@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [RFC 2/9] bpf: various constants
Message-ID: <YWhCHbCw17fxQtIN@kroah.com>
References: <20211014143436.54470-1-lmb@cloudflare.com>
 <20211014143436.54470-3-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014143436.54470-3-lmb@cloudflare.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 14, 2021 at 03:34:26PM +0100, Lorenz Bauer wrote:
> ---
>  include/uapi/linux/bpf.h | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)

I know I don't take matches without any changelog text, maybe other
maintainers are more lax?

Also, no signed-off-by:?

:(



> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 78b532d28761..211b9d902006 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1248,7 +1248,10 @@ enum bpf_stack_build_id_status {
>  	BPF_STACK_BUILD_ID_IP = 2,
>  };
>  
> -#define BPF_BUILD_ID_SIZE 20
> +enum {
> +	BPF_BUILD_ID_SIZE = 20,
> +};
> +
>  struct bpf_stack_build_id {
>  	__s32		status;
>  	unsigned char	build_id[BPF_BUILD_ID_SIZE];
> @@ -1258,7 +1261,9 @@ struct bpf_stack_build_id {
>  	};
>  };
>  
> -#define BPF_OBJ_NAME_LEN 16U
> +enum {
> +	BPF_OBJ_NAME_LEN = 16U,
> +};
>  
>  union bpf_attr {
>  	struct { /* anonymous struct used by BPF_MAP_CREATE command */
> @@ -5464,7 +5469,9 @@ struct bpf_xdp_sock {
>  	__u32 queue_id;
>  };
>  
> -#define XDP_PACKET_HEADROOM 256
> +enum {
> +	XDP_PACKET_HEADROOM = 256,
> +};
>  
>  /* User return codes for XDP prog type.
>   * A valid XDP program must return one of these defined values. All other
> @@ -5582,7 +5589,9 @@ struct sk_reuseport_md {
>  	__bpf_md_ptr(struct bpf_sock *, migrating_sk);
>  };
>  
> -#define BPF_TAG_SIZE	8
> +enum {
> +	BPF_TAG_SIZE = 8,
> +};
>  
>  struct bpf_prog_info {
>  	__u32 type;
> -- 
> 2.30.2
> 
