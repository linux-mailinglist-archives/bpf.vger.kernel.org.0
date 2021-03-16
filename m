Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBEEE33DC95
	for <lists+bpf@lfdr.de>; Tue, 16 Mar 2021 19:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239995AbhCPS3n (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Mar 2021 14:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240017AbhCPS3X (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Mar 2021 14:29:23 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23104C06174A
        for <bpf@vger.kernel.org>; Tue, 16 Mar 2021 11:29:23 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id w18so22755834edc.0
        for <bpf@vger.kernel.org>; Tue, 16 Mar 2021 11:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FPQpYUDh0iSMnzTmLGWJ1gFwwRAQhxT5gVNcSaWJF+I=;
        b=HHJS3JCO9PGZdF72/II5Vn5y3+9Uh97kJ9MLAuwPwHRQ+95cWgNCpLVf8UlHvMyiCH
         fMTEDA1HstGdoIxKqNEcoVa7ysSgVeOIZZGLCt6tlpxt9MOuk+S0BBrPDhymhIRI+KQE
         LQ4nGrWgnfn2ZoAaDorimtXt/Ew8CooHxCZElkzq6RMZX+BtJWGb+9+nym+gTA20XHF4
         mBBvr2ucz2Vcuc+Inow3VJ+fEiNgxhja6w73HPFHsHtOEbADGfUQmqHKdwqjVQ0zJ4EU
         Bp4CiJ0g3tZuGKZc4uQa0kPP6yczk1aYqgRzwPPlSr5oZdNjOSqlPitWI6H0ZWnMFSNz
         OJJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FPQpYUDh0iSMnzTmLGWJ1gFwwRAQhxT5gVNcSaWJF+I=;
        b=IkJz20UET5JMCDRGvMhzI6LqS8T4drIRoB/OeIxA5XnNbd4+Md8d1zsZFJG9H6XzXc
         DjMHw63ICr6ZOctbIrgAP8VABDyKsZNM++Zkp+S212J41AUJh0aZ/WsQK8YpqqOHXxyj
         Hmr0FemBeh1/G8WYM4AGdwc47huIiuwpRGr9FEWGyrl9kexhTupSGYK1Uz9f3T9OcTmX
         aGU6E9OnaE3Y6KXnF1hMyNoCgQqcbAbG3Mx3a3SEN37WuL7/TLBu1YclJWbvj/2gbjSO
         59xAmtDKNmNz7TsBc3usWGoqKuWRyZnvk+8ijBSLv/NaE9GW43ytHNS+SFxkzFcnpJNY
         WGrQ==
X-Gm-Message-State: AOAM532u7Oy5B3JORT2gmm6gxO54b8Kn/VoA3deUCiBQtECNCrdkC/Xi
        bvQjVGk82OTLZTQZAZjregV6QFy3k4bW+AwbO48=
X-Google-Smtp-Source: ABdhPJw3ZNIm7G+aBy008Clfn0RABQ1RwmdUzjAQlcE2fYtFzecX3B/8SV+oXDQ9DW3+sYFVGqWX83I6LSDahTm4Oic=
X-Received: by 2002:aa7:cdcf:: with SMTP id h15mr37290722edw.28.1615919361831;
 Tue, 16 Mar 2021 11:29:21 -0700 (PDT)
MIME-Version: 1.0
References: <CANaYP3GTwpRMNrLNLLvOyaVzU6UiV-h2Ji=JwWeOJq4NBiJ_Bg@mail.gmail.com>
 <CAEf4BzaFMhCrDSHuQH1uc9cBNuvuTKeXPam0Ux2LmuUM9anJJg@mail.gmail.com>
In-Reply-To: <CAEf4BzaFMhCrDSHuQH1uc9cBNuvuTKeXPam0Ux2LmuUM9anJJg@mail.gmail.com>
From:   Gilad Reti <gilad.reti@gmail.com>
Date:   Tue, 16 Mar 2021 20:28:45 +0200
Message-ID: <CANaYP3HpLYUfw5sXNRJrywbdPUYkbBw5-VXW3PFJJVuj_5smmg@mail.gmail.com>
Subject: Re: libbpf pinning strategies - towards v1
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 16, 2021 at 7:55 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Sun, Mar 14, 2021 at 8:40 AM Gilad Reti <gilad.reti@gmail.com> wrote:
> >
> > As libbpf is heading towards a first major release, we wanted to
> > discuss libbpf's object pinning strategy.
> >
> > bpf object pinning has a couple of use cases (feel free to add, there
> > are more for sure):
> > 1. Sharing specific bpf objects between different processes (for
> > example, one process loads a bpf skeleton, another one interacts with
> > it using various bpf maps (for example, for changing configurations
> > (i.e. dynamic networking rules etc))
> > 2. Preventing bpf objects from destruction upon owning process exit
> > (i.e. to prevent bpf progs detach upon userspace program crash)
> >
> > Regarding the first use case, for most cases manually setting the pin
> > path (both in the loading process and in other processes) will
> > probably be the best. In such cases, no redesign is required here.
> >
> > For the second one, something like the bpf_object__pin will be more
> > appropriate (to allow a complete reuse of the bpf objects). For that
> > use case, some sensible requirements we can consider are:
> >
> > 1. Paths should be unique:
> >     a. at the bpf_object level (that is, same pinnable objects that
> > belong to different bpf_object s should be pinned at different paths).
> >     b. in the same bpf_object, between different pinnable object types
> > (i.e. a map and a prog) should always be pinned at different paths.
> >     c. different objects, belonging to the same bpf_object and of the
> > same type should be pinned at different paths.
> > 2. Paths should be predictable, given enough information on the
> > originating bpf_object (that is, adding random UID to ensure
> > uniqueness is not an option).
> >
> > All the above should be applied to auto-pinned maps and the
> > bpf_object__pin function. I am not sure if the
> > bpf_object__pin_{maps,programs} should conform to those requirements
> > too. Of course, all paths should be overridable similarly to the
> > current implementation.
>
> I actually think that bpf_object__pin_maps and
> bpf_object__pin_programs should be removed.
> bpf_object__pin()/bpf_object__unpin() and then per-map and per-program
> API to control their pinning parameters should be enough to handle all
> the cases.
>

Sure. I personally couldn't find any usecase for exposing them, and if
there is no such one then I am totally okay with that.

> >
> > Regarding implementation, 1.c. will already be satisfied by the
> > current implementation (after the program name pinning path will be
> > changed, since both map names and function names are unique inside a
> > single object).
>
> That's going to change with BPF static linking. I'm thinking about
> supporting static maps, i.e., maps visible within a single BPF .o
> file, but still visible to outside world. At that point, each .o file
> should be able to have conflicting map name, just as you'd expect to
> have conflicting static variables and static functions. I haven't
> thought yet all that is going to be expose  to user-space, though.
>
> > For 1.a and 1.b, I think that bpf_object__pin should produce the
> > following directory layout:
> >
> > <obj_name>
> > =E2=94=9C=E2=94=80=E2=94=80 maps
> > =E2=94=82      =E2=94=94=E2=94=80=E2=94=80 <map_name>
> > =E2=94=94=E2=94=80=E2=94=80 programs
> >         =E2=94=94=E2=94=80=E2=94=80 <program_name>
> >
> > If we decide that the requirements should apply to the specific
> > bpf_object__pin_<type>s variants, then each will produce
> >
> > <obj_name>
> > =E2=94=94=E2=94=80=E2=94=80 <type>s (i.e. maps, programs)
> >         =E2=94=94=E2=94=80=E2=94=80 <name>
> >
> > It may be better to put all pinned objects under a objects/ directory
> > too, I am not sure about that.
>
> seems a bit of an overkill, first-level directory for an object seems nic=
e
>
> >
> > As a last point, I think that it will be nice to have a way to pin a
> > bpf_object_skeleton. This will be an improvement over the current
> > bpf_object__pin since skeletons keep track of attached links.
>
> Hm.. that's the first time this comes up. You mean that all the
> created bpf_links (stored inside skel->links) will be pinned in such a
> case? Those links would probably go under <obj_name/links/ directory,
> right? Would we then need to generate something like
> my_skeleton__load_pinned(), which would be called instead of
> my_skeleton__load()?
>

Yes, something like that.

> >
> > There are more use cases I am not familiar with for sure, so I would
> > like to hear other's opinions and comments.
>
> Yes, absolutely, I'd like to hear some more use cases as well.
>
> I think we need to discuss more on how to manage pinning settings for
> maps (including .data, .rodata, etc) and programs. Another aspect that
> is rarely discussed but is important is compatibility and
> upgradeability. I.e., what if pinned map is not exactly the same as
> the one you expect in your BPF code (e.g., map value size increased,
> etc). This is especially important for .data, .rodata special maps, as
> BPF program code will reference variables through compiled-in offsets.
> For such cases we'd need to validate that all expected/used variables
> are still at the same place and have the same (or compatible?) sizes.
>
> In short, there is a lot more subtlety to pinning that meets the eye,
> which is why I hope that more people will get involved in the
> discussion. I personally never had a use for pinning, so for me it's
> hard to judge what's important in practice. But I do see a lot of
> ambiguity and potential problems with re-using BPF maps and BPF
> programs :)
