Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8AC65945E
	for <lists+bpf@lfdr.de>; Fri, 30 Dec 2022 04:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbiL3DUb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Dec 2022 22:20:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiL3DUa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Dec 2022 22:20:30 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2856A13F9B;
        Thu, 29 Dec 2022 19:20:29 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id c34so22414933edf.0;
        Thu, 29 Dec 2022 19:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3shaM31XNfxnTIgL1yOhRXuzIZtjbF2iZ8+JDnxxmW0=;
        b=jrqskRPHtHBOYjQnBuJXgH8aw0QVZhjC7buDf19yxHVI9Y5m1YpmOb5hkbFL2qg0wE
         SOnlgx2ziVHhUCMijw5TRBWDSVCIT//+rE/PkhN9cDacEk27CUA9ANUGXYEppGxAXOm4
         oKRBLeeVBBUegbdg+CogQZsyFD8B13N/8FdAEkIWa+lbNio9rVgWsk6uEdYyj2RKQsqZ
         Pn6RJ+zM9BlFDuGOssrFmEuTspb/VKwhmvSGgQxpkfv97XQJwwhp7J7aVXlPguLzj1w0
         cRQ8Wx45cRScfqoMMWNV1fP29w1b72hP57zhACUAXaWqNX4l4fKCr4DKKZjxu3k33yvm
         dkOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3shaM31XNfxnTIgL1yOhRXuzIZtjbF2iZ8+JDnxxmW0=;
        b=7zrKlBLt744PS+gFozgcf8Twc7FwL3UZiI1AMsAeybreKryXIhE6a+sAY+ToYgnY2c
         kPnUMH123+waolAXwbghSsUxzzSbxd3BBHtCxBj/K2ZK+e98aA3Ays9lj32in5+Clnt9
         olzyv7acDoJq6XvYjeOAzn62AbU0aVcYgh1yvCDyjUrs90AkYUwDqBgJ86l6MF3jg8ht
         9sUv4PT7Eu7cx1hpyjTWFiKYmCwhJWCfmkVtnk/CSL0ysZi+dlbvrgnCV5e87Da9rmsI
         qFQ6V13GR6RiP51E5SdZNX1eOFBUoHsW0w/BrF2QY1FjkeefL4HNbZVQTMuK9mc2kOxJ
         vPeg==
X-Gm-Message-State: AFqh2kou2UicvcqelnTLVtLAwpFULLmsR7ZUd80fLLD6a4tP7OKlQxOK
        tLn0c+X0sUdQykJocMPb/DT6K3kueOIXTwQdoug=
X-Google-Smtp-Source: AMrXdXsQq8kEYt0m6BNUy3WefoAuBWWzO1LQs7s0ykKJYoU4aFNM2RFwqcKxuAqC5cdtwFkeisipvbJdMRNHq9RfrTo=
X-Received: by 2002:a05:6402:b4b:b0:483:bc48:dfa8 with SMTP id
 bx11-20020a0564020b4b00b00483bc48dfa8mr1885680edb.94.1672370427615; Thu, 29
 Dec 2022 19:20:27 -0800 (PST)
MIME-Version: 1.0
References: <20221223133618.10323-1-liuxin350@huawei.com> <CAEf4BzYYvs0TgA5aE41z7_ZQ8qa0=ird3P4hCFn3Xxj7km49-w@mail.gmail.com>
 <CAADnVQ+FbGD9yMpRYtCbzC-snOG1tGLfvEXQvkJYcMRjbYjTyw@mail.gmail.com> <CAEf4BzaeXwrjgT_sh9ySunSHviNvM5tMSXfXYnJ6ZD7hAfhN4w@mail.gmail.com>
In-Reply-To: <CAEf4BzaeXwrjgT_sh9ySunSHviNvM5tMSXfXYnJ6ZD7hAfhN4w@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 29 Dec 2022 19:20:16 -0800
Message-ID: <CAADnVQ+7vwr95vXME=9YyRyBA60Num-1-Btm+__5q7t1NwU3YA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: fix errno is overwritten after being closed.
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Xin Liu <liuxin350@huawei.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        yanan@huawei.com, wuchangye@huawei.com, xiesongyang@huawei.com,
        kongweibin2@huawei.com, zhangmingyi5@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 29, 2022 at 3:21 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Dec 29, 2022 at 1:49 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu, Dec 29, 2022 at 1:44 PM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Fri, Dec 23, 2022 at 5:36 AM Xin Liu <liuxin350@huawei.com> wrote:
> > > >
> > > > In the ensure_good_fd function, if the fcntl function succeeds but
> > > > the close function fails, ensure_good_fd returns a normal fd and
> > > > sets errno, which may cause users to misunderstand. The close
> > > > failure is not a serious problem, and the correct FD has been
> > > > handed over to the upper-layer application. Let's restore errno here.
> > > >
> > > > Signed-off-by: Xin Liu <liuxin350@huawei.com>
> > > > ---
> > > >  tools/lib/bpf/libbpf_internal.h | 5 ++---
> > > >  1 file changed, 2 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
> > > > index 377642ff51fc..98333a6c38e9 100644
> > > > --- a/tools/lib/bpf/libbpf_internal.h
> > > > +++ b/tools/lib/bpf/libbpf_internal.h
> > > > @@ -543,10 +543,9 @@ static inline int ensure_good_fd(int fd)
> > > >                 fd = fcntl(fd, F_DUPFD_CLOEXEC, 3);
> > > >                 saved_errno = errno;
> > > >                 close(old_fd);
> > > > -               if (fd < 0) {
> > > > +               errno = saved_errno;
> > > > +               if (fd < 0)
> > > >                         pr_warn("failed to dup FD %d to FD > 2: %d\n", old_fd, -saved_errno);
> > > > -                       errno = saved_errno;
> > >
> > > pr_warn calls into user-provided callback, which can clobber errno, so
> > > `errno = saved_errno` should happen after pr_warn. With your change
> > > there is even higher chance of errno clobbering.
> > >
> > > Please send a follow up fix to unconditionally restore errno *after*
> > > pr_warn, thanks.
> >
> > Good point. I can follow up with one line fix too.
>
> that would be simplest, probably, thanks!

Pushed trivial fix to bpf-next.
