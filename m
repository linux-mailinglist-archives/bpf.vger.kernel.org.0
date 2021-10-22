Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D44C1436F01
	for <lists+bpf@lfdr.de>; Fri, 22 Oct 2021 02:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbhJVAvj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Oct 2021 20:51:39 -0400
Received: from linux.microsoft.com ([13.77.154.182]:40948 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhJVAvj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Oct 2021 20:51:39 -0400
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
        by linux.microsoft.com (Postfix) with ESMTPSA id 61EBF20B6C55
        for <bpf@vger.kernel.org>; Thu, 21 Oct 2021 17:49:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 61EBF20B6C55
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1634863762;
        bh=svPWq/6FS+2H+VVf9ukZHq+zjeWYXuTgEf2PYMnibS0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SqQXBAkE1ftJE4qowzeI6WlVcHSpo45gurc0PClpAutivDm9FDRRu0v+w5UB7E2eV
         A50jF7oNf3uCxP3Qq6Ih7lZwVAF5RfoqJsuWa8CV56ehOqi2Nsu9LjxkEuMdkX9kHI
         APzsMvX3wXLLdGSXRS+qk6UfUFz2vFYbNVzqYGVs=
Received: by mail-pj1-f54.google.com with SMTP id pi19-20020a17090b1e5300b0019fdd3557d3so1811001pjb.5
        for <bpf@vger.kernel.org>; Thu, 21 Oct 2021 17:49:22 -0700 (PDT)
X-Gm-Message-State: AOAM530ul5003QnIHjGuzoUOCPzzwITH10DmOn2IxLCZUKxGRvRcseCW
        TjwOOpNhM/vmYEkHuNn9uKgKwqQvXipZWyR7CRU=
X-Google-Smtp-Source: ABdhPJxeLRlfqf2KbjxpCQq3t6x4yXlqykZ3mbIStymCuy8hpUc5gJLNWUTx1rOLeJOzFRpH051rq/HaIHN10EXA8ak=
X-Received: by 2002:a17:90b:1e0e:: with SMTP id pg14mr10342710pjb.15.1634863761867;
 Thu, 21 Oct 2021 17:49:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210917215721.43491-1-alexei.starovoitov@gmail.com>
 <20210917215721.43491-2-alexei.starovoitov@gmail.com> <20210928164515.46fad888@linux.microsoft.com>
 <20210928163730.7v7ovjhk7kxputny@ast-mbp.dhcp.thefacebook.com>
 <20210928191103.193a9c62@linux.microsoft.com> <CAADnVQ+ajFPKfP+Q5WQFztfZ+05uGgbuQk3H8_9OTny=0vku=g@mail.gmail.com>
 <CAFnufp3hx0CaF=ukCXY3UJj0omVX+5WWk0=-QuENvTPGye_sKA@mail.gmail.com>
 <20210929193858.57ba3cd1@linux.microsoft.com> <CAADnVQJjHyB1CwquYx2X2uMGygEpFJhNh75gPcHnYkD2pLmcDA@mail.gmail.com>
 <CAFnufp07EHqc0wgv0V2H5yMfdw-9diPOX6RS_z+k1iJV+LJ=Kw@mail.gmail.com>
In-Reply-To: <CAFnufp07EHqc0wgv0V2H5yMfdw-9diPOX6RS_z+k1iJV+LJ=Kw@mail.gmail.com>
From:   Matteo Croce <mcroce@linux.microsoft.com>
Date:   Fri, 22 Oct 2021 02:48:45 +0200
X-Gmail-Original-Message-ID: <CAFnufp15UYRJTW9dEorryZ80NsK_ULK0MXmaP_dg_ys6jC89nw@mail.gmail.com>
Message-ID: <CAFnufp15UYRJTW9dEorryZ80NsK_ULK0MXmaP_dg_ys6jC89nw@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 01/10] bpf: Prepare relo_core.c for kernel duty.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Matteo Croce <mcroce@microsoft.com>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 30, 2021 at 1:49 AM Matteo Croce <mcroce@linux.microsoft.com> wrote:
>
> On Thu, Sep 30, 2021 at 1:01 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Wed, Sep 29, 2021 at 10:39 AM Matteo Croce
> > <mcroce@linux.microsoft.com> wrote:
> > > > >
> > > > > I'll take a look. Could you provide the full .c file?
> > > >
> > > > Sure. I put everything in this repo:
> > > >
> > > > https://gist.github.com/teknoraver/2855e0f8770d1363b57d683fa32bccc3
> >
> > This gist is not a reproducer. It doesn't have a single CO-RE relo.
> >
> > But I've hacked it with dev->ifindex like in your email above
> > and managed to repro.
> > My error is different though:
> > [ 1127.634633] libbpf: prog 'prog_name': relo #0: trying to relocate
> > unrecognized insn #0, code:0x85, src:0x0, dst:0x0, off:0x0, imm:0x7
> > [ 1127.636003] libbpf: prog 'prog_name': relo #0: failed to patch insn #0: -22
> >
> > But there is a bug. Debugging...
>
> Oops, I forget to force push, sorry..
> I've updated the gist, even if you managed to reproduce a similar error.
>
> Regards,
> --
> per aspera ad upstream

Hi Alexei,

Did you find out anything?

I posted an RFC for the eBPF signature which depends on this series.

Regards,
-- 
per aspera ad upstream
