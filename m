Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C38673349DD
	for <lists+bpf@lfdr.de>; Wed, 10 Mar 2021 22:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbhCJVgW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Mar 2021 16:36:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbhCJVfy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Mar 2021 16:35:54 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93AC2C061574;
        Wed, 10 Mar 2021 13:35:54 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id 133so19455004ybd.5;
        Wed, 10 Mar 2021 13:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KHehzNoQna3AztT9ET1AQFNt/+LUL+Hb2dYWXL76tYU=;
        b=XJDMgh1cf2oexfeAaSS6oWc2vhEPbsK2jOO5hbldWGnihSq77ME/hGYBo//7JNlA9e
         r5lDWJiP3SUcj0NidT/1JXANX7fXsr7Jm82RvIUVcVs5YXPg4WEcqM9vKgOotfO8NUXl
         pxye08qUBtLE7yuakEMuAhlvhi99Mr/SUTBmXm4TvQrI9504I4A4tR3BgMKx+j42KV5y
         F24lbOpZmz3Fx3Sp7+gyutkGWrielO7AsFM6ZsLDLBaZDsqAmk4kAz35S9uHRIfigEY0
         UUCXqbnEsaX4int3RIKJlKPO0927QlGb22B/0cdSNSN+2XVCYt52pwHGfyC/++RCWC5w
         hPQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KHehzNoQna3AztT9ET1AQFNt/+LUL+Hb2dYWXL76tYU=;
        b=i0WXUZ3f7ZGI0UNjmMATqabe8ZtpRBF25DaRBElFbf5ZQtap3pV5CChkep/80pnCrg
         lz2rsGCAlgDR+V31CkKYpM/u+03llktgxjvLjDWUKd8cDVG9htZLb+pwByXzNCpOQ0WE
         XBKSEN2dKCKHOOkzmdVoBj/C4kx3DybspQFczrpXfUkTeC/2SmYKuve8WdoD5S9chqdN
         uEcZf89uoNOtERFTu7pG9Xj4/xaLASkr5T8rk0Kem2MHZZ1nFQiGGya9+KX6UmdO+uqv
         zE7u+egJnXH5tORHIADFIYx++Ofpenr9yyAYvVzkPxkwL5jmOLzg5ktgOjN83NeinO+N
         qdlA==
X-Gm-Message-State: AOAM533f7tw/GB1xWqSwAFE1C2fdDDappaqRAdDyDB/2qhoVEQ9t03y/
        cR/oaZw1XIcCAX93enAeCuWY0A1F9irqjCyt3oQ=
X-Google-Smtp-Source: ABdhPJyoI7VC1x6/YGWqGDJ7cGpac0lHIJw5hiHoXCsKEBTvDm3O9THK1nAUusLChxIHi+8vyu3Xd2jFl6tDmHoNA1Q=
X-Received: by 2002:a25:874c:: with SMTP id e12mr6424021ybn.403.1615412153605;
 Wed, 10 Mar 2021 13:35:53 -0800 (PST)
MIME-Version: 1.0
References: <20210310201550.170599-1-iii@linux.ibm.com> <CAEf4BzY0++YuU7+a3vSfWWZNLoov7mu7Q1ty4FqqH78gkqgqQw@mail.gmail.com>
 <ff68a62e776ce9e459bece7ae87cc53573500a50.camel@linux.ibm.com>
In-Reply-To: <ff68a62e776ce9e459bece7ae87cc53573500a50.camel@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 10 Mar 2021 13:35:39 -0800
Message-ID: <CAEf4Bzbyugfb2RkBkRuxNGKwSk40Tbq4zAvhQT8W=fVMYWuaxA@mail.gmail.com>
Subject: Re: [PATCH v4 dwarves] btf: Add support for the floating-point types
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andrii Nakryiko <andrii@kernel.org>, dwarves@vger.kernel.org,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 10, 2021 at 1:02 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> On Wed, 2021-03-10 at 12:25 -0800, Andrii Nakryiko wrote:
> > On Wed, Mar 10, 2021 at 12:16 PM Ilya Leoshkevich <iii@linux.ibm.com>
> > wrote:
> > >
> > > Some BPF programs compiled on s390 fail to load, because s390
> > > arch-specific linux headers contain float and double types.
> > >
> > > Fix as follows:
> > >
> > > - Make the DWARF loader fill base_type.float_type.
> > >
> > > - Introduce the --btf_gen_floats command-line parameter, so that
> > >   pahole could be used to build both the older and the newer
> > > kernels.
> > >
> > > - libbpf introduced the support for the floating-point types in
> > > commit
> > >   986962fade5, so update the libbpf submodule to that version and
> > > use
> > >   the new btf__add_float() function in order to emit the floating-
> > > point
> > >   types when not in the compatibility mode.
> > >
> > > - Make the BTF loader recognize the new BTF kind.
> > >
> > > Example of the resulting entry in the vmlinux BTF:
> > >
> > >     [7164] FLOAT 'double' size=8
> > >
> > > when building with:
> > >
> > >     LLVM_OBJCOPY=${OBJCOPY} ${PAHOLE} -J ${1} --btf_gen_floats
> > >
> > > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > > ---
> >
> > So it looks good to me overall, but here's the question about using
> > this --btf-gen-floats flag from link-vmlinux.sh script. If you
> > specify
> > that flag for an old pahole, it will probably error out, right? So
> > that means we'll need to do feature detection for pahole supported
> > features, right?..
>
> I was planning to just bump the version in this check:
>
>     if [ "${pahole_ver}" -lt "116" ]; then

No-no-no, we can't just arbitrarily say that the minimal pahole
version is now 1.21, while 1.16 would work just fine in almost all
cases on almost all architectures.

>
> But we could also keep allowing 1.16-1.20 and pass the new flag on
> 1.21+ only.
>
> What do you think?

I think we'll have to do the extra check. I'd also add something like
--btf-gen-all, that would turn on all the supported BTF features. So
that people that generate BTF for kernels externally (e.g., for old
kernels to support BPF CO-RE), could just do --btf-gen-all, instead of
potentially longer list of all the BTF optional subsets
(--btf-gen-floats --btf-gen-somemore --btf-gen-morecool etc). That
doesn't have to happen in this patch, of course.

So with what we have now:

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>
