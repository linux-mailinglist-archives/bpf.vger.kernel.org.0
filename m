Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91AF15FAD33
	for <lists+bpf@lfdr.de>; Tue, 11 Oct 2022 09:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiJKHHD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Oct 2022 03:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbiJKHHC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Oct 2022 03:07:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0016D814C6
        for <bpf@vger.kernel.org>; Tue, 11 Oct 2022 00:06:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9AEF76112C
        for <bpf@vger.kernel.org>; Tue, 11 Oct 2022 07:06:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 105FDC43142
        for <bpf@vger.kernel.org>; Tue, 11 Oct 2022 07:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665472018;
        bh=FCJg8foX5psLkUPvlFNJIKUqS2JZVRqEJIpOPDkL8hc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ju7SIyAjCiy+8ZPHUqj4zRufZA358Csd4YLhQkUvL0fnWmk6Q/P+g4595ELZTLT83
         ouIoNkekfMT1zv/gyH8QHdSAi9lxfRAW4bpqYhNmFsqVkqY0zERHrWSU1SPZ+ENM/s
         k1DC3B6LUg1xgNy5Tpx6DCBZqcHEUXtXylZe27y2g074MS7pyu2AJCnXWLPHKL9uCR
         R9Htc4Z/6gLbi+FkpLWM1LQq06iixb1jVLEES6XVGw8RzbqJEqHcSU11vFJxsGQZCm
         STKtCUoj2+hrOACS8r5/WfefhnxhuVY1yGRiweI8HU4o7Rh2HwLdEO6NnUtRZKBXx/
         LH4ED7buphmRw==
Received: by mail-ej1-f43.google.com with SMTP id k2so29391554ejr.2
        for <bpf@vger.kernel.org>; Tue, 11 Oct 2022 00:06:57 -0700 (PDT)
X-Gm-Message-State: ACrzQf0l+vprvIAqFuItgL9dgMRC+EehRC5H2kINtVcrC/eT5hv/ciNp
        AY2XVjlDK/WJj7x9Q3gSlFhepabpW918+ZrCtT4=
X-Google-Smtp-Source: AMsMyM4CR6cOpNxfu9uzgZqbw9gBlYo3LlT5IXKY070IKidzgFxL6AarXD4SOwCoSms7wr2K5FcOrwwbW5hm60aQQNI=
X-Received: by 2002:a17:906:58c6:b0:78d:b37f:5ce5 with SMTP id
 e6-20020a17090658c600b0078db37f5ce5mr8359160ejs.707.1665472016258; Tue, 11
 Oct 2022 00:06:56 -0700 (PDT)
MIME-Version: 1.0
References: <20221009215926.970164-1-jolsa@kernel.org> <20221009215926.970164-4-jolsa@kernel.org>
In-Reply-To: <20221009215926.970164-4-jolsa@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Tue, 11 Oct 2022 00:06:44 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4sgGq3ujm-6cnizYnAP+XX5vqn7MkpAgKu=kuvOsxsag@mail.gmail.com>
Message-ID: <CAPhsuW4sgGq3ujm-6cnizYnAP+XX5vqn7MkpAgKu=kuvOsxsag@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/8] bpf: Rename __bpf_kprobe_multi_cookie_cmp to bpf_kprobe_multi_addrs_cmp
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Christoph Hellwig <hch@lst.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Martynas Pumputis <m@lambda.lt>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Oct 9, 2022 at 3:00 PM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Renaming __bpf_kprobe_multi_cookie_cmp to bpf_kprobe_multi_addrs_cmp,
> because it's more suitable to current and upcoming code.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Song Liu <song@kernel.org>

> ---
>  kernel/trace/bpf_trace.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 688552df95ca..9be1a2b6b53b 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2545,7 +2545,7 @@ static void bpf_kprobe_multi_cookie_swap(void *a, void *b, int size, const void
>         swap(*cookie_a, *cookie_b);
>  }
>
> -static int __bpf_kprobe_multi_cookie_cmp(const void *a, const void *b)
> +static int bpf_kprobe_multi_addrs_cmp(const void *a, const void *b)
>  {
>         const unsigned long *addr_a = a, *addr_b = b;
>
> @@ -2556,7 +2556,7 @@ static int __bpf_kprobe_multi_cookie_cmp(const void *a, const void *b)
>
>  static int bpf_kprobe_multi_cookie_cmp(const void *a, const void *b, const void *priv)
>  {
> -       return __bpf_kprobe_multi_cookie_cmp(a, b);
> +       return bpf_kprobe_multi_addrs_cmp(a, b);
>  }
>
>  static u64 bpf_kprobe_multi_cookie(struct bpf_run_ctx *ctx)
> @@ -2574,7 +2574,7 @@ static u64 bpf_kprobe_multi_cookie(struct bpf_run_ctx *ctx)
>                 return 0;
>         entry_ip = run_ctx->entry_ip;
>         addr = bsearch(&entry_ip, link->addrs, link->cnt, sizeof(entry_ip),
> -                      __bpf_kprobe_multi_cookie_cmp);
> +                      bpf_kprobe_multi_addrs_cmp);
>         if (!addr)
>                 return 0;
>         cookie = link->cookies + (addr - link->addrs);
> --
> 2.37.3
>
