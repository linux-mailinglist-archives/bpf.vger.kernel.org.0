Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8DE069B6A9
	for <lists+bpf@lfdr.de>; Sat, 18 Feb 2023 01:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjBRAXa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Feb 2023 19:23:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjBRAXa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Feb 2023 19:23:30 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF70A67830
        for <bpf@vger.kernel.org>; Fri, 17 Feb 2023 16:23:28 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id ml23-20020a17090b361700b00234463de251so2998613pjb.3
        for <bpf@vger.kernel.org>; Fri, 17 Feb 2023 16:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J4fxRCSv+KJyGYriQ4w2jEoV2/PLz28LUQCJuDMXopo=;
        b=PIFQjw3Tzhv2jt1zmIYMiK9KOKmbjBJIbchfGKGfGeBNj654iVwcgK+EmgyM18uN48
         zZEx1qZDo5BaZZ9/fZh/qqYixQSjNlx5D5dGLLdBWDqYMDYZpFgGlFSbAARixDZL3op9
         qkhS5Y3uBvTDMDNgf9SgrpRqvFYmGeqV22VNPCUyxfSvzz2bABJSvU5GZtFGNZ5rhpYU
         aGfJX8K2leXtiG9KJmTvZrHP2UxhYVe6kaxLle75QI3n5aJKOW8utAYr165g61oEkSa9
         nUD2WD/Rg3Zhs8RWZSDNgnvx0gJn9B0Cba0LfvucA+yc9Ns73yicFLm5gVQvbPCqUXva
         m3uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J4fxRCSv+KJyGYriQ4w2jEoV2/PLz28LUQCJuDMXopo=;
        b=PJp0g4OwncefsWWDSR4vJwGGEaEedvlTj8H7kvP1pQ3rN6ukkJxmzz8e8rXeFAZ28t
         hRBjRVBMrs/m5Z7XXsaHQRNzPMB2jqRft2f2hlqmNYPxry0TgkE/xgK+ZdnRBSOtyV7U
         j+w5GvSzoSAnPVOU66xmL3k7UAFpffZ4Osub99mKkG/AN9RmFMWAhlMULKwRhBvJZHZS
         QLsB2HIY/Ygf/TEGA8EScGNLTIqau3TVLzQkBxzfUzW68jR10w/cEV3JjIxevxalHfWU
         8UwiNefAI9kPKoSWT+rvYzKr6JrQv9fIoKh5u7am9j0gabJ8sllZvqcqSqd/7gtlPJmt
         XFDA==
X-Gm-Message-State: AO0yUKXjaFJr98nrHHncTW4djeZ1qIYUF10GjlzYMnIHPlsdhxdZogDx
        0fUCTWUfV1CBMTg6g2Yl1uM=
X-Google-Smtp-Source: AK7set/vCHYCMf0B/hswavkSDPymCJlIzG1YYlT4TXaI7HVQRX2oqCq7DBqtX7eHypqE+MYedvGy6A==
X-Received: by 2002:a17:903:790:b0:19a:a4f3:6d4c with SMTP id kn16-20020a170903079000b0019aa4f36d4cmr1533370plb.67.1676679808305;
        Fri, 17 Feb 2023 16:23:28 -0800 (PST)
Received: from ?IPV6:2620:10d:c085:21cf::1210? ([2620:10d:c090:400::5:2cec])
        by smtp.gmail.com with ESMTPSA id t6-20020a1709027fc600b0019719f752c5sm3664240plb.59.2023.02.17.16.23.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Feb 2023 16:23:27 -0800 (PST)
Message-ID: <1e94cca4-2ec4-68d2-c0c8-73c7f2e4ecb1@gmail.com>
Date:   Fri, 17 Feb 2023 16:23:25 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH bpf-next 7/7] selftests/bpf: Test switching TCP Congestion
 Control algorithms.
Content-Language: en-US, en-ZW
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Kui-Feng Lee <kuifeng@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
        song@kernel.org, kernel-team@meta.com, andrii@kernel.org
References: <20230214221718.503964-1-kuifeng@meta.com>
 <20230214221718.503964-8-kuifeng@meta.com>
 <CAEf4BzbNtdRv089KMi+NS_VQq=ijbVAMt5nh8wWw5s2=sv6K5w@mail.gmail.com>
From:   Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <CAEf4BzbNtdRv089KMi+NS_VQq=ijbVAMt5nh8wWw5s2=sv6K5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/16/23 14:50, Andrii Nakryiko wrote:
> On Tue, Feb 14, 2023 at 2:17 PM Kui-Feng Lee <kuifeng@meta.com> wrote:
>>
>> Create a pair of sockets that utilize the congestion control algorithm
>> under a particular name. Then switch up this congestion control
>> algorithm to another implementation and check whether newly created
>> connections using the same cc name now run the new implementation.
>>
>> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
>> ---
>>   .../selftests/bpf/prog_tests/bpf_tcp_ca.c     | 48 ++++++++++++
>>   .../selftests/bpf/progs/tcp_ca_update.c       | 75 +++++++++++++++++++
>>   2 files changed, 123 insertions(+)
>>   create mode 100644 tools/testing/selftests/bpf/progs/tcp_ca_update.c
>>
> 
> [...]
> 
>> diff --git a/tools/testing/selftests/bpf/progs/tcp_ca_update.c b/tools/testing/selftests/bpf/progs/tcp_ca_update.c
>> new file mode 100644
>> index 000000000000..cf51fe54ac01
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/tcp_ca_update.c
>> @@ -0,0 +1,75 @@
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
>> +
>> +#define min(a, b) ((a) < (b) ? (a) : (b))
>> +
>> +static inline struct tcp_sock *tcp_sk(const struct sock *sk)
>> +{
>> +       return (struct tcp_sock *)sk;
>> +}
>> +
>> +SEC("struct_ops/ca_update_init")
>> +void BPF_PROG(ca_update_init, struct sock *sk)
>> +{
>> +#ifdef ENABLE_ATOMICS_TESTS
> 
> it's been 2 years since atomics were added to Clang, I think it's fine
> to just assume atomic operations are supported and not do the
> ENABLE_ATOMICS_TEST (and I'd clean up ENABLE_ATOMICS_TESTS now as
> well)

Sure!

> 
>> +       __sync_bool_compare_and_swap(&sk->sk_pacing_status, SK_PACING_NONE,
>> +                                    SK_PACING_NEEDED);
>> +#else
>> +       sk->sk_pacing_status = SK_PACING_NEEDED;
>> +#endif
>> +}
>> +
>> +SEC("struct_ops/ca_update_1_cong_control")
>> +void BPF_PROG(ca_update_1_cong_control, struct sock *sk,
>> +             const struct rate_sample *rs)
>> +{
>> +       ca1_cnt++;
>> +}
>> +
>> +SEC("struct_ops/ca_update_2_cong_control")
>> +void BPF_PROG(ca_update_2_cong_control, struct sock *sk,
>> +             const struct rate_sample *rs)
>> +{
>> +       ca2_cnt++;
>> +}
>> +
>> +SEC("struct_ops/ca_update_ssthresh")
>> +__u32 BPF_PROG(ca_update_ssthresh, struct sock *sk)
>> +{
>> +       return tcp_sk(sk)->snd_ssthresh;
>> +}
>> +
>> +SEC("struct_ops/ca_update_undo_cwnd")
>> +__u32 BPF_PROG(ca_update_undo_cwnd, struct sock *sk)
>> +{
>> +       return tcp_sk(sk)->snd_cwnd;
>> +}
>> +
>> +SEC(".struct_ops")
>> +struct tcp_congestion_ops ca_update_1 = {
>> +       .init = (void *)ca_update_init,
>> +       .cong_control = (void *)ca_update_1_cong_control,
>> +       .ssthresh = (void *)ca_update_ssthresh,
>> +       .undo_cwnd = (void *)ca_update_undo_cwnd,
>> +       .name = "tcp_ca_update",
>> +};
>> +
>> +SEC(".struct_ops")
>> +struct tcp_congestion_ops ca_update_2 = {
>> +       .init = (void *)ca_update_init,
>> +       .cong_control = (void *)ca_update_2_cong_control,
>> +       .ssthresh = (void *)ca_update_ssthresh,
>> +       .undo_cwnd = (void *)ca_update_undo_cwnd,
>> +       .name = "tcp_ca_update",
>> +};
>> --
>> 2.30.2
>>
