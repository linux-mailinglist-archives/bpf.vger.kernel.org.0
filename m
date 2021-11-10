Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9098444BAE7
	for <lists+bpf@lfdr.de>; Wed, 10 Nov 2021 05:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbhKJEww (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Nov 2021 23:52:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbhKJEwv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Nov 2021 23:52:51 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 913F4C061764
        for <bpf@vger.kernel.org>; Tue,  9 Nov 2021 20:50:04 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id j75so3265181ybj.6
        for <bpf@vger.kernel.org>; Tue, 09 Nov 2021 20:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dB37vn5Roetqn2UtqpRldyxRNbjfg7uFahNOQHU9h/0=;
        b=GnXExS5+T11yZa4WNJvw2015657OHNq0OBgFfjHv+kLKQWqj9B9MmhoeTd570bsKWv
         z2W4ZHcaPNNmx0SVSZ9K8KMftDfFoAXMoUu24j1psEPCh2SSmOakxZabR4hq+E9US0Dd
         6XZlwT/iQ6bJSMXeOeWHpO1RCCQ6HECB+mC0p6fDEaWWKzCUFFclSC/TBEt+8ZNO2OfN
         FrPjvq6OGnyML4LI87cAQmbrqbzmhnOnQ1NJHHCh0yr3qrzm1rVuIA/1J0Ou57tRj3bV
         pKZu0MFoz46ayYmkRiC9juhYzgSTp5ZGx+WpvZvaobk8SKjOUXPvMWnqryzdbrzhYoFG
         KN9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dB37vn5Roetqn2UtqpRldyxRNbjfg7uFahNOQHU9h/0=;
        b=XptZOsWqzx3B/Un6FmprYtW0SeeQ4IgMmglxg2Nx2RlWlkU07PzJe2NCWcHErU5ard
         rf+yglRuH4RnE6sGeHNmavl9mWJB3cVvrZAYCPokjl9EYPsGl7IbEWr8DE5x7THVAUhW
         9CIw4O6VwTv8NE3bqCS6PMAOejFOGCCFXsowbPTiQ+hodlxZIWRGzjf8dWoWORiyUrXd
         nxOvdnUG8rbaAeuGYSk0C7vQ8tHsP+M11X6mHdRTfLTMF3hUL52twxfwoyeqOxWhzWxC
         zSckBGbbWRxc2QszV76slMZpj+z6PWmNn4hDu6rGHCQ4tsWXSpCj1Tq7vXezUTcKuT8a
         Cfwg==
X-Gm-Message-State: AOAM530nhgLrSrGFISaqINhyZQoMRZhCDVrBMopYgy2DDa4HmNZlP37z
        zQnbq7Cg1zshhTRMZSOpYIbzRR+jucLDwuyHgiM=
X-Google-Smtp-Source: ABdhPJxFhoo+L1uL3/teRAKfzHZWDxjPAtl5NuGMdFRn5E1mQ+zsuFwGnB7MyWq/bDCqZwf0mWDbtTuw3dJdx9VGa54=
X-Received: by 2002:a25:cc4c:: with SMTP id l73mr14898167ybf.114.1636519803661;
 Tue, 09 Nov 2021 20:50:03 -0800 (PST)
MIME-Version: 1.0
References: <20211109003052.3499225-1-haoluo@google.com> <20211109003052.3499225-4-haoluo@google.com>
In-Reply-To: <20211109003052.3499225-4-haoluo@google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 9 Nov 2021 20:49:52 -0800
Message-ID: <CAEf4Bzb6t7jWEj5o81A+9JcTkPWzqHS_AgNFo188gLV1dR=DsQ@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 3/3] bpf/selftests: Test PTR_TO_RDONLY_MEM
To:     Hao Luo <haoluo@google.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 8, 2021 at 4:31 PM Hao Luo <haoluo@google.com> wrote:
>
> This test verifies that a ksym of non-struct can not be directly
> updated.
>
> Signed-off-by: Hao Luo <haoluo@google.com>
> ---

Love the simplicity of the test.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  Changes since v2:
>   - Rebase
>
>  Changes since v1:
>   - Replaced CHECK() with ASSERT_ERR_PTR()
>   - Commented in the test for the reason of verification failure.
>
>  .../selftests/bpf/prog_tests/ksyms_btf.c      | 14 +++++++++
>  .../bpf/progs/test_ksyms_btf_write_check.c    | 29 +++++++++++++++++++
>  2 files changed, 43 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/test_ksyms_btf_write_check.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/ksyms_btf.c b/tools/testing/selftests/bpf/prog_tests/ksyms_btf.c
> index 79f6bd1e50d6..f6933b06daf8 100644
> --- a/tools/testing/selftests/bpf/prog_tests/ksyms_btf.c
> +++ b/tools/testing/selftests/bpf/prog_tests/ksyms_btf.c
> @@ -8,6 +8,7 @@
>  #include "test_ksyms_btf_null_check.skel.h"
>  #include "test_ksyms_weak.skel.h"
>  #include "test_ksyms_weak.lskel.h"
> +#include "test_ksyms_btf_write_check.skel.h"
>
>  static int duration;
>
> @@ -137,6 +138,16 @@ static void test_weak_syms_lskel(void)
>         test_ksyms_weak_lskel__destroy(skel);
>  }
>
> +static void test_write_check(void)
> +{
> +       struct test_ksyms_btf_write_check *skel;
> +
> +       skel = test_ksyms_btf_write_check__open_and_load();
> +       ASSERT_ERR_PTR(skel, "unexpected load of a prog writing to ksym memory\n");
> +
> +       test_ksyms_btf_write_check__destroy(skel);
> +}
> +
>  void test_ksyms_btf(void)
>  {
>         int percpu_datasec;
> @@ -167,4 +178,7 @@ void test_ksyms_btf(void)
>
>         if (test__start_subtest("weak_ksyms_lskel"))
>                 test_weak_syms_lskel();
> +
> +       if (test__start_subtest("write_check"))
> +               test_write_check();
>  }
> diff --git a/tools/testing/selftests/bpf/progs/test_ksyms_btf_write_check.c b/tools/testing/selftests/bpf/progs/test_ksyms_btf_write_check.c
> new file mode 100644
> index 000000000000..2180c41cd890
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_ksyms_btf_write_check.c
> @@ -0,0 +1,29 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2021 Google */
> +
> +#include "vmlinux.h"
> +
> +#include <bpf/bpf_helpers.h>
> +
> +extern const int bpf_prog_active __ksym; /* int type global var. */
> +
> +SEC("raw_tp/sys_enter")
> +int handler(const void *ctx)
> +{
> +       int *active;
> +       __u32 cpu;
> +
> +       cpu = bpf_get_smp_processor_id();
> +       active = (int *)bpf_per_cpu_ptr(&bpf_prog_active, cpu);
> +       if (active) {
> +               /* Kernel memory obtained from bpf_{per,this}_cpu_ptr
> +                * is read-only, should _not_ pass verification.
> +                */
> +               /* WRITE_ONCE */
> +               *(volatile int *)active = -1;
> +       }
> +
> +       return 0;
> +}
> +
> +char _license[] SEC("license") = "GPL";
> --
> 2.34.0.rc0.344.g81b53c2807-goog
>
