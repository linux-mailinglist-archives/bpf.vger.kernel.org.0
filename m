Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70C9B34C824
	for <lists+bpf@lfdr.de>; Mon, 29 Mar 2021 10:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233089AbhC2IUF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Mar 2021 04:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233080AbhC2ITc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Mar 2021 04:19:32 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2798C061756
        for <bpf@vger.kernel.org>; Mon, 29 Mar 2021 01:19:25 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id a198so17147382lfd.7
        for <bpf@vger.kernel.org>; Mon, 29 Mar 2021 01:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T17UPyB49fQi81p3RjN5h9re4h1c9rcNiJmp3cH67jg=;
        b=q1LkIVeN1CSY5hosJXtoBv+Ux0JhJ27lW+Gm+sBS9dvD4Sw2R4apI4P5/0lR/NLEQR
         VIZ+gt088HzjytzKLP0IMIDXvGVjshPrKXBV/YdRScfYB9kBop09xAfYf0Mc/qm5RqMG
         ovmY11JV78D5bCh5lGmZc69wxuCOT1iyewBBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T17UPyB49fQi81p3RjN5h9re4h1c9rcNiJmp3cH67jg=;
        b=hrXdjq8JZp+TTrC2ZCW1MEEIPsZRcAVPNUXYsQtww4OwsZ50ldlFq18pHQdqSIEx4K
         UBl/JKmNDGkkmTch71GgdbbkPy4E5r0/8aDZM8NB2a6uDSSl4Frgi2uD3J7/AWys0tnj
         xJCu8FIXo86IJG8Nc9Wp7aSlPDnZJE8WL3RGjveEetLczzpFF+nkpaod0DZpvbTlbdpp
         VCYXr/aZ4FIu59HyKUYCtjVggINJJRnOvfkQOhM9y9sBwG7PaU2jolp4uq8Fl1xN+2dT
         tGl5EghW6IHRuU2eS6ONcJ/FZyAXwSc/9ZTumMS0fq+j/CYXuVxxlD3r31Igw7kPaOfk
         4E7w==
X-Gm-Message-State: AOAM531ddjND50Oj9JlUzAzV4M7tXd3xwcb2vHo+SqiZ3QyvujyyqOy0
        Ard2DDXK1qTJbLBZz8XjN5Hg7WNTf18yCAs1nyc+H36SMyA=
X-Google-Smtp-Source: ABdhPJxFOiDf3HdUzgGwB1o9orQWHoh/OXEAOPDSOIowsXvtXJ80dRVlkz8qGZfuEAA4/DB8oCyHi6o9BNhhc5MaJTY=
X-Received: by 2002:a19:521a:: with SMTP id m26mr16066250lfb.56.1617005964467;
 Mon, 29 Mar 2021 01:19:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210326160501.46234-1-lmb@cloudflare.com> <20210326160501.46234-2-lmb@cloudflare.com>
 <CAPhsuW7E4bhEGcboKQ5O=1o0iVNPLpJB1nrAgxweiZqGhZm-JQ@mail.gmail.com>
In-Reply-To: <CAPhsuW7E4bhEGcboKQ5O=1o0iVNPLpJB1nrAgxweiZqGhZm-JQ@mail.gmail.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Mon, 29 Mar 2021 09:19:13 +0100
Message-ID: <CACAyw99NVbu0q-wh=r7ifoVUnny6gxXwf6LPGf0HUhg1CCQkUQ@mail.gmail.com>
Subject: Re: [PATCH bpf v2 2/2] bpf: program: refuse non-O_RDWR flags in BPF_OBJ_GET
To:     Song Liu <song@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        kernel-team <kernel-team@cloudflare.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 26 Mar 2021 at 20:14, Song Liu <song@kernel.org> wrote:
>
> On Fri, Mar 26, 2021 at 9:07 AM Lorenz Bauer <lmb@cloudflare.com> wrote:
> >
> > As for bpf_link, refuse creating a non-O_RDWR fd. Since program fds
> > currently don't allow modifications this is a precaution, not a
> > straight up bug fix.
> >
> > Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
> > ---
> >  kernel/bpf/inode.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
> > index dc56237d6960..d2de2abec35b 100644
> > --- a/kernel/bpf/inode.c
> > +++ b/kernel/bpf/inode.c
> > @@ -543,7 +543,7 @@ int bpf_obj_get_user(const char __user *pathname, int flags)
> >                 return PTR_ERR(raw);
>
> For both patches, shall we do the check before bpf_obj_do_get(), which is a few
> lines above?

type is filled in by bpf_obj_do_get, so we can't avoid calling it. As
Andrii mentions we need to allow flags for map.

>
> Thanks,
> Song
>
> >
> >         if (type == BPF_TYPE_PROG)
> > -               ret = bpf_prog_new_fd(raw);
> > +               ret = (f_flags != O_RDWR) ? -EINVAL : bpf_prog_new_fd(raw);
> >         else if (type == BPF_TYPE_MAP)
> >                 ret = bpf_map_new_fd(raw, f_flags);
> >         else if (type == BPF_TYPE_LINK)
> > --
> > 2.27.0
> >



-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
