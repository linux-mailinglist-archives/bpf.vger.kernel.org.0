Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3EF47E30B
	for <lists+bpf@lfdr.de>; Thu, 23 Dec 2021 13:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348134AbhLWMQF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Dec 2021 07:16:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243398AbhLWMQE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Dec 2021 07:16:04 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827F5C061401
        for <bpf@vger.kernel.org>; Thu, 23 Dec 2021 04:16:04 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id co15so4920337pjb.2
        for <bpf@vger.kernel.org>; Thu, 23 Dec 2021 04:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=rHFH7SBdnM6eutAEvFYWXPa6WsoIdxrurvqOBAWwByk=;
        b=K9hSixS7sS1zQZrWPZISz4NKkgE70i2C4hyQlacVCs02UrRgmVsIISNB1gVxd7jUDw
         J4t5IoncIHtbM9pf+hofw4z4JZmenOkwoVBticC8f7q7Pos5JCUuEC/oUWgMv429w7hy
         oVKyBJJGydyIEjMKIATokvlMuLyJUZpUSuoJ9ECH/EKUDeZ6rYQ1mkLWEABZzfSxtH0/
         RnxLNHGPPhdwszB7Y0GIAyHjylx+b6x2gtJATxIA4voy1wxeBBreqTks+GSJTQMJ104V
         IxPnTvkwif/dUMbejvLB1jdIvvIeU+VEazCYK5m4oL+bqNKEEsCc1upLAQrbIGS0idco
         BxzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rHFH7SBdnM6eutAEvFYWXPa6WsoIdxrurvqOBAWwByk=;
        b=ExSCPxWPJaVY8OLEnYpjFfoGuvmfrRkRWLiSAMh5yq2zEcET7Vge7ezGIMmkSwYrhQ
         CQ6omTtKSNxn+qmRWTvlWXl/Spb5DQU23xyS/3SYzQ6Wi+m95/vhQAZcGVTQZiYswMRY
         u+xHmFcRrm7h/rLPxf+ptXzh+fGVYvQxizqIApHxSMz5cog9c6qz66GUYrNFy4ntH2Tn
         GTxfCq03RQOn0SsSBF8gke3hcWVCepQsN9DoMcTCEYDueHa3Zyx31tbIeM0nVlYrCYGm
         pfXa/2n1PbtC6JFzQtM6EgeAgg6mTGsBHAM5xMNKM3OpazXGLbOcefUwiiB/D7OkpLvU
         k93g==
X-Gm-Message-State: AOAM530N/Y95zEpYWRASzixBlIk4UX6mED6ssQnSjpnOxho2leG4gPDX
        uxRR1R7huoXlax47Hi8UB38=
X-Google-Smtp-Source: ABdhPJyVGuFBrEvRD97dGMkxjkq8/vxONupnvNdHBy/XMR9nM2tYYUYr1S/ce0eEO9+wRPmXYxWOyA==
X-Received: by 2002:a17:902:904b:b0:143:73ff:eb7d with SMTP id w11-20020a170902904b00b0014373ffeb7dmr2121208plz.85.1640261764070;
        Thu, 23 Dec 2021 04:16:04 -0800 (PST)
Received: from [192.168.255.10] ([203.205.141.118])
        by smtp.gmail.com with ESMTPSA id om3sm8430696pjb.49.2021.12.23.04.16.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Dec 2021 04:16:03 -0800 (PST)
Message-ID: <77103ff7-5994-2ab4-a069-02eb5a57c44f@gmail.com>
Date:   Thu, 23 Dec 2021 20:16:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Test
 BPF_KPROBE_SYSCALL/BPF_KRETPROBE_SYSCALL macros
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
References: <20211221055312.3371414-1-hengqi.chen@gmail.com>
 <20211221055312.3371414-3-hengqi.chen@gmail.com>
 <CAEf4BzZ+UHAoAVwgjafAcfZa=c7cSLiLUY8OvpfKk9N4gO7zYQ@mail.gmail.com>
From:   Hengqi Chen <hengqi.chen@gmail.com>
In-Reply-To: <CAEf4BzZ+UHAoAVwgjafAcfZa=c7cSLiLUY8OvpfKk9N4gO7zYQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2021/12/22 8:37 AM, Andrii Nakryiko wrote:
> On Mon, Dec 20, 2021 at 9:54 PM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>>
>> Add tests for the newly added BPF_KPROBE_SYSCALL/BPF_KRETPROBE_SYSCALL macros.
>>
>> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
>> ---
>>  .../selftests/bpf/prog_tests/kprobe_syscall.c | 40 ++++++++++++++++++
>>  .../selftests/bpf/progs/test_kprobe_syscall.c | 41 +++++++++++++++++++
>>  2 files changed, 81 insertions(+)
>>  create mode 100644 tools/testing/selftests/bpf/prog_tests/kprobe_syscall.c
>>  create mode 100644 tools/testing/selftests/bpf/progs/test_kprobe_syscall.c
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/kprobe_syscall.c
>> new file mode 100644
>> index 000000000000..a1fad70bbb69
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/kprobe_syscall.c
>> @@ -0,0 +1,40 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (c) 2021 Hengqi Chen */
>> +
>> +#include <test_progs.h>
>> +#include <sys/types.h>
>> +#include <sys/socket.h>
>> +#include "test_kprobe_syscall.skel.h"
>> +
>> +void test_kprobe_syscall(void)
>> +{
>> +       struct test_kprobe_syscall *skel;
>> +       int err, fd = 0;
>> +
>> +       skel = test_kprobe_syscall__open();
>> +       if (!ASSERT_OK_PTR(skel, "could not open BPF object"))
>> +               return;
>> +
>> +       skel->rodata->my_pid = getpid();
>> +
>> +       err = test_kprobe_syscall__load(skel);
>> +       if (!ASSERT_OK(err, "could not load BPF object"))
>> +               goto cleanup;
>> +
>> +       err = test_kprobe_syscall__attach(skel);
>> +       if (!ASSERT_OK(err, "could not attach BPF object"))
>> +               goto cleanup;
>> +
>> +       fd = socket(AF_UNIX, SOCK_STREAM, 0);
>> +
>> +       ASSERT_GT(fd, 0, "socket failed");
>> +       ASSERT_EQ(skel->bss->domain, AF_UNIX, "BPF_KPROBE_SYSCALL failed");
>> +       ASSERT_EQ(skel->bss->type, SOCK_STREAM, "BPF_KPROBE_SYSCALL failed");
>> +       ASSERT_EQ(skel->bss->protocol, 0, "BPF_KPROBE_SYSCALL failed");
>> +       ASSERT_EQ(skel->bss->fd, fd, "BPF_KRETPROBE_SYSCALL failed");
>> +
>> +cleanup:
>> +       if (fd)
>> +               close(fd);
>> +       test_kprobe_syscall__destroy(skel);
>> +}
>> diff --git a/tools/testing/selftests/bpf/progs/test_kprobe_syscall.c b/tools/testing/selftests/bpf/progs/test_kprobe_syscall.c
>> new file mode 100644
>> index 000000000000..ecef9d19007c
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/test_kprobe_syscall.c
>> @@ -0,0 +1,41 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (c) 2021 Hengqi Chen */
>> +
>> +#include "vmlinux.h"
>> +#include <bpf/bpf_helpers.h>
>> +#include <bpf/bpf_tracing.h>
>> +#include <bpf/bpf_core_read.h>
>> +
>> +const volatile pid_t my_pid = 0;
>> +int domain = 0;
>> +int type = 0;
>> +int protocol = 0;
>> +int fd = 0;
>> +
>> +SEC("kprobe/__x64_sys_socket")
>> +int BPF_KPROBE_SYSCALL(socket_enter, int d, int t, int p)
>> +{
>> +       pid_t pid = bpf_get_current_pid_tgid() >> 32;
>> +
>> +       if (pid != my_pid)
>> +               return 0;
>> +
>> +       domain = d;
>> +       type = t;
>> +       protocol = p;
>> +       return 0;
>> +}
>> +
>> +SEC("kretprobe/__x64_sys_socket")
> 
> oh, please also use SYS_PREFIX instead of hard-coding __x64. This is
> very x86-64-specific and we have other architectures tested by
> selftests, so this makes it automatically fail on non-x86_64.
> 

I just followed some existing selftests, didn't realize SYS_PREFIX.
Will update to use SYS_PREFIX.

> If you get a chance, try also cleaning up other __x64_ uses in the
> selftests as a separate patch. Thank you!
> 

OK, will do.

>> +int BPF_KRETPROBE_SYSCALL(socket_exit, int ret)
>> +{
>> +       pid_t pid = bpf_get_current_pid_tgid() >> 32;
>> +
>> +       if (pid != my_pid)
>> +               return 0;
>> +
>> +       fd = ret;
>> +       return 0;
>> +}
>> +
>> +char _license[] SEC("license") = "GPL";
>> --
>> 2.30.2
