Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3F222C7716
	for <lists+bpf@lfdr.de>; Sun, 29 Nov 2020 02:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgK2BHu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 28 Nov 2020 20:07:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgK2BHt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 28 Nov 2020 20:07:49 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C22C0613D2;
        Sat, 28 Nov 2020 17:07:09 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id s63so7387631pgc.8;
        Sat, 28 Nov 2020 17:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yhpJsuB2XchhEKb/EAYyLqgLN0ibLc1dc4vULmZ0Dnc=;
        b=GYh7mRnY5RiTPQOgim5X/KaU7jNy2fRb0+sKX6RtqFEAshyxe49p9/vcSx7mIElqFd
         HiIax09hHeB1VCTE2vbdJ+cVbhg7o2hnyXerWuN35xhD7hMO+p979kX/uflOqYkEaKOC
         r0YTLl/kh/KgvDuSrH7e3MTOq9vfH8mKyQVe5FJsGRUoKtbQ3c41Ocjc4WItbkN8mGnV
         9byIEYSRVtPFrOAPQvFBV+u6DrnYAXaOaluw1HivG4/2QAcT8dgUMuYbRjIbdCk6eBhn
         8zHMuCCoHwcKVjAaXdNTKDvape5ZIWHNelH+sB8ftedg9rUiGoZykh3DGA6QplRyNOIX
         gVCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yhpJsuB2XchhEKb/EAYyLqgLN0ibLc1dc4vULmZ0Dnc=;
        b=S9gY4baMK60PoFjwB5GnO698N9feRCITDMijPqbecrCFxnVxsu7yJ8+rQMnyvp3cGL
         YhFvkNkblbTMQFIC4lG8d3fav1m18YrgYa5m+NOa8fYn2CUcwtltGmjwPBx01Xz7ribC
         w2yr84qppZBk/t8J7PIXqurKAQUYX8HqahgBCpkGP3IHoFn/YpH1A5iTMYEL17ywws5p
         ao89/I8QvItbfPMI0J6gGFFvqw5insXgAii/SQPlZTp48WyuxJNJsFG5RWKS58EKVAJE
         grCOtweEKGdBiBBRx3IwpXXMU0bmDjQ4wYCPY+ij5D2e/CP6f9z2t9OH01LnCfoZsrQw
         ikfw==
X-Gm-Message-State: AOAM533IqClNsqkeu6XHwAez3Mh3XiIR3m9JgcAZI4bKlLrRcB32xhNs
        gjreL6mkQtFReXEopVukIFQ=
X-Google-Smtp-Source: ABdhPJxQkkMqMR2Ln+1hgeRSlgKBZBp/fhRNQrJPfG9XDrFVn5fHfsLQbMFY3WHyIwxteaUeU+cs5A==
X-Received: by 2002:a17:90a:aa0f:: with SMTP id k15mr18904581pjq.171.1606612029145;
        Sat, 28 Nov 2020 17:07:09 -0800 (PST)
Received: from ast-mbp ([2620:10d:c090:400::5:5925])
        by smtp.gmail.com with ESMTPSA id y1sm11366929pfe.80.2020.11.28.17.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2020 17:07:08 -0800 (PST)
Date:   Sat, 28 Nov 2020 17:07:05 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Florent Revest <revest@chromium.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kpsingh@chromium.org, revest@google.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/2] bpf: Add a bpf_kallsyms_lookup helper
Message-ID: <20201129010705.7djnqmztkjhqlrdt@ast-mbp>
References: <20201126165748.1748417-1-revest@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126165748.1748417-1-revest@google.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 26, 2020 at 05:57:47PM +0100, Florent Revest wrote:
> This helper exposes the kallsyms_lookup function to eBPF tracing
> programs. This can be used to retrieve the name of the symbol at an
> address. For example, when hooking into nf_register_net_hook, one can
> audit the name of the registered netfilter hook and potentially also
> the name of the module in which the symbol is located.
> 
> Signed-off-by: Florent Revest <revest@google.com>
> ---
>  include/uapi/linux/bpf.h       | 16 +++++++++++++
>  kernel/trace/bpf_trace.c       | 41 ++++++++++++++++++++++++++++++++++
>  tools/include/uapi/linux/bpf.h | 16 +++++++++++++
>  3 files changed, 73 insertions(+)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index c3458ec1f30a..670998635eac 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -3817,6 +3817,21 @@ union bpf_attr {
>   *		The **hash_algo** is returned on success,
>   *		**-EOPNOTSUP** if IMA is disabled or **-EINVAL** if
>   *		invalid arguments are passed.
> + *
> + * long bpf_kallsyms_lookup(u64 address, char *symbol, u32 symbol_size, char *module, u32 module_size)
> + *	Description
> + *		Uses kallsyms to write the name of the symbol at *address*
> + *		into *symbol* of size *symbol_sz*. This is guaranteed to be
> + *		zero terminated.
> + *		If the symbol is in a module, up to *module_size* bytes of
> + *		the module name is written in *module*. This is also
> + *		guaranteed to be zero-terminated. Note: a module name
> + *		is always shorter than 64 bytes.
> + *	Return
> + *		On success, the strictly positive length of the full symbol
> + *		name, If this is greater than *symbol_size*, the written
> + *		symbol is truncated.
> + *		On error, a negative value.

Looks like debug-only helper.
I cannot think of a way to use in production code.
What program suppose to do with that string?
Do string compare? BPF side doesn't have a good way to do string manipulations.
If you really need to print a symbolic name for a given address
I'd rather extend bpf_trace_printk() to support %pS
