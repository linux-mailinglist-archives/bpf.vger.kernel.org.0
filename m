Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B96DA65924B
	for <lists+bpf@lfdr.de>; Thu, 29 Dec 2022 22:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbiL2VtT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Dec 2022 16:49:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbiL2VtS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Dec 2022 16:49:18 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F27910FD4;
        Thu, 29 Dec 2022 13:49:17 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id fc4so47666758ejc.12;
        Thu, 29 Dec 2022 13:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7NMRV5ypnDMUJPfywMYOiu80EiYecrYjVKdYS5AMU/0=;
        b=hzvEZw96TKFXIf2ulPVp8Z1vJD4aDY9Kd7OTIxM+iCgxr2Wft17+UyrU6zijMltNfq
         SHxvea3tnqG7zI7GeDDG4V/3cLAE11S0lsgL5n0hehuD9syLwbWWqseCM4wjq4+CQCin
         wAnQflmh/VBDUWct73Mpq7RB/z82ivJC++sugddeQ3fWmBpQCRi5TCaJy9oQkKLSZwAR
         auiNAimhYGTAlodHJUKi7rMNL9x/mhFd3jFwP2PJdESpoM2ysdA/yFLmLsnAxc3/36gR
         ot5HW6GYMSPjy72seZJkI5KAy1h9CVZkw/vXtfymYRzt9nUJxYXS8bO3r3dRvNaaq5gq
         j1ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7NMRV5ypnDMUJPfywMYOiu80EiYecrYjVKdYS5AMU/0=;
        b=n6H6F4ags0bBKMcuhXFYsJ/dfRPAXlVQNToSg3Pknf7xGar0XRBhTZwTWywiFqelOl
         53KQsEDmhBVeo83UKjSmKkgkxtImeDITVT3TQAu0MLTmT50iQS+BOP/dyurF9lm6yhKd
         NnMb672rRSLSPZF/tQA7YapvLriNmJxi7TXsQ4J0JOhz+8DtlGpvWbUC4U7z7SM8QgFZ
         h4xObbxRZUDD55eF39FrSmwmQDwxb5jO0M+aQDshWCCm7EakGiPYqhf1qF717XwiXKwK
         t/7PzuRuhjOr922IZzhUDs7U84+T8M/a9PsoirpKZaA8LxQByzc1EPM5utoueNPB7KYA
         y5ug==
X-Gm-Message-State: AFqh2ko1M1VE7whVKn48mJbVPJLjsrQNnM6hgXzvGCBqng5gFaP5LCu9
        kzipvgjF7Vo0m5ePNwMycBepGBUXXl7oGpd7qvA=
X-Google-Smtp-Source: AMrXdXuGSHPJdC4E8PK48hQYqla/lioEbgmENnzp7DqtrP+6xiQyqhJK3VxnNgy6M65k5wlVw3Z2VKF6E88PqLRLWsE=
X-Received: by 2002:a17:906:30c9:b0:7c1:bb5:f29c with SMTP id
 b9-20020a17090630c900b007c10bb5f29cmr1782370ejb.58.1672350555420; Thu, 29 Dec
 2022 13:49:15 -0800 (PST)
MIME-Version: 1.0
References: <20221223133618.10323-1-liuxin350@huawei.com> <CAEf4BzYYvs0TgA5aE41z7_ZQ8qa0=ird3P4hCFn3Xxj7km49-w@mail.gmail.com>
In-Reply-To: <CAEf4BzYYvs0TgA5aE41z7_ZQ8qa0=ird3P4hCFn3Xxj7km49-w@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 29 Dec 2022 13:49:03 -0800
Message-ID: <CAADnVQ+FbGD9yMpRYtCbzC-snOG1tGLfvEXQvkJYcMRjbYjTyw@mail.gmail.com>
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

On Thu, Dec 29, 2022 at 1:44 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Dec 23, 2022 at 5:36 AM Xin Liu <liuxin350@huawei.com> wrote:
> >
> > In the ensure_good_fd function, if the fcntl function succeeds but
> > the close function fails, ensure_good_fd returns a normal fd and
> > sets errno, which may cause users to misunderstand. The close
> > failure is not a serious problem, and the correct FD has been
> > handed over to the upper-layer application. Let's restore errno here.
> >
> > Signed-off-by: Xin Liu <liuxin350@huawei.com>
> > ---
> >  tools/lib/bpf/libbpf_internal.h | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
> > index 377642ff51fc..98333a6c38e9 100644
> > --- a/tools/lib/bpf/libbpf_internal.h
> > +++ b/tools/lib/bpf/libbpf_internal.h
> > @@ -543,10 +543,9 @@ static inline int ensure_good_fd(int fd)
> >                 fd = fcntl(fd, F_DUPFD_CLOEXEC, 3);
> >                 saved_errno = errno;
> >                 close(old_fd);
> > -               if (fd < 0) {
> > +               errno = saved_errno;
> > +               if (fd < 0)
> >                         pr_warn("failed to dup FD %d to FD > 2: %d\n", old_fd, -saved_errno);
> > -                       errno = saved_errno;
>
> pr_warn calls into user-provided callback, which can clobber errno, so
> `errno = saved_errno` should happen after pr_warn. With your change
> there is even higher chance of errno clobbering.
>
> Please send a follow up fix to unconditionally restore errno *after*
> pr_warn, thanks.

Good point. I can follow up with one line fix too.
