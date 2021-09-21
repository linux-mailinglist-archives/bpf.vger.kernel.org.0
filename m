Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9CB8413B0E
	for <lists+bpf@lfdr.de>; Tue, 21 Sep 2021 21:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbhIUUBP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Sep 2021 16:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbhIUUBO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Sep 2021 16:01:14 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA40C061574
        for <bpf@vger.kernel.org>; Tue, 21 Sep 2021 12:59:46 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id q68so169505pga.9
        for <bpf@vger.kernel.org>; Tue, 21 Sep 2021 12:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W7AcCBZp9dh68XP5zT5AJDg/qUp48lzkRhRexRBvtq0=;
        b=Z064YwPHVVaOZoqcX4HQrxbpt7Ls1fdHDGbbxsf8lWgVkiFNmjof0sQRBlHIEqkBzg
         ieV2qoRH/2tkk97R6Q2ADkJGa2zCE7sW14hobJ25uojvYXKASvI/ko2Rrc7rg2KUnNv4
         6Cyi55uEfE7h6fq396KmcGnfMTOq0NOjoAgaeKsLkrBfoLFKyFDDCHY6S3QllfsOc6Tw
         tBPYAaABw0IVAC175zZt20Eql4P5GKrBd0lcPmaMMoFTMYGDYq7LePPVGL8V+DVc7zxC
         M7+NL8/2xIn77Fqcv84RzevwRsb48VV7ZdW0wk1S5gQlKRPmEJ02eoAL6SMPF6dMpnVd
         kaWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W7AcCBZp9dh68XP5zT5AJDg/qUp48lzkRhRexRBvtq0=;
        b=BlKx+5PazGZnsY+e5tIuLkHp1PGv6h+3yuYxmpN6ayW3C1ylxNTlod43j4HLgViJwG
         O91j3R3rRHoOUwvbVi0ocByRO3E8Ej5qasmY3KTaEIsIZsjs3/l6qrWaljymCooUlHu1
         Gpjen4PfAV6hIctIqyB8TIZc8qcAWRt3l8RVSpfpzYoXxtd+37WlPWNzntDq3Py1eMQ+
         gdDEo2ciLAxHh0qSZQz9oj9FH0NNYkgj/ac9zHzypEFRmRQ6yX+QTxTKjZMxRAiDNhRS
         /ibbHRT5SYMAP7vs669X5m3XqnV/YftQMltjmmO9flAjmjp9enxli4VziTEz1AtuRa+o
         +ahg==
X-Gm-Message-State: AOAM5317qDnKQ1pUwXSNF96bRIv1NLxqFHjUZihNdCqoUx3LBvBYnttB
        dKs7EnK97u4zHqrIKQxH7M4tjVkrwUcmU6vIrqgV6/Y+
X-Google-Smtp-Source: ABdhPJy65/nRnBcY8qgcM6fwFf4UsDIFHEJI9x6Hi+n4D40K27kymKVae3i7viDI8FsvlZ0h9KqIr1d7CKBQC1Jg9oM=
X-Received: by 2002:a65:4008:: with SMTP id f8mr29214912pgp.310.1632254385488;
 Tue, 21 Sep 2021 12:59:45 -0700 (PDT)
MIME-Version: 1.0
References: <CACAyw9_TjUMu1s46X3jE3ubcszAW3yoj39ADADOFseL0x96MeQ@mail.gmail.com>
 <CAADnVQKxmNDET97wfi-k7L_ot9WXDX7CnqPNe=wK=rXpQJDcyg@mail.gmail.com>
 <CACAyw9_1s2ZCBWTHvT-rGufW+-m3F722GvhHb_rSR3mEr2gfGA@mail.gmail.com> <CABEBQi=WfdJ-h+5+fgFXOptDWSk2Oe_V85gR90G2V+PQh9ME0A@mail.gmail.com>
In-Reply-To: <CABEBQi=WfdJ-h+5+fgFXOptDWSk2Oe_V85gR90G2V+PQh9ME0A@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 21 Sep 2021 12:59:34 -0700
Message-ID: <CAADnVQKX+ngPV=ZD9+Mm-odr=g-Neqm21TtxZ_rHpt+ybs-8RQ@mail.gmail.com>
Subject: Re: bpf_jit_limit close shave
To:     Frank Hofmann <fhofmann@cloudflare.com>
Cc:     Lorenz Bauer <lmb@cloudflare.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 21, 2021 at 12:11 PM Frank Hofmann <fhofmann@cloudflare.com> wrote:
>
> Wouldn't that (updating the variable only for unpriv use) also make the leak impossible to notice that we ran into ?

impossible?
That jit limit is not there on older kernels and doesn't apply to root.
How would you notice such a kernel bug in such conditions?

> (we have something near to a simple reproducer for https://www.spinics.net/lists/kernel/msg4029472.html ... need to extract the relevant parts of an app of ours, will update separately when there)
>
> FrankH.
>
> On Tue, Sep 21, 2021 at 4:52 PM Lorenz Bauer <lmb@cloudflare.com> wrote:
>>
>> On Tue, 21 Sept 2021 at 15:34, Alexei Starovoitov
>> <alexei.starovoitov@gmail.com> wrote:
>> >
>> > On Tue, Sep 21, 2021 at 4:50 AM Lorenz Bauer <lmb@cloudflare.com> wrote:
>> > >
>> > > Does it make sense to include !capable(CAP_BPF) in the check?
>> >
>> > Good point. Makes sense to add CAP_BPF there.
>> > Taking down critical networking infrastructure because of this limit
>> > that supposed to apply to unpriv users only is scary indeed.
>>
>> Ok, I'll send a patch. Can I add a Fixes: 2c78ee898d8f ("bpf:
>> Implement CAP_BPF")?
>>
>> Another thought: move the check for bpf_capable before the
>> atomic_long_add_return? This means we only track JIT allocations from
>> unprivileged users. As it stands a privileged user can easily "lock
>> out" unprivileged users, which on our set up is a real concern. We
>> have several socket filters / SO_REUSEPORT programs which are
>> critical, and also use lots of XDP from privileged processes as you
>> know.
>>
>> >
>> > > This limit reminds me a bit of the memlock issue, where a global limit
>> > > causes coupling between independent systems / processes. Can we remove
>> > > the limit in favour of something more fine grained?
>> >
>> > Right. Unfortunately memcg doesn't distinguish kernel module
>> > memory vs any other memory. All types of memory are memory.
>> > Regardless of whether its type is per-cpu, bpf map memory, bpf jit memory, etc.
>> > That's the main reason for the independent knob for JITed memory.
>> > Since it's a bit special. It's a crude knob. Certainly not perfect.
>>
>> I'm missing context, how is JIT memory different from these other kinds of code?
>>
>> Lorenz
>>
>> --
>> Lorenz Bauer  |  Systems Engineer
>> 6th Floor, County Hall/The Riverside Building, SE1 7PB, UK
>>
>> www.cloudflare.com
