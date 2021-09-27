Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63F4A4199AB
	for <lists+bpf@lfdr.de>; Mon, 27 Sep 2021 18:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235639AbhI0QwN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Sep 2021 12:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235656AbhI0QwM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Sep 2021 12:52:12 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2FB6C061714
        for <bpf@vger.kernel.org>; Mon, 27 Sep 2021 09:50:34 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id bb10so12209302plb.2
        for <bpf@vger.kernel.org>; Mon, 27 Sep 2021 09:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nFWR2qnqWqoMjsl7kxCKNIhe2F7pM5dxSeoyYxy4P4M=;
        b=TMjzz/re0wDJr1opoocmapndfGN/a1elFc7v7iOHoPSTLAz8ab9+ml7cgCf1IeTnUo
         fs51tyLo342EUoW6fbRnU4IOIUOAtOKNuvkMjjMTzW9SQUnBgPvreJdAurQXeYPlwuaw
         rnYK8aqElfc1nEfXvD9oLtqCXsfhsyHM4X6ZtLScmHCmxnSNRQd57qBdyiCjKuKcgv1C
         e0mP+qUciaRm7UxYOIKKDUC5x8FtEX5wNFm4zkmsM/Xvk3zz5C0FPztZabfiKEpyK43m
         AeyBYhmxB+mBBATGDHAJV2f5U5cUwpb+sbXsqSNBhDMdUOzPyPoryaYOHwEqQrQgSruF
         FCSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nFWR2qnqWqoMjsl7kxCKNIhe2F7pM5dxSeoyYxy4P4M=;
        b=ceeTsBN2gs5Dym2IM/9Xc74vK3jxQDnQEdQKnl0D65nwehrNMRh08blL4b3RWEW7Af
         mEcXMgGyr2KOE72NWz8485jE/vQqzYdiGKcCVWkeR6mFz68R1r6vr15l2vAscO/goMDf
         6LfigqRYo/dKYzH2zKjGhBJl5LZ2X1iAqdeaSjzRhwY0pVubg0ua+GQepLHJDxBJa0Dg
         hIkT/nq8jZFm73wsmMP/kL6bQmb9YVesmcCN4gsEf2+2DgJUqFEltxfESCy9pV2m7+lc
         puArTHCQ3yQed7zJZu9R8WZZsYjT28K37oov0J+eYqwGiBg/m0khgjZmOPpxRs53xMXq
         AuDA==
X-Gm-Message-State: AOAM532oyOTVJ/uL+h/1Jx61UEvM99buhEpl4sWmFb93SQ1x1fuXcX4c
        QTd5qqt7aNtlSRkrfdx4LpQ=
X-Google-Smtp-Source: ABdhPJxfgLIfABRGFsREk36K/xjYmlMJziXvfUuMh6sCaW8Gz0vsyeK0Omftadxp9PCx6W1J/qBCYg==
X-Received: by 2002:a17:90b:4f45:: with SMTP id pj5mr60910pjb.19.1632761433976;
        Mon, 27 Sep 2021 09:50:33 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:6cbb])
        by smtp.gmail.com with ESMTPSA id k7sm16362398pfk.59.2021.09.27.09.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 09:50:33 -0700 (PDT)
Date:   Mon, 27 Sep 2021 09:50:31 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        mcroce@microsoft.com, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH RFC bpf-next 00/10] bpf: CO-RE support in the kernel.
Message-ID: <20210927165031.hfv3kf43cxrbc3rb@ast-mbp.dhcp.thefacebook.com>
References: <20210917215721.43491-1-alexei.starovoitov@gmail.com>
 <CACAyw98puHhO7f=OmEACNaje0DvVdpS7FosLY9aM8z46hy=7ww@mail.gmail.com>
 <20210924231313.jbg4cs3wk63ii54a@ast-mbp.lan>
 <CACAyw99aR5sfGZ5OQuRrz6Rt+sOkm6B2vC=JfK1tPqdf6961tw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACAyw99aR5sfGZ5OQuRrz6Rt+sOkm6B2vC=JfK1tPqdf6961tw@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 27, 2021 at 05:12:15PM +0100, Lorenz Bauer wrote:
> On Sat, 25 Sept 2021 at 00:13, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu, Sep 23, 2021 at 12:33:58PM +0100, Lorenz Bauer wrote:
> > >
> > > Some questions:
> > > * How can this handle kernels that don't have built-in BTF? Not a
> > > problem for myself, but some people have to deal with BTF-less distro
> > > kernels by using pahole to generate external BTF from debug symbols.
> > > Can we accommodate that?
> >
> > I think so, but it probably should be done as a generic feature:
> > "populate kernel BTF".
> > When kernel wasn't compiled with BTF there could be a way to
> > populate it with such. Just like we do sys_bpf(BTF_LOAD)
> > for program's BTF we can allow populating vmlinux BTF this way.
> > Unlike builtin BTF it wouldn't be trusted for certain verifier assumptions,
> > but better than nothing and more convenient than specifying BTF file
> > on a side for every bpf prog load with traditional libbpf style.
> 
> From my POV we already have an API for external BTF (and I think
> libbpf does too?) but would need a new API for "load kernel BTF".
> Global state like this also doesn't work well for several individual
> processes. Imagine multiple programs on the system trying to each
> replace the kernel BTF, how would that work? Which one wins? 

The kernel BTF can be only one, of course.
I don't expect progs to update the kernel BTF when they start.
It's more of the admin/chef job when kernel boots.
Only for the cases when kernel somehow was compiled without BTF.

> Being
> able to give my own fd for kernel BTF circumvents all those problems
> and seems much cleaner to me.

You mean to pass kernel BTF's fd to the kernel?
It's doable, but I don't quite see the operational side of it.
If progs have to carry both their BTF and kernel BTF why would
they need CO-RE at all? If they were compiled with given kernel BTF
there is no need to adjust offsets for the given host.
I suspect I simply don't understand your use case :)
