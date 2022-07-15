Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA53D57659C
	for <lists+bpf@lfdr.de>; Fri, 15 Jul 2022 19:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234297AbiGOQy1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Jul 2022 12:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234387AbiGOQy0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Jul 2022 12:54:26 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C7579688
        for <bpf@vger.kernel.org>; Fri, 15 Jul 2022 09:54:25 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id oy13so10007434ejb.1
        for <bpf@vger.kernel.org>; Fri, 15 Jul 2022 09:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GaXQ6/4sZpmCnEBbHlxBJAVY4GxtbvmUa327qZM4cVQ=;
        b=fQXSTHTFNlEjGgN3Bs9bXnhxhNETSMS5NLbJvgk7Hl25C6o5Y5W4K+blnOhSr8JexG
         +Af9p/02ZpIzAqAJ5Sk1cFflshKshd0ptkv2Sph8jSAss0cDGAGIgs6UQ0IdxE5j878x
         RYNnr1h5TF8syZd0UJeqqBWMgm0zBnlt+JKksk9JKx1PDH8EM6Pdh4juyUIYaKX1X/HV
         mRjZ2VV/8yAe3VF3uvn1WdAtq/pJfh/x9vmLJV58DkP7zbrOgzc+3JyckRSNG+/6jPmk
         1kASEFOyKMgr36IC2fkDzLwYbND+BkLMGdpeWVb1h3dAjiAQJP6Pf58jaJ4bzbUVjmq9
         HYFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GaXQ6/4sZpmCnEBbHlxBJAVY4GxtbvmUa327qZM4cVQ=;
        b=mX/MJ+M7S6BuOkfrg62p/1P8DuEr4IekfJixwg+lvx3lx7eT3WFNa2FivAKBY+7xrb
         PL1lJk2aJLRTiZBaK3OASjLaLHETMSQrVJQHsFn7pyGh/YBrXwzFdCumYeBdRyo4As0Y
         zjwZONmINfwf/1Za4Uap73YX80IkAkusgXpuV24m7QFag/jIaNElnQkCM3TdJnDA0eFK
         IV1O3TORQVAANSRYjy1gDaFneNtFYB4yzw7FIuI67pxLijL3aAd7e1snqEbye7a/1cXX
         OSj8hLY8734gf1KIFJHzVkrdINFTsFwZD3l7VKOko8vWR4zOFFCDIyFOCiK+MQPpCU49
         sHYA==
X-Gm-Message-State: AJIora8UG/odhIcDsmkmoDox2i/9+gYZ/ugjhvdQz6WzYZGzuTLQatvv
        M/9KdE5ZnW7BupnW3p5Lm9f7D3nB7yu9kfteIbs=
X-Google-Smtp-Source: AGRyM1vMlokIUC+uq33Q2ChsTDoXxMlN9hW2oN/jsIZxdJ4/gtewSNKg+9PxcloN8cjKqlZ/HNqszbI2WOCpEtEd0L0=
X-Received: by 2002:a17:907:75ef:b0:72b:2fd:1a92 with SMTP id
 jz15-20020a17090775ef00b0072b02fd1a92mr14489835ejc.745.1657904063928; Fri, 15
 Jul 2022 09:54:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220715141835.93513-1-arilou@gmail.com> <20220715141835.93513-2-arilou@gmail.com>
In-Reply-To: <20220715141835.93513-2-arilou@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 15 Jul 2022 09:54:12 -0700
Message-ID: <CAEf4Bzb64KNbu-a_hASYHxobVjuvf9UQ5s0Kw1woSbosm0opZQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/1] libbpf: perfbuf: Add API to get the ring buffer
To:     Jon Doron <arilou@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, Jon Doron <jond@wiz.io>
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

On Fri, Jul 15, 2022 at 7:18 AM Jon Doron <arilou@gmail.com> wrote:
>
> From: Jon Doron <jond@wiz.io>
>
> Add support for writing a custom event reader, by exposing the ring
> buffer.
>
> Few simple examples where this type of needed:
> 1. perf_event_read_simple is allocating using malloc, perhaps you want
>    to handle the wrap-around in some other way.
> 2. Since perf buf is per-cpu then the order of the events is not
>    guarnteed, for example:
>    Given 3 events where each event has a timestamp t0 < t1 < t2,
>    and the events are spread on more than 1 CPU, then we can end
>    up with the following state in the ring buf:
>    CPU[0] => [t0, t2]
>    CPU[1] => [t1]
>    When you consume the events from CPU[0], you could know there is
>    a t1 missing, (assuming there are no drops, and your event data
>    contains a sequential index).
>    So now one can simply do the following, for CPU[0], you can store
>    the address of t0 and t2 in an array (without moving the tail, so
>    there data is not perished) then move on the CPU[1] and set the
>    address of t1 in the same array.
>    So you end up with something like:
>    void **arr[] = [&t0, &t1, &t2], now you can consume it orderely
>    and move the tails as you process in order.
> 3. Assuming there are multiple CPUs and we want to start draining the
>    messages from them, then we can "pick" with which one to start with
>    according to the remaining free space in the ring buffer.

It would be good to mention that with perf_buffer__buffer() you get
access to raw mmap()'ed per-CPU underlying memory region, which
contains both perf buffer data and header, which in turn contains
head/tail positions, so the above scenarios are possible to implement
now.

>
> Signed-off-by: Jon Doron <jond@wiz.io>
> ---
>  tools/lib/bpf/libbpf.c   | 26 ++++++++++++++++++++++++++
>  tools/lib/bpf/libbpf.h   |  2 ++
>  tools/lib/bpf/libbpf.map |  1 +
>  3 files changed, 29 insertions(+)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index e89cc9c885b3..250263812194 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -12485,6 +12485,32 @@ int perf_buffer__buffer_fd(const struct perf_buffer *pb, size_t buf_idx)
>         return cpu_buf->fd;
>  }
>
> +/*
> + * Return the memory region of a ring buffer in *buf_idx* slot of
> + * PERF_EVENT_ARRAY BPF map. This ring buffer can be used to implement
> + * a custom events consumer.
> + * The ring buffer starts with the *struct perf_event_mmap_page*, which
> + * holds the ring buffer managment fields, when accessing the header
> + * structure it's important to be SMP aware.
> + * You can refer to *perf_event_read_simple* for a simple example.
> + */

Please move this comment into libbpf.h to corresponding API
declaration site. And make sure it is a proper doc comment (so add
descriptions for parameters and return results

> +int perf_buffer__buffer(struct perf_buffer *pb, int buf_idx, void **buf,
> +                       size_t *buf_size)

nit: if this fits under 100 characters, keep it as a single line

> +{
> +       struct perf_cpu_buf *cpu_buf;
> +
> +       if (buf_idx >= pb->cpu_cnt)
> +               return libbpf_err(-EINVAL);
> +
> +       cpu_buf = pb->cpu_bufs[buf_idx];
> +       if (!cpu_buf)
> +               return libbpf_err(-ENOENT);
> +
> +       *buf = cpu_buf->base;
> +       *buf_size = pb->mmap_size;
> +       return 0;
> +}
> +

The code itself looks good and straightforward

>  /*
>   * Consume data from perf ring buffer corresponding to slot *buf_idx* in
>   * PERF_EVENT_ARRAY BPF map without waiting/polling. If there is no data to
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 9e9a3fd3edd8..78a7ab8f610a 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -1381,6 +1381,8 @@ LIBBPF_API int perf_buffer__consume(struct perf_buffer *pb);
>  LIBBPF_API int perf_buffer__consume_buffer(struct perf_buffer *pb, size_t buf_idx);
>  LIBBPF_API size_t perf_buffer__buffer_cnt(const struct perf_buffer *pb);
>  LIBBPF_API int perf_buffer__buffer_fd(const struct perf_buffer *pb, size_t buf_idx);

here should be that doc comment

> +LIBBPF_API int perf_buffer__buffer(struct perf_buffer *pb, int buf_idx, void **buf,
> +                                  size_t *buf_size);
>
>  typedef enum bpf_perf_event_ret
>         (*bpf_perf_event_print_t)(struct perf_event_header *hdr,
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 52973cffc20c..971072c6dfd8 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -458,6 +458,7 @@ LIBBPF_0.8.0 {
>                 bpf_program__set_insns;
>                 libbpf_register_prog_handler;
>                 libbpf_unregister_prog_handler;
> +               perf_buffer__buffer;

Current development version is 1.0.0, please put new API in the right section

>  } LIBBPF_0.7.0;
>
>  LIBBPF_1.0.0 {
> --
> 2.36.1
>
