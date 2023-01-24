Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC6B679D19
	for <lists+bpf@lfdr.de>; Tue, 24 Jan 2023 16:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233448AbjAXPOP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Jan 2023 10:14:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbjAXPOO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Jan 2023 10:14:14 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5E747098
        for <bpf@vger.kernel.org>; Tue, 24 Jan 2023 07:14:10 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id r9so14199416wrw.4
        for <bpf@vger.kernel.org>; Tue, 24 Jan 2023 07:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2RNiPoGQgZk00hKi0FAXLQ9h780umVeFRdv2t++gej8=;
        b=ElNkH2skUaTvWVPDUgeGw4qCqbB5V9l5/X5sDaGndnrEWlF0Q5dyD++GQTv6SLP3CU
         ZYgTMkZkR3ep61GiLmAlNk21t0y54OtiWSgLq3qy+Fz+N11eX2aC/4DwRb8CBRSpYr5z
         nxZg/zsoCnklHK74pC5a2rTDWx3IOeKungsIZxldpL2/D7ysM7jYX+5Mf2n5C1gwDdwP
         4YRb4vehaB2jvmsBHIP+p64IA7EK387EQk3wLQLb5NSWckCjDDouhtTKH4/Axp2uD+wC
         Bw/YqazyzZasgR8mgDy1s9TDmTwieUlImHSnRt6LFCtWqr+Hrt9419dliMkcZNqXornn
         mshQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2RNiPoGQgZk00hKi0FAXLQ9h780umVeFRdv2t++gej8=;
        b=vRNlwYe8mq4dyOCvTmxz32LWVNWGW6eKSdjX3rFNPxqdv7D2rMuE6UNbGbNHpvgyYv
         bq44Fkr/nl9Yv+ErZ01L3VEaKNY7+3LU2ePYCLrL+egZpuikzNy//YRryqHGLYz41gGa
         I75RVib4kUF6XLf9JkhImywygkvbi3v+FpxkGPecfk3OUKf6bbuGDHQWK8QZiX5qdtuG
         iWOl/YMmI9oBD9XHYRgQLebU7mklI+rOCFbzXb3gUxJ0jfSmIL8hYPyh8fEgg2PehaDN
         J+pLppXBiARmBFuNrlAhnOeESDL4PubaycDWiBF0cbiys4vUu1drR1eVEPnQbQSlK7PZ
         21Ag==
X-Gm-Message-State: AFqh2kqviDNBE9JlPqADnlIfdzRhtcgnZb8F3ZceAgwCkrYZ2/Xh4kOS
        CWrKnc/qxAfsjQFSxPrNd3M=
X-Google-Smtp-Source: AMrXdXtnAPyx2UqhSBQNfMy2wzi8ChRvmAWE/nuTbtc69mMXeEjh1qkhwr+hILeHOuObg+54bT7jag==
X-Received: by 2002:a05:6000:3c2:b0:2bd:d45c:3929 with SMTP id b2-20020a05600003c200b002bdd45c3929mr27163251wrg.54.1674573248745;
        Tue, 24 Jan 2023 07:14:08 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id a5-20020adfeec5000000b002bfb5ebf8cfsm282845wrp.21.2023.01.24.07.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 07:14:08 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Tue, 24 Jan 2023 16:14:05 +0100
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     acme@kernel.org, yhs@fb.com, ast@kernel.org, olsajiri@gmail.com,
        timo@incline.eu, daniel@iogearbox.net, andrii@kernel.org,
        songliubraving@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org, sdf@google.com, haoluo@google.com,
        martin.lau@kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH dwarves 0/5] dwarves: support encoding of optimized-out
 parameters, removal of inconsistent static functions
Message-ID: <Y8/1vY5vaPcerfYw@krava>
References: <1674567931-26458-1-git-send-email-alan.maguire@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1674567931-26458-1-git-send-email-alan.maguire@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 24, 2023 at 01:45:26PM +0000, Alan Maguire wrote:
> At optimization level -O2 or higher in gcc, static functions may be
> optimized such that they have suffixes like .isra.0, .constprop.0 etc.
> These represent
> 
> - constant propagation (.constprop.0);
> - interprocedural scalar replacement of aggregates, removal of
>   unused parameters and replacement of parameters passed by
>   reference by parameters passed by value (.isra.0)
> 
> See [1] for details.
> 
> Currently BTF encoding does not handle such optimized functions
> that get renamed with a "." suffix such as ".isra.0", ".constprop.0".
> This is safer because such suffixes can often indicate parameters have
> been optimized out.  This series addresses this by matching a
> function to a suffixed version ("foo" matching "foo.isra.0") while
> ensuring that the function signature does not contain optimized-out
> parameters.  Note that if the function is found ("foo") it will
> be preferred, only falling back to "foo.isra.0" if lookup of the
> function fails.  Addition to BTF is skipped if the function has
> optimized-out parameters, since the expected function signature
> will not match. BTF encoding does not include the "."-suffix to
> be consistent with DWARF. In addition, the kernel currently does
> not allow a "." suffix in a BTF function name.
> 
> A problem with this approach however is that BTF carries out the
> encoding process in parallel across multiple CUs, and sometimes
> a function has optimized-out parameters in one CU but not others;
> we see this for NF_HOOK.constprop.0 for example.  So in order to
> determine if the function has optimized-out parameters in any
> CU, its addition is not carried out until we have processed all
> CUs and are about to merge BTF.  At this point we know if any
> such optimizations have occurred.  Patches 1-4 handle the
> optimized-out parameter identification and matching "."-suffixed
> functions with the original function to facilitate BTF
> encoding.
> 
> Patch 5 addresses a related problem - it is entirely possible
> for a static function of the same name to exist in different
> CUs with different function signatures.  Because BTF does not
> currently encode any information that would help disambiguate
> which BTF function specification matches which static function
> (in the case of multiple different function signatures), it is
> best to eliminate such functions from BTF for now.  The same
> mechanism that is used to compare static "."-suffixed functions
> is re-used for the static function comparison.  A superficial
> comparison of number of parameters/parameter names is done to
> see if such representations are consistent, and if inconsistent
> prototypes are observed, the function is flagged for exclusion
> from BTF.

should we remove all instances of static functions with same name?

Yonghong suggested in the other thread, that user will assume that
the function he's attached to is the one he expects, while he will
be attached to any (first) match we get from kallsyms_lookup_name

thanks,
jirka

> 
> When these methods are combined - the additive encoding of
> "."-suffixed functions and the subtractive elimination of
> functions with inconsistent parameters - we see a small overall
> increase in the number of functions in vmlinux BTF, from
> 49538 to 50083.  It turns out that the inconsistent prototype
> checking will actually eliminate some of the suffix matches
> also, for cases where the DWARF representation of a function
> differs across CUs, but not via the abstract origin late DWARF
> references showing optimized-out parameters that we check
> for in patch 1.
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc/Optimize-Options.html
> 
> Alan Maguire (5):
>   dwarves: help dwarf loader spot functions with optimized-out
>     parameters
>   btf_encoder: refactor function addition into dedicated
>     btf_encoder__add_func
>   btf_encoder: child encoders should have a reference to parent encoder
>   btf_encoder: represent "."-suffixed optimized functions (".isra.0") in
>     BTF
>   btf_encoder: skip BTF encoding of static functions with inconsistent
>     prototypes
> 
>  btf_encoder.c  | 357 +++++++++++++++++++++++++++++++++++++++++++++++++--------
>  btf_encoder.h  |   2 +-
>  dwarf_loader.c |  76 +++++++++++-
>  dwarves.h      |   5 +-
>  pahole.c       |   7 +-
>  5 files changed, 390 insertions(+), 57 deletions(-)
> 
> -- 
> 1.8.3.1
> 
