Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D26658F4D2
	for <lists+bpf@lfdr.de>; Thu, 11 Aug 2022 01:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233687AbiHJX0Z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Aug 2022 19:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233626AbiHJX0Y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Aug 2022 19:26:24 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917CE7B7AC;
        Wed, 10 Aug 2022 16:26:23 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id x2so3015806ilp.10;
        Wed, 10 Aug 2022 16:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=ZWG0Pplx8o3vWqJcu5N5Rp9ELa1xjLQiL3hpegwnr1I=;
        b=H2OYenAG2+KJR3IyeJVLiRVGw9bcGJwfpolvXYZXJVHmXcjEBatHuOKq46aCoAQNLv
         GyP42AURQfkEOuhsZeo4Joq1d+b9WidU1HzjaLpStNuQzGRWG/vXTwsdrFFcJTLHdySU
         TkD+qB5DxMzkT6Xp5ePoKL1AyOIRCRnJXCHPaoMpOtRzvlKTxiXS3FVJrs+GH9z2/nKo
         H5jU2L90uinfUEuADoseVVsvmpOJtmOEEWYahi/m9sjlelrlUImJTkbt++8kdKPoIY1A
         Qf4FTlds9zArEOGH4F/dGVpYvrHF1xS/B1+BfFtSNjTX6vHUASRInLqtKrIrPfCD+pel
         q6XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ZWG0Pplx8o3vWqJcu5N5Rp9ELa1xjLQiL3hpegwnr1I=;
        b=iSVW/YlmEFUxwe6oFWcxNe6JIOQK4wZQIZSXi8ijmeGUsa+UPpaBBSxHsZxThbB8q+
         3hgGwF88QeCkApPzq6/G1Uccto6D3y2B5WEqiMuASShIzB79SMlBqwSRnr03NXCcSrlz
         j5JrdShsaRXPncDEVVFm2NFqj4QTRypspgqVLuv5sRocHqyY9JKNFnhbe5odUfCejXnF
         VwkLxoPHp6N6eA3LFiWgXwEm+hUe509V6etKU47+RjZIExv5dzI9S88bZcf1fY2m5QwC
         niUWxsfBABz4VXL0b9vMd8qwRcUfMRyMiogJfC+N/LWwuBwhd4wddWR8BahWI5kNCmDe
         W2iQ==
X-Gm-Message-State: ACgBeo3XA6Fppa61vbgqrnm0oJr+bg5bdulHCaqdclvX3QnJ8GZ5cayl
        NAiVeocKY1lRPHT79zcCrUHRJ1QMPHN8NItaCsJpBGpN
X-Google-Smtp-Source: AA6agR6CxGmAs2M5Lq1KuJdo6O8i149G0FC0fNmGz0gS3OiWDA9ijhUpfFMuNKKdT72bCKe5Grdo9VG7eLB5GEqCukU=
X-Received: by 2002:a05:6e02:218c:b0:2e0:c966:a39d with SMTP id
 j12-20020a056e02218c00b002e0c966a39dmr9536232ila.216.1660173982972; Wed, 10
 Aug 2022 16:26:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1660173222.git.dxu@dxuuu.xyz> <d82d4a001572e2f29cc0537563c3ef74b1351480.1660173222.git.dxu@dxuuu.xyz>
In-Reply-To: <d82d4a001572e2f29cc0537563c3ef74b1351480.1660173222.git.dxu@dxuuu.xyz>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Thu, 11 Aug 2022 01:25:46 +0200
Message-ID: <CAP01T76R=rCL7YEeMyDfM_HLvfNDY=Khh0FPToB08x4cD6LZhw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/3] selftests/bpf: Add existing connection
 bpf_*_ct_lookup() test
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 11 Aug 2022 at 01:16, Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> Add a test where we do a conntrack lookup on an existing connection.
> This is nice because it's a more realistic test than artifically
> creating a ct entry and looking it up afterwards.
>
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---
>  .../testing/selftests/bpf/prog_tests/bpf_nf.c | 59 +++++++++++++++++++
>  .../testing/selftests/bpf/progs/test_bpf_nf.c | 18 ++++++
>  2 files changed, 77 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_nf.c b/tools/testing/selftests/bpf/prog_tests/bpf_nf.c
> index 7a74a1579076..317978cac029 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_nf.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_nf.c
> @@ -24,10 +24,34 @@ enum {
>         TEST_TC_BPF,
>  };
>
> +#define TIMEOUT_MS 3000
> +
> +static int connect_to_server(int srv_fd)
> +{
> +       int fd = -1;
> +
> +       fd = socket(AF_INET, SOCK_STREAM, 0);
> +       if (!ASSERT_GE(fd, 0, "socket"))
> +               goto out;
> +
> +       if (CHECK_FAIL(connect_fd_to_fd(fd, srv_fd, TIMEOUT_MS))) {

CHECK_FAIL is deprecated, please consider using ASSERT_*. Sorry for
not catching this before your respin...

> +               close(fd);
> +               fd = -1;
> +       }
> +out:
> +       return fd;
> +}
> +
>  static void test_bpf_nf_ct(int mode)
>  {
> +       const char *iptables = "iptables -t raw %s PREROUTING -j CT";
> +       int srv_fd = -1, client_fd = -1, srv_client_fd = -1;
> +       struct sockaddr_in peer_addr = {};
>         struct test_bpf_nf *skel;
>         int prog_fd, err;
> +       socklen_t len;
> +       u16 srv_port;
> +       char cmd[64];
>         LIBBPF_OPTS(bpf_test_run_opts, topts,
>                 .data_in = &pkt_v4,
>                 .data_size_in = sizeof(pkt_v4),
> @@ -38,6 +62,32 @@ static void test_bpf_nf_ct(int mode)
>         if (!ASSERT_OK_PTR(skel, "test_bpf_nf__open_and_load"))
>                 return;
>
> +       /* Enable connection tracking */
> +       snprintf(cmd, sizeof(cmd), iptables, "-A");
> +       if (!ASSERT_OK(system(cmd), "iptables"))
> +               goto end;
> +
> +       srv_port = (mode == TEST_XDP) ? 5005 : 5006;
> +       srv_fd = start_server(AF_INET, SOCK_STREAM, "127.0.0.1", srv_port, TIMEOUT_MS);
> +       if (!ASSERT_GE(srv_fd, 0, "start_server"))
> +               goto end;
> +
> +       client_fd = connect_to_server(srv_fd);
> +       if (!ASSERT_GE(client_fd, 0, "connect_to_server"))
> +               goto end;
> +
> +       len = sizeof(peer_addr);
> +       srv_client_fd = accept(srv_fd, (struct sockaddr *)&peer_addr, &len);
> +       if (!ASSERT_GE(srv_client_fd, 0, "accept"))
> +               goto end;
> +       if (!ASSERT_EQ(len, sizeof(struct sockaddr_in), "sockaddr len"))
> +               goto end;
> +
> +       skel->bss->saddr = peer_addr.sin_addr.s_addr;
> +       skel->bss->sport = peer_addr.sin_port;
> +       skel->bss->daddr = peer_addr.sin_addr.s_addr;
> +       skel->bss->dport = htons(srv_port);
> +
>         if (mode == TEST_XDP)
>                 prog_fd = bpf_program__fd(skel->progs.nf_xdp_ct_test);
>         else
> @@ -63,7 +113,16 @@ static void test_bpf_nf_ct(int mode)
>         ASSERT_LE(skel->bss->test_delta_timeout, 10, "Test for max ct timeout update");
>         /* expected status is IPS_SEEN_REPLY */
>         ASSERT_EQ(skel->bss->test_status, 2, "Test for ct status update ");
> +       ASSERT_EQ(skel->data->test_exist_lookup, 0, "Test existing connection lookup");
>  end:
> +       if (srv_client_fd != -1)
> +               close(srv_client_fd);
> +       if (client_fd != -1)
> +               close(client_fd);
> +       if (srv_fd != -1)
> +               close(srv_fd);
> +       snprintf(cmd, sizeof(cmd), iptables, "-D");
> +       system(cmd);
>         test_bpf_nf__destroy(skel);
>  }
>
> diff --git a/tools/testing/selftests/bpf/progs/test_bpf_nf.c b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
> index 196cd8dfe42a..84e0fd479794 100644
> --- a/tools/testing/selftests/bpf/progs/test_bpf_nf.c
> +++ b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
> @@ -23,6 +23,11 @@ int test_insert_entry = -EAFNOSUPPORT;
>  int test_succ_lookup = -ENOENT;
>  u32 test_delta_timeout = 0;
>  u32 test_status = 0;
> +__be32 saddr = 0;
> +__be16 sport = 0;
> +__be32 daddr = 0;
> +__be16 dport = 0;
> +int test_exist_lookup = -ENOENT;
>
>  struct nf_conn;
>
> @@ -160,6 +165,19 @@ nf_ct_test(struct nf_conn *(*lookup_fn)(void *, struct bpf_sock_tuple *, u32,
>                 }
>                 test_alloc_entry = 0;
>         }
> +
> +       bpf_tuple.ipv4.saddr = saddr;
> +       bpf_tuple.ipv4.daddr = daddr;
> +       bpf_tuple.ipv4.sport = sport;
> +       bpf_tuple.ipv4.dport = dport;
> +       ct = lookup_fn(ctx, &bpf_tuple, sizeof(bpf_tuple.ipv4), &opts_def,
> +                      sizeof(opts_def));
> +       if (ct) {
> +               test_exist_lookup = 0;
> +               bpf_ct_release(ct);
> +       } else {
> +               test_exist_lookup = opts_def.error;
> +       }
>  }
>
>  SEC("xdp")
> --
> 2.37.1
>
