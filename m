Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F097164D041
	for <lists+bpf@lfdr.de>; Wed, 14 Dec 2022 20:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239082AbiLNTs4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Dec 2022 14:48:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239083AbiLNTsV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Dec 2022 14:48:21 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB80186DE
        for <bpf@vger.kernel.org>; Wed, 14 Dec 2022 11:48:20 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id x22so47103668ejs.11
        for <bpf@vger.kernel.org>; Wed, 14 Dec 2022 11:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XWYXAqU7h7z75BTRtLt86qVcm94lkO36hS0zV0uLE18=;
        b=hl622PJfeCnNkc55RzDAbAcgsOHJdvgo7kQ7h0vXGYMiznEZX24ccFIcGPvjpLoC0A
         JZl6egb257Htd/6VqindjCKBePZUuYz4DnRzGqSrgn0BSG7aII+fbQRRqFCfgT+KVuN7
         nHIw+N+pD8h9ETIwU9j5AhykYDhHHCXyezKHTpa4E65dQnv3Nt5xcUAh003uLXL+68fO
         Sm7nZM8qTo33amuglfsjQDeni/i9X/RmDsbUQpCLZJxrYys40xxNYoh/Flg4Ob9m6j/W
         tTI7fo+yBuRwIK53moMBIgdNGiJg/gRTLJ1ZLTSD9Y1KV2TnetwN4EXO4bzyCQpX4f3j
         KKqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XWYXAqU7h7z75BTRtLt86qVcm94lkO36hS0zV0uLE18=;
        b=RMcZiU2JgFODoB5yeXj2LEFcatmzJo1CRYecPdHHTBAVUziMJF2P9Pbxvb2PxPYw9m
         oIttWspKtGDPqeD6H5d6Vn8Y1/tMz1BGiRsMWu+EzIVXMCLys5Fa+LvWHgj4ONI69Zgd
         X3xUXM0X7c9rx43I1tFeXh8b+PdaIAsJ9DP3T4StEt00KDdk1ou8vFxy3bZXIJZb44mw
         U/Rjox9YQRBlNaCjs0FgP1ol7vLtyoP7+h8h9A96QfxUxceI4I6x1kT2z/YJlFVckBuc
         5Sk2divhNkF+r36lFEKvFKjlUIffXWTD+6zftTrgT3bQgNB9nWGsiqJFOu1kTXHCwze3
         unAw==
X-Gm-Message-State: ANoB5plOh29ntHDajd7EXa0ZKM/3dpjQzNtBx7RRP2qyJrpxcq8e3eGy
        jI7M3grbS/9Acm7nrEXAFPXhkQqJtw+YMFrxwvQ=
X-Google-Smtp-Source: AA0mqf7ppCMhccpi52S7wiiKB+feV5QckMvqSnqAn21Wc6reTjo6Zark+/Zh/biLsQ30hxwo62+P6OYMXpca0aV8gWc=
X-Received: by 2002:a17:906:7116:b0:7c1:8450:f964 with SMTP id
 x22-20020a170906711600b007c18450f964mr1039274ejj.176.1671047298782; Wed, 14
 Dec 2022 11:48:18 -0800 (PST)
MIME-Version: 1.0
References: <20221214100424.1209771-1-jolsa@kernel.org>
In-Reply-To: <20221214100424.1209771-1-jolsa@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 14 Dec 2022 11:48:06 -0800
Message-ID: <CAEf4BzYmt+7k-eovdj2MWMKOj5FCwhExHa7jSFUX+9Q2NfHHLg@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next] bpf: Remove trace_printk_lock
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 14, 2022 at 2:04 AM Jiri Olsa <jolsa@kernel.org> wrote:
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
> v2 changes:
>   - changed subject [Yonghong]
>   - added WARN_ON_ONCE to get_printk_buf [Song]
>
>  kernel/trace/bpf_trace.c | 61 +++++++++++++++++++++++++++++++---------
>  1 file changed, 47 insertions(+), 14 deletions(-)
>
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 3bbd3f0c810c..a992b5a47fd6 100644
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
> +       level = this_cpu_inc_return(buf->level);
> +       if (WARN_ON_ONCE(level > BPF_TRACE_PRINTK_LEVELS)) {
> +               put_printk_buf(buf);
> +               return false;
> +       }
> +       *data = (char *) this_cpu_ptr(&buf->data[level - 1]);
> +       return true;
> +}
>
>  BPF_CALL_5(bpf_trace_printk, char *, fmt, u32, fmt_size, u64, arg1,
>            u64, arg2, u64, arg3)
>  {
>         u64 args[MAX_TRACE_PRINTK_VARARGS] = { arg1, arg2, arg3 };
>         u32 *bin_args;
> -       static char buf[BPF_TRACE_PRINTK_SIZE];
> -       unsigned long flags;
> +       char *buf;
>         int ret;
>
> +       if (!get_printk_buf(&printk_buf, &buf))
> +               return -EBUSY;
> +
>         ret = bpf_bprintf_prepare(fmt, fmt_size, args, &bin_args,
>                                   MAX_TRACE_PRINTK_VARARGS);
>         if (ret < 0)
> -               return ret;
> +               goto out;
>
> -       raw_spin_lock_irqsave(&trace_printk_lock, flags);
> -       ret = bstr_printf(buf, sizeof(buf), fmt, bin_args);
> +       ret = bstr_printf(buf, BPF_TRACE_PRINTK_SIZE, fmt, bin_args);
>
>         trace_bpf_trace_printk(buf);
> -       raw_spin_unlock_irqrestore(&trace_printk_lock, flags);
>
>         bpf_bprintf_cleanup();
>
> +out:
> +       put_printk_buf(&printk_buf);
>         return ret;
>  }
>
> @@ -427,31 +456,35 @@ const struct bpf_func_proto *bpf_get_trace_printk_proto(void)
>         return &bpf_trace_printk_proto;
>  }
>
> +static DEFINE_PER_CPU(struct trace_printk_buf, vprintk_buf);
> +
>  BPF_CALL_4(bpf_trace_vprintk, char *, fmt, u32, fmt_size, const void *, data,
>            u32, data_len)
>  {
> -       static char buf[BPF_TRACE_PRINTK_SIZE];
> -       unsigned long flags;
>         int ret, num_args;
>         u32 *bin_args;
> +       char *buf;
>
>         if (data_len & 7 || data_len > MAX_BPRINTF_VARARGS * 8 ||
>             (data_len && !data))
>                 return -EINVAL;
>         num_args = data_len / 8;
>
> +       if (!get_printk_buf(&vprintk_buf, &buf))
> +               return -EBUSY;
> +
>         ret = bpf_bprintf_prepare(fmt, fmt_size, data, &bin_args, num_args);
>         if (ret < 0)
> -               return ret;
> +               goto out;
>
> -       raw_spin_lock_irqsave(&trace_printk_lock, flags);
> -       ret = bstr_printf(buf, sizeof(buf), fmt, bin_args);
> +       ret = bstr_printf(buf, BPF_TRACE_PRINTK_SIZE, fmt, bin_args);
>
>         trace_bpf_trace_printk(buf);
> -       raw_spin_unlock_irqrestore(&trace_printk_lock, flags);
>
>         bpf_bprintf_cleanup();

I checked what this is doing. And it seems like we have a very similar
thing there already, with preempt_disable(), 3-level buffers, etc.
Would it make sense to roll this new change into bpf_bprintf_prepare()
and make it return the buffer for bpf_trace_printk(), even if it is
not used for bpf_snprintf() ?

>
> +out:
> +       put_printk_buf(&vprintk_buf);
>         return ret;
>  }
>
> --
> 2.38.1
>
