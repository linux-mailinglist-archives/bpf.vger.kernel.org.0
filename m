Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F08A543B9E3
	for <lists+bpf@lfdr.de>; Tue, 26 Oct 2021 20:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236841AbhJZSr2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Oct 2021 14:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238403AbhJZSr1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Oct 2021 14:47:27 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B56C061745
        for <bpf@vger.kernel.org>; Tue, 26 Oct 2021 11:45:01 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id v7so147680ybq.0
        for <bpf@vger.kernel.org>; Tue, 26 Oct 2021 11:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0SI4Vg/0gG01azwEsvEQKza93hBuexKegHK321tyPa0=;
        b=LzQTkYrldV/Tw0nd/LEn6JjrDLpXOmKzgbK1jSnYkbyrir4k/5tIsMNlG52Fxdbh9M
         M/6O0lbotYcFNl2YGbmAjD+o/U0BtgjbCQL1T5QYQIKcF4RavOXCuIaBMZONlOCdW4aL
         7t1HEPNHYtgRn/ps1e94yLkafxR0VEGGqHzU8FyP3tryWFFoiPVQUz739JTO4tLTR5Mk
         5dNdjbm66vZsdbdUHeePhjIW2/ma8q+yawLeSYv6xt39+pN/o936Lv8QAbx/9HbTcx5o
         y6kNv5td+KHY5eGIUCVEIbKuItkjfYXmXn0/QISZcekCZTGLkIkjo3XmLTyVbePWzHei
         dS3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0SI4Vg/0gG01azwEsvEQKza93hBuexKegHK321tyPa0=;
        b=q575SkYujgb8taFr3VTOVyItJ3wYFOhuIxb+CArPZkK6YAP9uyNz6A7fyA7oRtxF/e
         uyfeGiwekiPdOeQ2+1aHduddb5A1iFRlNtT/2GExTgebM4K9AtZCRpa2mfk7keR/Xva4
         RA6zTNuDeeHpdi5ECEMvuLjG36jsbnJIZnx7TQzUQnQ8zqxnylmJi25JKxk7fTsPM2sg
         wlMB9bsL8gVF21rk03fiIVzIAYNlox2LgOahFokN6F66QUYogHcTH/nK9MdJDdtzo9eg
         iqdqTTvV/j91jQaDALljFYuHBi6BtpLFy34RBFzP4L1ZOWrELF/p0+VBJGWhkeyjfa95
         i5Mg==
X-Gm-Message-State: AOAM530dKjma11M13c1eQmgHIsH1L/QfHcrOzde8Qhp8BqHE8Dya0Ixu
        veXjwyODyOhKdY6KR79LXrhWaQbk+kEdelABiMI=
X-Google-Smtp-Source: ABdhPJxFNxJLVI/yAj4YgsIF3Yil5r2vUVetbP/3R5q500n8g5WhVknWMsgioUPcI/qlBCFspwUNVbQQBa1QZ71XRaU=
X-Received: by 2002:a25:aa0f:: with SMTP id s15mr19748062ybi.51.1635273900046;
 Tue, 26 Oct 2021 11:45:00 -0700 (PDT)
MIME-Version: 1.0
References: <20211025231256.4030142-1-haoluo@google.com> <20211025231256.4030142-3-haoluo@google.com>
 <20211026034854.3ozkpaxaok7hk6kn@ast-mbp.dhcp.thefacebook.com>
 <CAEf4BzbvXQ1qpGazNKCBhzUUPmmfe9d9icDtf++weJkJmme0aw@mail.gmail.com> <CAADnVQJQuZ9pP_T_ZDgoeTnqfPcRMcKM_BshBTpmsZiRmzWMgA@mail.gmail.com>
In-Reply-To: <CAADnVQJQuZ9pP_T_ZDgoeTnqfPcRMcKM_BshBTpmsZiRmzWMgA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 26 Oct 2021 11:44:48 -0700
Message-ID: <CAEf4Bzb2LdZrYVP+h5HxKS+H5tj-s7h_4xir_c3+bihaU5z_yQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/3] bpf: Introduce ARG_PTR_TO_WRITABLE_MEM
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Hao Luo <haoluo@google.com>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 26, 2021 at 10:59 AM Alexei Starovoitov
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

That's true, but while it's easy to add a flag to bpf_reg_state, it's
not easy to do the same for BPF helper input (ARG_PTR_xxx) and output
(RET_PTR_xxx) restrictions. So unless we extend ARG_PTR and RET_PTR
with flags, it seems more consistent to keep the same pure enum
approach for reg_state.

> May be we will have a kernel vs user flag for PTR_TO_MEM in the future.
> If we use different name to express that we will have:
> PTR_TO_USER_RDONLY_MEM and
> PTR_TO_USER_MEM
> plus all variants of ARG_* and RET_* and *_OR_NULL.
> With a flag approach it will be just another flag in bpf_reg_state.

All true, but then maybe we should rethink how we do all those enums.
And instead of having all the _OR_NULL variants, it should be
ARG_NULLABLE/REG_NULLABLE/RET_NULLABLE flag that can be or-ed with the
basic set of register/input/output type enums? Same for ARG_RDONLY
flag. Same could technically be done for USER vs KERNEL memory in the
future.

It's definitely a bunch of code changes, but if we are worried about
an explosion of enum values, it might be the right move?

On the other hand, if there are all those different variations and
each is handled slightly differently, we'll have to have different
logic for each of them. And whether it's an enum + flags, or a few
more enumerators, doesn't change anything fundamentally. I feel like
enums make code discovery a bit simpler in practice, but it's
subjective.
