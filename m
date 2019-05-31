Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF7E531182
	for <lists+bpf@lfdr.de>; Fri, 31 May 2019 17:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfEaPpm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 31 May 2019 11:45:42 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41334 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfEaPpm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 31 May 2019 11:45:42 -0400
Received: by mail-lf1-f66.google.com with SMTP id 136so8273653lfa.8
        for <bpf@vger.kernel.org>; Fri, 31 May 2019 08:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/DZt8luZx8AZd+g3OwucXhV/souOkAqU6IAlufN+JIw=;
        b=fRr515esaIOr8mkEww0IKDtMKmNftE282RImc1BVF4NJkoyzWycXVzqJGvuIhA4tRg
         yGD98Ugj6GLQCyZr2JaDPuomsu1bWjRPzuDOz5QxW4SEF/qpmGwOeTDYHxJmmhOgcpvh
         YTD8txi1NP7Tf93arKTMnQTYJzJOeBgEcuaR9Nk9UIfApiKPLOM9OKvKzoFI65b+en8G
         mqoQU8m/U/4AUlvwyEhuXXJiWSMQGVpS8baWkvBUint97bO4se4HJHQ4vXPI0pA6nHPM
         QiOQRZe0fXT8C240IXihy/Ku1XNTcuFvmFzZNCsaPzcfS7NIiVdploSAO975KD9bFmyl
         O+bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/DZt8luZx8AZd+g3OwucXhV/souOkAqU6IAlufN+JIw=;
        b=I5UZ4yHraH5y1BVF/3gR+vxY5w04zIyymRhQ9h0DFEhn1g+LmCE3U+zLjLGYFxu56W
         fy8SieEKlHvkSse+Cop3Kw+JzxADPkRukLfbnMeklcqirHhJp1ZXQZ0m7f7NP71JdTqQ
         h+X3GtiIRNpGoNrSI6/eJx7ZfhNhznW9pio/8pXZYplbSFgDAHlpQlsxUPwRkNfskyNO
         iNDR8DEHsyQSDyfOgkeXhZn7yM9oBr41o7bt2kYaT1rPj76hu5gIlR5kvZBpNy/60/pm
         MxHmc/kEwG2R+8m4cbBjJoVY8aFpreC0h46MDl+V+TeufkedXx+Bqfd+EfNA/cMxN438
         ctpg==
X-Gm-Message-State: APjAAAUOcjM141hImEP5uEfUZUPyENlXMaClQErBNDt3SU5rfZEh6m2y
        CtXYe0J8CB3OeumTrb7vo6kmp4QeP9W5aE0aBEOC
X-Google-Smtp-Source: APXvYqzFztIsHezNj4wOvdAK/eHaIBSHz130vzxCSTL8AZkALwTZeT3dQxZbC5UR86jbnMY3vWbN4D58tPPMshgs18U=
X-Received: by 2002:a19:c301:: with SMTP id t1mr6164138lff.137.1559317540060;
 Fri, 31 May 2019 08:45:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190531013350.GA4642@zhanggen-UX430UQ>
In-Reply-To: <20190531013350.GA4642@zhanggen-UX430UQ>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 31 May 2019 11:45:28 -0400
Message-ID: <CAHC9VhTmj8b9jYMaXd=ORhBgTAWUgF=srgqAXkECe7MFkDXOmg@mail.gmail.com>
Subject: Re: [PATCH v2] hooks: fix a missing-check bug in selinux_sb_eat_lsm_opts()
To:     Gen Zhang <blackgod016574@gmail.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 30, 2019 at 9:34 PM Gen Zhang <blackgod016574@gmail.com> wrote:
>
> In selinux_sb_eat_lsm_opts(), 'arg' is allocated by kmemdup_nul(). It
> returns NULL when fails. So 'arg' should be checked.
>
> Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
> Reviewed-by: Ondrej Mosnacek <omosnace@redhat.com>
> Fixes: 99dbbb593fe6 ("selinux: rewrite selinux_sb_eat_lsm_opts()")

One quick note about the subject line, instead of using "hooks:" you
should use "selinux:" since this is specific to SELinux.  If the patch
did apply to the LSM framework as a whole, I would suggest using
"lsm:" instead of "hooks:" as "hooks" is too ambiguous of a prefix.

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 3ec702c..5a9e959 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2635,6 +2635,8 @@ static int selinux_sb_eat_lsm_opts(char *options, void **mnt_opts)
>                                                 *q++ = c;
>                                 }
>                                 arg = kmemdup_nul(arg, q - arg, GFP_KERNEL);
> +                               if (!arg)
> +                                       return -ENOMEM;

It seems like we should also check for, and potentially free *mnt_opts
as the selinux_add_opt() error handling does just below this change,
yes?  If that is the case we might want to move that error handling
code to the bottom of the function and jump there on error.

>                         }
>                         rc = selinux_add_opt(token, arg, mnt_opts);
>                         if (unlikely(rc)) {

-- 
paul moore
www.paul-moore.com
