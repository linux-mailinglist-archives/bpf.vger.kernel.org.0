Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76CAC4198A5
	for <lists+bpf@lfdr.de>; Mon, 27 Sep 2021 18:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235303AbhI0QOJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Sep 2021 12:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235350AbhI0QOH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Sep 2021 12:14:07 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A2BC061575
        for <bpf@vger.kernel.org>; Mon, 27 Sep 2021 09:12:28 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id e15so79930522lfr.10
        for <bpf@vger.kernel.org>; Mon, 27 Sep 2021 09:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oYHtAAui5cKKV8oyXpRS2vluHJGq3IuR+P8GvGmSJ5g=;
        b=ZFXUhgP5yYIU68CliyaEtPdeFaMZomwn3hrQ+zwvR22pNJKB2nQAfwlA3l9lb3mGDK
         fyhlm8lV4s9gAiwl4R1jbu/9sQuxcy+xT8iKFR24cT6Vd5poQtQhoOuuDEAL9rjOxfFr
         ZtvZjArhwZOoeMRjrZFEWAkMLgXQ8RbVl9yfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oYHtAAui5cKKV8oyXpRS2vluHJGq3IuR+P8GvGmSJ5g=;
        b=TT/LHN9qkdA5kLQPYT20u5Zt5Pwj/4tuhReh4Tvf73WaSOYZXzj0zchwcilz9Vw8Jw
         NW9tQ6cReL/by01uT9xFko5waUk1Q1cDyawi1zQBTw7+YtCEAV1Iou76wBPkkQJsaIyd
         yyyNPlB/jfMvJqPb7zAPkzBM8HEl8jdmJ64rQA+ccG4WQXi77hXhZv0n+Ytb+JAY89/p
         KjKPgwSBU6JfbDLFNqluA8oFQzxRTD+lNGyaYarSai7OgzJJMn1kkDRqzFT8QtbC/zC5
         KMhn6FGJNFSDZ0QlbBwGUrMEKcoik0rUO3ERKdKRFhzumjz7NVdg0iTalu/AKS3npBRU
         D2ng==
X-Gm-Message-State: AOAM532spL2XUJUj10rXIDr7sRccW/kQLNNiskq9yGoFlw+8Jh23JkqN
        Ct+LgzVJXR2xnoJTNtltArgnjt1gjnEc+K0zH+nruA==
X-Google-Smtp-Source: ABdhPJxTBPs8pIvBH3UDeYuKu0nS1AhbuS7TfOGBH8Ajv/0y7nEtorIOo7IatkjxIvbm70yOaqznUIEbfqED8i/YWzY=
X-Received: by 2002:a05:6512:118a:: with SMTP id g10mr615786lfr.206.1632759146968;
 Mon, 27 Sep 2021 09:12:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210917215721.43491-1-alexei.starovoitov@gmail.com>
 <CACAyw98puHhO7f=OmEACNaje0DvVdpS7FosLY9aM8z46hy=7ww@mail.gmail.com> <20210924231313.jbg4cs3wk63ii54a@ast-mbp.lan>
In-Reply-To: <20210924231313.jbg4cs3wk63ii54a@ast-mbp.lan>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Mon, 27 Sep 2021 17:12:15 +0100
Message-ID: <CACAyw99aR5sfGZ5OQuRrz6Rt+sOkm6B2vC=JfK1tPqdf6961tw@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 00/10] bpf: CO-RE support in the kernel.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        mcroce@microsoft.com, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, 25 Sept 2021 at 00:13, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Sep 23, 2021 at 12:33:58PM +0100, Lorenz Bauer wrote:
> >
> > Some questions:
> > * How can this handle kernels that don't have built-in BTF? Not a
> > problem for myself, but some people have to deal with BTF-less distro
> > kernels by using pahole to generate external BTF from debug symbols.
> > Can we accommodate that?
>
> I think so, but it probably should be done as a generic feature:
> "populate kernel BTF".
> When kernel wasn't compiled with BTF there could be a way to
> populate it with such. Just like we do sys_bpf(BTF_LOAD)
> for program's BTF we can allow populating vmlinux BTF this way.
> Unlike builtin BTF it wouldn't be trusted for certain verifier assumptions,
> but better than nothing and more convenient than specifying BTF file
> on a side for every bpf prog load with traditional libbpf style.

From my POV we already have an API for external BTF (and I think
libbpf does too?) but would need a new API for "load kernel BTF".
Global state like this also doesn't work well for several individual
processes. Imagine multiple programs on the system trying to each
replace the kernel BTF, how would that work? Which one wins? Being
able to give my own fd for kernel BTF circumvents all those problems
and seems much cleaner to me.

Lorenz

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
