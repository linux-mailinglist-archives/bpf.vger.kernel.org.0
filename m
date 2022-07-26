Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EAB0581AA8
	for <lists+bpf@lfdr.de>; Tue, 26 Jul 2022 22:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbiGZUG6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Jul 2022 16:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiGZUG5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Jul 2022 16:06:57 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7EAC6364
        for <bpf@vger.kernel.org>; Tue, 26 Jul 2022 13:06:54 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id m8so18951979edd.9
        for <bpf@vger.kernel.org>; Tue, 26 Jul 2022 13:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZBaTR21MWe/g5YmwFWuy9DNefiwPXGi30/f/mSYcMmk=;
        b=k3mjnSPuw5LUzMZUEUJ4SS4pQSPepQC21dlgQ6NzhWBvS/Usaoj4Fc7IFqO/yw/aIP
         Q5dW0MOo7aG4QRY4wNS1d+0TYVShSEZRzUf8neD9xxAiqoRG87KpwLF8aa3E78HqnLI8
         9/vV8VCfGYfl/mRf4IqCtfWK0g+N+vFLrwsEE8w2W4Y4ZSHMzNsAR7eKBQoLNBAkTGPi
         8n4ZMuFxSUh+rfl/aZxTxeZJqk0o9a0QlK3pmV1YTsseVeQkKdLhxwbq8CXbGrGxBUvE
         /wyqpVhwSpau2NA0ArckpYsc2iF+Zl4Dr9tfcNZMjoR9EUUjz1XlVcoaOp0AdF/G+CXL
         ojNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZBaTR21MWe/g5YmwFWuy9DNefiwPXGi30/f/mSYcMmk=;
        b=DVJncmZoKZJ0JFXGj+FzpH+32VhAJsQu+0i+AULp1fGIsT61r/5teRlecgmaROWR6x
         FKEi+3aqECzeoIRUvdGbq6RXh1r0jszLqhDilEq21M92DjW94sedEpRBA6qRABVcHpOR
         ogfbk67XIqq+b1QotdbtSx4Ryu4ff4dXKX5tHTn+Z8v4KMq2IyHWD7aHoD0j0bcoKOcF
         pgmOtTSSTxlMnggVZEy1OO5gtznL3W00tCPhmm9vghhqO7KFORExdSresEbFSrpBiGM5
         WezPIvV87pWxX4tHpe9L7vw25NzyLIb49G5XtGE1n1ThqvDYyptPZxY5/4V1hx1RLSdK
         iPeA==
X-Gm-Message-State: AJIora/cskQzFMuh48AsNAxt20XHxO6xIx/IbF60XW8NunU5lIn2pms6
        6bHGwvsURWh5GGGPTuVeWHy90Ima7N8pF1tiLYA=
X-Google-Smtp-Source: AGRyM1t381ho4SISvwEj7uk28qracOc6Kc3DiLCtGUlWJ8CEDGGXnp1JHJCOF2mfof1RyrBpw49O2k+5ZkGiP8f9cZI=
X-Received: by 2002:a05:6402:190e:b0:43c:34ba:1903 with SMTP id
 e14-20020a056402190e00b0043c34ba1903mr7829017edz.229.1658866012806; Tue, 26
 Jul 2022 13:06:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220726184706.954822-1-joannelkoong@gmail.com>
 <20220726184706.954822-4-joannelkoong@gmail.com> <CAC1LvL3L-UiM37G3-LfLyGLWLCrFf9-CQ_RN50zqUZOZGtZwPg@mail.gmail.com>
In-Reply-To: <CAC1LvL3L-UiM37G3-LfLyGLWLCrFf9-CQ_RN50zqUZOZGtZwPg@mail.gmail.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Tue, 26 Jul 2022 13:06:41 -0700
Message-ID: <CAJnrk1bZAZ+YbzWFCd1H5n0mksnHeTWjX6i3wXhGgo5OnMO-Jg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 3/3] selftests/bpf: tests for using dynptrs to
 parse skb and xdp buffers
To:     Zvi Effron <zeffron@riotgames.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
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

On Tue, Jul 26, 2022 at 12:44 PM Zvi Effron <zeffron@riotgames.com> wrote:
>
> On Tue, Jul 26, 2022 at 11:48 AM Joanne Koong <joannelkoong@gmail.com> wrote:
> >
> > Test skb and xdp dynptr functionality in the following ways:
> >
> > 1) progs/test_xdp.c
> > * Change existing test to use dynptrs to parse xdp data
> >
> > There were no noticeable diferences in user + system time between
> > the original version vs. using dynptrs. Averaging the time for 10
> > runs (run using "time ./test_progs -t xdp_bpf2bpf"):
> > original version: 0.0449 sec
> > with dynptrs: 0.0429 sec
> >
> > 2) progs/test_l4lb_noinline.c
> > * Change existing test to use dynptrs to parse skb data
> >
> > There were no noticeable diferences in user + system time between
> > the original version vs. using dynptrs. Averaging the time for 10
> > runs (run using "time ./test_progs -t l4lb_all/l4lb_noinline"):
> > original version: 0.0502 sec
> > with dynptrs: 0.055 sec
> >
> > For number of processed verifier instructions:
> > original version: 6284 insns
> > with dynptrs: 2538 insns
> >
> > 3) progs/test_dynptr_xdp.c
> > * Add sample code for parsing tcp hdr opt lookup using dynptrs.
> > This logic is lifted from a real-world use case of packet parsing in
> > katran [0], a layer 4 load balancer
> >
> > 4) progs/dynptr_success.c
> > * Add test case "test_skb_readonly" for testing attempts at writes /
> > data slices on a prog type with read-only skb ctx.
> >
> > 5) progs/dynptr_fail.c
> > * Add test cases "skb_invalid_data_slice" and
> > "xdp_invalid_data_slice" for testing that helpers that modify the
> > underlying packet buffer automatically invalidate the associated
> > data slice.
> > * Add test cases "skb_invalid_ctx" and "xdp_invalid_ctx" for testing
> > that prog types that do not support bpf_dynptr_from_skb/xdp don't
> > have access to the API.
> >
> > [0] https://github.com/facebookincubator/katran/blob/main/katran/lib/bpf/pckt_parsing.h
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> > .../testing/selftests/bpf/prog_tests/dynptr.c | 85 ++++++++++---
> > .../selftests/bpf/prog_tests/dynptr_xdp.c | 49 ++++++++
> > .../testing/selftests/bpf/progs/dynptr_fail.c | 76 ++++++++++++
> > .../selftests/bpf/progs/dynptr_success.c | 32 +++++
> > .../selftests/bpf/progs/test_dynptr_xdp.c | 115 ++++++++++++++++++
> > .../selftests/bpf/progs/test_l4lb_noinline.c | 71 +++++------
> > tools/testing/selftests/bpf/progs/test_xdp.c | 95 +++++++--------
> > .../selftests/bpf/test_tcp_hdr_options.h | 1 +
> > 8 files changed, 416 insertions(+), 108 deletions(-)
> > create mode 100644 tools/testing/selftests/bpf/prog_tests/dynptr_xdp.c
> > create mode 100644 tools/testing/selftests/bpf/progs/test_dynptr_xdp.c
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/dynptr.c b/tools/testing/selftests/bpf/prog_tests/dynptr.c
> > index bcf80b9f7c27..c40631f33c7b 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/dynptr.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/dynptr.c
> > @@ -2,6 +2,7 @@
> > /* Copyright (c) 2022 Facebook */
> >
> > #include <test_progs.h>
> > +#include <network_helpers.h>
> > #include "dynptr_fail.skel.h"
> > #include "dynptr_success.skel.h"
> >
> > @@ -11,8 +12,8 @@ static char obj_log_buf[1048576];
> > static struct {
> > const char *prog_name;
> > const char *expected_err_msg;
> > -} dynptr_tests[] = {
> > - /* failure cases */
> > +} verifier_error_tests[] = {
> > + /* these cases should trigger a verifier error */
> > {"ringbuf_missing_release1", "Unreleased reference id=1"},
> > {"ringbuf_missing_release2", "Unreleased reference id=2"},
> > {"ringbuf_missing_release_callback", "Unreleased reference id"},
> > @@ -42,11 +43,25 @@ static struct {
> > {"release_twice_callback", "arg 1 is an unacquired reference"},
> > {"dynptr_from_mem_invalid_api",
> > "Unsupported reg type fp for bpf_dynptr_from_mem data"},
> > + {"skb_invalid_data_slice", "invalid mem access 'scalar'"},
> > + {"xdp_invalid_data_slice", "invalid mem access 'scalar'"},
> > + {"skb_invalid_ctx", "unknown func bpf_dynptr_from_skb"},
> > + {"xdp_invalid_ctx", "unknown func bpf_dynptr_from_xdp"},
> > +};
> > +
> > +enum test_setup_type {
> > + SETUP_SYSCALL_SLEEP,
> > + SETUP_SKB_PROG,
> > +};
> >
> > - /* success cases */
> > - {"test_read_write", NULL},
> > - {"test_data_slice", NULL},
> > - {"test_ringbuf", NULL},
> > +static struct {
> > + const char *prog_name;
> > + enum test_setup_type type;
> > +} runtime_tests[] = {
> > + {"test_read_write", SETUP_SYSCALL_SLEEP},
> > + {"test_data_slice", SETUP_SYSCALL_SLEEP},
> > + {"test_ringbuf", SETUP_SYSCALL_SLEEP},
> > + {"test_skb_readonly", SETUP_SKB_PROG},
> > };
> >
> > static void verify_fail(const char *prog_name, const char *expected_err_msg)
> > @@ -85,7 +100,7 @@ static void verify_fail(const char *prog_name, const char *expected_err_msg)
> > dynptr_fail__destroy(skel);
> > }
> >
> > -static void verify_success(const char *prog_name)
> > +static void run_tests(const char *prog_name, enum test_setup_type setup_type)
> > {
> > struct dynptr_success *skel;
> > struct bpf_program *prog;
> > @@ -107,15 +122,42 @@ static void verify_success(const char *prog_name)
> > if (!ASSERT_OK_PTR(prog, "bpf_object__find_program_by_name"))
> > goto cleanup;
> >
> > - link = bpf_program__attach(prog);
> > - if (!ASSERT_OK_PTR(link, "bpf_program__attach"))
> > - goto cleanup;
> > + switch (setup_type) {
> > + case SETUP_SYSCALL_SLEEP:
> > + link = bpf_program__attach(prog);
> > + if (!ASSERT_OK_PTR(link, "bpf_program__attach"))
> > + goto cleanup;
> >
> > - usleep(1);
> > + usleep(1);
> >
> > - ASSERT_EQ(skel->bss->err, 0, "err");
> > + bpf_link__destroy(link);
> > + break;
> > + case SETUP_SKB_PROG:
> > + {
> > + int prog_fd, err;
> > + char buf[64];
> > +
> > + prog_fd = bpf_program__fd(prog);
> > + if (CHECK_FAIL(prog_fd < 0))
> > + goto cleanup;
> > +
> > + LIBBPF_OPTS(bpf_test_run_opts, topts,
> > + .data_in = &pkt_v4,
> > + .data_size_in = sizeof(pkt_v4),
> > + .data_out = buf,
> > + .data_size_out = sizeof(buf),
> > + .repeat = 1,
> > + );
> >
> > - bpf_link__destroy(link);
> > + err = bpf_prog_test_run_opts(prog_fd, &topts);
> > +
> > + if (!ASSERT_OK(err, "test_run"))
> > + goto cleanup;
> > +
> > + break;
> > + }
> > + }
> > + ASSERT_EQ(skel->bss->err, 0, "err");
> >
> > cleanup:
> > dynptr_success__destroy(skel);
> > @@ -125,14 +167,17 @@ void test_dynptr(void)
> > {
> > int i;
> >
> > - for (i = 0; i < ARRAY_SIZE(dynptr_tests); i++) {
> > - if (!test__start_subtest(dynptr_tests[i].prog_name))
> > + for (i = 0; i < ARRAY_SIZE(verifier_error_tests); i++) {
> > + if (!test__start_subtest(verifier_error_tests[i].prog_name))
> > + continue;
> > +
> > + verify_fail(verifier_error_tests[i].prog_name,
> > + verifier_error_tests[i].expected_err_msg);
> > + }
> > + for (i = 0; i < ARRAY_SIZE(runtime_tests); i++) {
> > + if (!test__start_subtest(runtime_tests[i].prog_name))
> > continue;
> >
> > - if (dynptr_tests[i].expected_err_msg)
> > - verify_fail(dynptr_tests[i].prog_name,
> > - dynptr_tests[i].expected_err_msg);
> > - else
> > - verify_success(dynptr_tests[i].prog_name);
> > + run_tests(runtime_tests[i].prog_name, runtime_tests[i].type);
> > }
> > }
> > diff --git a/tools/testing/selftests/bpf/prog_tests/dynptr_xdp.c b/tools/testing/selftests/bpf/prog_tests/dynptr_xdp.c
> > new file mode 100644
> > index 000000000000..ca775d126b60
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/dynptr_xdp.c
> > @@ -0,0 +1,49 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include <test_progs.h>
> > +#include <network_helpers.h>
> > +#include "test_dynptr_xdp.skel.h"
> > +#include "test_tcp_hdr_options.h"
> > +
> > +struct test_pkt {
> > + struct ipv6_packet pk6_v6;
> > + u8 options[16];
> > +} __packed;
> > +
> > +void test_dynptr_xdp(void)
> > +{
> > + struct test_dynptr_xdp *skel;
> > + char buf[128];
> > + int err;
> > +
> > + skel = test_dynptr_xdp__open_and_load();
> > + if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
> > + return;
> > +
> > + struct test_pkt pkt = {
> > + .pk6_v6.eth.h_proto = __bpf_constant_htons(ETH_P_IPV6),
> > + .pk6_v6.iph.nexthdr = IPPROTO_TCP,
> > + .pk6_v6.iph.payload_len = __bpf_constant_htons(MAGIC_BYTES),
> > + .pk6_v6.tcp.urg_ptr = 123,
> > + .pk6_v6.tcp.doff = 9, /* 16 bytes of options */
> > +
> > + .options = {
> > + TCPOPT_MSS, 4, 0x05, 0xB4, TCPOPT_NOP, TCPOPT_NOP,
> > + skel->rodata->tcp_hdr_opt_kind_tpr, 6, 0, 0, 0, 9, TCPOPT_EOL
> > + },
> > + };
> > +
> > + LIBBPF_OPTS(bpf_test_run_opts, topts,
> > + .data_in = &pkt,
> > + .data_size_in = sizeof(pkt),
> > + .data_out = buf,
> > + .data_size_out = sizeof(buf),
> > + .repeat = 3,
> > + );
> > +
> > + err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.xdp_ingress_v6), &topts);
> > + ASSERT_OK(err, "ipv6 test_run");
> > + ASSERT_EQ(skel->bss->server_id, 0x9000000, "server id");
> > + ASSERT_EQ(topts.retval, XDP_PASS, "ipv6 test_run retval");
> > +
> > + test_dynptr_xdp__destroy(skel);
> > +}
> > diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
> > index c1814938a5fd..4e3f853b2d02 100644
> > --- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
> > +++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
> > @@ -5,6 +5,7 @@
> > #include <string.h>
> > #include <linux/bpf.h>
> > #include <bpf/bpf_helpers.h>
> > +#include <linux/if_ether.h>
> > #include "bpf_misc.h"
> >
> > char _license[] SEC("license") = "GPL";
> > @@ -622,3 +623,78 @@ int dynptr_from_mem_invalid_api(void *ctx)
> >
> > return 0;
> > }
> > +
> > +/* The data slice is invalidated whenever a helper changes packet data */
> > +SEC("?tc")
> > +int skb_invalid_data_slice(struct __sk_buff *skb)
> > +{
> > + struct bpf_dynptr ptr;
> > + struct ethhdr *hdr;
> > +
> > + bpf_dynptr_from_skb(skb, 0, &ptr);
> > + hdr = bpf_dynptr_data(&ptr, 0, sizeof(*hdr));
> > + if (!hdr)
> > + return SK_DROP;
> > +
> > + hdr->h_proto = 12;
> > +
> > + if (bpf_skb_pull_data(skb, skb->len))
> > + return SK_DROP;
> > +
> > + /* this should fail */
> > + hdr->h_proto = 1;
> > +
> > + return SK_PASS;
> > +}
> > +
> > +/* The data slice is invalidated whenever a helper changes packet data */
> > +SEC("?xdp")
> > +int xdp_invalid_data_slice(struct xdp_md *xdp)
> > +{
> > + struct bpf_dynptr ptr;
> > + struct ethhdr *hdr1, *hdr2;
> > +
> > + bpf_dynptr_from_xdp(xdp, 0, &ptr);
> > + hdr1 = bpf_dynptr_data(&ptr, 0, sizeof(*hdr1));
> > + if (!hdr1)
> > + return XDP_DROP;
> > +
> > + hdr2 = bpf_dynptr_data(&ptr, 0, sizeof(*hdr2));
> > + if (!hdr2)
> > + return XDP_DROP;
> > +
> > + hdr1->h_proto = 12;
> > + hdr2->h_proto = 12;
> > +
> > + if (bpf_xdp_adjust_head(xdp, 0 - (int)sizeof(*hdr1)))
> > + return XDP_DROP;
> > +
> > + /* this should fail */
> > + hdr2->h_proto = 1;
> > +
> > + return XDP_PASS;
> > +}
> > +
> > +/* Only supported prog type can create skb-type dynptrs */
> > +SEC("?raw_tp/sys_nanosleep")
> > +int skb_invalid_ctx(void *ctx)
> > +{
> > + struct bpf_dynptr ptr;
> > +
> > + /* this should fail */
> > + bpf_dynptr_from_skb(ctx, 0, &ptr);
> > +
> > + return 0;
> > +}
> > +
> > +/* Only supported prog type can create xdp-type dynptrs */
> > +SEC("?raw_tp/sys_nanosleep")
> > +int xdp_invalid_ctx(void *ctx)
> > +{
> > + struct bpf_dynptr ptr;
> > +
> > + /* this should fail */
> > + bpf_dynptr_from_xdp(ctx, 0, &ptr);
> > +
> > + return 0;
> > +}
> > diff --git a/tools/testing/selftests/bpf/progs/dynptr_success.c b/tools/testing/selftests/bpf/progs/dynptr_success.c
> > index a3a6103c8569..ffddd6ddc7fb 100644
> > --- a/tools/testing/selftests/bpf/progs/dynptr_success.c
> > +++ b/tools/testing/selftests/bpf/progs/dynptr_success.c
> > @@ -162,3 +162,35 @@ int test_ringbuf(void *ctx)
> > bpf_ringbuf_discard_dynptr(&ptr, 0);
> > return 0;
> > }
> > +
> > +SEC("cgroup_skb/egress")
> > +int test_skb_readonly(void *ctx)
> > +{
> > + __u8 write_data[2] = {1, 2};
> > + struct bpf_dynptr ptr;
> > + void *data;
> > + int ret;
> > +
> > + err = 1;
> > +
> > + if (bpf_dynptr_from_skb(ctx, 0, &ptr))
> > + return 0;
> > + err++;
> > +
> > + data = bpf_dynptr_data(&ptr, 0, 1);
> > + if (data)
> > + /* it's an error if data is not NULL since cgroup skbs
> > + * are read only
> > + */
> > + return 0;
> > + err++;
> > +
> > + ret = bpf_dynptr_write(&ptr, 0, write_data, sizeof(write_data), 0);
> > + /* since cgroup skbs are read only, writes should fail */
> > + if (ret != -EINVAL)
> > + return 0;
> > +
> > + err = 0;
> > +
> > + return 0;
> > +}
> > diff --git a/tools/testing/selftests/bpf/progs/test_dynptr_xdp.c b/tools/testing/selftests/bpf/progs/test_dynptr_xdp.c
> > new file mode 100644
> > index 000000000000..c879dfb6370a
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/test_dynptr_xdp.c
> > @@ -0,0 +1,115 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +/* This logic is lifted from a real-world use case of packet parsing, used in
> > + * the open source library katran, a layer 4 load balancer.
> > + *
> > + * This test demonstrates how to parse packet contents using dynptrs.
> > + *
> > + * https://github.com/facebookincubator/katran/blob/main/katran/lib/bpf/pckt_parsing.h
> > + */
> > +
> > +#include <string.h>
> > +#include <linux/bpf.h>
> > +#include <bpf/bpf_helpers.h>
> > +#include <linux/tcp.h>
> > +#include <stdbool.h>
> > +#include <linux/ipv6.h>
> > +#include <linux/if_ether.h>
> > +#include "test_tcp_hdr_options.h"
> > +
> > +char _license[] SEC("license") = "GPL";
> > +
> > +/* Arbitrarily picked unused value from IANA TCP Option Kind Numbers */
> > +const __u32 tcp_hdr_opt_kind_tpr = 0xB7;
>
> Should this instead be either 0xFD or 0xFE, as those are the two Kind numbers
> allocated for experiments? Using a reserved value seems suboptimal, and
> potentially risks updating one of the entries in [0] to have a double asterisk.

I used 0xB7 because that's what the katran library [1] uses, but after
reading through that iana link, using 0xFD or 0xFE as the experimental
value makes sense to me. I'll change this for v2.

[1] https://github.com/facebookincubator/katran/blob/44ac98876280b8a76e6c90bf857b7b0afe1870f1/katran/lib/bpf/balancer_consts.h#L176-L177

>
> [0]: https://www.iana.org/assignments/tcp-parameters/tcp-parameters.xhtml#tcp-parameters-1
>
> > +/* Length of the tcp header option */
> > +const __u32 tcp_hdr_opt_len_tpr = 6;
> > +/* maximum number of header options to check to lookup server_id */
> > +const __u32 tcp_hdr_opt_max_opt_checks = 15;
> > +
> > +__u32 server_id;
> > +
> > +static int parse_hdr_opt(struct bpf_dynptr *ptr, __u32 *off, __u8 *hdr_bytes_remaining,
> > + __u32 *server_id)
> > +{
> > + __u8 *tcp_opt, kind, hdr_len;
> > + __u8 *data;
> > +
> > + data = bpf_dynptr_data(ptr, *off, sizeof(kind) + sizeof(hdr_len) +
> > + sizeof(*server_id));
> > + if (!data)
> > + return -1;
> > +
> > + kind = data[0];
> > +
> > + if (kind == TCPOPT_EOL)
> > + return -1;
> > +
> > + if (kind == TCPOPT_NOP) {
> > + *off += 1;
> > + /* continue to the next option */
> > + *hdr_bytes_remaining -= 1;
> > +
> > + return 0;
> > + }
> > +
> > + if (*hdr_bytes_remaining < 2)
> > + return -1;
> > +
> > + hdr_len = data[1];
> > + if (hdr_len > *hdr_bytes_remaining)
> > + return -1;
> > +
> > + if (kind == tcp_hdr_opt_kind_tpr) {
> > + if (hdr_len != tcp_hdr_opt_len_tpr)
> > + return -1;
> > +
> > + memcpy(server_id, (__u32 *)(data + 2), sizeof(*server_id));
> > + return 1;
> > + }
> > +
> > + *off += hdr_len;
> > + *hdr_bytes_remaining -= hdr_len;
> > +
> > + return 0;
> > +}
> > +
> > +SEC("xdp")
> > +int xdp_ingress_v6(struct xdp_md *xdp)
> > +{
> > + __u8 hdr_bytes_remaining;
> > + struct tcphdr *tcp_hdr;
> > + __u8 tcp_hdr_opt_len;
> > + int err = 0;
> > + __u32 off;
> > +
> > + struct bpf_dynptr ptr;
> > +
> > + bpf_dynptr_from_xdp(xdp, 0, &ptr);
> > +
> > + off = sizeof(struct ethhdr) + sizeof(struct ipv6hdr);
> > +
> > + tcp_hdr = bpf_dynptr_data(&ptr, off, sizeof(*tcp_hdr));
> > + if (!tcp_hdr)
> > + return XDP_DROP;
> > +
> > + tcp_hdr_opt_len = (tcp_hdr->doff * 4) - sizeof(struct tcphdr);
> > + if (tcp_hdr_opt_len < tcp_hdr_opt_len_tpr)
> > + return XDP_DROP;
> > +
> > + hdr_bytes_remaining = tcp_hdr_opt_len;
> > +
> > + off += sizeof(struct tcphdr);
> > +
> > + /* max number of bytes of options in tcp header is 40 bytes */
> > + for (int i = 0; i < tcp_hdr_opt_max_opt_checks; i++) {
> > + err = parse_hdr_opt(&ptr, &off, &hdr_bytes_remaining, &server_id);
> > +
> > + if (err || !hdr_bytes_remaining)
> > + break;
> > + }
> > +
> > + if (!server_id)
> > + return XDP_DROP;
> > +
> > + return XDP_PASS;
> > +}
> > diff --git a/tools/testing/selftests/bpf/progs/test_l4lb_noinline.c b/tools/testing/selftests/bpf/progs/test_l4lb_noinline.c
> > index c8bc0c6947aa..1fef7868ea8b 100644
> > --- a/tools/testing/selftests/bpf/progs/test_l4lb_noinline.c
> > +++ b/tools/testing/selftests/bpf/progs/test_l4lb_noinline.c
> > @@ -230,21 +230,18 @@ static __noinline bool get_packet_dst(struct real_definition **real,
> > return true;
> > }
> >
> > -static __noinline int parse_icmpv6(void *data, void *data_end, __u64 off,
> > +static __noinline int parse_icmpv6(struct bpf_dynptr *skb_ptr, __u64 off,
> > struct packet_description *pckt)
> > {
> > struct icmp6hdr *icmp_hdr;
> > struct ipv6hdr *ip6h;
> >
> > - icmp_hdr = data + off;
> > - if (icmp_hdr + 1 > data_end)
> > + icmp_hdr = bpf_dynptr_data(skb_ptr, off, sizeof(*icmp_hdr) + sizeof(*ip6h));
> > + if (!icmp_hdr)
> > return TC_ACT_SHOT;
> > if (icmp_hdr->icmp6_type != ICMPV6_PKT_TOOBIG)
> > return TC_ACT_OK;
> > - off += sizeof(struct icmp6hdr);
> > - ip6h = data + off;
> > - if (ip6h + 1 > data_end)
> > - return TC_ACT_SHOT;
> > + ip6h = (struct ipv6hdr *)(icmp_hdr + 1);
> > pckt->proto = ip6h->nexthdr;
> > pckt->flags |= F_ICMP;
> > memcpy(pckt->srcv6, ip6h->daddr.s6_addr32, 16);
> > @@ -252,22 +249,19 @@ static __noinline int parse_icmpv6(void *data, void *data_end, __u64 off,
> > return TC_ACT_UNSPEC;
> > }
> >
> > -static __noinline int parse_icmp(void *data, void *data_end, __u64 off,
> > +static __noinline int parse_icmp(struct bpf_dynptr *skb_ptr, __u64 off,
> > struct packet_description *pckt)
> > {
> > struct icmphdr *icmp_hdr;
> > struct iphdr *iph;
> >
> > - icmp_hdr = data + off;
> > - if (icmp_hdr + 1 > data_end)
> > + icmp_hdr = bpf_dynptr_data(skb_ptr, off, sizeof(*icmp_hdr) + sizeof(*iph));
> > + if (!icmp_hdr)
> > return TC_ACT_SHOT;
> > if (icmp_hdr->type != ICMP_DEST_UNREACH ||
> > icmp_hdr->code != ICMP_FRAG_NEEDED)
> > return TC_ACT_OK;
> > - off += sizeof(struct icmphdr);
> > - iph = data + off;
> > - if (iph + 1 > data_end)
> > - return TC_ACT_SHOT;
> > + iph = (struct iphdr *)(icmp_hdr + 1);
> > if (iph->ihl != 5)
> > return TC_ACT_SHOT;
> > pckt->proto = iph->protocol;
> > @@ -277,13 +271,13 @@ static __noinline int parse_icmp(void *data, void *data_end, __u64 off,
> > return TC_ACT_UNSPEC;
> > }
> >
> > -static __noinline bool parse_udp(void *data, __u64 off, void *data_end,
> > +static __noinline bool parse_udp(struct bpf_dynptr *skb_ptr, __u64 off,
> > struct packet_description *pckt)
> > {
> > struct udphdr *udp;
> > - udp = data + off;
> >
> > - if (udp + 1 > data_end)
> > + udp = bpf_dynptr_data(skb_ptr, off, sizeof(*udp));
> > + if (!udp)
> > return false;
> >
> > if (!(pckt->flags & F_ICMP)) {
> > @@ -296,13 +290,13 @@ static __noinline bool parse_udp(void *data, __u64 off, void *data_end,
> > return true;
> > }
> >
> > -static __noinline bool parse_tcp(void *data, __u64 off, void *data_end,
> > +static __noinline bool parse_tcp(struct bpf_dynptr *skb_ptr, __u64 off,
> > struct packet_description *pckt)
> > {
> > struct tcphdr *tcp;
> >
> > - tcp = data + off;
> > - if (tcp + 1 > data_end)
> > + tcp = bpf_dynptr_data(skb_ptr, off, sizeof(*tcp));
> > + if (!tcp)
> > return false;
> >
> > if (tcp->syn)
> > @@ -318,12 +312,11 @@ static __noinline bool parse_tcp(void *data, __u64 off, void *data_end,
> > return true;
> > }
> >
> > -static __noinline int process_packet(void *data, __u64 off, void *data_end,
> > +static __noinline int process_packet(struct bpf_dynptr *skb_ptr,
> > + struct eth_hdr *eth, __u64 off,
> > bool is_ipv6, struct __sk_buff *skb)
> > {
> > - void *pkt_start = (void *)(long)skb->data;
> > struct packet_description pckt = {};
> > - struct eth_hdr *eth = pkt_start;
> > struct bpf_tunnel_key tkey = {};
> > struct vip_stats *data_stats;
> > struct real_definition *dst;
> > @@ -344,8 +337,8 @@ static __noinline int process_packet(void *data, __u64 off, void *data_end,
> >
> > tkey.tunnel_ttl = 64;
> > if (is_ipv6) {
> > - ip6h = data + off;
> > - if (ip6h + 1 > data_end)
> > + ip6h = bpf_dynptr_data(skb_ptr, off, sizeof(*ip6h));
> > + if (!ip6h)
> > return TC_ACT_SHOT;
> >
> > iph_len = sizeof(struct ipv6hdr);
> > @@ -356,7 +349,7 @@ static __noinline int process_packet(void *data, __u64 off, void *data_end,
> > if (protocol == IPPROTO_FRAGMENT) {
> > return TC_ACT_SHOT;
> > } else if (protocol == IPPROTO_ICMPV6) {
> > - action = parse_icmpv6(data, data_end, off, &pckt);
> > + action = parse_icmpv6(skb_ptr, off, &pckt);
> > if (action >= 0)
> > return action;
> > off += IPV6_PLUS_ICMP_HDR;
> > @@ -365,10 +358,8 @@ static __noinline int process_packet(void *data, __u64 off, void *data_end,
> > memcpy(pckt.dstv6, ip6h->daddr.s6_addr32, 16);
> > }
> > } else {
> > - iph = data + off;
> > - if (iph + 1 > data_end)
> > - return TC_ACT_SHOT;
> > - if (iph->ihl != 5)
> > + iph = bpf_dynptr_data(skb_ptr, off, sizeof(*iph));
> > + if (!iph || iph->ihl != 5)
> > return TC_ACT_SHOT;
> >
> > protocol = iph->protocol;
> > @@ -379,7 +370,7 @@ static __noinline int process_packet(void *data, __u64 off, void *data_end,
> > if (iph->frag_off & PCKT_FRAGMENTED)
> > return TC_ACT_SHOT;
> > if (protocol == IPPROTO_ICMP) {
> > - action = parse_icmp(data, data_end, off, &pckt);
> > + action = parse_icmp(skb_ptr, off, &pckt);
> > if (action >= 0)
> > return action;
> > off += IPV4_PLUS_ICMP_HDR;
> > @@ -391,10 +382,10 @@ static __noinline int process_packet(void *data, __u64 off, void *data_end,
> > protocol = pckt.proto;
> >
> > if (protocol == IPPROTO_TCP) {
> > - if (!parse_tcp(data, off, data_end, &pckt))
> > + if (!parse_tcp(skb_ptr, off, &pckt))
> > return TC_ACT_SHOT;
> > } else if (protocol == IPPROTO_UDP) {
> > - if (!parse_udp(data, off, data_end, &pckt))
> > + if (!parse_udp(skb_ptr, off, &pckt))
> > return TC_ACT_SHOT;
> > } else {
> > return TC_ACT_SHOT;
> > @@ -450,20 +441,22 @@ static __noinline int process_packet(void *data, __u64 off, void *data_end,
> > SEC("tc")
> > int balancer_ingress(struct __sk_buff *ctx)
> > {
> > - void *data_end = (void *)(long)ctx->data_end;
> > - void *data = (void *)(long)ctx->data;
> > - struct eth_hdr *eth = data;
> > + struct bpf_dynptr ptr;
> > + struct eth_hdr *eth;
> > __u32 eth_proto;
> > __u32 nh_off;
> >
> > nh_off = sizeof(struct eth_hdr);
> > - if (data + nh_off > data_end)
> > +
> > + bpf_dynptr_from_skb(ctx, 0, &ptr);
> > + eth = bpf_dynptr_data(&ptr, 0, sizeof(*eth));
> > + if (!eth)
> > return TC_ACT_SHOT;
> > eth_proto = eth->eth_proto;
> > if (eth_proto == bpf_htons(ETH_P_IP))
> > - return process_packet(data, nh_off, data_end, false, ctx);
> > + return process_packet(&ptr, eth, nh_off, false, ctx);
> > else if (eth_proto == bpf_htons(ETH_P_IPV6))
> > - return process_packet(data, nh_off, data_end, true, ctx);
> > + return process_packet(&ptr, eth, nh_off, true, ctx);
> > else
> > return TC_ACT_SHOT;
> > }
> > diff --git a/tools/testing/selftests/bpf/progs/test_xdp.c b/tools/testing/selftests/bpf/progs/test_xdp.c
> > index d7a9a74b7245..2272b56a8777 100644
> > --- a/tools/testing/selftests/bpf/progs/test_xdp.c
> > +++ b/tools/testing/selftests/bpf/progs/test_xdp.c
> > @@ -20,6 +20,12 @@
> > #include <bpf/bpf_endian.h>
> > #include "test_iptunnel_common.h"
> >
> > +const size_t tcphdr_sz = sizeof(struct tcphdr);
> > +const size_t udphdr_sz = sizeof(struct udphdr);
> > +const size_t ethhdr_sz = sizeof(struct ethhdr);
> > +const size_t iphdr_sz = sizeof(struct iphdr);
> > +const size_t ipv6hdr_sz = sizeof(struct ipv6hdr);
> > +
> > struct {
> > __uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
> > __uint(max_entries, 256);
> > @@ -43,8 +49,7 @@ static __always_inline void count_tx(__u32 protocol)
> > *rxcnt_count += 1;
> > }
> >
> > -static __always_inline int get_dport(void *trans_data, void *data_end,
> > - __u8 protocol)
> > +static __always_inline int get_dport(void *trans_data, __u8 protocol)
> > {
> > struct tcphdr *th;
> > struct udphdr *uh;
> > @@ -52,13 +57,9 @@ static __always_inline int get_dport(void *trans_data, void *data_end,
> > switch (protocol) {
> > case IPPROTO_TCP:
> > th = (struct tcphdr *)trans_data;
> > - if (th + 1 > data_end)
> > - return -1;
> > return th->dest;
> > case IPPROTO_UDP:
> > uh = (struct udphdr *)trans_data;
> > - if (uh + 1 > data_end)
> > - return -1;
> > return uh->dest;
> > default:
> > return 0;
> > @@ -75,14 +76,13 @@ static __always_inline void set_ethhdr(struct ethhdr *new_eth,
> > new_eth->h_proto = h_proto;
> > }
> >
> > -static __always_inline int handle_ipv4(struct xdp_md *xdp)
> > +static __always_inline int handle_ipv4(struct xdp_md *xdp, struct bpf_dynptr *xdp_ptr)
> > {
> > - void *data_end = (void *)(long)xdp->data_end;
> > - void *data = (void *)(long)xdp->data;
> > + struct bpf_dynptr new_xdp_ptr;
> > struct iptnl_info *tnl;
> > struct ethhdr *new_eth;
> > struct ethhdr *old_eth;
> > - struct iphdr *iph = data + sizeof(struct ethhdr);
> > + struct iphdr *iph;
> > __u16 *next_iph;
> > __u16 payload_len;
> > struct vip vip = {};
> > @@ -90,10 +90,12 @@ static __always_inline int handle_ipv4(struct xdp_md *xdp)
> > __u32 csum = 0;
> > int i;
> >
> > - if (iph + 1 > data_end)
> > + iph = bpf_dynptr_data(xdp_ptr, ethhdr_sz,
> > + iphdr_sz + (tcphdr_sz > udphdr_sz ? tcphdr_sz : udphdr_sz));
> > + if (!iph)
> > return XDP_DROP;
> >
> > - dport = get_dport(iph + 1, data_end, iph->protocol);
> > + dport = get_dport(iph + 1, iph->protocol);
> > if (dport == -1)
> > return XDP_DROP;
> >
> > @@ -108,37 +110,33 @@ static __always_inline int handle_ipv4(struct xdp_md *xdp)
> > if (!tnl || tnl->family != AF_INET)
> > return XDP_PASS;
> >
> > - if (bpf_xdp_adjust_head(xdp, 0 - (int)sizeof(struct iphdr)))
> > + if (bpf_xdp_adjust_head(xdp, 0 - (int)iphdr_sz))
> > return XDP_DROP;
> >
> > - data = (void *)(long)xdp->data;
> > - data_end = (void *)(long)xdp->data_end;
> > -
> > - new_eth = data;
> > - iph = data + sizeof(*new_eth);
> > - old_eth = data + sizeof(*iph);
> > -
> > - if (new_eth + 1 > data_end ||
> > - old_eth + 1 > data_end ||
> > - iph + 1 > data_end)
> > + bpf_dynptr_from_xdp(xdp, 0, &new_xdp_ptr);
> > + new_eth = bpf_dynptr_data(&new_xdp_ptr, 0, ethhdr_sz + iphdr_sz + ethhdr_sz);
> > + if (!new_eth)
> > return XDP_DROP;
> >
> > + iph = (struct iphdr *)(new_eth + 1);
> > + old_eth = (struct ethhdr *)(iph + 1);
> > +
> > set_ethhdr(new_eth, old_eth, tnl, bpf_htons(ETH_P_IP));
> >
> > iph->version = 4;
> > - iph->ihl = sizeof(*iph) >> 2;
> > + iph->ihl = iphdr_sz >> 2;
> > iph->frag_off = 0;
> > iph->protocol = IPPROTO_IPIP;
> > iph->check = 0;
> > iph->tos = 0;
> > - iph->tot_len = bpf_htons(payload_len + sizeof(*iph));
> > + iph->tot_len = bpf_htons(payload_len + iphdr_sz);
> > iph->daddr = tnl->daddr.v4;
> > iph->saddr = tnl->saddr.v4;
> > iph->ttl = 8;
> >
> > next_iph = (__u16 *)iph;
> > #pragma clang loop unroll(full)
> > - for (i = 0; i < sizeof(*iph) >> 1; i++)
> > + for (i = 0; i < iphdr_sz >> 1; i++)
> > csum += *next_iph++;
> >
> > iph->check = ~((csum & 0xffff) + (csum >> 16));
> > @@ -148,22 +146,23 @@ static __always_inline int handle_ipv4(struct xdp_md *xdp)
> > return XDP_TX;
> > }
> >
> > -static __always_inline int handle_ipv6(struct xdp_md *xdp)
> > +static __always_inline int handle_ipv6(struct xdp_md *xdp, struct bpf_dynptr *xdp_ptr)
> > {
> > - void *data_end = (void *)(long)xdp->data_end;
> > - void *data = (void *)(long)xdp->data;
> > + struct bpf_dynptr new_xdp_ptr;
> > struct iptnl_info *tnl;
> > struct ethhdr *new_eth;
> > struct ethhdr *old_eth;
> > - struct ipv6hdr *ip6h = data + sizeof(struct ethhdr);
> > + struct ipv6hdr *ip6h;
> > __u16 payload_len;
> > struct vip vip = {};
> > int dport;
> >
> > - if (ip6h + 1 > data_end)
> > + ip6h = bpf_dynptr_data(xdp_ptr, ethhdr_sz,
> > + ipv6hdr_sz + (tcphdr_sz > udphdr_sz ? tcphdr_sz : udphdr_sz));
> > + if (!ip6h)
> > return XDP_DROP;
> >
> > - dport = get_dport(ip6h + 1, data_end, ip6h->nexthdr);
> > + dport = get_dport(ip6h + 1, ip6h->nexthdr);
> > if (dport == -1)
> > return XDP_DROP;
> >
> > @@ -178,26 +177,23 @@ static __always_inline int handle_ipv6(struct xdp_md *xdp)
> > if (!tnl || tnl->family != AF_INET6)
> > return XDP_PASS;
> >
> > - if (bpf_xdp_adjust_head(xdp, 0 - (int)sizeof(struct ipv6hdr)))
> > + if (bpf_xdp_adjust_head(xdp, 0 - (int)ipv6hdr_sz))
> > return XDP_DROP;
> >
> > - data = (void *)(long)xdp->data;
> > - data_end = (void *)(long)xdp->data_end;
> > -
> > - new_eth = data;
> > - ip6h = data + sizeof(*new_eth);
> > - old_eth = data + sizeof(*ip6h);
> > -
> > - if (new_eth + 1 > data_end || old_eth + 1 > data_end ||
> > - ip6h + 1 > data_end)
> > + bpf_dynptr_from_xdp(xdp, 0, &new_xdp_ptr);
> > + new_eth = bpf_dynptr_data(&new_xdp_ptr, 0, ethhdr_sz + ipv6hdr_sz + ethhdr_sz);
> > + if (!new_eth)
> > return XDP_DROP;
> >
> > + ip6h = (struct ipv6hdr *)(new_eth + 1);
> > + old_eth = (struct ethhdr *)(ip6h + 1);
> > +
> > set_ethhdr(new_eth, old_eth, tnl, bpf_htons(ETH_P_IPV6));
> >
> > ip6h->version = 6;
> > ip6h->priority = 0;
> > memset(ip6h->flow_lbl, 0, sizeof(ip6h->flow_lbl));
> > - ip6h->payload_len = bpf_htons(bpf_ntohs(payload_len) + sizeof(*ip6h));
> > + ip6h->payload_len = bpf_htons(bpf_ntohs(payload_len) + ipv6hdr_sz);
> > ip6h->nexthdr = IPPROTO_IPV6;
> > ip6h->hop_limit = 8;
> > memcpy(ip6h->saddr.s6_addr32, tnl->saddr.v6, sizeof(tnl->saddr.v6));
> > @@ -211,21 +207,22 @@ static __always_inline int handle_ipv6(struct xdp_md *xdp)
> > SEC("xdp")
> > int _xdp_tx_iptunnel(struct xdp_md *xdp)
> > {
> > - void *data_end = (void *)(long)xdp->data_end;
> > - void *data = (void *)(long)xdp->data;
> > - struct ethhdr *eth = data;
> > + struct bpf_dynptr ptr;
> > + struct ethhdr *eth;
> > __u16 h_proto;
> >
> > - if (eth + 1 > data_end)
> > + bpf_dynptr_from_xdp(xdp, 0, &ptr);
> > + eth = bpf_dynptr_data(&ptr, 0, ethhdr_sz);
> > + if (!eth)
> > return XDP_DROP;
> >
> > h_proto = eth->h_proto;
> >
> > if (h_proto == bpf_htons(ETH_P_IP))
> > - return handle_ipv4(xdp);
> > + return handle_ipv4(xdp, &ptr);
> > else if (h_proto == bpf_htons(ETH_P_IPV6))
> >
> > - return handle_ipv6(xdp);
> > + return handle_ipv6(xdp, &ptr);
> > else
> > return XDP_DROP;
> > }
> > diff --git a/tools/testing/selftests/bpf/test_tcp_hdr_options.h b/tools/testing/selftests/bpf/test_tcp_hdr_options.h
> > index 6118e3ab61fc..56c9f8a3ad3d 100644
> > --- a/tools/testing/selftests/bpf/test_tcp_hdr_options.h
> > +++ b/tools/testing/selftests/bpf/test_tcp_hdr_options.h
> > @@ -50,6 +50,7 @@ struct linum_err {
> >
> > #define TCPOPT_EOL 0
> > #define TCPOPT_NOP 1
> > +#define TCPOPT_MSS 2
> > #define TCPOPT_WINDOW 3
> > #define TCPOPT_EXP 254
> >
> > --
> > 2.30.2
> >
