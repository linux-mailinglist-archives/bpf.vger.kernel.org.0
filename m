Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFDA159D68C
	for <lists+bpf@lfdr.de>; Tue, 23 Aug 2022 11:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348579AbiHWJMb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Aug 2022 05:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348348AbiHWJJ0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Aug 2022 05:09:26 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D330F6CD2E
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 01:30:52 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id t11-20020a17090a510b00b001fac77e9d1fso13801074pjh.5
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 01:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc;
        bh=+ivO5zPEGana2OjGBsQcG8xErgpyRKttjdzpEcxCKxw=;
        b=o5NCmtjB7g0naTLOIraOdwyNWAa5qK7VD8hNtLmKl/YwNbAvmk7S5+gI3n5O+66jrc
         X/u8Tn855msJz+qGFKrfjj4C8vhjOnsx6bHyNk3Ta78hoqbXgsm6my/G0t3dgGMcGRFW
         xcAuwfusCfkw8072BqPv+5xJZQbzVeYWMYkvKgiyXXemUSAr5gYf5uwop3wkuFq95frZ
         jsC1Op292HUZjAbQazwVvbPKjvA92PEy+i34PJzJQK4KufuE+5UwZBAePf7dwL7oLt1W
         V42qDXw2oyJrlTTE8pCoqGxftME09sCYe4Vn4qyd0Vx10NCRnEefc+bb0015buo3IZsU
         Ga0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc;
        bh=+ivO5zPEGana2OjGBsQcG8xErgpyRKttjdzpEcxCKxw=;
        b=jzVcoV0xejJUnPp2L5P2SBSaDx5nHPBWtRDBeEMsqJPDVjxqBszYIKVwHu1UJEMfxE
         EY+d26cWLM+wQF6/L/cnTiSRQgdLn2u7mWcP0m5lPbtwRcBHkwaoX9hgz4383WCcXzyy
         Pkh+JFZwdcpOfeJzZ27MPIfSgZYxkDBSvt0Eyu9UvN9dKqgIorMmxATHmWvq4lsYnEJA
         AgOKOa881EUm1QD2Ij1xdjP0Nu4xSUQjvUCBSsclWJNzNzpnHAicEJc5y3ehzcaJlWMx
         hqXKLGeGKsSzNLwMU2Xux+mQ8eY3BP+jURuarvD+C/rXNzhgb1JRT51PTqQcjAuHPHze
         0vBg==
X-Gm-Message-State: ACgBeo2hZaP8Hfh6oQ5eR7ifTLvckC29Pv2cPZmZrOfGCyXqM0VQjl/+
        /JVJLHFYoXll1WS/mvmCO+Mm1s6i4jE=
X-Google-Smtp-Source: AA6agR5EIDaOoANXuuyKQrP+G+X5MWMuRLDKI1Mt+Tv1dTlZFeA6zN9JJx2Xal6+tduT8QZmY/jJNA==
X-Received: by 2002:a17:90a:b703:b0:1dd:1e2f:97d7 with SMTP id l3-20020a17090ab70300b001dd1e2f97d7mr2215655pjr.62.1661243397673;
        Tue, 23 Aug 2022 01:29:57 -0700 (PDT)
Received: from localhost ([98.97.33.232])
        by smtp.gmail.com with ESMTPSA id h19-20020aa796d3000000b0053684aff04esm4338358pfq.2.2022.08.23.01.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 01:29:56 -0700 (PDT)
Date:   Tue, 23 Aug 2022 01:29:54 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <630490024ded0_2ad4d7208e3@john.notmuch>
In-Reply-To: <20220822131923.21476-2-memxor@gmail.com>
References: <20220822131923.21476-1-memxor@gmail.com>
 <20220822131923.21476-2-memxor@gmail.com>
Subject: RE: [PATCH bpf v1 1/3] bpf: Move bpf_loop and bpf_for_each_map_elem
 under CAP_BPF
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Kumar Kartikeya Dwivedi wrote:
> They would require func_info which needs prog BTF anyway. Loading BTF
> and setting the prog btf_fd while loading the prog indirectly requires
> CAP_BPF, so just to reduce confusion, move both these helpers taking
> callback under bpf_capable() protection as well, since they cannot be
> used without CAP_BPF.
> 
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

This should have a fixes tag IMO. You'll get unexpected results if we
don't have get it backported to the right places.

>  kernel/bpf/helpers.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 1f961f9982d2..d0e80926bac5 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1633,10 +1633,6 @@ bpf_base_func_proto(enum bpf_func_id func_id)
>  		return &bpf_ringbuf_submit_dynptr_proto;
>  	case BPF_FUNC_ringbuf_discard_dynptr:
>  		return &bpf_ringbuf_discard_dynptr_proto;
> -	case BPF_FUNC_for_each_map_elem:
> -		return &bpf_for_each_map_elem_proto;
> -	case BPF_FUNC_loop:
> -		return &bpf_loop_proto;
>  	case BPF_FUNC_strncmp:
>  		return &bpf_strncmp_proto;
>  	case BPF_FUNC_dynptr_from_mem:
> @@ -1675,6 +1671,10 @@ bpf_base_func_proto(enum bpf_func_id func_id)
>  		return &bpf_timer_cancel_proto;
>  	case BPF_FUNC_kptr_xchg:
>  		return &bpf_kptr_xchg_proto;
> +	case BPF_FUNC_for_each_map_elem:
> +		return &bpf_for_each_map_elem_proto;
> +	case BPF_FUNC_loop:
> +		return &bpf_loop_proto;
>  	default:
>  		break;
>  	}
> -- 
> 2.34.1
> 


