Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 664853DE150
	for <lists+bpf@lfdr.de>; Mon,  2 Aug 2021 23:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbhHBVRj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 2 Aug 2021 17:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbhHBVRi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 2 Aug 2021 17:17:38 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8345C06175F
        for <bpf@vger.kernel.org>; Mon,  2 Aug 2021 14:17:27 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id j77so28712327ybj.3
        for <bpf@vger.kernel.org>; Mon, 02 Aug 2021 14:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PmeztRSgPMTcprlnP0q0q7ev93gC/sERcrTzhb+xnLI=;
        b=jEMOGUEN6EEa5JN2pznJAbE9JENjE9tipIL68IYFfzFstQEYp1/Y4mN7v2LELfCPf9
         /PD+Fvm1JV7iH6j2ayodbhODDXMw2H5VCpzzcgxOnuFwWafg+TwpCRR2B0G2IJijvoA3
         1q7S3KiO7ZMsoeU0F2K/P/lhh1AS1V9ox1lxFhgbqtBaKW9szY/q1ooGqI0AWbIELHPF
         oWHqE72kica54a73twUNUWGHsWPOwdDHl/QGc7Ac/Dd8P7dgCwDDnDl1T12XX5QPCKb5
         hw+eWGgqsjGqHttD0GIVswMBVbH0rJMjwQE5MOmtXu4/S7S/s9ZxUqz63s2ORCNvetzY
         LgHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PmeztRSgPMTcprlnP0q0q7ev93gC/sERcrTzhb+xnLI=;
        b=umOxpC5u60OGcES5iz4lTGkrqb0YWf3PrTtBhA0ywSeZ2nxGIovnLVi1vOIqoywGW8
         z7n8LArs3/4Zz00Iv70enTXXHZIas+lHHUtVg5rd3aw8cnrMyBu/iQuOs29oEDRlpTBI
         r7kunund4EE2hH02nlxQF+bGpmLs5vCh2YUNr0Sqc7GzlYqZmkvNAF7VqAAwKNV6IK3A
         IoLmVEahQA2aM57Um4v//reI61k4OJiKjVhbdKMHzpg1HpKcWO/ybejgXLkFhwDkjm4u
         Q9Wg5KcT1+zZgpJHdSlNC4eXFEWEubjvi5JN7KjFJhS7traNl4+B1Q50B+VfwlUFRPYS
         eOmw==
X-Gm-Message-State: AOAM533Bjww0/4tQh+uhiy9A/0ksMvqQVWyc9jvayPAT7Cjz+ywe1bNi
        Jddc959eobfW/JlVHG9X1QBb1MGGwd3sRpvVW4k=
X-Google-Smtp-Source: ABdhPJyfkIZD4ysPNMBQJzMicvus/IRYRV/balKdVnTYoAmytiG6TI7X6TfKQ/tneJCBYF5q6/yLwOH5KHipCbG6PJs=
X-Received: by 2002:a25:cdc7:: with SMTP id d190mr23347717ybf.425.1627939047247;
 Mon, 02 Aug 2021 14:17:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210802160556.1271747-1-hengqi.chen@gmail.com>
In-Reply-To: <20210802160556.1271747-1-hengqi.chen@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 2 Aug 2021 14:17:16 -0700
Message-ID: <CAEf4BzatBpjSSbeKCBzUYcA2FHBiymFrUvKikPkjtv1Ecv-mgw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Test btf__load_vmlinux_btf/btf__load_module_btf
 APIs
To:     Hengqi Chen <hengqi.chen@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 2, 2021 at 9:06 AM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>
> Add test for btf__load_vmlinux_btf/btf__load_module_btf APIs. It first
> checks that if btrfs module BTF exists, if yes, load module BTF and
> check symbol existence.
>
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> ---
>  .../selftests/bpf/prog_tests/btf_module.c     | 32 +++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_module.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_module.c b/tools/testing/selftests/bpf/prog_tests/btf_module.c
> new file mode 100644
> index 000000000000..9314a46e001c
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/btf_module.c
> @@ -0,0 +1,32 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2021 Hengqi Chen */
> +
> +#include <test_progs.h>
> +#include <bpf/btf.h>
> +
> +static const char *module_path = "/sys/kernel/btf/btrfs";
> +static const char *module_name = "btrfs";
> +
> +void test_btf_module()
> +{
> +       struct btf *vmlinux_btf, *module_btf;
> +       __s32 type_id;
> +
> +       if (access(module_path, F_OK))
> +               return;

we shouldn't use btrfs module, as it might not be mounted in our CI
environment. Good news is that selftests uses its own custom module to
do various module-related logic. It's already preloaded for all tests,
so you can just assume its existence (unless pre-loading fails, then
error out). See how "bpf_testmod" is used in selftests.

> +
> +       vmlinux_btf = btf__load_vmlinux_btf();
> +       if (!ASSERT_OK_PTR(vmlinux_btf, "could not load vmlinux BTF"))
> +               return;
> +
> +       module_btf = btf__load_module_btf(module_name, vmlinux_btf);
> +       if (!ASSERT_OK_PTR(module_btf, "could not load module BTF"))
> +               goto cleanup;
> +
> +       type_id = btf__find_by_name(module_btf, "btrfs_file_open");
> +       ASSERT_GT(type_id, 0, "func btrfs_file_open not found");
> +
> +cleanup:
> +       btf__free(module_btf);
> +       btf__free(vmlinux_btf);
> +}
> --
> 2.25.1
