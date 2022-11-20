Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A51B9631588
	for <lists+bpf@lfdr.de>; Sun, 20 Nov 2022 18:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbiKTR3X (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 20 Nov 2022 12:29:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiKTR3W (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 20 Nov 2022 12:29:22 -0500
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6779305;
        Sun, 20 Nov 2022 09:29:21 -0800 (PST)
Received: by mail-qt1-f169.google.com with SMTP id w9so6073049qtv.13;
        Sun, 20 Nov 2022 09:29:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2m/oKh2JCFyE3zOn/G6TKOcNovbaWdXH+bxKkKXD33I=;
        b=oRg5bgvYMF9lYUEYVF7qrIDKg9wY5WQdB+eHVKqxYG+rfxCnwNzFRia2/zXjHVkvNS
         HS8zoHw15lcneimrtFvxODpRu1oDfmJXsqlnlCg9LiPvimbGcMOUyjKgrRSXlLASFLbo
         7FsBCN0Srp+6d7ZhtejdLssqo4QmzU9qqiUyv/CX/HOD5LopKY6vRADXQob06FyYl7hW
         HQ3rSlD5iiLPzE4ZGjFJv5UlOXFoq5t5fKlEd8ZBOe/XcUb9JYuOqq6NIR60pUIXqJFv
         rZT8xyU8f8PY7erSUxlpMvLz93WHWr4pMzSkCfu+CK9DajLnsZ9+9O2FaJJka9OFhCdK
         GdbA==
X-Gm-Message-State: ANoB5pkxDQHmcT2t38eaXLtgdoFN1pSJmI5jX1PEYlLuSfyf6qP4OXOd
        dOnJDDNN3gI4cfeEBNC5JkE=
X-Google-Smtp-Source: AA0mqf5iklrigu3ogCld1s+7y6kFYaSrTYriw4iHyNJySr4/kwt/B1Dp0whscLdPjgscK35e6t3GKA==
X-Received: by 2002:ac8:1306:0:b0:3a5:9fb3:ba72 with SMTP id e6-20020ac81306000000b003a59fb3ba72mr14202220qtj.617.1668965360741;
        Sun, 20 Nov 2022 09:29:20 -0800 (PST)
Received: from maniforge.lan (c-24-15-214-156.hsd1.il.comcast.net. [24.15.214.156])
        by smtp.gmail.com with ESMTPSA id o16-20020a05620a2a1000b006fab68c7e87sm6873447qkp.70.2022.11.20.09.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 09:29:19 -0800 (PST)
Date:   Sun, 20 Nov 2022 11:29:24 -0600
From:   David Vernet <void@manifault.com>
To:     Rong Tao <rtoax@foxmail.com>
Cc:     ast@kernel.org, Rong Tao <rongtao@cestc.cn>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)" 
        <bpf@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next] docs/bpf: Update btf test programe code
Message-ID: <Y3pj9FCI5SOEHZXz@maniforge.lan>
References: <tencent_7F84D04F96EBE594CAD5EBD12815A2B00106@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_7F84D04F96EBE594CAD5EBD12815A2B00106@qq.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Nov 20, 2022 at 03:57:51PM +0800, Rong Tao wrote:
> From: Rong Tao <rongtao@cestc.cn>
> 
> commit c64779e24e88("selftests/bpf: Merge most of test_btf into
> test_progs") rename selftests/bpf btf test from 'test_btf.c' to
> 'prog_tests/btf.c'.
> 
> Signed-off-by: Rong Tao <rongtao@cestc.cn>
> ---
>  Documentation/bpf/btf.rst | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
> index cf8722f96090..59ccd9bad1e0 100644
> --- a/Documentation/bpf/btf.rst
> +++ b/Documentation/bpf/btf.rst
> @@ -1062,4 +1062,5 @@ format.::
>  7. Testing
>  ==========
>  
> -Kernel bpf selftest `test_btf.c` provides extensive set of BTF-related tests.
> +Kernel bpf selftest `prog_tests/btf.c` provides extensive set of BTF-related

s/Kernel bpf selftest/The kernel BPF selftest

s/provide extensive/provides an extensive

> +tests.

Thanks for adjusting this. Could you please mirror what prog_lsm.rst
does [0], and add a link to the file in the linux.git repo?

[0]: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/Documentation/bpf/prog_lsm.rst#n134

> -- 
> 2.38.1
> 
