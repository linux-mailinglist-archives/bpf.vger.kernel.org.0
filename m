Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 940EB32980
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2019 09:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfFCH1k (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 Jun 2019 03:27:40 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40640 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbfFCH1k (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 3 Jun 2019 03:27:40 -0400
Received: by mail-oi1-f195.google.com with SMTP id w196so2583769oie.7
        for <bpf@vger.kernel.org>; Mon, 03 Jun 2019 00:27:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=91l+n5sLsO8XrUlcVUfMfSBih2YfyMwvOg3hnHFMMJw=;
        b=H9TaTNO6osBAg++Sipc5q9WxjEvDHurD0h/IQx0I1RltlrKUbfcn8ldSpxkTgwbU7G
         Yex78lLiX9aBl7JAq1712UjW7tou4vT4l41oN/w7bNRjZGEnRQfUPiBWMUPO8+1gtKnT
         TqQyAxkyC3DZJEd3X3NVD28zXaaQXShk+1CwWCRIuqNpUesRQUstFMqRUv3hlD3k7dGf
         PGavGXlDQQ0AiSoBEy3oSDRb7ytdtbd4145Iut7TpHEP2D5TJQxDKVzaB5yUmTJ6OlHK
         UipbzQQT56XuHGNiWuooWSfUFxB/a2jSNiVo1dSWFRi2sbEoTat1K1eGrnked7WpacgP
         5o9Q==
X-Gm-Message-State: APjAAAV6oWGenLq80X0E+sw8IxrR9n8HWfF+jka4XQzY48qVR6GBh8/w
        BB84lo+6grCuR9fZxzvD4fea/J8tRq+WyHKCF766WA==
X-Google-Smtp-Source: APXvYqy4T57mDjaHFCyHTKOwj1BaQRtES/e739DaslgYKUUjlVAXZOV5trKZ1YmsPbDI5+1eyBiTHu+dO12TFQJ5Z+Y=
X-Received: by 2002:aca:300d:: with SMTP id w13mr12937oiw.26.1559546859860;
 Mon, 03 Jun 2019 00:27:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190601021526.GA8264@zhanggen-UX430UQ>
In-Reply-To: <20190601021526.GA8264@zhanggen-UX430UQ>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 3 Jun 2019 09:27:29 +0200
Message-ID: <CAFqZXNuPMxOQeq-5evh4dSuGC-Q5sQPjbhRgCBh4Q=u6OrEi9Q@mail.gmail.com>
Subject: Re: [PATCH v3] selinux: lsm: fix a missing-check bug in selinux_sb_eat_lsm_opts()
To:     Gen Zhang <blackgod016574@gmail.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Jun 1, 2019 at 4:15 AM Gen Zhang <blackgod016574@gmail.com> wrote:
> In selinux_sb_eat_lsm_opts(), 'arg' is allocated by kmemdup_nul(). It
> returns NULL when fails. So 'arg' should be checked. And 'mnt_opts'
> should be freed when error.
>
> Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
> Reviewed-by: Ondrej Mosnacek <omosnace@redhat.com>
> Fixes: 99dbbb593fe6 ("selinux: rewrite selinux_sb_eat_lsm_opts()")
> ---
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 3ec702c..f329fc0 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2616,6 +2616,7 @@ static int selinux_sb_eat_lsm_opts(char *options, void **mnt_opts)
>         char *from = options;
>         char *to = options;
>         bool first = true;
> +       int ret;

I'd suggest just moving the declaration of 'rc' here and simply reuse
that variable. Otherwise the patch looks good to me.

>
>         while (1) {
>                 int len = opt_len(from);
> @@ -2635,15 +2636,16 @@ static int selinux_sb_eat_lsm_opts(char *options, void **mnt_opts)
>                                                 *q++ = c;
>                                 }
>                                 arg = kmemdup_nul(arg, q - arg, GFP_KERNEL);
> +                               if (!arg) {
> +                                       ret = -ENOMEM;
> +                                       goto free_opt;
> +                               }
>                         }
>                         rc = selinux_add_opt(token, arg, mnt_opts);
>                         if (unlikely(rc)) {
> +                               ret = rc;
>                                 kfree(arg);
> -                               if (*mnt_opts) {
> -                                       selinux_free_mnt_opts(*mnt_opts);
> -                                       *mnt_opts = NULL;
> -                               }
> -                               return rc;
> +                               goto free_opt;
>                         }
>                 } else {
>                         if (!first) {   // copy with preceding comma
> @@ -2661,6 +2663,12 @@ static int selinux_sb_eat_lsm_opts(char *options, void **mnt_opts)
>         }
>         *to = '\0';
>         return 0;
> +free_opt:
> +       if (*mnt_opts) {
> +               selinux_free_mnt_opts(*mnt_opts);
> +               *mnt_opts = NULL;
> +       }
> +       return ret;
>  }
>
>  static int selinux_sb_remount(struct super_block *sb, void *mnt_opts)

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.
