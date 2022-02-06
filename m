Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B57F4AB2A4
	for <lists+bpf@lfdr.de>; Sun,  6 Feb 2022 23:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345959AbiBFW2V (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 6 Feb 2022 17:28:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241442AbiBFW2V (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 6 Feb 2022 17:28:21 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A9CBDC061348;
        Sun,  6 Feb 2022 14:28:20 -0800 (PST)
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
        by linux.microsoft.com (Postfix) with ESMTPSA id 454DC20B876C;
        Sun,  6 Feb 2022 14:28:20 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 454DC20B876C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1644186500;
        bh=AlgeafKjcWTDjqK3xCVT2BjxHUzAw2nMkNrXQLyZQqc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JvioGdL5CYwDWllkg46Qe8WBy+WRWKiMns089Y+xhT/wlYcUksaQBAMDV/KWkjzYK
         /PCSjE+19iNDH4yAFHfvu8N1gUUdSoE3RBr9mqlsHAFH9ouR6bq40xi6+drlw6iFjr
         P8TeKutcAnqBXK94rU3Y4JCsWcmZXOOLBQTmnKVo=
Received: by mail-pg1-f179.google.com with SMTP id v3so10003958pgc.1;
        Sun, 06 Feb 2022 14:28:20 -0800 (PST)
X-Gm-Message-State: AOAM533b11kn2zgSMvNHvbAPN2kze1vrWJHO0U3t7crpnX/G7dD9Gpsq
        ez2sdmMIMjbyJuc0c3Hr8WTg5lK4TR7vns5zsCA=
X-Google-Smtp-Source: ABdhPJyMiXen4M2yfTGefBb4OQ4k2zXbkKWF5dpmLywwDDvBXpV8ydstjtqe9+OpxQ1eGPd1TGEK1SqWCneAahZnr78=
X-Received: by 2002:a63:f156:: with SMTP id o22mr6987624pgk.387.1644186499802;
 Sun, 06 Feb 2022 14:28:19 -0800 (PST)
MIME-Version: 1.0
References: <20220204005519.60361-1-mcroce@linux.microsoft.com>
 <20220204005519.60361-3-mcroce@linux.microsoft.com> <CAADnVQ+tesyKMd864TzBgfynuxosPPoGgHiB0M9p2oRjitdv2g@mail.gmail.com>
In-Reply-To: <CAADnVQ+tesyKMd864TzBgfynuxosPPoGgHiB0M9p2oRjitdv2g@mail.gmail.com>
From:   Matteo Croce <mcroce@linux.microsoft.com>
Date:   Sun, 6 Feb 2022 23:27:43 +0100
X-Gmail-Original-Message-ID: <CAFnufp31Sw8z6f6z1ZR5W9Z61qBMWsOFdN3bFbWNU6vT4KKOvw@mail.gmail.com>
Message-ID: <CAFnufp31Sw8z6f6z1ZR5W9Z61qBMWsOFdN3bFbWNU6vT4KKOvw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: test maximum recursion
 depth for bpf_core_types_are_compat()
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 4, 2022 at 8:38 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Feb 3, 2022 at 4:55 PM Matteo Croce <mcroce@linux.microsoft.com> wrote:
> > --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> > +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> > @@ -13,6 +13,11 @@
> >  #define CREATE_TRACE_POINTS
> >  #include "bpf_testmod-events.h"
> >
> > +typedef int (*func_proto_typedef___match)(long);
> > +typedef int (*func_proto_typedef___overflow)(func_proto_typedef___match);
>
> There is no need for "___flavor" on the kernel side of type definition.
> It makes the test confusing to read.
>
> > +func_proto_typedef___match funcp = NULL;
> > +func_proto_typedef___overflow funcp_of = NULL;
>
> We have BTF_TYPE_EMIT() macro to avoid unnecessary declaration.
>
> > +typedef int (*func_proto_typedef___match)(long);
> > +typedef int (*func_proto_typedef___overflow)(func_proto_typedef___match);
>
> With <=1 in the previous patch such single depth of func_proto
> was reaching the recursion limit.
> Hence the fix <=0 was necessary.
> I've also changed this test to:
>
> +typedef int (*func_proto_typedef)(long);
> +typedef int (*func_proto_typedef_nested1)(func_proto_typedef);
> +typedef int (*func_proto_typedef_nested2)(func_proto_typedef_nested1);
>
> in bpf_testmod.c and in progs/core_kern_overflow.c
> and
> bpf_core_type_exists(func_proto_typedef_nested2);
> to go above the limit.
>
> Also added bpf_core_type_exists(func_proto_typedef_nested1)
> to progs/core_kern.c to stay at the limit.
>
> Please see the result in bpf-next.

Awesome.
I've seen both patches in the repo, LGTM.

-- 
per aspera ad upstream
