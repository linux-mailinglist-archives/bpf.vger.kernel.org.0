Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41B2F462BF4
	for <lists+bpf@lfdr.de>; Tue, 30 Nov 2021 06:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbhK3FSW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Nov 2021 00:18:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbhK3FSW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Nov 2021 00:18:22 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD983C061574
        for <bpf@vger.kernel.org>; Mon, 29 Nov 2021 21:15:03 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id v203so49055112ybe.6
        for <bpf@vger.kernel.org>; Mon, 29 Nov 2021 21:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wNhM8JkEsf5Yq5sGXPAfI9hf6CAVhTc40b5kipSIrQg=;
        b=hf2sutuD6PVXglfE/LrNilg9eGKlOIcNxHvVk/PcOw5RCHqrTpvyaZMWDa4KWCFA2G
         Dc8AF+Z6XxjCSSPa0S08pCleKbkdS/384xyPxl7fOCBAsisgzeA9QssmEs7MZr41x58w
         rlFTOKJKY6+Sr6ZbuiOPmZZG/HImAKq1ovtlZoLbUajG/L6PHNrb6bmQWCEWUP0CB5rk
         Z+v08DPbnSk/GVTew1g+7OXaa6n//DSergymRP0L1zckosTNeeVIXFpdzDneyiDQPgvl
         Yhgye4DNMJIA6yCMl/I2ZfyghCHB+li3aYIBXvLcvKLhvfD0YpaRMGou6Xo6J0sLbd8S
         O0aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wNhM8JkEsf5Yq5sGXPAfI9hf6CAVhTc40b5kipSIrQg=;
        b=q28nE+wJMdkwezkEmc35GWb8WggZPD0P7vTOGFESb9q7wMmTyQVELuy1IK4HweZuFV
         LIuelFGYhCytMeh//TcqQUrIWdjAl7qS8uEY79Db0mQATXq+0Uu6lHaCSI2YD8E39XUT
         Mmt21aDFUobrArhWwbvyNYM3KA4qs0ebIIw3lfglRXXWKL7ZkOvGsrlhpD+Vaflt0BJt
         5NOp+KXqUawiLOc3rw1Rt9PrjfaNw88gYWuNXtuZEzX30pj4PIzfiw0ZXfQJ3/45CtBR
         yYPA+MO6BSYuqTmVNWYib1Y5Hm7kT4IglmTVADVr9pxJlWgWQWQJ8H9fRRoXEL2Ekhq9
         yXxQ==
X-Gm-Message-State: AOAM530Jgo21xttxMlEo+E4oDP/pEtUJoVr4FnR5P5eHjeNbF8C1ACjr
        GxavpdB1iTQLeRnt246b3cvRN4CdLg1zKbofep+t50UPr2c=
X-Google-Smtp-Source: ABdhPJx2sdQ13M1ynPKvuQJGHopo4KnL2/gKvKNjYgveYKUm99vLdRxeWpjWox0m2RMd/iDl0GOsqQv2YZS7W3H3k/8=
X-Received: by 2002:a25:2c92:: with SMTP id s140mr39058045ybs.308.1638249302992;
 Mon, 29 Nov 2021 21:15:02 -0800 (PST)
MIME-Version: 1.0
References: <20211124060209.493-1-alexei.starovoitov@gmail.com>
 <20211124060209.493-8-alexei.starovoitov@gmail.com> <CAEf4BzYNkgP-t_icXjLAxddOPWgN7GZZ7vWrsLbCDycN=z9KzA@mail.gmail.com>
 <20211130031819.7ulr5cfqrqagioza@ast-mbp.dhcp.thefacebook.com>
 <CAEf4Bzb3E5qyf3WtOAWHWSiq9ptPLXErGg5pCFQTAdz0LhZCBw@mail.gmail.com> <20211130050457.o7da5r6hj6zqfbll@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20211130050457.o7da5r6hj6zqfbll@ast-mbp.dhcp.thefacebook.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 29 Nov 2021 21:14:52 -0800
Message-ID: <CAEf4BzZahPknJTJSeUBtCW4+BpWhPjjz8THgZksB_RW_cSg+og@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 07/16] bpf: Add bpf_core_add_cands() and wire
 it into bpf_core_apply_relo_insn().
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 29, 2021 at 9:05 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Nov 29, 2021 at 08:09:55PM -0800, Andrii Nakryiko wrote:
> >
> > oh, I thought you added those fields initially and forgot to delete or
> > something, didn't notice that you are just "opting them out" for
> > __KERNEL__. I think libbpf code doesn't strictly need this, here's the
> > diff that completely removes their use, it's pretty straightforward
> > and minimal, so maybe instead of #ifdef'ing let's just do that?
>
> Cool.
> Folded it into my series as another patch with your SOB.
>

Sounds good, thanks.

> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index b59fede08ba7..95fa57eea289 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -5179,15 +5179,18 @@ static int bpf_core_add_cands(struct
> > bpf_core_cand *local_cand,
> >                    struct bpf_core_cand_list *cands)
> >  {
> >      struct bpf_core_cand *new_cands, *cand;
> > -    const struct btf_type *t;
> > -    const char *targ_name;
> > +    const struct btf_type *t, *local_t;
> > +    const char *targ_name, *local_name;
>
> I wish you've inserted the patch without mangling.
> Thankfully it was short enough to repeat manually.
> No big deal.

Sorry, I actually don't know how to do it with Gmail :( It always
replaces tabs with spaces and I haven't found a way around that.
