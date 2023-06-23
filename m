Return-Path: <bpf+bounces-3245-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 456D373B2EC
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 10:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3220281932
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 08:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27951184E;
	Fri, 23 Jun 2023 08:51:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84211388
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 08:51:34 +0000 (UTC)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A6D1706
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 01:51:32 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f96da99965so395521e87.1
        for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 01:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1687510291; x=1690102291;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FBp/5we+F098cYxjClAH39IPPmeDVkhswEY+vCjkrLU=;
        b=Ldb53M44W8TbeL/H4zJekM/7x63/asS5bW6zXQ9hJOyWbKLNY7keLnKXhRj4QrC0l/
         DLXXI4bXuMJbOq8ckfyr5v1acn0wXTqUNlru42rjmYpwkXm+H96OgZgoI/kCnW2k7oxl
         5Da53GQIaNEpKCSkb9q0VDRLUTm8EeZ/Egqsr8ggJ3t+EiI4Mf3FiuOKj5/uk1Ro4Szo
         5fx2JdV1Gj8eUq+940HvdiGUJOJJoB464Of3kP4xSxRYeC/5T4GTYNjml1HW49/4/0Mg
         nTS0IoQC1ppNOJGvTDABxyXAPGh/iA1087WWe5v1Fr96c6G0LMb6JgKCuGj+56lCYl3C
         Jyww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687510291; x=1690102291;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FBp/5we+F098cYxjClAH39IPPmeDVkhswEY+vCjkrLU=;
        b=PkMLJ2Gr3Vb8NDo2VfEQCQS+7q1CnBj8U20kp8LS2NntReDaAWIlKjLeZfZRtVozsL
         g0+aVKxMwCGu7weXyM+V4W7cahXS6L9NdFUtxPbByfpuWVHa0A5mOwNDSMTLZwhQ9zPB
         MPrfKaaVWHSmjHgHwnUliafFBg5h0UnpCMRHwO1fYi4nVWgUu2+US7/BuipXczmguzlN
         PvC5l2E0aW7yw+vwKyMqn0xP5YIMcjIZqtNKIvbmstbfCuF9likDeisBUafWvWpABJeD
         9eluMuxeKj4ev/kD409s2gN5oK/GGKBDTZH6JfB+s+Vjm2lOL4AksMbrRrcHjWI3apA9
         03EA==
X-Gm-Message-State: AC+VfDyW3ekMDokaQUHD4rYturoI/X3DqtT1aqzx8K2G6APHv/6LmWSx
	TniRZooV03EAkb07E800Eum9Zg==
X-Google-Smtp-Source: ACHHUZ4bJ8bVgtgP/IjbqRrFOwLkmmEY0vE1BaZUiA+/j8tie7A0E3PJlHa8tG/xQQi6uTLzNyUNhA==
X-Received: by 2002:a19:6544:0:b0:4f6:d7b:2f19 with SMTP id c4-20020a196544000000b004f60d7b2f19mr11832148lfj.24.1687510290980;
        Fri, 23 Jun 2023 01:51:30 -0700 (PDT)
Received: from ?IPV6:2a02:8011:e80c:0:9cb8:f81f:3342:3b44? ([2a02:8011:e80c:0:9cb8:f81f:3342:3b44])
        by smtp.gmail.com with ESMTPSA id f23-20020a1c6a17000000b003eddc6aa5fasm1671290wmc.39.2023.06.23.01.51.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 01:51:30 -0700 (PDT)
Message-ID: <a5d419e4-f2ea-27f6-9259-a7b6486ab616@isovalent.com>
Date: Fri, 23 Jun 2023 09:51:29 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] bpf: Replace deprecated -target with --target= for Clang
Content-Language: en-GB
To: Fangrui Song <maskray@google.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20230623020908.1410959-1-maskray@google.com>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20230623020908.1410959-1-maskray@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

2023-06-23 02:09 UTC+0000 ~ Fangrui Song <maskray@google.com>
> -target has been deprecated since Clang 3.4 in 2013. Use the preferred
> --target=bpf form instead. This matches how we use --target= in
> scripts/Makefile.clang.

This seems to be the relevant commit, for reference:

https://github.com/llvm/llvm-project/commit/274b6f0c87a6a1798de0a68135afc7f95def6277

> 
> Signed-off-by: Fangrui Song <maskray@google.com>
> ---
>  Documentation/bpf/bpf_devel_QA.rst              | 10 +++++-----
>  Documentation/bpf/btf.rst                       |  4 ++--
>  Documentation/bpf/llvm_reloc.rst                |  6 +++---
>  drivers/hid/bpf/entrypoints/Makefile            |  2 +-
>  kernel/bpf/preload/iterators/Makefile           |  2 +-
>  samples/bpf/Makefile                            |  6 +++---
>  samples/bpf/gnu/stubs.h                         |  3 ++-
>  samples/bpf/test_lwt_bpf.sh                     |  2 +-
>  samples/hid/Makefile                            |  6 +++---
>  tools/bpf/bpftool/Documentation/bpftool-gen.rst |  4 ++--
>  tools/bpf/bpftool/Makefile                      |  2 +-
>  tools/bpf/runqslower/Makefile                   |  2 +-
>  tools/build/feature/Makefile                    |  2 +-
>  tools/perf/Documentation/perf-config.txt        |  2 +-
>  tools/perf/Makefile.perf                        |  4 ++--
>  tools/perf/util/llvm-utils.c                    |  4 ++--
>  tools/testing/selftests/bpf/Makefile            |  6 +++---
>  tools/testing/selftests/bpf/gnu/stubs.h         |  3 ++-
>  tools/testing/selftests/hid/Makefile            |  6 +++---
>  tools/testing/selftests/net/Makefile            |  4 ++--
>  tools/testing/selftests/tc-testing/Makefile     |  2 +-
>  21 files changed, 42 insertions(+), 40 deletions(-)
> 

> diff --git a/samples/bpf/gnu/stubs.h b/samples/bpf/gnu/stubs.h
> index 719225b16626..cc37155fbfa5 100644
> --- a/samples/bpf/gnu/stubs.h
> +++ b/samples/bpf/gnu/stubs.h
> @@ -1 +1,2 @@
> -/* dummy .h to trick /usr/include/features.h to work with 'clang -target bpf' */
> +/* SPDX-License-Identifier: GPL-2.0 */

Are these necessary, seeing that the files only contain this single-line
comment?

> +/* dummy .h to trick /usr/include/features.h to work with 'clang --target=bpf' */

Other than this, the change looks good, thanks. Although it should
probably target bpf-next rather than bpf?

Acked-by: Quentin Monnet <quentin@isovalent.com>


