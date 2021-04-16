Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D05F73628BC
	for <lists+bpf@lfdr.de>; Fri, 16 Apr 2021 21:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240930AbhDPTjL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Apr 2021 15:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243879AbhDPTjK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 16 Apr 2021 15:39:10 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB0EC061574
        for <bpf@vger.kernel.org>; Fri, 16 Apr 2021 12:38:44 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id l11so6009128vsr.10
        for <bpf@vger.kernel.org>; Fri, 16 Apr 2021 12:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+sLELYf2ikX/yh1Og49eeJUNRxG1Nq09JbaL4tgNnHo=;
        b=QOJylPtOuhy2/V2gEW5P8LTXaCIBv5LAe/ykdBk5GWn7IoNeCPWOmsXL3r1WL80Ilo
         IJWJAsMnegRgQccVuD9U67SK7CpOpCyVe0fy76xwZztgWUUPGLWlZX9qzDKojI/8CGZ7
         EquX4dTu7zSDxDANV1mlO8zXgy03PYsHfaWwrWHF+f2rmYPD0IWlsVd3ZWEdrJgu29SB
         2q7wRtEO7oly67rcBnRkfBrq68+6ZhU94Qr/IAA9O7QY9jS7kMnmhQI7+NglWFNGiXXW
         FjwbAPiVbS2x+ppTtdjlC5fqrw9QpSBco9Db+vhyouQ+2sNmaP7rH22Ji4ZEYrnXOYkj
         G9cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+sLELYf2ikX/yh1Og49eeJUNRxG1Nq09JbaL4tgNnHo=;
        b=lZIovYXFXK9Cp406XNBA3Yr112FoGFjSZ/i8Y1PP7JxUg2llBB0nKmpgGK5mgdIPFn
         Htev/KJX4BmIZoEwFJ91I3Ri8SO84ugvknyvzAGeDkt5MgQJHI7qlHexoF4HZUmI6FL8
         BtsJtqzZagGn7eJOGAQemYQI+vIRrgBmJ44s4x5rOfgT9elhnbdqTVGD4OcIh2//7yVM
         zZkhAgbnNB9jxg19RA8Xwr9tgDawI5s34ZEQkRSPU03S1MFmpDRfLRS6mSLbKinL02LL
         6JSMNbb33ky5ZaJgQLcwFPYAGxyPcVlmFx9B1OJy2VXf2JS7zrsly3mEROnqi9UAApvH
         3yUQ==
X-Gm-Message-State: AOAM532HIMPkQZc1KEBBE+w7eab3BOyfv4jUMYUVLHFdyVesYMZox0Ae
        RozMGqOhXXAUkbziYKojwUrjhcWfsL9KVdXkUus=
X-Google-Smtp-Source: ABdhPJyg4WqdfYTJd5B/a4A8EJnBu7TrJ+l3eOSFYjY5VAf4VkcoaIu/IXWqSWfWFRG0AyZiDH10bXCRc4JsGcicylo=
X-Received: by 2002:a05:6102:30b0:: with SMTP id y16mr8472289vsd.9.1618601923961;
 Fri, 16 Apr 2021 12:38:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAO658oXG4HEm0rGEW-==0kaTmqenDUC_GM-qi7CEjwSakbnJRw@mail.gmail.com>
 <CAEf4BzZy0XDYcchPkarUw5AusO7LZfOnswuOyUqakkVJ-ksCDQ@mail.gmail.com> <CAO658oUJApo-1RMmkkj=y7oH-LAHLd48E0aqobTiTRSuYm617w@mail.gmail.com>
In-Reply-To: <CAO658oUJApo-1RMmkkj=y7oH-LAHLd48E0aqobTiTRSuYm617w@mail.gmail.com>
From:   Grant Seltzer Richman <grantseltzer@gmail.com>
Date:   Fri, 16 Apr 2021 15:38:33 -0400
Message-ID: <CAO658oV=NPtTNRk1_W_F1jzKMTyCONWL4kKC+YwexGP2Q5ZYEA@mail.gmail.com>
Subject: Re: Generating libbpf API documentation
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 16, 2021 at 4:14 PM Grant Seltzer Richman
<grantseltzer@gmail.com> wrote:
>
> On Mon, Mar 15, 2021 at 8:47 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Mon, Mar 15, 2021 at 9:51 AM Grant Seltzer Richman
> > <grantseltzer@gmail.com> wrote:
> > >
> > > Hi all,
> > >
> > > I have been experimenting with ways to contribute documentation to
> > > libbpf to make it easier for developers of bpf projects to use it.
> > > With the goal of making a documentation site that is easy to
> > > maintain/generate I found Doxygen (many of you may have experience
> > > with it, I did not). I set up a CI/CD workflow using github actions
> > > that runs doxygen on the libbpf mirror hosted there, and hosts the
> > > produced HTML using netlify. You can find the currently hosted version
> > > of it at https://libbpf-docs.netlify.app (I would gladly donate a real
> > > domain name for this purpose). The docs generation workflow is in my
> > > github repo here: https://github.com/grantseltzer/libbpf-docs
> >
> > Thanks for investigating this! I've look at libbpf-docs.netlify.app,
> > and it seems like it just contains a list of structs and their fields
> > (both those that are part of libbpf API, as well as internal). Out of
> > all functions only two are listed there (libbpf_nla_parse_nested and
> > libbpf_nla_parse) and both are not part of libbpf API as well. So I
> > understand that I don't see any comments due to the '/**' format
> > (though it would be easy to run sed script adding it everywhere, just
> > as part of an experiment), but I'm not sure why none of API functions
> > are present there?
> >
> > I think kernel docs used to be hosted on readthedocs.org, seems like
> > they are also providing hosting for open-source projects, so that
> > would solve the problem of the hosting. Have you looked at that
> > solution? It definitely has a bit more modern UI that
> > Doxygen-generated one :) but I don't know what are the real
> > differences between Sphinx and Doxygen and which one we should choose.
> >
> > >
> > > In order to make this work all we would need is to format comments
> > > above functions we want to document. Doxygen requires that the comment
> > > just be in a block that starts with `/**`. I don't think doxygen
> > > specific directives should be committed to code but I think this is a
> > > fine convention to follow. Other doxygen directives (i.e. having
> > > `@file` in every file) can be faked using a step I have in the github
> > > actions.
> > >
> > > What does everyone think? Can we agree on this convention and start
> > > contributing documentation in this way? Any pitfalls to doxygen I'm
> > > not familiar with?
> > >
> > > Thanks!
>
> As far as I understand Doxygen's only criteria for generating
> documentation for functions is if the correctly formatted comment is
> present. I've changed the repo that the libbpf-docs.netlify.app
> website uses to track a fork libbpf I have on my personal account. I
> added comments above some ringbuffer functions to demonstrate this.
>
> Interestingly the two functions that already show up
> (libbpf_nla_parse/parse_nested) have comments which are specifically
> formatted for doxygen, even including directives for arguments and
> related functions.
>
> I have heard of Sphinx/read-the-docs but didn't look too deeply into
> it, I'll check it out and report back with my findings!

I've finally gotten a chance to circle around to this. I investigated
Sphinx and read the docs. As far as I can tell Doxygen is still
required for generating that docs from code. Sphinx seems to typically
be used to transform markdown documentation files into themed html
pages. Sphinx would also enable us to host the documentation on
readthedocs's, but it would still be the output of Doxygen, meaning it
wouldn't have the nice theme that you see on other readthedocs pages.

I have a barebones example set up of what that would look like at
libbpf.readthedocs.io which pulls from my fork of the github mirror
here: github.com/grantseltzer/libbpf

The advantage of this approach is only having free hosting and having
a 'readthedocs.io' domain. It would still require CI for pulling in
libbpf releases, appending doxygen directives, and of course
committing comments in code next to api functions/types.

I prefer the previous approach (github actions + netlify/github pages)
but regardless would happily set this up if we can start an initiative
to add those code comments in code, which I'd also like to help
contribute to. I'd also be happy to hear of suggestions of free/open
source alternatives for CI.

Andrii, do you run the libbpf github org and mirror repo?
