Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E44D44A55F
	for <lists+bpf@lfdr.de>; Tue,  9 Nov 2021 04:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238391AbhKIDl2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Nov 2021 22:41:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236843AbhKIDl1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Nov 2021 22:41:27 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23E7C061570
        for <bpf@vger.kernel.org>; Mon,  8 Nov 2021 19:38:42 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id e65so17183266pgc.5
        for <bpf@vger.kernel.org>; Mon, 08 Nov 2021 19:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SMFg9QPC5pw46fWPrYbSwJaUwcvgw73TWYPsfswb4qk=;
        b=HX2AqtDeKd8yo0LFjO8EubQ9HGu0UAH2lsb/wfIVkzykmKuTTCDSsdX0apfJeGLmZU
         +qd9IriY745jlty7TPeW2Y810d0/s83kJdJBZ936gGh+wuVnwNBOy3SRuLRivcKkD9qu
         UYwwMHDZvARfAgyizv3n7B29mY/0LEuNjuIqR4L2cSRllTzqkxtL5vE9gQ00QQKOprzI
         e2CYkPkjxbBt6dMV6yKTN39RsddhpMoD7QDES9cnTV8UdrAbXJogHJYLDV8jyMpsnRQJ
         TUHY6G/dvG1j4RUeF6rToS/5d+wpa5E0g3JZlKVPDn13i8T1pRrbXRerN4IOnTq3Jo96
         TYgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SMFg9QPC5pw46fWPrYbSwJaUwcvgw73TWYPsfswb4qk=;
        b=HdUJe+yqbRI/HfnHX83Xbr16awllykp7NNGp90QQYr7FQBBuBbQZJ9cOIgg474qjrx
         0dRhzOxRo75OAE/VPwxbq6xzfua7c0NDvKBQ0lfxYZnwj70kMP2bCqlDa5jVlo+v1NaG
         acgE0CyiON6ITyT6DvoMnWKESMpirn6Aml6o7VY904KH21CXa0WU4OoqhEU19exSJMgf
         EtvUGvoWB5zrYhYNioX25HzLJPQ/apb36dAurb+pI2kNrF24agOBIrL4c1VsWHgblWY8
         TPgd0XH/1A3CS0xmgK7+3FyyRq9zMbVSEu+uJQoAXO4Oe0/azBwI8+OYB7f0kpSaiQmc
         y/BA==
X-Gm-Message-State: AOAM531JbhrGMM31UI84D3VpuGb8oHjpNCQZF2a+8N7mAN8GKcGwiqTd
        Lz53m8qDO3eKjWtVZT5sk7Y=
X-Google-Smtp-Source: ABdhPJxb6el9P8apmE5vM0RoiOgf2s7JMzVw8YFE6CVF6JhWI55m6MzrmtubD6ADWNZn0UUVUgR1Hw==
X-Received: by 2002:a63:1441:: with SMTP id 1mr3581813pgu.66.1636429122133;
        Mon, 08 Nov 2021 19:38:42 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:e262])
        by smtp.gmail.com with ESMTPSA id 130sm17223551pfu.170.2021.11.08.19.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 19:38:41 -0800 (PST)
Date:   Mon, 8 Nov 2021 19:38:39 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
Subject: Re: [PATCH bpf-next 06/11] libbpf: ensure btf_dump__new() and
 btf_dump_opts are future-proof
Message-ID: <20211109033839.yf3v7xcbqco6fddp@ast-mbp.dhcp.thefacebook.com>
References: <20211108061316.203217-1-andrii@kernel.org>
 <20211108061316.203217-7-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211108061316.203217-7-andrii@kernel.org>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Nov 07, 2021 at 10:13:11PM -0800, Andrii Nakryiko wrote:
> +#define btf_dump__new(a1, a2, a3, a4) __builtin_choose_expr(		      \
> +	__builtin_types_compatible_p(typeof(a4), btf_dump_printf_fn_t) +      \
> +	__builtin_types_compatible_p(typeof(a4),			      \
> +				     void(void *, const char *, va_list)),    \
> +	btf_dump__new_deprecated((void *)a1, (void *)a2, (void *)a3, (void *)a4),\
> +	btf_dump__new((void *)a1, (void *)a2, (void *)a3, (void *)a4))

why '+' in the above? The return type of __builtin_types_compatible_p() is bool.
What is bool + bool ?
It suppose to be logical 'OR', right?

Maybe checking for ops type would be more robust ?
Like:
#define btf_dump__new(a1, a2, a3, a4) __builtin_choose_expr(		      \
	__builtin_types_compatible_p(typeof(a4), const struct btf_dump_opts*), \
	btf_dump__new((void *)a1, (void *)a2, (void *)a3, (void *)a4),        \
	btf_dump__new_deprecated((void *)a1, (void *)a2, (void *)a3, (void *)a4))
