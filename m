Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A670674A5F
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 04:48:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjATDsg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Jan 2023 22:48:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjATDsf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Jan 2023 22:48:35 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954D993D3
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 19:48:33 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id s67so3194914pgs.3
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 19:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5xYlYYwidFMsYGMcEAqTW/TSYKnVvBTImcdKv0esWOg=;
        b=I/hCvBgArkRJYrKjLErfJ1lV42+ANPGFDVtEjg6t987XpBK3FBhyVvno/lo4aSL/dT
         PbuweWutUZ+PwzDMbE9ARqEpJ4VlkEB7BmhMUcYqaXJCEIfzK/wy2yok7ogGYaPEERa8
         ++kpPOQJ2yDe+cLBQUaU3kKK08drO+kynVThk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5xYlYYwidFMsYGMcEAqTW/TSYKnVvBTImcdKv0esWOg=;
        b=BeZAjxm6YSR5fbVRKpZG0m2qHHEMdagwhOZI8BFdNN2N+bCNtV1CCSgannm+sQ60bO
         ZK02h2TJMyTJsT+447QVrr2DzsJ/gLfl+XX9YWuqoc81EuPHfeb+iKqBFqft1mlMm54q
         8OjH8pYgChCV4lJ0VNUL2hQxDGtV3f9vjDrCaWCzpuLKTkmKq1Rw+pg7gH5nR2vX5dU2
         Ug8Fk96Wt/d3jCK5HFsq0i0ybuIEStJbGqYlZOJ3zwJ50anb7EUxl3qP6h41oR3EcE+D
         XTNFKQxEBMURsTbg0NkGgUloBEVeiZBg2uNy1MS9gdiK8GKyE27tFp5WxDT7o/3WouoU
         r9dQ==
X-Gm-Message-State: AFqh2koGdbVdhol+OKHvbpbH1qvbHXQjrJs22rUhu5pX6aimfJrssSzn
        iF+91vePKGEvlqzaeUfzWzaxiQ==
X-Google-Smtp-Source: AMrXdXuax1LzobrWZKP/qQYBYMBg3lpUvoOqNaUBZ09TA0aRtS+pTYsDlgKqY/lBz5hhwaYk+J6s4g==
X-Received: by 2002:aa7:88d5:0:b0:58d:a683:bb2d with SMTP id k21-20020aa788d5000000b0058da683bb2dmr18113345pff.30.1674186513080;
        Thu, 19 Jan 2023 19:48:33 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v4-20020a626104000000b0058de0998f17sm4629415pfb.154.2023.01.19.19.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 19:48:32 -0800 (PST)
Date:   Thu, 19 Jan 2023 19:48:31 -0800
From:   Kees Cook <keescook@chromium.org>
To:     KP Singh <kpsingh@kernel.org>
Cc:     linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, jackmanb@google.com,
        renauld@google.com, paul@paul-moore.com, casey@schaufler-ca.com,
        song@kernel.org, revest@chromium.org
Subject: Re: [PATCH RESEND bpf-next 1/4] kernel: Add helper macros for loop
 unrolling
Message-ID: <202301191938.A7465D123@keescook>
References: <20230120000818.1324170-1-kpsingh@kernel.org>
 <20230120000818.1324170-2-kpsingh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120000818.1324170-2-kpsingh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 20, 2023 at 01:08:15AM +0100, KP Singh wrote:
> This helps in easily initializing blocks of code (e.g. static calls and
> keys).
> 
> UNROLL(N, MACRO, __VA_ARGS__) calls MACRO N times with the first
> argument as the index of the iteration. This allows string pasting to
> create unique tokens for variable names, function calls etc.
> 
> As an example:
> 
> 	#include <linux/unroll.h>
> 
> 	#define MACRO(N, a, b)            \
> 		int add_##N(int a, int b) \
> 		{                         \
> 			return a + b + N; \
> 		}
> 
> 	UNROLL(2, MACRO, x, y)
> 
> expands to:
> 
> 	int add_0(int x, int y)
> 	{
> 		return x + y + 0;
> 	}
> 
> 	int add_1(int x, int y)
> 	{
> 		return x + y + 1;
> 	}
> 
> Signed-off-by: KP Singh <kpsingh@kernel.org>
> ---
>  include/linux/unroll.h | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>  create mode 100644 include/linux/unroll.h
> 
> diff --git a/include/linux/unroll.h b/include/linux/unroll.h
> new file mode 100644
> index 000000000000..e19aef95b94b
> --- /dev/null
> +++ b/include/linux/unroll.h
> @@ -0,0 +1,35 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * Copyright (C) 2020 Google LLC.
> + */
> +
> +#ifndef __UNROLL_H
> +#define __UNROLL_H
> +
> +#define __UNROLL_CONCAT(a, b) a ## _ ## b

#include <linux/kernel.h>
and just use CONCATENATE

> +#define UNROLL(N, MACRO, args...) __UNROLL_CONCAT(__UNROLL, N)(MACRO, args)

Which would be, and it just loses the _, which isn't important here:
#define UNROLL(N, MACRO, args...) CONCATENATE(__UNROLL, N)(MACRO, args)

> +#define __UNROLL_0(MACRO, args...)
> +#define __UNROLL_1(MACRO, args...)  __UNROLL_0(MACRO, args)  MACRO(0, args)

But yeah, I like it. It's an expression version of the __MAP() macro
used by the syscall wrappers for arguments.

-- 
Kees Cook
