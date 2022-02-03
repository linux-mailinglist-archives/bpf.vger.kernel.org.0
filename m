Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D09774A8A36
	for <lists+bpf@lfdr.de>; Thu,  3 Feb 2022 18:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243549AbiBCRgu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Feb 2022 12:36:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233512AbiBCRgt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Feb 2022 12:36:49 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82125C061714;
        Thu,  3 Feb 2022 09:36:49 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id s6so2718695plg.12;
        Thu, 03 Feb 2022 09:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5I5a2aleiUaHSVG05eSin+O0+2GmadoXbT1CBpGVmVg=;
        b=YDwf9xGAGoiZuHSers3gN6OILdgsP9eLyNRCH8J26MT2gnOeZKqba+PbqExN6UOHs6
         /jc5670/4mCF/Odu5BZjQpeFseTMLNsg7dtnSt47OrDxtGNWnuCfYn/bO5s9BbPzdXIz
         PFuDU+YNZIwf6ijsPZ3cHipUwkTm5SQ+EEZh00cIiscgkVKA/sejW/oZMfYUectIiZo9
         FNPZOrFvtM/r2VhvsYl05rqbVr46nHdiiXW3YTP97j+TaOJ6NSeXjDj2pA2f7dqsEeH/
         +QX1PqtRtAs+1gKXk2+FHXequc0mosXqGGMnsbjNEPdJGsRb0X5fXJY6Xl4OUNFXTXSX
         DMKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5I5a2aleiUaHSVG05eSin+O0+2GmadoXbT1CBpGVmVg=;
        b=20fxrEiHJ8tR7dMT+isiXnjFAS2gbOzVzWbyIRIxcEMe6ieziKomA0bi/LfaEVKkfr
         z8mmQyTzEVJWQmthAhf1XTv+PGRWQsCC8j5YO3TVyUXKMhK8VZs2IADHXFa0TuAQCuqq
         MncfE6H/QcLaAZ02OPnX0qlCNZYDAyX9xQUCNF+vzCDCNEIyQsqZtQD/z1p/wHuH6Qt0
         e9Jfh9y6sBASspfhFSxo6Ub22PE05YB0dzbeyecJp1GyY2W42eDImcrUYQYgp3IUED+x
         uvxWE0sge2di8J58r8mMjrkqKqpZhFWGb196FjP+sCkjLqDfJ0XIzOAK7XOfc24PBaXg
         RXgA==
X-Gm-Message-State: AOAM5302l6NOwmzI8uKTW7TTUN5Rft+QtO5IOPn+h7PaVhx/5YxTIkte
        Imnr7aDuJIYz7634krwmtsxXWmtAATsdmknOX+8=
X-Google-Smtp-Source: ABdhPJxYcrN4bvEQR+zrWc1ogjgqtyMArTJR/wnAUtNmwp9bx3XLZzgrs74tmsW6jlgG+l8ba92xQ/XeVftoXlgmr5s=
X-Received: by 2002:a17:90b:4ac6:: with SMTP id mh6mr15271610pjb.138.1643909808921;
 Thu, 03 Feb 2022 09:36:48 -0800 (PST)
MIME-Version: 1.0
References: <20220202211328.176481-1-mcroce@linux.microsoft.com> <20220202211328.176481-3-mcroce@linux.microsoft.com>
In-Reply-To: <20220202211328.176481-3-mcroce@linux.microsoft.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 3 Feb 2022 09:36:38 -0800
Message-ID: <CAADnVQ+PpCHnQoTxJ2V0305SnSmftngyGGaq1m71ai0KS1jZ9w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: test maximum recursion
 depth for bpf_core_types_are_compat()
To:     Matteo Croce <mcroce@linux.microsoft.com>
Cc:     bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 2, 2022 at 1:13 PM Matteo Croce <mcroce@linux.microsoft.com> wrote:
>
> From: Matteo Croce <mcroce@microsoft.com>
>
> bpf_core_types_are_compat() was limited to 2 recursion levels, which are
> enough to parse a function prototype.
> Add a test which checks the existence of a function prototype, so to
> test the bpf_core_types_are_compat() code path.
>
> Signed-off-by: Matteo Croce <mcroce@microsoft.com>
> ---
>  .../selftests/bpf/bpf_testmod/bpf_testmod.c        |  3 +++
>  tools/testing/selftests/bpf/progs/core_kern.c      | 14 ++++++++++++++
>  2 files changed, 17 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> index 595d32ab285a..a457071a7751 100644
> --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> @@ -13,6 +13,9 @@
>  #define CREATE_TRACE_POINTS
>  #include "bpf_testmod-events.h"
>
> +typedef int (*func_proto_typedef)(long);
> +func_proto_typedef funcp = NULL;
> +
>  DEFINE_PER_CPU(int, bpf_testmod_ksym_percpu) = 123;
>
>  noinline void
> diff --git a/tools/testing/selftests/bpf/progs/core_kern.c b/tools/testing/selftests/bpf/progs/core_kern.c
> index 13499cc15c7d..bfea86b42563 100644
> --- a/tools/testing/selftests/bpf/progs/core_kern.c
> +++ b/tools/testing/selftests/bpf/progs/core_kern.c
> @@ -101,4 +101,18 @@ int balancer_ingress(struct __sk_buff *ctx)
>         return 0;
>  }
>
> +typedef int (*func_proto_typedef___match)(long);
> +typedef void (*func_proto_typedef___doesnt_match)(char*);
> +
> +int out[2];
> +
> +SEC("raw_tracepoint/sys_enter")
> +int core_relo_recur_limit(void *ctx)
> +{
> +       out[0] = bpf_core_type_exists(func_proto_typedef___match);
> +       out[1] = bpf_core_type_exists(func_proto_typedef___doesnt_match);

How does it test it?
The kernel code could be a nop and there will be no failure in this "test".
Please make it real.
Also add tests that exercise the limit of recursion.
One that goes over and fails and another that is right at the limit
and passes.
