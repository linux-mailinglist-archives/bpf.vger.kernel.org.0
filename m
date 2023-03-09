Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4906B1A01
	for <lists+bpf@lfdr.de>; Thu,  9 Mar 2023 04:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjCIDeu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Mar 2023 22:34:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjCIDes (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Mar 2023 22:34:48 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A2EB5FC8
        for <bpf@vger.kernel.org>; Wed,  8 Mar 2023 19:34:47 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id y2so882667pjg.3
        for <bpf@vger.kernel.org>; Wed, 08 Mar 2023 19:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678332887;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7iiCv+4Y1nLWolZblGPXIoFSiA0VaVNPbm+AylRQwRY=;
        b=WZB9Fo7qz0kJ75XArfNFnQcludOw09PXPkWv0r9k0QfhC1E9zZy0yU4NLwov7qt9RV
         psQ8uKqa7h8goF39K5mywAtBoDVW++hPCTkUGd6MWaHqtWh3tDh7ysL3Z7/928K2i9N5
         Q9zow8ePiG1iuYwfByZujHN0tYWIXyQNRRdqh2FY6kjmjU66cSKMOV+Ia2PHA2sVtzC1
         jEfwTzc3j3051rNTeuiaICA8+BaTLY8ndbL9nCslhUC4Ap5MociC6sRlCDTYH1CgbhI0
         m3b/4aAHlW1USdFWurNSQNrezcJ1Tc2+3yOGMETf87J70hm80LF6ephSS96riwQos+U1
         ZZxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678332887;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7iiCv+4Y1nLWolZblGPXIoFSiA0VaVNPbm+AylRQwRY=;
        b=r1OBo5U7HcGQ1xQaFQP/9DnkvhxA5AoSLyx8GnofWp0NuotjtHtdc1Nzqui16HKTEK
         n7JHbKuIMslE/s9Aa2IvbC/p/JAAv8Sg5AYlLWpwge59o+eIFr5DMbxFfxJoCly/Mv+7
         hy/GwwbjQf2YJUCzyXSgrpMDUS6S8Dawmmml2C8twbri9V8TYFskZTVO4itC8ZQUQlqV
         yh9SjeOLoTuptxKvhMQqqK5WYI3a8XCC00+YB7SfABIui/PUqFYGarDNq6dol/Xirrtu
         KhFph+cqYuqkkJmCcCqsxPYNH2A1pctoS0mWCznMtMufUx/w2/6tJu6K4ugBHxoq/XcV
         yA/Q==
X-Gm-Message-State: AO0yUKVOXMPd0msxFBqh4Hi5QQeki+wmlq53vvpEuXLkeXBRxLcP50lr
        wx9o7lP8n9L4Pmj0GI6Suqs=
X-Google-Smtp-Source: AK7set+PfO1jDfKtXYoWYorpL6W2R4an7gGubXeJo5G/pUoz/o6FwxKxaAkkK2bMQQ2xW6Y+6hh3yw==
X-Received: by 2002:a05:6a20:3d04:b0:cc:6d4d:57ae with SMTP id y4-20020a056a203d0400b000cc6d4d57aemr26590389pzi.42.1678332886907;
        Wed, 08 Mar 2023 19:34:46 -0800 (PST)
Received: from ?IPV6:2620:10d:c085:21c8::1626? ([2620:10d:c090:400::5:f2a2])
        by smtp.gmail.com with ESMTPSA id d7-20020aa78147000000b005a8851e0cddsm10010314pfn.188.2023.03.08.19.34.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 19:34:46 -0800 (PST)
Message-ID: <0f828b9b-c00e-47f2-3e73-d58167b51eeb@gmail.com>
Date:   Wed, 8 Mar 2023 19:34:43 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH bpf-next v5 8/8] selftests/bpf: Test switching TCP
 Congestion Control algorithms.
Content-Language: en-US, en-ZW
To:     Martin KaFai Lau <martin.lau@linux.dev>,
        Kui-Feng Lee <kuifeng@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
        kernel-team@meta.com, andrii@kernel.org, sdf@google.com
References: <20230308005050.255859-1-kuifeng@meta.com>
 <20230308005050.255859-9-kuifeng@meta.com>
 <5a05613a-a346-1072-bbab-3494cf231961@linux.dev>
From:   Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <5a05613a-a346-1072-bbab-3494cf231961@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/8/23 15:10, Martin KaFai Lau wrote:
> On 3/7/23 4:50 PM, Kui-Feng Lee wrote:
>> Create a pair of sockets that utilize the congestion control algorithm
>> under a particular name. Then switch up this congestion control
>> algorithm to another implementation and check whether newly created
>> connections using the same cc name now run the new implementation.
>>
>> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
>> ---
>>   .../selftests/bpf/prog_tests/bpf_tcp_ca.c     | 38 ++++++++++++
>>   .../selftests/bpf/progs/tcp_ca_update.c       | 62 +++++++++++++++++++
>>   2 files changed, 100 insertions(+)
>>   create mode 100644 tools/testing/selftests/bpf/progs/tcp_ca_update.c
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c 
>> b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
>> index e980188d4124..caaa9175ee36 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
>> @@ -8,6 +8,7 @@
>>   #include "bpf_dctcp.skel.h"
>>   #include "bpf_cubic.skel.h"
>>   #include "bpf_tcp_nogpl.skel.h"
>> +#include "tcp_ca_update.skel.h"
>>   #include "bpf_dctcp_release.skel.h"
>>   #include "tcp_ca_write_sk_pacing.skel.h"
>>   #include "tcp_ca_incompl_cong_ops.skel.h"
>> @@ -381,6 +382,41 @@ static void test_unsupp_cong_op(void)
>>       libbpf_set_print(old_print_fn);
>>   }
>> +static void test_update_ca(void)
>> +{
>> +    struct tcp_ca_update *skel;
>> +    struct bpf_link *link;
>> +    int saved_ca1_cnt;
>> +    int err;
>> +
>> +    skel = tcp_ca_update__open();
>> +    if (!ASSERT_OK_PTR(skel, "open"))
>> +        return;
>> +
>> +    err = tcp_ca_update__load(skel);
> 
> nit. Use tcp_ca_update__open_and_load().
> 
>> +    if (!ASSERT_OK(err, "load")) {
>> +        tcp_ca_update__destroy(skel);
>> +        return;
>> +    }
>> +
>> +    link = bpf_map__attach_struct_ops(skel->maps.ca_update_1);
>> +    ASSERT_OK_PTR(link, "attach_struct_ops");
>> +
>> +    do_test("tcp_ca_update", NULL);
>> +    saved_ca1_cnt = skel->bss->ca1_cnt;
>> +    ASSERT_GT(saved_ca1_cnt, 0, "ca1_ca1_cnt");
>> +
>> +    err = bpf_link__update_map(link, skel->maps.ca_update_2);
>> +    ASSERT_OK(err, "update_struct_ops");
>> +
>> +    do_test("tcp_ca_update", NULL);
>> +    ASSERT_EQ(skel->bss->ca1_cnt, saved_ca1_cnt, "ca2_ca1_cnt");
>> +    ASSERT_GT(skel->bss->ca2_cnt, 0, "ca2_ca2_cnt");
>> +
>> +    bpf_link__destroy(link);
>> +    tcp_ca_update__destroy(skel);
>> +}
>> +
>>   void test_bpf_tcp_ca(void)
>>   {
>>       if (test__start_subtest("dctcp"))
>> @@ -399,4 +435,6 @@ void test_bpf_tcp_ca(void)
>>           test_incompl_cong_ops();
>>       if (test__start_subtest("unsupp_cong_op"))
>>           test_unsupp_cong_op();
>> +    if (test__start_subtest("update_ca"))
>> +        test_update_ca();
>>   }
>> diff --git a/tools/testing/selftests/bpf/progs/tcp_ca_update.c 
>> b/tools/testing/selftests/bpf/progs/tcp_ca_update.c
>> new file mode 100644
>> index 000000000000..36a04be95df5
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/tcp_ca_update.c
>> @@ -0,0 +1,62 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +#include "vmlinux.h"
>> +
>> +#include <bpf/bpf_helpers.h>
>> +#include <bpf/bpf_tracing.h>
>> +
>> +char _license[] SEC("license") = "GPL";
>> +
>> +int ca1_cnt = 0;
>> +int ca2_cnt = 0;
>> +
>> +#define USEC_PER_SEC 1000000UL
> 
> Not used.
> 
>> +
>> +#define min(a, b) ((a) < (b) ? (a) : (b))
> 
> Not used.
> 
>> +
>> +static inline struct tcp_sock *tcp_sk(const struct sock *sk)
>> +{
>> +    return (struct tcp_sock *)sk;
>> +}
>> +
>> +SEC("struct_ops/ca_update_1_cong_control")
>> +void BPF_PROG(ca_update_1_cong_control, struct sock *sk,
>> +          const struct rate_sample *rs)
>> +{
>> +    ca1_cnt++;
>> +}
>> +
>> +SEC("struct_ops/ca_update_2_cong_control")
>> +void BPF_PROG(ca_update_2_cong_control, struct sock *sk,
>> +          const struct rate_sample *rs)
>> +{
>> +    ca2_cnt++;
>> +}
>> +
>> +SEC("struct_ops/ca_update_ssthresh")
>> +__u32 BPF_PROG(ca_update_ssthresh, struct sock *sk)
>> +{
>> +    return tcp_sk(sk)->snd_ssthresh;
>> +}
>> +
>> +SEC("struct_ops/ca_update_undo_cwnd")
>> +__u32 BPF_PROG(ca_update_undo_cwnd, struct sock *sk)
>> +{
>> +    return tcp_sk(sk)->snd_cwnd;
>> +}
>> +
>> +SEC(".struct_ops.link")
>> +struct tcp_congestion_ops ca_update_1 = {
>> +    .cong_control = (void *)ca_update_1_cong_control,
>> +    .ssthresh = (void *)ca_update_ssthresh,
>> +    .undo_cwnd = (void *)ca_update_undo_cwnd,
>> +    .name = "tcp_ca_update",
>> +};
>> +
>> +SEC(".struct_ops.link")
>> +struct tcp_congestion_ops ca_update_2 = {
>> +    .cong_control = (void *)ca_update_2_cong_control,
> 
> nit. I think it is more future proof to use '.init' to bump the ca1_cnt 
> and ca2_cnt. '.init' must be called. Just in case for some unlikely 
> stack change that may not call cong_control and then need to adjust the 
> test accordingly.

Got it!

> 
> It also needs a few negative tests like creating a link with a map 
> without BPF_F_LINK. delete_elem on BPF_F_LINK map. Replace a link with a 
> different tcp-cc-name which is not supported now, ...etc.

I have added a few more today.  Replaceing a link with a different name
is something missing. Thanks!

> 
>> +    .ssthresh = (void *)ca_update_ssthresh,
>> +    .undo_cwnd = (void *)ca_update_undo_cwnd,
>> +    .name = "tcp_ca_update",
>> +};
> 
