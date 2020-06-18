Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D49F31FEB6D
	for <lists+bpf@lfdr.de>; Thu, 18 Jun 2020 08:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbgFRGYt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Jun 2020 02:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbgFRGYs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Jun 2020 02:24:48 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91FE3C06174E
        for <bpf@vger.kernel.org>; Wed, 17 Jun 2020 23:24:48 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id 205so4568525qkg.3
        for <bpf@vger.kernel.org>; Wed, 17 Jun 2020 23:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bF5q6vXgSV3/N15ErA3BBT/5nF889OzyWU5E+sP5bnk=;
        b=bgkI0Bg22U/ls7OCAYLepTJSXdDISDUCwhJ2+tgtqp/Qz3LrKMvjLNXlgACoXkj6W/
         1wy4oURPFg4bN0/dxDTHPYHtO7dZpkCPSa+4rvM9n4M5Yg863GpWLTpvX460WxVKwUkn
         fRyWjpJ0dWCRzVaRSEB5SNwLUHx+YFDV8Jt5en2pQzo7+s9wNkvAuHZX4Pjv8jCvuEzw
         NoTf9o8Radd0KOak/zGfPtsIdrc4IQYlYU1mVclF7V+m1tA6/MGKQeAa6ZLalDbHZBz+
         QcFICnnUZR03I8LtWparnGJnRj5v8C3q8zsgZEodUoAE1taBFDZjTuAbGfHvWLrB3QHm
         M+bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bF5q6vXgSV3/N15ErA3BBT/5nF889OzyWU5E+sP5bnk=;
        b=OQwz8XpCEeCfgIptzofXsG4JbnQskTXav7feipUP3AL+QaiWNcXfDF3+xIZxuIFfiU
         izY6boCUReFN/RwjRHUNFUQig5pUbtsKueuSjSnMg3MY2rJCPpIMpfwUhESSo3siHBG2
         8/uFz4ILE3cDAjEmUU4jsejm5LRT81FePiN9oQ1XuLC2rF2E9tLUvaKm1FyO93mYTtVf
         s+gGZ5AO7YJ9WIdGB4OXxBhHc+uY4OxiOxifkaPBjlZKchKXd1EQFqut/jFx81nOM0sq
         GvTvHc8iA7LUtTl/mww+nuCBSLMqS7d7jj/iOvxNpg5jqVbWuF6TmSQO0Gw3IQZrTlxt
         kjeQ==
X-Gm-Message-State: AOAM531psCMY5EEPoyPSJDLVO3Tg7L1k2ORCjuPzU0YmpJI3oc29F8wP
        kdllo226Hprw4l0vWe3BlZdo6x+xxzhMTeyVtKbCwR7EqLE=
X-Google-Smtp-Source: ABdhPJw5EhP44oSXfcstHtaja4cLOkK7mPhNC7KVqZxEvM4dioe0RQXn6s4vmaLIcnD7Z1L2P6+bKTOlkChfBVIcRds=
X-Received: by 2002:a37:d0b:: with SMTP id 11mr2406340qkn.449.1592461487571;
 Wed, 17 Jun 2020 23:24:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200617211536.1854348-1-yhs@fb.com> <20200617211551.1856689-1-yhs@fb.com>
 <CAEf4BzakFhQsLqpoJvw8LPurv27ntyA_x+XZpjxM8MzJhHprtA@mail.gmail.com> <ab5a131f-93c7-802b-49be-dd72085d8e56@fb.com>
In-Reply-To: <ab5a131f-93c7-802b-49be-dd72085d8e56@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 17 Jun 2020 23:24:36 -0700
Message-ID: <CAEf4BzaXBdzpUvSCcDB2LXES4BUv+wF+ks3U5n1CC-tPr1tbUw@mail.gmail.com>
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

On Wed, Jun 17, 2020 at 5:21 PM Yonghong Song <yhs@fb.com> wrote:
>
>
> On 6/17/20 3:51 PM, Andrii Nakryiko wrote:
>
> On Wed, Jun 17, 2020 at 2:16 PM Yonghong Song <yhs@fb.com> wrote:
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
>
> Why redefining struct tcp6_sock? It seems it's been defined forever,
> so should just come from vmlinux.h
>
> Unfortunately, it is not in vmlinux.h. In the kernel code, tcp6_sock
> is referenced with sizeof() operator and ipv6_pinfo is referenced
> through through (struct ipv6_pinfo *)(ptr + sizeof(struct tcp6_sock) - sizeof(struct ipv6_pinfo)).
> I have a minor comment in patch #5 for this.

Ah, I see, so it wasn't there, but the latest kernel will be there. Ok.

BTW, there is this BTF_TYPE_EMIT() macro (used by struct_ops), it
would probably be good to use it instead of ad-hoc type casting in
patch #5, to preserve type info. It's more explicitly stating the
intent.


>
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
>
> Seems like this is needed to do anything useful with sockets, right?
> How about adding a new helper header (e.g., bpf_sock.h or bpf_net.h?)
> so that everyone can benefit?
>
> I have been thinking of a bpf_iter_net.h since I have several
> net related bpf programs and they share some common macros and
> static inline functions. But I am short of action in this revision.
>
> Yes, I agree it is a good idea to have a helper under
> tools/lib/bpf for common use. Maybe I can call it
> bpf_tracing_net.h to imply the header is for tracing programs
> which ties to kernel internals and its contents may, although unlikely,
> change.

bpf_iter_net.h is too iter-specific, while this is useful more
broadly. bpf_tracing_net.h is fine, I guess, but appending "tracing"
to everything that is intended for use on the BPF side sounds a bit
like an overkill... But don't know, no strong feelings there.

>
>
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
>
> [...]
