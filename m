Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F496A2548
	for <lists+bpf@lfdr.de>; Sat, 25 Feb 2023 01:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjBYABo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Feb 2023 19:01:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjBYABn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Feb 2023 19:01:43 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A3A457E6
        for <bpf@vger.kernel.org>; Fri, 24 Feb 2023 16:01:42 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id f13so3744606edz.6
        for <bpf@vger.kernel.org>; Fri, 24 Feb 2023 16:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7bUJgbu7pDu9C1hVhoB9CcXumYG1ZNXuY6Itwc3sC/0=;
        b=SIZrwUM7t8b25tSj+Lxg/UqWK3UrMolKTk/vjiSQeyN+CtQ8k01yWAmj0d0qMCtosg
         glLJdEbMUy8oRv+4wx40elOBQQk2ojjN/XkDKcloKUOlYmW1I1DqaW8zM/aAPv4ejZuA
         OSAkgsB7xKSzhgzZySEEC2SP7BTMQNhhDa80u3q5sQLXMdrAcE8wcZNWAKu/VczAVtGR
         HS7bT5SI/iEgk8lcLLDnytrLFDruNpHuot7Vzuu5ckCVsk+EBCBbQtqjCGljt++SaAE5
         DML49VjF4nURxDFEbajUUgddmTKNtKULAIGPfp1oK7Gxtz8UU5I9XYAcW2yOz0moJR3Q
         dyWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7bUJgbu7pDu9C1hVhoB9CcXumYG1ZNXuY6Itwc3sC/0=;
        b=rEfIvGBtB54m7BCnw0owL30ywMdeIvZoz9FUX5jbHzlBQs4FLPWXIt2hYlSLTy46bN
         bfqeSnNvcB/Fbezdme+FezHCyAUKfch4gUyI4x+jLblFlbpd/n/HideOCgJf/xCOBihb
         zL7BUcAqG1c+/K1lkEB4MZ+0CbrEIX/G5DLUYq9p8jn1dwpBhG/CcBMfNWAsl540jXbH
         6YEMmSZaJg+QdgS79DAIQkCWYJa6fTLlpC6cgCVLPUA2STN3GN0wTQEkNflmKg1/ayDj
         1Dl+giKIIPPXGicUTybxOGNelOI2vRDL2nQ67gpsJeHYeIJh9oYFwqZn6Jfgtbmb496+
         7BuA==
X-Gm-Message-State: AO0yUKWNlYq3YmDBZvvMQO4TzxhOwQSzMDpj2dqu5a43zZbbdsn/E0+j
        WyHF/eYTtIVZRt1F0zK/qv6piX+swl9OMTdCDi/aPiLq
X-Google-Smtp-Source: AK7set+Tml+gQSF6sCCDB0pYUXTKuX3ztLyPxdum98mByMrJ4L1ncets5ygMw3u3f9jLzOXwl/Yf6CQlk7Rc+H7WJmM=
X-Received: by 2002:a17:906:48c9:b0:8ae:9f1e:a1c5 with SMTP id
 d9-20020a17090648c900b008ae9f1ea1c5mr11314741ejt.3.1677283300834; Fri, 24 Feb
 2023 16:01:40 -0800 (PST)
MIME-Version: 1.0
References: <0838bc96-c8a8-c326-a8f0-80240cf6b31a@linux.intel.com>
 <CAADnVQJ4fHzqeuhbCF5SDR5V1Ktku=U2RRRPLc17ia0aFgNG=w@mail.gmail.com> <f171f10b-f7e5-e63d-b446-b37a2856909a@linux.intel.com>
In-Reply-To: <f171f10b-f7e5-e63d-b446-b37a2856909a@linux.intel.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 24 Feb 2023 16:01:29 -0800
Message-ID: <CAADnVQKQ+eEyNt_3EsNkCbxgu93tNEOFq+EGs-6JJhMt-A50cA@mail.gmail.com>
Subject: Re: bpf: RFC for platform specific BPF helper addition
To:     Tero Kristo <tero.kristo@linux.intel.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 24, 2023 at 3:49 AM Tero Kristo <tero.kristo@linux.intel.com> wrote:
>
>
> On 23/02/2023 19:46, Alexei Starovoitov wrote:
> > On Thu, Feb 23, 2023 at 5:23 AM Tero Kristo <tero.kristo@linux.intel.com> wrote:
> >> Hi,
> >>
> >> Some background first; on x86 platforms there is a free running TSC
> >> counter which can be used to generate extremely accurate profiling time
> >> stamps. Currently this can be used by BPF programs via hooking into perf
> >> subsystem and reading the value there; however this reduces the accuracy
> >> due to latency + jitter involved with long execution chain, and also the
> >> timebase gets converted into relative from the start of the execution of
> >> the program, instead of getting an absolute system level value.
> > Are you talking about rdtsc or some other counter?
> > Does it need an arch specific setup?
> Yes, this is rdtsc. TSC is setup automatically by the arch, but
> exporting it to BPF takes a few lines of arch specific code (I did use
> register_btf_kfunc_id_set() during init, under arch/x86/kernel/tsc.c.)
> >
> >> Now, I do have a pretty trivial patch (under internal review atm. at
> >> Intel) that adds an x86 platform specific bpf helper that can directly
> >> read this timestamp counter without relying to perf subsystem hooks.
> >>
> >> Do people have any feedback / insights on this list about addition of
> >> such platform specific BPF helper, basically thumbs up/down for adding
> >> such a thing? Currently I don't think there are any platform specific
> >> helpers in the kernel.
> > Right. That's one of the reasons we don't add new helpers anymore.
> > Please use kfunc instead. You can add it to:
> > arch/x86/net/bpf_jit_comp.c
> > like:
> > __bpf_kfunc u64 bpf_read_rdtsc(void)
> > { asm ("...
> > or to arch specific kernel module.
> >
> > Make sure to add selftests when you submit a patch.
>
> Ok, I can take a look at the selftest side if things nudge forward,
> however there is some internal pressure to ditch the whole idea of
> bpf_rdtsc() due to potential of side channel attacks by using BPF, and
> exploiting the accurate timer in the process. Any thoughts on that side?
> Using BPF requires root access nowadays so it is sort of on-par to
> out-of-tree kernel modules.

Can you elaborate on that security concern?
User space can do rdtsc, so not clear how doing the same in bpf prog
loaded by root makes any difference.
Unpriv bpf is pretty much non-existent.
bpf subsystem went root only long ago.
