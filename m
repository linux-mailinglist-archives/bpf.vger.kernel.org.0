Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF7F036887F
	for <lists+bpf@lfdr.de>; Thu, 22 Apr 2021 23:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237048AbhDVVVl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Apr 2021 17:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237018AbhDVVVl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Apr 2021 17:21:41 -0400
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A10C06174A
        for <bpf@vger.kernel.org>; Thu, 22 Apr 2021 14:21:05 -0700 (PDT)
Received: by mail-vk1-xa29.google.com with SMTP id x4so10160846vkx.5
        for <bpf@vger.kernel.org>; Thu, 22 Apr 2021 14:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IGhXjnkSXjtzb3EVBdwJaLUgJJh/tTihxGt6DqyeoiQ=;
        b=Gf2Jbim10f8ltIngbegutuIKfJkXc5rxo1dqe2k7Ixte9OexHwemMVgI/tTzXpqnJw
         8q7mh+mYU66/ZEqLH65jZIuwX6gwogsf1zXkCO7Y8apMgzzUwFwW13OE1h3QeN0ZkUTQ
         +AENROU0/d3bDDQabsTceexm2rIKIR23PyH1ukylxGnsSs7qQvL+BOvHt/gMdziHIOtr
         OFpfsSA69igO+audyXdWFoW3vOpNtl0wsMspklmfmGYPIMAWdSWxwo60wDk76eUB+RuA
         pG7/8UQ+PYHXh+Ur6RYUaI1/D2ak8FbsCqS3B5DN2mq7c6NWTippVTsL1SUwoWab3vRd
         u3bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IGhXjnkSXjtzb3EVBdwJaLUgJJh/tTihxGt6DqyeoiQ=;
        b=al2e3+22B/ciW0RtcO+ZkSThX7OWnbJvMBUVVbHg0zNSLqIaPwY8nr2WDzAx7tt00J
         4L3EvoRic+1AtNm4E5lIiQrYVs+rHdmWf2xbSgiPz9t1ISalnGJBH0oemkfRsidmp3Wt
         OwEODmv45HmkMMSdJoWGP+kyxr4sRhca3Ax5FIXN6w7XX/SUF/NoAuMW7Zfe/J6LS5hi
         4x6UJK0rF0djUP10pxVGTVOnyGL25jWNvDeNff8XpMC23Pp7VmTkhnR2iFLGaencCqVp
         BD9tQseOWb51FLaFMwjJ2cU6Ky2IMppouB4dPWshPf3Q7ziWKjMt5sigAJemqORFIqUK
         aSyw==
X-Gm-Message-State: AOAM531WDnTTkMocLpd7hz3o4dHF96uHaic0JY16yWOypiS/r8qJ1k1B
        W+qi1vyTF0Ett38ixclm9BKCA3dXQI9b58xjme0=
X-Google-Smtp-Source: ABdhPJyY8ULNCywKmKEf0JvUYqPhtOPw8YXMGmaFZToa9Ly+AVmDEGsH7TsdtR7qHzhwdiw4POHkmpB5eNby36Ouk9w=
X-Received: by 2002:a1f:1e01:: with SMTP id e1mr842962vke.8.1619126464522;
 Thu, 22 Apr 2021 14:21:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAO658oXG4HEm0rGEW-==0kaTmqenDUC_GM-qi7CEjwSakbnJRw@mail.gmail.com>
 <CAEf4BzZy0XDYcchPkarUw5AusO7LZfOnswuOyUqakkVJ-ksCDQ@mail.gmail.com>
 <CAO658oUJApo-1RMmkkj=y7oH-LAHLd48E0aqobTiTRSuYm617w@mail.gmail.com>
 <CAO658oV=NPtTNRk1_W_F1jzKMTyCONWL4kKC+YwexGP2Q5ZYEA@mail.gmail.com>
 <CAEf4BzbxZsS+6S+qdXHFSYPGsevQhxdXqsVH8Z9HGTWreP5uGQ@mail.gmail.com>
 <CAO658oXWP2dsAsD9S8=EjosnoE4ND6LWr3js_yiDNGNw3ZqGQg@mail.gmail.com> <CAEf4Bza34-z4CXHdz6C7wEL9ghcaDSQdGp7NX1QF7T5u3brO1w@mail.gmail.com>
In-Reply-To: <CAEf4Bza34-z4CXHdz6C7wEL9ghcaDSQdGp7NX1QF7T5u3brO1w@mail.gmail.com>
From:   Grant Seltzer Richman <grantseltzer@gmail.com>
Date:   Thu, 22 Apr 2021 17:20:53 -0400
Message-ID: <CAO658oUmvX1FYwHey1_6oF82ep=h6XvGNdW4oFTPtMhJ8fxrug@mail.gmail.com>
Subject: Re: Generating libbpf API documentation
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 21, 2021 at 11:58 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Apr 21, 2021 at 12:24 PM Grant Seltzer Richman
> <grantseltzer@gmail.com> wrote:
> >
> > On Tue, Apr 20, 2021 at 12:26 AM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Fri, Apr 16, 2021 at 12:38 PM Grant Seltzer Richman
> > > <grantseltzer@gmail.com> wrote:
> > > >
> > > > On Tue, Mar 16, 2021 at 4:14 PM Grant Seltzer Richman
> > > > <grantseltzer@gmail.com> wrote:
> > > > >
> > > > > On Mon, Mar 15, 2021 at 8:47 PM Andrii Nakryiko
> > > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > >
> > > > > > On Mon, Mar 15, 2021 at 9:51 AM Grant Seltzer Richman
> > > > > > <grantseltzer@gmail.com> wrote:
> > > > > > >
> > > > > > > Hi all,
> > > > > > >
> > > > > > > I have been experimenting with ways to contribute documentation to
> > > > > > > libbpf to make it easier for developers of bpf projects to use it.
> > > > > > > With the goal of making a documentation site that is easy to
> > > > > > > maintain/generate I found Doxygen (many of you may have experience
> > > > > > > with it, I did not). I set up a CI/CD workflow using github actions
> > > > > > > that runs doxygen on the libbpf mirror hosted there, and hosts the
> > > > > > > produced HTML using netlify. You can find the currently hosted version
> > > > > > > of it at https://libbpf-docs.netlify.app (I would gladly donate a real
> > > > > > > domain name for this purpose). The docs generation workflow is in my
> > > > > > > github repo here: https://github.com/grantseltzer/libbpf-docs
> > > > > >
> > > > > > Thanks for investigating this! I've look at libbpf-docs.netlify.app,
> > > > > > and it seems like it just contains a list of structs and their fields
> > > > > > (both those that are part of libbpf API, as well as internal). Out of
> > > > > > all functions only two are listed there (libbpf_nla_parse_nested and
> > > > > > libbpf_nla_parse) and both are not part of libbpf API as well. So I
> > > > > > understand that I don't see any comments due to the '/**' format
> > > > > > (though it would be easy to run sed script adding it everywhere, just
> > > > > > as part of an experiment), but I'm not sure why none of API functions
> > > > > > are present there?
> > > > > >
> > > > > > I think kernel docs used to be hosted on readthedocs.org, seems like
> > > > > > they are also providing hosting for open-source projects, so that
> > > > > > would solve the problem of the hosting. Have you looked at that
> > > > > > solution? It definitely has a bit more modern UI that
> > > > > > Doxygen-generated one :) but I don't know what are the real
> > > > > > differences between Sphinx and Doxygen and which one we should choose.
> > > > > >
> > > > > > >
> > > > > > > In order to make this work all we would need is to format comments
> > > > > > > above functions we want to document. Doxygen requires that the comment
> > > > > > > just be in a block that starts with `/**`. I don't think doxygen
> > > > > > > specific directives should be committed to code but I think this is a
> > > > > > > fine convention to follow. Other doxygen directives (i.e. having
> > > > > > > `@file` in every file) can be faked using a step I have in the github
> > > > > > > actions.
> > > > > > >
> > > > > > > What does everyone think? Can we agree on this convention and start
> > > > > > > contributing documentation in this way? Any pitfalls to doxygen I'm
> > > > > > > not familiar with?
> > > > > > >
> > > > > > > Thanks!
> > > > >
> > > > > As far as I understand Doxygen's only criteria for generating
> > > > > documentation for functions is if the correctly formatted comment is
> > > > > present. I've changed the repo that the libbpf-docs.netlify.app
> > > > > website uses to track a fork libbpf I have on my personal account. I
> > > > > added comments above some ringbuffer functions to demonstrate this.
> > > > >
> > > > > Interestingly the two functions that already show up
> > > > > (libbpf_nla_parse/parse_nested) have comments which are specifically
> > > > > formatted for doxygen, even including directives for arguments and
> > > > > related functions.
> > > > >
> > > > > I have heard of Sphinx/read-the-docs but didn't look too deeply into
> > > > > it, I'll check it out and report back with my findings!
> > > >
> > > > I've finally gotten a chance to circle around to this. I investigated
> > > > Sphinx and read the docs. As far as I can tell Doxygen is still
> > > > required for generating that docs from code. Sphinx seems to typically
> > > > be used to transform markdown documentation files into themed html
> > > > pages. Sphinx would also enable us to host the documentation on
> > > > readthedocs's, but it would still be the output of Doxygen, meaning it
> > > > wouldn't have the nice theme that you see on other readthedocs pages.
> > > >
> > > > I have a barebones example set up of what that would look like at
> > > > libbpf.readthedocs.io which pulls from my fork of the github mirror
> > > > here: github.com/grantseltzer/libbpf
> > > >
> > > > The advantage of this approach is only having free hosting and having
> > > > a 'readthedocs.io' domain. It would still require CI for pulling in
> > > > libbpf releases, appending doxygen directives, and of course
> > > > committing comments in code next to api functions/types.
> > > >
> > >
> > > I didn't have much time to investigate Sphinx vs Doxygen. Reding [0]
> > > diagonally, seems like you need few extensions (breathe and
> > > sphinx_rtd_theme) to make everything work. It also seems like
> > > readthedocs will be able to automatically pull and generate
> > > documentation, so if all that is true, it still seems like Sphinx +
> > > readthedocs is the better and more modern approach.
> > >
> > >   [0] https://devblogs.microsoft.com/cppblog/clear-functional-c-documentation-with-sphinx-breathe-doxygen-cmake/
> >
> > That link proved helpful. I was not using the breathe plugin
> > directives correctly in the previous iteration. Thanks!
> >
>
> Great, glad it helped.
>
> > >
> > > > I prefer the previous approach (github actions + netlify/github pages)
> > > > but regardless would happily set this up if we can start an initiative
> > > > to add those code comments in code, which I'd also like to help
> > > > contribute to. I'd also be happy to hear of suggestions of free/open
> > > > source alternatives for CI.
> > >
> > > We currently use Travis CI for libbpf CI, but I'm not very happy with
> > > it and ideally we should move to GitHub Actions or something along
> > > those lines.
> >
> > I recently set up some github actions workflow for the project I help
> > maintain and really like it so far, I would be happy to help
> > transition.
>
> Yeah, we currently have entire infrastructure around Travis CI in
> which we compile the latest kernel, selftests, spin up qemu instance
> and run selftests inside it. It would be great to migrate that to
> Github Actions, I hope that most of the logic doesn't need to change.
> But unfortunately I haven't been able to dedicate enough time to
> tackle that migration.
>
> >
> > >
> > > >
> > > > Andrii, do you run the libbpf github org and mirror repo?
> > >
> > > Yes, I have admin access along Alexei and Daniel. So we'll be able to
> > > set up whatever needs to be set up.
> >
> > I just pushed changes for libbpf.readthedocs.io for you to check out.
>
> It looks great! Something that's from the modern era, you know... ;)
>
> > The 'API' page has the auto generated docs based on public
> > functions/structs/enums in libbpf.h. There's a couple of functions
> > that I added bogus test comments to show what documentation  would
> > look like. (`libbpf_num_possible_cpus` has a good example). Also the
> > 'BPF Program Types' page is just to serve as an example of how we can
> > include documentation that isn't just auto generated from code.
> >
> > I need to read the `sync-kernel.sh` script to better understand how
> > the mirror works, but after that would it be helpful to open a github
> > PR? Once that'd get merged I'd transfer the readthedocs libbpf page to
> > track it. I also want to discuss this on the linux-doc mailing list
> > for input.
>
> sync-kernel.sh has few places where rules for transforming kernel
> source code into Github layout are specified. Only those would need to
> be updated, probably.
>
> So yeah, please take a look and submit PR and/or patches here. Let's
> start with just bare bones infra for documentation and then start
> improving doc comments themselves.

Went ahead and submitted a PR on the mirror:
https://github.com/libbpf/libbpf/pull/260

I'll follow that up with some initial patches to the code with comment
documentation, and likely also some blog content promoting this
initiative.
