Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5887E41AA9D
	for <lists+bpf@lfdr.de>; Tue, 28 Sep 2021 10:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239292AbhI1IcQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Sep 2021 04:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235918AbhI1IcP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Sep 2021 04:32:15 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5829FC061575
        for <bpf@vger.kernel.org>; Tue, 28 Sep 2021 01:30:36 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id i25so89805315lfg.6
        for <bpf@vger.kernel.org>; Tue, 28 Sep 2021 01:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dLOJwjVQWlUcK4hUa0u/Pn1wB5WqEO47ZAo2w3mowAE=;
        b=JXPC7S0LvZB7KMJ2i7LqrO7qI/bXt4Z7bKJo8ZqLYDVoc9MXDEQ0svPc6A260HmxwR
         EtmY+d8lK0Gw6vdXUA9kqmIR0sCAIkgHk9DonayHNMoQP31onJe5vQW58R2zHfQ2vkIk
         oO2XY+d4gEHzAUF8rMmOhLD2Gbrwctx3i+RfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dLOJwjVQWlUcK4hUa0u/Pn1wB5WqEO47ZAo2w3mowAE=;
        b=1qjxVkZVTPPvhxJRGnNgvDpBiai7hVmpA+8pvBFuvLRkV1I6ew8DnNorzcZOy9Y2HO
         W4AxIeetTpps98ucq02kZzjsfaumhAor035k58Diz1sdLOWCqhJIxtIPU1L0JESha/qn
         M5vmsqYXBl0tJDu+g7Qhlcf3iqhIPTcJnYHd9g1ZZEtZbDEINWwU69H5UClKZi+KHd3f
         NuKig+8uEx5fgC3evEWw1bGT1w+pAseukorw8GLMibuqMHWg3M6H201+ie7hqbGahbVI
         8NwWf+OXAffa4VjWAwE+TtrskSgLEwwbGoCc8JtzxBEf21QnDdepOKmsawvDkOw0GeVc
         KjNw==
X-Gm-Message-State: AOAM530djct3uY/uwAU3fQks0oUKivy0fWpHFxgx9bF1FD7eov4TVnM7
        dYu/mSHx0nw/tm4YFOco+ZyUmeVCE4KdlPs024M6zA==
X-Google-Smtp-Source: ABdhPJwKMUMU994vfeJhWBpKYonrTuAtw24LkaobIcN1ePs1+f2VouohVcsv30l3rlAzjDGLX/CDgBFI0iK23yZ89Vc=
X-Received: by 2002:a2e:a550:: with SMTP id e16mr4487857ljn.2.1632817834664;
 Tue, 28 Sep 2021 01:30:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210917215721.43491-1-alexei.starovoitov@gmail.com>
 <CACAyw98puHhO7f=OmEACNaje0DvVdpS7FosLY9aM8z46hy=7ww@mail.gmail.com>
 <20210924231313.jbg4cs3wk63ii54a@ast-mbp.lan> <CACAyw99aR5sfGZ5OQuRrz6Rt+sOkm6B2vC=JfK1tPqdf6961tw@mail.gmail.com>
 <20210927165031.hfv3kf43cxrbc3rb@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20210927165031.hfv3kf43cxrbc3rb@ast-mbp.dhcp.thefacebook.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Tue, 28 Sep 2021 09:30:23 +0100
Message-ID: <CACAyw98=qk_zoAP_J4eG3p_OhHJgU3-6ae+Xzrd4h6tjdm_GCQ@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 00/10] bpf: CO-RE support in the kernel.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        mcroce@microsoft.com, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 27 Sept 2021 at 17:50, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Sep 27, 2021 at 05:12:15PM +0100, Lorenz Bauer wrote:
> > On Sat, 25 Sept 2021 at 00:13, Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Thu, Sep 23, 2021 at 12:33:58PM +0100, Lorenz Bauer wrote:
> > > >
> > > > Some questions:
> > > > * How can this handle kernels that don't have built-in BTF? Not a
> > > > problem for myself, but some people have to deal with BTF-less distro
> > > > kernels by using pahole to generate external BTF from debug symbols.
> > > > Can we accommodate that?
> > >
> > > I think so, but it probably should be done as a generic feature:
> > > "populate kernel BTF".
> > > When kernel wasn't compiled with BTF there could be a way to
> > > populate it with such. Just like we do sys_bpf(BTF_LOAD)
> > > for program's BTF we can allow populating vmlinux BTF this way.
> > > Unlike builtin BTF it wouldn't be trusted for certain verifier assumptions,
> > > but better than nothing and more convenient than specifying BTF file
> > > on a side for every bpf prog load with traditional libbpf style.
> >
> > From my POV we already have an API for external BTF (and I think
> > libbpf does too?) but would need a new API for "load kernel BTF".
> > Global state like this also doesn't work well for several individual
> > processes. Imagine multiple programs on the system trying to each
> > replace the kernel BTF, how would that work? Which one wins?
>
> The kernel BTF can be only one, of course.
> I don't expect progs to update the kernel BTF when they start.
> It's more of the admin/chef job when kernel boots.
> Only for the cases when kernel somehow was compiled without BTF.
>
> > Being
> > able to give my own fd for kernel BTF circumvents all those problems
> > and seems much cleaner to me.
>
> You mean to pass kernel BTF's fd to the kernel?
> It's doable, but I don't quite see the operational side of it.
> If progs have to carry both their BTF and kernel BTF why would
> they need CO-RE at all? If they were compiled with given kernel BTF
> there is no need to adjust offsets for the given host.
> I suspect I simply don't understand your use case :)

This is the "distro ships without BTF" case that the aqua sec folks
have been grappling with, and for which btfhub is a solution. If the
distro disables BTF they are unlikely to perform this "admin" job in
the first place. So whose responsibility is it to load that BTF?
Currently it falls on the developers of the user space tooling to
provide alternative BTF. Only allowing a single replacement BTF makes
this difficult.

Here is why:
* Since external BTF is a thing, loaders today have to provide a way
to relocate against external BTF in a non-standard location. This
means loading the file from disk and then performing CO-RE using that
info.
* Users of the loader build a btfhub integration (or similar) and
provide a path to the external BTF during load. They do this because
they will have to support legacy kernels for years to come.
* Under my proposal, a loader can detect whether in-kernel CO-RE is
supported, load the BTF provided by the user into the kernel, and pass
that fd to PROG_LOAD.
* This is transparent to the user: they keep using their existing BTF
but get the benefit of canonical CO-RE resolution.

We don't have to introduce a new loader-side API to deal with this
situation. We also don't have to deal with a global resource that is
subject to the whims of the distro.

Lorenz

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
