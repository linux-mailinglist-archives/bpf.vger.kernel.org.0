Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76134659247
	for <lists+bpf@lfdr.de>; Thu, 29 Dec 2022 22:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbiL2VoM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Dec 2022 16:44:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233924AbiL2VoK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Dec 2022 16:44:10 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27B110061;
        Thu, 29 Dec 2022 13:44:09 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id u9so47832815ejo.0;
        Thu, 29 Dec 2022 13:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YUR9lBWtgopswNBH5Ii+s9RjlfE8jrVHFGOZoG+ipZU=;
        b=VNzDd7dgQakYLbIEbxJVE0KXx/QOusoi5AmJ6vF5gAqYxyyeWO2ZwmpAHEJSe7digb
         35pB5OEVWv1P8obSC1sF7DZ0qTwgQhoxxZVTMxmhBcCpd4RTklYURueWI8yIFY1HD3LB
         pFYJiwTmVaDQhQseAtMjUYyqQfsadCopMobXziT1NiwiAQTAGLRR7l4pS850MKwCPy80
         rwfMlUaub+/Bu84Q3fOlngyHedK8YRKy68FNY1OZC3FknJr+5vWEpmgb76HDA0V4bLeK
         AfoF/QUkQL0bB1//ttxw6WGzMaTqAj/CIf4oZz2bG2NZZjtV7skv7Y2uCKNSYyFdY13l
         Unng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YUR9lBWtgopswNBH5Ii+s9RjlfE8jrVHFGOZoG+ipZU=;
        b=NqoZ3Y5XVVEGg0MYcMUrzpe/hgMU6FGqTVmyXe3ufO+IsH2a82yKVWjV8tfwzeSDor
         o1xKUNsCYxOeAiEoEpU6RuUkZ9kcMDjOWw/KI0XqUcDJl0ce/XvRWZ//Wt+hFthfCKVS
         GUjmSx1vemdX3hAm+76WbVmFeeUCxfWjxksWciOsmQ6Fhq+1Xu0I3ee248m+KPpaY8J+
         OKxy9u8a9GuokwP2TwhaNowSazwVRwewpgU9aOv89hXBn76vchf9bjW5cOkkH2EOsREz
         F1ZWyb7Ul0dWJnaAklDMNZL7kT3Qlm5daP81dPF5/+3PYZio16atTD27gvHnn0lDzTy1
         NIeg==
X-Gm-Message-State: AFqh2kpJwcS2L3n0gcJpgOwdBr/2PGYGj+MwdEx7zQJf+JlCwysn3Qmn
        aTaKqn97yIH8tuXhfTp3XiBBQhB0DoP76PTUsIM=
X-Google-Smtp-Source: AMrXdXv9TR45yTu5J8n/KtpPRdnwCt1e6kf+752907k36orqSqB62CpJaB2+AQ0hBUy+H8mFttEH+RDsXM7A0Jx9vFk=
X-Received: by 2002:a17:906:388:b0:7c1:1f2b:945f with SMTP id
 b8-20020a170906038800b007c11f2b945fmr1676696eja.302.1672350248384; Thu, 29
 Dec 2022 13:44:08 -0800 (PST)
MIME-Version: 1.0
References: <20221223133618.10323-1-liuxin350@huawei.com>
In-Reply-To: <20221223133618.10323-1-liuxin350@huawei.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 29 Dec 2022 13:43:56 -0800
Message-ID: <CAEf4BzYYvs0TgA5aE41z7_ZQ8qa0=ird3P4hCFn3Xxj7km49-w@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: fix errno is overwritten after being closed.
To:     Xin Liu <liuxin350@huawei.com>
Cc:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, yanan@huawei.com,
        wuchangye@huawei.com, xiesongyang@huawei.com,
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

On Fri, Dec 23, 2022 at 5:36 AM Xin Liu <liuxin350@huawei.com> wrote:
>
> In the ensure_good_fd function, if the fcntl function succeeds but
> the close function fails, ensure_good_fd returns a normal fd and
> sets errno, which may cause users to misunderstand. The close
> failure is not a serious problem, and the correct FD has been
> handed over to the upper-layer application. Let's restore errno here.
>
> Signed-off-by: Xin Liu <liuxin350@huawei.com>
> ---
>  tools/lib/bpf/libbpf_internal.h | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
> index 377642ff51fc..98333a6c38e9 100644
> --- a/tools/lib/bpf/libbpf_internal.h
> +++ b/tools/lib/bpf/libbpf_internal.h
> @@ -543,10 +543,9 @@ static inline int ensure_good_fd(int fd)
>                 fd = fcntl(fd, F_DUPFD_CLOEXEC, 3);
>                 saved_errno = errno;
>                 close(old_fd);
> -               if (fd < 0) {
> +               errno = saved_errno;
> +               if (fd < 0)
>                         pr_warn("failed to dup FD %d to FD > 2: %d\n", old_fd, -saved_errno);
> -                       errno = saved_errno;

pr_warn calls into user-provided callback, which can clobber errno, so
`errno = saved_errno` should happen after pr_warn. With your change
there is even higher chance of errno clobbering.

Please send a follow up fix to unconditionally restore errno *after*
pr_warn, thanks.

> -               }
>         }
>         return fd;
>  }
> --
> 2.33.0
>
