Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67FEA43B939
	for <lists+bpf@lfdr.de>; Tue, 26 Oct 2021 20:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238163AbhJZSQh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Oct 2021 14:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238145AbhJZSQ2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Oct 2021 14:16:28 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4300FC061226
        for <bpf@vger.kernel.org>; Tue, 26 Oct 2021 11:14:04 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id y67so415686iof.10
        for <bpf@vger.kernel.org>; Tue, 26 Oct 2021 11:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a3xvsJM2aKqQJVT0+o82H+Qil172ZuH81nWvhLX7y0s=;
        b=UctN/2lwOvIBfyJMKAS4onBCQR5BjA7X6vJaxKpzBjkcnZMWIfBQVDK2q8z+T2nriq
         GgWA88PQzTq8I5cD/S3jpplbcp8CqB6TL4ESDYqaI5eVkuRptzvJh3v5dP8pX1rsl4jR
         1OVuJYLwcEHdUvrzHLTLBSCIt4MiaoHOk29CGv+m9hKwOU+k41ofIDTwb3ISK8kZ40qs
         RZuBVDysd89yONV1w7TjjzM3yqAnn421tLxakyICfel5yX+0tPGaxFmdS2fJaEJYa+4K
         bOl2SaYRs4uuffgAmtGEDjhARO2/qsKwGwYGAin1ACQuQpIi2GFKK6kldOcQF+zF05Ar
         eN2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a3xvsJM2aKqQJVT0+o82H+Qil172ZuH81nWvhLX7y0s=;
        b=2aFF9UoRKIfsiEujoWz0W+egp7MaBN1D4AqAxZejIElVAFPN8dV9JC6GINsbV2zpYq
         bBIVv1CiPU4AYjD2pqKQDwNsn7JHwEFDT29EzKCmH68wxA7FM07RLwbQ2/6RsHixnNgz
         rdQEIpGdiHJw0idC82KNx47s0j3/iWq1K9zqEABt5/UnJGyuI1yg2wUAOu6s/dsghy6w
         WL+C3PkQm1iOiXfaFJURsLEvGazVCpfos7UOAmUTuAiv1x/m9K+wuSvX7MDmTpP3FKSr
         nOCFFqXx1F0HZ8862jHjNEza9/jE/A6hok9iL/oWxEyXnIsC6fodnjO73XxzvYFfyv4j
         kdXg==
X-Gm-Message-State: AOAM530TZiJOOw+3jqj1k1DGgwdnPxu9FDqOETesLEBxmyo14em6DYLP
        MUUupBac7V+9wNHn2TC8Y+SKviJTuJwSEtY1Rf5JFQ==
X-Google-Smtp-Source: ABdhPJx2JzJVxpEwngeRPGfaDDiyvIbKfPto5JgkcLJx/hfwViN2rscaajTWpzDGu9U8d1hW9Zq7lk6FsHJe8/JcoAQ=
X-Received: by 2002:a5e:c204:: with SMTP id v4mr16484774iop.183.1635272043400;
 Tue, 26 Oct 2021 11:14:03 -0700 (PDT)
MIME-Version: 1.0
References: <20211025231256.4030142-1-haoluo@google.com> <20211025231256.4030142-3-haoluo@google.com>
 <20211026034854.3ozkpaxaok7hk6kn@ast-mbp.dhcp.thefacebook.com>
 <CAEf4BzbvXQ1qpGazNKCBhzUUPmmfe9d9icDtf++weJkJmme0aw@mail.gmail.com> <CAADnVQJQuZ9pP_T_ZDgoeTnqfPcRMcKM_BshBTpmsZiRmzWMgA@mail.gmail.com>
In-Reply-To: <CAADnVQJQuZ9pP_T_ZDgoeTnqfPcRMcKM_BshBTpmsZiRmzWMgA@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Tue, 26 Oct 2021 11:13:52 -0700
Message-ID: <CA+khW7h1p8T5FikBC=xxj3n7yL8+du2=UVXCAx0BC-uFMW2Oog@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/3] bpf: Introduce ARG_PTR_TO_WRITABLE_MEM
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 26, 2021 at 11:00 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Oct 25, 2021 at 10:14 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> > >
> > > Instead of adding new types,
> > > can we do something like this instead:
> > >
> > > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> > > index c8a78e830fca..5dbd2541aa86 100644
> > > --- a/include/linux/bpf_verifier.h
> > > +++ b/include/linux/bpf_verifier.h
> > > @@ -68,7 +68,8 @@ struct bpf_reg_state {
> > >                         u32 btf_id;
> > >                 };
> > >
> > > -               u32 mem_size; /* for PTR_TO_MEM | PTR_TO_MEM_OR_NULL */
> > > +               u32 rd_mem_size; /* for PTR_TO_MEM | PTR_TO_MEM_OR_NULL */
> > > +               u32 wr_mem_size; /* for PTR_TO_MEM | PTR_TO_MEM_OR_NULL */
> >
> > This seems more confusing, it's technically possible to express a
> > memory pointer from which you can read X bytes, but can write Y bytes.
>
> I'm fine it being a new flag instead of wr_mem_size.
>
> > I actually liked the idea that helpers will be explicit about whether
> > they can write into a memory or only read from it.
> >
> > Apart from a few more lines of code, are there any downsides to having
> > PTR_TO_MEM vs PTR_TO_RDONLY_MEM?
>
> because it's a churn and non scalable long term.
> It's not just PTR_TO_RDONLY_MEM.
> It's also ARG_PTR_TO_RDONLY_MEM,
> and RET_PTR_TO_RDONLY_MEM,
> and PTR_TO_RDONLY_MEM_OR_NULL
> and *_OR_BTF_ID,
> and *_OR_BTF_ID_OR_NULL.
> It felt that expressing readonly-ness as a flag in bpf_reg_state
> will make it easier to get right in the code and extend in the future.
> May be we will have a kernel vs user flag for PTR_TO_MEM in the future.
> If we use different name to express that we will have:
> PTR_TO_USER_RDONLY_MEM and
> PTR_TO_USER_MEM
> plus all variants of ARG_* and RET_* and *_OR_NULL.
> With a flag approach it will be just another flag in bpf_reg_state.

Totally agree. Adding a variant incurs exponential cost. Introducing
another dimension in future may need to go over all the MEM,
RDONLY_MEM, MEM_OR_NULL, RDONLY_MEM_OR_NULL, multiplied by ARG_*,
RET_*, etc. It's a pain.

I have that in mind and start thinking more about how can we do a more
scalable flag approach.
