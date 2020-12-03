Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60C802CD418
	for <lists+bpf@lfdr.de>; Thu,  3 Dec 2020 11:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbgLCK5h (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Dec 2020 05:57:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbgLCK5g (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Dec 2020 05:57:36 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3581DC061A4E
        for <bpf@vger.kernel.org>; Thu,  3 Dec 2020 02:56:56 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id f18so2020961ljg.9
        for <bpf@vger.kernel.org>; Thu, 03 Dec 2020 02:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ta9VEauCzPHkuUkI/2rHgERO7q63Vl1ro/mvyocnPMU=;
        b=gfdYa3aju9eS/l+ALHBoPlbuWH3QBUOWgwiEF8GehyRMgZ/Dx6RbuBbbtZ0kjIvzin
         IlyG1uWjp6lpdm89lCP82l2LKeqrFnKrU8xr9CfsfQq+UlpT3pWoZhR9ihRx7AebrFna
         hdmEaV4K/dxYZV+AKI+RZceYomKU9Na80cdUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ta9VEauCzPHkuUkI/2rHgERO7q63Vl1ro/mvyocnPMU=;
        b=GVxmlt2MIRob4Npqw8BxgcgoMhtaSiFjQAi+GsVTAa+AX6nPhkahOxTXzNQyYpYFPZ
         i6KDRmkD2RyoYnD37462awHwHguHTeU32z+3HF+d69DhlqsiteK/1+CMfDmCLw8HW6ai
         nVKR/ks5TYr5wa6qKRZdUgsuwx+aLG8HwLuq1I8aYRqHH31qkVxh4VBNNv0gTy3r6wpN
         naZU0XLjTfeMTRaMruWpvDSJkcDKBIjxlz5HeS4eMvJn3XxN6rtqUaKDRv0oLi528I+e
         5djc7fL9jSSSL8W9flZhyKGNILqlZnl5Bd4M7jywFaIBhjPF7CaflqJ3kg1ymPm0njXs
         963Q==
X-Gm-Message-State: AOAM533w7P96VYe9FbQAnXgM3HMxF+Yt/dujgSyRxlXZB1uA5x2VZmRo
        Sr6T4kTp+gxcy6z54cw4NUuxyFzpyuv9P7jyezuHKHIvzWwp24JA
X-Google-Smtp-Source: ABdhPJxqoITZsZg9fNyt2FHOHbcQpWA88PMI1nedTTp8aqDaGgKZfKEJU3YUF4IlaV7TqZPNZWrxXBjktKr7C0KJ4Jg=
X-Received: by 2002:a2e:7407:: with SMTP id p7mr1017158ljc.430.1606993013976;
 Thu, 03 Dec 2020 02:56:53 -0800 (PST)
MIME-Version: 1.0
References: <20201203005807.486320-1-kpsingh@chromium.org> <20201203005807.486320-4-kpsingh@chromium.org>
 <CAEf4BzbXA-az9cAKwy=bpqFOkX+6mtirm0TRxkyTmZdm+bXxoQ@mail.gmail.com>
In-Reply-To: <CAEf4BzbXA-az9cAKwy=bpqFOkX+6mtirm0TRxkyTmZdm+bXxoQ@mail.gmail.com>
From:   KP Singh <kpsingh@chromium.org>
Date:   Thu, 3 Dec 2020 11:56:43 +0100
Message-ID: <CACYkzJ6PYgmkZg_=q3Yi300esXmjB_gnX4urmcLxSQFxf+QyuQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/4] selftests/bpf: Add config dependency on BLK_DEV_LOOP
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 3, 2020 at 6:56 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Dec 2, 2020 at 4:58 PM KP Singh <kpsingh@chromium.org> wrote:
> >
> > From: KP Singh <kpsingh@google.com>
> >
> > The ima selftest restricts its scope to a test filesystem image
> > mounted on a loop device and prevents permanent ima policy changes for
> > the whole system.
> >
> > Fixes: 34b82d3ac105 ("bpf: Add a selftest for bpf_ima_inode_hash")
> > Reported-by: Andrii Nakryiko <andrii@kernel.org>
> > Signed-off-by: KP Singh <kpsingh@google.com>
> > ---
> >  tools/testing/selftests/bpf/config | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
> > index 365bf9771b07..37e1f303fc11 100644
> > --- a/tools/testing/selftests/bpf/config
> > +++ b/tools/testing/selftests/bpf/config
> > @@ -43,3 +43,4 @@ CONFIG_IMA=y
> >  CONFIG_SECURITYFS=y
> >  CONFIG_IMA_WRITE_POLICY=y
> >  CONFIG_IMA_READ_POLICY=y
> > +CONFIG_BLK_DEV_LOOP=y
> > --
>
>
> You mentioned also that CONFIG_LSM="selinux,bpf,integrity" is needed,
> no? Let's add that as well?

I did not add it because we did not do it when we added "bpf" to the list and

I also don't think selinux is really required here which might be worse in
some cases (e.g. when the required config options for
SELinux are not selected).

Also, when one selects CONFIG_BPF_LSM or CONFIG_IMA from make
menuconfig / nconfig, we get "bpf" and "integrity" appended by default:

We can add a comment that says that says:

  "Please ensure "bpf" and "integrity" are present in CONFIG_LSM"

Now, I was not sure if adding a comment would break any scripts that people
have that parse this file, so I avoided it. But overriding the string
completely
might not be a good idea.

>
> > 2.29.2.576.ga3fc446d84-goog
> >
