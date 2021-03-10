Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23166333F64
	for <lists+bpf@lfdr.de>; Wed, 10 Mar 2021 14:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234985AbhCJNhf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Mar 2021 08:37:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:58594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233859AbhCJNhF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Mar 2021 08:37:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 659DA64FD6;
        Wed, 10 Mar 2021 13:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615383424;
        bh=BhjsV9O/Cb++gTnIBjc2l4D0WTs6uHc/AE5awQZUoYg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IHToW6IGSL79SQpPRM2ToX7jZnwI1z3kEGhHWeZ1p+g0MdqdZ0VTLRwfWs+jUvA8N
         i/dxaloQNGGbPwEmhxhXat+hPB9TIhz8vXxREWPZSgtYjuHFD0cNi3brJfzhn1mQWy
         oGzg6ZVK2g5hVizTj/i+ODgUhVQtx9dNzM3WWoCf9sgoZKS1wIRpAMMm7mZcg4e+fk
         VFzlzVN676GzGDZQM9hn3XFiNDHpfA0qAfllPq9t//9Lu7c141CyCoDr6fvlpRrXLu
         6ztYL5h1IfnJvPAkWH9iHbIB94WqXmp5sLDQxUa4tNceGAijVlUTYfGDvrHomifQ7y
         5e3jVOLDS66QA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BF21540647; Wed, 10 Mar 2021 10:37:01 -0300 (-03)
Date:   Wed, 10 Mar 2021 10:37:01 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH dwarves v2] btf: Add support for the floating-point types
Message-ID: <YEjLfbBQSxiWQMLD@kernel.org>
References: <20210308235913.162038-1-iii@linux.ibm.com>
 <YEdglMDZvplD6ELk@kernel.org>
 <CAEf4BzaN0XwrAaTNe4TojT8UfStvGUfQSJuSQ8CcMtLAgOu9iw@mail.gmail.com>
 <051e4d6b000af07cc65a8dc70f4589fa3bd4be78.camel@linux.ibm.com>
 <CAEf4BzZo4DJJgB57wrkDZCzBGf876ixZBjQrJE4XM_y7OTDKKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZo4DJJgB57wrkDZCzBGf876ixZBjQrJE4XM_y7OTDKKQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Tue, Mar 09, 2021 at 08:14:50PM -0800, Andrii Nakryiko escreveu:
> On Tue, Mar 9, 2021 at 1:57 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
> > On Tue, 2021-03-09 at 13:37 -0800, Andrii Nakryiko wrote:
> > > On Tue, Mar 9, 2021 at 3:48 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > > Em Tue, Mar 09, 2021 at 12:59:13AM +0100, Ilya Leoshkevich escreveu:
> > > TBH, I think it's not exactly right to call out libbpf version
> > > here.  It's BTF "version" (if we had such a thing) that determines
> > > the set of supported BTF kinds. There could be other libraries
> > > that might want to parse BTF. So I don't know what this should be
> > > called, but libbpf_compat is probably a wrong name for it.

> > BTF version seems to exist: btf_header.version. Should we maybe bump
> > this?
 
> That seems excessive. If the kernel doesn't use FLOATs, then no one
> would even notice a difference. While if we bump this version, then
> everything will automatically become incompatible.

> > > If we do want to teach pahole to not emit some parts of BTF, it
> > > should
> > > probably be a set of BPF features, not some arbitrary library
> > > versions.

> > I thought about just adding --btf-allow-floats, but if new features
> > will be added in the future, the list of options will become unwieldy.
> > So I thought it would be good to settle for something that increases
> > monotonically.
 
> BTF_KIND_FLOAT is the first extension in a long while. I'd worry about
> the proliferation of new options when we actually see some proof of
> that being a problem in practice.

I tend to agree, Ilya, can you rework the patch in that direction?
Something like --encode-btf-kind-float that starts disabled or other
suitable name?

- Arnaldo
