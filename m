Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B032B2348E6
	for <lists+bpf@lfdr.de>; Fri, 31 Jul 2020 18:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728771AbgGaQHO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 31 Jul 2020 12:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727819AbgGaQHN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 31 Jul 2020 12:07:13 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968BCC061574
        for <bpf@vger.kernel.org>; Fri, 31 Jul 2020 09:07:13 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id w12so18543278iom.4
        for <bpf@vger.kernel.org>; Fri, 31 Jul 2020 09:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=l9VxvupihRplFurEv7SSgUkaEV82Y8Z3ZplQgxB6qdw=;
        b=NtpHwonAWWgKcZMaKnV96MQMLHeXjBqT+Jeuy3ZUniQkyF4d9CSbs/4a8h2eXmA6fr
         tPFLBp2sXoP5Zh+kusYIiFMQFqW9MGv6ZWx7/7ZSR5oXC8b7/fHw/2cl+0cNyP4A1p+E
         vloYq2zYhMPlT4kkUQQnf1ZKxN1iFW7tbUpFM/lmME76QEopcRMWOzwPkflnNdWm7l/w
         lgHYPQKjedYKv41GswuX4HGhgH2GiNThBDZziWzv63q/Z2PJkGqZ2kEdNBuwD8Q/BTUi
         mNf6atXu8gmvL3yThBliKQIvuY/Uml9TJUKRNMkRNKGfNvY5EosbIycWHJZEPbJNGCP/
         p3rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=l9VxvupihRplFurEv7SSgUkaEV82Y8Z3ZplQgxB6qdw=;
        b=s5NZI+2q3hYmyV+6wWsl61ZiZkjFXEiGtg0MVjFR354nIPmGgzf0AJXCgJup7oJZl/
         xWF9Q1IUpyr4fPu+fBbjYjujUOZygCLX/H5UUsb8wUcc3MtQwKHV2EKyxYTnx5dxeh3y
         3oQnFu2V8c8jmc96VVn6b/KnJIdXRK3yhSB9+jTUnJ65UYYK7Xayac6sFUS2+H2PyACR
         my79YeuwcA8ZoXNQEhA/0J1VjU7F85VjJoBgjVdRBNOm3S3gZScXnQHgp5+E55vr1XQA
         ZINBxUmz4upBET69dxrd/GLU0VCX40NVoPuqkqEPx209JCF1Ey3prXnARw8Y5sPmbymF
         Qc1Q==
X-Gm-Message-State: AOAM532us1wqLeqOoBNhqDMZAJXUxmAaQbb4Yl6GiwcXXfOL589fD07y
        u6llZxBB5+4YZjzXyZ8rK3McbhWMdC+g433dDjWiCw==
X-Google-Smtp-Source: ABdhPJwOc2ry9xNMrjeCi9BehehSb0W6YDhdEDIevE8KC3cDzkk+AZuAX1CLQykEdpstVTATp3iBfGb5YJ0iqRyR7QQ=
X-Received: by 2002:a05:6638:2493:: with SMTP id x19mr5941212jat.53.1596211632765;
 Fri, 31 Jul 2020 09:07:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200730205657.3351905-1-kafai@fb.com> <20200730205736.3354304-1-kafai@fb.com>
In-Reply-To: <20200730205736.3354304-1-kafai@fb.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 31 Jul 2020 09:06:57 -0700
Message-ID: <CANn89i+5RKTcBFqueEs48HUadC+dO54eR7Yp5pBJ6zgbosTDCQ@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 6/9] bpf: tcp: Allow bpf prog to write and
 parse TCP header option
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        kernel-team <kernel-team@fb.com>,
        Lawrence Brakmo <brakmo@fb.com>,
        Neal Cardwell <ncardwell@google.com>,
        netdev <netdev@vger.kernel.org>,
        Yuchung Cheng <ycheng@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jul 30, 2020 at 1:57 PM Martin KaFai Lau <kafai@fb.com> wrote:
>
> The earlier effort in BPF-TCP-CC allows the TCP Congestion Control
> algorithm to be written in BPF.  It opens up opportunities to allow
> a faster turnaround time in testing/releasing new congestion control
> ideas to production environment.
>
> The same flexibility can be extended to writing TCP header option.
> It is not uncommon that people want to test new TCP header option
> to improve the TCP performance.  Another use case is for data-center
> that has a more controlled environment and has more flexibility in
> putting header options for internal only use.
>
> For example, we want to test the idea in putting maximum delay
> ACK in TCP header option which is similar to a draft RFC proposal [1].
>
> This patch introduces the necessary BPF API and use them in the
> TCP stack to allow BPF_PROG_TYPE_SOCK_OPS program to parse
> and write TCP header options.  It currently supports most of
> the TCP packet except RST.
>
> Supported TCP header option:
> =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80
> This patch allows the bpf-prog to write any option kind.
> Different bpf-progs can write its own option by calling the new helper
> bpf_store_hdr_opt().  The helper will ensure there is no duplicated
> option in the header.
>
> By allowing bpf-prog to write any option kind, this gives a lot of
> flexibility to the bpf-prog.  Different bpf-prog can write its
> own option kind.  It could also allow the bpf-prog to support a
> recently standardized option on an older kernel.
>
> Sockops Callback Flags:
> =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80
> The header parsing and writing callback can be turned on
> by enabling a few newly added callback flags:
>
> BPF_SOCK_OPS_PARSE_UNKNOWN_HDR_OPT_CB_FLAG:
>         Call bpf when kernel has received a header option that
>         the kernel cannot handle.  It is useful when the peer doesn't
>         send bpf-options very often.
>
>         The bpf-prog can inspect the received header by sock_ops->skb_dat=
a
>         which covers the whole header (including the fixed fields like
>         ports, flags...etc) or
>         use the new bpf_load_hdr_opt() to search for a particular TCP
>         header option.
>
>
>
>

> [1]: draft-wang-tcpm-low-latency-opt-00
>      https://tools.ietf.org/html/draft-wang-tcpm-low-latency-opt-00
>
> Signed-off-by: Martin KaFai Lau <kafai@fb.com>
> ---
>  include/linux/bpf-cgroup.h     |  25 +++
>  include/linux/filter.h         |   4 +
>  include/net/tcp.h              |  53 ++++-
>  include/uapi/linux/bpf.h       | 231 ++++++++++++++++++++-
>  net/core/filter.c              | 365 +++++++++++++++++++++++++++++++++
>  net/ipv4/tcp_fastopen.c        |   2 +-
>  net/ipv4/tcp_input.c           |  86 +++++++-
>  net/ipv4/tcp_ipv4.c            |   3 +-
>  net/ipv4/tcp_minisocks.c       |   1 +
>  net/ipv4/tcp_output.c          | 194 ++++++++++++++++--
>  net/ipv6/tcp_ipv6.c            |   3 +-
>  tools/include/uapi/linux/bpf.h | 231 ++++++++++++++++++++-
>  12 files changed, 1171 insertions(+), 27 deletions(-)

This is a truly gigantic patch.

Could you split it in maybe two parts ?

This way I could focus on the TCP changes, and let eBPF experts focus
on BPF changes.
