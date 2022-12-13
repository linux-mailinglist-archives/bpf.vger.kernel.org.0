Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3633E64BC56
	for <lists+bpf@lfdr.de>; Tue, 13 Dec 2022 19:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236286AbiLMStA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Dec 2022 13:49:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235875AbiLMStA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Dec 2022 13:49:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46EE2F5F
        for <bpf@vger.kernel.org>; Tue, 13 Dec 2022 10:48:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 09781B81227
        for <bpf@vger.kernel.org>; Tue, 13 Dec 2022 18:48:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB44DC433F0
        for <bpf@vger.kernel.org>; Tue, 13 Dec 2022 18:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670957336;
        bh=nXcMLwWVry7qGVvIoxwBK7/8pvJ1JyQOQ3Kg8qEEmDY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ym+Ktq4039dg59E1XNFy/VEGTmi2OTqH1PQQp9QlB35XoADEsEzQb2K+918Ntf5Oh
         5sRMNaedfOCdYcVynYS7ByuUc6z+RuzBVQtjVQSn7Z88l1lIy1oTIuxfYhKcn2Wj59
         QkLlvxyh1EhBMVl0BIutwyjZItaeDx0I9LtCJxC11u5/f5rc/Mk+2esSy7B3frXarx
         7zN/WK8nZb72eCQcIFpj2IN65VG/2A+nSZZRZ7oPKWbqo502PyfLSMOPO1+kPiGvhr
         +CK1+zdeyXfcgtDTQxjJvENW0gaJoMFfi51Ge0i8Ihgl8Pweis/hIu5LZytOdeKe6i
         wvdxgdfvfE/xA==
Received: by mail-lf1-f46.google.com with SMTP id z26so6433702lfu.8
        for <bpf@vger.kernel.org>; Tue, 13 Dec 2022 10:48:56 -0800 (PST)
X-Gm-Message-State: ANoB5pk0PZeK2NECdnciMJnMfY64b2+k3TWNRYg0i7XIOyXUT7s7RjGw
        lRwmGTJuz9O3yhuja+SzO24w6o/sslCq/etJStk=
X-Google-Smtp-Source: AA0mqf54rV41lQh/TW03VNTxK7H8uPMjc0/t9+DZt0Gb4SEF1EaGhWw77fYtiwMB9takmg7CtXrDgH6OKES/XJwAqHk=
X-Received: by 2002:ac2:4c93:0:b0:4b5:b46b:17c7 with SMTP id
 d19-20020ac24c93000000b004b5b46b17c7mr1609186lfl.215.1670957334748; Tue, 13
 Dec 2022 10:48:54 -0800 (PST)
MIME-Version: 1.0
References: <20221213140843.803293-1-jolsa@kernel.org>
In-Reply-To: <20221213140843.803293-1-jolsa@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Tue, 13 Dec 2022 10:48:43 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5sQaspOhurLWm0igDUJk+V9ihmt0WnjaKsq1gJ66F6Gw@mail.gmail.com>
Message-ID: <CAPhsuW5sQaspOhurLWm0igDUJk+V9ihmt0WnjaKsq1gJ66F6Gw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Remove trace_printk_lock lock
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Hao Sun <sunhao.th@gmail.com>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Dec 13, 2022 at 6:09 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Both bpf_trace_printk and bpf_trace_vprintk helpers use static buffer
> guarded with trace_printk_lock spin lock.
>
> The spin lock contention causes issues with bpf programs attached to
> contention_begin tracepoint [1] [2].
>
> Andrii suggested we could get rid of the contention by using trylock,
> but we could actually get rid of the spinlock completely by using
> percpu buffers the same way as for bin_args in bpf_bprintf_prepare
> function.
>
> Adding 4 per cpu buffers (1k each) which should be enough for all
> possible nesting contexts (normal, softirq, irq, nmi) or possible
> (yet unlikely) probe within the printk helpers.
>
> In very unlikely case we'd run out of the nesting levels the printk
> will be omitted.
>
> [1] https://lore.kernel.org/bpf/CACkBjsakT_yWxnSWr4r-0TpPvbKm9-OBmVUhJb7hV3hY8fdCkw@mail.gmail.com/
> [2] https://lore.kernel.org/bpf/CACkBjsaCsTovQHFfkqJKto6S4Z8d02ud1D7MPESrHa1cVNNTrw@mail.gmail.com/
>
> Reported-by: Hao Sun <sunhao.th@gmail.com>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  kernel/trace/bpf_trace.c | 61 +++++++++++++++++++++++++++++++---------
>  1 file changed, 47 insertions(+), 14 deletions(-)
>
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 3bbd3f0c810c..b9287b3a5540 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -369,33 +369,62 @@ static const struct bpf_func_proto *bpf_get_probe_write_proto(void)
>         return &bpf_probe_write_user_proto;
>  }
>
> -static DEFINE_RAW_SPINLOCK(trace_printk_lock);
> -
>  #define MAX_TRACE_PRINTK_VARARGS       3
>  #define BPF_TRACE_PRINTK_SIZE          1024
> +#define BPF_TRACE_PRINTK_LEVELS                4
> +
> +struct trace_printk_buf {
> +       char data[BPF_TRACE_PRINTK_LEVELS][BPF_TRACE_PRINTK_SIZE];
> +       int level;
> +};
> +static DEFINE_PER_CPU(struct trace_printk_buf, printk_buf);
> +
> +static void put_printk_buf(struct trace_printk_buf __percpu *buf)
> +{
> +       if (WARN_ON_ONCE(this_cpu_read(buf->level) == 0))
> +               return;
> +       this_cpu_dec(buf->level);
> +       preempt_enable();
> +}
> +
> +static bool get_printk_buf(struct trace_printk_buf __percpu *buf, char **data)
> +{
> +       int level;
> +
> +       preempt_disable();

Can we use migrate_disable() instead?

> +       level = this_cpu_inc_return(buf->level);
> +       if (level > BPF_TRACE_PRINTK_LEVELS) {

Maybe add WARN_ON_ONCE() here?

Thanks,
Song

[...]
