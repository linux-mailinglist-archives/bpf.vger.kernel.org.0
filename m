Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 039B4699FE1
	for <lists+bpf@lfdr.de>; Thu, 16 Feb 2023 23:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjBPWvN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Feb 2023 17:51:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBPWvM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Feb 2023 17:51:12 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6E535262
        for <bpf@vger.kernel.org>; Thu, 16 Feb 2023 14:51:11 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id fi26so8707682edb.7
        for <bpf@vger.kernel.org>; Thu, 16 Feb 2023 14:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MlaHJsZtranfiYL9ZMEmx9Kqzo8NiwMYRCY57vU4ANk=;
        b=j5f5FvCxoRhj5nTzWGmyA+tQNxSqvZ3SH5lkjScOVSPyksCfYKKdaKWWCVWMp7/YlH
         wpR6pZc5Z6zYr1jxRFmfXQY2kEAS+Hbjg7d70/c/2AcLl9ayf1o7h7i77f+nhQKtIWKc
         bZT6qJC/Y2krPk9XOfGrngSWvcKYGigXmIuGpYOkEmxDGPNemhwBDcK4ZJJ8NtlExU2u
         9Jf9WQU8oNc8bujbd++hUm8+oBlWRsQC8VuvSt7C9U9/3u4+suFxDPdx91DRHlcSFqbs
         r58rogYP2l5ZF9OLeCqzllw99AJALqGuYLww5Hpr5k8QHFcNTmzy869r8yBTF9rs2vQN
         elCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MlaHJsZtranfiYL9ZMEmx9Kqzo8NiwMYRCY57vU4ANk=;
        b=6jAccOBdAqnynHWZnuKR8Ceunl/jeMN1iIytovH+iWMtmAD5M2rx1Ix9Q7+tSCG+mP
         Ukfx5edsKKnD++OHF5iyHVOa7yRpkwYQOMIKWf6eMyUCtYqAg7kGYSvcN0qg+hda+H0I
         6AzwgbZ+UXSYL7IyR1Z+Kz5dBtzAn7+ga7eLFVuiWcpivfls4hwzOh9h2zX/WzUoAaPs
         DmQ9T3u+hNv4A9efhSEyhFIyw0fCIEPgYn94PPIzIpOYmf4oxdxPGRmpHtbHKPwg5/C0
         t3HCqbMDTvRpTQfGXUkhkzdw9mmhzWJqJfVTv8I4mkTkrxkGU9DEmsxeDtKIvJGQ0Bfc
         UWAw==
X-Gm-Message-State: AO0yUKVry6TdTC7ufIlY3EZtl4lpgrKxF2sDhcG+JBM9xKLiUyYi3PFq
        LiMewTyaXsz2204LaZEqrEVU/oyqKkad7T7RHBY=
X-Google-Smtp-Source: AK7set9cnnLu3/KRyrod8yoqGarIlOpTVHbZyJgDsxWnRHsyptuPu31jMrwHwtPxRXfv4wcqmsXreq2L/0CHfCR5TEA=
X-Received: by 2002:a17:906:497:b0:8b1:28f6:8ab3 with SMTP id
 f23-20020a170906049700b008b128f68ab3mr3593453eja.15.1676587870359; Thu, 16
 Feb 2023 14:51:10 -0800 (PST)
MIME-Version: 1.0
References: <20230214221718.503964-1-kuifeng@meta.com> <20230214221718.503964-8-kuifeng@meta.com>
In-Reply-To: <20230214221718.503964-8-kuifeng@meta.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 16 Feb 2023 14:50:58 -0800
Message-ID: <CAEf4BzbNtdRv089KMi+NS_VQq=ijbVAMt5nh8wWw5s2=sv6K5w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 7/7] selftests/bpf: Test switching TCP Congestion
 Control algorithms.
To:     Kui-Feng Lee <kuifeng@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
        song@kernel.org, kernel-team@meta.com, andrii@kernel.org
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

On Tue, Feb 14, 2023 at 2:17 PM Kui-Feng Lee <kuifeng@meta.com> wrote:
>
> Create a pair of sockets that utilize the congestion control algorithm
> under a particular name. Then switch up this congestion control
> algorithm to another implementation and check whether newly created
> connections using the same cc name now run the new implementation.
>
> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
> ---
>  .../selftests/bpf/prog_tests/bpf_tcp_ca.c     | 48 ++++++++++++
>  .../selftests/bpf/progs/tcp_ca_update.c       | 75 +++++++++++++++++++
>  2 files changed, 123 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/tcp_ca_update.c
>

[...]

> diff --git a/tools/testing/selftests/bpf/progs/tcp_ca_update.c b/tools/testing/selftests/bpf/progs/tcp_ca_update.c
> new file mode 100644
> index 000000000000..cf51fe54ac01
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/tcp_ca_update.c
> @@ -0,0 +1,75 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include "vmlinux.h"
> +
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +char _license[] SEC("license") = "GPL";
> +
> +int ca1_cnt = 0;
> +int ca2_cnt = 0;
> +
> +#define USEC_PER_SEC 1000000UL
> +
> +#define min(a, b) ((a) < (b) ? (a) : (b))
> +
> +static inline struct tcp_sock *tcp_sk(const struct sock *sk)
> +{
> +       return (struct tcp_sock *)sk;
> +}
> +
> +SEC("struct_ops/ca_update_init")
> +void BPF_PROG(ca_update_init, struct sock *sk)
> +{
> +#ifdef ENABLE_ATOMICS_TESTS

it's been 2 years since atomics were added to Clang, I think it's fine
to just assume atomic operations are supported and not do the
ENABLE_ATOMICS_TEST (and I'd clean up ENABLE_ATOMICS_TESTS now as
well)

> +       __sync_bool_compare_and_swap(&sk->sk_pacing_status, SK_PACING_NONE,
> +                                    SK_PACING_NEEDED);
> +#else
> +       sk->sk_pacing_status = SK_PACING_NEEDED;
> +#endif
> +}
> +
> +SEC("struct_ops/ca_update_1_cong_control")
> +void BPF_PROG(ca_update_1_cong_control, struct sock *sk,
> +             const struct rate_sample *rs)
> +{
> +       ca1_cnt++;
> +}
> +
> +SEC("struct_ops/ca_update_2_cong_control")
> +void BPF_PROG(ca_update_2_cong_control, struct sock *sk,
> +             const struct rate_sample *rs)
> +{
> +       ca2_cnt++;
> +}
> +
> +SEC("struct_ops/ca_update_ssthresh")
> +__u32 BPF_PROG(ca_update_ssthresh, struct sock *sk)
> +{
> +       return tcp_sk(sk)->snd_ssthresh;
> +}
> +
> +SEC("struct_ops/ca_update_undo_cwnd")
> +__u32 BPF_PROG(ca_update_undo_cwnd, struct sock *sk)
> +{
> +       return tcp_sk(sk)->snd_cwnd;
> +}
> +
> +SEC(".struct_ops")
> +struct tcp_congestion_ops ca_update_1 = {
> +       .init = (void *)ca_update_init,
> +       .cong_control = (void *)ca_update_1_cong_control,
> +       .ssthresh = (void *)ca_update_ssthresh,
> +       .undo_cwnd = (void *)ca_update_undo_cwnd,
> +       .name = "tcp_ca_update",
> +};
> +
> +SEC(".struct_ops")
> +struct tcp_congestion_ops ca_update_2 = {
> +       .init = (void *)ca_update_init,
> +       .cong_control = (void *)ca_update_2_cong_control,
> +       .ssthresh = (void *)ca_update_ssthresh,
> +       .undo_cwnd = (void *)ca_update_undo_cwnd,
> +       .name = "tcp_ca_update",
> +};
> --
> 2.30.2
>
