Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3DCD45C9BD
	for <lists+bpf@lfdr.de>; Wed, 24 Nov 2021 17:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbhKXQVs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Nov 2021 11:21:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbhKXQVs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Nov 2021 11:21:48 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21E3C061574
        for <bpf@vger.kernel.org>; Wed, 24 Nov 2021 08:18:38 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id v23so2937067pjr.5
        for <bpf@vger.kernel.org>; Wed, 24 Nov 2021 08:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NYzlQMx2qREsd0p1zFgqhePRJIUEMuVXwBghOaI3CdA=;
        b=RluXuzAQO+oiqp1Z0XryVZ6X9utpSgED5wKFsIT2M4HwHkcDkqQ02hGCQQof3A20vR
         7ufYd/I2x42HG5NBXe+EFm5w6UxllBSj4o+QH1L8HJtG5ErTz8p6DDaGSV34rYqn0pOy
         O49AH1z/4mKG0TyWVk/lPFDHsvwZZx9ZH4bImz6MopKiPx/rSyGMK1j6IhVzHQs3+I1F
         MBuh5/DFXk/qUjayuk9OSQNPZiaOdrzAXFLHuncJy/VIEB/QAXSR81PxRAy5CfALxsBG
         SfPkFG5WXmx+kfX9mhMnDqdlrLeX2K8QxWYW37YK+TSkxrPhQTTZ57TE7/EqLdowzRir
         bkeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NYzlQMx2qREsd0p1zFgqhePRJIUEMuVXwBghOaI3CdA=;
        b=RhkH4u3RjflWWGe0vpfy+bKw9b1QwXLl/I52OiZ9VuXS1SHJghLZ+aPLujLX7TKJXr
         htZrL+0mJVHgLPs7qzpdFXgrUREgiRRXR97MYmAe2aTWyhLNXsn4ltMezBJ1rWPeeZ5d
         fWGuu3Jk3WdqknY39ci3Aw2ss10iB/MeWFXS3wN+mt6Pi2WsQ1b1ZyTDCVUKTkNafo/x
         O+m3AdDqkqTP0R3PlHT8cw8YRdSbgINwz6W6Cv93VhuSjD33tUU4NTpxM8lbt8+9lM1+
         7s4i4SItvd7Gu0odqO3w0opI4xCwCisOJ8CXnwOCP8LIqdZ3SSp096vVOc4d+mGDdif0
         Rxrg==
X-Gm-Message-State: AOAM533xXwDEGp+TI4B+mhp6Dl1ThASRhYD2RD5OqKN0IYKb3x7FIk6u
        zLMb4BrxNN/zw6ilRjlj/QVO9MMsqh0fcw==
X-Google-Smtp-Source: ABdhPJy69gJiXDUTarDA6Bzyjmd8z9SR1nR3TEFvKGk0HZgaYUCJ052PcvmdsWTjinw1RjxcWjhtDQ==
X-Received: by 2002:a17:902:f693:b0:142:9ec:c2e1 with SMTP id l19-20020a170902f69300b0014209ecc2e1mr20090366plg.34.1637770718039;
        Wed, 24 Nov 2021 08:18:38 -0800 (PST)
Received: from [0.0.0.0] ([150.109.126.7])
        by smtp.gmail.com with ESMTPSA id mq14sm5847198pjb.54.2021.11.24.08.18.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Nov 2021 08:18:37 -0800 (PST)
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Test BPF_MAP_TYPE_PROG_ARRAY
 static initialization
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
References: <20211121135440.3205482-1-hengqi.chen@gmail.com>
 <20211121135440.3205482-3-hengqi.chen@gmail.com>
 <CAEf4BzZ1_pgRfk-uwqa8sr8BDaYPPr0yreENdCbU=szzSL4HFQ@mail.gmail.com>
From:   Hengqi Chen <hengqi.chen@gmail.com>
Message-ID: <b5524574-1f74-02f2-970c-98bb0740abf9@gmail.com>
Date:   Thu, 25 Nov 2021 00:18:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAEf4BzZ1_pgRfk-uwqa8sr8BDaYPPr0yreENdCbU=szzSL4HFQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/23/21 11:28 AM, Andrii Nakryiko wrote:
> On Sun, Nov 21, 2021 at 5:55 AM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>>
>> Add testcase for BPF_MAP_TYPE_PROG_ARRAY static initialization.
>>
>> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
>> ---
> 
> It's a bit too minimal, let's actually trigger the program and make
> sure that tail call program gets executed. Please also make sure that
> you filter by pid like other tracing progs do (I suggest using
> usleep(1) and raw_tracepoint program for sys_enter, as the simplest
> set up).
> 

Will implement what you suggest here. Thanks.

>>  .../bpf/prog_tests/prog_array_init.c          | 27 +++++++++++++++++
>>  .../bpf/progs/test_prog_array_init.c          | 30 +++++++++++++++++++
>>  2 files changed, 57 insertions(+)
>>  create mode 100644 tools/testing/selftests/bpf/prog_tests/prog_array_init.c
>>  create mode 100644 tools/testing/selftests/bpf/progs/test_prog_array_init.c
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/prog_array_init.c b/tools/testing/selftests/bpf/prog_tests/prog_array_init.c
>> new file mode 100644
>> index 000000000000..2fbf6946a0b6
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/prog_array_init.c
>> @@ -0,0 +1,27 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/* Copyright (c) 2021 Hengqi Chen */
>> +
>> +#include <test_progs.h>
>> +#include <sys/un.h>
>> +#include "test_prog_array_init.skel.h"
>> +
>> +void test_prog_array_init(void)
>> +{
>> +       struct test_prog_array_init *skel;
>> +       int err;
>> +
>> +       skel = test_prog_array_init__open();
>> +       if (!ASSERT_OK_PTR(skel, "could not open BPF object"))
>> +               return;
>> +
>> +       err = test_prog_array_init__load(skel);
>> +       if (!ASSERT_OK(err, "could not load BPF object"))
>> +               goto cleanup;
>> +
>> +       err = test_prog_array_init__attach(skel);
>> +       if (!ASSERT_OK(err, "could not attach BPF object"))
>> +               goto cleanup;
>> +
>> +cleanup:
>> +       test_prog_array_init__destroy(skel);
>> +}
>> diff --git a/tools/testing/selftests/bpf/progs/test_prog_array_init.c b/tools/testing/selftests/bpf/progs/test_prog_array_init.c
>> new file mode 100644
>> index 000000000000..e97204dd5443
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/test_prog_array_init.c
>> @@ -0,0 +1,30 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/* Copyright (c) 2021 Hengqi Chen */
>> +
>> +#include "vmlinux.h"
>> +#include <bpf/bpf_helpers.h>
>> +#include <bpf/bpf_tracing.h>
>> +
>> +SEC("socket")
>> +int tailcall_1(void *ctx)
>> +{
> 
> let's add some global variable that will be set by the tail call
> program, so that we know that correct slot and correct program was set
> 

Will do.

>> +       return 0;
>> +}
>> +
>> +struct {
>> +       __uint(type, BPF_MAP_TYPE_PROG_ARRAY);
>> +       __uint(max_entries, 2);
>> +       __uint(key_size, sizeof(__u32));
>> +       __array(values, int (void *));
>> +} prog_array_init SEC(".maps") = {
>> +       .values = {
>> +               [1] = (void *)&tailcall_1,
>> +       },
>> +};
>> +
>> +SEC("socket")
>> +int BPF_PROG(entry)
>> +{
> 
> BPF_PROG doesn't really help, it just hides ctx which you are actually
> using below, so let's just stick to `int entry(void *ctx)` here.
> 

Ack.

>> +       bpf_tail_call(ctx, &prog_array_init, 1);
>> +       return 0;
>> +}
>> --
>> 2.30.2

---Hengqi
