Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E505A4AA033
	for <lists+bpf@lfdr.de>; Fri,  4 Feb 2022 20:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234034AbiBDTiA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Feb 2022 14:38:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233941AbiBDTiA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Feb 2022 14:38:00 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E58C061714;
        Fri,  4 Feb 2022 11:38:00 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id h14so6033886plf.1;
        Fri, 04 Feb 2022 11:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L5dLU4EAVWGYM7Yk8YJmAlAnD7IzyAIW7kZVpagkypg=;
        b=Ctt4DPTUdPcxcqshyQk5fK/wryEC1i6k4Lk+HOFZb7y2CzNO0n4sYu2KgWzgAhHGA1
         s5JlHee1DaJNJE6cOyWsnGA4lmEPx0/Mx+gY08n4k1PO1Dlty84bGvXEIzxW6PpbZO5n
         arvXeN4Wow0QULCZAMS44RrXQ22V8lw3tx87/lkC+VPheqwZzicGWkBzHrYfXg5yBIxe
         9M7TY7basXq5Ziw8tsdXbNPvJ5Ehu9bHDBoaj6chiO0h9VJJuxWYmpIZwxB5q2bqCUtA
         W/ZHbFH6DCAm4as8QGiUCFGFP5tjkL5FqImcxtMK/e12VF/RvX6gppfdys9vd+ro0D48
         jvRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L5dLU4EAVWGYM7Yk8YJmAlAnD7IzyAIW7kZVpagkypg=;
        b=8A48kmvt+ngjo2YTo0KQ4daPrTmgqqnzYkHGTRmi/ZF2UOQIdMX8uawJRRXJy02xEU
         GrPXLHIuIs8v3bAHIlDWfgUhzy0NKcDqGKmBT+fGGrgPHpN8j2tLrloopvTEkqEDUNwH
         V01i7+5vWo9883lMN0V3VbTmFwqUT6mUyYkkLqlyAHSn9Z1NSTvOtsoCRAdmszs2Uitz
         57rMisDz0HMXDNuaMaFo3ofkpiGHhgyQniZrclYwDpKIKCgySgmF9gTyCvtJirepQVip
         jFOIMh/A3mkh2ik/TNUPxfRta2kGZ28WIEpk4fvJ2PFaYyTWv4mnAJpd8XQWIOu3XDIN
         35kw==
X-Gm-Message-State: AOAM531Tc0fRaqsJSyUuaMKcaNqKJs/aARACWz6bw49PWWallg9+aXGv
        F3AYMGKTJR05vN5DT94bY7Rdh/SeYQgAB8HhZDM=
X-Google-Smtp-Source: ABdhPJx6ccKRnDnARaIIVdj8sW/bKIPVdcni82iM0SD7DQXOfakSctEzgg+NvpTaXzqsNXQ/d4I2Cj+HMaztGbsEtzc=
X-Received: by 2002:a17:902:d4c5:: with SMTP id o5mr4743370plg.116.1644003479467;
 Fri, 04 Feb 2022 11:37:59 -0800 (PST)
MIME-Version: 1.0
References: <20220204005519.60361-1-mcroce@linux.microsoft.com> <20220204005519.60361-3-mcroce@linux.microsoft.com>
In-Reply-To: <20220204005519.60361-3-mcroce@linux.microsoft.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 4 Feb 2022 11:37:48 -0800
Message-ID: <CAADnVQ+tesyKMd864TzBgfynuxosPPoGgHiB0M9p2oRjitdv2g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: test maximum recursion
 depth for bpf_core_types_are_compat()
To:     Matteo Croce <mcroce@linux.microsoft.com>
Cc:     bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 3, 2022 at 4:55 PM Matteo Croce <mcroce@linux.microsoft.com> wrote:
> --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> @@ -13,6 +13,11 @@
>  #define CREATE_TRACE_POINTS
>  #include "bpf_testmod-events.h"
>
> +typedef int (*func_proto_typedef___match)(long);
> +typedef int (*func_proto_typedef___overflow)(func_proto_typedef___match);

There is no need for "___flavor" on the kernel side of type definition.
It makes the test confusing to read.

> +func_proto_typedef___match funcp = NULL;
> +func_proto_typedef___overflow funcp_of = NULL;

We have BTF_TYPE_EMIT() macro to avoid unnecessary declaration.

> +typedef int (*func_proto_typedef___match)(long);
> +typedef int (*func_proto_typedef___overflow)(func_proto_typedef___match);

With <=1 in the previous patch such single depth of func_proto
was reaching the recursion limit.
Hence the fix <=0 was necessary.
I've also changed this test to:

+typedef int (*func_proto_typedef)(long);
+typedef int (*func_proto_typedef_nested1)(func_proto_typedef);
+typedef int (*func_proto_typedef_nested2)(func_proto_typedef_nested1);

in bpf_testmod.c and in progs/core_kern_overflow.c
and
bpf_core_type_exists(func_proto_typedef_nested2);
to go above the limit.

Also added bpf_core_type_exists(func_proto_typedef_nested1)
to progs/core_kern.c to stay at the limit.

Please see the result in bpf-next.
