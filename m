Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2FC337B55
	for <lists+bpf@lfdr.de>; Thu, 11 Mar 2021 18:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbhCKRrT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Mar 2021 12:47:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:47492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229490AbhCKRqv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Mar 2021 12:46:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E931764E77;
        Thu, 11 Mar 2021 17:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615484811;
        bh=k9aZEfwcMo7lmOg49WEreVY2aaFbpcrHQrJJuLNBukw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s+zvYqOiio5XXMyNE3sGp9SC58VFcFQetoZ9tdMsfcKrz/irLJDgoYeHVywrdXaZq
         /9OyGkHYb1P+1GtPDJPlNYjOc5D2kidpI/OrhBfkzoH0su49qvapO4vXFKk9ATVDE9
         +cQkTFFH00AoV0bU+lySNeUjbFUp39FQZ2DppCItNxKbs5N6rQreBwAlPZhoTwxHBm
         7GaU7WcMvSPhRbnpUpuwb6wLaGsB8gJ4uIVXSRIAhuPblu1zv4oWwrmr+0U5UDzykl
         4132MjmjbnmKAwD0rpo5YXXbUPLyxizrY+LEY6NijDHKbEmXCdMlQh8nHJ7qz7PllQ
         4IIN/VFvfN+Wg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6D98940647; Thu, 11 Mar 2021 14:46:47 -0300 (-03)
Date:   Thu, 11 Mar 2021 14:46:47 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andrii Nakryiko <andrii@kernel.org>, dwarves@vger.kernel.org,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v4 dwarves] btf: Add support for the floating-point types
Message-ID: <YEpXh4v79FHklsHx@kernel.org>
References: <20210310201550.170599-1-iii@linux.ibm.com>
 <CAEf4BzY0++YuU7+a3vSfWWZNLoov7mu7Q1ty4FqqH78gkqgqQw@mail.gmail.com>
 <ff68a62e776ce9e459bece7ae87cc53573500a50.camel@linux.ibm.com>
 <CAEf4Bzbyugfb2RkBkRuxNGKwSk40Tbq4zAvhQT8W=fVMYWuaxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4Bzbyugfb2RkBkRuxNGKwSk40Tbq4zAvhQT8W=fVMYWuaxA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Wed, Mar 10, 2021 at 01:35:39PM -0800, Andrii Nakryiko escreveu:
> On Wed, Mar 10, 2021 at 1:02 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
> >
> > On Wed, 2021-03-10 at 12:25 -0800, Andrii Nakryiko wrote:
> > > On Wed, Mar 10, 2021 at 12:16 PM Ilya Leoshkevich <iii@linux.ibm.com>
> > > wrote:
> > > >
> > > > Some BPF programs compiled on s390 fail to load, because s390
> > > > arch-specific linux headers contain float and double types.
> > > >
> > > > Fix as follows:
> > > >
> > > > - Make the DWARF loader fill base_type.float_type.
> > > >
> > > > - Introduce the --btf_gen_floats command-line parameter, so that
> > > >   pahole could be used to build both the older and the newer
> > > > kernels.
> > > >
> > > > - libbpf introduced the support for the floating-point types in
> > > > commit
> > > >   986962fade5, so update the libbpf submodule to that version and
> > > > use
> > > >   the new btf__add_float() function in order to emit the floating-
> > > > point
> > > >   types when not in the compatibility mode.
> > > >
> > > > - Make the BTF loader recognize the new BTF kind.
> > > >
> > > > Example of the resulting entry in the vmlinux BTF:
> > > >
> > > >     [7164] FLOAT 'double' size=8
> > > >
> > > > when building with:
> > > >
> > > >     LLVM_OBJCOPY=${OBJCOPY} ${PAHOLE} -J ${1} --btf_gen_floats
> > > >
> > > > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > > > ---
> > >
> > > So it looks good to me overall, but here's the question about using
> > > this --btf-gen-floats flag from link-vmlinux.sh script. If you
> > > specify
> > > that flag for an old pahole, it will probably error out, right? So
> > > that means we'll need to do feature detection for pahole supported
> > > features, right?..
> >
> > I was planning to just bump the version in this check:
> >
> >     if [ "${pahole_ver}" -lt "116" ]; then
> 
> No-no-no, we can't just arbitrarily say that the minimal pahole
> version is now 1.21, while 1.16 would work just fine in almost all
> cases on almost all architectures.
> 
> >
> > But we could also keep allowing 1.16-1.20 and pass the new flag on
> > 1.21+ only.
> >
> > What do you think?
> 
> I think we'll have to do the extra check. I'd also add something like
> --btf-gen-all, that would turn on all the supported BTF features. So
> that people that generate BTF for kernels externally (e.g., for old
> kernels to support BPF CO-RE), could just do --btf-gen-all, instead of
> potentially longer list of all the BTF optional subsets
> (--btf-gen-floats --btf-gen-somemore --btf-gen-morecool etc). That
> doesn't have to happen in this patch, of course.
> 
> So with what we have now:
> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>

Ok, so I'm taking this v4, collecting Andrii's Acked-by and waiting for
the --btf-gen-all patch as a followup,

Thanks,

- Arnaldo
