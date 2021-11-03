Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6242444608
	for <lists+bpf@lfdr.de>; Wed,  3 Nov 2021 17:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbhKCQjb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Nov 2021 12:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232806AbhKCQjb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Nov 2021 12:39:31 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2103C061714
        for <bpf@vger.kernel.org>; Wed,  3 Nov 2021 09:36:54 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id v138so7767801ybb.8
        for <bpf@vger.kernel.org>; Wed, 03 Nov 2021 09:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vYJTaxBgX36fk7PCnp+L1Zgt8Rdgzn5aHIwwPb487Ik=;
        b=PSeQXfzj9jDzDZALUj99x8AVjztLv1aSMh1yzYkJ9o+lW4d9yd6hxjg8RYgwXRMaV0
         +rqhVOZrTcOZ90oHKHCJHsckBjXEw2xcz56GSd6x7V1zQn8oxp2PYHd5/OQy6O+LPwFU
         G2SXCAD1i0pnxt2APLSkblkU9C1j2W9YHGhG+1hdESg7kQaBu53x2JHvpcZR2c7CStvj
         zZML5b4OqPe08BzKccVz4y6jDP8K+ikqokm/VJP6EvSegYYYGzICN9Q8jNmCsuzQCWyb
         Nj/+lUKRRPRaT/13nlUUcu4n9KznQ7NFRe+C0slZ8fXrUjHrw0sFeOv0Tr46QHKn8gvN
         vXLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vYJTaxBgX36fk7PCnp+L1Zgt8Rdgzn5aHIwwPb487Ik=;
        b=NBk4/uiH2nmcdQtWf2GwC8moPGuM7yIl50N4DIjtQ/3t90KGO4T/Tun41UoSeyKJEz
         DJ5t8BBH1gS2hmrWN8S4bwtH/QXm1gmmxBoKwfNyZS7QFBoQr+otx4T+8u+Eq303Pztp
         DDBhB4WNLVfeORc/p3+Qd99UrIZnuFJ9QAYLfX0p6L2YlfnZ5m2+BbhWn+VmWobgoxNR
         0r6B273WXt1mRu7EySqYidmLSKle2z2dyErFAIzyP5myhnvWbHWn+SbLMq155r1VOeiR
         AFje6GSnfZbgmSjtl6mTUEiKBX6lW5VHw3n3InPbZz68oENHOuKzT2pkHTM8d2UvxnYu
         UDZg==
X-Gm-Message-State: AOAM530liNnJh2+nYUPDzlnuJpthHEpb0ePj5u3xUqI5dPEAukTc1T0N
        c7aIQwfw8DVxvJ4zFUZA1hP3sy+7qXBdcUHX1u8=
X-Google-Smtp-Source: ABdhPJzX+E13Xx4MMahPeHO25eJMVnhf0ArsdAcP1zdvYluTq5xYS8DStkZFQknusnnpKSsIYNZm401DdwKgAFAf9IQ=
X-Received: by 2002:a25:afcd:: with SMTP id d13mr49662569ybj.504.1635957414047;
 Wed, 03 Nov 2021 09:36:54 -0700 (PDT)
MIME-Version: 1.0
References: <20211103001003.398812-1-andrii@kernel.org> <20211103001003.398812-3-andrii@kernel.org>
 <21677f40-5415-e932-46ef-4e31cf6dd0f2@fb.com>
In-Reply-To: <21677f40-5415-e932-46ef-4e31cf6dd0f2@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 3 Nov 2021 09:36:43 -0700
Message-ID: <CAEf4BzaPE8QKRfeHPmPtJjQQ1Fv1AzSVUb-s+0+8Z4GMpDa2SQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/5] libbpf: improve sanity checking during BTF
 fix up
To:     Yonghong Song <yhs@fb.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 2, 2021 at 11:06 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 11/2/21 5:10 PM, Andrii Nakryiko wrote:
> > If BTF is corrupted DATASEC's variable type ID might be incorrect.
> > Prevent this easy to detect situation with extra NULL check.
> > Reported by oss-fuzz project.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>
> Ack with a nit below.
> Acked-by: Yonghong Song <yhs@fb.com>
>
> > ---
> >   tools/lib/bpf/libbpf.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 71f5a009010a..4537ce6d54ce 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -2754,7 +2754,7 @@ static int btf_fixup_datasec(struct bpf_object *obj, struct btf *btf,
> >               t_var = btf__type_by_id(btf, vsi->type);
> >               var = btf_var(t_var);
>
> Can we move the above 'var = ...' assignment after below if statement?

it's safe as is because btf_var() is equivalent to pointer casting. I
considered doing a check before btf_var() cast, but that would require
a separate if and pr_debug statements which felt like an overkill.

>
> >
> > -             if (!btf_is_var(t_var)) {
> > +             if (!t_var || !btf_is_var(t_var)) {
> >                       pr_debug("Non-VAR type seen in section %s\n", name);
> >                       return -EINVAL;
> >               }
> >
