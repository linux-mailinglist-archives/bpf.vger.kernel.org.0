Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2923365178
	for <lists+bpf@lfdr.de>; Tue, 20 Apr 2021 06:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbhDTE1W (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Apr 2021 00:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbhDTE1V (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Apr 2021 00:27:21 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5056C06174A
        for <bpf@vger.kernel.org>; Mon, 19 Apr 2021 21:26:49 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id v72so20745227ybe.11
        for <bpf@vger.kernel.org>; Mon, 19 Apr 2021 21:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GkKIutH3HG3+yIGoM7URFgS7eHgowJJmxUNgLe1R6K4=;
        b=PAIOtWT9FKC5FJZHYeJ1XNFFvcKm/4TFGrM+P3V96dt4WBbiT+G2urcsQB81QTkoYK
         oz2xNqyONV6fde1mAv3j0mdz/Oe6mvPPdHDu4MRaBVqUCEbs1C/v6gIfjGKwmF235ywg
         kevzwwBt4mgQ2UHobARJOcPZBotp9JSSCSiEpf1e7wdfI75MNY3H/eLAs4IdnCy8Yo7N
         A+KI+K0FS4BjyLxrAybckNOZlKJhzyveLJitCClwCmUV6SxXh/WqBpqLFFlg0Gy7unYZ
         o4l4xsV33Q7TvW/HO5JgeIfA1zgF25eLpGF8KRpbVOmRs+6rJA0ZmQpLkJSL2U0FX762
         q99Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GkKIutH3HG3+yIGoM7URFgS7eHgowJJmxUNgLe1R6K4=;
        b=rv3DIaJWP66dFy89m0+SbiJJoe4qcwT9u7muzWLj5ZBsmnRYH8KPmdfa17ESj+P11h
         fqjK+KhbdwxS4pLp3q1AFLLu6lWbAnfNMM/6Fmw7SStIBpgqyRTJupK76dGeT7zXdNjf
         BByF3eVVAxb9lMvJ2XHkxN0H47YNLF4WPsZeqvbsgdIx5nQTSI8Y3FQjlmT7mtO6hb8x
         3MXgXhgWfP1yNMyXwbEnJlNc1In/Y6MqinNrcswoXP6iPU8jF8IEIQ9hu+HJrDimlpfo
         4sEUeh5D9MqbLS4d4M4xMd0q5sRCIhMQEHE0rW58m8ubzsJVfyymbK9Ilw/uvV4DWuRm
         OqZQ==
X-Gm-Message-State: AOAM5326nVIe/Sbo0m66vCPQrRAmbaFXfaF2qskxusuQu/HJnFRqwx31
        n3PLFSNxbQFpvk3oP0u7D/1PRWnk7iNxCZfXTN8=
X-Google-Smtp-Source: ABdhPJxMnZAbEiEpVWoy478aJuy3oKQtFFnqyiEYaWjEdXU7RmKzimj/o0a6pXTLXeDbw+2gPurwuBkVW5uTppLaPSQ=
X-Received: by 2002:a25:9942:: with SMTP id n2mr22536479ybo.230.1618892808987;
 Mon, 19 Apr 2021 21:26:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAO658oXG4HEm0rGEW-==0kaTmqenDUC_GM-qi7CEjwSakbnJRw@mail.gmail.com>
 <CAEf4BzZy0XDYcchPkarUw5AusO7LZfOnswuOyUqakkVJ-ksCDQ@mail.gmail.com>
 <CAO658oUJApo-1RMmkkj=y7oH-LAHLd48E0aqobTiTRSuYm617w@mail.gmail.com> <CAO658oV=NPtTNRk1_W_F1jzKMTyCONWL4kKC+YwexGP2Q5ZYEA@mail.gmail.com>
In-Reply-To: <CAO658oV=NPtTNRk1_W_F1jzKMTyCONWL4kKC+YwexGP2Q5ZYEA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 19 Apr 2021 21:26:37 -0700
Message-ID: <CAEf4BzbxZsS+6S+qdXHFSYPGsevQhxdXqsVH8Z9HGTWreP5uGQ@mail.gmail.com>
Subject: Re: Generating libbpf API documentation
To:     Grant Seltzer Richman <grantseltzer@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 16, 2021 at 12:38 PM Grant Seltzer Richman
<grantseltzer@gmail.com> wrote:
>
> On Tue, Mar 16, 2021 at 4:14 PM Grant Seltzer Richman
> <grantseltzer@gmail.com> wrote:
> >
> > On Mon, Mar 15, 2021 at 8:47 PM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Mon, Mar 15, 2021 at 9:51 AM Grant Seltzer Richman
> > > <grantseltzer@gmail.com> wrote:
> > > >
> > > > Hi all,
> > > >
> > > > I have been experimenting with ways to contribute documentation to
> > > > libbpf to make it easier for developers of bpf projects to use it.
> > > > With the goal of making a documentation site that is easy to
> > > > maintain/generate I found Doxygen (many of you may have experience
> > > > with it, I did not). I set up a CI/CD workflow using github actions
> > > > that runs doxygen on the libbpf mirror hosted there, and hosts the
> > > > produced HTML using netlify. You can find the currently hosted version
> > > > of it at https://libbpf-docs.netlify.app (I would gladly donate a real
> > > > domain name for this purpose). The docs generation workflow is in my
> > > > github repo here: https://github.com/grantseltzer/libbpf-docs
> > >
> > > Thanks for investigating this! I've look at libbpf-docs.netlify.app,
> > > and it seems like it just contains a list of structs and their fields
> > > (both those that are part of libbpf API, as well as internal). Out of
> > > all functions only two are listed there (libbpf_nla_parse_nested and
> > > libbpf_nla_parse) and both are not part of libbpf API as well. So I
> > > understand that I don't see any comments due to the '/**' format
> > > (though it would be easy to run sed script adding it everywhere, just
> > > as part of an experiment), but I'm not sure why none of API functions
> > > are present there?
> > >
> > > I think kernel docs used to be hosted on readthedocs.org, seems like
> > > they are also providing hosting for open-source projects, so that
> > > would solve the problem of the hosting. Have you looked at that
> > > solution? It definitely has a bit more modern UI that
> > > Doxygen-generated one :) but I don't know what are the real
> > > differences between Sphinx and Doxygen and which one we should choose.
> > >
> > > >
> > > > In order to make this work all we would need is to format comments
> > > > above functions we want to document. Doxygen requires that the comment
> > > > just be in a block that starts with `/**`. I don't think doxygen
> > > > specific directives should be committed to code but I think this is a
> > > > fine convention to follow. Other doxygen directives (i.e. having
> > > > `@file` in every file) can be faked using a step I have in the github
> > > > actions.
> > > >
> > > > What does everyone think? Can we agree on this convention and start
> > > > contributing documentation in this way? Any pitfalls to doxygen I'm
> > > > not familiar with?
> > > >
> > > > Thanks!
> >
> > As far as I understand Doxygen's only criteria for generating
> > documentation for functions is if the correctly formatted comment is
> > present. I've changed the repo that the libbpf-docs.netlify.app
> > website uses to track a fork libbpf I have on my personal account. I
> > added comments above some ringbuffer functions to demonstrate this.
> >
> > Interestingly the two functions that already show up
> > (libbpf_nla_parse/parse_nested) have comments which are specifically
> > formatted for doxygen, even including directives for arguments and
> > related functions.
> >
> > I have heard of Sphinx/read-the-docs but didn't look too deeply into
> > it, I'll check it out and report back with my findings!
>
> I've finally gotten a chance to circle around to this. I investigated
> Sphinx and read the docs. As far as I can tell Doxygen is still
> required for generating that docs from code. Sphinx seems to typically
> be used to transform markdown documentation files into themed html
> pages. Sphinx would also enable us to host the documentation on
> readthedocs's, but it would still be the output of Doxygen, meaning it
> wouldn't have the nice theme that you see on other readthedocs pages.
>
> I have a barebones example set up of what that would look like at
> libbpf.readthedocs.io which pulls from my fork of the github mirror
> here: github.com/grantseltzer/libbpf
>
> The advantage of this approach is only having free hosting and having
> a 'readthedocs.io' domain. It would still require CI for pulling in
> libbpf releases, appending doxygen directives, and of course
> committing comments in code next to api functions/types.
>

I didn't have much time to investigate Sphinx vs Doxygen. Reding [0]
diagonally, seems like you need few extensions (breathe and
sphinx_rtd_theme) to make everything work. It also seems like
readthedocs will be able to automatically pull and generate
documentation, so if all that is true, it still seems like Sphinx +
readthedocs is the better and more modern approach.

  [0] https://devblogs.microsoft.com/cppblog/clear-functional-c-documentation-with-sphinx-breathe-doxygen-cmake/

> I prefer the previous approach (github actions + netlify/github pages)
> but regardless would happily set this up if we can start an initiative
> to add those code comments in code, which I'd also like to help
> contribute to. I'd also be happy to hear of suggestions of free/open
> source alternatives for CI.

We currently use Travis CI for libbpf CI, but I'm not very happy with
it and ideally we should move to GitHub Actions or something along
those lines.

>
> Andrii, do you run the libbpf github org and mirror repo?

Yes, I have admin access along Alexei and Daniel. So we'll be able to
set up whatever needs to be set up.
