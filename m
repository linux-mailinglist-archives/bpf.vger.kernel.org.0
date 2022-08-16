Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7625964AF
	for <lists+bpf@lfdr.de>; Tue, 16 Aug 2022 23:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237159AbiHPVeu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Aug 2022 17:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236381AbiHPVes (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Aug 2022 17:34:48 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B211D8B99E
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 14:34:47 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id j6so9134061qkl.10
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 14:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=lXMwEDyt7vS4GynB/11lwmMlekMHRfQ+v8KOaIJZsic=;
        b=LDK1W9/1VrND1LXe+Sy8HeIyWdwI69L6SsAq8IMI9Uroi1NRPu+5b6uk+KZQ6UxIk4
         045uMKy54FX6DR151prv3brtZ2IB2jFilVRLtg8LbE0fqzSz4A41FfekMnruMSX1YC8M
         zjKvFsOfPA2D0HXLEE71fPcjQIYOGa5WC8DkcuVrtBXYjYGj+Fo9x15kSP89v/OHblnY
         gKKkCU4sbSDF2MhIu49zlHwHSDJuDu6mEeNkglN5t44aLvnnqGxQgUkF3TtyZWv8qSJz
         LV8Sxj5iss34vty5A6mr8AgyYPSR7XdEjoOgRMyugNVRqjdPprWGLOmcNotqKrNZvqPg
         m0Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=lXMwEDyt7vS4GynB/11lwmMlekMHRfQ+v8KOaIJZsic=;
        b=6wualIBHOBz5p2OJcK872VjZwBhXRAqSrt9WFaI1Kn2ZSbUUQI64ty6GCo+f4yOqbe
         pbODr0Tt89KBnz4yyRUDVA91+XYWvhyDjbIMhiUpaUsQaVtJjL1HKDI7OAQ7mK+bv2NW
         PUKn7xG0nl/7SHPrpgtBOdKOMvuW248sXGaT65pErseASUEmjtS2HitSllrK/ruJWCmb
         8Y+i200Q2VzIVWBpSmYSqlLaLKKcDcNWkN03hkB1oI3vsIOKRRsEcdY5zGzhK6S+EwAS
         MJiSqJWJxLWKbboKTfcBDQc3a3KjUKxKQbU7fJpW9jXeK77wBsy1edyeNCGxXonsxcLy
         9dEg==
X-Gm-Message-State: ACgBeo2N03RSOZgezU4uWPiS7SJkVGQbYOLVfA81IRHac6qZgjXinHWr
        QIrpE3MYliNOoUV6Fy+L2SztWeCSbd79ot5NSGjfkPXN5XHnSg==
X-Google-Smtp-Source: AA6agR5fhLbDvjiNTVDHyYkr/5ryoIhCpXCrkfStQcMF0Jn0eQpP6z/3sJm79kBSnEooCMZOyPboRLsSdCz/glU0hy4=
X-Received: by 2002:a37:41d5:0:b0:6bb:856a:42ac with SMTP id
 o204-20020a3741d5000000b006bb856a42acmr1548634qka.583.1660685686688; Tue, 16
 Aug 2022 14:34:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220816001929.369487-1-andrii@kernel.org> <20220816001929.369487-5-andrii@kernel.org>
In-Reply-To: <20220816001929.369487-5-andrii@kernel.org>
From:   Hao Luo <haoluo@google.com>
Date:   Tue, 16 Aug 2022 14:34:36 -0700
Message-ID: <CA+khW7jdztV3XgdVJy7t8jwr8iheTMjQMYnioLBVX3xxBRRKjw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/4] selftests/bpf: few fixes for selftests/bpf
 built in release mode
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 15, 2022 at 8:52 PM Andrii Nakryiko <andrii@kernel.org> wrote:
>
> Fix few issues found when building and running test_progs in release
> mode.
>
> First, potentially uninitialized idx variable in xskxceiver,
> force-initialize to zero to satisfy compiler.
>
> Few instances of defining uprobe trigger functions break in release mode
> unless marked as noinline, due to being static. Add noinline to make
> sure everything works.
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

I can't say for the noinline change, I trust it works. The fix for
uninitialized use looks good to me.

Acked-by: Hao Luo <haoluo@google.com>


>  tools/testing/selftests/bpf/prog_tests/attach_probe.c | 6 +++---
>  tools/testing/selftests/bpf/prog_tests/bpf_cookie.c   | 2 +-
>  tools/testing/selftests/bpf/prog_tests/task_pt_regs.c | 2 +-
>  tools/testing/selftests/bpf/xskxceiver.c              | 2 +-
>  4 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/attach_probe.c b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
> index 0b899d2d8ea7..9566d9d2f6ee 100644
> --- a/tools/testing/selftests/bpf/prog_tests/attach_probe.c
> +++ b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
> @@ -6,19 +6,19 @@
>  volatile unsigned short uprobe_ref_ctr __attribute__((unused)) __attribute((section(".probes")));
>
>  /* uprobe attach point */
> -static void trigger_func(void)
> +static noinline void trigger_func(void)
>  {
>         asm volatile ("");
>  }
>
>  /* attach point for byname uprobe */
> -static void trigger_func2(void)
> +static noinline void trigger_func2(void)
>  {
>         asm volatile ("");
>  }
>
>  /* attach point for byname sleepable uprobe */
> -static void trigger_func3(void)
> +static noinline void trigger_func3(void)
>  {
>         asm volatile ("");
>  }
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
> index 2974b44f80fa..2be2d61954bc 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
> @@ -13,7 +13,7 @@
>  #include "kprobe_multi.skel.h"
>
>  /* uprobe attach point */
> -static void trigger_func(void)
> +static noinline void trigger_func(void)
>  {
>         asm volatile ("");
>  }
> diff --git a/tools/testing/selftests/bpf/prog_tests/task_pt_regs.c b/tools/testing/selftests/bpf/prog_tests/task_pt_regs.c
> index 61935e7e056a..f000734a3d1f 100644
> --- a/tools/testing/selftests/bpf/prog_tests/task_pt_regs.c
> +++ b/tools/testing/selftests/bpf/prog_tests/task_pt_regs.c
> @@ -4,7 +4,7 @@
>  #include "test_task_pt_regs.skel.h"
>
>  /* uprobe attach point */
> -static void trigger_func(void)
> +static noinline void trigger_func(void)
>  {
>         asm volatile ("");
>  }
> diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
> index 20b44ab32a06..14b4737b223c 100644
> --- a/tools/testing/selftests/bpf/xskxceiver.c
> +++ b/tools/testing/selftests/bpf/xskxceiver.c
> @@ -922,7 +922,7 @@ static int __send_pkts(struct ifobject *ifobject, u32 *pkt_nb, struct pollfd *fd
>  {
>         struct xsk_socket_info *xsk = ifobject->xsk;
>         bool use_poll = ifobject->use_poll;
> -       u32 i, idx, ret, valid_pkts = 0;
> +       u32 i, idx = 0, ret, valid_pkts = 0;
>
>         while (xsk_ring_prod__reserve(&xsk->tx, BATCH_SIZE, &idx) < BATCH_SIZE) {
>                 if (use_poll) {
> --
> 2.30.2
>
