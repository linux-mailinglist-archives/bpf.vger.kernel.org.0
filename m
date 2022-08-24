Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7D0A5A03AC
	for <lists+bpf@lfdr.de>; Thu, 25 Aug 2022 00:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240835AbiHXWEX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 18:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240876AbiHXWEL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 18:04:11 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102F477576;
        Wed, 24 Aug 2022 15:04:07 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id n7so17922642ejh.2;
        Wed, 24 Aug 2022 15:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Tvo4KEWB4BfarSnzwYPGZG4zYGwhj32j+2JFcJaFoGA=;
        b=G/ilqra0+ovuT46s5RdJ3m/DQbXsjTUKnXiiNflrpsTbr0X2WP1W5p5SPRPt4KPOOo
         gYQnH9cHNuSvDSmPRNJTsXOMS5oSv6ea8ZUJhdMYtTlq/gSrUF5EnewoudZVltDpi/RY
         gBDlsYV8EpIPUJJKlP4ij+hl+PxA5rjUMF3I/odN83cMUbcWK1ElpjOzLbZFWpbhmbun
         ukTmBASCj+i0ZPsr75B6/OsTHykbnKdvgy+3YZwvdRei2PEa5tLNpKck+JsJwPllxfu5
         qOpz8ENbnCmNLXuGWp1UTxOWOGxpdB4QW1Lu+0y05Wwrk15ydYTy3h0X6hu+kb3tfECp
         mQbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Tvo4KEWB4BfarSnzwYPGZG4zYGwhj32j+2JFcJaFoGA=;
        b=QMDwMX95HvQHFJ91YPc6sPQyH0SvZiSJYGN4vKW0YyZHXYW7jg/YGtp1/2Wi/IUkAr
         SGfmELXFxKJJKeCCi5KXTxL5MYRUYTQjeufJi1uid8czmZdSG+/Eeqx/bztM1oxywHxZ
         fUNxuKH57gVxX1sJPLnbEVUPnLyugLuI2BuRPXHVpZKOeN5oyHISFbzm3VWdoERI/K5+
         M8a7fy6PqZA6PsdvYJSldAaTiqXIBi6Jguwicmx7JiuBoSzc7DytoYuKXKzAdeeeOXqt
         oTPRUNKHzm7fWY3820h9ucEeV7N2rExCPVZRclfpC2QzDzWZmK2y/Vg5mYibhPnGM9m/
         C4Wg==
X-Gm-Message-State: ACgBeo3uyi4cS/jxmm5sCZty53QR7IqaqPKmXXRc0tvN37v+LJOY4RZu
        FdZyJEqxPUAx5A1zif88Xnzdrz3SUUurCE7zHgA=
X-Google-Smtp-Source: AA6agR5CbOOqDDFFpDZjt7mwWG0f9rU+1+4u9f8xbl3T5fQ2MTP1r/13FInffVcHgYty4rPAOzbKBUxZoYjJ1CX7obg=
X-Received: by 2002:a17:907:7e9e:b0:73d:ae12:5f11 with SMTP id
 qb30-20020a1709077e9e00b0073dae125f11mr630572ejc.176.1661378645504; Wed, 24
 Aug 2022 15:04:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220818221212.464487-1-void@manifault.com> <20220818221212.464487-5-void@manifault.com>
In-Reply-To: <20220818221212.464487-5-void@manifault.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 24 Aug 2022 15:03:54 -0700
Message-ID: <CAEf4Bzbj0ACUmZqQLhRR5DvEX9Zphqz5UwBWdkTdXfKqxWM0mQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] selftests/bpf: Add selftests validating the user ringbuf
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, joannelkoong@gmail.com, tj@kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Aug 18, 2022 at 3:12 PM David Vernet <void@manifault.com> wrote:
>
> This change includes selftests that validate the expected behavior and
> APIs of the new BPF_MAP_TYPE_USER_RINGBUF map type.
>
> Signed-off-by: David Vernet <void@manifault.com>
> ---
>  .../selftests/bpf/prog_tests/user_ringbuf.c   | 755 ++++++++++++++++++
>  .../selftests/bpf/progs/user_ringbuf_fail.c   | 177 ++++
>  .../bpf/progs/user_ringbuf_success.c          | 220 +++++
>  .../testing/selftests/bpf/test_user_ringbuf.h |  35 +
>  4 files changed, 1187 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/user_ringbuf.c
>  create mode 100644 tools/testing/selftests/bpf/progs/user_ringbuf_fail.c
>  create mode 100644 tools/testing/selftests/bpf/progs/user_ringbuf_success.c
>  create mode 100644 tools/testing/selftests/bpf/test_user_ringbuf.h
>

[...]

> +       /* Write some number of samples to the ring buffer. */
> +       for (i = 0; i < num_samples; i++) {
> +               struct sample *entry;
> +               int read;
> +
> +               entry = user_ring_buffer__reserve(ringbuf, sizeof(*entry));
> +               if (!entry) {
> +                       err = -errno;
> +                       goto done;
> +               }
> +
> +               entry->pid = getpid();
> +               entry->seq = i;
> +               entry->value = i * i;
> +
> +               read = snprintf(entry->comm, sizeof(entry->comm), "%u", i);
> +               if (read <= 0) {
> +                       /* Only invoke CHECK on the error path to avoid spamming
> +                        * logs with mostly success messages.
> +                        */
> +                       CHECK(read <= 0, "snprintf_comm",
> +                             "Failed to write index %d to comm\n", i);

please, no CHECK() use in new tests, we have ASSERT_xxx() covering all
common cases

> +                       err = read;
> +                       user_ring_buffer__discard(ringbuf, entry);
> +                       goto done;
> +               }
> +
> +               user_ring_buffer__submit(ringbuf, entry);
> +       }
> +

[...]

> +static long
> +bad_access1(struct bpf_dynptr *dynptr, void *context)
> +{
> +       const struct sample *sample;
> +
> +       sample = bpf_dynptr_data(dynptr - 1, 0, sizeof(*sample));
> +       bpf_printk("Was able to pass bad pointer %lx\n", (__u64)dynptr - 1);
> +
> +       return 0;
> +}
> +
> +/* A callback that accesses a dynptr in a bpf_user_ringbuf_drain callback should
> + * not be able to read before the pointer.
> + */
> +SEC("?raw_tp/sys_nanosleep")

there is no sys_nanosleep raw tracepoint, use SEC("?raw_tp") to
specify type, that's enough

> +int user_ringbuf_callback_bad_access1(void *ctx)
> +{
> +       bpf_user_ringbuf_drain(&user_ringbuf, bad_access1, NULL, 0);
> +
> +       return 0;
> +}
> +

[...]

> diff --git a/tools/testing/selftests/bpf/test_user_ringbuf.h b/tools/testing/selftests/bpf/test_user_ringbuf.h
> new file mode 100644
> index 000000000000..1643b4d59ba7
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/test_user_ringbuf.h

nit: I'd probably put it under progs/test_user_ringbuf.h so it's
closer to BPF source code. As it is right now, it's neither near
user-space part of tests nor near BPF part.

> @@ -0,0 +1,35 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
> +
> +#ifndef _TEST_USER_RINGBUF_H
> +#define _TEST_USER_RINGBUF_H
> +
> +#define TEST_OP_64 4
> +#define TEST_OP_32 2
> +
> +enum test_msg_op {
> +       TEST_MSG_OP_INC64,
> +       TEST_MSG_OP_INC32,
> +       TEST_MSG_OP_MUL64,
> +       TEST_MSG_OP_MUL32,
> +
> +       // Must come last.
> +       TEST_MSG_OP_NUM_OPS,
> +};
> +
> +struct test_msg {
> +       enum test_msg_op msg_op;
> +       union {
> +               __s64 operand_64;
> +               __s32 operand_32;
> +       };
> +};
> +
> +struct sample {
> +       int pid;
> +       int seq;
> +       long value;
> +       char comm[16];
> +};
> +
> +#endif /* _TEST_USER_RINGBUF_H */
> --
> 2.37.1
>
