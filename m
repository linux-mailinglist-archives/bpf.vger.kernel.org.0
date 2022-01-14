Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB5348E2AD
	for <lists+bpf@lfdr.de>; Fri, 14 Jan 2022 03:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236116AbiANCvL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Jan 2022 21:51:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236108AbiANCvL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Jan 2022 21:51:11 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131B1C061574
        for <bpf@vger.kernel.org>; Thu, 13 Jan 2022 18:51:11 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id m13so12210450pji.3
        for <bpf@vger.kernel.org>; Thu, 13 Jan 2022 18:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hyCirsKl9VXY1tHnRy62IKOeqesnBMNFvlN5Se5j92Q=;
        b=jfXX9lb541hwNLxpp4gt2Qy+Yo7Nlrx4aeumlZxrY568eHZdNJN4uUtUsR4OFPpR5X
         VL2azoJieZ3eKWfGpShU7g1BECwkbVt0/y6nBJw+Z/K+kuXsmS9wH67MYTEXNPHNb1Lp
         JBEvk/LAimnjq+rN3g3az7eT1iwOqFOI2kx6t6wVKvxGfzK60yltAuarP6lphXEnOEbe
         PisA1u7MC/I/36Ojoa+lGbsLCCqfor4VGPRD7bQgHEgWKXstkMiW7T6JPpJuWsi61QT1
         indBb91lZ23Eh0Q9M8vqaG20GokXI69Afy/420aqvIJXaZC+3ww0S40LvQ/0GW2HFDwj
         wpIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hyCirsKl9VXY1tHnRy62IKOeqesnBMNFvlN5Se5j92Q=;
        b=M5SIm7aD7ftpPb5/IajOKdqYAc8iRLH+BhHghfQpPAOURFoQdFi5wgJ9dijh6EEWNb
         EGb7Pnq44hTFyWTtGyrm10lZD4iUvKCC2dg98QslkTVJFRTf5SJPv+yahPLuSqwWd4IE
         dUd4WFpk+wNtCG/B49PlF8tMqK6Y+mJ3VWpa22gsei0fu0g5E4VdGI14V0gOVSYw4LYa
         Jg9KGctJKr+Rzkc2Z1WCiuumyc7kQ/pYvcIo6fdE22tOPNY0ujh0feXyzgJl+qSzctnP
         w5eDFhzYAmGA0ZzZC0cy+0wywbVzPP/HG2JaMBEkPUgS09adxcULln975NIhRU/zvP6H
         Sjaw==
X-Gm-Message-State: AOAM530LmjRctBypbeXbEi5mn0i8xyHzYqNh29C4XuPIsYbLedT0Dcyt
        ZBUNj7ULxrRY8A1Q4hHtYmf7ss0lnCJ6EC4stA9DHe6S
X-Google-Smtp-Source: ABdhPJwRkNWUzuuPWlX4bjZKqEbJiu7+Q4avcEqpl8ko7Qp5NOjv/aRCo3S0r2mjWoqVcSJ78gKcHZ1Hc7miB7kHW7s=
X-Received: by 2002:a17:90b:224c:: with SMTP id hk12mr8330071pjb.62.1642128670562;
 Thu, 13 Jan 2022 18:51:10 -0800 (PST)
MIME-Version: 1.0
References: <20220113233158.1582743-1-kennyyu@fb.com> <20220114004900.3756025-1-kennyyu@fb.com>
 <20220114004900.3756025-3-kennyyu@fb.com>
In-Reply-To: <20220114004900.3756025-3-kennyyu@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 13 Jan 2022 18:50:59 -0800
Message-ID: <CAADnVQKmdrXi=6AZbg6+-YG2d08PxuJ0D+z0FqT175jXra1f_w@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/4] bpf: Add support for sleepable programs
 in bpf_iter_run_prog
To:     Kenny Yu <kennyyu@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 13, 2022 at 4:49 PM Kenny Yu <kennyyu@fb.com> wrote:
>
> The next patch adds the ability to create sleepable bpf iterator programs.
> This changes `bpf_iter_run_prog` to use the appropriate synchronization for
> sleepable bpf programs. With sleepable bpf iterator programs, we can no
> longer use `rcu_read_lock()` and must use `rcu_read_lock_trace()` instead
> to protect the bpf program.
>
> Signed-off-by: Kenny Yu <kennyyu@fb.com>
> ---
>  kernel/bpf/bpf_iter.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
> index b7aef5b3416d..d814ca6454af 100644
> --- a/kernel/bpf/bpf_iter.c
> +++ b/kernel/bpf/bpf_iter.c
> @@ -5,6 +5,7 @@
>  #include <linux/anon_inodes.h>
>  #include <linux/filter.h>
>  #include <linux/bpf.h>
> +#include <linux/rcupdate_trace.h>
>
>  struct bpf_iter_target_info {
>         struct list_head list;
> @@ -684,11 +685,20 @@ int bpf_iter_run_prog(struct bpf_prog *prog, void *ctx)
>  {
>         int ret;
>
> -       rcu_read_lock();
> -       migrate_disable();
> +       if (prog->aux->sleepable) {
> +               rcu_read_lock_trace();

Pretty cool that a single 'if' is all that is needed to enable
sleepable iterators.

Maybe combine under one 'if' ?
if (prog->aux->sleepable) {
  lock_trace
  migr_dis
  might_fault
  bpf_prog_run
  migr_en
  unlock_trace
} else {
  lock
  migr_dis
  bpf_prog_run
  migr_end
  unlock
}

Would it be easier to read?
