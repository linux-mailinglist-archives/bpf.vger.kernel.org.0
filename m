Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A37013A7B85
	for <lists+bpf@lfdr.de>; Tue, 15 Jun 2021 12:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbhFOKNW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Jun 2021 06:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbhFOKNV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Jun 2021 06:13:21 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97562C06175F
        for <bpf@vger.kernel.org>; Tue, 15 Jun 2021 03:11:16 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id a1so26021262lfr.12
        for <bpf@vger.kernel.org>; Tue, 15 Jun 2021 03:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IyvkIcwwdoDL37FE6kX9vMk5LMKw+sW+txneM0TaPaM=;
        b=i5RkcgI+tZZZjVLxQhbDXbcXnQH173TnSUKH2BaKT5urJjkYMP/rHGwyM4tDh9KlnZ
         71p0Sj+oDBELvc5Eogx+QXZ/tgPSrflLDrVkl1wPIJKCjWbCvNj0LayYOiUBrDv5l8WK
         bx8j77bcvhOs10Z8CPR8O40+qhAY8oiUh9nyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IyvkIcwwdoDL37FE6kX9vMk5LMKw+sW+txneM0TaPaM=;
        b=FooFN4j99Ab2K/HhR8nUzC2pcGdp4InVfbF/2yL80vxAJZLPEMhNE73k46oxZwgtdP
         FLrIp+EUwonUx79tRqJt4Hr59I4zdijCJPjV0ayu2jmwLkvtEjwm6Q/c7fMlKuyH4cKY
         bN3s1PqYNUW2PI7Z+ehdPShy4iYDKuXOa/KeaJMXKeKJAt5pqKyJeIjE+dHIO1iQU+N0
         QVJiUkwwiMngddj7fADn/CbSwHFsysoI84ibfxUjiV8fkAQlrGiyiaADrlsinfX9XyQC
         tZ6JVRrtqAeFyrYJic2cbkrllL+ZCDIzjuLZh9XkMwGZ39ylixhuHeaRe+bF7vjRul96
         u0wQ==
X-Gm-Message-State: AOAM532VugNbgbHVSl/BOlQ11JADl13Fj7bsl31oYquPwPGlfRQ05U/O
        8zLgCJuKMHpxwBt6yxrcTSapw0Ljmqnuz9yBtrr+HQ==
X-Google-Smtp-Source: ABdhPJwjloOjO7IrNwTLlATV17OWemrQn98sIs0ptxJ0pAXIE8gohgDOCQef2dpCfGItXCQyWGm99EvLbLn0mzBMk88=
X-Received: by 2002:a05:6512:2ea:: with SMTP id m10mr15579620lfq.325.1623751874994;
 Tue, 15 Jun 2021 03:11:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210610161027.255372-1-lmb@cloudflare.com> <CAEf4BzZDDuyybofAjxm8QG9VYFMGAF8gZ9g-rnoD1-8R_9LExw@mail.gmail.com>
 <CACAyw9-UbOD_H5=KfscPHzwOHL13nTUpojhtQnOTNJpTS-DVzQ@mail.gmail.com> <CAEf4BzbFhGkRi0YSa0pB+2SFYtJKXLEVKx=hQpVbBO_D4KUjtQ@mail.gmail.com>
In-Reply-To: <CAEf4BzbFhGkRi0YSa0pB+2SFYtJKXLEVKx=hQpVbBO_D4KUjtQ@mail.gmail.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Tue, 15 Jun 2021 11:11:03 +0100
Message-ID: <CACAyw9-0qDakujnUBT3uZcgnBZr0dZ8o=GbLx_OEiF1xXvRdzQ@mail.gmail.com>
Subject: Re: [PATCH bpf] lib: bpf: tracing: fail compilation if target arch is missing
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 15 Jun 2021 at 00:27, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> It doesn't seem avoidable. But I'm surprised you are satisfied with
> your patch, it doesn't seem to solve your problem, because you'll
> never trigger those _Pragmas as you'll just fallback to using your
> host architecture. Isn't that right? How did you test your patch?

I tested the patch by removing -D__TARGET_ARCH_$(SRCARCH) from
BPF_CFLAGS in the Makefile. The pragmas are triggered because the
testsuite compiles with -target bpf. This prevents the "host arch"
fallback from activating. bpf2go specifies -target bpf(el|eb) as well,
so any users will get the _Pragma if they use a new enough
bpf_tracing.h.

> >
> > Without it we sometimes get an integer cast warning, something about
> > an int to void* cast I think?
>
> hmm.. ok

This is the error I get:

progs/lsm.c:166:14: warning: cast to 'void *' from smaller integer
type 'int' [-Wint-to-void-pointer-cast]
        void *ptr = (void *)PT_REGS_PARM1(regs);
                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
