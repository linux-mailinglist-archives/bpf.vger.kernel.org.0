Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1FF463E55
	for <lists+bpf@lfdr.de>; Tue, 30 Nov 2021 20:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234889AbhK3TFW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Nov 2021 14:05:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234273AbhK3TFW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Nov 2021 14:05:22 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D80C061574
        for <bpf@vger.kernel.org>; Tue, 30 Nov 2021 11:02:02 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id r130so21634228pfc.1
        for <bpf@vger.kernel.org>; Tue, 30 Nov 2021 11:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PxOK6KgKxlhnnXBi2Gfre4Ri99gW2e7GwwsCbng2odE=;
        b=j+ReCkZ3MYdw7h3Tc8VG33CEGdG7UHBUFHzhSbHwDhc056S5rM2E6hlrlcxlHxHCx8
         tUMCPQyPdZm5vpZMI0Ia76fRghc0svZmaR1qildnXh4GBUg78JbktAxDkIP4r97YMnU1
         7ajrDYaJP8FKGgPr2/ant6rVbq6LmZghq7CsHVohwI1KaEyjPalA7yIDnNn2bLkC3fJd
         snuUMRc+nfeMrN95OfIOxL9xcfsVJ+KIv/nZdNS5NGEAewlS3H+Bke3+0cKvW+5BZRGc
         emsPN12jqLhWTjY0T2qH2DSRnp1FLfgHor2btqD5ZvDFvi5Zrwed7OeLtx+pQAacFlPc
         uJRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PxOK6KgKxlhnnXBi2Gfre4Ri99gW2e7GwwsCbng2odE=;
        b=04/uxFOB0/bfvcoaQVSITGGDUp2zy7ujAMGAQCpBAstxAfHPtXwjD/tES1/Vj1e+c4
         4wwlTuISrwjYiCfg+tUq4i/PtXtW+hfL48k4eu7rYP1vMOuITkiq/srtpfidDLLNPzRQ
         3m5+wus949YZzKncOtx+ZnteBOYc7RyJlnbefejx/0dChnD9IR6450TkaC4r/Xr6Fu7B
         HAsPuzz0IfX02Y3IrdX3XpszCWXkyv2JllFqMXrm9dDRWBofIWsg6xsq1uGe9CYA/YiM
         rlvp7pHpDjZMbUp/Gv7GQzUnObtoPAi+g3Xp9MvqZJqVOOP3D0MxlvKhlYvzyomDe7ns
         UxAQ==
X-Gm-Message-State: AOAM530QXyVL6S0KI8M6k0+8FSFDQOhm/aVajqZkvDvm1s5UnnJxwDNs
        Mjm2Fj6shqFcLVB1g2FJI+7yBhM2gEDOEnFBxm8=
X-Google-Smtp-Source: ABdhPJzWC2tW+9YwZCIQ0RcIR83BPo9iYj3PUJYUTB1GmVUu+exPpl0+cOnuYDqlWnqlnbc209EQ5E3SenN/uYy/cc4=
X-Received: by 2002:a05:6a00:1583:b0:49f:dc1c:a0fe with SMTP id
 u3-20020a056a00158300b0049fdc1ca0femr900827pfk.46.1638298922086; Tue, 30 Nov
 2021 11:02:02 -0800 (PST)
MIME-Version: 1.0
References: <20211130030622.4131246-1-joannekoong@fb.com>
In-Reply-To: <20211130030622.4131246-1-joannekoong@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 30 Nov 2021 11:01:50 -0800
Message-ID: <CAADnVQJ8Y64MBY2B-uLG5W_D0-Fwjp0NuL5ZE+b6qYEvLFb7rA@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 0/4] Add bpf_loop helper
To:     Joanne Koong <joannekoong@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 29, 2021 at 7:07 PM Joanne Koong <joannekoong@fb.com> wrote:
>
> This patchset add a new helper, bpf_loop.
>
> One of the complexities of using for loops in bpf programs is that the verifier
> needs to ensure that in every possibility of the loop logic, the loop will always
> terminate. As such, there is a limit on how many iterations the loop can do.
>
> The bpf_loop helper moves the loop logic into the kernel and can thereby
> guarantee that the loop will always terminate. The bpf_loop helper simplifies
> a lot of the complexity the verifier needs to check, as well as removes the
> constraint on the number of loops able to be run.
>
> From the test results, we see that using bpf_loop in place
> of the traditional for loop led to a decrease in verification time
> and number of bpf instructions by ~99%. The benchmark results show
> that as the number of iterations increases, the overhead per iteration
> decreases.
>
> The high-level overview of the patches -
> Patch 1 - kernel-side + API changes for adding bpf_loop
> Patch 2 - tests
> Patch 3 - use bpf_loop in strobemeta + pyperf600 and measure verifier performance
> Patch 4 - benchmark for throughput + latency of bpf_loop call
>
> v3 -> v4:
> ~ Address nits: use usleep for triggering bpf programs, fix copyright style

Applied. Thanks
