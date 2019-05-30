Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 281792F4A7
	for <lists+bpf@lfdr.de>; Thu, 30 May 2019 06:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729283AbfE3EkG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 May 2019 00:40:06 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39676 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729318AbfE3EkD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 May 2019 00:40:03 -0400
Received: by mail-oi1-f193.google.com with SMTP id v2so3955093oie.6;
        Wed, 29 May 2019 21:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qPfbRdCKDeTcfRBkgrMRhnVVc+q1ciJjBXfKb7kwiQs=;
        b=Ul7xklMZhWPYwNAtnEbULBCgIl5thKdpnRCERtn3kf/K6d/oAD9cIet+dzpjupV/ti
         NsdwP7dQCRwFSq1MxyPekjGTpvB1+2A2SRo96msAFWSm50IpQvUrvPHAdTYDRZb2betQ
         hMGO0nHnWE4Z1g8Q0GtXYceBhClVPBWvZ1psp+BtLLC0qzaHml92XM0Cp8MfNqi/an5e
         shzeX/ZZf4fcL0gs4uTxTIbSPXBNkHET2Cy7JMCu9NZVSYld8MGb6n8QXRyBQ0bAc02Q
         UKeQHJHtKznfk/34npkRvilz3Gtlc7ygWa8Qi5awEQMUo/VulosxyhQEm23N1P28XgUF
         +sSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qPfbRdCKDeTcfRBkgrMRhnVVc+q1ciJjBXfKb7kwiQs=;
        b=P/LCjTKQPSZ0lbU+sOj7s89OC4zRGhl1XjGnwhcaZgGmgoUH3ELCwMsHcJHI1TDLJH
         3O6H1NyezMUcnZoy8FbUzUTdKKxV99aC2lbe1Shn8cSxGvpk4bbZ5FQjA+tTvrTPp/X1
         2h+PL7jN4ER4mtIdx09r/LH8f+SMX5iFK+u3a49FKjf8+6HnImlZ282+lCknbZegloaF
         /eobR5Pzk31cgiJgjWvEJAbA6MIIwQANqjIm6RrVKZaZBdyBzIJUnLrsM9aHNMf8kVLO
         v61ztBwajlXPDL6gJEIWv01HmT5GUNBoXNY3lTUzJiN7qsbGx7UVdHr7mTI1rb4b5z5+
         PYDg==
X-Gm-Message-State: APjAAAWQABycLcTSXSc3M4yhtLTqsCIvWO+QFhct86ZbJewlGAOWy7Hh
        FEAFl0PGkH7HKP+a5nWwY45yptW7eeNR18NYNkg=
X-Google-Smtp-Source: APXvYqyUWqG99QmH2R6P/lV2F6KeYoxKbdK6QChcQ9h7BkKMxmRABLQZ4yK6l4ZLXISSf0TbimWMBp0Dx/9dHGuaUIw=
X-Received: by 2002:aca:3fc6:: with SMTP id m189mr1166957oia.124.1559191202295;
 Wed, 29 May 2019 21:40:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190530035310.GA9127@zhanggen-UX430UQ>
In-Reply-To: <20190530035310.GA9127@zhanggen-UX430UQ>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Wed, 29 May 2019 21:39:50 -0700
Message-ID: <CAFftDdrX_=7KXfbvMDdCamj84nzYB+QCGXWArD3=zEkPZsQ1eQ@mail.gmail.com>
Subject: Re: [PATCH] hooks: fix a missing-check bug in selinux_sb_eat_lsm_opts()
To:     Gen Zhang <blackgod016574@gmail.com>
Cc:     Paul Moore <paul@paul-moore.com>, tony.luck@intel.com,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 29, 2019 at 8:55 PM Gen Zhang <blackgod016574@gmail.com> wrote:
>
> In selinux_sb_eat_lsm_opts(), 'arg' is allocated by kmemdup_nul(). It
> returns NULL when fails. So 'arg' should be checked.
>
> Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
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

The routine seems to return 0 on success, why would it return 0 on ENOMEM?

>                         }
>                         rc = selinux_add_opt(token, arg, mnt_opts);
>                         if (unlikely(rc)) {
