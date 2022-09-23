Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E27A65E850F
	for <lists+bpf@lfdr.de>; Fri, 23 Sep 2022 23:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbiIWVkv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Sep 2022 17:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbiIWVku (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Sep 2022 17:40:50 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B45C132FFD
        for <bpf@vger.kernel.org>; Fri, 23 Sep 2022 14:40:49 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id y8so1845959edc.10
        for <bpf@vger.kernel.org>; Fri, 23 Sep 2022 14:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=lbbwr++8qW3rns3ZwDfAsTXhTtdhZ7FcdYJvtkVS9Nw=;
        b=qu/A0JcTJKfTqKpjs/16bAlW6nMPzbNBy38M1EJfbZfqbBnilfZFKaHwhCTfhmsVu6
         91kJINi5gB9q9bsBBBAHiDR6u4c6ByCsjf/K9FUhif5tSnANk/C0rK7jdyrRfqzDijBr
         JpvynDMnRJZpxeGzyCfZ8dKK7w7yhsoVOo1+3r61jz5G0gnWBBJVBbJ8Rhs6QKaCnKVz
         pP4TKjjT+clDh4yb2mPJJHPmErAOQ/Xz6le2O6p4z+qpMFBdsARAluoXaD5gCJUnGs6W
         MDZ2lgsfkGGB1n7n9XmIRVywWnYmDDhiKAU4zsjoM5gmlwq/3cupUwvu0IJhCM19uueV
         zZTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=lbbwr++8qW3rns3ZwDfAsTXhTtdhZ7FcdYJvtkVS9Nw=;
        b=KQ5z9WmAcZch+42Yq0OEylc10OAQ7BhyqnmI4VJfwi4TQnsNzVp2OdQLStkoaLPbwN
         kHhhOLUbzcp0R40yP7nnp9oYLyXLWb8XCKuMBQGPM+V7hdlIK1nH6DYDJ6DewCUh95I1
         WRM634QczwhvQabcQxaqgwzmBWHjEYTBi0eCpt9uInefn/3GF37gdTCx/t00ohzqt/Qs
         9HdO43Mh6n/rMu17mXK3Jv3Z32NlK7r/ymYr0zYGfP/NwYKg9tuBnUVma+83r/9vcF1W
         1gxzVlFEIZ6vpMhuLWVQgavEoQQ+IB9eOJ4ag4ir3UGHpHM0uPW6o55wiPq57UJG2O8T
         rVsw==
X-Gm-Message-State: ACrzQf3uLlGdBhfRcTJxcDeNWt1CC94wbnysvXwjetf0Sk1YenfPCSa6
        MzrLwCld2ZJ9c9j/IbXarhAjIwgf0Am42hTot7Q=
X-Google-Smtp-Source: AMsMyM7lC37mHo6IcVznYq4qR7mvdYcVX3JGenCsauOK700l9gsJGMFhiHw5+G/xVID0C/RL97AbuaTdtQVzdmpobnY=
X-Received: by 2002:aa7:de9a:0:b0:44d:8191:44c5 with SMTP id
 j26-20020aa7de9a000000b0044d819144c5mr10390074edv.232.1663969247779; Fri, 23
 Sep 2022 14:40:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220922210320.1076658-1-jolsa@kernel.org> <20220922210320.1076658-5-jolsa@kernel.org>
In-Reply-To: <20220922210320.1076658-5-jolsa@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 23 Sep 2022 14:40:36 -0700
Message-ID: <CAEf4BzbXYsA6A6LWBmXvpAMTYGGbTKNopo_NMRjdZs8nNXFF_Q@mail.gmail.com>
Subject: Re: [PATCHv4 bpf-next 4/6] bpf: Adjust kprobe_multi entry_ip for CONFIG_X86_KERNEL_IBT
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Martynas Pumputis <m@lambda.lt>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
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

On Thu, Sep 22, 2022 at 2:04 PM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Martynas reported bpf_get_func_ip returning +4 address when
> CONFIG_X86_KERNEL_IBT option is enabled.
>
> When CONFIG_X86_KERNEL_IBT is enabled we'll have endbr instruction
> at the function entry, which screws return value of bpf_get_func_ip()
> helper that should return the function address.
>
> There's short term workaround for kprobe_multi bpf program made by
> Alexei [1], but we need this fixup also for bpf_get_attach_cookie,
> that returns cookie based on the entry_ip value.
>
> Moving the fixup in the fprobe handler, so both bpf_get_func_ip
> and bpf_get_attach_cookie get expected function address when
> CONFIG_X86_KERNEL_IBT option is enabled.
>
> Also renaming kprobe_multi_link_handler entry_ip argument to fentry_ip
> so it's clearer this is an ftrace __fentry__ ip.
>
> [1] commit 7f0059b58f02 ("selftests/bpf: Fix kprobe_multi test.")
>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Reported-by: Martynas Pumputis <m@lambda.lt>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---

lgtm

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  kernel/trace/bpf_trace.c                      | 20 +++++++++++++++++--
>  .../selftests/bpf/progs/kprobe_multi.c        |  4 +---
>  2 files changed, 19 insertions(+), 5 deletions(-)
>

[...]
