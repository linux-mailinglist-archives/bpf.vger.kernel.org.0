Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 874C818FDC0
	for <lists+bpf@lfdr.de>; Mon, 23 Mar 2020 20:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbgCWTdr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Mar 2020 15:33:47 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:37702 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727747AbgCWTdr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Mar 2020 15:33:47 -0400
Received: by mail-pj1-f66.google.com with SMTP id o12so305647pjs.2
        for <bpf@vger.kernel.org>; Mon, 23 Mar 2020 12:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QK1jZXR8lSHrMmCV4BaYuYh+4tyJTB+kyT8mffooOtA=;
        b=HY0cWUyiO+tlb7hC5bbViSYOfF0QR6yS/1XYhTW2nFMIXjADrDzAxBWqUWl09jzXYi
         3tQQblO3u2Xd6Lslklk+9nGAGLXb0BWsi83Uc5JrUD4ztiVDckfTvwJqUaPWGCMGQvQo
         wMTNDwOJIF8n6FNk1wvZaHcl9wbszdMe71fUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QK1jZXR8lSHrMmCV4BaYuYh+4tyJTB+kyT8mffooOtA=;
        b=ph4h0NOAeWo0egfJ3CArpmAUpmtKw4zqv+wCB1/y9FjWjZZy0UO2u+Ov7HGnjnqytz
         Zkoo4J+oXF8HrtHdYxkyp7UJV0oZyZLW9BMl2Q9XFCqmqir5mJ2XFUyQMzS0mg9EgumJ
         3OoOz0z75XEtGonPTXBZwQitW8xhpDDLSQUHr1WbWHFNfEX8jQ/NZ7oAGJkB7O01r1GH
         cNHj9v7DLxFUVJqw6cm4UZ9lb9O7G2nPR/PiAiAttMfU9F+ptxKSxMvD8KhsWeUX/3nX
         GK4xhxDxLw76j/72w3gwxpPT0LC9Y2hebm+0roJ7uVUQE/NPfk8XvL+941Gmx9CQNO3e
         ZkwA==
X-Gm-Message-State: ANhLgQ04fJTEmsTQiaYGdYWoKyxDdKeHdoVbvrZQSy3mWz3mZ/QgjuIx
        KIfbVnyl2vGz+HpIEj+BlQgmiQ==
X-Google-Smtp-Source: ADFU+vvWLmXaf6AUKUF5V6qy/3SqirUY/UMVqEGOYugH0BR4CvrraHrsBBXWHeoHg3BMrlOSLtzdRw==
X-Received: by 2002:a17:90a:1a43:: with SMTP id 3mr993827pjl.35.1584992026093;
        Mon, 23 Mar 2020 12:33:46 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f6sm14827161pfk.99.2020.03.23.12.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 12:33:45 -0700 (PDT)
Date:   Mon, 23 Mar 2020 12:33:44 -0700
From:   Kees Cook <keescook@chromium.org>
To:     KP Singh <kpsingh@chromium.org>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH bpf-next v5 3/7] bpf: lsm: provide attachment points for
 BPF LSM programs
Message-ID: <202003231233.9C1E0B830@keescook>
References: <20200323164415.12943-1-kpsingh@chromium.org>
 <20200323164415.12943-4-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323164415.12943-4-kpsingh@chromium.org>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 23, 2020 at 05:44:11PM +0100, KP Singh wrote:
> From: KP Singh <kpsingh@google.com>
> 
> When CONFIG_BPF_LSM is enabled, nops functions, bpf_lsm_<hook_name>, are
> generated for each LSM hook. These nops are initialized as LSM hooks in
> a subsequent patch.
> 
> Signed-off-by: KP Singh <kpsingh@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> Reviewed-by: Brendan Jackman <jackmanb@google.com>
> Reviewed-by: Florent Revest <revest@google.com>
> ---
>  include/linux/bpf_lsm.h | 21 +++++++++++++++++++++
>  kernel/bpf/bpf_lsm.c    | 19 +++++++++++++++++++
>  2 files changed, 40 insertions(+)
>  create mode 100644 include/linux/bpf_lsm.h
> 
> diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
> new file mode 100644
> index 000000000000..c6423a140220
> --- /dev/null
> +++ b/include/linux/bpf_lsm.h
> @@ -0,0 +1,21 @@
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
> +#define LSM_HOOK(RET, NAME, ...) RET bpf_lsm_##NAME(__VA_ARGS__);
> +#include <linux/lsm_hook_names.h>
> +#undef LSM_HOOK
> +
> +#endif /* CONFIG_BPF_LSM */
> +
> +#endif /* _LINUX_BPF_LSM_H */
> diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> index 82875039ca90..530d137f7a84 100644
> --- a/kernel/bpf/bpf_lsm.c
> +++ b/kernel/bpf/bpf_lsm.c
> @@ -7,6 +7,25 @@
>  #include <linux/filter.h>
>  #include <linux/bpf.h>
>  #include <linux/btf.h>
> +#include <linux/lsm_hooks.h>
> +#include <linux/bpf_lsm.h>
> +
> +/* For every LSM hook  that allows attachment of BPF programs, declare a NOP
> + * function where a BPF program can be attached as an fexit trampoline.
> + */
> +#define LSM_HOOK(RET, NAME, ...) LSM_HOOK_##RET(NAME, __VA_ARGS__)
> +
> +#define LSM_HOOK_int(NAME, ...)			\
> +noinline __weak int bpf_lsm_##NAME(__VA_ARGS__)	\
> +{						\
> +	return 0;				\
> +}
> +
> +#define LSM_HOOK_void(NAME, ...) \
> +noinline __weak void bpf_lsm_##NAME(__VA_ARGS__) {}
> +
> +#include <linux/lsm_hook_names.h>
> +#undef LSM_HOOK
>  
>  const struct bpf_prog_ops lsm_prog_ops = {
>  };
> -- 
> 2.20.1
> 

-- 
Kees Cook
