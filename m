Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5121061A2F1
	for <lists+bpf@lfdr.de>; Fri,  4 Nov 2022 22:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbiKDVNC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Nov 2022 17:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiKDVNC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Nov 2022 17:13:02 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313A943843;
        Fri,  4 Nov 2022 14:12:57 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id q9so16561900ejd.0;
        Fri, 04 Nov 2022 14:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k3lmctAkmWwvXl1VWZl8A6gGM1NjwJhPSeg6lKVknz0=;
        b=iJVDVoTi7bPLy/0kPNkE3R3MGJlvuHmzBmXikRJcYAQRHu+UsCqPyYWgCGQtrHcgh8
         1hSkExlqylK5lZSfv/pzA5zekZfsNxZ6iLuN350fFKZp9EhUDJqezVcj+1uv2xk6doUo
         94YdDHCWGjyhgBLOVy7fOHqOHepXWBEhPnYm+ltONPAWDOxxZbZmFptSnq1K1w12dasM
         SKkg7FNi0BLuAC5wBmlVWIYHrRtYKS/wkJiDixszrV3NSK0cFiaHThsAj9KFMw/zg3Tf
         W3FXD9PON7zA7nfFBfCYGmdth+KwGelzCTA/TuKdKWo7/TrAMeGkku10MzxG+9e0YIvn
         6m6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k3lmctAkmWwvXl1VWZl8A6gGM1NjwJhPSeg6lKVknz0=;
        b=adwJm2Pg9ZfLhkA6+43rTYZkwABYu+h0rALYQpQrXcWVsi+QM2+XEcW+rC9bee6nSO
         ATi8eQh/kRXVkfd2C2QXqoVQE9+vMgiXfJCwsh7RRoojVhnKQHU+AEPuznTmyqIHzG5n
         1K4iA+U1oRXPgZX5NZLltlJsbZ3glez1PrBdbac5anj4TbO5zerew0j8TaH/12Wrnl1Y
         1a50ICdrhNlUZa1jlgKZI/cFPRbJFYzKK6EOb16EspP1Eo+B9UmMqIYjKFS9u5gkYnG3
         /GDgxkPwbbgWc9j7WUWirh10UdH1+1+AaxKxNQnwZVQlt7Tu96Lo8x5gk0682hiNKn0X
         8rYg==
X-Gm-Message-State: ACrzQf26N41Z01cmV6J2t3veDTO3gn80g6sqk2NNFqNt4AJhNLBWIZOf
        ZI1jV5pJ3IbfXKlq9h+WLfT9PBH1Zvp23uzVYWw=
X-Google-Smtp-Source: AMsMyM6L21ktfnCGlTxwCwRIQyXV0qnnnFPKIdqwggnMU+048Ib/Gh6BVhGnMzx7G+R11Qkr/dv85V/+r9xMYYhyGA0=
X-Received: by 2002:a17:907:8a24:b0:795:bb7d:643b with SMTP id
 sc36-20020a1709078a2400b00795bb7d643bmr37134945ejc.115.1667596375750; Fri, 04
 Nov 2022 14:12:55 -0700 (PDT)
MIME-Version: 1.0
References: <20221031215728.50389-1-kuniyu@amazon.com>
In-Reply-To: <20221031215728.50389-1-kuniyu@amazon.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 4 Nov 2022 14:12:43 -0700
Message-ID: <CAEf4BzaU+jiCQy7g4N0UuifL0TcdEY4Z_5_3MHiOwZhFzKFFFg@mail.gmail.com>
Subject: Re: [PATCH] arm64/syscall: Include asm/ptrace.h in syscall_wrapper header.
To:     Kuniyuki Iwashima <kuniyu@amazon.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Akihiro HARAI <jharai0815@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Kuniyuki Iwashima <kuni1840@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 31, 2022 at 2:57 PM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
>
> Add the same change for ARM64 as done in the commit 9440c4294160
> ("x86/syscall: Include asm/ptrace.h in syscall_wrapper header") to
> make sure all syscalls see 'struct pt_regs' definition and resulted
> BTF for '__arm64_sys_*(struct pt_regs *regs)' functions point to
> actual struct.
>
> Without this patch, the BPF verifier refuses to load a tracing prog
> which accesses pt_regs.
>
>   bpf(BPF_PROG_LOAD, {prog_type=0x1a, ...}, 128) = -1 EACCES
>
> With this patch, we can see the correct error, which saves us time
> in debugging the prog.
>
>   bpf(BPF_PROG_LOAD, {prog_type=0x1a, ...}, 128) = 4
>   bpf(BPF_RAW_TRACEPOINT_OPEN, {raw_tracepoint={name=NULL, prog_fd=4}}, 128) = -1 ENOTSUPP
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---

Some of these problems will be mitigated by [0], but still good to
have completely types if possible. LGTM.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

  [0] https://patchwork.kernel.org/project/netdevbpf/list/?series=691488&state=*

> Note the cited commit only exists in the tip tree for now.
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=9440c42941606af4c379afa3cf8624f0dc43a629
> ---
>  arch/arm64/include/asm/syscall_wrapper.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/include/asm/syscall_wrapper.h b/arch/arm64/include/asm/syscall_wrapper.h
> index b383b4802a7b..d30217c21eff 100644
> --- a/arch/arm64/include/asm/syscall_wrapper.h
> +++ b/arch/arm64/include/asm/syscall_wrapper.h
> @@ -8,7 +8,7 @@
>  #ifndef __ASM_SYSCALL_WRAPPER_H
>  #define __ASM_SYSCALL_WRAPPER_H
>
> -struct pt_regs;
> +#include <asm/ptrace.h>
>
>  #define SC_ARM64_REGS_TO_ARGS(x, ...)                          \
>         __MAP(x,__SC_ARGS                                       \
> --
> 2.30.2
>
