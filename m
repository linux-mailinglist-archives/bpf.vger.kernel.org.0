Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 790AC242B79
	for <lists+bpf@lfdr.de>; Wed, 12 Aug 2020 16:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgHLOiF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Aug 2020 10:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbgHLOiE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Aug 2020 10:38:04 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D30C061383
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2020 07:38:04 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id c10so1702984edk.6
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2020 07:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qdMjHh1PyQqOPAqC3XbTF/dXACb3TQgezEnJTlb9Y58=;
        b=nLRq/tZmo/mY7x4rSHyFvW0OKefz+OPcHo42WNAhv5ZgFq6ka+yaNNWVkwtkjpfx4N
         zqIwQit2oe+Y1AP3nWKYxfXH44pxHcGXfPqLNCGa9UGqzlQSMvC/lB4QTI50n1mdzR5N
         avJD9CPWq3B/AiPXmGlFwS9cIFofadmMpaZeVQ1llATBdhvnTMyJgVfaOcm8KG9rG93O
         gv/061FDDnxPUdOM7EZScAfzdvUg4ufvlKJeUv1OfJxsxZ0bg+1RXnLfJaYaBkRcMIgH
         BQ4eIh1k5KH1kBdoDouJHPu4dbM6tEwHKnp07eBO4NsbaE9iYIyTS5WOu/CKKL6aij/n
         V6Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qdMjHh1PyQqOPAqC3XbTF/dXACb3TQgezEnJTlb9Y58=;
        b=QTjZQe7SmEzQzQ++3lRdPAcb1DdbAeZGYzmkCMBSz8B8K3aF746Hl39mqAEN4UkXFO
         vU1SzRYh5X3OhKL9UIPeKgrYyusa9OPdvUzUzo3QtI8M9RPyg0dKnzEKO9LKGba2EKcg
         6+NRjzIUS8R9dvFcNUDnxVaAyeuSvlNC9y7IT2zxPFAgwQmre8DjdBaNFxusSQhBmzSZ
         ix7EhKWO+o6RQoWLltrC42mrECorFY1kubqfW6rcomAUZ/B9I43fEaptL40lmeIRHvmx
         drs/5LYTAnFafHqP9PirSbf4tuOcP7G6v33ofRsb6eZ+kFZOriELlxI/aJ/6xBNAf5Ap
         rxEg==
X-Gm-Message-State: AOAM531siyCj+EQBfSF3kDDnoCQrHHHbq3guaJ2We1bqsob5w0wI9rG/
        A9yNhObFfXuwGtgPSh/ZDdrH5A==
X-Google-Smtp-Source: ABdhPJwOjrPP80qNmG5FivbmMvcRnHg1AIqortuC4SHeap+6p6b5gZY/oAf9xGCntxkf+h8TLn6goA==
X-Received: by 2002:aa7:d58b:: with SMTP id r11mr215000edq.302.1597243082914;
        Wed, 12 Aug 2020 07:38:02 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id b16sm1542753edy.73.2020.08.12.07.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 07:38:02 -0700 (PDT)
Date:   Wed, 12 Aug 2020 16:37:46 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, bpf <bpf@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Jakov Petrina <jakov.petrina@sartura.hr>
Subject: Re: [PATCH bpf] libbpf: Handle GCC built-in types for Arm NEON
Message-ID: <20200812143746.GB3112830@myrica>
References: <20200810122835.2309026-1-jean-philippe@linaro.org>
 <CAEf4Bza_Fchmy7sKT4=3Vs6wopk+yZU7g9o86CJNzeH4DY1c2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4Bza_Fchmy7sKT4=3Vs6wopk+yZU7g9o86CJNzeH4DY1c2A@mail.gmail.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 11, 2020 at 08:30:06PM -0700, Andrii Nakryiko wrote:
[...]
> > +       /*
> > +        * GCC emits typedefs to its internal __PolyXX_t types when compiling
> > +        * Arm SIMD intrinsics. Alias them to the same standard types as Clang.
> > +        */
> > +       { "__Poly8_t",          "unsigned char" },
> > +       { "__Poly16_t",         "unsigned short" },
> > +       { "__Poly64_t",         "unsigned long" },
> 
> In the diff ([0]) that Daniel referenced, seems like they are adding
> poly64_t to ARM32. What prevents GCC from doing that (or maybe they've
> already done that). So instead of making unreliable assumptions, let's
> define it as "unsigned long long" instead?

Agreed. When writing this I had an older version of the ACLE doc
referenced in [0] and wanted to be consistent with the older clang
typedefs.

Thanks,
Jean

> 
>   [0] https://reviews.llvm.org/D79711
> 
> > +       { "__Poly128_t",        "unsigned __int128" },
> > +};
> > +
> > +static void btf_dump_emit_int_def(struct btf_dump *d, __u32 id,
> > +                                 const struct btf_type *t)
> > +{
> > +       const char *name = btf_dump_type_name(d, id);
> > +       int i;
> > +
> > +       for (i = 0; i < ARRAY_SIZE(builtin_types); i++) {
> > +               if (strcmp(name, builtin_types[i][0]) == 0) {
> > +                       btf_dump_printf(d, "typedef %s %s;\n\n",
> > +                                       builtin_types[i][1], name);
> > +                       break;
> > +               }
> > +       }
> > +}
> > +
> >  static void btf_dump_emit_enum_fwd(struct btf_dump *d, __u32 id,
> >                                    const struct btf_type *t)
> >  {
> > --
> > 2.27.0
> >
