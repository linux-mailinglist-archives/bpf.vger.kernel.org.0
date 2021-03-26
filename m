Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11C2C34A437
	for <lists+bpf@lfdr.de>; Fri, 26 Mar 2021 10:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbhCZJWN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Mar 2021 05:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbhCZJVl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Mar 2021 05:21:41 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4ABCC0613AA
        for <bpf@vger.kernel.org>; Fri, 26 Mar 2021 02:21:40 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id o126so6724976lfa.0
        for <bpf@vger.kernel.org>; Fri, 26 Mar 2021 02:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p6nxZbR4Xgz4AncIrczo5kp+se9vOk+PPXgMHdUhIsg=;
        b=TC5ioniMTubmFeTpgz6LjRhQLGhK45DHfYA1LoF0jrdnzW3lT59zY8xTjtjOLRjEbd
         Od7CYRiePEA8ExQ/yhWTZNup5X4MleGgrLev6ByAibtWwAOOVug8re1Smp4v/zaMOq0q
         H62Tl5nPbSQfzBJnovfy424RgmEhbuUSnf34Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p6nxZbR4Xgz4AncIrczo5kp+se9vOk+PPXgMHdUhIsg=;
        b=rOQl4ylD+RQlR011W01bl7fRAAoAcgcIz6nFbV2qT4ZyJpELdHAdYV0D99v+cWP7p2
         DN8GqpO3VJtANW7SXPF7jippRKIyXP3vTEpXmO56VsS7JfT2F3JrM8IChzfgObQKUgGe
         +8sT3MX2mKOfsF8s7432t43+JpiH8J9Zp4rX1X7vfGbCeaqeovGUwGs1PF5Ed94g4cYB
         3EtoJSwvpuwKorAA9DmREPPGeDGG1J9fmTQ2W5+OfL2nAN5b8aa9REDWJ/2JtAGA1dEy
         3bvxNDCoYzFXeUxuaqgGWTKd9mjK4Fgfa4r1L9ldTwAtTHlsXfFw22fbtjzPy4lmaBWy
         vvsw==
X-Gm-Message-State: AOAM531NXcjt7x2cKB22zjbAUgqLT76ZWrGdY7fCMJ09OLwnSFt9OIgr
        QDegovCq1KrmU9+TAFgs9HtsOgRhVA9C+QhTSWqVjw==
X-Google-Smtp-Source: ABdhPJwiYavCv8TB+frrXlrQ71Jl6lZjSBv8FbsLBGmoOuF1aUYslQ8Pmqc/4aJBUD4DqO8GHNwbuB0fznv47Ri6Tck=
X-Received: by 2002:a05:6512:3226:: with SMTP id f6mr7318541lfe.171.1616750499132;
 Fri, 26 Mar 2021 02:21:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210325152146.188654-1-lmb@cloudflare.com> <CAEf4BzbC75N2xHW0kB76AZCbnD+01LA5T+tn4XfBPL=b=xNS4A@mail.gmail.com>
In-Reply-To: <CAEf4BzbC75N2xHW0kB76AZCbnD+01LA5T+tn4XfBPL=b=xNS4A@mail.gmail.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Fri, 26 Mar 2021 09:21:28 +0000
Message-ID: <CACAyw9--2Nj6L-r__A=-Xka97ONE8UqiP=Ku7sY+5GHQHsayGA@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: link: refuse non-zero file_flags in BPF_OBJ_GET
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        kernel-team <kernel-team@cloudflare.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 26 Mar 2021 at 04:43, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> Makes sense, but see below about details.
>
> Also, should we do the same for BPF programs as well? I guess they
> don't have a "write operation", once loaded, but still...

I asked myself the same question, I don't have a good answer. Right
now it seems like no harm is done, but this will probably bite us
again in the future. Would you want to backport this? We'd have to
target commit 6e71b04a8224 ("bpf: Add file mode configuration into bpf
maps") I think, which appeared in 4.14 (?). Maybe it's better to just
refuse the flag in bpf-next?

>
> >  kernel/bpf/inode.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
> > index 1576ff331ee4..2f9e8115ad58 100644
> > --- a/kernel/bpf/inode.c
> > +++ b/kernel/bpf/inode.c
> > @@ -547,7 +547,7 @@ int bpf_obj_get_user(const char __user *pathname, int flags)
> >         else if (type == BPF_TYPE_MAP)
> >                 ret = bpf_map_new_fd(raw, f_flags);
> >         else if (type == BPF_TYPE_LINK)
> > -               ret = bpf_link_new_fd(raw);
> > +               ret = (flags) ? -EINVAL : bpf_link_new_fd(raw);
>
> nit: unnecessary ()
>
>
> I wonder if EACCESS would make more sense here?

My thinking was: the access mode is fine if we get to this place, but
the code in question doesn't support that particular flag. EINVAL
seemed more appropriate. Happy to change it if you prefer.

>And check f_flags, not flags:
>
> if (f_flags != O_RDWR)
>     ret = -EACCESS;
> else
>     ret = bpf_link_new_fd(raw);

I'll respin with f_flags. I'd prefer keeping the ternary operator
version though, since this should ease backporting.

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
