Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5ED1416573
	for <lists+bpf@lfdr.de>; Thu, 23 Sep 2021 20:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242727AbhIWSxy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Sep 2021 14:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242811AbhIWSxx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Sep 2021 14:53:53 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB82C061574
        for <bpf@vger.kernel.org>; Thu, 23 Sep 2021 11:52:21 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id s16so365001ybe.0
        for <bpf@vger.kernel.org>; Thu, 23 Sep 2021 11:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dcLg/eRWX82LWhZq5NSmPRnQe61HEehwk4b62T7t8fw=;
        b=TC7MM0Z+y88WzcNI65okpSvVRmdvrF85YS/xrZulvDf+ptUfH+aV7MSTTBMhY1m6ab
         JsQ1m5RtrNMh8Xe75Cb4N/EXkulfpPv1ugksK3RAaVexiCwpXOO0DiasmIC/2YokYrVA
         7R/m+D922uS3USpWUy+xpMTFgGwJddSvn3WQ3osi4yeZUsJ6fm7TzU0bUKuh0hzc+Uv+
         hNKv+BBKVklxreB+andRTynkT+1jm9tQI1Uytli2tOoE+HXVGuDvrXxtX7ydNSI6SpOc
         YkKBT5HeuGbl0gD469/eI2v/zRrWO149QLOkbPXT1IInbb409htxIPRrADwDYHdmAW5+
         fW8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dcLg/eRWX82LWhZq5NSmPRnQe61HEehwk4b62T7t8fw=;
        b=sCTNOJfm0Ti2fqy4JuULxd1bdLRDzgwNjaak3maQxLbwiA/mkBxpSL4570tXo8kHDq
         NPwQaXwbeIln8v4SFtFspE65YmC1HGYzPlEYkPLIGDrs8zGK3nUa77496K8eDXaFvmnB
         235jNDfCpmDqoQtakkrT1mU5m4cyQi1uF4v9DQSpRzOd1B8uDyUrr2ipNSHWCyLgNeXP
         igp9Xw8DUd9CCgTZPQI1lCHqaRmODkII760iu8rsUPIEAsG1apxTSQPhmSJW7jpZCQLc
         DBfnfoIC7iqRmZZuEXjm5D8FL/JFghuAUz3GFF7mw/FQbxd1XQPk8J17SABvzCYRQw32
         d5rg==
X-Gm-Message-State: AOAM532uJ+jIu2qJEAZI6JfELJuCP3rYEI0Esgq+M5mLFUl8YFyBQhF2
        R0HFvqg50Pf1hXOoaObBQ6hkh3jAgo1MoRh2DDY=
X-Google-Smtp-Source: ABdhPJz9kYbvnABew0+/uPvbmFYUYefmx/cDHGVv/7Dz50MIO6GlDmpkaFzysCpyROtsOEx6iSF26r2JaTXJRLLAXPo=
X-Received: by 2002:a25:83c6:: with SMTP id v6mr7775105ybm.2.1632423137297;
 Thu, 23 Sep 2021 11:52:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210917215721.43491-1-alexei.starovoitov@gmail.com> <CACAyw98puHhO7f=OmEACNaje0DvVdpS7FosLY9aM8z46hy=7ww@mail.gmail.com>
In-Reply-To: <CACAyw98puHhO7f=OmEACNaje0DvVdpS7FosLY9aM8z46hy=7ww@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 23 Sep 2021 11:52:06 -0700
Message-ID: <CAEf4Bzbi_zZZndM93pWXn=Yu=bXQi6TWP8=pherCCtP5ZseqMA@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 00/10] bpf: CO-RE support in the kernel.
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        mcroce@microsoft.com, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 23, 2021 at 4:34 AM Lorenz Bauer <lmb@cloudflare.com> wrote:
>
> On Fri, 17 Sept 2021 at 22:57, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > Hi All,
> >
> > This is very early RFC that introduces CO-RE support in the kernel.
> > There are several reasons to add such support:
> > 1. It's a step toward signed BPF programs.
> > 2. It allows golang like languages that struggle to adopt libbpf
> >    to take advantage of CO-RE powers.
> > 3. Currently the field accessed by 'ldx [R1 + 10]' insn is recognized
> >    by the verifier purely based on +10 offset. If R1 points to a union
> >    the verifier picks one of the fields at this offset.
> >    With CO-RE the kernel can disambiguate the field access.
> >
> > This set wires all relevant pieces and passes two selftests with CO-RE
> > in the kernel.
> >
> > The main goal of RFC is to get feedback on patch 3.
> > It's passing CO-RE relocation into the kernel via bpf_core_apply_relo()
> > helper that is called by the loader program.
> > It works, but there is no clean way to add error reporting here.
> > So I'm thinking that the better approach would be to pass an array
> > of 'struct bpf_core_relo_desc' into PROG_LOAD command similar to
> > how func_info and line_info are passed.
> > Such approach would allow for the use case 3 above (which
> > current approach in patch 3 doesn't support).
>
> +1 to having good error reporting, it's hard to debug CO-RE failures
> as they are. PROG_LOAD seems nice, provided that relocation happens
> before verification.
>
> Some questions:
> * How can this handle kernels that don't have built-in BTF? Not a
> problem for myself, but some people have to deal with BTF-less distro
> kernels by using pahole to generate external BTF from debug symbols.
> Can we accommodate that?
> * Does in-kernel CO-RE need to account for packed structs w/ bitfields
> in them? If relocation happens after verification this could be a
> problem: [1].

The way that CO-RE relocs for bitfields are implemented with libbpf is
through the use of 5 different relocation kinds. See
BPF_CORE_READ_BITFIELD() macro in bpf_core_read.h.

> * Tangent: libbpf CO-RE has this res->validate flag, which turns off
> some checks for bitfields. I've never fully understood why that is,
> maybe Andrii can explain it?

Because there is no single canonical set of those 5 relocated values
(that I mentioned above) that the compiler has to general. There are
many ways to extract a bitfield and compiler can use different ones
due to optimization and code generation choices. So in general it's
ambiguous and impossible to validate that we agree with the compiler.
Generally we won't agree, but will still do correct bitfield
relocation. Again, I'll refer you to BPF_CORE_READ_BITFIELD() macro
for details.


>
> Lorenz
>
> 1: https://lore.kernel.org/bpf/CACAyw9_R4_ib0KvcuQC4nSOy5+Hn8-Xq-G8geDdLsNztX=0Fsw@mail.gmail.com/
>
> --
> Lorenz Bauer  |  Systems Engineer
> 6th Floor, County Hall/The Riverside Building, SE1 7PB, UK
>
> www.cloudflare.com
