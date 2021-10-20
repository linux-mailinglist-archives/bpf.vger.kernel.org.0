Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4E1435111
	for <lists+bpf@lfdr.de>; Wed, 20 Oct 2021 19:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbhJTRSA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Oct 2021 13:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbhJTRSA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Oct 2021 13:18:00 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C9FC06161C
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 10:15:45 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id e65so20695648pgc.5
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 10:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rLpAp/X6qtKMpM5IinZ23spMtez31o6DCCkuaUohJIA=;
        b=m9jUEZ36cHFQVKA4uCw/wc7EQEj/JAnUyEhxZNpRVsQCP/18tZYyufNBDj6WrURVxb
         D8WUMjVvy+L3KB/SGrrcgQrm5eGKGKd5VQXPeK7l353cDS/5sJmOlEFuRKWQk9DS92jK
         C6pWbg/ugymtfwvXOVFWMngXVR3/tALV5d/vI3nDug/ymFUrJKD4p7s5cSqyt+HcPLbO
         fB1j2jIURr1/YWjH1/HdacWgA6WRxUAEyqJegqjyWADCHBjUIyBbyeLDcZWCvbwpiDdg
         L7P53Ev8/sUjJCmWW4mOqUfO1s4lKKaiKPkUpS4lUFffWFomNzWWZDFOjYuacznLvGbE
         E0hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rLpAp/X6qtKMpM5IinZ23spMtez31o6DCCkuaUohJIA=;
        b=xrwGvMaHJN21vVBSbb4LvTPcAD/f9LX5TZgTwIZydRcRwGMhxJ8lYtwZms0hkl/FZH
         Nblsyq3EKKWLcvl0MehKioUEWOcGtANgde7tXpb72RtJz9OrY0pNeypiG7HnrKGqh6Yz
         6s/OjaFjkVW9jEgtmBxewuZiP32tKv9ssGw+YCwumzXLHJW5pn3hL7y5QGOiTTFOZdtg
         1tt6Jhw2xvir1Bw1aujHqanGVY79+Rw9MsGt7Q2ate2ohK8vbWcKNKomhxSyZAHM5L+t
         SPNTxV2XcmIO3ydMlqMOjo/TP2mEE6zIi1+DAcPmv8WOXjQjS8qEi02aaq6gjt/nSP5y
         +njA==
X-Gm-Message-State: AOAM532Ei/4/kSeIKwLUK9qDiCI7GQceyKeNbKw/dKbhUGkLl3ZlU1zV
        S62QnqpupTvuGzDHpoCyTLo=
X-Google-Smtp-Source: ABdhPJyf2L6r6MUDYYMPjPfo+85bLGxDpl6UKsIll65vMh6WyfExPDK0ra1UtNpkPzcBs2HID5FbbQ==
X-Received: by 2002:a65:62d5:: with SMTP id m21mr446155pgv.124.1634750144977;
        Wed, 20 Oct 2021 10:15:44 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:b634])
        by smtp.gmail.com with ESMTPSA id z24sm3248170pfr.141.2021.10.20.10.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 10:15:44 -0700 (PDT)
Date:   Wed, 20 Oct 2021 10:15:42 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        bpf@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [RFC 7/9] bpf: split get_id and fd_by_id in bpf_attr
Message-ID: <20211020171542.7vn3lsrqmq2h7q2v@ast-mbp.dhcp.thefacebook.com>
References: <20211014143436.54470-1-lmb@cloudflare.com>
 <20211014143436.54470-10-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014143436.54470-10-lmb@cloudflare.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 14, 2021 at 03:34:33PM +0100, Lorenz Bauer wrote:
> ---
>  include/uapi/linux/bpf.h | 60 ++++++++++++++++++++++++++++++++--------
>  kernel/bpf/syscall.c     | 18 ++++++------
>  2 files changed, 58 insertions(+), 20 deletions(-)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index d3acd12d98c1..13d126c201ce 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1422,17 +1422,43 @@ union bpf_attr {
>  		__u32		cpu;
>  	} test;
>  
> -	struct { /* anonymous struct used by BPF_*_GET_*_ID */
> -		union {
> -			__u32		start_id;
> -			__u32		prog_id;
> -			__u32		map_id;
> -			__u32		btf_id;
> -			__u32		link_id;
> -		};
> -		__u32		next_id;
> -		__u32		open_flags;
> -	};
> +	struct { /* used by BPF_PROG_GET_FD_BY_ID command */
> +		__u32 id;
> +	} prog_get_fd_by_id;
> +
> +	struct { /* used by BPF_MAP_GET_FD_BY_ID command */
> +		__u32 id;
> +		__u32 ingnored;
> +		__u32 open_flags;
> +	} map_get_fd_by_id;
> +
> +	struct { /* used by BPF_BTF_GET_FD_BY_ID command */
> +		__u32 id;
> +	} btf_get_fd_by_id;
> +
> +	struct { /* used by BPF_LINK_GET_FD_BY_ID command */
> +		__u32 id;
> +	} link_get_fd_by_id;
> +
> +	struct { /* used by BPF_PROG_GET_NEXT_ID command */
> +		__u32 start_id;
> +		__u32 next_id;
> +	} prog_get_next_id;
> +
> +	struct { /* used by BPF_MAP_GET_NEXT_ID command */
> +		__u32 start_id;
> +		__u32 next_id;
> +	} map_get_next_id;
> +
> +	struct { /* used by BPF_BTF_GET_NEXT_ID command */
> +		__u32 start_id;
> +		__u32 next_id;
> +	} btf_get_next_id;
> +
> +	struct { /* used by BPF_LINK_GET_NEXT_ID command */
> +		__u32 start_id;
> +		__u32 next_id;
> +	} link_get_next_id;

This one looks like churn though.
