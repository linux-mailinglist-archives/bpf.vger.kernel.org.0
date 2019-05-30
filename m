Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81A742FB27
	for <lists+bpf@lfdr.de>; Thu, 30 May 2019 13:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfE3LwX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 May 2019 07:52:23 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35500 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbfE3LwX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 May 2019 07:52:23 -0400
Received: by mail-ot1-f67.google.com with SMTP id n14so5326342otk.2
        for <bpf@vger.kernel.org>; Thu, 30 May 2019 04:52:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vAN+W8HMPR+e2EfUykPuPve3XAe6lmTzwXCfaLwdSz8=;
        b=tnv5BzXe04vkJMO9ZdqVhCkg0v1prdLyYeG+1pUElr1elyP1bxyZsaE1ucvsUEs1OU
         cGmwvx69H7o2ytlIqzqfy2kATP4p45f7Q8hOrDlQN95hLRFv6YwwnS6ZgzKoiC9pqAYf
         ssYU/N3p7hNQa8BizuU6eAzCCUxZgQg2l35dKPOWjyHxqkxDOpHhss6WVN3Wt+11tJKw
         u1FSarByhlUQjZu7XTuIpBVhCBVHDdx9nUgd+cy1aEEzqBm7MYmcNbXCcBzt82DTyE84
         WnP6xXmpMxC2CvyTMCsMr+PimTmc8FoMd56gYpuJvveUgYzVkZX5Kt42WLj9q5+GCWQw
         Ur4w==
X-Gm-Message-State: APjAAAXVXxDglvPmUVCtZKzTxkmg643I55TqlKp6XS3z7mj4VD7YuahE
        P7V3iLamtHUBU8oc1oAaZuZla/ixJk6rvwzy7n5rK/TFGsA=
X-Google-Smtp-Source: APXvYqxKpCp2brBM13KsmN/4s51AkFDodgy602B18KVX9OGtDboNvG1r1eWhhRO2gFVi4V5WEVlWY0LUDFO4YhGMEBE=
X-Received: by 2002:a05:6830:154c:: with SMTP id l12mr2235146otp.66.1559217143019;
 Thu, 30 May 2019 04:52:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190530035310.GA9127@zhanggen-UX430UQ> <CAFqZXNv-54DJhd8gyUhwDo6RvmjFGSHo=+s-BVsL87S+u0cQxQ@mail.gmail.com>
 <20190530085106.GA2711@zhanggen-UX430UQ>
In-Reply-To: <20190530085106.GA2711@zhanggen-UX430UQ>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 30 May 2019 13:52:12 +0200
Message-ID: <CAFqZXNuVVTL4FmBRvsZri+tvv4T4U47tMLjTZvSr7Cro=hR5Dg@mail.gmail.com>
Subject: Re: [PATCH v2] hooks: fix a missing-check bug in selinux_sb_eat_lsm_opts()
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

On Thu, May 30, 2019 at 10:51 AM Gen Zhang <blackgod016574@gmail.com> wrote:
> In selinux_sb_eat_lsm_opts(), 'arg' is allocated by kmemdup_nul(). It
> returns NULL when fails. So 'arg' should be checked.
>
> Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
> Fixes: 99dbbb593fe6 ("selinux: rewrite selinux_sb_eat_lsm_opts()")
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
> +                                       return -ENOMEM;
>                         }
>                         rc = selinux_add_opt(token, arg, mnt_opts);
>                         if (unlikely(rc)) {

Looking at the callers of security_sb_eat_lsm_opts() (which is the
function that eventually calls the selinux_sb_eat_lsm_opts() hook),
-ENOMEM should be appropriate here.

Reviewed-by: Ondrej Mosnacek <omosnace@redhat.com>

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.
