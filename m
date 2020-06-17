Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC66C1FD93E
	for <lists+bpf@lfdr.de>; Thu, 18 Jun 2020 00:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbgFQWvk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Jun 2020 18:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgFQWvj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Jun 2020 18:51:39 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D25EC06174E
        for <bpf@vger.kernel.org>; Wed, 17 Jun 2020 15:51:38 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id w9so2971278qtv.3
        for <bpf@vger.kernel.org>; Wed, 17 Jun 2020 15:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ihyF1SuRluXxY31TEsmM5gFoi7vBLV5yvCMEkIleysg=;
        b=DBHQI3QQiA5+LFTbsRNEDgXEmxXveVNLFS8v24f0mUbMb7xdYnVtNcMpkpUlCJDwHN
         yR3bBbBytoBNkVz/l1LXJ4EYsfC6nT5cqX0ma32lrOedyOBcT/yZp4kZaJbVxk3gCrCh
         9LuugIEuAqaZvZpr8SftpOb+VohU3UM+TgcJFMpwbvqXQp5PWHAEvEzslqduFEI0t+Ul
         cbFXcinUQSAVpD90JVsDZ1kDH3fTSZpC7whIv9PvAQyhqaerqAzxvzAAMptTg6vxmlnV
         YQ56uan8qLIyzr3TIbVOsWHIEaQQiqXEnnlwQbRwsZYuaJWEtn6PSkDoewEqpzh/Wceo
         nsTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ihyF1SuRluXxY31TEsmM5gFoi7vBLV5yvCMEkIleysg=;
        b=qVhacSSEFWHW61zx3axjYORqfeymPguaF0LulE879JGuqmfN6h4b8qnSHPQZXFD2tQ
         CvWYVwuy7HAj7AE3XIIdCjaLaZI+BRL/nSzQ+oB71fgvZCijtn+vLNC8L5qgn2y0gH+c
         T3T5ipJyxeIWgoTNHDpFeut8CqDN37PGU1BazOM4xInTDdaYTP1V5tn7BlCtRFsPQJlK
         xMLUtcfikuMFWA/Ig/m1phooumudODjExRHpGqx7743miMp5Cw6HsQh5P2cwlOUHA+nu
         Lsvev00YmGVp7R4xVGvJVqS20G40ZMecklth1edy8tJ6K9vsFzz8JOZ+VdqmegQWUKsp
         Ktbg==
X-Gm-Message-State: AOAM533v9QYYcxYxFD/e4U2mW34JWKIcuLOQrlLT0qT5uJKN62+QwHUC
        EDtWJTcQ+VDeZ7IwawxuzhyC20VwiGaLIpFEpJRXhe9l
X-Google-Smtp-Source: ABdhPJyd9g/gPjzBzZv9kc3lVZ0u+f6y2mRhZSFqIy6+nl/4yEMN/LPoPNYUiz3/kLEnbDe3Z/LTWfYeab9EuiEcleo=
X-Received: by 2002:ac8:2dc3:: with SMTP id q3mr1480065qta.141.1592434297961;
 Wed, 17 Jun 2020 15:51:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200617211536.1854348-1-yhs@fb.com> <20200617211551.1856689-1-yhs@fb.com>
In-Reply-To: <20200617211551.1856689-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 17 Jun 2020 15:51:27 -0700
Message-ID: <CAEf4BzakFhQsLqpoJvw8LPurv27ntyA_x+XZpjxM8MzJhHprtA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 11/13] tools/bpf: selftests: implement sample
 tcp/tcp6 bpf_iter programs
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Martin KaFai Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jun 17, 2020 at 2:16 PM Yonghong Song <yhs@fb.com> wrote:
>
> In my VM, I got identical result compared to /proc/net/{tcp,tcp6}.
> For tcp6:
>   $ cat /proc/net/tcp6
>     sl  local_address                         remote_address                        st tx_queue rx_queue tr tm->when retrnsmt   uid  timeout inode
>      0: 00000000000000000000000000000000:0016 00000000000000000000000000000000:0000 0A 00000000:00000000 00:00000001 00000000     0        0 17955 1 000000003eb3102e 100 0 0 10 0
>
>   $ cat /sys/fs/bpf/p1
>     sl  local_address                         remote_address                        st tx_queue rx_queue tr tm->when retrnsmt   uid  timeout inode
>      0: 00000000000000000000000000000000:0016 00000000000000000000000000000000:0000 0A 00000000:00000000 00:00000000 00000000     0        0 17955 1 000000003eb3102e 100 0 0 10 0
>
> For tcp:
>   $ cat /proc/net/tcp
>   sl  local_address rem_address   st tx_queue rx_queue tr tm->when retrnsmt   uid  timeout inode
>    0: 00000000:0016 00000000:0000 0A 00000000:00000000 00:00000000 00000000     0        0 2666 1 000000007152e43f 100 0 0 10 0
>   $ cat /sys/fs/bpf/p2
>   sl  local_address                         remote_address                        st tx_queue rx_queue tr tm->when retrnsmt   uid  timeout inode
>    1: 00000000:0016 00000000:0000 0A 00000000:00000000 00:00000000 00000000     0        0 2666 1 000000007152e43f 100 0 0 10 0
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  tools/testing/selftests/bpf/progs/bpf_iter.h  |  15 +
>  .../selftests/bpf/progs/bpf_iter_tcp4.c       | 261 +++++++++++++++++
>  .../selftests/bpf/progs/bpf_iter_tcp6.c       | 277 ++++++++++++++++++
>  3 files changed, 553 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_tcp4.c
>  create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_tcp6.c
>
> diff --git a/tools/testing/selftests/bpf/progs/bpf_iter.h b/tools/testing/selftests/bpf/progs/bpf_iter.h
> index d8e6820e49e6..ab3ed904d391 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_iter.h
> +++ b/tools/testing/selftests/bpf/progs/bpf_iter.h
> @@ -7,6 +7,8 @@
>  #define bpf_iter__netlink bpf_iter__netlink___not_used
>  #define bpf_iter__task bpf_iter__task___not_used
>  #define bpf_iter__task_file bpf_iter__task_file___not_used
> +#define bpf_iter__tcp bpf_iter__tcp___not_used
> +#define tcp6_sock tcp6_sock___not_used
>  #include "vmlinux.h"
>  #undef bpf_iter_meta
>  #undef bpf_iter__bpf_map
> @@ -14,6 +16,8 @@
>  #undef bpf_iter__netlink
>  #undef bpf_iter__task
>  #undef bpf_iter__task_file
> +#undef bpf_iter__tcp
> +#undef tcp6_sock
>
>  struct bpf_iter_meta {
>         struct seq_file *seq;
> @@ -47,3 +51,14 @@ struct bpf_iter__bpf_map {
>         struct bpf_iter_meta *meta;
>         struct bpf_map *map;
>  } __attribute__((preserve_access_index));
> +
> +struct bpf_iter__tcp {
> +       struct bpf_iter_meta *meta;
> +       struct sock_common *sk_common;
> +       uid_t uid;
> +} __attribute__((preserve_access_index));
> +
> +struct tcp6_sock {
> +       struct tcp_sock tcp;
> +       struct ipv6_pinfo inet6;
> +} __attribute__((preserve_access_index));

Why redefining struct tcp6_sock? It seems it's been defined forever,
so should just come from vmlinux.h

> diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_tcp4.c b/tools/testing/selftests/bpf/progs/bpf_iter_tcp4.c
> new file mode 100644
> index 000000000000..37008b914334
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/bpf_iter_tcp4.c
> @@ -0,0 +1,261 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2020 Facebook */
> +#include "bpf_iter.h"
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +#include <bpf/bpf_endian.h>
> +
> +char _license[] SEC("license") = "GPL";
> +
> +#define sk_state       __sk_common.skc_state
> +#define sk_refcnt      __sk_common.skc_refcnt
> +
> +#define inet_daddr     sk.__sk_common.skc_daddr
> +#define inet_rcv_saddr sk.__sk_common.skc_rcv_saddr
> +#define inet_dport     sk.__sk_common.skc_dport
> +
> +#define tw_daddr       __tw_common.skc_daddr
> +#define tw_rcv_saddr   __tw_common.skc_rcv_saddr
> +#define tw_dport       __tw_common.skc_dport
> +#define tw_refcnt      __tw_common.skc_refcnt
> +
> +#define ir_loc_addr    req.__req_common.skc_rcv_saddr
> +#define ir_rmt_addr    req.__req_common.skc_daddr
> +#define ir_rmt_port    req.__req_common.skc_dport
> +#define ir_num         req.__req_common.skc_num
> +
> +#define ICSK_TIME_RETRANS      1
> +#define ICSK_TIME_PROBE0       3
> +#define ICSK_TIME_LOSS_PROBE   5
> +#define ICSK_TIME_REO_TIMEOUT  6
> +
> +#define TCP_INFINITE_SSTHRESH  0x7fffffff
> +#define TCP_PINGPONG_THRESH    3
> +
> +#define AF_INET                        2

Seems like this is needed to do anything useful with sockets, right?
How about adding a new helper header (e.g., bpf_sock.h or bpf_net.h?)
so that everyone can benefit?


> +
> +static int hlist_unhashed_lockless(const struct hlist_node *h)
> +{
> +        return !(h->pprev);
> +}
> +
> +static int timer_pending(const struct timer_list * timer)
> +{
> +       return !hlist_unhashed_lockless(&timer->entry);
> +}
> +

[...]
