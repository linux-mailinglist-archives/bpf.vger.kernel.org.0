Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B00641B3F7
	for <lists+bpf@lfdr.de>; Tue, 28 Sep 2021 18:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241768AbhI1Qgt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Sep 2021 12:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241763AbhI1Qgs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Sep 2021 12:36:48 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384A4C06161C
        for <bpf@vger.kernel.org>; Tue, 28 Sep 2021 09:35:09 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id h3so21748610pgb.7
        for <bpf@vger.kernel.org>; Tue, 28 Sep 2021 09:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=C2sAlPF45PgZcEsfmljiv2BWUxOmDZcVfU7eK0NE+fA=;
        b=jT1h9E0Pj5JlU1/5/GeD0Hc9YgEAHmngLq5zr3ZBd058Q1ehNyewpAuPahr/KjbIwk
         sv4cKVFnhvjWvpzoJOQtEUSyQCEfIoCns7MQG7CD3QNKb9lLDMQopL0l8Wf3i4SPEW8t
         fSr7wEMYImb9aFH6bpku+HUHUr+7bN8OFtUuRvbiF52wBi8h0LGog+a00rg0pLG2bp2S
         5nXCmVFE1HOOhabYkN7b7OuONPsuwXUo7rS0ee9P/KcvcHnRDdCsIipGusDkD+dKieCa
         TqGLHiCDEP6zZNQKH/BL/JrnUSLrPQUuvj0PDYAGSp3D/6T44WW3u2iwGS7ADHxatrdE
         5cxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C2sAlPF45PgZcEsfmljiv2BWUxOmDZcVfU7eK0NE+fA=;
        b=GMspTX81y1MZrf2vxuretXSAHMOKEKh7epKRb3jmwPPsXiGaT9+jlxS1AP4upoO09I
         TvaxdmE6FwXCRUyTVANijqQmGGfv6dt90mfBJHhGI9u6OqYhq80MaJg2ThsUGCjeeru3
         EzuGu7DeCYlErM+Cub05MDccjMxH4hnCNsYkKe8qtvr/wgIMbGxrwa7j29s/NrW+z1Gk
         5djKVkyW16ncGW0GsMp75NzDsXUWZABgRWHdw7DG7kpds11J8ifqFJsoVihimor9Rt/9
         5A5pMGO/tWD3RkFmgfjVUmP1KZrSpZaLs3zIcRjppff7m5Y7W1DcP3wYn1PdhhUwrPwt
         a8zg==
X-Gm-Message-State: AOAM531hScsqgOyypUqK7/n7PvDBvhM28OykIgKRrPkeWwQsoVk5OkDa
        xNWCobC1+9eDrPK25r7Swl0KynvieK8=
X-Google-Smtp-Source: ABdhPJzt+OSpnHpTja/c/UZRj2VM2cne9u0WiRWriRmM6oXfQsdVjsWXqfIdQj3h1LvryWZNJDXQoQ==
X-Received: by 2002:a62:6383:0:b0:447:7fc:3eee with SMTP id x125-20020a626383000000b0044707fc3eeemr6554091pfb.86.1632846908597;
        Tue, 28 Sep 2021 09:35:08 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:500::6:e195])
        by smtp.gmail.com with ESMTPSA id y3sm22617955pge.44.2021.09.28.09.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 09:35:08 -0700 (PDT)
Date:   Tue, 28 Sep 2021 09:35:06 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        mcroce@microsoft.com, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH RFC bpf-next 00/10] bpf: CO-RE support in the kernel.
Message-ID: <20210928163506.uji2h54evv3g4tlb@ast-mbp.dhcp.thefacebook.com>
References: <20210917215721.43491-1-alexei.starovoitov@gmail.com>
 <CACAyw98puHhO7f=OmEACNaje0DvVdpS7FosLY9aM8z46hy=7ww@mail.gmail.com>
 <20210924231313.jbg4cs3wk63ii54a@ast-mbp.lan>
 <CACAyw99aR5sfGZ5OQuRrz6Rt+sOkm6B2vC=JfK1tPqdf6961tw@mail.gmail.com>
 <20210927165031.hfv3kf43cxrbc3rb@ast-mbp.dhcp.thefacebook.com>
 <CACAyw98=qk_zoAP_J4eG3p_OhHJgU3-6ae+Xzrd4h6tjdm_GCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACAyw98=qk_zoAP_J4eG3p_OhHJgU3-6ae+Xzrd4h6tjdm_GCQ@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 28, 2021 at 09:30:23AM +0100, Lorenz Bauer wrote:
> On Mon, 27 Sept 2021 at 17:50, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Sep 27, 2021 at 05:12:15PM +0100, Lorenz Bauer wrote:
> > > On Sat, 25 Sept 2021 at 00:13, Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Thu, Sep 23, 2021 at 12:33:58PM +0100, Lorenz Bauer wrote:
> > > > >
> > > > > Some questions:
> > > > > * How can this handle kernels that don't have built-in BTF? Not a
> > > > > problem for myself, but some people have to deal with BTF-less distro
> > > > > kernels by using pahole to generate external BTF from debug symbols.
> > > > > Can we accommodate that?
> > > >
> > > > I think so, but it probably should be done as a generic feature:
> > > > "populate kernel BTF".
> > > > When kernel wasn't compiled with BTF there could be a way to
> > > > populate it with such. Just like we do sys_bpf(BTF_LOAD)
> > > > for program's BTF we can allow populating vmlinux BTF this way.
> > > > Unlike builtin BTF it wouldn't be trusted for certain verifier assumptions,
> > > > but better than nothing and more convenient than specifying BTF file
> > > > on a side for every bpf prog load with traditional libbpf style.
> > >
> > > From my POV we already have an API for external BTF (and I think
> > > libbpf does too?) but would need a new API for "load kernel BTF".
> > > Global state like this also doesn't work well for several individual
> > > processes. Imagine multiple programs on the system trying to each
> > > replace the kernel BTF, how would that work? Which one wins?
> >
> > The kernel BTF can be only one, of course.
> > I don't expect progs to update the kernel BTF when they start.
> > It's more of the admin/chef job when kernel boots.
> > Only for the cases when kernel somehow was compiled without BTF.
> >
> > > Being
> > > able to give my own fd for kernel BTF circumvents all those problems
> > > and seems much cleaner to me.
> >
> > You mean to pass kernel BTF's fd to the kernel?
> > It's doable, but I don't quite see the operational side of it.
> > If progs have to carry both their BTF and kernel BTF why would
> > they need CO-RE at all? If they were compiled with given kernel BTF
> > there is no need to adjust offsets for the given host.
> > I suspect I simply don't understand your use case :)
> 
> This is the "distro ships without BTF" case that the aqua sec folks
> have been grappling with, and for which btfhub is a solution. If the
> distro disables BTF they are unlikely to perform this "admin" job in
> the first place. So whose responsibility is it to load that BTF?
> Currently it falls on the developers of the user space tooling to
> provide alternative BTF. Only allowing a single replacement BTF makes
> this difficult.

There is only one BTF that matches the kernel. If one was buggy
(due to pahole/compiler issue) it would be replaced with the fixed one.
I can see the case where two vmlinux BTFs would be used for testing.
Like the kernel compiled with clang produces one BTF and the kernel
compiled with gcc->pahole produces another BTF, but the vmlinux would
be different too. So the admins/users should be using BTF that
matches the kernel.

> Here is why:
> * Since external BTF is a thing, loaders today have to provide a way
> to relocate against external BTF in a non-standard location. This
> means loading the file from disk and then performing CO-RE using that
> info.
> * Users of the loader build a btfhub integration (or similar) and
> provide a path to the external BTF during load. They do this because
> they will have to support legacy kernels for years to come.
> * Under my proposal, a loader can detect whether in-kernel CO-RE is
> supported, load the BTF provided by the user into the kernel, and pass
> that fd to PROG_LOAD.
> * This is transparent to the user: they keep using their existing BTF
> but get the benefit of canonical CO-RE resolution.
> 
> We don't have to introduce a new loader-side API to deal with this
> situation. We also don't have to deal with a global resource that is
> subject to the whims of the distro.

I agree with all of the above. It's easy to add 'target_vmlinux_btf_fd'
to PROG_LOAD and let CO-RE in the kernel use that, but the kernel
has dynamically loaded kernel modules and it does search through them.
They will not be supported in such case. I think it's an ok limitation.
