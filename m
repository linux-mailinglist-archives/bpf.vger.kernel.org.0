Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAA2F32477D
	for <lists+bpf@lfdr.de>; Thu, 25 Feb 2021 00:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236237AbhBXXYZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Feb 2021 18:24:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236285AbhBXXYT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Feb 2021 18:24:19 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD69C061574
        for <bpf@vger.kernel.org>; Wed, 24 Feb 2021 15:23:38 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id p186so3594287ybg.2
        for <bpf@vger.kernel.org>; Wed, 24 Feb 2021 15:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lCCuCRsO8rvaYLcb6rg3HFrBHt09FHX0HF6/JaQOz4k=;
        b=X45ZvouokP0haHKWsPJS1zb8Ku8Ed/vVyve3FfY0+dQP45Pp3E5XZIfxpYRmADJD9k
         4cHSsxWvsK0Q7hcKlMyS6+ZeLuXCFh/aQwvdX1tDGV59i+HiEsXDI7YD8ZCebocb54Xi
         rjRslN/zP0pALXEvLSIfARpFcBWT2VI0ZG6+YJ7L2rcK7601ZwXucYDWKsYgiCd/J+gR
         /ryBmtnB9/wPdEIRYMKM3xXwWy6QrpGweMjPcMLZdEjdbp9s6lW7ctSb2JmoZXFcKLAE
         LlkJu75qcF4HmOp5CxMLQXuDAYcazsNGeB6K7Ak4/PwPXHXqcyuXSPO/k7QYYSW+lZk2
         6ucg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lCCuCRsO8rvaYLcb6rg3HFrBHt09FHX0HF6/JaQOz4k=;
        b=uPxqX53EStF0G+1RFSxiaYezYt2uJmt7+qmnj/vHPt9N918FVXQDCE4y26gy06sTgY
         a2v1aNsjo+y+xzr5TVnqH68ik2eVO4xck9HAKPSuMZ1RENJoIMJbLAugq1uy6h5uKJfn
         ZqoaHvogK3C4EETGX9mszAoLia78STp8UOMZLX1PWfEjnEWEvY/7erBs7m0S0G9aaVnD
         2AulHr1Iy8dSNQkIbAKaC1T4YDkDhTVsWeJMGBJwSRDEMgPtk5sdvdV3SUK51kIRqJwZ
         K56yYHzPD+RSWqcKCe6AzHlqhyocPgjdBNReUH/ZRrjwfXV5eb/m1iuIZFladeqsnIxo
         XxwA==
X-Gm-Message-State: AOAM533Q5FzSKxb1XtlKjgqhHGwHa3ji156MQmuHlyXVPbKzwiXGc8YC
        cuG9lRGXwww0h0aCNE0S9iE3OPyqVmd8IgKB/MU=
X-Google-Smtp-Source: ABdhPJzDFoIRZ/Irvly2HbYP0cW/bDlQAMBym8lSD2hQ+l4/etET6Wsg0/bxRj8lBUMHuMyDkBQNg5SdVK/KaM/Xp9w=
X-Received: by 2002:a25:f40e:: with SMTP id q14mr88078ybd.230.1614209018028;
 Wed, 24 Feb 2021 15:23:38 -0800 (PST)
MIME-Version: 1.0
References: <20210223231459.99664-1-iii@linux.ibm.com> <20210223231459.99664-3-iii@linux.ibm.com>
 <CAEf4BzZdD7gh4ehmH3k-Q_Dt-KtCfX5Xe5PUA93xpo3bS=NTiA@mail.gmail.com> <912782baa065fb961f61f198cba21bb894d1537a.camel@linux.ibm.com>
In-Reply-To: <912782baa065fb961f61f198cba21bb894d1537a.camel@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 24 Feb 2021 15:23:27 -0800
Message-ID: <CAEf4BzZ8aAVsnv_TSV_5uXcu0JNh516rXj2L=cH9ncKGUju_OA@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 2/8] libbpf: Add BTF_KIND_FLOAT support
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        bpf <bpf@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 24, 2021 at 3:11 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> On Wed, 2021-02-24 at 12:56 -0800, Andrii Nakryiko wrote:
> > On Tue, Feb 23, 2021 at 3:15 PM Ilya Leoshkevich <iii@linux.ibm.com>
> > wrote:
> > >
> > > The logic follows that of BTF_KIND_INT most of the time.
> > > Sanitization
> > > replaces BTF_KIND_FLOATs with equally-sized empty BTF_KIND_STRUCTs
> > > on
> > > older kernels, for example, the following:
> > >
> > >     [4] FLOAT 'float' size=4
> > >
> > > becomes the following:
> > >
> > >     [4] STRUCT '(anon)' size=4 vlen=0
> > >
> > > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > > ---
> >
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> >
> > >  tools/lib/bpf/btf.c             | 51
> > > ++++++++++++++++++++++++++++++++-
> > >  tools/lib/bpf/btf.h             |  6 ++++
> > >  tools/lib/bpf/btf_dump.c        |  4 +++
> > >  tools/lib/bpf/libbpf.c          | 26 ++++++++++++++++-
> > >  tools/lib/bpf/libbpf.map        |  5 ++++
> > >  tools/lib/bpf/libbpf_internal.h |  2 ++
> > >  6 files changed, 92 insertions(+), 2 deletions(-)
> > >
> >
> > [...]
> >
> > >  /* it's completely legal to append BTF types with type IDs
> > > pointing forward to
> > >   * types that haven't been appended yet, so we only make sure that
> > > id looks
> > >   * sane, we can't guarantee that ID will always be valid
> > > @@ -1910,7 +1955,7 @@ static int btf_add_composite(struct btf *btf,
> > > int kind, const char *name, __u32
> > >   *   - *byte_sz* - size of the struct, in bytes;
> > >   *
> > >   * Struct initially has no fields in it. Fields can be added by
> > > - * btf__add_field() right after btf__add_struct() succeeds.
> > > + * btf__add_field() right after btf__add_struct() succeeds.
> >
> > Was there some whitespacing problem on this line?
>
> Ouch, yes, I remember dropping this chunk, but my editor appears to
> have sneaked it back in. I will split this commit in two (hopefully
> it's ok to keep the ack :-)).
>

Don't bother just for this line.
