Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B66C5C92D2
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2019 22:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbfJBUWV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Oct 2019 16:22:21 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46577 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727304AbfJBUWU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Oct 2019 16:22:20 -0400
Received: by mail-qt1-f195.google.com with SMTP id u22so356460qtq.13;
        Wed, 02 Oct 2019 13:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fcINkAGrhaxybz9we0aCJ9+w9JUp7C0z8Gn94WWvQGI=;
        b=BjDZyYgjhfxWcP3NTWkt0mMF/bAuMBjpivsjx7HfXOrCmMr1getLWzGJso+UuJ3zdb
         K2PaFVMLXTGS2/r7nMFf3pMjf2yg+79Eb3x+suEdXJWcBAvvMgbMyAObfJWypFt4a+ED
         EooK5rxib95WH0eMz1mwL2sTqVbbyFjGDt7vRPwi8HL7liGAwYiknyv2hIDssS5zx8fQ
         +QR9Fg0ISZPTwmpGpTI10DbOIKVhpSq9LC/tPUfDLtZWjBgZfOnjGWTcglvLdmyGJZoS
         vPVYma+ZxpAM7X63vm2eRkThUj42ZUGXwEohT+v+JpVo27Kf9BhZAG/m/ebC8JUIiR4m
         4lAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fcINkAGrhaxybz9we0aCJ9+w9JUp7C0z8Gn94WWvQGI=;
        b=qHSqfwUAPJ+kLMeh/Qr708AdeG6ljvpRPvvRY0lDCmvTcG5YCxVLFP4ZnJWXlbu+sX
         OoqY5NFIaR5u3MLdRWOl2Ok69PmOs84ywmwzIp4rRSxnkQx/ZvUt0cYh86XculpLO6zn
         eqOGNs/SaFHLHVQZ9NIyOszRemXiPwCO04sG32suDU34C4jFXZ3h7DFGAKWPRd9T/YAg
         2WUteIGNnpmqfeQyxZj+mICcke1RsQg8efsh2jrGKtQVmmBIk9t5JCG6cqYduIQfrqIz
         Tsx6n0ri93VmKgk117ImSqq4MVOlNhWgWwqY4j+Jyax9xlajm/PYiLFzGW03MmZHwd92
         fTMw==
X-Gm-Message-State: APjAAAUlDw7kTrA8O82dmChMwK5P6oofKV2J12T7xW7RtY1Y3b7yfK8B
        pIBxvl0CBTTsXcREhca5fqKW1CBfn5iSbzI7bwI=
X-Google-Smtp-Source: APXvYqySHhkOEsIOcVw93B6ZEj9ZGqCCSVJ5Fhmq8QghLWxsWgfgVCA11vGgq5CpwZLlJ86+S07y5uvgJMmXx5yUg7I=
X-Received: by 2002:ac8:1417:: with SMTP id k23mr5869128qtj.93.1570047739558;
 Wed, 02 Oct 2019 13:22:19 -0700 (PDT)
MIME-Version: 1.0
References: <20191002191652.11432-1-kpsingh@chromium.org>
In-Reply-To: <20191002191652.11432-1-kpsingh@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 2 Oct 2019 13:22:08 -0700
Message-ID: <CAEf4BzY4tXd=sHbkN=Bbhj5=7=W_PBs_BB=wjGJ4-bHenKz6sw@mail.gmail.com>
Subject: Re: [PATCH v2] samples/bpf: Add a workaround for asm_inline
To:     KP Singh <kpsingh@chromium.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Florent Revest <revest@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Florent Revest <revest@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 2, 2019 at 12:17 PM KP Singh <kpsingh@chromium.org> wrote:
>
> From: KP Singh <kpsingh@google.com>
>
> This was added in:
>
>   commit eb111869301e ("compiler-types.h: add asm_inline definition")
>
> and breaks samples/bpf as clang does not support asm __inline.
>
> Co-developed-by: Florent Revest <revest@google.com>
> Signed-off-by: Florent Revest <revest@google.com>
> Signed-off-by: KP Singh <kpsingh@google.com>
> ---
>
> Changes since v1:
>
> - Dropped the rename from asm_workaround.h to asm_goto_workaround.h
> - Dropped the fix for task_fd_query_user.c as it is updated in
>   https://lore.kernel.org/bpf/20191001112249.27341-1-bjorn.topel@gmail.com/
>
>  samples/bpf/asm_goto_workaround.h | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/samples/bpf/asm_goto_workaround.h b/samples/bpf/asm_goto_workaround.h
> index 7409722727ca..7048bb3594d6 100644
> --- a/samples/bpf/asm_goto_workaround.h
> +++ b/samples/bpf/asm_goto_workaround.h
> @@ -3,7 +3,8 @@
>  #ifndef __ASM_GOTO_WORKAROUND_H
>  #define __ASM_GOTO_WORKAROUND_H
>
> -/* this will bring in asm_volatile_goto macro definition
> +/*
> + * This will bring in asm_volatile_goto and asm_inline macro definitions
>   * if enabled by compiler and config options.
>   */
>  #include <linux/types.h>
> @@ -13,5 +14,15 @@
>  #define asm_volatile_goto(x...) asm volatile("invalid use of asm_volatile_goto")
>  #endif
>
> +/*
> + * asm_inline is defined as asm __inline in "include/linux/compiler_types.h"
> + * if supported by the kernel's CC (i.e CONFIG_CC_HAS_ASM_INLINE) which is not
> + * supported by CLANG.
> + */
> +#ifdef asm_inline
> +#undef asm_inline
> +#define asm_inline asm
> +#endif

Would it be better to just #undef CONFIG_CC_HAS_ASM_INLINE for BPF programs?

> +
>  #define volatile(x...) volatile("")
>  #endif
> --
> 2.20.1
>
