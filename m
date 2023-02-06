Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 193B768C9D1
	for <lists+bpf@lfdr.de>; Mon,  6 Feb 2023 23:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjBFWyX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Feb 2023 17:54:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbjBFWyV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Feb 2023 17:54:21 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9D3305EE;
        Mon,  6 Feb 2023 14:54:18 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id m8so13215560edd.10;
        Mon, 06 Feb 2023 14:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J75NycyL66W62IiHP4VOFBvEWLmhVQd9tt6hGWKjgIc=;
        b=SlvuqXgWgd8Ab26YxwngX4tdcDM6KLP6dhJMO4DDoysOSaPX6/dRv87KJ5X6uKOFyM
         d0a5zALVTofgslMrdrjHXzMKmL6e7Xsm7oywmAdqtbqIh9jT0/xkmQa/Ilt26dTQZgiw
         +nRIPPEXItuMN7/30ie7uzw6fKTkJ0K6PbZlzOVEMgj/zRKt/KXtne0DG4dbe9IsrLqf
         tuLoBv+5aYhsWAWZVohkJ+6c4zCn2GR8jZf8a4V+DFVLYjCV1HrdDzIJhO/AD0MiMK/j
         MkPxc0bQAGOb6Bk5GGZfD+mbpP6Ig3SkPjSrFL22lqM6Q1xwCw5Fhv25Vw5aUCxX8ohD
         c/1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J75NycyL66W62IiHP4VOFBvEWLmhVQd9tt6hGWKjgIc=;
        b=r+V9JqbKs432gSdnPuwIvbw1csnsV6pJ5xeCy+yFANOD3222+k4Hyanrnv5EXJZZAI
         o3LRPNIi+wuHIoilmJPsMFalueFEYF3L94XSQk5o06B71BlkOiJbXHK2X8V7r2JwYG6Y
         Uju+hgP2k3zMmHCGQTumf2fQYEpV944KrLqmYYjHy2gcv3AaE+7GlW7bu1BCMDZr5S0P
         uNZKev092fzl1xaEhLEZ3yhokdBNfOlDjDiB9eV2rxNHzdnTx/TlteFNm+Bix29B85kA
         wBBjbUeNfn7k5gz4Xg5XhAQJ+7fz2K4ZK//fzL8J8oiQ/vF5IC4JBPjnrVN6fc/pgNVA
         T9AA==
X-Gm-Message-State: AO0yUKXd9vFUiJvvLUZRkS6c/zI0DAUmQlEbeJHH3wD/3SGVpIz7TzXL
        HANt5WJwcX8Y/HOV7EqXj3WOs0lTCWZlBHMZRtc=
X-Google-Smtp-Source: AK7set8lu7EDxtJjAdGowJUwSW07rxe3Ns80W1f5Mf9mdP8O9gpTCtTl6d2Lc9xPFAc03N0/UR6G1Em8DAE2XVsr9VQ=
X-Received: by 2002:a50:f603:0:b0:49d:ec5e:1e98 with SMTP id
 c3-20020a50f603000000b0049dec5e1e98mr36394edn.5.1675724056464; Mon, 06 Feb
 2023 14:54:16 -0800 (PST)
MIME-Version: 1.0
References: <tencent_9E0636426959DE97692A50AF79A3D9888B08@qq.com>
In-Reply-To: <tencent_9E0636426959DE97692A50AF79A3D9888B08@qq.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 6 Feb 2023 14:54:03 -0800
Message-ID: <CAEf4BzZa2PxezazfhqUsDjcT0PJpk0rBOh=_9YdcXmc00dh6Kg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] samples: bpf: Add macro SYSCALL() for aarch64
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
        "open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)" 
        <bpf@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
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

On Mon, Feb 6, 2023 at 3:34 AM Rong Tao <rtoax@foxmail.com> wrote:
>
> From: Rong Tao <rongtao@cestc.cn>
>
> kernel arm64/kernel/sys.c macro __SYSCALL() adds a prefix __arm64_, we
> should support it for aarch64. The following is the output of the bpftrace
> script:
>
>     $ sudo bpftrace -l | grep sys_write
>     ...
>     kprobe:__arm64_sys_write
>     kprobe:__arm64_sys_writev
>     ...
>
> Signed-off-by: Rong Tao <rongtao@cestc.cn>
> ---

samples were converted to SEC("ksyscall") programs and BPF_KSYSCALL()
macro, there is not even samples/bpf/trace_common.h there. Please
check the latest bpf-next/master.


>  samples/bpf/trace_common.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/samples/bpf/trace_common.h b/samples/bpf/trace_common.h
> index 8cb5400aed1f..fafc699af0a3 100644
> --- a/samples/bpf/trace_common.h
> +++ b/samples/bpf/trace_common.h
> @@ -6,6 +6,8 @@
>  #define SYSCALL(SYS) "__x64_" __stringify(SYS)
>  #elif defined(__s390x__)
>  #define SYSCALL(SYS) "__s390x_" __stringify(SYS)
> +#elif defined(__aarch64__)
> +#define SYSCALL(SYS) "__arm64_" __stringify(SYS)
>  #else
>  #define SYSCALL(SYS)  __stringify(SYS)
>  #endif
> --
> 2.39.1
>
