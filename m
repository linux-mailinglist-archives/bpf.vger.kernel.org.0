Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 653042B12EF
	for <lists+bpf@lfdr.de>; Fri, 13 Nov 2020 00:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgKLX7e (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Nov 2020 18:59:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbgKLX7e (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Nov 2020 18:59:34 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FBCAC0613D4
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2020 15:59:33 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id s30so11196164lfc.4
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2020 15:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NB51xM3BxnxRj+T4GWFKGqQkGCdh1sfty5MaDk0BKUw=;
        b=F7tRh11KDuKimmVjHebWItlcGSDD0/Be8iksXTMbQjusEcapiZ4EkkkZbE5ewTBKB9
         +Vm7qrxXE7b0yUW58JBQeQ8EreLtCmievgWdwBr0J7/9hCsMNt2+KrdHnjYXlCREqBHk
         DqvzdAZcVfypEtn03x+CNhCqQLVatv8X1aCqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NB51xM3BxnxRj+T4GWFKGqQkGCdh1sfty5MaDk0BKUw=;
        b=IHGvaabBh+vh/NHR0+cnZwC1rpgmw1i5tGKxW4CAS6191W318Nk45OKtq5L+0gLC/F
         1ubWVXwRC2z7ntJ+YwoTE1zV8XH/czLp7lnHxKcK/fphbAPZxz31sPr4KtIltfafqhff
         GdIatuanOpYHar3gy8neDVJMPVW1f5l6ZwYXQ18OQ52kd5JVd4ZuCidqeqqoMfbxj//1
         ilJlHlZgd+gA73WnLAQJNDhQPkBzIdz4UdYzxuYl6r0gHsIN7fRb8w2yTa2p/5fTbSrJ
         eZRm+6HzxbTez7oRLD/GHPNmavSGackmMmc1WUboNgBJzO+V8k6QS/rEQXy65BfJGQzE
         Q6cA==
X-Gm-Message-State: AOAM532Q2SA9BSW10ss1S0touaNGOZv8iYzfC/ZqqIn2lhguYXNCtvax
        ukOdVLEucDqIfxABTaJR5+/PPcvTWEAPKdGhlwHh1w==
X-Google-Smtp-Source: ABdhPJxjjUgLoSp5F/NaxeYSaIcFGjf6CMUOlMjZ1xtTbxZYQjHeJQJb2/q4V6vxbFVZzmlF8bgCp7GheYo8k7K3a4w=
X-Received: by 2002:a05:6512:34d3:: with SMTP id w19mr710469lfr.418.1605225572038;
 Thu, 12 Nov 2020 15:59:32 -0800 (PST)
MIME-Version: 1.0
References: <20201112200346.404864-1-kpsingh@chromium.org> <20201112200346.404864-2-kpsingh@chromium.org>
 <5d22e146-0dd1-2054-c718-fa76f8dfa7b9@iogearbox.net>
In-Reply-To: <5d22e146-0dd1-2054-c718-fa76f8dfa7b9@iogearbox.net>
From:   KP Singh <kpsingh@chromium.org>
Date:   Fri, 13 Nov 2020 00:59:21 +0100
Message-ID: <CACYkzJ4ijbX5_k1yf6sh6rMDX72qAT9XTxVgSKhG0MfBMPYC7Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Augment the set of sleepable LSM hooks
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Jann Horn <jannh@google.com>,
        Hao Luo <haoluo@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 12, 2020 at 11:35 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 11/12/20 9:03 PM, KP Singh wrote:
> > From: KP Singh <kpsingh@google.com>
> >
> > Update the set of sleepable hooks with the ones that do not trigger
> > a warning with might_fault() when exercised with the correct kernel
> > config options enabled, i.e.

[...]

>
> I think this is very useful info. I was wondering whether it would make sense
> to annotate these more closely to the code so there's less chance this info
> becomes stale? Maybe something like below, not sure ... issue is if you would
> just place a cant_sleep() in there it might be wrong since this should just
> document that it can be invoked from non-sleepable context but it might not
> have to.

Indeed, this is why I did not make an explicit cant_sleep() call for these hooks
in __bpf_prog_enter (with a change in the signature to pass struct *prog).

> diff --git a/security/security.c b/security/security.c
> index a28045dc9e7f..7899bf32cdaa 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -94,6 +94,11 @@ static __initdata bool debug;
>                          pr_info(__VA_ARGS__);                   \
>          } while (0)
>
> +/*
> + * Placeholder for now to document that hook implementation cannot sleep
> + * since it could potentially be called from non-sleepable context, too.
> + */
> +#define hook_cant_sleep()              do { } while (0)

Good idea!

At the very least, we can update the comments in lsm_hooks.h
which already mention some of the LSM hooks as being called from
non-sleepable contexts.

I will remove this comment, send a separate patch to security folks
and respin these patches.

-KP

> +
>   static bool __init is_enabled(struct lsm_info *lsm)
>   {
>          if (!lsm->enabled)
> @@ -2522,6 +2527,7 @@ void security_bpf_map_free(struct bpf_map *map)
>   }
>   void security_bpf_prog_free(struct bpf_prog_aux *aux)
>   {
> +       hook_cant_sleep();
>          call_void_hook(bpf_prog_free_security, aux);
>   }
>   #endif /* CONFIG_BPF_SYSCALL */
