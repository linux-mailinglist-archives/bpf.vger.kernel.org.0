Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFC60372370
	for <lists+bpf@lfdr.de>; Tue,  4 May 2021 01:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbhECXJf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 May 2021 19:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbhECXJf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 3 May 2021 19:09:35 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F07AC061574
        for <bpf@vger.kernel.org>; Mon,  3 May 2021 16:08:40 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id i4so9775987ybe.2
        for <bpf@vger.kernel.org>; Mon, 03 May 2021 16:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cs5BLcfK75PvZhe2Iy8IQFTDumdUx75paHJqzlSwp5k=;
        b=rlN15Gf3Rc1NmMBkHThxVcNkoMSYh+vyiCJ6Nff4UOKczAz7KSIrv7zqnLzHHuX5rb
         z1mSd52jJ0IGcDdofkk/+eQ+cSFIfS/NIVzeuE2R4CYRT8x8qgvhCxM+99HMSENq+S+J
         dQdoVv4Jjjetpwck2A4cOPUuj6ah9EbmjEIl13oTuI6HUmCjakdwEeJI1r6SvRG/yawx
         Ac96MtVCXRtqi1eKQ5z96ArzBdUEpxOUuKD/KtLq7zIIKOhIatymR0ltN3pTUOjSHkFp
         qeI5omHPtADerDQka5pxA+OJAxxq+4mx6SI31fKZWZNkw7MU+9b0Mx0OZbWgLFqR7mCN
         N9Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cs5BLcfK75PvZhe2Iy8IQFTDumdUx75paHJqzlSwp5k=;
        b=H56fzmPTXG3Q9h/Qq0mDV/k44uT3b7wxIzKn1AgZraZUoeomy05eJ+LlVy4kz0Tw6W
         OMiNpALBQ5/0Y/o9fw8eQhk9OTDASH4gSdGlJ6nygIdeBwFOFZCRLr5NSGoob1Zwrkio
         /rUqlAZc31yiDTYNlVFl292ZzN+n0gjmF9p45VDrIF3ji3h+VrdhsH+cOd/xPQhFjckp
         FLj7H5r0vH1OkoFmhgbY7QLJ6XFpPvOWTlXo8TmpeZ6o1NQeLUougIuRw2DuBw2O4re9
         LI3HoHqYO24KwLxuhxLgo5a0dmREqGTp+5F8aurdPYos2/C59chpJhaQs/gxsvSmw75l
         UV1A==
X-Gm-Message-State: AOAM532jum1jTc6VG2qwuWcpCaeh2wFfHHtIMTWJoybvhjtULB3l1MfZ
        FhqeZkm/JG+ZMxvvcj5j822bre3Qgdn4AHLQ/Ug=
X-Google-Smtp-Source: ABdhPJzVUcln94phhwBLhOF7GFrBJaC3KSYVODO2xzBW+5m6OrxGs/gQecIVNlpCaqogl8GLRq2naExfKXzIvkxOMIA=
X-Received: by 2002:a25:ba06:: with SMTP id t6mr28921317ybg.459.1620083319859;
 Mon, 03 May 2021 16:08:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210429153043.3145478-1-joamaki@gmail.com> <20210503111203.3948860-1-joamaki@gmail.com>
In-Reply-To: <20210503111203.3948860-1-joamaki@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 3 May 2021 16:08:28 -0700
Message-ID: <CAEf4BzY0fK3SGJbci0QoPxW1VkerNQ4BGZ4qWOH6WoANw5SAPQ@mail.gmail.com>
Subject: Re: [PATCH bpf v2] selftests/bpf: Rewrite test_tc_redirect.sh as prog_tests/tc_redirect.c
To:     Jussi Maki <joamaki@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, May 3, 2021 at 4:12 AM Jussi Maki <joamaki@gmail.com> wrote:
>
> Ports test_tc_redirect.sh to the test_progs framework and removes the
> old test. This makes it more in line with rest of the tests and makes
> it possible to run this test with vmtest.sh and under the bpf CI.
>
> Signed-off-by: Jussi Maki <joamaki@gmail.com>
> ---

One bug and few mostly mechanical nits. It would be great to get a
code review from someone that knows something about iproute2 and the
whole networking stuff :)

>  tools/testing/selftests/bpf/network_helpers.c |   2 +-
>  tools/testing/selftests/bpf/network_helpers.h |   1 +
>  .../selftests/bpf/prog_tests/tc_redirect.c    | 594 ++++++++++++++++++
>  .../selftests/bpf/progs/test_tc_neigh.c       |  33 +-
>  .../selftests/bpf/progs/test_tc_neigh_fib.c   |   9 +-
>  .../selftests/bpf/progs/test_tc_peer.c        |  33 +-
>  .../testing/selftests/bpf/test_tc_redirect.sh | 216 -------
>  7 files changed, 622 insertions(+), 266 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/tc_redirect.c
>  delete mode 100755 tools/testing/selftests/bpf/test_tc_redirect.sh
>

[...]

> +
> +/**
> + * modify_proc() - Modify entry in /proc
> + *
> + * Modifies an entry in /proc and saves the original value for later
> + * restoration with restore_proc().
> + */
> +static int modify_proc(const char *path, const char *newval)
> +{
> +       struct proc_mod *mod;
> +       FILE *f;
> +
> +       f = fopen(path, "r+");
> +       if (!f)
> +               return -1;
> +
> +       if (num_proc_mods + 1 > MAX_PROC_MODS)
> +               goto fail;

you'll decrement num_proc_mods without incrementing it

> +
> +       num_proc_mods++;
> +       mod = &proc_mods[num_proc_mods-1];
> +
> +       strncpy(mod->path, path, PATH_MAX);
> +
> +       if (!fread(mod->oldval, 1, MAX_PROC_VALUE_LEN, f)) {
> +               log_err("reading from %s failed", path);
> +               goto fail;
> +       }
> +       rewind(f);
> +       if (fwrite(newval, strlen(newval), 1, f) != 1) {
> +               log_err("writing to %s failed", path);
> +               goto fail;
> +       }
> +
> +       fclose(f);
> +       return 0;
> +fail:
> +
> +       fclose(f);
> +       num_proc_mods--;
> +       return -1;
> +}
> +
> +/**
> + * restore_proc() - Restore all /proc modifications
> + */
> +static void restore_proc(void)
> +{
> +       int i;
> +
> +       for (i = 0; i < num_proc_mods; i++) {
> +               struct proc_mod *mod = &proc_mods[i];
> +               FILE *f = fopen(mod->path, "w");

we typically split variable declaration and function calls when the
function can fail, so pretty much anything non-trivial will be done as
a separate statement (followed immediately by error check)

> +
> +               if (!f) {
> +                       log_err("fopen of %s failed", mod->path);
> +                       continue;
> +               }
> +
> +               if (fwrite(mod->oldval, mod->oldlen, 1, f) != 1)
> +                       log_err("fwrite to %s failed", mod->path);
> +
> +               fclose(f);
> +       }
> +       num_proc_mods = 0;
> +}
> +

[...]

> +
> +static int netns_setup_links_and_routes(struct netns_setup_result *result)
> +{
> +       char veth_src_fwd_addr[IFADDR_STR_LEN+1] = {0,};
> +       char veth_dst_fwd_addr[IFADDR_STR_LEN+1] = {0,};

just "= {};". same effect, but not misleading notation

> +
> +       SYS("ip link add veth_src type veth peer name veth_src_fwd");
> +       SYS("ip link add veth_dst type veth peer name veth_dst_fwd");
> +       if (get_ifaddr("veth_src_fwd", veth_src_fwd_addr))
> +               goto fail;
> +       if (get_ifaddr("veth_dst_fwd", veth_dst_fwd_addr))
> +               goto fail;
> +
> +       result->ifindex_veth_src_fwd = get_ifindex("veth_src_fwd");
> +       if (result->ifindex_veth_src_fwd < 0)
> +               goto fail;
> +       result->ifindex_veth_dst_fwd = get_ifindex("veth_dst_fwd");
> +       if (result->ifindex_veth_dst_fwd < 0)
> +               goto fail;
> +

[...]

> +static void test_tcp(int family, const char *addr, __u16 port)
> +{
> +       int listen_fd = -1, accept_fd = -1, client_fd = -1;
> +       char buf[] = "testing testing";
> +
> +       if (!ASSERT_OK(setns_by_name(NS_DST), "setns dst"))
> +               return;
> +
> +       listen_fd = start_server(family, SOCK_STREAM, addr, port, 0);
> +       if (!ASSERT_GE(listen_fd, 0, "listen"))
> +               goto done;
> +
> +       if (!ASSERT_OK(setns_by_name(NS_SRC), "setns src"))
> +               goto done;
> +
> +       client_fd = connect_to_fd(listen_fd, TIMEOUT_MILLIS);
> +       if (!ASSERT_GE(client_fd, 0, "connect_to_fd"))
> +               goto done;
> +
> +       accept_fd = accept(listen_fd, NULL, NULL);
> +       if (!ASSERT_GE(accept_fd, 0, "accept"))
> +               goto done;
> +
> +       if (!ASSERT_OK(settimeo(accept_fd, TIMEOUT_MILLIS), "settimeo"))
> +               goto done;
> +
> +       if (!ASSERT_EQ(
> +               write(client_fd, buf, sizeof(buf)),
> +               sizeof(buf),
> +               "send to server"))
> +               goto done;

I think cases like this are much cleaner if written as:

n = write(client_fd, buf, sizeof(buf));
if (!ASSERT_EQ(n, sizeof(buf), "send to server"))
    goto done;

Don't try to do too much in a single if. Same below.

> +
> +       if (!ASSERT_EQ(
> +               read(accept_fd, buf, sizeof(buf)),
> +               sizeof(buf),
> +               "recv from server"))
> +               goto done;
> +
> +done:
> +       setns_root();
> +       if (listen_fd >= 0)
> +               close(listen_fd);
> +       if (accept_fd >= 0)
> +               close(accept_fd);
> +       if (client_fd >= 0)
> +               close(client_fd);
> +}
> +
> +static int test_ping(int family, const char *addr)
> +{
> +       const char *ping = family == AF_INET6 ? "ping6" : "ping";
> +
> +       SYS("ip netns exec " NS_SRC " %s " PING_ARGS " %s", ping, addr);
> +       return 0;
> +fail:
> +       return -1;
> +}
> +
> +static void test_connectivity(void)
> +{
> +       test_tcp(AF_INET, IP4_DST, IP4_PORT);
> +       test_ping(AF_INET, IP4_DST);
> +       test_tcp(AF_INET6, IP6_DST, IP6_PORT);
> +       test_ping(AF_INET6, IP6_DST);
> +}
> +
> +static void test_tc_redirect_neigh_fib(struct netns_setup_result *setup_result)
> +{
> +       struct test_tc_neigh_fib *skel;
> +
> +       skel = test_tc_neigh_fib__open();
> +       if (!ASSERT_OK_PTR(skel, "test_tc_neigh_fib__open"))
> +               return;
> +
> +       if (!ASSERT_OK(test_tc_neigh_fib__load(skel), "test_tc_neigh_fib__load")) {
> +               test_tc_neigh_fib__destroy(skel);
> +               return;
> +       }
> +
> +       if (!ASSERT_OK(
> +               bpf_program__pin(skel->progs.tc_src, SRC_PROG_PIN_FILE),
> +               "pin " SRC_PROG_PIN_FILE))
> +               goto done;
> +

see above, use

err = bpf_program__pin(...);
if (!ASSERT_OK(err, ...))

That actually makes it easier to debug as well, btw.

> +       if (!ASSERT_OK(
> +               bpf_program__pin(skel->progs.tc_chk, CHK_PROG_PIN_FILE),
> +               "pin " CHK_PROG_PIN_FILE))
> +               goto done;
> +
> +       if (!ASSERT_OK(
> +               bpf_program__pin(skel->progs.tc_dst, DST_PROG_PIN_FILE),
> +               "pin " DST_PROG_PIN_FILE))
> +               goto done;
> +
> +       if (netns_load_bpf())
> +               goto done;
> +
> +       /* bpf_fib_lookup() checks if forwarding is enabled */
> +       if (!ASSERT_OK(setns_by_name(NS_FWD), "setns fwd"))
> +               goto done;
> +       if (!ASSERT_OK(modify_proc("/proc/sys/net/ipv4/ip_forward", "1"),
> +                                  "set ipv4.ip_forward"))
> +               goto done;
> +       if (!ASSERT_OK(modify_proc("/proc/sys/net/ipv6/conf/all/forwarding", "1"),
> +                                  "set ipv6.forwarding"))
> +               goto done;
> +       setns_root();
> +
> +       test_connectivity();
> +done:
> +       bpf_program__unpin(skel->progs.tc_src, SRC_PROG_PIN_FILE);
> +       bpf_program__unpin(skel->progs.tc_chk, CHK_PROG_PIN_FILE);
> +       bpf_program__unpin(skel->progs.tc_dst, DST_PROG_PIN_FILE);
> +       test_tc_neigh_fib__destroy(skel);
> +       netns_unload_bpf();
> +       setns_root();
> +       restore_proc();
> +}
> +

[...]
