Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2C4F33DE73
	for <lists+bpf@lfdr.de>; Tue, 16 Mar 2021 21:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbhCPUOv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Mar 2021 16:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhCPUO0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Mar 2021 16:14:26 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E1AC06174A
        for <bpf@vger.kernel.org>; Tue, 16 Mar 2021 13:14:25 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id p24so18894975vsj.13
        for <bpf@vger.kernel.org>; Tue, 16 Mar 2021 13:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nxM4Rakpj1tpDuvsqlthouTzebEqmRLf1OH+eh/uE4I=;
        b=kD5FzStN94dS4ziEBvOIAYbgfqc2PMS/A9tGta8oXjc1wy6FLnSAmaHgzyPyzjkxNc
         OTtLvNYLaT9HzFMN0xycGNKU0XBcbNaYMfy5pNo3KJ55G4UrJi/r51fZWrAe82WG0psN
         D2DYy/3ELOeESOtdw0iKGuPRmCnk50hVc7ZT2S87g1NVyddwoEhuxQWplBi3/Ac4P7Dq
         Bba3rBttfxVyhhvUoUG3RSUOqwZ8S7hG0rsOrcSpAEvqbPKZgxeXK9PqZCOEs9zb4GKd
         TJiBnq5YYpZRNH2ODG4QyP2EUil9xvgJuOxwbRYcckRaUVaEnwECwPIxfwfPndL/yg6Q
         IWhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nxM4Rakpj1tpDuvsqlthouTzebEqmRLf1OH+eh/uE4I=;
        b=FR2ukKrP+HnvSeUZ/ks2FH2RaqceNxVObqwFG9J8SPSIezpvMuE3iBK7R87IXxOK5O
         b9QUoqXVUCwiGV/kg/19s4FsEkMXzhSWrVJQ8oEB50vG2UCM/Xv3EO0L0wblx2vJkv+i
         hmDpTI6hAh/bNQGVFkgmSrpNtbU4YeblwYovEpvhoQflmHNCr2b1P+l/fcoyVPjZh7N8
         EUPZl/MBOMblYJRmwbxd35hAjO6QP/D4IPs1tt+MujzpmMGw7RucoS2xeNmvMfv0dKh1
         vG2H5+r4y4YY+KP4/YOMxZxvfhVyh5VlNrYRMqT7/upKnX3oYPFtXwsF5NzPUJbEl5F0
         70Cg==
X-Gm-Message-State: AOAM533t+koTl6UP4J9opnZxVxZ35ycFsEn2bVtSXVdkr10+Sigseqba
        b2UjxrHfKyJ+/SCeD3SpdZH/6/3uQYetLUO+UUI=
X-Google-Smtp-Source: ABdhPJz068FgHL7OLrS3Gnb9EJsCCZUOSyBbJE9+fN3N1Faqye8tpNn+OA0ix8CbQyrhHVfjCFGjYNB7D/3waqa4qGs=
X-Received: by 2002:a67:e043:: with SMTP id n3mr1060772vsl.22.1615925664943;
 Tue, 16 Mar 2021 13:14:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAO658oXG4HEm0rGEW-==0kaTmqenDUC_GM-qi7CEjwSakbnJRw@mail.gmail.com>
 <CAEf4BzZy0XDYcchPkarUw5AusO7LZfOnswuOyUqakkVJ-ksCDQ@mail.gmail.com>
In-Reply-To: <CAEf4BzZy0XDYcchPkarUw5AusO7LZfOnswuOyUqakkVJ-ksCDQ@mail.gmail.com>
From:   Grant Seltzer Richman <grantseltzer@gmail.com>
Date:   Tue, 16 Mar 2021 16:14:13 -0400
Message-ID: <CAO658oUJApo-1RMmkkj=y7oH-LAHLd48E0aqobTiTRSuYm617w@mail.gmail.com>
Subject: Re: Generating libbpf API documentation
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 15, 2021 at 8:47 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Mar 15, 2021 at 9:51 AM Grant Seltzer Richman
> <grantseltzer@gmail.com> wrote:
> >
> > Hi all,
> >
> > I have been experimenting with ways to contribute documentation to
> > libbpf to make it easier for developers of bpf projects to use it.
> > With the goal of making a documentation site that is easy to
> > maintain/generate I found Doxygen (many of you may have experience
> > with it, I did not). I set up a CI/CD workflow using github actions
> > that runs doxygen on the libbpf mirror hosted there, and hosts the
> > produced HTML using netlify. You can find the currently hosted version
> > of it at https://libbpf-docs.netlify.app (I would gladly donate a real
> > domain name for this purpose). The docs generation workflow is in my
> > github repo here: https://github.com/grantseltzer/libbpf-docs
>
> Thanks for investigating this! I've look at libbpf-docs.netlify.app,
> and it seems like it just contains a list of structs and their fields
> (both those that are part of libbpf API, as well as internal). Out of
> all functions only two are listed there (libbpf_nla_parse_nested and
> libbpf_nla_parse) and both are not part of libbpf API as well. So I
> understand that I don't see any comments due to the '/**' format
> (though it would be easy to run sed script adding it everywhere, just
> as part of an experiment), but I'm not sure why none of API functions
> are present there?
>
> I think kernel docs used to be hosted on readthedocs.org, seems like
> they are also providing hosting for open-source projects, so that
> would solve the problem of the hosting. Have you looked at that
> solution? It definitely has a bit more modern UI that
> Doxygen-generated one :) but I don't know what are the real
> differences between Sphinx and Doxygen and which one we should choose.
>
> >
> > In order to make this work all we would need is to format comments
> > above functions we want to document. Doxygen requires that the comment
> > just be in a block that starts with `/**`. I don't think doxygen
> > specific directives should be committed to code but I think this is a
> > fine convention to follow. Other doxygen directives (i.e. having
> > `@file` in every file) can be faked using a step I have in the github
> > actions.
> >
> > What does everyone think? Can we agree on this convention and start
> > contributing documentation in this way? Any pitfalls to doxygen I'm
> > not familiar with?
> >
> > Thanks!

As far as I understand Doxygen's only criteria for generating
documentation for functions is if the correctly formatted comment is
present. I've changed the repo that the libbpf-docs.netlify.app
website uses to track a fork libbpf I have on my personal account. I
added comments above some ringbuffer functions to demonstrate this.

Interestingly the two functions that already show up
(libbpf_nla_parse/parse_nested) have comments which are specifically
formatted for doxygen, even including directives for arguments and
related functions.

I have heard of Sphinx/read-the-docs but didn't look too deeply into
it, I'll check it out and report back with my findings!
