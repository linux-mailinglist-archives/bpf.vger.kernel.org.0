Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC8432F87D
	for <lists+bpf@lfdr.de>; Thu, 30 May 2019 10:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbfE3I2y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 May 2019 04:28:54 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39469 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbfE3I2y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 May 2019 04:28:54 -0400
Received: by mail-oi1-f193.google.com with SMTP id v2so4312898oie.6
        for <bpf@vger.kernel.org>; Thu, 30 May 2019 01:28:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a4/V6C9EK4vY7/JLXibmWc3UiOpGTZPM0ljUbojs3aI=;
        b=Iz4xEnsFwuXUaQ22ykefblBhAiw1HkMgOEEujvXWN/haK7x5O0/7gvE51ON9GKkf4t
         MRWOuTiRsjbZAOmMyTr2crz2uD/dyB3Y09fuVjI6czhX5ymflKTduhJKsVd299z/J3Bj
         sD0jpLQh7DaZ+wJCZIHk5xPAp6Pl7rujvDW8ms7L56gUuX+2BQE5iLnOPMAjGAGAO79T
         ZVmwlNfMI7YWh/GfuWe/8ZXC0/VzGRJKEhIe0DUssOFQc0+Ze+7Ksa5nbmWLCyalmVvB
         LlrbvLKLYyCt8xbsWhB6hpqk23cNRaeiIeiVZfQzRPriX7EotycKsn8YeBHrMHEeFD6T
         gATQ==
X-Gm-Message-State: APjAAAUgNh/kED7qSQ9NKKrZTtSfLvq8dZkE9QK8Y5tyg6bGyof8cSDv
        wqhJTpTeHjcJ2y8FS5mORX0QoO9IPS8j+NyF+fA9FA==
X-Google-Smtp-Source: APXvYqz8Iw8/yjTeW0ZPob8U9xgh/OrWA3XSOSxGUsJCtkPzLy3bnytgOFnAYpOTDJoJ1VvfTiEd8WIOqAIMIBngZT4=
X-Received: by 2002:aca:e146:: with SMTP id y67mr1244852oig.127.1559204933231;
 Thu, 30 May 2019 01:28:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190530035310.GA9127@zhanggen-UX430UQ>
In-Reply-To: <20190530035310.GA9127@zhanggen-UX430UQ>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 30 May 2019 10:28:46 +0200
Message-ID: <CAFqZXNv-54DJhd8gyUhwDo6RvmjFGSHo=+s-BVsL87S+u0cQxQ@mail.gmail.com>
Subject: Re: [PATCH] hooks: fix a missing-check bug in selinux_sb_eat_lsm_opts()
To:     Gen Zhang <blackgod016574@gmail.com>
Cc:     Paul Moore <paul@paul-moore.com>, tony.luck@intel.com,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 30, 2019 at 5:53 AM Gen Zhang <blackgod016574@gmail.com> wrote:
> In selinux_sb_eat_lsm_opts(), 'arg' is allocated by kmemdup_nul(). It
> returns NULL when fails. So 'arg' should be checked.
>
> Signed-off-by: Gen Zhang <blackgod016574@gmail.com>

Since it looks like you are going to respin this patch, please add:

Fixes: 99dbbb593fe6 ("selinux: rewrite selinux_sb_eat_lsm_opts()")

to the commit message so that there is a record of which commit
introduced the issue (then it can be picked up automatically for
backport into the relevant stable kernels).

Thanks for spotting the issue and sending the patch(es)!

> ---
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 3ec702c..5a9e959 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2635,6 +2635,8 @@ static int selinux_sb_eat_lsm_opts(char *options, void **mnt_opts)
>                                                 *q++ = c;
>                                 }
>                                 arg = kmemdup_nul(arg, q - arg, GFP_KERNEL);
> +                               if (!arg)
> +                                       return 0;
>                         }
>                         rc = selinux_add_opt(token, arg, mnt_opts);
>                         if (unlikely(rc)) {

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.
