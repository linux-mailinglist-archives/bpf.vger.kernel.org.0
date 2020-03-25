Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CAAA193121
	for <lists+bpf@lfdr.de>; Wed, 25 Mar 2020 20:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbgCYT3E (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Mar 2020 15:29:04 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41795 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727351AbgCYT3D (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Mar 2020 15:29:03 -0400
Received: by mail-pf1-f196.google.com with SMTP id z65so1535478pfz.8
        for <bpf@vger.kernel.org>; Wed, 25 Mar 2020 12:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rVEA1fnFFcIWOeL5zXMHQTp1aBPMsrLrZyBjvLPiLRU=;
        b=gPfPaVQai63uk6Om4qjYnBgTUEKBxmnzI5iwkr04eOe09U4mQ196leEbp+I9r0X+hd
         RuO4hYZwrZKxduFI/hzfN7cxCASTZhkfCKv8gJ8ZGwpfdyZXAGMrrnlzswDJqSdxTmuo
         Ug1Lw7eBXbZ87kRitG8EYK2HRjYkeioDTW9mE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rVEA1fnFFcIWOeL5zXMHQTp1aBPMsrLrZyBjvLPiLRU=;
        b=KYJtqSGh0LJqWi6V5iduNH8P29VLsqh34GJYGIUmITvy7ngUJCQlrs7DZheHTmE6VP
         UXWQaOoiXvix+laZUeH4g/P2ZOvDozMQqIe4m8hVCM1+NMqacxxH1Srnd/RNTcTPgTx6
         4rcRnBgd/Q2LZLCDWC9OseJj6s0/eg39SjJa/FcYPBc3ItntwXFQ5HFo6A6cM1YaPZyf
         H9AOKw38mCpxvsRT3jPUgSEbdKg7kkRL/SttTclhqnReXPhByn0mu9Q9I5igcgIr5R4W
         CdF718pZWBMxXvO01ZKa4XutR6niSUiMaSAOrJtSr8yE8SPGBCXTps8fkZIL6ZSYejmM
         IUaA==
X-Gm-Message-State: ANhLgQ0miMUVaOeADb81BpKmT7wZa4a2rtn7cHGPHNAzvluB5T9QTD/P
        3ZngnJHtG++7XYHN+Uqh/JmcUw==
X-Google-Smtp-Source: ADFU+vsu2Cw98SHfFXx1pKAQY4JSLE3Orstirbhflq9fp1jD+tqPTkyGP+3heKz/M20ohMKz4Uu2Lg==
X-Received: by 2002:a65:5383:: with SMTP id x3mr4566831pgq.279.1585164541179;
        Wed, 25 Mar 2020 12:29:01 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b17sm19245567pff.81.2020.03.25.12.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 12:29:00 -0700 (PDT)
Date:   Wed, 25 Mar 2020 12:28:59 -0700
From:   Kees Cook <keescook@chromium.org>
To:     KP Singh <kpsingh@chromium.org>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>, Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH bpf-next v6 3/8] bpf: lsm: provide attachment points for
 BPF LSM programs
Message-ID: <202003251225.923FF1DD7@keescook>
References: <20200325152629.6904-1-kpsingh@chromium.org>
 <20200325152629.6904-4-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200325152629.6904-4-kpsingh@chromium.org>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 25, 2020 at 04:26:24PM +0100, KP Singh wrote:
> From: KP Singh <kpsingh@google.com>
> 
> When CONFIG_BPF_LSM is enabled, nop functions, bpf_lsm_<hook_name>, are
> generated for each LSM hook. These functions are initialized as LSM
> hooks in a subsequent patch.
> 
> Signed-off-by: KP Singh <kpsingh@google.com>
> Reviewed-by: Brendan Jackman <jackmanb@google.com>
> Reviewed-by: Florent Revest <revest@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Acked-by: Yonghong Song <yhs@fb.com>
> ---
>  include/linux/bpf_lsm.h | 22 ++++++++++++++++++++++
>  kernel/bpf/bpf_lsm.c    | 14 ++++++++++++++
>  2 files changed, 36 insertions(+)
>  create mode 100644 include/linux/bpf_lsm.h
> 
> diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
> new file mode 100644
> index 000000000000..83b96895829f
> --- /dev/null
> +++ b/include/linux/bpf_lsm.h
> @@ -0,0 +1,22 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * Copyright (C) 2020 Google LLC.
> + */
> +
> +#ifndef _LINUX_BPF_LSM_H
> +#define _LINUX_BPF_LSM_H
> +
> +#include <linux/bpf.h>
> +#include <linux/lsm_hooks.h>
> +
> +#ifdef CONFIG_BPF_LSM
> +
> +#define LSM_HOOK(RET, DEFAULT, NAME, ...) \
> +	RET bpf_lsm_##NAME(__VA_ARGS__);
> +#include <linux/lsm_hook_defs.h>
> +#undef LSM_HOOK
> +
> +#endif /* CONFIG_BPF_LSM */
> +
> +#endif /* _LINUX_BPF_LSM_H */
> diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> index 82875039ca90..1210a819ca52 100644
> --- a/kernel/bpf/bpf_lsm.c
> +++ b/kernel/bpf/bpf_lsm.c
> @@ -7,6 +7,20 @@
>  #include <linux/filter.h>
>  #include <linux/bpf.h>
>  #include <linux/btf.h>
> +#include <linux/lsm_hooks.h>
> +#include <linux/bpf_lsm.h>
> +
> +/* For every LSM hook that allows attachment of BPF programs, declare a nop
> + * function where a BPF program can be attached.
> + */
> +#define LSM_HOOK(RET, DEFAULT, NAME, ...) 	\
> +noinline __weak RET bpf_lsm_##NAME(__VA_ARGS__)	\

I don't think the __weak is needed any more here?

> +{						\
> +	return DEFAULT;				\

I'm impressed that LSM_RET_VOID actually works. :)

-Kees

> +}
> +
> +#include <linux/lsm_hook_defs.h>
> +#undef LSM_HOOK
>  
>  const struct bpf_prog_ops lsm_prog_ops = {
>  };
> -- 
> 2.20.1
> 

-- 
Kees Cook
