Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4A933AAF5A
	for <lists+bpf@lfdr.de>; Thu, 17 Jun 2021 11:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbhFQJMS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Jun 2021 05:12:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49979 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231444AbhFQJMS (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 17 Jun 2021 05:12:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623921010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QyqFtiU3z2ei2H0zxrEJzHtN9ZSY0dHGKYbBjpd8sPw=;
        b=hMlrm14ytYHRZZhm4RbPq7n5Ll3z71sq6/0qbOCaGCi6W0OTWeKinFhQpKod6+/yPn+YTF
        t9MfY+1v6NEsJqLVWAG67fm8NUCpfl0oztu1biJYhTa+KqY/Rcy3wFii6hlGYYVqFJZVxX
        UyDcH7X5sFPMTQ6EI9olZRjcrjzFfh4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-8uToIdxSOe20thON1XBFng-1; Thu, 17 Jun 2021 05:10:07 -0400
X-MC-Unique: 8uToIdxSOe20thON1XBFng-1
Received: by mail-ej1-f72.google.com with SMTP id hz18-20020a1709072cf2b02903fbaae9f4faso1920500ejc.4
        for <bpf@vger.kernel.org>; Thu, 17 Jun 2021 02:10:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QyqFtiU3z2ei2H0zxrEJzHtN9ZSY0dHGKYbBjpd8sPw=;
        b=Xo0SZStcYw+wR2yferUyG1UNgp1nc/g5OyjxbkkI7eeYvvLVA0Wde7jAtn3QsuhOJA
         d3dqaqHZR2mAoBULUlRru3g8dTa/u3h27774cTP3qZ/VrqdWAfcP7GF6LDAmlvJaW4aZ
         6Yf+1rJU3F+7pqLDTtsBn8VzeilO/mkeQIz05ngK+bApRcarHPoQmtftsg9zpb+fgwLM
         Bli69mJXldHuwTT81BZBEK3osr4XtDlAD082lvsXq4nGeJ6w7jdMwdxD1p3bm4U2f5WB
         tfsHfCUh0Ft6EVxRzDVOHeC/bSnkq5PjFdyBcKb9HKNIRsjnwCHMehJfNQB09URUD+hi
         sthA==
X-Gm-Message-State: AOAM532v1dGXU4G7p0W83olIp+n2i/QDkNo4LPhbrAJ0QSo1v+FGKCwj
        yplEbNRmmmb+2ZZUGa/QoWCadzi087ZYEiLyZW4x0EU25uBEKaZ9mgrGNCIbvnk7EZZZ0SnMTlf
        0dxKW1bOr8jHY
X-Received: by 2002:a05:6402:2742:: with SMTP id z2mr5186645edd.66.1623921005894;
        Thu, 17 Jun 2021 02:10:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwsqPA+pMQABzOz379wdXow+Vgr6xo9CA+XItKKC/X7LlnCWm3Ubzs7V/lG6WOU0iNgZ0dxng==
X-Received: by 2002:a05:6402:2742:: with SMTP id z2mr5186618edd.66.1623921005750;
        Thu, 17 Jun 2021 02:10:05 -0700 (PDT)
Received: from krava ([83.240.60.126])
        by smtp.gmail.com with ESMTPSA id m18sm3289941ejx.56.2021.06.17.02.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 02:10:05 -0700 (PDT)
Date:   Thu, 17 Jun 2021 11:10:03 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Tony Ambardar <tony.ambardar@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>, Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Stable <stable@vger.kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Frank Eigler <fche@redhat.com>, Mark Wielaard <mjw@redhat.com>
Subject: Re: [PATCH bpf v1] bpf: fix libelf endian handling in resolv_btfids
Message-ID: <YMsRa3nT4tlzO6DJ@krava>
References: <20210616092521.800788-1-Tony.Ambardar@gmail.com>
 <caf1dcbd-7a07-993c-e940-1b2689985c5a@fb.com>
 <YMopCb5CqOYsl6HR@krava>
 <CAPGftE-CqfycuyTRpFvHwe5kR5gG8WGyLSgdLTat5XnxmqQ3GQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPGftE-CqfycuyTRpFvHwe5kR5gG8WGyLSgdLTat5XnxmqQ3GQ@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jun 16, 2021 at 03:09:13PM -0700, Tony Ambardar wrote:
> On Wed, 16 Jun 2021 at 09:38, Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Wed, Jun 16, 2021 at 08:56:42AM -0700, Yonghong Song wrote:
> > >
> > > On 6/16/21 2:25 AM, Tony Ambardar wrote:
> > > > While patching the .BTF_ids section in vmlinux, resolve_btfids writes type
> > > > ids using host-native endianness, and relies on libelf for any required
> > > > translation when finally updating vmlinux. However, the default type of the
> > > > .BTF_ids section content is ELF_T_BYTE (i.e. unsigned char), and undergoes
> > > > no translation. This results in incorrect patched values if cross-compiling
> > > > to non-native endianness, and can manifest as kernel Oops and test failures
> > > > which are difficult to debug.
> >
> > nice catch, great libelf can do that ;-)
> 
> Funny, I'd actually assumed that was your intention, but I just
> couldn't find where the
> data type was being set, so resorted to this "kludge". While there's a .BTF_ids
> section definition in include/linux/btf_ids.h, there's no means I can
> see to specify
> the data type either (i.e. in the gcc asm .pushsection() options). That approach
> would be cleaner.
> 
> >
> > > >
> > > > Explicitly set the type of patched data to ELF_T_WORD, allowing libelf to
> > > > transparently handle the endian conversions.
> > > >
> > > > Fixes: fbbb68de80a4 ("bpf: Add resolve_btfids tool to resolve BTF IDs in ELF object")
> > > > Cc: stable@vger.kernel.org # v5.10+
> > > > Cc: Jiri Olsa <jolsa@kernel.org>
> > > > Cc: Yonghong Song <yhs@fb.com>
> > > > Link: https://lore.kernel.org/bpf/CAPGftE_eY-Zdi3wBcgDfkz_iOr1KF10n=9mJHm1_a_PykcsoeA@mail.gmail.com/
> > > > Signed-off-by: Tony Ambardar <Tony.Ambardar@gmail.com>
> > > > ---
> > > >   tools/bpf/resolve_btfids/main.c | 3 +++
> > > >   1 file changed, 3 insertions(+)
> > > >
> > > > diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
> > > > index d636643ddd35..f32c059fbfb4 100644
> > > > --- a/tools/bpf/resolve_btfids/main.c
> > > > +++ b/tools/bpf/resolve_btfids/main.c
> > > > @@ -649,6 +649,9 @@ static int symbols_patch(struct object *obj)
> > > >     if (sets_patch(obj))
> > > >             return -1;
> > > > +   /* Set type to ensure endian translation occurs. */
> > > > +   obj->efile.idlist->d_type = ELF_T_WORD;
> > >
> > > The change makes sense to me as .BTF_ids contains just a list of
> > > u32's.
> > >
> > > Jiri, could you double check on this?
> >
> > the comment in ELF_T_WORD declaration suggests the size depends on
> > elf's class?
> >
> >   ELF_T_WORD,                   /* Elf32_Word, Elf64_Word, ... */
> >
> > data in .BTF_ids section are allways u32
> >
> 
> I believe the Elf32/Elf64 refer to the arch since some data structures vary
> between the two, but ELF_T_WORD is common to both, and valid as the
> data type of Elf_Data struct holding the .BTF_ids contents. See elf(5):
> 
>     Basic types
>     The following types are used for  N-bit  architectures  (N=32,64,  ElfN
>     stands for Elf32 or Elf64, uintN_t stands for uint32_t or uint64_t):
> ...
>         ElfN_Word       uint32_t
> 
> Also see the code and comments in "elf.h":
>     /* Types for signed and unsigned 32-bit quantities.  */
>     typedef uint32_t Elf32_Word;
>     typedef uint32_t Elf64_Word;

ok

> 
> > I have no idea how is this handled in libelf (perhaps it's ok),
> > but just that comment above suggests it could be also 64 bits,
> > cc-ing Frank and Mark for more insight
> >
> 
> One other area I'd like to confirm is with section compression. Is it safe
> to ignore this for .BTF_ids? I've done so because include/linux/btf_ids.h
> appears to define the section with SHF_ALLOC flag set, which is
> incompatible with compression based on "libelf.h" comments.

not sure what you mean.. where it wouldn't be safe?
what workflow/processing

thanks,
jirka

