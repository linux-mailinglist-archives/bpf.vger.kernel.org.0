Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82DD066BBB5
	for <lists+bpf@lfdr.de>; Mon, 16 Jan 2023 11:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjAPKaU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Jan 2023 05:30:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbjAPKaT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Jan 2023 05:30:19 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1DA1A972
        for <bpf@vger.kernel.org>; Mon, 16 Jan 2023 02:30:18 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id ay40so19646639wmb.2
        for <bpf@vger.kernel.org>; Mon, 16 Jan 2023 02:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qTooUq4cMjOEihCYLJFBqFS7hAzRSHaf73G77gKeBmo=;
        b=MO3oc2rD84K0LdlR/IJAprDxtYLFJ0sNfcuUaS64tDCx0pC1g5CWuVu353jpTPr+II
         J/4aDi3i78oIZsLXVb855d7PvVYzL29M1yaa5Uielj1i4B4mLdsFFfYI6PKdgMfePD+V
         36/47gK3jCqbwYRHK40grP4D/ba0t6/iUpuWhob1RvE0znhZYXtbHNnLkQCHqzuxsnjs
         +GQ/uEwiJRnlrY8+BhgQBk7GgOngbW51EWsdWqAkGozHHqgl4Qoq6upQ8e3Dm3mLX0oS
         qSop9GgV3WsSfXyIPX8aUkpUa163Goy9LG+lTNqJNpV1VaJEOE700LCiKLyrFyg+Hr/J
         TPzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qTooUq4cMjOEihCYLJFBqFS7hAzRSHaf73G77gKeBmo=;
        b=iewpiwdA1s6mgTFrAyhlK7Qqt4t4fia6uNIUNlebkRwV3h/MZpxucwJMLtAiFpj8Ex
         CbOUIP84RuAD0krZbcDefuBsF5+TiYkGYNRjyBzHRNUpbwXtQdosD9PpKIdQDILxsbyu
         qVDeKu2nBPODYIzyVRakIHqUHkKN1acF5G8WfaOyq3MQfY74aJ2kDpO5fRhaJRskzJKL
         Ymg5Qbf0elqUv7DhbrlPa0WqjDbqsNQ9w5pkm0yXJkDk4gnbn9NrE1kVeSXTwrMtYR2s
         j+9Bhra4lYnbhz3W3CKqS+3HEsW83SH+Ub9yV+kUZw/JjcW8CNFid2p6NpHrm3kqn5BR
         2Rgw==
X-Gm-Message-State: AFqh2kri3hsF91k41lF+mJR1+dIyWIbPTnlMIlc/MCjVAoNLEAPyC/w0
        oex0QO71+Rs/nCobctnan13/MA==
X-Google-Smtp-Source: AMrXdXsYyTyvcOBn4REIZA5fHuv68tyqOAxd2gu3QvrZVRzS7158AX8poyUv1J5fgE+WZ6npAJXv/w==
X-Received: by 2002:a05:600c:b95:b0:3da:fa42:bbf2 with SMTP id fl21-20020a05600c0b9500b003dafa42bbf2mr3401950wmb.28.1673865016776;
        Mon, 16 Jan 2023 02:30:16 -0800 (PST)
Received: from [192.168.178.32] ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id q6-20020a05600c46c600b003d1f3e9df3csm40561236wmo.7.2023.01.16.02.30.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 02:30:16 -0800 (PST)
Message-ID: <cb03b745-26b8-706c-de40-80ae991e29fd@isovalent.com>
Date:   Mon, 16 Jan 2023 10:30:15 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] tools: bpf: Disable stack protector
Content-Language: en-GB
To:     Peter Foley <pefoley2@pefoley.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
References: <20230114-bpf-v1-1-f836695a8b62@pefoley.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20230114-bpf-v1-1-f836695a8b62@pefoley.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2023-01-14 18:00 UTC-0500 ~ Peter Foley <pefoley2@pefoley.com>
> Avoid build errors on distros that force the stack protector on by
> default.
> e.g.
>   CLANG   /home/peter/linux/work/tools/bpf/bpftool/pid_iter.bpf.o
> skeleton/pid_iter.bpf.c:53:5: error: A call to built-in function '__stack_chk_fail' is not supported.
> int iter(struct bpf_iter__task_file *ctx)
>     ^
> 1 error generated.
> 
> Signed-off-by: Peter Foley <pefoley2@pefoley.com>
> ---
>  tools/bpf/bpftool/Makefile    | 1 +
>  tools/bpf/runqslower/Makefile | 5 +++--
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> index f610e184ce02a..36ac0002e386f 100644
> --- a/tools/bpf/bpftool/Makefile
> +++ b/tools/bpf/bpftool/Makefile
> @@ -215,6 +215,7 @@ $(OUTPUT)%.bpf.o: skeleton/%.bpf.c $(OUTPUT)vmlinux.h $(LIBBPF_BOOTSTRAP)
>  		-I$(or $(OUTPUT),.) \
>  		-I$(srctree)/tools/include/uapi/ \
>  		-I$(LIBBPF_BOOTSTRAP_INCLUDE) \
> +		-fno-stack-protector \
>  		-g -O2 -Wall -target bpf -c $< -o $@
>  	$(Q)$(LLVM_STRIP) -g $@
>  

For bpftool, a similar patch was already submitted and merged to the
bpf-next tree last Friday: 878625e1c7a1 ("bpftool: Always disable stack
protection for BPF objects").

> diff --git a/tools/bpf/runqslower/Makefile b/tools/bpf/runqslower/Makefile
> index 8b3d87b82b7a2..f7313cc966a04 100644
> --- a/tools/bpf/runqslower/Makefile
> +++ b/tools/bpf/runqslower/Makefile
> @@ -60,8 +60,9 @@ $(OUTPUT)/%.skel.h: $(OUTPUT)/%.bpf.o | $(BPFTOOL)
>  	$(QUIET_GEN)$(BPFTOOL) gen skeleton $< > $@
>  
>  $(OUTPUT)/%.bpf.o: %.bpf.c $(BPFOBJ) | $(OUTPUT)
> -	$(QUIET_GEN)$(CLANG) -g -O2 -target bpf $(INCLUDES)		      \
> -		 -c $(filter %.c,$^) -o $@ &&				      \
> +	$(QUIET_GEN)$(CLANG) -g -O2 -target bpf $(INCLUDES)		\
> +		 -fno-stack-protector 					\
> +		 -c $(filter %.c,$^) -o $@ &&				\
>  	$(LLVM_STRIP) -g $@
>  
>  $(OUTPUT)/%.o: %.c | $(OUTPUT)

This one looks good, thanks!

I note a few more places in the repository where we compile to BPF using
clang. Given that there have been patches to add -fno-stack-protector at
several locations already, have you checked if any of these also need
the flag, by any chance, so we could fix this once and for all?

$ git grep -l 'target bpf ' | egrep -v '(Documentation|bpftool)'
kernel/bpf/preload/iterators/Makefile
samples/bpf/Makefile
samples/bpf/test_lwt_bpf.sh
tools/bpf/runqslower/Makefile
tools/build/feature/Makefile
tools/perf/Makefile.perf
tools/perf/util/llvm-utils.c
tools/testing/selftests/bpf/Makefile
tools/testing/selftests/net/bpf/Makefile
tools/testing/selftests/tc-testing/Makefile
