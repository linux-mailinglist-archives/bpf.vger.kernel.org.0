Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34D0126260B
	for <lists+bpf@lfdr.de>; Wed,  9 Sep 2020 06:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725826AbgIIEE4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Sep 2020 00:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgIIEEz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Sep 2020 00:04:55 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159C9C061573
        for <bpf@vger.kernel.org>; Tue,  8 Sep 2020 21:04:55 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id r7so887801ybl.6
        for <bpf@vger.kernel.org>; Tue, 08 Sep 2020 21:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2CsLZbBYh+8LVih5FzY6aP/SCaU/+SVAIgbsCjSp6hk=;
        b=oTY6rwGKC5Fw50aSjUUM0MymxJXtJeu5R2Nku7fy/gpTixuTHAvc5dt0yCWqH6X/d8
         V3B17W8yf3YZmeaf7haqWCT8o3l7xd5/Cp65vMCea1OT0tjkuTO30/SoDrz3gfSybFRT
         PW+uoNehGBVh3JGDeKJgswMXl2DcRPc/Zq4o1S38eUvxG7h6Pl4L9EMfm3obeXSw5kLk
         Wgad28tQvoSS64433Cm27jpCBUbru6/uWos75WNFDG2qGRbr3Hq/HXJ3T1+iZnI4Avyj
         xetqySDb+MJK2uVoU4XyOupcT5P0lbjZ/qcaIIZJwn3ReGO/3mtt9JQfMLwPVJYjI5vq
         LVyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2CsLZbBYh+8LVih5FzY6aP/SCaU/+SVAIgbsCjSp6hk=;
        b=bN9ZIOfeiVy9Bg+FPwJTHPODF2Pn7KBui5vap34mtTvPUjtmoVNcXryvgpl6dkFOfb
         lM0BypNflOdhYlomMFBnQsPTX6WHBakRHmnpNCXWdZ5lEeEUJVTkjAKF/TArcx0WUDs/
         zKS2HSCOgc7g7NEAJJos13PrQWYCI1MidfZavDbjPbgudJoaY5b+PuDDi9jgEXjD1WMv
         Qw3VZUDPcMpfvERn6BVnGXdLH75JbKi1Mrniv0ieRcvl+WJO4Fp3YHldZ3w+DICU4vOi
         aDStHBpVbFk2KRRoMxbmJ1OrsOC43Q17sjJDca3/F4nCxKkBnxTitzSnHzqU6alrkXt8
         y7Ow==
X-Gm-Message-State: AOAM5323gB01H2jSliWCXr4nobap61AL+fYjjVWkj91hUyoB+ozES+WL
        mUjFI7QvYR5K0FiuvaV/ueX+6v5p4P9bxlpb9ks=
X-Google-Smtp-Source: ABdhPJysvvW49Gv3MCsjl1HIv+y8LAV9a15BN8WfgJM6K9zPPX3ZtmSAa15wkY/IMtBx0HvPn2DResM6yL7XyVCA8/o=
X-Received: by 2002:a25:ef43:: with SMTP id w3mr2811856ybm.230.1599624294254;
 Tue, 08 Sep 2020 21:04:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200904112401.667645-1-lmb@cloudflare.com> <20200904112401.667645-2-lmb@cloudflare.com>
In-Reply-To: <20200904112401.667645-2-lmb@cloudflare.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 8 Sep 2020 21:04:43 -0700
Message-ID: <CAEf4BzbyRGR0zcxcKU3qudgoJnm7gB7qgfOj-5g7u68LyHqxvQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 01/11] btf: Fix BTF_SET_START_GLOBAL macro
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 4, 2020 at 4:30 AM Lorenz Bauer <lmb@cloudflare.com> wrote:
>
> The extern symbol declaration should be on the BTF_SET_START macro, not
> on BTF_SET_START_GLOBAL, since in the global case the symbol will be
> declared in a header somewhere.

See below about my confusion. But besides that, is there any problem
to have this extern in both BTF_SET_START and BTF_SET_START_GLOBAL?
Are there any problems caused by this? This commit message doesn't
explain what problem it's trying to solve.

>
> Fixes: eae2e83e6263 ("bpf: Add BTF_SET_START/END macros")
> Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
> ---
>  include/linux/btf_ids.h       | 6 +++---
>  tools/include/linux/btf_ids.h | 6 +++---
>  2 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
> index 210b086188a3..42aa667d4433 100644
> --- a/include/linux/btf_ids.h
> +++ b/include/linux/btf_ids.h
> @@ -121,7 +121,8 @@ asm(                                                        \
>
>  #define BTF_SET_START(name)                            \
>  __BTF_ID_LIST(name, local)                             \
> -__BTF_SET_START(name, local)
> +__BTF_SET_START(name, local)                           \
> +extern struct btf_id_set name;
>
>  #define BTF_SET_START_GLOBAL(name)                     \
>  __BTF_ID_LIST(name, globl)                             \
> @@ -131,8 +132,7 @@ __BTF_SET_START(name, globl)
>  asm(                                                   \
>  ".pushsection " BTF_IDS_SECTION ",\"a\";      \n"      \
>  ".size __BTF_ID__set__" #name ", .-" #name "  \n"      \
> -".popsection;                                 \n");    \
> -extern struct btf_id_set name;
> +".popsection;                                 \n");
>
>  #else
>
> diff --git a/tools/include/linux/btf_ids.h b/tools/include/linux/btf_ids.h
> index 210b086188a3..42aa667d4433 100644
> --- a/tools/include/linux/btf_ids.h
> +++ b/tools/include/linux/btf_ids.h
> @@ -121,7 +121,8 @@ asm(                                                        \
>
>  #define BTF_SET_START(name)                            \
>  __BTF_ID_LIST(name, local)                             \
> -__BTF_SET_START(name, local)
> +__BTF_SET_START(name, local)                           \
> +extern struct btf_id_set name;
>
>  #define BTF_SET_START_GLOBAL(name)                     \
>  __BTF_ID_LIST(name, globl)                             \
> @@ -131,8 +132,7 @@ __BTF_SET_START(name, globl)
>  asm(                                                   \
>  ".pushsection " BTF_IDS_SECTION ",\"a\";      \n"      \
>  ".size __BTF_ID__set__" #name ", .-" #name "  \n"      \
> -".popsection;                                 \n");    \
> -extern struct btf_id_set name;
> +".popsection;                                 \n");
>

This diff is extremely misleading. It's actually BTF_SET_END macro.
Coupled with your commit message, it's double-misleading, because you
are moving extern declaration from BTF_SET_END (which is used with
both BTF_SET_START and BTF_SET_START_GLOBAL) to BTF_SET_START. Not
from BTF_SET_START_GLOBAL to BTF_SET_START (as your commit message
implies, at least that's how I read it).

>  #else
>
> --
> 2.25.1
>
