Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 040B765F3F3
	for <lists+bpf@lfdr.de>; Thu,  5 Jan 2023 19:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235096AbjAESrb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Jan 2023 13:47:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234997AbjAESrS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Jan 2023 13:47:18 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221B73E0E1
        for <bpf@vger.kernel.org>; Thu,  5 Jan 2023 10:47:18 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id k21-20020aa78215000000b00575ab46ca2cso18114006pfi.20
        for <bpf@vger.kernel.org>; Thu, 05 Jan 2023 10:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XZuxdDBhTxtm3sl01imrqslWnx2DLyZq2pIBjdBkdtU=;
        b=nY1jnv1a32uBxDuO5+tT8LwT5b7tNeasNcDHqg25ZhhkWQ8KBl5tFYwf+6r4Nznw+h
         lWkcpWmx5MFR8d+EI05kIZMWbRY7bn6zJUDb7EieF6hCh39MVswYSoxbGCwXeDcwMW5u
         Ffv8qRwoxYu59pRGqDELmVYlWbiPzRORv5UiTPHlzdMXPXQhI/vNKxIHh7zzFOBg8jEw
         7GHDEdXlsJ+RylQfGe/oCNQzy5JBRdHpu0JX8PdHXEzSv0stkVYMRPkzBjv7Uhw9W0iN
         vKeBbZOe6t3+1Yu3AUNhY7XVIZmi4/pZfdm+JtclSKFOep8FmdbKqhrxD/LzYYJCia16
         Y5FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XZuxdDBhTxtm3sl01imrqslWnx2DLyZq2pIBjdBkdtU=;
        b=AnlahUgzCzA0UAeXDlyTrlazXiS/6bmlgNNkhGSiBUCYp2/cPQu9Bs40qoNBsuXN1l
         z8uugAmgLjXdSD6Fu85pEERX+N7IYeNJ7PaeOmXiL2iQ86I/M3ZkGLECEUPZccAjvc7Q
         LSnOt45pZYirveYGMCGIu3TdoLzLjLSD4llD8+XFlU+SgLm8yjXLtypvpchF73b5fVSH
         N7moP//bYFSW+/i/rQ/zVO7OLdf+qCj6q4Amu03/C+NJQzYOShV1sviNuvYJoqOuVu6H
         Xgpx8tk677FfyGlXjMutO1XcPnU1RDhQA5q06ylVoz4QUV+aCm7eKrNBS2wEIXyTj1Z6
         zipw==
X-Gm-Message-State: AFqh2kpEn+5bTHoK+UZk6WxE2aHaTeNdvzOZjJi5tMM+n9CrIW6LWNhP
        z5ejqhUEakcRs9qL3TTloe8P0bY=
X-Google-Smtp-Source: AMrXdXuI6Xj0hFDOhwzWxjDGfk+OpJDiilxIIWG7/FCvwa/Jn7hcp4wZMn015IN0Xqo6W4q7FRLtJrY=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:903:40c8:b0:189:7a15:134b with SMTP id
 t8-20020a17090340c800b001897a15134bmr2760642pld.143.1672944437584; Thu, 05
 Jan 2023 10:47:17 -0800 (PST)
Date:   Thu, 5 Jan 2023 10:47:15 -0800
In-Reply-To: <tencent_5695A257C4D16B4413036BA1DAACDECB0B07@qq.com>
Mime-Version: 1.0
References: <tencent_5695A257C4D16B4413036BA1DAACDECB0B07@qq.com>
Message-ID: <Y7cbM1D2YvB9tdqg@google.com>
Subject: Re: [PATCH bpf-next] libbpf: poison strlcpy()
From:   sdf@google.com
To:     Rong Tao <rtoax@foxmail.com>
Cc:     andrii@kernel.org, rongtao@cestc.cn,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        "open list:BPF [LIBRARY] (libbpf)" <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 01/05, Rong Tao wrote:
> From: Rong Tao <rongtao@cestc.cn>

> Since commit 9fc205b413b3("libbpf: Add sane strncpy alternative and use
> it internally") introduce libbpf_strlcpy(), thus add strlcpy() to a poison
> list to prevent accidental use of it.

> Signed-off-by: Rong Tao <rongtao@cestc.cn>

Acked-by: Stanislav Fomichev <sdf@google.com>

> ---
>   tools/lib/bpf/libbpf_internal.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

> diff --git a/tools/lib/bpf/libbpf_internal.h  
> b/tools/lib/bpf/libbpf_internal.h
> index 377642ff51fc..2d26ded383ca 100644
> --- a/tools/lib/bpf/libbpf_internal.h
> +++ b/tools/lib/bpf/libbpf_internal.h
> @@ -20,8 +20,8 @@
>   /* make sure libbpf doesn't use kernel-only integer typedefs */
>   #pragma GCC poison u8 u16 u32 u64 s8 s16 s32 s64

> -/* prevent accidental re-addition of reallocarray() */
> -#pragma GCC poison reallocarray
> +/* prevent accidental re-addition of reallocarray()/strlcpy() */
> +#pragma GCC poison reallocarray strlcpy

>   #include "libbpf.h"
>   #include "btf.h"
> --
> 2.39.0

