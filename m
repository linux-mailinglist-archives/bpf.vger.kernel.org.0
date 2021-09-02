Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C68A3FF546
	for <lists+bpf@lfdr.de>; Thu,  2 Sep 2021 23:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242415AbhIBVGJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Sep 2021 17:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234242AbhIBVGJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Sep 2021 17:06:09 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963C3C061575;
        Thu,  2 Sep 2021 14:05:10 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id b10so4290891ioq.9;
        Thu, 02 Sep 2021 14:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=Rki0Xa8doRs4Csl7X3HY7teBc3htHoj8qmA3lDoXuaw=;
        b=I/Zb+qO1RFB66XF5xSjmYnWVrg33UJrahZqeDLi5NEG5s+Nlmu6Jr9Gcq7d0HwYx20
         zZ09WlYaOxnjf4fWbWQX4z4CGeqAPXxt9rqV0RFIF2zNugFlfcFEFzUfNPUQA1FpYrvL
         EnqH1p+BHHyeD032Bga9dhfRnNrOyWrO8CK+ZvETTySnCiAoZyK9co86MQ1TiUEerun4
         dar1yB4G7RouUQllRtBvXV26bAgJch/FNG0427ZBgQAP3hwVTlHoh5hU0AYtIYazXe6r
         zNPHw6PtboUndjJYmLhcRqnKmesjX/ilJ+Ad4Fu1ZlpCC4HstZe0dKH+KTJCA2fLkXDW
         WQBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=Rki0Xa8doRs4Csl7X3HY7teBc3htHoj8qmA3lDoXuaw=;
        b=AqkcELkzjFz7OCNbbI7nszn12pfbFMKptFNz8F8MnqT92ZtIwbk3dQ3x+xs+oBuGiC
         QQy7BVnyTEqHLEPCYE3McLlOG3/l+hBwrWzIjJdntPEkAMBYHIXOzuEAjUNzh4yNQTx2
         cmsgo+gYfoa/TS1slMnG/c0RBqzMJGNB7uyOJCVfGuO0kolCluOvNLw9u2OscoC3vrMd
         9z9fdgG2a14OK06JvCdtMARIYZCZLOF0xx/PlH0zYVqnSnQWBALc+3Mehyl7v0ioXK5s
         113/THdkhA6c1kLGABwIND78321eJcTUT+9gzny6cTtTu4vQGKlmQa9e3GIZp/oTE1yW
         32iA==
X-Gm-Message-State: AOAM5334AKsPkxb1sr3kXdkvwm5MavnvC17a8rPNzQBXga+t0Db0OHHJ
        rs+f9giyTAI89X+zaG93j7w=
X-Google-Smtp-Source: ABdhPJyhVJBVLeACV9vJagTAi+U0OV47ef9Pm69G9DQJki8KoLF1GIdUk9yYbDyFZ7msSA4lDpjHvQ==
X-Received: by 2002:a05:6602:2cc5:: with SMTP id j5mr279545iow.156.1630616710040;
        Thu, 02 Sep 2021 14:05:10 -0700 (PDT)
Received: from localhost ([172.243.157.240])
        by smtp.gmail.com with ESMTPSA id c25sm1596362iom.9.2021.09.02.14.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 14:05:09 -0700 (PDT)
Date:   Thu, 02 Sep 2021 14:05:02 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Song Liu <songliubraving@fb.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        kjain@linux.ibm.com, kernel-team@fb.com,
        Song Liu <songliubraving@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>
Message-ID: <61313c7eb16ba_2c56f208d9@john-XPS-13-9370.notmuch>
In-Reply-To: <20210902165706.2812867-4-songliubraving@fb.com>
References: <20210902165706.2812867-1-songliubraving@fb.com>
 <20210902165706.2812867-4-songliubraving@fb.com>
Subject: RE: [PATCH v5 bpf-next 3/3] selftests/bpf: add test for
 bpf_get_branch_snapshot
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Song Liu wrote:
> This test uses bpf_get_branch_snapshot from a fexit program. The test uses
> a target function (bpf_testmod_loop_test) and compares the record against
> kallsyms. If there isn't enough record matching kallsyms, the test fails.
> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Song Liu <songliubraving@fb.com>
> ---
>  .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  19 +++-
>  .../selftests/bpf/prog_tests/core_reloc.c     |  14 +--
>  .../bpf/prog_tests/get_branch_snapshot.c      | 100 ++++++++++++++++++
>  .../selftests/bpf/prog_tests/module_attach.c  |  39 -------
>  .../selftests/bpf/progs/get_branch_snapshot.c |  40 +++++++
>  tools/testing/selftests/bpf/test_progs.c      |  39 +++++++
>  tools/testing/selftests/bpf/test_progs.h      |   2 +
>  tools/testing/selftests/bpf/trace_helpers.c   |  37 +++++++
>  tools/testing/selftests/bpf/trace_helpers.h   |   5 +
>  9 files changed, 243 insertions(+), 52 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/get_branch_snapshot.c
>  create mode 100644 tools/testing/selftests/bpf/progs/get_branch_snapshot.c
> 

[...]

> diff --git a/tools/testing/selftests/bpf/progs/get_branch_snapshot.c b/tools/testing/selftests/bpf/progs/get_branch_snapshot.c
> new file mode 100644
> index 0000000000000..a1b139888048c
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/get_branch_snapshot.c
> @@ -0,0 +1,40 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2021 Facebook */
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +char _license[] SEC("license") = "GPL";
> +
> +__u64 test1_hits = 0;
> +__u64 address_low = 0;
> +__u64 address_high = 0;
> +int wasted_entries = 0;
> +long total_entries = 0;
> +
> +#define ENTRY_CNT 32
> +struct perf_branch_entry entries[ENTRY_CNT] = {};

It looks like perf_branch_entry has never changed, but it could grow?
Then size check in helper would fail. I'm not sure its worth it, but
this could be done with CO-RE so the size is correct even if the
struct grows.

> +
> +static inline bool in_range(__u64 val)
> +{
> +	return (val >= address_low) && (val < address_high);
> +}
> +
> +SEC("fexit/bpf_testmod_loop_test")
> +int BPF_PROG(test1, int n, int ret)
> +{
> +	long i;
> +
> +	total_entries = bpf_get_branch_snapshot(entries, sizeof(entries), 0);
> +	total_entries /= sizeof(struct perf_branch_entry);
> +
> +	for (i = 0; i < ENTRY_CNT; i++) {
> +		if (i >= total_entries)
> +			break;
> +		if (in_range(entries[i].from) && in_range(entries[i].to))
> +			test1_hits++;
> +		else if (!test1_hits)
> +			wasted_entries++;
> +	}
> +	return 0;
> +}

Other than small comment LGTM.

Acked-by: John Fastabend <john.fastabend@gmail.com>
