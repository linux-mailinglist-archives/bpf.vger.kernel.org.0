Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6727424C56
	for <lists+bpf@lfdr.de>; Thu,  7 Oct 2021 06:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbhJGEHi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Oct 2021 00:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbhJGEHi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Oct 2021 00:07:38 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3ECC061746
        for <bpf@vger.kernel.org>; Wed,  6 Oct 2021 21:05:45 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id cs11-20020a17090af50b00b0019fe3df3dddso4750158pjb.0
        for <bpf@vger.kernel.org>; Wed, 06 Oct 2021 21:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JAfKCBtQonuNoYMh1YSVY4QujIRT8e+Izrm+wXFMU1s=;
        b=Uhf3iRnYhpzxNJgaMI7BVmpo5MM2BUuuqO0jwKIj29xbdt1pw5b6djjx2tqbx2k2rt
         pZzHj8x+UxQjNcEDEdwV4zAKa+TZbEDqfHNwEeIlMBV1hIPXfBUgfhCDBa/+TItHb5fS
         INktO66oyJAtAIqPYH0gBMcqLZphqAX0xpruWw8IjFLFYsKejn/5JR1SMTWaNmYo3ekF
         LP+0T2rEvBniXK+AsGRTQx5ZAlueuT2+P7j0NWYt91i0yMG61rMVYCdU9g27nNCZI4ij
         LmEc7xDLAnvUGifLYGCyoIVrUijGIeY3B2BDXukpEaHzY5miKbL+bD0zAFLNy3ZNdeKK
         07gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JAfKCBtQonuNoYMh1YSVY4QujIRT8e+Izrm+wXFMU1s=;
        b=iOQmhFnGRfiEBwsFyByOmT57TeOrCUnVQvBulSgG0dAF+A2RTkDOde03r7+p6KWMVX
         depGOOyDCHElTJjuIODCoiPOYUwmKCrsxE3p3hSfQGxgCrSxyiV6S8LGD3Rx1qmD7GTF
         G/419rlWNKvn3wHPR+lbuDC+5OxEIPjFMrVQYKgY5VsM7B7NaiV/706dLIhqlRArKe8G
         HZXJVRP+/diYJdavfipzalGMqvSyt8qAke0o+Z3VRjlP1LXuiLHYNUsxvL5yp27KVCod
         EexdkVYVRZuM2zlJSvyDrzF1Mzfh7pptZDgCCdi7+hBGOUdMctxx3yOmsXKG0XAHXcO1
         n7sw==
X-Gm-Message-State: AOAM531qs8+3x9LTKBiChgWZFfFr44tul9lMY1wV4AfzrING3vh0pc6a
        GWXVSMM+75I/XR8hneiwb/I=
X-Google-Smtp-Source: ABdhPJzdoMZhY17zGpqt9Dy4ItitogFgStBo6kMu9U7GUGjevvAGL82jFK3X/eKSnGGzl2em4jxhKQ==
X-Received: by 2002:a17:90b:3a88:: with SMTP id om8mr2162157pjb.229.1633579544808;
        Wed, 06 Oct 2021 21:05:44 -0700 (PDT)
Received: from [0.0.0.0] ([150.109.126.7])
        by smtp.gmail.com with ESMTPSA id v22sm22430332pff.93.2021.10.06.21.05.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Oct 2021 21:05:44 -0700 (PDT)
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Test bpf_skc_to_unix_sock()
To:     Song Liu <song@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>
References: <20211006040623.401527-1-hengqi.chen@gmail.com>
 <20211006040623.401527-3-hengqi.chen@gmail.com>
 <CAPhsuW7eK6KA62bcA+pTc8-r5yraN=5H1hocy+TOA3C30KWNDg@mail.gmail.com>
From:   Hengqi Chen <hengqi.chen@gmail.com>
Message-ID: <d67f6631-edf3-9627-142f-ea4b4a076d96@gmail.com>
Date:   Thu, 7 Oct 2021 12:05:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW7eK6KA62bcA+pTc8-r5yraN=5H1hocy+TOA3C30KWNDg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 10/6/21 1:09 PM, Song Liu wrote:
> On Tue, Oct 5, 2021 at 9:08 PM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>>
>> Add a new test which triggers unix_listen kernel function
>> to test bpf_skc_to_unix_sock helper.
>>
>> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
>> ---
>>  .../bpf/prog_tests/skc_to_unix_sock.c         | 54 +++++++++++++++++++
>>  .../bpf/progs/test_skc_to_unix_sock.c         | 28 ++++++++++
>>  2 files changed, 82 insertions(+)
>>  create mode 100644 tools/testing/selftests/bpf/prog_tests/skc_to_unix_sock.c
>>  create mode 100644 tools/testing/selftests/bpf/progs/test_skc_to_unix_sock.c
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/skc_to_unix_sock.c b/tools/testing/selftests/bpf/prog_tests/skc_to_unix_sock.c
>> new file mode 100644
>> index 000000000000..5d8ed76a71dc
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/skc_to_unix_sock.c
>> @@ -0,0 +1,54 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/* Copyright (c) 2021 Hengqi Chen */
>> +
>> +#include <test_progs.h>
>> +#include <sys/un.h>
>> +#include "test_skc_to_unix_sock.skel.h"
>> +
>> +static const char *sock_path = "/tmp/test.sock";
>> +
>> +void test_skc_to_unix_sock(void)
>> +{
>> +       struct test_skc_to_unix_sock *skel;
>> +       struct sockaddr_un sockaddr;
>> +       int err, len, sockfd = 0;
>> +
>> +       skel = test_skc_to_unix_sock__open();
>> +       if (!ASSERT_OK_PTR(skel, "could not open BPF object"))
>> +               return;
>> +
>> +       skel->rodata->my_pid = getpid();
>> +
>> +       err = test_skc_to_unix_sock__load(skel);
>> +       if (!ASSERT_OK(err, "could not load BPF object"))
>> +               goto cleanup;
>> +
>> +       err = test_skc_to_unix_sock__attach(skel);
>> +       if (!ASSERT_OK(err, "could not attach BPF object"))
>> +               goto cleanup;
>> +
>> +       // trigger unix_listen
>> +       sockfd = socket(AF_UNIX, SOCK_STREAM, 0);
>> +       if (!ASSERT_GT(sockfd, 0, "socket failed"))
>> +               goto cleanup;
>> +
>> +       sockaddr.sun_family = AF_UNIX;
>> +       strcpy(sockaddr.sun_path, sock_path);
>> +       len = sizeof(sockaddr);
>> +       unlink(sock_path);
>> +
>> +       err = bind(sockfd, (struct sockaddr *)&sockaddr, len);
>> +       if (!ASSERT_OK(err, "bind failed"))
>> +               goto cleanup;
>> +
>> +       err = listen(sockfd, 1);
>> +       if (!ASSERT_OK(err, "listen failed"))
>> +               goto cleanup;
>> +
>> +       ASSERT_GT(skel->bss->ret, 0, "bpf_skc_to_unix_sock failed");
>> +
>> +cleanup:
>> +       if (sockfd)
>> +               close(sockfd);
>> +       test_skc_to_unix_sock__destroy(skel);
>> +}
>> diff --git a/tools/testing/selftests/bpf/progs/test_skc_to_unix_sock.c b/tools/testing/selftests/bpf/progs/test_skc_to_unix_sock.c
>> new file mode 100644
>> index 000000000000..544d2ed56d7e
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/test_skc_to_unix_sock.c
>> @@ -0,0 +1,28 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/* Copyright (c) 2021 Hengqi Chen */
>> +
>> +#include "vmlinux.h"
>> +#include <bpf/bpf_helpers.h>
>> +#include <bpf/bpf_tracing.h>
>> +
>> +const volatile pid_t my_pid = 0;
>> +__u64 ret = 0;
>> +
>> +SEC("fentry/unix_listen")
>> +int BPF_PROG(unix_listen, struct socket *sock, int backlog)
>> +{
>> +       pid_t pid = bpf_get_current_pid_tgid() >> 32;
>> +       struct unix_sock *unix_sk;
>> +
>> +       if (pid != my_pid)
>> +               return 0;
>> +
>> +       unix_sk = (struct unix_sock *)bpf_skc_to_unix_sock(sock->sk);
>> +       if (!unix_sk)
>> +               return 0;
>> +
>> +       ret = (__u64)unix_sk;
> 
> Other than ret !=0, can we verify unix_sk we get is expected? May we can
> verify unix_sock-> path matches /tmp/test.sock?
> 

Yes, that would be much more precise. Will do.

> Thanks,
> Song
> 
