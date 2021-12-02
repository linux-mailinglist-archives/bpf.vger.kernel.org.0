Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18020466DEF
	for <lists+bpf@lfdr.de>; Fri,  3 Dec 2021 00:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349388AbhLBXnk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Dec 2021 18:43:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232981AbhLBXnj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Dec 2021 18:43:39 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3BBC06174A
        for <bpf@vger.kernel.org>; Thu,  2 Dec 2021 15:40:16 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id q74so4008394ybq.11
        for <bpf@vger.kernel.org>; Thu, 02 Dec 2021 15:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8P8QIzYRrFun1JZisDtD7k/7OOsoMY4TSWu3nCJDlCg=;
        b=UYrgR/JBrvf/xXsJcTOcO8tUP6VVbB8+GkF5lCGusuBhHOJVrYEYloFiZzAnWFsXS+
         2bxS4aqZof5ndKxySAdxubMv6ZwgjP28wBcQabHeZSup8MNGKtxVYQjPkIoDBVxEDeoC
         FbuCZwyENioFrUdAnB+yhtwhOf/UoNAEB1mZ3l6ycqN/eP6Hbkb6c/pqhDEZnvhWzQLK
         qxfCMiXtwlRXBiJctxiJUIzbEtaVQwYWmXCRnxGjsEns5nh/m7WHouGy4U2yU4otZ0nh
         UQY3UW5x2m7LC9Q7FGylyNqft5OKXe3+nwQKULnsvs2z1pS/NTvIz1tADFxhTrViCs/H
         v8VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8P8QIzYRrFun1JZisDtD7k/7OOsoMY4TSWu3nCJDlCg=;
        b=hkOZw2m9d8VaSSHSU7o1Hv//vRczCaYZDBGaEI3IJ31CYh6oyobvy4g6Au6z9nFsie
         XeKCbyaJnHK2b1SB/69ghyMkiQPpN9O/wZov3GG7GlgWyM1nVsW2dpBfpMmbjdJeylEK
         J67qcziBgvOdhyV3cz41X8h/SsjzLTVtpdsCEI0+3LnIfj5xjnW2R4K0fy9F/XXsQyLv
         yL186vdTb9y/tug55aWvlMr9ZGFBeHV29drJa2cxjdHox/8XKrgOsKFqYw7CVOlVz8c3
         OGenzVUpIcVZ7pY/3CJ8VLsVnChbqB9t2IrSsVMktkdaG1TVsMWpmZeWi3nFak1lTPxx
         XEpQ==
X-Gm-Message-State: AOAM530klIIks4RabInlvd4BE8XrvqIOfsxbR7X+qTwx5UQ9b7JeUX+X
        eI18fTLfr8K1Oqd/UtALztAMMBMSLAhUjT6Agm4=
X-Google-Smtp-Source: ABdhPJzfAnwdposKqxpFVOnjqPNyogekBtwJSZwFqtE8AJgMku2v/FV0pYk/7sYxnf9lC/UNKf8uDeW4ap7XjtRKlPQ=
X-Received: by 2002:a25:b204:: with SMTP id i4mr18259273ybj.263.1638488415935;
 Thu, 02 Dec 2021 15:40:15 -0800 (PST)
MIME-Version: 1.0
References: <20211201232824.3166325-1-andrii@kernel.org> <20211201232824.3166325-2-andrii@kernel.org>
 <CAADnVQ+u12cF=8OnRkL3REsrusvf+XjOrEoUD78rDxJ3sJCeVg@mail.gmail.com>
In-Reply-To: <CAADnVQ+u12cF=8OnRkL3REsrusvf+XjOrEoUD78rDxJ3sJCeVg@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 2 Dec 2021 15:40:04 -0800
Message-ID: <CAEf4BzZGyUp+3QPoXXbFFUtXe6qvyrmTwZXxS8kz8dbYGUjgVA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/9] libbpf: use __u32 fields in bpf_map_create_opts
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 2, 2021 at 3:29 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Dec 1, 2021 at 3:28 PM Andrii Nakryiko <andrii@kernel.org> wrote:
> >
> > Corresponding Linux UAPI struct uses __u32, not int, so keep it
> > consistent.
> >
> > Fixes: 992c4225419a3 ("992c4225419a libbpf: Unify low-level map creation APIs w/ new bpf_map_create()")
>
> That was not a correct tag.
> It should have been:
> Fixes: 992c4225419a ("libbpf: Unify low-level map creation APIs w/ new
> bpf_map_create()")

yeah, sorry, it's just a copy/paste problem (I pasted just hash
initially, then git log --oneline <hash>, pasted that, but forgot to
remove previously pasted sha.


>
> I fixed it while applying.
> I have the following in my .gitconfig
> [core]
>         abbrev = 12
> [pretty]
>         fixes = Fixes: %h (\"%s\")

oh, nice trick, I'll add that, thanks

>
> and use it this way:
> git log -1 --pretty=fixes sha
