Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EFC240FEFB
	for <lists+bpf@lfdr.de>; Fri, 17 Sep 2021 20:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbhIQSGD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Sep 2021 14:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbhIQSGD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Sep 2021 14:06:03 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D83C061574
        for <bpf@vger.kernel.org>; Fri, 17 Sep 2021 11:04:41 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id a66so20088121qkc.1
        for <bpf@vger.kernel.org>; Fri, 17 Sep 2021 11:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x7BzGDRhEtKmATJQnyxIsrdoa4nFPXq+ZsApwi2oLWg=;
        b=nkS0DbJafAemlORVfTh6Y1UVlekSX1pbVUiuTCGAj5bYBbmZKak+4Zta7waPLBNtJX
         tAaxsvKzUuqxOau6h1jkm9sNN2FX6YJftxWL0mawZWA+Ir2Ni/0/7cWUpJPWSlE0Q8oR
         A+NUOce1Ekhbz1hcDWlLgwiaGB1EuFcLfgJ3ibnvUUQjKGovNUPzv4RR8yx9Frd0LKtn
         2hfOvWhgNlTW4fxzA1a6y3cQKeuFUhhlK32RetX0NbRqziiBUaqasA+h2py5blSPGpSx
         vRegjFli0hqKhYoBHdbFnHLG1YSP3pHlFKunMHru55jBkw5VpMY2kdTHg2uZFWzbCo0r
         ZUeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x7BzGDRhEtKmATJQnyxIsrdoa4nFPXq+ZsApwi2oLWg=;
        b=rKMQj5LGoDWsJQRdZJEXC3s+lFT39K/XFPjYyU3nt3Ngz3ge6byjztr6lVkG5o1W9N
         cdAjKmb2cDB4ZVknuzhLOH4ZZi7+9DBcmSZDHTZZ68RJWx4LXL5ndzKyJGIe5LR71lF3
         95konYQTMvkR1YiJmlFbPgsq17KIfkAw9y2hMO/pV/hqm55tKwsAhqvvPggYVeWhW8lz
         9+snoLAY8uU15wB6XULIjLffM94XGnXm/T2Zb3WRRpE/WR+VrgaHuKMRHWEe1hktUWQI
         8G1sc4nY732MalbHhk8mPdVo7Qz1CJ/jdbVUz3r/JBtIgQOMvpBLgIrdo+OHtwaquJjU
         WfOQ==
X-Gm-Message-State: AOAM5316yktXxoRoM5fh+BvblFi1/+NdV5q93V/XYVyhmq+XOUqabikY
        nQsrTJfcBX+1HFqG05hjtONBoAmo2bdWNhnKOac+JlI0
X-Google-Smtp-Source: ABdhPJwMiCXaWVVknETVaYgMbfj8GEFTg3eRk2S3jF2NmqvWiNdttXWLcWI3G1Y9QTzNs9rjschoJdn/rozftrbThAQ=
X-Received: by 2002:a25:afcd:: with SMTP id d13mr15258261ybj.504.1631901880446;
 Fri, 17 Sep 2021 11:04:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210916015836.1248906-1-andrii@kernel.org> <20210916015836.1248906-5-andrii@kernel.org>
 <1334565d-4810-1ded-504b-180a7b124473@fb.com> <CAADnVQK8hdbEQ0iO7X0pr_xAet-=nC0DhwkE2Kid9FrG72hD2Q@mail.gmail.com>
In-Reply-To: <CAADnVQK8hdbEQ0iO7X0pr_xAet-=nC0DhwkE2Kid9FrG72hD2Q@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 17 Sep 2021 11:04:29 -0700
Message-ID: <CAEf4BzbMBg49+DqE2bgmYRDH5Kao5HvmMyDKY0EHL7DRU-KvKw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/7] libbpf: allow skipping attach_func_name in bpf_program__set_attach_target()
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andrii@kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 17, 2021 at 9:10 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Sep 15, 2021 at 9:17 PM Yonghong Song <yhs@fb.com> wrote:
> >
> >
> >
> > On 9/15/21 6:58 PM, Andrii Nakryiko wrote:
> > > Allow to use bpf_program__set_attach_target to only set target attach
> > > program FD, while letting libbpf to use target attach function name from
> > > SEC() definition. This might be useful for some scenarios where
> > > bpf_object contains multiple related freplace BPF programs intended to
> > > replace different sub-programs in target BPF program. In such case all
> > > programs will have the same attach_prog_fd, but different
> > > attach_func_name. It's conveninent to specify such target function names
> >
> > typo: conveninent => convenient
> >
> > > declaratively in SEC() definitions, but attach_prog_fd is a dynamic
> > > runtime setting.
> > >
> > > To simplify such scenario, allow bpf_program__set_attach_target() to
> > > delay BTF ID resolution till the BPF program load time by providing NULL
> > > attach_func_name. In that case the behavior will be similar to using
> > > bpf_object_open_opts.attach_prog_fd (which is marked deprecated since
> > > v0.7), but has the benefit of allowing more control by user in what is
> > > attached to what. Such setup allows having BPF programs attached to
> > > different target attach_prog_fd with target funtions still declaratively
>
> Applied with "conveninent" and "funtions" typos fixed.

Thanks!
