Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF3A6CF701
	for <lists+bpf@lfdr.de>; Thu, 30 Mar 2023 01:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbjC2XZU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Mar 2023 19:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbjC2XZT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Mar 2023 19:25:19 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F711FFF
        for <bpf@vger.kernel.org>; Wed, 29 Mar 2023 16:25:16 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id cu12so11344506pfb.13
        for <bpf@vger.kernel.org>; Wed, 29 Mar 2023 16:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680132316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O7CrRS/gfWuSHy7wGEBXQxVbAO5VOZ5m2OxijE7ik0E=;
        b=S9msJw/T0bBDLTwOqVt8dPvGDAssugYUhabv6tDCB9fUZeAWdqw1f0SmM5hWft7TW4
         4Lrr0GyoceopeUPxAAUKqtzGTALubMsvYvHXdUWNSTaouE/EMyPdSe2Fh5eW6NwYJ4ey
         VNdha/5ACQdeWIUuofXuJ5xhAEg3TTFUCB8LSwRH2IDGInyFLkhcfepqeYGYmNjYuhNe
         xCMYb0iwnvEoD3Oi5YoDyl+uK3xlb9eI1KNTqM7L0XnctR/JhHjwNxFM9H9TE10YE2+H
         PBUFgxK8T9lNGpmghS+JdKZm+YJzkFOmxBvAcQjI6NnLHciDBqTZb4sWMCiLcuL8LR7N
         mtOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680132316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O7CrRS/gfWuSHy7wGEBXQxVbAO5VOZ5m2OxijE7ik0E=;
        b=YwXEWjh/rVZc9ZXEgnnZe2mZdhfX3osRuP6ji52Sz5tfetexJvKdFer7VznsPUET3F
         Evp5Kmpy/0cTlcFwBktITSoPPSyJOnUZLsOlvOXhpWajqVTeQKjsKvQxe2XxaOz4cQlP
         M7UcnTUKwY/rnQhTe9IUSBRXfZx9TJz5kFJdu/Ba/SNsOIALH1rEUKi+atBpT2Yi5vPu
         TuHTZ1YXKtiFS2t9w4q/hrtfJ11aWkPeSueXKTud1Ctxc2RMX5VLo4mQwMtUfROFuGRh
         7gxnpLaIDvx+ihEsusJwH7V7Alh0Le3u9ZH3WqgL46eNP7oqP+kChKXf3hSi/bZSD1K1
         nhfw==
X-Gm-Message-State: AAQBX9fKaQrpZRFNMUR1VqfSX5TYs6DgctnmFsH9mg+zxFOdEbZbDU21
        vl3LLoRKPUXk4JPTJHO40Bbp8WqsLvXiLdze/3ZWAg==
X-Google-Smtp-Source: AKy350bgMTdAQVtx1dY+RMXW6jMyPNwzxNfgKZoQ2Njpnoj0ctYhq3NUoi9kYpNMok0PG3/WlUTRKxgOHVCjo45AYOk=
X-Received: by 2002:a05:6a00:1905:b0:62d:934e:6ef8 with SMTP id
 y5-20020a056a00190500b0062d934e6ef8mr5490409pfi.5.1680132315414; Wed, 29 Mar
 2023 16:25:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230323200633.3175753-1-aditi.ghag@isovalent.com>
 <20230323200633.3175753-5-aditi.ghag@isovalent.com> <ZB4btVWyDjjdIqhV@google.com>
 <DD6B5D46-CDA5-4510-8647-28445AD92DE1@isovalent.com> <ZCHKY4Bmb6mgc8ea@google.com>
 <F3202D0D-A607-4B66-86B1-2CA1ED67E0BB@isovalent.com> <CAKH8qBtYvsvjruNdznYq-Bkr-FjJoazx71_f=hph21B6_09-oA@mail.gmail.com>
 <30733F2E-2CEB-4004-9970-FA791988F887@isovalent.com>
In-Reply-To: <30733F2E-2CEB-4004-9970-FA791988F887@isovalent.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Wed, 29 Mar 2023 16:25:04 -0700
Message-ID: <CAKH8qBszmONDq+RV1pnfwEwCr=cZbeBdbegmYSV6hP1PPJRm+g@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 4/4] selftests/bpf: Add tests for bpf_sock_destroy
To:     Aditi Ghag <aditi.ghag@isovalent.com>
Cc:     bpf@vger.kernel.org, kafai@fb.com, edumazet@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 29, 2023 at 4:13=E2=80=AFPM Aditi Ghag <aditi.ghag@isovalent.co=
m> wrote:
>
>
>
> > On Mar 28, 2023, at 11:35 AM, Stanislav Fomichev <sdf@google.com> wrote=
:
> >
> > On Tue, Mar 28, 2023 at 10:51=E2=80=AFAM Aditi Ghag <aditi.ghag@isovale=
nt.com> wrote:
> >>
> >>
> >>
> >>> On Mar 27, 2023, at 9:54 AM, Stanislav Fomichev <sdf@google.com> wrot=
e:
> >>>
> >>> On 03/27, Aditi Ghag wrote:
> >>>
> >>>
> >>>>> On Mar 24, 2023, at 2:52 PM, Stanislav Fomichev <sdf@google.com> wr=
ote:
> >>>>>
> >>>>> On 03/23, Aditi Ghag wrote:
> >>>>>> The test cases for destroying sockets mirror the intended usages o=
f the
> >>>>>> bpf_sock_destroy kfunc using iterators.
> >>>>>
> >>>>>> The destroy helpers set `ECONNABORTED` error code that we can vali=
date in
> >>>>>> the test code with client sockets. But UDP sockets have an overrid=
ing error
> >>>>>> code from the disconnect called during abort, so the error code th=
e
> >>>>>> validation is only done for TCP sockets.
> >>>>>
> >>>>>> Signed-off-by: Aditi Ghag <aditi.ghag@isovalent.com>
> >>>>>> ---
> >>>>>> .../selftests/bpf/prog_tests/sock_destroy.c   | 195 ++++++++++++++=
++++
> >>>>>> .../selftests/bpf/progs/sock_destroy_prog.c   | 151 ++++++++++++++
> >>>>>> 2 files changed, 346 insertions(+)
> >>>>>> create mode 100644 tools/testing/selftests/bpf/prog_tests/sock_des=
troy.c
> >>>>>> create mode 100644 tools/testing/selftests/bpf/progs/sock_destroy_=
prog.c
> >>>>>
> >>>>>> diff --git a/tools/testing/selftests/bpf/prog_tests/sock_destroy.c=
 b/tools/testing/selftests/bpf/prog_tests/sock_destroy.c
> >>>>>> new file mode 100644
> >>>>>> index 000000000000..cbce966af568
> >>>>>> --- /dev/null
> >>>>>> +++ b/tools/testing/selftests/bpf/prog_tests/sock_destroy.c
> >>>>>> @@ -0,0 +1,195 @@
> >>>>>> +// SPDX-License-Identifier: GPL-2.0
> >>>>>> +#include <test_progs.h>
> >>>>>> +
> >>>>>> +#include "sock_destroy_prog.skel.h"
> >>>>>> +#include "network_helpers.h"
> >>>>>> +
> >>>>>> +#define SERVER_PORT 6062
> >>>>>> +
> >>>>>> +static void start_iter_sockets(struct bpf_program *prog)
> >>>>>> +{
> >>>>>> + struct bpf_link *link;
> >>>>>> + char buf[50] =3D {};
> >>>>>> + int iter_fd, len;
> >>>>>> +
> >>>>>> + link =3D bpf_program__attach_iter(prog, NULL);
> >>>>>> + if (!ASSERT_OK_PTR(link, "attach_iter"))
> >>>>>> +         return;
> >>>>>> +
> >>>>>> + iter_fd =3D bpf_iter_create(bpf_link__fd(link));
> >>>>>> + if (!ASSERT_GE(iter_fd, 0, "create_iter"))
> >>>>>> +         goto free_link;
> >>>>>> +
> >>>>>> + while ((len =3D read(iter_fd, buf, sizeof(buf))) > 0)
> >>>>>> +         ;
> >>>>>> + ASSERT_GE(len, 0, "read");
> >>>>>> +
> >>>>>> + close(iter_fd);
> >>>>>> +
> >>>>>> +free_link:
> >>>>>> + bpf_link__destroy(link);
> >>>>>> +}
> >>>>>> +
> >>>>>> +static void test_tcp_client(struct sock_destroy_prog *skel)
> >>>>>> +{
> >>>>>> + int serv =3D -1, clien =3D -1, n =3D 0;
> >>>>>> +
> >>>>>> + serv =3D start_server(AF_INET6, SOCK_STREAM, NULL, 0, 0);
> >>>>>> + if (!ASSERT_GE(serv, 0, "start_server"))
> >>>>>> +         goto cleanup_serv;
> >>>>>> +
> >>>>>> + clien =3D connect_to_fd(serv, 0);
> >>>>>> + if (!ASSERT_GE(clien, 0, "connect_to_fd"))
> >>>>>> +         goto cleanup_serv;
> >>>>>> +
> >>>>>> + serv =3D accept(serv, NULL, NULL);
> >>>>>> + if (!ASSERT_GE(serv, 0, "serv accept"))
> >>>>>> +         goto cleanup;
> >>>>>> +
> >>>>>> + n =3D send(clien, "t", 1, 0);
> >>>>>> + if (!ASSERT_GE(n, 0, "client send"))
> >>>>>> +         goto cleanup;
> >>>>>> +
> >>>>>> + /* Run iterator program that destroys connected client sockets. =
*/
> >>>>>> + start_iter_sockets(skel->progs.iter_tcp6_client);
> >>>>>> +
> >>>>>> + n =3D send(clien, "t", 1, 0);
> >>>>>> + if (!ASSERT_LT(n, 0, "client_send on destroyed socket"))
> >>>>>> +         goto cleanup;
> >>>>>> + ASSERT_EQ(errno, ECONNABORTED, "error code on destroyed socket")=
;
> >>>>>> +
> >>>>>> +
> >>>>>> +cleanup:
> >>>>>> + close(clien);
> >>>>>> +cleanup_serv:
> >>>>>> + close(serv);
> >>>>>> +}
> >>>>>> +
> >>>>>> +static void test_tcp_server(struct sock_destroy_prog *skel)
> >>>>>> +{
> >>>>>> + int serv =3D -1, clien =3D -1, n =3D 0;
> >>>>>> +
> >>>>>> + serv =3D start_server(AF_INET6, SOCK_STREAM, NULL, SERVER_PORT, =
0);
> >>>>>> + if (!ASSERT_GE(serv, 0, "start_server"))
> >>>>>> +         goto cleanup_serv;
> >>>>>> +
> >>>>>> + clien =3D connect_to_fd(serv, 0);
> >>>>>> + if (!ASSERT_GE(clien, 0, "connect_to_fd"))
> >>>>>> +         goto cleanup_serv;
> >>>>>> +
> >>>>>> + serv =3D accept(serv, NULL, NULL);
> >>>>>> + if (!ASSERT_GE(serv, 0, "serv accept"))
> >>>>>> +         goto cleanup;
> >>>>>> +
> >>>>>> + n =3D send(clien, "t", 1, 0);
> >>>>>> + if (!ASSERT_GE(n, 0, "client send"))
> >>>>>> +         goto cleanup;
> >>>>>> +
> >>>>>> + /* Run iterator program that destroys server sockets. */
> >>>>>> + start_iter_sockets(skel->progs.iter_tcp6_server);
> >>>>>> +
> >>>>>> + n =3D send(clien, "t", 1, 0);
> >>>>>> + if (!ASSERT_LT(n, 0, "client_send on destroyed socket"))
> >>>>>> +         goto cleanup;
> >>>>>> + ASSERT_EQ(errno, ECONNRESET, "error code on destroyed socket");
> >>>>>> +
> >>>>>> +
> >>>>>> +cleanup:
> >>>>>> + close(clien);
> >>>>>> +cleanup_serv:
> >>>>>> + close(serv);
> >>>>>> +}
> >>>>>> +
> >>>>>> +
> >>>>>> +static void test_udp_client(struct sock_destroy_prog *skel)
> >>>>>> +{
> >>>>>> + int serv =3D -1, clien =3D -1, n =3D 0;
> >>>>>> +
> >>>>>> + serv =3D start_server(AF_INET6, SOCK_DGRAM, NULL, 6161, 0);
> >>>>>> + if (!ASSERT_GE(serv, 0, "start_server"))
> >>>>>> +         goto cleanup_serv;
> >>>>>> +
> >>>>>> + clien =3D connect_to_fd(serv, 0);
> >>>>>> + if (!ASSERT_GE(clien, 0, "connect_to_fd"))
> >>>>>> +         goto cleanup_serv;
> >>>>>> +
> >>>>>> + n =3D send(clien, "t", 1, 0);
> >>>>>> + if (!ASSERT_GE(n, 0, "client send"))
> >>>>>> +         goto cleanup;
> >>>>>> +
> >>>>>> + /* Run iterator program that destroys sockets. */
> >>>>>> + start_iter_sockets(skel->progs.iter_udp6_client);
> >>>>>> +
> >>>>>> + n =3D send(clien, "t", 1, 0);
> >>>>>> + if (!ASSERT_LT(n, 0, "client_send on destroyed socket"))
> >>>>>> +         goto cleanup;
> >>>>>> + /* UDP sockets have an overriding error code after they are disc=
onnected,
> >>>>>> +  * so we don't check for ECONNABORTED error code.
> >>>>>> +  */
> >>>>>> +
> >>>>>> +cleanup:
> >>>>>> + close(clien);
> >>>>>> +cleanup_serv:
> >>>>>> + close(serv);
> >>>>>> +}
> >>>>>> +
> >>>>>> +static void test_udp_server(struct sock_destroy_prog *skel)
> >>>>>> +{
> >>>>>> + int *listen_fds =3D NULL, n, i;
> >>>>>> + unsigned int num_listens =3D 5;
> >>>>>> + char buf[1];
> >>>>>> +
> >>>>>> + /* Start reuseport servers. */
> >>>>>> + listen_fds =3D start_reuseport_server(AF_INET6, SOCK_DGRAM,
> >>>>>> +                                     "::1", SERVER_PORT, 0,
> >>>>>> +                                     num_listens);
> >>>>>> + if (!ASSERT_OK_PTR(listen_fds, "start_reuseport_server"))
> >>>>>> +         goto cleanup;
> >>>>>> +
> >>>>>> + /* Run iterator program that destroys server sockets. */
> >>>>>> + start_iter_sockets(skel->progs.iter_udp6_server);
> >>>>>> +
> >>>>>> + for (i =3D 0; i < num_listens; ++i) {
> >>>>>> +         n =3D read(listen_fds[i], buf, sizeof(buf));
> >>>>>> +         if (!ASSERT_EQ(n, -1, "read") ||
> >>>>>> +             !ASSERT_EQ(errno, ECONNABORTED, "error code on destr=
oyed socket"))
> >>>>>> +                 break;
> >>>>>> + }
> >>>>>> + ASSERT_EQ(i, num_listens, "server socket");
> >>>>>> +
> >>>>>> +cleanup:
> >>>>>> + free_fds(listen_fds, num_listens);
> >>>>>> +}
> >>>>>> +
> >>>>>> +void test_sock_destroy(void)
> >>>>>> +{
> >>>>>> + int cgroup_fd =3D 0;
> >>>>>> + struct sock_destroy_prog *skel;
> >>>>>> +
> >>>>>> + skel =3D sock_destroy_prog__open_and_load();
> >>>>>> + if (!ASSERT_OK_PTR(skel, "skel_open"))
> >>>>>> +         return;
> >>>>>> +
> >>>>>> + cgroup_fd =3D test__join_cgroup("/sock_destroy");
> >>>>>> + if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup"))
> >>>>>> +         goto close_cgroup_fd;
> >>>>>> +
> >>>>>> + skel->links.sock_connect =3D bpf_program__attach_cgroup(
> >>>>>> +         skel->progs.sock_connect, cgroup_fd);
> >>>>>> + if (!ASSERT_OK_PTR(skel->links.sock_connect, "prog_attach"))
> >>>>>> +         goto close_cgroup_fd;
> >>>>>> +
> >>>>>> + if (test__start_subtest("tcp_client"))
> >>>>>> +         test_tcp_client(skel);
> >>>>>> + if (test__start_subtest("tcp_server"))
> >>>>>> +         test_tcp_server(skel);
> >>>>>> + if (test__start_subtest("udp_client"))
> >>>>>> +         test_udp_client(skel);
> >>>>>> + if (test__start_subtest("udp_server"))
> >>>>>> +         test_udp_server(skel);
> >>>>>> +
> >>>>>> +
> >>>>>> +close_cgroup_fd:
> >>>>>> + close(cgroup_fd);
> >>>>>> + sock_destroy_prog__destroy(skel);
> >>>>>> +}
> >>>>>> diff --git a/tools/testing/selftests/bpf/progs/sock_destroy_prog.c=
 b/tools/testing/selftests/bpf/progs/sock_destroy_prog.c
> >>>>>> new file mode 100644
> >>>>>> index 000000000000..8e09d82c50f3
> >>>>>> --- /dev/null
> >>>>>> +++ b/tools/testing/selftests/bpf/progs/sock_destroy_prog.c
> >>>>>> @@ -0,0 +1,151 @@
> >>>>>> +// SPDX-License-Identifier: GPL-2.0
> >>>>>> +
> >>>>>> +#include "vmlinux.h"
> >>>>>> +
> >>>>>> +#include "bpf_tracing_net.h"
> >>>>>> +#include <bpf/bpf_helpers.h>
> >>>>>> +#include <bpf/bpf_endian.h>
> >>>>>> +
> >>>>>> +#define AF_INET6 10
> >>>>>
> >>>>> [..]
> >>>>>
> >>>>>> +/* Keep it in sync with prog_test/sock_destroy. */
> >>>>>> +#define SERVER_PORT 6062
> >>>>>
> >>>>> The test looks good, one optional unrelated nit maybe:
> >>>>>
> >>>>> I've been guilty of these hard-coded ports in the past, but maybe
> >>>>> we should stop hard-coding them? Getting the address of the listene=
r (bound to
> >>>>> port 0) and passing it to the bpf program via global variable shoul=
d be super
> >>>>> easy now (with the skeletons and network_helpers).
> >>>
> >>>
> >>>> I briefly considered adding the ports in a map, and retrieving them =
in the test. But it didn't seem worthwhile as the tests should fail clearly=
 when there is a mismatch.
> >>>
> >>> My worry is that the amount of those tests that have a hard-coded por=
t
> >>> grows and at some point somebody will clash with somebody else.
> >>> And it might not be 100% apparent because test_progs is now multi-thr=
eaded
> >>> and racy..
> >>>
> >>
> >> So you would like the ports to be unique across all the tests.
> >
> > Yeah, but it's hard without having some kind of global registry. Take
> > a look at the following:
> >
> > $ grep -Iri _port tools/testing/selftests/bpf/ | grep -P '\d{4}'
> >
> > tools/testing/selftests/bpf/progs/connect_force_port4.c:
> > sa.sin_port =3D bpf_htons(22222);
> > tools/testing/selftests/bpf/progs/connect_force_port4.c:        if
> > (ctx->user_port =3D=3D bpf_htons(60000)) {
> > tools/testing/selftests/bpf/progs/connect_force_port4.c:
> > ctx->user_port =3D bpf_htons(60123);
> > tools/testing/selftests/bpf/progs/connect_force_port4.c:        if
> > (ctx->user_port =3D=3D bpf_htons(60123)) {
> > tools/testing/selftests/bpf/progs/connect_force_port4.c:
> > ctx->user_port =3D bpf_htons(60000);
> > tools/testing/selftests/bpf/progs/connect_force_port4.c:        if
> > (ctx->user_port =3D=3D bpf_htons(60123)) {
> > tools/testing/selftests/bpf/progs/connect6_prog.c:#define
> > DST_REWRITE_PORT6     6666
> > tools/testing/selftests/bpf/progs/test_sk_lookup.c:static const __u16
> > SRC_PORT =3D bpf_htons(8008);
> > tools/testing/selftests/bpf/progs/test_sk_lookup.c:static const __u16
> > DST_PORT =3D 7007; /* Host byte order */
> > tools/testing/selftests/bpf/progs/test_tc_dtime.c:      __u16
> > dst_ns_port =3D __bpf_htons(50000 + test);
> > tools/testing/selftests/bpf/progs/connect4_dropper.c:   if
> > (ctx->user_port =3D=3D bpf_htons(60120))
> > tools/testing/selftests/bpf/progs/connect_force_port6.c:
> > sa.sin6_port =3D bpf_htons(22223);
> > tools/testing/selftests/bpf/progs/connect_force_port6.c:        if
> > (ctx->user_port =3D=3D bpf_htons(60000)) {
> > tools/testing/selftests/bpf/progs/connect_force_port6.c:
> > ctx->user_port =3D bpf_htons(60124);
> > tools/testing/selftests/bpf/progs/connect_force_port6.c:        if
> > (ctx->user_port =3D=3D bpf_htons(60124)) {
> > tools/testing/selftests/bpf/progs/connect_force_port6.c:
> > ctx->user_port =3D bpf_htons(60000);
> > tools/testing/selftests/bpf/progs/connect_force_port6.c:        if
> > (ctx->user_port =3D=3D bpf_htons(60124)) {
> > tools/testing/selftests/bpf/progs/test_tunnel_kern.c:#define
> > VXLAN_UDP_PORT 4789
> > tools/testing/selftests/bpf/progs/sendmsg4_prog.c:#define DST_PORT
> >         4040
> > tools/testing/selftests/bpf/progs/sendmsg4_prog.c:#define
> > DST_REWRITE_PORT4     4444
> > tools/testing/selftests/bpf/progs/connect4_prog.c:#define
> > DST_REWRITE_PORT4     4444
> > tools/testing/selftests/bpf/progs/bind6_prog.c:#define SERV6_PORT
> >         6060
> > tools/testing/selftests/bpf/progs/bind6_prog.c:#define
> > SERV6_REWRITE_PORT       6666
> > tools/testing/selftests/bpf/progs/sendmsg6_prog.c:#define
> > DST_REWRITE_PORT6     6666
> > tools/testing/selftests/bpf/progs/recvmsg4_prog.c:#define SERV4_PORT
> >         4040
> > <cut>
> >
> > .... there is much more ...
> >
> >>> Getting the address of the listener (bound to
> >>> port 0) and passing it to the bpf program via global variable should =
be super
> >>> easy now (with the skeletons and network_helpers).
> >>
> >> Just so that we are on the same page, could you point to which network=
 helpers are you referring to here for passing global variables?
> >
> > Take a look at the following existing tests:
> > * prog_tests/cgroup_skb_sk_lookup.c
> >  * run_lookup_test(&skel->bss->g_serv_port, out_sk);
> > * progs/cgroup_skb_sk_lookup_kern.c
> >  * g_serv_port
> >
> > Fundamentally, here is what's preferable to have:
> >
> > fd =3D start_server(..., port=3D0, ...);
> > listener_port =3D get_port(fd); /* new network_helpers.h helper that
> > calls getsockname */
> > obj->bss->port =3D listener_port; /* populate the port in the BPF progr=
am */
> >
> > Does it make sense?
>
> That makes sense. Good to know for future references. The client tests do=
n't have hard-coded ports anyway, only the server tests do as they are usin=
g the so_resuseport option. You did mention that this was an optional nit, =
so I'll leave the hard-coded ports for the server tests for now. Hope that'=
s reasonable.

Sure, up to you, but to clarify. You have the following:

+static void test_tcp_server(struct sock_destroy_prog *skel)
+{
+ int serv =3D -1, clien =3D -1, n =3D 0;
+
+ serv =3D start_server(AF_INET6, SOCK_STREAM, NULL, SERVER_PORT, 0);

And the following:

+static void test_udp_client(struct sock_destroy_prog *skel)
+{
+ int serv =3D -1, clien =3D -1, n =3D 0;
+
+ serv =3D start_server(AF_INET6, SOCK_DGRAM, NULL, 6161, 0);

Both have hard-coded ports and not using reuseport?

> >
> >>>>>
> >>>>> And, unrelated, maybe also fix a bunch of places where the reverse =
christmas
> >>>>> tree doesn't look reverse anymore?
> >>>
> >>>> Ok. The checks should be part of tooling (e.g., checkpatch) though i=
f they are meant to be enforced consistently, no?
> >>>
> >>> They are networking specific, so they are not part of a checkpath :-(
> >>> I won't say they are consistently enforced, but we try to keep then
> >>> whenever possible.
> >>>
> >>>>>
> >>>>>> +
> >>>>>> +int bpf_sock_destroy(struct sock_common *sk) __ksym;
> >>>>>> +
> >>>>>> +struct {
> >>>>>> + __uint(type, BPF_MAP_TYPE_ARRAY);
> >>>>>> + __uint(max_entries, 1);
> >>>>>> + __type(key, __u32);
> >>>>>> + __type(value, __u64);
> >>>>>> +} tcp_conn_sockets SEC(".maps");
> >>>>>> +
> >>>>>> +struct {
> >>>>>> + __uint(type, BPF_MAP_TYPE_ARRAY);
> >>>>>> + __uint(max_entries, 1);
> >>>>>> + __type(key, __u32);
> >>>>>> + __type(value, __u64);
> >>>>>> +} udp_conn_sockets SEC(".maps");
> >>>>>> +
> >>>>>> +SEC("cgroup/connect6")
> >>>>>> +int sock_connect(struct bpf_sock_addr *ctx)
> >>>>>> +{
> >>>>>> + int key =3D 0;
> >>>>>> + __u64 sock_cookie =3D 0;
> >>>>>> + __u32 keyc =3D 0;
> >>>>>> +
> >>>>>> + if (ctx->family !=3D AF_INET6 || ctx->user_family !=3D AF_INET6)
> >>>>>> +         return 1;
> >>>>>> +
> >>>>>> + sock_cookie =3D bpf_get_socket_cookie(ctx);
> >>>>>> + if (ctx->protocol =3D=3D IPPROTO_TCP)
> >>>>>> +         bpf_map_update_elem(&tcp_conn_sockets, &key, &sock_cooki=
e, 0);
> >>>>>> + else if (ctx->protocol =3D=3D IPPROTO_UDP)
> >>>>>> +         bpf_map_update_elem(&udp_conn_sockets, &keyc, &sock_cook=
ie, 0);
> >>>>>> + else
> >>>>>> +         return 1;
> >>>>>> +
> >>>>>> + return 1;
> >>>>>> +}
> >>>>>> +
> >>>>>> +SEC("iter/tcp")
> >>>>>> +int iter_tcp6_client(struct bpf_iter__tcp *ctx)
> >>>>>> +{
> >>>>>> + struct sock_common *sk_common =3D ctx->sk_common;
> >>>>>> + struct seq_file *seq =3D ctx->meta->seq;
> >>>>>> + __u64 sock_cookie =3D 0;
> >>>>>> + __u64 *val;
> >>>>>> + int key =3D 0;
> >>>>>> +
> >>>>>> + if (!sk_common)
> >>>>>> +         return 0;
> >>>>>> +
> >>>>>> + if (sk_common->skc_family !=3D AF_INET6)
> >>>>>> +         return 0;
> >>>>>> +
> >>>>>> + sock_cookie  =3D bpf_get_socket_cookie(sk_common);
> >>>>>> + val =3D bpf_map_lookup_elem(&tcp_conn_sockets, &key);
> >>>>>> + if (!val)
> >>>>>> +         return 0;
> >>>>>> + /* Destroy connected client sockets. */
> >>>>>> + if (sock_cookie =3D=3D *val)
> >>>>>> +         bpf_sock_destroy(sk_common);
> >>>>>> +
> >>>>>> + return 0;
> >>>>>> +}
> >>>>>> +
> >>>>>> +SEC("iter/tcp")
> >>>>>> +int iter_tcp6_server(struct bpf_iter__tcp *ctx)
> >>>>>> +{
> >>>>>> + struct sock_common *sk_common =3D ctx->sk_common;
> >>>>>> + struct seq_file *seq =3D ctx->meta->seq;
> >>>>>> + struct tcp6_sock *tcp_sk;
> >>>>>> + const struct inet_connection_sock *icsk;
> >>>>>> + const struct inet_sock *inet;
> >>>>>> + __u16 srcp;
> >>>>>> +
> >>>>>> + if (!sk_common)
> >>>>>> +         return 0;
> >>>>>> +
> >>>>>> + if (sk_common->skc_family !=3D AF_INET6)
> >>>>>> +         return 0;
> >>>>>> +
> >>>>>> + tcp_sk =3D bpf_skc_to_tcp6_sock(sk_common);
> >>>>>> + if (!tcp_sk)
> >>>>>> +         return 0;
> >>>>>> +
> >>>>>> + icsk =3D &tcp_sk->tcp.inet_conn;
> >>>>>> + inet =3D &icsk->icsk_inet;
> >>>>>> + srcp =3D bpf_ntohs(inet->inet_sport);
> >>>>>> +
> >>>>>> + /* Destroy server sockets. */
> >>>>>> + if (srcp =3D=3D SERVER_PORT)
> >>>>>> +         bpf_sock_destroy(sk_common);
> >>>>>> +
> >>>>>> + return 0;
> >>>>>> +}
> >>>>>> +
> >>>>>> +
> >>>>>> +SEC("iter/udp")
> >>>>>> +int iter_udp6_client(struct bpf_iter__udp *ctx)
> >>>>>> +{
> >>>>>> + struct seq_file *seq =3D ctx->meta->seq;
> >>>>>> + struct udp_sock *udp_sk =3D ctx->udp_sk;
> >>>>>> + struct sock *sk =3D (struct sock *) udp_sk;
> >>>>>> + __u64 sock_cookie =3D 0, *val;
> >>>>>> + int key =3D 0;
> >>>>>> +
> >>>>>> + if (!sk)
> >>>>>> +         return 0;
> >>>>>> +
> >>>>>> + sock_cookie  =3D bpf_get_socket_cookie(sk);
> >>>>>> + val =3D bpf_map_lookup_elem(&udp_conn_sockets, &key);
> >>>>>> + if (!val)
> >>>>>> +         return 0;
> >>>>>> + /* Destroy connected client sockets. */
> >>>>>> + if (sock_cookie =3D=3D *val)
> >>>>>> +         bpf_sock_destroy((struct sock_common *)sk);
> >>>>>> +
> >>>>>> + return 0;
> >>>>>> +}
> >>>>>> +
> >>>>>> +SEC("iter/udp")
> >>>>>> +int iter_udp6_server(struct bpf_iter__udp *ctx)
> >>>>>> +{
> >>>>>> + struct seq_file *seq =3D ctx->meta->seq;
> >>>>>> + struct udp_sock *udp_sk =3D ctx->udp_sk;
> >>>>>> + struct sock *sk =3D (struct sock *) udp_sk;
> >>>>>> + __u16 srcp;
> >>>>>> + struct inet_sock *inet;
> >>>>>> +
> >>>>>> + if (!sk)
> >>>>>> +         return 0;
> >>>>>> +
> >>>>>> + inet =3D &udp_sk->inet;
> >>>>>> + srcp =3D bpf_ntohs(inet->inet_sport);
> >>>>>> + if (srcp =3D=3D SERVER_PORT)
> >>>>>> +         bpf_sock_destroy((struct sock_common *)sk);
> >>>>>> +
> >>>>>> + return 0;
> >>>>>> +}
> >>>>>> +
> >>>>>> +char _license[] SEC("license") =3D "GPL";
> >>>>>> --
> >>>>>> 2.34.1
>
