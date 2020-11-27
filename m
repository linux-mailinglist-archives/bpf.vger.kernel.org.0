Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F58A2C5EC0
	for <lists+bpf@lfdr.de>; Fri, 27 Nov 2020 03:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392219AbgK0CcS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Nov 2020 21:32:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbgK0CcR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 Nov 2020 21:32:17 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64351C0613D4
        for <bpf@vger.kernel.org>; Thu, 26 Nov 2020 18:32:17 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id s27so5021575lfp.5
        for <bpf@vger.kernel.org>; Thu, 26 Nov 2020 18:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=duKXrMXbO5x97/X4ifJt1mH4DWBuc4Xj0bBfthNtITo=;
        b=RdVbIFRv325tEKb1KxuR884D6+sUO17uL5VDFRX/mMETlyh/rWSMLOOCkq4JwuwzIP
         WjByKo44zmV0Uh8tYD/lm/SijRhTovN4/OE9s+UL6M2mNFT9OE0eTUSHz5wrS7h+Gfwe
         4bRtAW8ynalT354yFwKhUOZudZHtMXtMZq92s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=duKXrMXbO5x97/X4ifJt1mH4DWBuc4Xj0bBfthNtITo=;
        b=UwqGrjH/kJNe6BNS6HuRJ4QRSCkiEA1tSf7pTN3KiszpAekh9Zs4dqkKRfBRKLQhRy
         l2cECu3bSOjSdCUxNwZLPXrT2QPPBpT8BpMmMGgrYuByKCXZkafFqMPuyt1ImAA5D8uI
         xUgLPV91b/lrXiUstDRTynExy5jVWVHOrU7rXOJM0ANCYATqAW9zE5Y1wJsxa6ga2g3O
         JcWjo0oYK1LReJfSWmARUBGDxrQrIUfpGyybxmf6yZRHZSMOGMjr8i5bJ6+c5ctdyatZ
         tQo50dHHO93O71L43RkZJFCEDtzv80AbQMRVtQQ1hD41IrtchfkjX6Afp/w1Z3N2WcMI
         EQ/g==
X-Gm-Message-State: AOAM531/zzexngSyLWxmue9fdHG59EBaTv6oGpDB0yHMsB7L2ROi9Ke1
        gcnjyZlU4VJRpEfS68/OCkOCQ8Bh7bdXpX/2herctw==
X-Google-Smtp-Source: ABdhPJyRfHa59VPLJk9D5ukrU4+/2/Vx2g97em7FvUpGC0yhzfjdDvSvAvT99Qfioctitgy9S0KPwt8yv8ZyB1g1TJU=
X-Received: by 2002:a05:6512:34d3:: with SMTP id w19mr2235358lfr.418.1606444335787;
 Thu, 26 Nov 2020 18:32:15 -0800 (PST)
MIME-Version: 1.0
References: <20201126165748.1748417-1-revest@google.com>
In-Reply-To: <20201126165748.1748417-1-revest@google.com>
From:   KP Singh <kpsingh@chromium.org>
Date:   Fri, 27 Nov 2020 03:32:04 +0100
Message-ID: <CACYkzJ65P5fxW1bxVXm_ehLLE=gn6nuR+UVxYWjqSJfXoZd+8g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Add a bpf_kallsyms_lookup helper
To:     Florent Revest <revest@chromium.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Florent Revest <revest@google.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

[...]

> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index c3458ec1f30a..670998635eac 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -3817,6 +3817,21 @@ union bpf_attr {
>   *             The **hash_algo** is returned on success,
>   *             **-EOPNOTSUP** if IMA is disabled or **-EINVAL** if
>   *             invalid arguments are passed.
> + *
> + * long bpf_kallsyms_lookup(u64 address, char *symbol, u32 symbol_size, char *module, u32 module_size)
> + *     Description
> + *             Uses kallsyms to write the name of the symbol at *address*
> + *             into *symbol* of size *symbol_sz*. This is guaranteed to be
> + *             zero terminated.
> + *             If the symbol is in a module, up to *module_size* bytes of
> + *             the module name is written in *module*. This is also
> + *             guaranteed to be zero-terminated. Note: a module name
> + *             is always shorter than 64 bytes.
> + *     Return
> + *             On success, the strictly positive length of the full symbol
> + *             name, If this is greater than *symbol_size*, the written
> + *             symbol is truncated.
> + *             On error, a negative value.
>   */
>  #define __BPF_FUNC_MAPPER(FN)          \
>         FN(unspec),                     \
> @@ -3981,6 +3996,7 @@ union bpf_attr {
>         FN(bprm_opts_set),              \
>         FN(ktime_get_coarse_ns),        \
>         FN(ima_inode_hash),             \
> +       FN(kallsyms_lookup),    \
>         /* */
>
>  /* integer value in 'imm' field of BPF_CALL instruction selects which helper
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index d255bc9b2bfa..9d86e20c2b13 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -17,6 +17,7 @@
>  #include <linux/error-injection.h>
>  #include <linux/btf_ids.h>
>  #include <linux/bpf_lsm.h>
> +#include <linux/kallsyms.h>
>
>  #include <net/bpf_sk_storage.h>
>
> @@ -1260,6 +1261,44 @@ const struct bpf_func_proto bpf_snprintf_btf_proto = {
>         .arg5_type      = ARG_ANYTHING,
>  };
>
> +BPF_CALL_5(bpf_kallsyms_lookup, u64, address, char *, symbol, u32, symbol_size,
> +          char *, module, u32, module_size)
> +{
> +       char buffer[KSYM_SYMBOL_LEN];
> +       unsigned long offset, size;
> +       const char *name;
> +       char *modname;
> +       long ret;
> +
> +       name = kallsyms_lookup(address, &size, &offset, &modname, buffer);
> +       if (!name)
> +               return -EINVAL;
> +
> +       ret = strlen(name) + 1;
> +       if (symbol_size) {
> +               strncpy(symbol, name, symbol_size);
> +               symbol[symbol_size - 1] = '\0';
> +       }
> +
> +       if (modname && module_size) {
> +               strncpy(module, modname, module_size);

The return value does not seem to be impacted by the truncation of the
module name, I wonder if it is better to just use a single buffer.

For example, the proc kallsyms shows symbols as:

<symbol_name> [module_name]

https://github.com/torvalds/linux/blob/master/kernel/kallsyms.c#L648

The square brackets do seem to be a waste here, so maybe we could use
a single character as a separator?

> +               module[module_size - 1] = '\0';
> +       }
> +
> +       return ret;
> +}
> +
> +const struct bpf_func_proto bpf_kallsyms_lookup_proto = {
> +       .func           = bpf_kallsyms_lookup,
> +       .gpl_only       = false,
> +       .ret_type       = RET_INTEGER,
> +       .arg1_type      = ARG_ANYTHING,
> +       .arg2_type      = ARG_PTR_TO_MEM,
> +       .arg3_type      = ARG_CONST_SIZE,
> +       .arg4_type      = ARG_PTR_TO_MEM,
> +       .arg5_type      = ARG_CONST_SIZE,
> +};
> +

[...]
