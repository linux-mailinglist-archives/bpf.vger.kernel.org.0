Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67CBC425E7E
	for <lists+bpf@lfdr.de>; Thu,  7 Oct 2021 23:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbhJGVUN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Oct 2021 17:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233283AbhJGVUN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Oct 2021 17:20:13 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4DCC061570
        for <bpf@vger.kernel.org>; Thu,  7 Oct 2021 14:18:19 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id s64so16401148yba.11
        for <bpf@vger.kernel.org>; Thu, 07 Oct 2021 14:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q4a8CSzuHkUJ1B7p65R3RlpbmxxK/u6P8Q9D7fXoudg=;
        b=W0ux29RIRCLKxE0wcCKDAsql2PGBi2sA4RNKr5e7pYZ2t9FH5cUJnksRbl7vZROGl/
         ROpG888UqvKE3jVBpZcaO2GEqJcw218E+hRz3rEp8RTMkeSjkeXA3IbxhLlIqZHTPPkU
         7g8XM2PoeAWGbdtSOkcCzyQtSgx/owukEyLKTtSTIEj2CIYV76xwAzNNrHwiMn+qUqzD
         FTCxGbS0kr/A/Ed3X8vxtUqQF8I+dP3wjm1pEEJ/y8deg/+3BP7w6eIHaLeaPbToBcHJ
         QjXxi2H5EeyiIS8kq2gYqAjuwxKKBzwdaoj2GaXSBnurWqtlfmRfvC8TdtIPAToxQ2Hu
         sSwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q4a8CSzuHkUJ1B7p65R3RlpbmxxK/u6P8Q9D7fXoudg=;
        b=4y467m/rC7xP3CKPAa86scZLt5yiHJe4cFMS5828t/X5NU7iwxeThSkhBDOhEOW1il
         ijoqPeF4ddx+Ct7gMfV7GRFsypOXYexPINUfAAmyQS/7rnn9h1Sz4ewdjtUDtxAcIGoD
         G/EJO7KQfPG5eNOUL8zR4V6E3G7RcsjTM8Jh5F6yEuC4dEZ/PUSELp/GvRMT3tseXCsF
         7O8M2KVarn0g15pAgKGspkPd55okH8UnX5Osn25CJq+1k9UfOl9aQKkU2uDBesJWlwFn
         jkQBhvhAzMkRiRGng7Ai912L1HLrCC4nWvKT/9pVN1Y9hN+Ols0AMrdJz0XIw3JabqOr
         ST9g==
X-Gm-Message-State: AOAM531eUqwf/sZ836NOheAcxEFPDPkzzbD6kJN4LowI5eFrdnNdgBoN
        DO6YCXUSItijyXAKwpUaMDy2xU3UgtAz3QO73HGpafvqp9YR1Q==
X-Google-Smtp-Source: ABdhPJwPNqatdfFuS9gWbVZFCJvKs7i53SvGmYudkJ6zP3cac95sbWpXd23PunL/YGQOUgjjeoUbjLgAM6XWGcPmfa4=
X-Received: by 2002:a25:7c42:: with SMTP id x63mr7744197ybc.225.1633641498141;
 Thu, 07 Oct 2021 14:18:18 -0700 (PDT)
MIME-Version: 1.0
References: <20211007202319.1153540-1-davemarchevsky@fb.com> <fc18832d-5822-2c82-45b4-a2efca47b605@iogearbox.net>
In-Reply-To: <fc18832d-5822-2c82-45b4-a2efca47b605@iogearbox.net>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 7 Oct 2021 14:18:03 -0700
Message-ID: <CAEf4BzbZ0c6703JuorX7HuhNEOB5emZ0DSgHcS8VKAjtubdUmg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: remove SEC("version") from test progs
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Dave Marchevsky <davemarchevsky@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 7, 2021 at 2:00 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 10/7/21 10:23 PM, Dave Marchevsky wrote:
> > Since commit 6c4fc209fcf9d ("bpf: remove useless version check for prog
> > load") these "version" sections, which result in bpf_attr.kern_version
> > being set, have been unnecessary.
> >
> > Remove them so that it's obvious to folks using selftests as a guide that
> > "modern" BPF progs don't need this section.
> >
> > Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> > ---
> >   tools/testing/selftests/bpf/progs/cgroup_skb_sk_lookup_kern.c  | 1 -
> >   tools/testing/selftests/bpf/progs/connect4_prog.c              | 1 -
> >   tools/testing/selftests/bpf/progs/connect6_prog.c              | 1 -
> >   tools/testing/selftests/bpf/progs/connect_force_port4.c        | 1 -
> >   tools/testing/selftests/bpf/progs/connect_force_port6.c        | 1 -
> >   tools/testing/selftests/bpf/progs/dev_cgroup.c                 | 1 -
> >   tools/testing/selftests/bpf/progs/get_cgroup_id_kern.c         | 1 -
> >   tools/testing/selftests/bpf/progs/map_ptr_kern.c               | 1 -
> >   tools/testing/selftests/bpf/progs/netcnt_prog.c                | 1 -
> >   tools/testing/selftests/bpf/progs/sendmsg4_prog.c              | 1 -
> >   tools/testing/selftests/bpf/progs/sendmsg6_prog.c              | 1 -
> >   tools/testing/selftests/bpf/progs/sockmap_parse_prog.c         | 1 -
> >   tools/testing/selftests/bpf/progs/sockmap_tcp_msg_prog.c       | 1 -
> >   tools/testing/selftests/bpf/progs/sockmap_verdict_prog.c       | 1 -
> >   tools/testing/selftests/bpf/progs/sockopt_inherit.c            | 1 -
> >   tools/testing/selftests/bpf/progs/tcp_rtt.c                    | 1 -
> >   tools/testing/selftests/bpf/progs/test_btf_haskv.c             | 1 -
> >   tools/testing/selftests/bpf/progs/test_btf_newkv.c             | 1 -
> >   tools/testing/selftests/bpf/progs/test_btf_nokv.c              | 1 -
> >   tools/testing/selftests/bpf/progs/test_l4lb.c                  | 1 -
> >   tools/testing/selftests/bpf/progs/test_map_in_map.c            | 1 -
> >   tools/testing/selftests/bpf/progs/test_pinning.c               | 1 -
> >   tools/testing/selftests/bpf/progs/test_pinning_invalid.c       | 1 -
> >   tools/testing/selftests/bpf/progs/test_pkt_access.c            | 1 -
> >   tools/testing/selftests/bpf/progs/test_queue_stack_map.h       | 1 -
> >   tools/testing/selftests/bpf/progs/test_select_reuseport_kern.c | 1 -
> >   tools/testing/selftests/bpf/progs/test_sk_lookup.c             | 1 -
> >   tools/testing/selftests/bpf/progs/test_skb_cgroup_id_kern.c    | 1 -
> >   tools/testing/selftests/bpf/progs/test_skb_ctx.c               | 1 -
> >   tools/testing/selftests/bpf/progs/test_sockmap_kern.h          | 1 -
> >   tools/testing/selftests/bpf/progs/test_sockmap_listen.c        | 1 -
> >   tools/testing/selftests/bpf/progs/test_stacktrace_build_id.c   | 1 -
> >   tools/testing/selftests/bpf/progs/test_static_linked1.c        | 1 -
> >   tools/testing/selftests/bpf/progs/test_static_linked2.c        | 1 -
> >   tools/testing/selftests/bpf/progs/test_tcp_estats.c            | 1 -
> >   tools/testing/selftests/bpf/progs/test_tcpbpf_kern.c           | 1 -
> >   tools/testing/selftests/bpf/progs/test_tcpnotify_kern.c        | 1 -
> >   tools/testing/selftests/bpf/progs/test_tracepoint.c            | 1 -
> >   tools/testing/selftests/bpf/progs/test_tunnel_kern.c           | 1 -
> >   tools/testing/selftests/bpf/progs/test_xdp.c                   | 1 -
> >   tools/testing/selftests/bpf/progs/test_xdp_loop.c              | 1 -
> >   tools/testing/selftests/bpf/progs/test_xdp_redirect.c          | 1 -
> >   42 files changed, 42 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/progs/cgroup_skb_sk_lookup_kern.c b/tools/testing/selftests/bpf/progs/cgroup_skb_sk_lookup_kern.c
> > index 3f757e30d7a0..88638315c582 100644
> > --- a/tools/testing/selftests/bpf/progs/cgroup_skb_sk_lookup_kern.c
> > +++ b/tools/testing/selftests/bpf/progs/cgroup_skb_sk_lookup_kern.c
> > @@ -14,7 +14,6 @@
> >   #include <sys/types.h>
> >   #include <sys/socket.h>
> >
> > -int _version SEC("version") = 1;
> >   char _license[] SEC("license") = "GPL";
> >
> >   __u16 g_serv_port = 0;
> > diff --git a/tools/testing/selftests/bpf/progs/connect4_prog.c b/tools/testing/selftests/bpf/progs/connect4_prog.c
> > index a943d394fd3a..cf432a527d49 100644
> > --- a/tools/testing/selftests/bpf/progs/connect4_prog.c
> > +++ b/tools/testing/selftests/bpf/progs/connect4_prog.c
> > @@ -31,7 +31,6 @@
> >   #define IFNAMSIZ 16
> >   #endif
> >
> > -int _version SEC("version") = 1;
> >
>
> Overall looks good, small nit: please don't leave a double newline after the
> removal (here and in other places).
>

Also please don't remove version from test_static_linked tests. They
are there explicitly to test that static linker handles it properly.

> >   __attribute__ ((noinline))
> >   int do_bind(struct bpf_sock_addr *ctx)
