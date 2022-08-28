Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 100F35A4018
	for <lists+bpf@lfdr.de>; Mon, 29 Aug 2022 00:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbiH1WsS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 28 Aug 2022 18:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiH1WsS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 28 Aug 2022 18:48:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353F421825
        for <bpf@vger.kernel.org>; Sun, 28 Aug 2022 15:48:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E91F9B80B72
        for <bpf@vger.kernel.org>; Sun, 28 Aug 2022 22:48:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EBD3C43470
        for <bpf@vger.kernel.org>; Sun, 28 Aug 2022 22:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661726894;
        bh=g4sSnE2xYkVAH8p7YGEDwc0bgpH1kc7LW9IpFl3JMhI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KtYMar74Ys0rcLltG1bQpUFMAtQGmX7mnKw5qDqg6w2/3L/fQL8ceFEzYQ7B3yLPD
         aaTXFz9ahVpWNY3tiawn6ENGJZGLOwImOpYGTk8yQU0slYxEg4lyMwhvkbrIuCsNmU
         IW00+QfxnU5SakXBG3QA0oQIuIRRsoROLOxxddNmROvfh8otH1CAwLV5ZScjBQDq0j
         J2STxqt3c6acjVyJQILwUu3eemOkKNYNXipXCWIH2x8wt1FRd4JFeNf9M8RBbARVMK
         wsOMVwzSUN2sojbkbiudjC6HipPSRMXzlT0HZvbti7Qo9DGV61kU4WSAnoiccyFDSP
         U8GHZEdChsWlA==
Received: by mail-qv1-f52.google.com with SMTP id w4so4900177qvs.4
        for <bpf@vger.kernel.org>; Sun, 28 Aug 2022 15:48:14 -0700 (PDT)
X-Gm-Message-State: ACgBeo2pbuHac+rwE11BDAhgBOpdAS2VOw2qhhSlAfGJfXzvKO27Jjuq
        Le84kJD9uCE9z9IOaQFNxo3XVjcv9du+nuTxZ7Iadg==
X-Google-Smtp-Source: AA6agR5QwYDSIvZe1n0t8kgFBzOmEQNQ0HrKZTPaAvPccIxMfhORuFh2IdPmF2qbGbdMTM8R+3knEFp2Z+SbHkrC+TM=
X-Received: by 2002:a0c:b342:0:b0:498:ef25:abe5 with SMTP id
 a2-20020a0cb342000000b00498ef25abe5mr8412484qvf.21.1661726893619; Sun, 28 Aug
 2022 15:48:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220826230639.1249436-1-yosryahmed@google.com>
In-Reply-To: <20220826230639.1249436-1-yosryahmed@google.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Mon, 29 Aug 2022 00:48:02 +0200
X-Gmail-Original-Message-ID: <CACYkzJ4=YCZ-rwBdjm59zff-M9q103m6yTnm7da1znbAGX2Ojw@mail.gmail.com>
Message-ID: <CACYkzJ4=YCZ-rwBdjm59zff-M9q103m6yTnm7da1znbAGX2Ojw@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: simplify cgroup_hierarchical_stats selftest
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Mykola Lysenko <mykolal@fb.com>, Song Liu <song@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Aug 27, 2022 at 1:06 AM Yosry Ahmed <yosryahmed@google.com> wrote:
>
> The cgroup_hierarchical_stats selftest is complicated. It has to be,
> because it tests an entire workflow of recording, aggregating, and
> dumping cgroup stats. However, some of the complexity is unnecessary.
> The test now enables the memory controller in a cgroup hierarchy, invokes
> reclaim, measure reclaim time, THEN uses that reclaim time to test the
> stats collection and aggregation. We don't need to use such a
> complicated stat, as the context in which the stat is collected is
> orthogonal.
>
> Simplify the test by using a simple stat instead of reclaim time, the
> total number of times a process has ever entered a cgroup. This makes
> the test simpler and removes the dependency on the memory controller and
> the memory reclaim interface.
>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Acked-by: KP Singh <kpsingh@kernel.org>

> ---
>
> When the test failed on Alexei's setup because the memory controller was
> not enabled I realized this is an unnecessary dependency for the test,
> which inspired this patch :) I am not sure if this prompt a Fixes tag as
> the test wasn't broken.

yeah, this is an improvement, I don't think a fixes tag is needed here.

>
> ---
>  .../prog_tests/cgroup_hierarchical_stats.c    | 157 ++++++---------
>  .../bpf/progs/cgroup_hierarchical_stats.c     | 181 ++++++------------
>  2 files changed, 118 insertions(+), 220 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_hierarchical_stats.c b/tools/testing/selftests/bpf/prog_tests/cgroup_hierarchical_stats.c
> index bed1661596f7..12a6d4ddbd77 100644
> --- a/tools/testing/selftests/bpf/prog_tests/cgroup_hierarchical_stats.c
> +++ b/tools/testing/selftests/bpf/prog_tests/cgroup_hierarchical_stats.c
> @@ -1,6 +1,9 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
> - * Functions to manage eBPF programs attached to cgroup subsystems
> + * This test runs a BPF program that keeps a stat of the number of processes
> + * that ever attached to a cgroup, and makes sure that BPF integrates well with
> + * the rstat framework to efficiently collect those stat percpu to avoid
> + * locking, and to efficiently aggregate the stat across the hierarchy.
>   *
>   * Copyright 2022 Google LLC.
>   */
> @@ -21,8 +24,10 @@
>  #define PAGE_SIZE 4096
>  #define MB(x) (x << 20)
>
> +#define PROCESSES_PER_CGROUP 3
> +
>  #define BPFFS_ROOT "/sys/fs/bpf/"
> -#define BPFFS_VMSCAN BPFFS_ROOT"vmscan/"
> +#define BPFFS_ATTACH_COUNTERS BPFFS_ROOT"attach_counters/"

minor nit: Is there a missing space here?
i.e

#define BPFFS_ATTACH_COUNTERS BPFFS_ROOT "attach_counters/"

(this was a case in the line you changed so I am not sure if it's intentional)

The rest looks good to me, so  maintainers could, potentially, push it
with the minor edit if needed?


>
>  #define CG_ROOT_NAME "root"
>  #define CG_ROOT_ID 1
> @@ -79,7 +84,7 @@ static int setup_bpffs(void)
>                 return err;
>
>

[...]

> -       return 1;
> +       return 0;
>  }
> --
> 2.37.2.672.g94769d06f0-goog
>
