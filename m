Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26AC6523C4
	for <lists+bpf@lfdr.de>; Tue, 20 Dec 2022 16:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbiLTPil (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Dec 2022 10:38:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbiLTPij (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Dec 2022 10:38:39 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60160101EE
        for <bpf@vger.kernel.org>; Tue, 20 Dec 2022 07:38:37 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id o15so9038061wmr.4
        for <bpf@vger.kernel.org>; Tue, 20 Dec 2022 07:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/34tJIyjAP7baqWGpngAiiqvT8UHp3bz8kKbMzeEnfA=;
        b=14PCLWLvyaoEwZR603D8HJggj8rZdeGLGfIE/VDYssMSht2WCH/1E7Kt5QWRr9n9EY
         TcF6F7/j6gsa/ZDHUWgrEuGVeurxWoywI5LwqgeHyXSNeB+aM1PomKtmFiVrJY9iFCax
         0ChwJRiihnKqrwx9JLYyjh0jMK8zvF1LjM/bgN9KuDDWDdhHaA3V6QlIsC+3/X2MTeCS
         YvmbF0MN8Zrd5CZaZDQiMB5R60hbYtoIn3jsJM4Vwq9Dk3R0uItZc7qOCtvqwuEVQ4mv
         OfCq3VUlOMrFqCKovJ8HiF0YE/8hgNWYgoFFJ2tp0d8NK65qxBT9cSF5pVj981pywgSc
         fpaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/34tJIyjAP7baqWGpngAiiqvT8UHp3bz8kKbMzeEnfA=;
        b=HiWLt3amV26VHJQrA5d0hyEmdDIRqnnudFffzbJDm+4zo65W+cOKQU7xlYgbAO1nuF
         XljrBLYURG7O7oXHK8zp0ietNRKisG/65WOKJwXBB80+QnlLDkSjNYrMwCza1MpqcEUC
         1nx2FZafhM1+j72zz6hP5fIXfnseW45ViVc8cfrfKKV9KfW42RLsvdqAMOPGsm8ClQt/
         NmAeZlyT2xl+VUV/cPWzqxGlFrWW7c6m5soP6kXylGhesPAYN4voqzo2iLYX6h/CIytl
         KC3Ey1utP5x/rfaTX3SqS7ugNOWXGQ64FJsx9TfJaMSLwuOOhhaeV4N+GH491NPn9ZcE
         8sXQ==
X-Gm-Message-State: AFqh2kofAIxJ9Xpr15ABWxdgW8caBN89P2n+/ZSAmG+lSopLOGcQfq8h
        uMwgLtwKfdYXMvIjQg8mtbyzyw==
X-Google-Smtp-Source: AMrXdXuGOqlBaXnhHjBX3CP3CTvS32W4Oo+9iEk8VgNIUYzXfPokTe3bS7Lxl4mRzN6alWA3vKArHA==
X-Received: by 2002:a05:600c:54ed:b0:3d3:3c74:dbd0 with SMTP id jb13-20020a05600c54ed00b003d33c74dbd0mr14531267wmb.13.1671550715837;
        Tue, 20 Dec 2022 07:38:35 -0800 (PST)
Received: from [192.168.178.32] ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id p13-20020a05600c1d8d00b003d01b84e9b2sm16544121wms.27.2022.12.20.07.38.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 07:38:35 -0800 (PST)
Message-ID: <b5fcbefa-75d5-b716-10f7-bd7ab1f6ff9b@isovalent.com>
Date:   Tue, 20 Dec 2022 15:38:34 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3 2/2] bpf: makefiles: do not generate empty vmlinux.h
Content-Language: en-GB
To:     Changbin Du <changbin.du@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20221217223509.88254-1-changbin.du@gmail.com>
 <20221217223509.88254-3-changbin.du@gmail.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20221217223509.88254-3-changbin.du@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2022-12-18 06:35 UTC+0800 ~ Changbin Du <changbin.du@gmail.com>
> Remove the empty vmlinux.h if bpftool failed to dump btf info.
> The empty vmlinux.h can hide real error when reading output
> of make.
> 
> This is done by adding .DELETE_ON_ERROR special target in related
> makefiles.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  tools/bpf/bpftool/Makefile           | 3 +++
>  tools/testing/selftests/bpf/Makefile | 3 +++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> index 787b857d3fb5..313fd1b09189 100644
> --- a/tools/bpf/bpftool/Makefile
> +++ b/tools/bpf/bpftool/Makefile
> @@ -289,3 +289,6 @@ FORCE:
>  .PHONY: all FORCE bootstrap clean install-bin install uninstall
>  .PHONY: doc doc-clean doc-install doc-uninstall
>  .DEFAULT_GOAL := all
> +
> +# Delete partially updated (corrupted) files on error
> +.DELETE_ON_ERROR:

Acked-by: Quentin Monnet <quentin@isovalent.com>

Thanks!

