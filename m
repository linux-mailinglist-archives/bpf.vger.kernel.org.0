Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C84D659321
	for <lists+bpf@lfdr.de>; Fri, 30 Dec 2022 00:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbiL2XV5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Dec 2022 18:21:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiL2XVx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Dec 2022 18:21:53 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B3317047;
        Thu, 29 Dec 2022 15:21:52 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id g1so14292110edj.8;
        Thu, 29 Dec 2022 15:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gsydHdt4qFmoZGrRG7RK5t4nczQKBVGqpMi9ILvXlSI=;
        b=X79y6JF+6F149oEdCOU6aFFmOzRdjuar6v6UC10XYg2WODWhUCoHGUhS4E3JvmbLNZ
         mcBO+mRkCPN2JIYE42mHCt7IDQ5rRGq85LHTtxHpTsKXiDxKdgPVxqfwgDJS7FdtEWc6
         tMjLjIUAFooKMNzazI7BCW2omcmQb3yp85Jal3lW9P6NRzPJ0kgSoy5nKI9CRkcFa07n
         DN5CAonvVaiMaoWm+FR4k4UYhyOr2z2C3m33rlpfFqPnXMHpc/RvnMstqYb4IsZk87J/
         zCbdWsGOaoOF/0K4F3PeOUrsBwXHn7Z3eJ/49Qb81EljrUiL7nJeHtADJ50ZlXUY8jnX
         QYyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gsydHdt4qFmoZGrRG7RK5t4nczQKBVGqpMi9ILvXlSI=;
        b=WwmQ9Qfmkf4pJjrVg4VQOS8pU4kCabDI53mo1toBvzT1A5TjNb9XXktQKlzxJXpdt1
         TsPODkDRDX/E9gNfbRVaFQc2AH/BHwIXsKBPJJxlpG2cZfex4ANXA12x19LIOQW+i85N
         3iM+u9fv3zMgf7WwQb/YJsnsFtOUkh1ApG6BbO+fNZcVuX02ogt7+jRlW6N3ay4gvVMo
         5XU8OmqLFadcRsVs7v9xM5+rliEDFz/bQbU2tk0p7KWfPGNrf/VZ6SVF67dz4Ham8jFT
         dGLU7lOKmcdCkikzNgZAT8Vm3V7QZETfJilllxPKRsm+bKUEM+RXWrW7Am+GmqQftq6x
         xKMA==
X-Gm-Message-State: AFqh2kolVBGaJllPoooEM7lReFSYPTJDBAyHx/QH/WluldEYY5f3ZOW0
        YJJ+tBkJGD1vudUTYCBQBHNm1e1vh0MzJye8H1s=
X-Google-Smtp-Source: AMrXdXuEl2vR5AG5ElYSFYpKBZn1/Z3BWjGujNfAWdyrSZV1sz9m/viTlZQVDlxYq3eisZKW4tyqtr7Bitsj5iKoEN0=
X-Received: by 2002:aa7:db59:0:b0:486:48ae:95ed with SMTP id
 n25-20020aa7db59000000b0048648ae95edmr1263072edt.224.1672356110608; Thu, 29
 Dec 2022 15:21:50 -0800 (PST)
MIME-Version: 1.0
References: <20221223133618.10323-1-liuxin350@huawei.com> <CAEf4BzYYvs0TgA5aE41z7_ZQ8qa0=ird3P4hCFn3Xxj7km49-w@mail.gmail.com>
 <CAADnVQ+FbGD9yMpRYtCbzC-snOG1tGLfvEXQvkJYcMRjbYjTyw@mail.gmail.com>
In-Reply-To: <CAADnVQ+FbGD9yMpRYtCbzC-snOG1tGLfvEXQvkJYcMRjbYjTyw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 29 Dec 2022 15:21:38 -0800
Message-ID: <CAEf4BzaeXwrjgT_sh9ySunSHviNvM5tMSXfXYnJ6ZD7hAfhN4w@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: fix errno is overwritten after being closed.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
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

On Thu, Dec 29, 2022 at 1:49 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Dec 29, 2022 at 1:44 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Fri, Dec 23, 2022 at 5:36 AM Xin Liu <liuxin350@huawei.com> wrote:
> > >
> > > In the ensure_good_fd function, if the fcntl function succeeds but
> > > the close function fails, ensure_good_fd returns a normal fd and
> > > sets errno, which may cause users to misunderstand. The close
> > > failure is not a serious problem, and the correct FD has been
> > > handed over to the upper-layer application. Let's restore errno here.
> > >
> > > Signed-off-by: Xin Liu <liuxin350@huawei.com>
> > > ---
> > >  tools/lib/bpf/libbpf_internal.h | 5 ++---
> > >  1 file changed, 2 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
> > > index 377642ff51fc..98333a6c38e9 100644
> > > --- a/tools/lib/bpf/libbpf_internal.h
> > > +++ b/tools/lib/bpf/libbpf_internal.h
> > > @@ -543,10 +543,9 @@ static inline int ensure_good_fd(int fd)
> > >                 fd = fcntl(fd, F_DUPFD_CLOEXEC, 3);
> > >                 saved_errno = errno;
> > >                 close(old_fd);
> > > -               if (fd < 0) {
> > > +               errno = saved_errno;
> > > +               if (fd < 0)
> > >                         pr_warn("failed to dup FD %d to FD > 2: %d\n", old_fd, -saved_errno);
> > > -                       errno = saved_errno;
> >
> > pr_warn calls into user-provided callback, which can clobber errno, so
> > `errno = saved_errno` should happen after pr_warn. With your change
> > there is even higher chance of errno clobbering.
> >
> > Please send a follow up fix to unconditionally restore errno *after*
> > pr_warn, thanks.
>
> Good point. I can follow up with one line fix too.

that would be simplest, probably, thanks!
