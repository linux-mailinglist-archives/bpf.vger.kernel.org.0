Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8C6144F056
	for <lists+bpf@lfdr.de>; Sat, 13 Nov 2021 01:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbhKMBAD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Nov 2021 20:00:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbhKMBAB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Nov 2021 20:00:01 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74164C061766
        for <bpf@vger.kernel.org>; Fri, 12 Nov 2021 16:57:10 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id y5so9843733pfb.4
        for <bpf@vger.kernel.org>; Fri, 12 Nov 2021 16:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fT+um/li6lk7bI9Jehjg/mhrU5NcXEu0kEz1+5/pbz0=;
        b=Pz3LoqCdWcZfHnTR/TDhBF/UB39e2fLPjYztNDA9CX4+8bMbsWymSmpB7Cuu2tR9lK
         p3XOXFHcqkp/bRZAP2oyFzMesb04xJ5CyeYt8b1+lEY8chxO2qt5+pZ7Jzg28H3YKqMF
         j+5y46B14BAK4GR2//OvuiOWhXSerAvsHj3LQf5y8eWAqTJuLicrqhmjh3S2VLRzZv48
         2VFEENMvTvCxvlsBRYT99OuJQFsIvCY7ZNcReb9GboPgsjpvAX6hGamdiQsglmyg9VKN
         Z+3OclgaDog1jGKsTFLV7b0ZybpzaG1Wk5/+KkeRhNz04Xsx+bN6i+6xWdVbAkyo4w9z
         2v2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fT+um/li6lk7bI9Jehjg/mhrU5NcXEu0kEz1+5/pbz0=;
        b=O0BNQ4RqBagaM6MP49mI6ZD/oVewakQz9/J4Ek05J9B8LIZMGH+9BxwXtQByGBD6nx
         kA8DeJuHaCOCUn4VTIpDYieLSg8KMRacHSA64x2CHAsCPOtrHmlN/T1zYeBjPuelctv5
         w362+F52ykeVNonlJRaDn2q5m8TUnsuoXFI/uIp+s01jiKQEEUuVv9KTagJ5a6l40KMd
         qHDbpxjtu5ZRAO6EWhMykpOgw22tLRvQZm2CYs5xgp6rdEEe+56zcPD4Isr9zQN3okzH
         ImJkqBNR+s9d/gqrCVJBAQMzjrfZA8dq5hUEfT5nIrySDMKOZwHqVc/h/+bJ0cXMl3wP
         2P3g==
X-Gm-Message-State: AOAM533U+UcqQox+S3TdGG9lIHnzC6qvFyd712nIiULA8c3zvy60idvA
        n4mTvKLJw4swbIDDy/9fRQ0VIKKYNVM=
X-Google-Smtp-Source: ABdhPJwF01VKpXhEjXyvrxJXfIpR5YjBnNrPuXzIjPkXEqDKEkrHqIH/oiR//RbfJqdOvGx2onySmQ==
X-Received: by 2002:a05:6a00:2443:b0:44e:ec:f388 with SMTP id d3-20020a056a00244300b0044e00ecf388mr17380467pfj.7.1636765030006;
        Fri, 12 Nov 2021 16:57:10 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:8382])
        by smtp.gmail.com with ESMTPSA id b18sm8392224pfl.24.2021.11.12.16.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 16:57:09 -0800 (PST)
Date:   Fri, 12 Nov 2021 16:57:07 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH bpf v2] libbpf: Perform map fd cleanup for gen_loader in
 case of error
Message-ID: <20211113005707.7kcqlvywfzk5jfdx@ast-mbp.dhcp.thefacebook.com>
References: <20211112232022.899074-1-memxor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211112232022.899074-1-memxor@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Nov 13, 2021 at 04:50:22AM +0530, Kumar Kartikeya Dwivedi wrote:
> 
> +	/* amount of stack actually used, only used to calculate iterations, not stack offset */
> +	nr_progs_sz = offsetof(struct loader_stack, prog_fd[nr_progs + 1]);

I think '+ 1' would be one too many.
When nr_progs == 1 the offsetof(struct loader_stack, prog_fd[1])
would cover btf_fd, inner_map_fd, and prog_fd[0].

>  	/* jump over cleanup code */
>  	emit(gen, BPF_JMP_IMM(BPF_JA, 0, 0,
> -			      /* size of cleanup code below */
> -			      (stack_sz / 4) * 3 + 2));
> +			      /* size of cleanup code below (including map fd cleanup) */
> +			      (nr_progs_sz / 4) * 3 + 2 +
> +			      /* 6 insns for emit_sys_close_blob,
> +			       * 6 insns for debug_regs in emit_sys_close_blob
> +			       */
> +			      (nr_maps * (6 + (gen->log_level ? 6 : 0)))));

I've removed the extra () in the above.

And pushed to bpf tree.
Please confirm that +1 removal was correct.

Thanks for the quick debugging and fix. Much appreciate it.
