Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA5A35C4E1
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2019 23:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfGAVPl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Jul 2019 17:15:41 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38366 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbfGAVPk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Jul 2019 17:15:40 -0400
Received: by mail-wr1-f68.google.com with SMTP id p11so4137156wro.5
        for <bpf@vger.kernel.org>; Mon, 01 Jul 2019 14:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/a65+MdTTdSdBoyvBlSDBgVlXptz3TszC1xKq1rrZ4g=;
        b=KhxozAlXNmE4X2b0GWnExGYH9x81Fx/0Zb55BTWxbZL3WGhK/2dSinybewoJBJ4piD
         mN5cWT5HqYZNAnA3FnY+0bs74ypG42hcrFEq4QMDCpdQ8WdR2U1cPF5/W86lyl7Cpytx
         LRFkU5RuB1Dbl/hFyikfW8sVmi79jHzCbFldVzY5EMrpUocL6JkrFLAVFUlIbgLUHp8i
         sfp371cvGVuf/PpK584mxCynC6JHOnaYyZGF/NqjJ18Iv+h5GvLF5gG98K53Ery14XZ3
         Zv0ta4El2cb0zT7pG9tIeVI8V0x1KPsMuM/QXHdouEpobfdZWOIN5K9cnEpgyH1G2ABi
         I1Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/a65+MdTTdSdBoyvBlSDBgVlXptz3TszC1xKq1rrZ4g=;
        b=IsOeSVellL7WpvurKOqUr5F5RpsHWPmdSXT2GVMQ0SXcDuO46CoLQEhH0JinwZgY7c
         OQfMGE2TSw3/wYKX1MuPqJj4dueP1cOxUOnfJnvQV5HJPgYjlkS3UrSBpWrrm2JJHxEJ
         ZIRthA7d8xeRImCqx33LNYZDgmBBPN9GTSmgRjA5e++4XU9gB99j1LIDHMfp6+IU06Qi
         a3nfzI/0IHcdDGfBqeRQYHj/STgjY5NDISMkRWb8NAr4o/QWXOv1nKXff3Hm/nB91TG6
         IuzxTiZvLGiRXriqPOWOSYK1NPYcARPOvvImhxAGxa0ruNBk7kT/VLXqPu783/d68mYl
         NBTQ==
X-Gm-Message-State: APjAAAUgG0d/OwmvzBtXuXyaWmGwCQnHrSqd/6P5QdI5E16KZNGbnkPF
        GJLEhMIftu6tAGzeJuaEcGbY2tX3oOsiaLILLY9tLQ==
X-Google-Smtp-Source: APXvYqzXIwg8vxyYlSuq11Nd+k0/F2OO7kXfya+jfO9mqMFaOYUoO5ts/sLcf5iAG6y/UPW3omyL8tKROnI6VrlGfGA=
X-Received: by 2002:adf:9d81:: with SMTP id p1mr20902001wre.294.1562015738231;
 Mon, 01 Jul 2019 14:15:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190701204821.44230-1-sdf@google.com>
In-Reply-To: <20190701204821.44230-1-sdf@google.com>
From:   Yuchung Cheng <ycheng@google.com>
Date:   Mon, 1 Jul 2019 14:15:01 -0700
Message-ID: <CAK6E8=dw67BbfL6spdzp+XzaGgieutXHU7stsMAvq6Sew+FCrA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/8] bpf: TCP RTT sock_ops bpf callback
To:     Stanislav Fomichev <sdf@google.com>
Cc:     netdev <netdev@vger.kernel.org>, bpf@vger.kernel.org,
        David Miller <davem@davemloft.net>, ast@kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Eric Dumazet <edumazet@google.com>,
        Priyaranjan Jha <priyarjha@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jul 1, 2019 at 1:48 PM Stanislav Fomichev <sdf@google.com> wrote:
>
> Congestion control team would like to have a periodic callback to
> track some TCP statistics. Let's add a sock_ops callback that can be
> selectively enabled on a socket by socket basis and is executed for
> every RTT. BPF program frequency can be further controlled by calling
> bpf_ktime_get_ns and bailing out early.
>
> I run neper tcp_stream and tcp_rr tests with the sample program
> from the last patch and didn't observe any noticeable performance
> difference.
>
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Priyaranjan Jha <priyarjha@google.com>
> Cc: Yuchung Cheng <ycheng@google.com>
Acked-by: Yuchung Cheng <ycheng@google.com>

Thanks!

> Cc: Soheil Hassas Yeganeh <soheil@google.com>
>
> Stanislav Fomichev (8):
>   bpf: add BPF_CGROUP_SOCK_OPS callback that is executed on every RTT
>   bpf: split shared bpf_tcp_sock and bpf_sock_ops implementation
>   bpf: add dsack_dups/delivered{,_ce} to bpf_tcp_sock
>   bpf: add icsk_retransmits to bpf_tcp_sock
>   bpf/tools: sync bpf.h
>   selftests/bpf: test BPF_SOCK_OPS_RTT_CB
>   samples/bpf: add sample program that periodically dumps TCP stats
>   samples/bpf: fix tcp_bpf.readme detach command
>
>  include/net/tcp.h                           |   8 +
>  include/uapi/linux/bpf.h                    |  12 +-
>  net/core/filter.c                           | 207 +++++++++++-----
>  net/ipv4/tcp_input.c                        |   4 +
>  samples/bpf/Makefile                        |   1 +
>  samples/bpf/tcp_bpf.readme                  |   2 +-
>  samples/bpf/tcp_dumpstats_kern.c            |  65 +++++
>  tools/include/uapi/linux/bpf.h              |  12 +-
>  tools/testing/selftests/bpf/Makefile        |   3 +-
>  tools/testing/selftests/bpf/progs/tcp_rtt.c |  61 +++++
>  tools/testing/selftests/bpf/test_tcp_rtt.c  | 253 ++++++++++++++++++++
>  11 files changed, 570 insertions(+), 58 deletions(-)
>  create mode 100644 samples/bpf/tcp_dumpstats_kern.c
>  create mode 100644 tools/testing/selftests/bpf/progs/tcp_rtt.c
>  create mode 100644 tools/testing/selftests/bpf/test_tcp_rtt.c
>
> --
> 2.22.0.410.gd8fdbe21b5-goog
