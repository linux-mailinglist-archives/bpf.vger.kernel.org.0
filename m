Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7091C3677F6
	for <lists+bpf@lfdr.de>; Thu, 22 Apr 2021 05:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbhDVDc7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Apr 2021 23:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbhDVDc6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Apr 2021 23:32:58 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B5AC06174A;
        Wed, 21 Apr 2021 20:32:24 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id v72so29015206ybe.11;
        Wed, 21 Apr 2021 20:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dxHlgtvoXvn9RKORV+ZqAcBLqkSOd7zAiDpIufo/J9g=;
        b=uxirDz0cdZNdtB/wqvNS2E48bwtE1shK+82+vbj22ygfJmgjrhUaivA04hBl06w3un
         cA/dYZ6d1bdQAUz+OxOUfi1Y/ooWbs1AOXeMfBugYbGYkvqBX2/j/71wuBzeJwGkNDPs
         YvsanmUu+fcNnlN+v5n09/rX/4BoB4wgVNdCwSVzcous+6/4YYtPE8hUusCFoaAi2wgM
         BkEyPa2i2hhVIiI0ylrcknY4dJBrDlQvMYS5b+6OgqI2Xb0YgdhfhDsSsALBl5H+qKyk
         wVoyM6OLU20C9ZLKpKdwvJmL6jJwZNLkRlO3sEic9G5LACoB+w/lZxaUhgySehpTgPav
         m2Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dxHlgtvoXvn9RKORV+ZqAcBLqkSOd7zAiDpIufo/J9g=;
        b=RchZ2kzLtCdb6bXvDTRd5TcBeW8thzfwI2EABntA/Taqlzu4N6pmnwnuNdbOLfqbdV
         VIY9p7mLcNRjaQ8NqWusIiWkZNArEHnDk9ET5Mu3W28wmQ86PKxt9XPrQuM4d/90A/JV
         kUgqclHSniEfBOKLbU03I9whEHL2YbOrodT+JaTFHdW1DIBACyrkHhsRKuNCQSLH6947
         bttI8eBMNkDeZ6oH1B9nhvsGcrxFnLim13MOJc9qwSznX+T6JtioRP4XIF8NIKb+F2DO
         zFdNnwVVwDE2O5CfwJCnpwR26S5OqtUeZAhk9VBVa+utGdfQhtxLlE7gS+6lTG5D4THq
         DUzA==
X-Gm-Message-State: AOAM532Gt3evbVCuPN3/IXAyY79OzMQZ3KSFQJpX7TjghMO2saDV2V6+
        nTm/EPD+zX6eDNRnqMfdjleabuUDx5GB1Y2cPZg=
X-Google-Smtp-Source: ABdhPJzTL2qLrVEwrZs1aIsGNyiGiFwut9Mozw4psdb+wX5nYOEqmSRa+JtYp/m+Z4Wb7+giXr3RJ1lDPRDHdoCyJ1Y=
X-Received: by 2002:a25:9942:: with SMTP id n2mr1841844ybo.230.1619062343596;
 Wed, 21 Apr 2021 20:32:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210421190736.1538217-1-linux@rasmusvillemoes.dk>
In-Reply-To: <20210421190736.1538217-1-linux@rasmusvillemoes.dk>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 21 Apr 2021 20:32:12 -0700
Message-ID: <CAEf4Bza6-Unvr7QmcbvVtNDPc4BNzf8zMaU4XardNqB_GnGDHw@mail.gmail.com>
Subject: Re: [PATCH] bpf: remove pointless code from bpf_do_trace_printk()
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alan Maguire <alan.maguire@oracle.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 21, 2021 at 6:19 PM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> The comment is wrong. snprintf(buf, 16, "") and snprintf(buf, 16,
> "%s", "") etc. will certainly put '\0' in buf[0]. The only case where
> snprintf() does not guarantee a nul-terminated string is when it is
> given a buffer size of 0 (which of course prevents it from writing
> anything at all to the buffer).
>
> Remove it before it gets cargo-culted elsewhere.
>
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  kernel/trace/bpf_trace.c | 3 ---
>  1 file changed, 3 deletions(-)
>

The change looks good to me, but please rebase it on top of the
bpf-next tree. This is not a bug, so it doesn't have to go into the
bpf tree. As it is right now, it doesn't apply cleanly onto bpf-next.


> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index b0c45d923f0f..4ee55df84cd3 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -412,9 +412,6 @@ static __printf(1, 0) int bpf_do_trace_printk(const char *fmt, ...)
>         va_start(ap, fmt);
>         ret = vsnprintf(buf, sizeof(buf), fmt, ap);
>         va_end(ap);
> -       /* vsnprintf() will not append null for zero-length strings */
> -       if (ret == 0)
> -               buf[0] = '\0';
>         trace_bpf_trace_printk(buf);
>         raw_spin_unlock_irqrestore(&trace_printk_lock, flags);
>
> --
> 2.29.2
>
