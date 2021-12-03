Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7D2F467E14
	for <lists+bpf@lfdr.de>; Fri,  3 Dec 2021 20:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345117AbhLCTZ5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Dec 2021 14:25:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240241AbhLCTZ4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Dec 2021 14:25:56 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EFEEC061751;
        Fri,  3 Dec 2021 11:22:32 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id p18so2751534plf.13;
        Fri, 03 Dec 2021 11:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LZ5pu7ZRL5O2EGlU1hcOfyJ0qzyouTYq2e6urTHkqCw=;
        b=isPzW0rmg3EgLl+sAvrm9iMKrFTx5cAa3s/e7sr25l0DlqsqAB3mbqLHxBxKvHCvy5
         07SQBviJtyjeIjHGJw1KJ6o8a/baViOJ5fKXZBnu3JLlmtSIwiGCJH4aK+RGy/LQgYHI
         IK7JDZ2YrjQIXXIVGK2tPTnNIxoH6ixYCcey8QFRY45aef0YAM0B0xpFC/H0D42X5ArG
         /u0XEVohnyL0HuWpoxNPZNcsffUUPdPqcuA61o0zv0OJ8KNQlmvkyLqYLrU3HXkS1VEd
         duhEVaPmK+D2nR70LMNBpkl4RMgbopk5F8RLP/5/Od9LgpsTjUbI5hvoTFdbzEVgkH6y
         2feA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LZ5pu7ZRL5O2EGlU1hcOfyJ0qzyouTYq2e6urTHkqCw=;
        b=p4oQEQvgAGtJ7JcnLKfAeFLVbb6IzBS4v9cDsaOHSuGTHOeaUk1LnKLemJ4byTXXYm
         RXNHnroBCXVxMJSMLzy/vxjeBOGpc7i5UQWUyMPYfL9T/qGY2YirDOJkCaP5JljDoNV+
         Njw+Zr/FB9IF+0wDH+Pli5nhX5mwKkQjjKTGDFDXgiGrVApJ2kO2EKWtktpwisZNWDnA
         RWHd0mDuYI1X4AceARMH+2WhYlUPrTlxPCUNSPtmIRrSwprAqPdlYGGfyKZjckyNZuKz
         G5JMf8Tf1plO1PlCbDwy9jCqFuzaHXA7GI73CLJSD3WdXhl48goP/dxNgWlSCuZXlpQH
         KnDg==
X-Gm-Message-State: AOAM533XD/gIkAasSVZYu/GED6as7037LdSHizdA677T9ngX2FaHs2TN
        jHrTqr0KSWOpsD4Ge/8wjrjj1ZnCciXpe+BgYl8=
X-Google-Smtp-Source: ABdhPJwN6xw87FHw1o0DuqnWnt3+kHpnhIR22Qoh1ALcQtnUAU7BoeJ9oOObvo97LkCvIMg2hjmBBWlCbLDPgRA4ZQI=
X-Received: by 2002:a17:90a:1f45:: with SMTP id y5mr16742587pjy.138.1638559351448;
 Fri, 03 Dec 2021 11:22:31 -0800 (PST)
MIME-Version: 1.0
References: <20211203191844.69709-1-mcroce@linux.microsoft.com>
In-Reply-To: <20211203191844.69709-1-mcroce@linux.microsoft.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 3 Dec 2021 11:22:20 -0800
Message-ID: <CAADnVQLDEPxOvGn8CxwcG7phy26BKuOqpSQ5j7yZhZeEVoCC4w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/3] bpf: add signature
To:     Matteo Croce <mcroce@linux.microsoft.com>
Cc:     bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        keyrings@vger.kernel.org,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Luca Boccassi <bluca@debian.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Dec 3, 2021 at 11:18 AM Matteo Croce <mcroce@linux.microsoft.com> wrote:
>
> From: Matteo Croce <mcroce@microsoft.com>
>
> This series add signature verification for BPF files.
> The first patch implements the signature validation in the kernel,
> the second patch optionally makes the signature mandatory,
> the third adds signature generation to bpftool.

Matteo,

I think I already mentioned that it's no-go as-is.
We've agreed to go with John's suggestion.
