Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCBB6B10AA
	for <lists+bpf@lfdr.de>; Wed,  8 Mar 2023 19:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjCHSK6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Mar 2023 13:10:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjCHSK4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Mar 2023 13:10:56 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CC7CDA23
        for <bpf@vger.kernel.org>; Wed,  8 Mar 2023 10:10:55 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id m8-20020a17090a4d8800b002377bced051so3341754pjh.0
        for <bpf@vger.kernel.org>; Wed, 08 Mar 2023 10:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678299054;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rzwbRvuC2JQQ3qLez/so2Pw+pbTtEQ3q5W+0oC7rkPw=;
        b=o8OSDVMPIoarJwTNcwe44XC49DHjiaXHMB5JIJCGVJMGeOA+zUV+CJp7ElX3747NXc
         d5XYUJ+bL8WULcolAlzLTSGp1llYTad3o2j8hfqneWtroTfql5ImatuzMPIMtpvyq5ob
         sX8RRocLi87+co99CdpBxcvf9Xo7HtByWr7WujT1ud/b0UI+SAhqIWmZAjTY8heoiZe8
         zr+lS0ojRvajN3lGftNUnLxym7MDLtXySl5CTvRPo5FT9EmFgzEM98Iep6qRJvMen9f9
         agZgzAefKZRxbkgPtuLqQ7n8Vju+mrNy2JNPjo+YeIrqgdLZuha2VlrJ2WYx5UlL9DlQ
         U4SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678299054;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rzwbRvuC2JQQ3qLez/so2Pw+pbTtEQ3q5W+0oC7rkPw=;
        b=63l+9hO7aCmegRPkdwzBJo14YLo+CO6BBq2mvVEHMVnJkr0u+IkxdQ+TDXCEXba3j8
         9Lv0DevK0A+8ierYOkKiG0c5Wvcl2Wu62Bm1McPDRidHoNo+S0Ghr3lKII8DXS7t+geF
         7hFXuzyKcE3tA18pxFmdbC0m8YrCc8fKMY1hXmpAJ2KMU+G6jTl0CH6NXkE17FgVFiaM
         9aEA0Izu4+3mcVrs4qwfOtgw2KtG06DM1KKF+JD0MB0BYjUPyqP+KaJcNz2les7VxNdy
         FR6ozqRk5YbgX+trJzgHAvYkBk5peg8Xc4xTudLjxNdWMS3F352o5VJWErDAJB2X3Wi1
         6YnA==
X-Gm-Message-State: AO0yUKW2RXm62MzvGXcoOl9bXldZFNmVyDejg9fH2v+kErZtXlEcpr3e
        TttNv4qzf6KsfgxEhFMe/Vg=
X-Google-Smtp-Source: AK7set85s8MqYIWQ9DiJIJPacrSbPAmkKAYqoR1eBgBtMPzR88Fwr6t/G85Kwreu5YY31ToqRVG+7Q==
X-Received: by 2002:a17:903:492:b0:19e:773b:2215 with SMTP id jj18-20020a170903049200b0019e773b2215mr17943915plb.36.1678299054543;
        Wed, 08 Mar 2023 10:10:54 -0800 (PST)
Received: from ?IPV6:2620:10d:c085:21d6::1660? ([2620:10d:c090:400::5:78e2])
        by smtp.gmail.com with ESMTPSA id s2-20020a17090b070200b00213202d77d9sm46064pjz.43.2023.03.08.10.10.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 10:10:54 -0800 (PST)
Message-ID: <b3867a6b-12fc-2eee-83eb-09d520058620@gmail.com>
Date:   Wed, 8 Mar 2023 10:10:45 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH bpf-next v4 9/9] selftests/bpf: Test switching TCP
 Congestion Control algorithms.
Content-Language: en-US, en-ZW
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Kui-Feng Lee <kuifeng@meta.com>, bpf@vger.kernel.org,
        ast@kernel.org, martin.lau@linux.dev, song@kernel.org,
        kernel-team@meta.com, andrii@kernel.org, sdf@google.com
References: <20230307233307.3626875-1-kuifeng@meta.com>
 <20230307233307.3626875-10-kuifeng@meta.com>
 <CAEf4BzauUuFYfUVFSRY6u=NmVUfbmY1pH-p7yXMEWFN1SDjejA@mail.gmail.com>
 <8678e7e0-ae7a-3230-89d8-af071f800b04@gmail.com>
 <CAEf4BzYMxyrcbRg+BN2xCM8a5g3E5eCxrJWC22fAWFg4YNWw5w@mail.gmail.com>
From:   Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <CAEf4BzYMxyrcbRg+BN2xCM8a5g3E5eCxrJWC22fAWFg4YNWw5w@mail.gmail.com>
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



On 3/8/23 09:18, Andrii Nakryiko wrote:
> On Wed, Mar 8, 2023 at 7:58 AM Kui-Feng Lee <sinquersw@gmail.com> wrote:
>>
>>
>>
>> On 3/7/23 17:10, Andrii Nakryiko wrote:
>>> On Tue, Mar 7, 2023 at 3:34 PM Kui-Feng Lee <kuifeng@meta.com> wrote:
>>>>
>>>> Create a pair of sockets that utilize the congestion control algorithm
>>>> under a particular name. Then switch up this congestion control
>>>> algorithm to another implementation and check whether newly created
>>>> connections using the same cc name now run the new implementation.
>>>>
>>>> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
>>>> ---
>>>>    .../selftests/bpf/prog_tests/bpf_tcp_ca.c     | 38 ++++++++++++
>>>>    .../selftests/bpf/progs/tcp_ca_update.c       | 62 +++++++++++++++++++
>>>>    2 files changed, 100 insertions(+)
>>>>    create mode 100644 tools/testing/selftests/bpf/progs/tcp_ca_update.c
>>>>
>>>> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
>>>> index e980188d4124..caaa9175ee36 100644
>>>> --- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
>>>> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
>>>> @@ -8,6 +8,7 @@
>>>>    #include "bpf_dctcp.skel.h"
>>>>    #include "bpf_cubic.skel.h"
>>>>    #include "bpf_tcp_nogpl.skel.h"
>>>> +#include "tcp_ca_update.skel.h"
>>>>    #include "bpf_dctcp_release.skel.h"
>>>>    #include "tcp_ca_write_sk_pacing.skel.h"
>>>>    #include "tcp_ca_incompl_cong_ops.skel.h"
>>>> @@ -381,6 +382,41 @@ static void test_unsupp_cong_op(void)
>>>>           libbpf_set_print(old_print_fn);
>>>>    }
>>>>
>>>> +static void test_update_ca(void)
>>>> +{
>>>> +       struct tcp_ca_update *skel;
>>>> +       struct bpf_link *link;
>>>> +       int saved_ca1_cnt;
>>>> +       int err;
>>>> +
>>>> +       skel = tcp_ca_update__open();
>>>> +       if (!ASSERT_OK_PTR(skel, "open"))
>>>> +               return;
>>>> +
>>>> +       err = tcp_ca_update__load(skel);
>>>
>>> tcp_ca_update__open_and_load()
>>>
>>>> +       if (!ASSERT_OK(err, "load")) {
>>>> +               tcp_ca_update__destroy(skel);
>>>> +               return;
>>>> +       }
>>>> +
>>>> +       link = bpf_map__attach_struct_ops(skel->maps.ca_update_1);
>>>
>>> I think it's time to generate link holder for each struct_ops map to
>>> the BPF skeleton, and support auto-attach of struct_ops skeleton.
>>> Please do that as a follow up, once this patch set lands.
>>
>> Got it.
>>
>>>
>>>> +       ASSERT_OK_PTR(link, "attach_struct_ops");
>>>> +
>>>> +       do_test("tcp_ca_update", NULL);
>>>> +       saved_ca1_cnt = skel->bss->ca1_cnt;
>>>> +       ASSERT_GT(saved_ca1_cnt, 0, "ca1_ca1_cnt");
>>>> +
>>>> +       err = bpf_link__update_map(link, skel->maps.ca_update_2);
>>>> +       ASSERT_OK(err, "update_struct_ops");
>>>> +
>>>> +       do_test("tcp_ca_update", NULL);
>>>> +       ASSERT_EQ(skel->bss->ca1_cnt, saved_ca1_cnt, "ca2_ca1_cnt");
>>>> +       ASSERT_GT(skel->bss->ca2_cnt, 0, "ca2_ca2_cnt");
>>>
>>> how do we know that struct_ops programs were triggered? what
>>> guarantees that? if nothing, we are just adding another flaky
>>> networking test
>>
>> When an ack is received, cong_control of ca_update_1 and ca_update_2
>> will be called if they are activated.  By checking ca1_cnt & ca2_cnt, we
>> know which one is activated.  Here, we check if the ca1_cnt keeps the
>> same and ca2_cnt increase to make that ca_update_2 have replaced
>> ca_update_1.
> 
> I just don't see anything in the test ensuring that ack is
> sent/received, so it seems like we are relying on some background
> system activity and proper timing (unless I miss something, which is
> why I'm asking), so this is fragile, as in CI environment timings and
> background activity would be very different and unpredictable, causing
> flakiness of the test


The do_test() function creates two sockets to form a direct connection
that must receive at least one acknowledgment packet for the sockets to
progress into an ESTABLISHED state.  If they don't, that means it fails
to establish a connection.

> 
>>
>>>
>>>> +
>>>> +       bpf_link__destroy(link);
>>>> +       tcp_ca_update__destroy(skel);
>>>> +}
>>>> +
>>>>    void test_bpf_tcp_ca(void)
>>>>    {
>>>>           if (test__start_subtest("dctcp"))
>>>> @@ -399,4 +435,6 @@ void test_bpf_tcp_ca(void)
>>>>                   test_incompl_cong_ops();
>>>>           if (test__start_subtest("unsupp_cong_op"))
>>>>                   test_unsupp_cong_op();
>>>> +       if (test__start_subtest("update_ca"))
>>>> +               test_update_ca();
>>>>    }
>>>> diff --git a/tools/testing/selftests/bpf/progs/tcp_ca_update.c b/tools/testing/selftests/bpf/progs/tcp_ca_update.c
>>>> new file mode 100644
>>>> index 000000000000..36a04be95df5
>>>> --- /dev/null
>>>> +++ b/tools/testing/selftests/bpf/progs/tcp_ca_update.c
>>>> @@ -0,0 +1,62 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +
>>>> +#include "vmlinux.h"
>>>> +
>>>> +#include <bpf/bpf_helpers.h>
>>>> +#include <bpf/bpf_tracing.h>
>>>> +
>>>> +char _license[] SEC("license") = "GPL";
>>>> +
>>>> +int ca1_cnt = 0;
>>>> +int ca2_cnt = 0;
>>>> +
>>>> +#define USEC_PER_SEC 1000000UL
>>>> +
>>>> +#define min(a, b) ((a) < (b) ? (a) : (b))
>>>> +
>>>> +static inline struct tcp_sock *tcp_sk(const struct sock *sk)
>>>> +{
>>>> +       return (struct tcp_sock *)sk;
>>>> +}
>>>> +
>>>> +SEC("struct_ops/ca_update_1_cong_control")
>>>> +void BPF_PROG(ca_update_1_cong_control, struct sock *sk,
>>>> +             const struct rate_sample *rs)
>>>> +{
>>>> +       ca1_cnt++;
>>>> +}
>>>> +
>>>> +SEC("struct_ops/ca_update_2_cong_control")
>>>> +void BPF_PROG(ca_update_2_cong_control, struct sock *sk,
>>>> +             const struct rate_sample *rs)
>>>> +{
>>>> +       ca2_cnt++;
>>>> +}
>>>> +
>>>> +SEC("struct_ops/ca_update_ssthresh")
>>>> +__u32 BPF_PROG(ca_update_ssthresh, struct sock *sk)
>>>> +{
>>>> +       return tcp_sk(sk)->snd_ssthresh;
>>>> +}
>>>> +
>>>> +SEC("struct_ops/ca_update_undo_cwnd")
>>>> +__u32 BPF_PROG(ca_update_undo_cwnd, struct sock *sk)
>>>> +{
>>>> +       return tcp_sk(sk)->snd_cwnd;
>>>> +}
>>>> +
>>>> +SEC(".struct_ops.link")
>>>> +struct tcp_congestion_ops ca_update_1 = {
>>>> +       .cong_control = (void *)ca_update_1_cong_control,
>>>> +       .ssthresh = (void *)ca_update_ssthresh,
>>>> +       .undo_cwnd = (void *)ca_update_undo_cwnd,
>>>> +       .name = "tcp_ca_update",
>>>> +};
>>>> +
>>>> +SEC(".struct_ops.link")
>>>> +struct tcp_congestion_ops ca_update_2 = {
>>>> +       .cong_control = (void *)ca_update_2_cong_control,
>>>> +       .ssthresh = (void *)ca_update_ssthresh,
>>>> +       .undo_cwnd = (void *)ca_update_undo_cwnd,
>>>> +       .name = "tcp_ca_update",
>>>> +};
>>>
>>> please add a test where you combine both .struct_ops and
>>> .struct_ops.link, it's an obvious potentially problematic combination
>>>
>>> as I mentioned in previous patches, let's also have a negative test
>>> where bpf_link__update_map() fails
>>
>> Sure
>>
>>>
>>>> --
>>>> 2.34.1
>>>>
