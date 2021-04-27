Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 585C036CDEE
	for <lists+bpf@lfdr.de>; Tue, 27 Apr 2021 23:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237016AbhD0VmF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Apr 2021 17:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235440AbhD0VmF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Apr 2021 17:42:05 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A58BC061574
        for <bpf@vger.kernel.org>; Tue, 27 Apr 2021 14:41:21 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id j84so1562082ybj.9
        for <bpf@vger.kernel.org>; Tue, 27 Apr 2021 14:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MqrNqQ3ay7d3cntiWlOvjpDzEYj6Op0ivHRulquC0X4=;
        b=Htduftvf8edC7OIIN9TsCdqKz+gauVYtDamdoAH1rWKHIW641FLG8NmD5ruQYRZoAq
         sVaL1Wx25iQs9ZS+f2aD5ZrToEp89nm1ANfc3dfjbEYCjmv70ANwfhRu79UWw8fBMUe/
         BTjdPdxAivJlS6Pkl6parI/G7gYh2Q4EXnso7ZJxsmpRqZqMXhQAG+WUI1nIfxmpmEnL
         HCYTxPs0S7sW1Y661hjMsntGsn1E8VJrIAGlC+WXA02InXgC57a9ZDEpihQuKmZTxS+u
         8UuJK7jFXjXNFN+LAkC9et4VrsyBggZglkASMlTrSyWoxGAa7QGokK1F2hE6eDn2Ck6g
         bmig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MqrNqQ3ay7d3cntiWlOvjpDzEYj6Op0ivHRulquC0X4=;
        b=FlB5hSUkjCAp/eM09Brz+R3cwc0Nw2j4KK9C/zgfku7XXmcXaGzBfElAvexKb3x+Wc
         rC2YGZJTvtvJBdYIoAQxVnwqjrB+GXhllfIcV6/P5E1Lj/WWRRXj7uYzISDB/iI6oYqr
         gjzjeEGDHVAkXIUzch0anbiD1FuFGe35k3pvHp7HBDa+4E3XBybZApeb+uDmLHznOk45
         rDWYTCjoPBotk6fuclfwXfyz4Pp+gb6hQirhlZ7nQGElNIsrLNsb2i2v+XfBkJqFW/XZ
         5nECdOdqUUipIBOWoIqkBVbgKAjQlFTUhQFL+g9qa55LdHm+4PLL6BY8kIdiq4osI6un
         X3hQ==
X-Gm-Message-State: AOAM532ZSjGniPMk8EDq7YYTai6VTtcDiwMGMDt70/4qz1z/cAM8tojA
        Kurw9pwVi6wioaPpYJruWmXaxc5ZZ2lVrqA99O65T/92fRo=
X-Google-Smtp-Source: ABdhPJw1hvs7/sgrFZL0gr3CZBxwl0NcHe1HIPWm1lXXu4jg2nPuVNV1uaoEUAhyw3nPlEkO/bZPgUJwAc/KrR1Pmx8=
X-Received: by 2002:a25:2441:: with SMTP id k62mr35012109ybk.347.1619559680533;
 Tue, 27 Apr 2021 14:41:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210427135550.807355-1-joamaki@gmail.com> <20210427135550.807355-2-joamaki@gmail.com>
In-Reply-To: <20210427135550.807355-2-joamaki@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 27 Apr 2021 14:41:09 -0700
Message-ID: <CAEf4BzZ8iQ=ewupN0COpV78k+fhGvPZ4NHcqckZcQcmV=A6QXw@mail.gmail.com>
Subject: Re: [PATCH bpf 2/2] selftests/bpf: Add test for bpf_skb_change_head
To:     Jussi Maki <joamaki@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 27, 2021 at 6:56 AM Jussi Maki <joamaki@gmail.com> wrote:
>
> Adds test to check that bpf_skb_change_head can be used
> in combination with bpf_redirect_peer to redirect a packet
> from L3 device to veth.
>
> Fixes: a426d97e970d ("bpf: Set mac_len in bpf_skb_change_head")
> Signed-off-by: Jussi Maki <joamaki@gmail.com>
> ---
>  tools/testing/selftests/bpf/.gitignore        |   1 +
>  tools/testing/selftests/bpf/Makefile          |   2 +-
>  .../selftests/bpf/progs/test_tc_peer.c        |  24 ++++
>  .../testing/selftests/bpf/test_tc_peer_user.c | 127 ++++++++++++++++++
>  .../testing/selftests/bpf/test_tc_redirect.sh |  95 ++++++++++---
>  5 files changed, 233 insertions(+), 16 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/test_tc_peer_user.c
>
> diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
> index 4866f6a21901..49f3f050be4d 100644
> --- a/tools/testing/selftests/bpf/.gitignore
> +++ b/tools/testing/selftests/bpf/.gitignore
> @@ -27,6 +27,7 @@ test_tcpnotify_user
>  test_libbpf
>  test_tcp_check_syncookie_user
>  test_sysctl
> +test_tc_peer_user

can we make it into a reasonable test inside test_progs? that way it
will be executed regularly

>  xdping
>  test_cpp
>  *.skel.h
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 283e5ad8385e..0e05fefe2333 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -84,7 +84,7 @@ TEST_PROGS_EXTENDED := with_addr.sh \
>  TEST_GEN_PROGS_EXTENDED = test_sock_addr test_skb_cgroup_id_user \
>         flow_dissector_load test_flow_dissector test_tcp_check_syncookie_user \
>         test_lirc_mode2_user xdping test_cpp runqslower bench bpf_testmod.ko \
> -       xdpxceiver
> +       xdpxceiver test_tc_peer_user
>
>  TEST_CUSTOM_PROGS = $(OUTPUT)/urandom_read
>
> diff --git a/tools/testing/selftests/bpf/progs/test_tc_peer.c b/tools/testing/selftests/bpf/progs/test_tc_peer.c
> index fc84a7685aa2..49f0eefd58e7 100644
> --- a/tools/testing/selftests/bpf/progs/test_tc_peer.c
> +++ b/tools/testing/selftests/bpf/progs/test_tc_peer.c
> @@ -5,8 +5,11 @@
>  #include <linux/bpf.h>
>  #include <linux/stddef.h>
>  #include <linux/pkt_cls.h>
> +#include <linux/if_ether.h>
> +#include <linux/ip.h>
>
>  #include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_endian.h>
>
>  enum {
>         dev_src,
> @@ -42,4 +45,25 @@ SEC("src_ingress") int tc_src(struct __sk_buff *skb)
>         return bpf_redirect_peer(get_dev_ifindex(dev_dst), 0);
>  }
>
> +SEC("src_ingress_l3") int tc_src_l3(struct __sk_buff *skb)

please keep SEC() on separate line

also, is this a BPF_PROG_TYPE_SCHED_CLS program? Can you usee libbpf's
"classifier/src_ingress_l3" naming convention?

> +{
> +       __u16 proto = skb->protocol;
> +
> +       if (bpf_skb_change_head(skb, ETH_HLEN, 0) != 0)
> +               return TC_ACT_SHOT;
> +
> +       __u8 src_mac[] = {0x00, 0x11, 0x22, 0x33, 0x44, 0x55};

we try to keep BPF code compliant with C89, so please move all the
variable declaration into a single block at the top of a function

> +       if (bpf_skb_store_bytes(skb, 0, &src_mac, ETH_ALEN, 0) != 0)
> +               return TC_ACT_SHOT;
> +
> +       __u8 dst_mac[] = {0x00, 0x22, 0x33, 0x44, 0x55, 0x66};
> +       if (bpf_skb_store_bytes(skb, ETH_ALEN, &dst_mac, ETH_ALEN, 0) != 0)
> +               return TC_ACT_SHOT;
> +
> +       if (bpf_skb_store_bytes(skb, ETH_ALEN + ETH_ALEN, &proto, sizeof(__u16), 0) != 0)
> +               return TC_ACT_SHOT;
> +
> +       return bpf_redirect_peer(get_dev_ifindex(dev_dst), 0);
> +}
> +

[...]

> +#define MAX(a, b) ((a) > (b) ? (a) : (b))
> +
> +enum {
> +       SRC_TO_TARGET = 0,
> +       TARGET_TO_SRC = 1,
> +};
> +
> +void setns_by_name(char *name) {


{ should be on a new line

please run scripts/checkpatch.pl on these files, it will point out
trivial issues like this

> +       int nsfd;
> +       char nspath[PATH_MAX];
> +
> +        snprintf(nspath, sizeof(nspath), "%s/%s", "/var/run/netns", name);
> +        nsfd = open(nspath, O_RDONLY | O_CLOEXEC);
> +        if (nsfd < 0) {
> +               fprintf(stderr, "failed to open net namespace %s: %s\n", name, strerror(errno));
> +               exit(1);
> +        }

here seems to be a mix of tabs and spaces

> +       setns(nsfd, CLONE_NEWNET);
> +       close(nsfd);
> +}
> +

[...]
