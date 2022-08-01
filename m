Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8051A586FFA
	for <lists+bpf@lfdr.de>; Mon,  1 Aug 2022 19:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234192AbiHAR7J (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Aug 2022 13:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234082AbiHAR6r (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Aug 2022 13:58:47 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6893E744
        for <bpf@vger.kernel.org>; Mon,  1 Aug 2022 10:58:29 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id sz17so21756033ejc.9
        for <bpf@vger.kernel.org>; Mon, 01 Aug 2022 10:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=u6DZTqqryl0kwUamcgWE97NQYfGL6zlc6yJP4paj3zE=;
        b=BBsSojT/T7Z5ElOmrI6mk69NIM6Q3j/KL5vGwxWIuKqN04hBHusmQ2Ilwj3Podre44
         DlsyznN5EQBtrPDpkF5mqZSU9GL0wa+WITEfE0GgHruTq+JdYJlQEOql4q2oZOaoHSap
         A6X7YBEWjgWgt4Fu9VoGnFmh8iWHMxvts1wgwzg4rz85ZFvS/Uppf6s9cFdvKFWp0Row
         NDGQAv01EO4IXwhM/2JHafX/hFMvzcKhiwuxBSFuLjw5GJ0veuZV1uCGM8X+z0SZpp9z
         OyEz9bD0pMDFyTzK0hpd1bSIvGMbK0upzrFK8OEaKEnVVzf1AtVzoIivZvthfVpp9WFt
         KiDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=u6DZTqqryl0kwUamcgWE97NQYfGL6zlc6yJP4paj3zE=;
        b=I6eyr7cLKHYe1+F5I1K7XwizqMsljW0oX7/7S2LEdpvoZDK+Gehj4F9iL2R6HXNy9N
         o+8GqqQH1c1juhC6rUMBMpe8L/EIBR4koogreYb6B4cbl5TkdMErf0M0wIjhUBcAQlR/
         6+HVrEeijbAFIOPc/xQdhL15xbfp8BpJTCWHZ1k65K7WSfZMwhnKZJk7Rpkqexx6GyyF
         uVtO8aOhRk0CGvFSng70B6ceryxqrP+aA0n2whAu58lc30yxl8CiQH3RTmTqnT6TlnPA
         noeHCzjraGXvqhuPA6Q5Lnvpr6eyj4URoNVZnODlYtcmymXI9+WMQNLtlQXhsNEFMcrw
         0ZmQ==
X-Gm-Message-State: AJIora+otPRQudXavLxwUbH1XsSb7jzAXULnpM6hNEtipM73knzRQppA
        Qr1vMtizQLOJ+kZlqmCuBqkUY/Arr50aZEPbKAg=
X-Google-Smtp-Source: AGRyM1vM55hIxSJHFmuPrlmHMwtc/X3oQpmgSMmFShgMeRggsX5Ho6K8SMxzjL7r+Rxnj/hS2FhMneTCXfJRmJsyc0Y=
X-Received: by 2002:a17:907:2808:b0:72b:4d49:b2e9 with SMTP id
 eb8-20020a170907280800b0072b4d49b2e9mr13867899ejc.176.1659376707939; Mon, 01
 Aug 2022 10:58:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220726184706.954822-1-joannelkoong@gmail.com> <20220726184706.954822-4-joannelkoong@gmail.com>
In-Reply-To: <20220726184706.954822-4-joannelkoong@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 1 Aug 2022 10:58:16 -0700
Message-ID: <CAEf4Bzb2Jev=NpwzkKn8UPRe-99-3WcgySfGwOB6W8n-3E4G1g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 3/3] selftests/bpf: tests for using dynptrs to
 parse skb and xdp buffers
To:     Joanne Koong <joannelkoong@gmail.com>
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

On Tue, Jul 26, 2022 at 11:48 AM Joanne Koong <joannelkoong@gmail.com> wrote:
>
> Test skb and xdp dynptr functionality in the following ways:
>
> 1) progs/test_xdp.c
>    * Change existing test to use dynptrs to parse xdp data
>
>      There were no noticeable diferences in user + system time between
>      the original version vs. using dynptrs. Averaging the time for 10
>      runs (run using "time ./test_progs -t xdp_bpf2bpf"):
>          original version: 0.0449 sec
>          with dynptrs: 0.0429 sec
>
> 2) progs/test_l4lb_noinline.c
>    * Change existing test to use dynptrs to parse skb data
>
>      There were no noticeable diferences in user + system time between
>      the original version vs. using dynptrs. Averaging the time for 10
>      runs (run using "time ./test_progs -t l4lb_all/l4lb_noinline"):
>          original version: 0.0502 sec
>          with dynptrs: 0.055 sec
>
>      For number of processed verifier instructions:
>          original version: 6284 insns
>          with dynptrs: 2538 insns
>
> 3) progs/test_dynptr_xdp.c
>    * Add sample code for parsing tcp hdr opt lookup using dynptrs.
>      This logic is lifted from a real-world use case of packet parsing in
>      katran [0], a layer 4 load balancer
>
> 4) progs/dynptr_success.c
>    * Add test case "test_skb_readonly" for testing attempts at writes /
>      data slices on a prog type with read-only skb ctx.
>
> 5) progs/dynptr_fail.c
>    * Add test cases "skb_invalid_data_slice" and
>      "xdp_invalid_data_slice" for testing that helpers that modify the
>      underlying packet buffer automatically invalidate the associated
>      data slice.
>    * Add test cases "skb_invalid_ctx" and "xdp_invalid_ctx" for testing
>      that prog types that do not support bpf_dynptr_from_skb/xdp don't
>      have access to the API.
>
> [0] https://github.com/facebookincubator/katran/blob/main/katran/lib/bpf/pckt_parsing.h
>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  .../testing/selftests/bpf/prog_tests/dynptr.c |  85 ++++++++++---
>  .../selftests/bpf/prog_tests/dynptr_xdp.c     |  49 ++++++++
>  .../testing/selftests/bpf/progs/dynptr_fail.c |  76 ++++++++++++
>  .../selftests/bpf/progs/dynptr_success.c      |  32 +++++
>  .../selftests/bpf/progs/test_dynptr_xdp.c     | 115 ++++++++++++++++++
>  .../selftests/bpf/progs/test_l4lb_noinline.c  |  71 +++++------
>  tools/testing/selftests/bpf/progs/test_xdp.c  |  95 +++++++--------
>  .../selftests/bpf/test_tcp_hdr_options.h      |   1 +
>  8 files changed, 416 insertions(+), 108 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/dynptr_xdp.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_dynptr_xdp.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/dynptr.c b/tools/testing/selftests/bpf/prog_tests/dynptr.c
> index bcf80b9f7c27..c40631f33c7b 100644
> --- a/tools/testing/selftests/bpf/prog_tests/dynptr.c
> +++ b/tools/testing/selftests/bpf/prog_tests/dynptr.c
> @@ -2,6 +2,7 @@
>  /* Copyright (c) 2022 Facebook */
>
>  #include <test_progs.h>
> +#include <network_helpers.h>
>  #include "dynptr_fail.skel.h"
>  #include "dynptr_success.skel.h"
>
> @@ -11,8 +12,8 @@ static char obj_log_buf[1048576];
>  static struct {
>         const char *prog_name;
>         const char *expected_err_msg;
> -} dynptr_tests[] = {
> -       /* failure cases */
> +} verifier_error_tests[] = {
> +       /* these cases should trigger a verifier error */
>         {"ringbuf_missing_release1", "Unreleased reference id=1"},
>         {"ringbuf_missing_release2", "Unreleased reference id=2"},
>         {"ringbuf_missing_release_callback", "Unreleased reference id"},
> @@ -42,11 +43,25 @@ static struct {
>         {"release_twice_callback", "arg 1 is an unacquired reference"},
>         {"dynptr_from_mem_invalid_api",
>                 "Unsupported reg type fp for bpf_dynptr_from_mem data"},
> +       {"skb_invalid_data_slice", "invalid mem access 'scalar'"},
> +       {"xdp_invalid_data_slice", "invalid mem access 'scalar'"},
> +       {"skb_invalid_ctx", "unknown func bpf_dynptr_from_skb"},
> +       {"xdp_invalid_ctx", "unknown func bpf_dynptr_from_xdp"},
> +};
> +
> +enum test_setup_type {
> +       SETUP_SYSCALL_SLEEP,
> +       SETUP_SKB_PROG,
> +};
>
> -       /* success cases */
> -       {"test_read_write", NULL},
> -       {"test_data_slice", NULL},
> -       {"test_ringbuf", NULL},
> +static struct {
> +       const char *prog_name;
> +       enum test_setup_type type;
> +} runtime_tests[] = {
> +       {"test_read_write", SETUP_SYSCALL_SLEEP},
> +       {"test_data_slice", SETUP_SYSCALL_SLEEP},
> +       {"test_ringbuf", SETUP_SYSCALL_SLEEP},
> +       {"test_skb_readonly", SETUP_SKB_PROG},

nit: wouldn't it be better to add test_setup_type to dynptr_tests (and
keep fail and success cases together)? It's conceivable that you might
want different setups to test different error conditions, right?

>  };
>
>  static void verify_fail(const char *prog_name, const char *expected_err_msg)
> @@ -85,7 +100,7 @@ static void verify_fail(const char *prog_name, const char *expected_err_msg)
>         dynptr_fail__destroy(skel);
>  }
>
> -static void verify_success(const char *prog_name)
> +static void run_tests(const char *prog_name, enum test_setup_type setup_type)
>  {
>         struct dynptr_success *skel;
>         struct bpf_program *prog;
> @@ -107,15 +122,42 @@ static void verify_success(const char *prog_name)
>         if (!ASSERT_OK_PTR(prog, "bpf_object__find_program_by_name"))
>                 goto cleanup;
>
> -       link = bpf_program__attach(prog);
> -       if (!ASSERT_OK_PTR(link, "bpf_program__attach"))
> -               goto cleanup;
> +       switch (setup_type) {
> +       case SETUP_SYSCALL_SLEEP:
> +               link = bpf_program__attach(prog);
> +               if (!ASSERT_OK_PTR(link, "bpf_program__attach"))
> +                       goto cleanup;
>
> -       usleep(1);
> +               usleep(1);
>
> -       ASSERT_EQ(skel->bss->err, 0, "err");
> +               bpf_link__destroy(link);
> +               break;
> +       case SETUP_SKB_PROG:
> +       {
> +               int prog_fd, err;
> +               char buf[64];
> +
> +               prog_fd = bpf_program__fd(prog);
> +               if (CHECK_FAIL(prog_fd < 0))

please don't use CHECK and especially CHECK_FAIL

> +                       goto cleanup;
> +
> +               LIBBPF_OPTS(bpf_test_run_opts, topts,
> +                           .data_in = &pkt_v4,
> +                           .data_size_in = sizeof(pkt_v4),
> +                           .data_out = buf,
> +                           .data_size_out = sizeof(buf),
> +                           .repeat = 1,
> +               );

nit: LIBBPF_OPTS declares variable, so should be part of variable
declaration block

>
> -       bpf_link__destroy(link);
> +               err = bpf_prog_test_run_opts(prog_fd, &topts);
> +
> +               if (!ASSERT_OK(err, "test_run"))
> +                       goto cleanup;
> +
> +               break;
> +       }
> +       }
> +       ASSERT_EQ(skel->bss->err, 0, "err");
>
>  cleanup:
>         dynptr_success__destroy(skel);
> @@ -125,14 +167,17 @@ void test_dynptr(void)
>  {
>         int i;
>
> -       for (i = 0; i < ARRAY_SIZE(dynptr_tests); i++) {
> -               if (!test__start_subtest(dynptr_tests[i].prog_name))
> +       for (i = 0; i < ARRAY_SIZE(verifier_error_tests); i++) {
> +               if (!test__start_subtest(verifier_error_tests[i].prog_name))
> +                       continue;
> +
> +               verify_fail(verifier_error_tests[i].prog_name,
> +                           verifier_error_tests[i].expected_err_msg);
> +       }
> +       for (i = 0; i < ARRAY_SIZE(runtime_tests); i++) {
> +               if (!test__start_subtest(runtime_tests[i].prog_name))
>                         continue;
>
> -               if (dynptr_tests[i].expected_err_msg)
> -                       verify_fail(dynptr_tests[i].prog_name,
> -                                   dynptr_tests[i].expected_err_msg);
> -               else
> -                       verify_success(dynptr_tests[i].prog_name);
> +               run_tests(runtime_tests[i].prog_name, runtime_tests[i].type);
>         }
>  }
> diff --git a/tools/testing/selftests/bpf/prog_tests/dynptr_xdp.c b/tools/testing/selftests/bpf/prog_tests/dynptr_xdp.c
> new file mode 100644
> index 000000000000..ca775d126b60
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/dynptr_xdp.c
> @@ -0,0 +1,49 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <test_progs.h>
> +#include <network_helpers.h>
> +#include "test_dynptr_xdp.skel.h"
> +#include "test_tcp_hdr_options.h"
> +
> +struct test_pkt {
> +       struct ipv6_packet pk6_v6;
> +       u8 options[16];
> +} __packed;
> +
> +void test_dynptr_xdp(void)
> +{
> +       struct test_dynptr_xdp *skel;
> +       char buf[128];
> +       int err;
> +
> +       skel = test_dynptr_xdp__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
> +               return;
> +
> +       struct test_pkt pkt = {
> +               .pk6_v6.eth.h_proto = __bpf_constant_htons(ETH_P_IPV6),
> +               .pk6_v6.iph.nexthdr = IPPROTO_TCP,
> +               .pk6_v6.iph.payload_len = __bpf_constant_htons(MAGIC_BYTES),
> +               .pk6_v6.tcp.urg_ptr = 123,
> +               .pk6_v6.tcp.doff = 9, /* 16 bytes of options */
> +
> +               .options = {
> +                       TCPOPT_MSS, 4, 0x05, 0xB4, TCPOPT_NOP, TCPOPT_NOP,
> +                       skel->rodata->tcp_hdr_opt_kind_tpr, 6, 0, 0, 0, 9, TCPOPT_EOL
> +               },
> +       };
> +
> +       LIBBPF_OPTS(bpf_test_run_opts, topts,
> +                   .data_in = &pkt,
> +                   .data_size_in = sizeof(pkt),
> +                   .data_out = buf,
> +                   .data_size_out = sizeof(buf),
> +                   .repeat = 3,
> +       );
> +

for topts and pkt, they should be up above with other variables
(unless we want to break off from kernel code style, which I didn't
think we want)

> +       err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.xdp_ingress_v6), &topts);
> +       ASSERT_OK(err, "ipv6 test_run");
> +       ASSERT_EQ(skel->bss->server_id, 0x9000000, "server id");
> +       ASSERT_EQ(topts.retval, XDP_PASS, "ipv6 test_run retval");
> +
> +       test_dynptr_xdp__destroy(skel);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
> index c1814938a5fd..4e3f853b2d02 100644
> --- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
> +++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
> @@ -5,6 +5,7 @@
>  #include <string.h>
>  #include <linux/bpf.h>
>  #include <bpf/bpf_helpers.h>
> +#include <linux/if_ether.h>
>  #include "bpf_misc.h"
>
>  char _license[] SEC("license") = "GPL";
> @@ -622,3 +623,78 @@ int dynptr_from_mem_invalid_api(void *ctx)
>
>         return 0;
>  }
> +
> +/* The data slice is invalidated whenever a helper changes packet data */
> +SEC("?tc")
> +int skb_invalid_data_slice(struct __sk_buff *skb)
> +{
> +       struct bpf_dynptr ptr;
> +       struct ethhdr *hdr;
> +
> +       bpf_dynptr_from_skb(skb, 0, &ptr);
> +       hdr = bpf_dynptr_data(&ptr, 0, sizeof(*hdr));
> +       if (!hdr)
> +               return SK_DROP;
> +
> +       hdr->h_proto = 12;
> +
> +       if (bpf_skb_pull_data(skb, skb->len))
> +               return SK_DROP;
> +
> +       /* this should fail */
> +       hdr->h_proto = 1;
> +
> +       return SK_PASS;
> +}
> +
> +/* The data slice is invalidated whenever a helper changes packet data */
> +SEC("?xdp")
> +int xdp_invalid_data_slice(struct xdp_md *xdp)
> +{
> +       struct bpf_dynptr ptr;
> +       struct ethhdr *hdr1, *hdr2;
> +
> +       bpf_dynptr_from_xdp(xdp, 0, &ptr);
> +       hdr1 = bpf_dynptr_data(&ptr, 0, sizeof(*hdr1));
> +       if (!hdr1)
> +               return XDP_DROP;
> +
> +       hdr2 = bpf_dynptr_data(&ptr, 0, sizeof(*hdr2));
> +       if (!hdr2)
> +               return XDP_DROP;
> +
> +       hdr1->h_proto = 12;
> +       hdr2->h_proto = 12;
> +
> +       if (bpf_xdp_adjust_head(xdp, 0 - (int)sizeof(*hdr1)))
> +               return XDP_DROP;
> +
> +       /* this should fail */
> +       hdr2->h_proto = 1;

is there something special about having both hdr1 and hdr2? Wouldn't
this test work with just single hdr pointer?

> +
> +       return XDP_PASS;
> +}
> +
> +/* Only supported prog type can create skb-type dynptrs */

[...]

> +       err = 1;
> +
> +       if (bpf_dynptr_from_skb(ctx, 0, &ptr))
> +               return 0;
> +       err++;
> +
> +       data = bpf_dynptr_data(&ptr, 0, 1);
> +       if (data)
> +               /* it's an error if data is not NULL since cgroup skbs
> +                * are read only
> +                */
> +               return 0;
> +       err++;
> +
> +       ret = bpf_dynptr_write(&ptr, 0, write_data, sizeof(write_data), 0);
> +       /* since cgroup skbs are read only, writes should fail */
> +       if (ret != -EINVAL)
> +               return 0;
> +
> +       err = 0;

hm, if data is NULL you'll still report success if bpf_dynptr_write
returns 0 or any other error but -EINVAL... The logic is a bit unclear
here...

> +
> +       return 0;
> +}
> diff --git a/tools/testing/selftests/bpf/progs/test_dynptr_xdp.c b/tools/testing/selftests/bpf/progs/test_dynptr_xdp.c
> new file mode 100644
> index 000000000000..c879dfb6370a
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_dynptr_xdp.c
> @@ -0,0 +1,115 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/* This logic is lifted from a real-world use case of packet parsing, used in
> + * the open source library katran, a layer 4 load balancer.
> + *
> + * This test demonstrates how to parse packet contents using dynptrs.
> + *
> + * https://github.com/facebookincubator/katran/blob/main/katran/lib/bpf/pckt_parsing.h
> + */
> +
> +#include <string.h>
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include <linux/tcp.h>
> +#include <stdbool.h>
> +#include <linux/ipv6.h>
> +#include <linux/if_ether.h>
> +#include "test_tcp_hdr_options.h"
> +
> +char _license[] SEC("license") = "GPL";
> +
> +/* Arbitrarily picked unused value from IANA TCP Option Kind Numbers */
> +const __u32 tcp_hdr_opt_kind_tpr = 0xB7;
> +/* Length of the tcp header option */
> +const __u32 tcp_hdr_opt_len_tpr = 6;
> +/* maximum number of header options to check to lookup server_id */
> +const __u32 tcp_hdr_opt_max_opt_checks = 15;
> +
> +__u32 server_id;
> +
> +static int parse_hdr_opt(struct bpf_dynptr *ptr, __u32 *off, __u8 *hdr_bytes_remaining,
> +                        __u32 *server_id)
> +{
> +       __u8 *tcp_opt, kind, hdr_len;
> +       __u8 *data;
> +
> +       data = bpf_dynptr_data(ptr, *off, sizeof(kind) + sizeof(hdr_len) +
> +                              sizeof(*server_id));
> +       if (!data)
> +               return -1;
> +
> +       kind = data[0];
> +
> +       if (kind == TCPOPT_EOL)
> +               return -1;
> +
> +       if (kind == TCPOPT_NOP) {
> +               *off += 1;
> +               /* continue to the next option */
> +               *hdr_bytes_remaining -= 1;
> +
> +               return 0;
> +       }
> +
> +       if (*hdr_bytes_remaining < 2)
> +               return -1;
> +
> +       hdr_len = data[1];
> +       if (hdr_len > *hdr_bytes_remaining)
> +               return -1;
> +
> +       if (kind == tcp_hdr_opt_kind_tpr) {
> +               if (hdr_len != tcp_hdr_opt_len_tpr)
> +                       return -1;
> +
> +               memcpy(server_id, (__u32 *)(data + 2), sizeof(*server_id));

this implicitly relies on compiler inlining memcpy, let's use
__builtint_memcpy() here instead to set a good example?

> +               return 1;
> +       }
> +
> +       *off += hdr_len;
> +       *hdr_bytes_remaining -= hdr_len;
> +
> +       return 0;
> +}
> +
> +SEC("xdp")
> +int xdp_ingress_v6(struct xdp_md *xdp)
> +{
> +       __u8 hdr_bytes_remaining;
> +       struct tcphdr *tcp_hdr;
> +       __u8 tcp_hdr_opt_len;
> +       int err = 0;
> +       __u32 off;
> +
> +       struct bpf_dynptr ptr;
> +
> +       bpf_dynptr_from_xdp(xdp, 0, &ptr);
> +
> +       off = sizeof(struct ethhdr) + sizeof(struct ipv6hdr);
> +
> +       tcp_hdr = bpf_dynptr_data(&ptr, off, sizeof(*tcp_hdr));
> +       if (!tcp_hdr)
> +               return XDP_DROP;
> +
> +       tcp_hdr_opt_len = (tcp_hdr->doff * 4) - sizeof(struct tcphdr);
> +       if (tcp_hdr_opt_len < tcp_hdr_opt_len_tpr)
> +               return XDP_DROP;
> +
> +       hdr_bytes_remaining = tcp_hdr_opt_len;
> +
> +       off += sizeof(struct tcphdr);
> +
> +       /* max number of bytes of options in tcp header is 40 bytes */
> +       for (int i = 0; i < tcp_hdr_opt_max_opt_checks; i++) {
> +               err = parse_hdr_opt(&ptr, &off, &hdr_bytes_remaining, &server_id);
> +
> +               if (err || !hdr_bytes_remaining)
> +                       break;
> +       }
> +
> +       if (!server_id)
> +               return XDP_DROP;
> +
> +       return XDP_PASS;
> +}

I'm not a networking BPF expert, but the logic of packet parsing here
looks pretty clean! Would it be possible to also backport original
code with data and data_end, both for testing but also to be able to
compare and contrast dynptr vs data/data_end approaches?


> diff --git a/tools/testing/selftests/bpf/progs/test_l4lb_noinline.c b/tools/testing/selftests/bpf/progs/test_l4lb_noinline.c
> index c8bc0c6947aa..1fef7868ea8b 100644
> --- a/tools/testing/selftests/bpf/progs/test_l4lb_noinline.c
> +++ b/tools/testing/selftests/bpf/progs/test_l4lb_noinline.c
> @@ -230,21 +230,18 @@ static __noinline bool get_packet_dst(struct real_definition **real,
>         return true;
>  }
>
> -static __noinline int parse_icmpv6(void *data, void *data_end, __u64 off,
> +static __noinline int parse_icmpv6(struct bpf_dynptr *skb_ptr, __u64 off,
>                                    struct packet_description *pckt)
>  {
>         struct icmp6hdr *icmp_hdr;
>         struct ipv6hdr *ip6h;
>
> -       icmp_hdr = data + off;
> -       if (icmp_hdr + 1 > data_end)
> +       icmp_hdr = bpf_dynptr_data(skb_ptr, off, sizeof(*icmp_hdr) + sizeof(*ip6h));
> +       if (!icmp_hdr)
>                 return TC_ACT_SHOT;
>         if (icmp_hdr->icmp6_type != ICMPV6_PKT_TOOBIG)
>                 return TC_ACT_OK;

previously you can still TC_ACT_OK if it's ICMPV6_PKT_TOOBIG even if
packet size is < sizeof(*icmp_hdr) + sizeof(*ip6h), which might have
been a bug, but current logic will enforce that packet is at least
sizeof(*icmp_hdr) + sizeof(*ip6h). Is that a problem?

> -       off += sizeof(struct icmp6hdr);
> -       ip6h = data + off;
> -       if (ip6h + 1 > data_end)
> -               return TC_ACT_SHOT;
> +       ip6h = (struct ipv6hdr *)(icmp_hdr + 1);
>         pckt->proto = ip6h->nexthdr;
>         pckt->flags |= F_ICMP;
>         memcpy(pckt->srcv6, ip6h->daddr.s6_addr32, 16);
> @@ -252,22 +249,19 @@ static __noinline int parse_icmpv6(void *data, void *data_end, __u64 off,
>         return TC_ACT_UNSPEC;
>  }
>
> -static __noinline int parse_icmp(void *data, void *data_end, __u64 off,
> +static __noinline int parse_icmp(struct bpf_dynptr *skb_ptr, __u64 off,
>                                  struct packet_description *pckt)
>  {
>         struct icmphdr *icmp_hdr;
>         struct iphdr *iph;
>
> -       icmp_hdr = data + off;
> -       if (icmp_hdr + 1 > data_end)
> +       icmp_hdr = bpf_dynptr_data(skb_ptr, off, sizeof(*icmp_hdr) + sizeof(*iph));
> +       if (!icmp_hdr)
>                 return TC_ACT_SHOT;
>         if (icmp_hdr->type != ICMP_DEST_UNREACH ||
>             icmp_hdr->code != ICMP_FRAG_NEEDED)
>                 return TC_ACT_OK;

similarly here, short packets can still be TC_ACT_OK in some
circumstances, while with dynptr they will be shot down early on. Not
saying this is wrong or bad, just bringing this up for you and others
to chime in if it's an ok change

> -       off += sizeof(struct icmphdr);
> -       iph = data + off;
> -       if (iph + 1 > data_end)
> -               return TC_ACT_SHOT;
> +       iph = (struct iphdr *)(icmp_hdr + 1);
>         if (iph->ihl != 5)
>                 return TC_ACT_SHOT;
>         pckt->proto = iph->protocol;
> @@ -277,13 +271,13 @@ static __noinline int parse_icmp(void *data, void *data_end, __u64 off,
>         return TC_ACT_UNSPEC;
>  }

[...]

> -static __always_inline int handle_ipv4(struct xdp_md *xdp)
> +static __always_inline int handle_ipv4(struct xdp_md *xdp, struct bpf_dynptr *xdp_ptr)
>  {
> -       void *data_end = (void *)(long)xdp->data_end;
> -       void *data = (void *)(long)xdp->data;
> +       struct bpf_dynptr new_xdp_ptr;
>         struct iptnl_info *tnl;
>         struct ethhdr *new_eth;
>         struct ethhdr *old_eth;
> -       struct iphdr *iph = data + sizeof(struct ethhdr);
> +       struct iphdr *iph;
>         __u16 *next_iph;
>         __u16 payload_len;
>         struct vip vip = {};
> @@ -90,10 +90,12 @@ static __always_inline int handle_ipv4(struct xdp_md *xdp)
>         __u32 csum = 0;
>         int i;
>
> -       if (iph + 1 > data_end)
> +       iph = bpf_dynptr_data(xdp_ptr, ethhdr_sz,
> +                             iphdr_sz + (tcphdr_sz > udphdr_sz ? tcphdr_sz : udphdr_sz));

tcphdr_sz (20) is always bigger than udphdr_sz (8), so just use the
bigger one here? Though again, for UDP packet it might be a bit too
pessimistic to reject small packets?

> +       if (!iph)
>                 return XDP_DROP;
>
> -       dport = get_dport(iph + 1, data_end, iph->protocol);
> +       dport = get_dport(iph + 1, iph->protocol);
>         if (dport == -1)
>                 return XDP_DROP;

[...]

> -static __always_inline int handle_ipv6(struct xdp_md *xdp)
> +static __always_inline int handle_ipv6(struct xdp_md *xdp, struct bpf_dynptr *xdp_ptr)
>  {
> -       void *data_end = (void *)(long)xdp->data_end;
> -       void *data = (void *)(long)xdp->data;
> +       struct bpf_dynptr new_xdp_ptr;
>         struct iptnl_info *tnl;
>         struct ethhdr *new_eth;
>         struct ethhdr *old_eth;
> -       struct ipv6hdr *ip6h = data + sizeof(struct ethhdr);
> +       struct ipv6hdr *ip6h;
>         __u16 payload_len;
>         struct vip vip = {};
>         int dport;
>
> -       if (ip6h + 1 > data_end)
> +       ip6h = bpf_dynptr_data(xdp_ptr, ethhdr_sz,
> +                              ipv6hdr_sz + (tcphdr_sz > udphdr_sz ? tcphdr_sz : udphdr_sz));

ditto, there is no dynamism here, verifier actually enforces that this
value is statically known, I think this example will create false
assumptions if written this way

> +       if (!ip6h)
>                 return XDP_DROP;
>
> -       dport = get_dport(ip6h + 1, data_end, ip6h->nexthdr);
> +       dport = get_dport(ip6h + 1, ip6h->nexthdr);
>         if (dport == -1)
>                 return XDP_DROP;
>

[...]
