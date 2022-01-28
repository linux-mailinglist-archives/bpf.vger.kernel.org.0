Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9FC49F67C
	for <lists+bpf@lfdr.de>; Fri, 28 Jan 2022 10:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347596AbiA1JiE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Jan 2022 04:38:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:27460 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238119AbiA1JiE (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 28 Jan 2022 04:38:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643362683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Bm7yntnZphNntlIzJBi7dLNf0/Xc6WFVcDglxuX1l/s=;
        b=aFTWP+WHhD7wEd7pzcmPON/wed9pvTsnpBLYhEZo0FyfuZE6lfS/QQkpKwBU6F+RmGh9vN
        6oPjdfEGRTz/zo/2+LdgoC2FHZo5tG0vUOlGcPtIJ2yHIUuJWctenctvSDFR+Umfa/ulWg
        YxZ2GjFPgS7HP130HQn0FAZ8oZgsPFA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-389-45dtBYi0OYqBKCIxuhHiIg-1; Fri, 28 Jan 2022 04:38:00 -0500
X-MC-Unique: 45dtBYi0OYqBKCIxuhHiIg-1
Received: by mail-ej1-f70.google.com with SMTP id o4-20020a170906768400b006a981625756so2665614ejm.0
        for <bpf@vger.kernel.org>; Fri, 28 Jan 2022 01:38:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Bm7yntnZphNntlIzJBi7dLNf0/Xc6WFVcDglxuX1l/s=;
        b=4Lgy7PcDELm14EGbxPRh2GAOkz1TL8Xy0rUre2N5aPO3hyg4SlH6RrOqg4mOcXG9s5
         vqa2cNqSUvzYrN6v7bMFqSuGAWRJjIkJhH2EUASGolHp9NnXjtSTTYX0aAk3VaAwhvcN
         llAv5BrZl2rjfUL0Fu4ksiij2XxhfGJDdMqx4S4gfMv35zVcMrYgunm431zF550YoUj8
         tKk7DkZfdW7YjBN5vu4LIl/p/bc0tkt4G6jtkroC+dUNVWULlndIRFc3K5+z0PKG7BgX
         NttDMmQI9nTExGKZqC+I6XvyUPZNKmjvDBD8XNN7r0D5jKiEmhwrsN0tHp/WhhhxzWaV
         nyZg==
X-Gm-Message-State: AOAM530ecgyBKYVK5pG85tiYxBuVt4FIsMqDLkVyQTLiNaHPEJlClIsP
        sgmCfMvxvJfLBXrNiOIpQhvShZPGFx1lYMy6V/i5d0EXUlHJnBC19F6eqMYwg1QLjN7ykX+pAfd
        7L3uuCV76PggP
X-Received: by 2002:a05:6402:1d56:: with SMTP id dz22mr7685162edb.82.1643362679808;
        Fri, 28 Jan 2022 01:37:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxKe5ZRNHAS83VQrBS/4wBXr4dcTtl5PfFvJSOQogMXJPMGg8ZrekzVaiQ6a5cLAX7JhbRYjQ==
X-Received: by 2002:a05:6402:1d56:: with SMTP id dz22mr7685135edb.82.1643362679610;
        Fri, 28 Jan 2022 01:37:59 -0800 (PST)
Received: from krava ([83.240.63.12])
        by smtp.gmail.com with ESMTPSA id v14sm9782631ejy.77.2022.01.28.01.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 01:37:58 -0800 (PST)
Date:   Fri, 28 Jan 2022 10:37:56 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH v5 1/9] ftrace: Add ftrace_set_filter_ips function
Message-ID: <YfO5dLsrdRlN7D62@krava>
References: <164311269435.1933078.6963769885544050138.stgit@devnote2>
 <164311270629.1933078.4596694198103138848.stgit@devnote2>
 <20220125110659.2cc8df29@gandalf.local.home>
 <YfApT8uAoCODPAGu@krava>
 <20220128110523.de0e36317a34d48b793a7f6b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128110523.de0e36317a34d48b793a7f6b@kernel.org>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 28, 2022 at 11:05:23AM +0900, Masami Hiramatsu wrote:

SNIP

> 
> So, I wrote a below change for the next version. Is that OK for you?
> 
> Thank you,
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index f305e18f699f..a28b1bdb234a 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -4985,8 +4985,13 @@ ftrace_match_addr(struct ftrace_hash *hash, unsigned long *ips,
>  
>  	for (i = 0; i < cnt; i++) {
>  		err = __ftrace_match_addr(hash, ips[i], remove);
> -		if (err)
> +		if (err) {
> +			/*
> +			 * This expects the @hash is a temporary hash and if this
> +			 * fails the caller must free the @hash.
> +			 */
>  			return err;
> +		}
>  	}
>  	return 0;
>  }
> @@ -5649,7 +5654,7 @@ int ftrace_set_filter_ip(struct ftrace_ops *ops, unsigned long ip,
>  EXPORT_SYMBOL_GPL(ftrace_set_filter_ip);
>  
>  /**
> - * ftrace_set_filter_ips - set a functions to filter on in ftrace by addresses
> + * ftrace_set_filter_ips - set functions to filter on in ftrace by addresses
>   * @ops - the ops to set the filter with
>   * @ips - the array of addresses to add to or remove from the filter.
>   * @cnt - the number of addresses in @ips

looks good, thanks

jirka

