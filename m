Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63ED26B0DDE
	for <lists+bpf@lfdr.de>; Wed,  8 Mar 2023 16:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbjCHP7f (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Mar 2023 10:59:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbjCHP7R (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Mar 2023 10:59:17 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4555BC3616
        for <bpf@vger.kernel.org>; Wed,  8 Mar 2023 07:58:49 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id q189so9883897pga.9
        for <bpf@vger.kernel.org>; Wed, 08 Mar 2023 07:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678291128;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VPyuBJPb5d08MwEoPK5mB7Dm4luF5QmOee8XeXi8Q10=;
        b=kf19M7IP2WcPhzLLpHcsorp7AhmbEvro1uVREi6bXO9ZtpTJSw64ha3MhpXP/CM9MP
         zO9F06nSjTGNWH+AQD3eSSqX5ZMIPfw4gj1KTPmiwb9y9YM9YuihV/q3BUOsqLeFuSKj
         ULy8FKpppSMH0LC2t0wl0+K+11iQ6NoMZlit8Qq8yeo5lnOuvP+Nf5l/DWamiQxVirQS
         Q5EORdLT+PYTBFb0iCWxbA33AiS4tUK2C5isrrAvdKhsdqYNhBQhNbWlImjs1xgedpbg
         W2thtGt3qoGZ+9c/iiZ0QdZh7mijhb6zPPkJyhJZ5w7vY0Qi24FcwbAsABfVJCgrJMcF
         Ubbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678291128;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VPyuBJPb5d08MwEoPK5mB7Dm4luF5QmOee8XeXi8Q10=;
        b=dQqFhRHLk6MVKO9l032qwBewvOfWjCrdDAsAzgAxvsFnq5mubIniCkE/EZH8BP9mUX
         z3CKmknsz9XxLmxmkkEAA9QbJuZwo6pb1g0uP/6JOHvE/42YbWtyOTKIBeI9XXKg0URt
         Cc/R00knOdiimUf/Bn5rqgkKsDYBeOXh8ubQNOevM0se3J6kmfZAesp8BIWNxZ56qdS9
         +lvLTwvhE9vefegF6Uh9xDzDMl0y78sHM6FTTElSvQ4VJJD99MnfyrMUY7+qDSu4CPO2
         Bz6JTy7W8ikQuwK+UMN4Px5Os6RpJV5YADbb7JOixBUnXCezvb6rz9H5LEV70PKpRQA6
         CiKw==
X-Gm-Message-State: AO0yUKVShp1Q/yjHqSgThixUUvT3Uz2FT0HjFWDNyxKb0Pf2/vEAunkT
        cXQKaO56INbJr62xzAlzUpk=
X-Google-Smtp-Source: AK7set/QuPV6LzukvSp3jdY5PYWlo4drFJ/Hdem4cNgHTr+gmqSTVuQDHvzxIDBtYXzFwf//RR5+CQ==
X-Received: by 2002:aa7:973d:0:b0:5a8:ab21:be2e with SMTP id k29-20020aa7973d000000b005a8ab21be2emr13204069pfg.18.1678291127929;
        Wed, 08 Mar 2023 07:58:47 -0800 (PST)
Received: from ?IPV6:2620:10d:c085:21d6::126c? ([2620:10d:c090:400::5:d539])
        by smtp.gmail.com with ESMTPSA id p9-20020a63fe09000000b00502ea3898a7sm9456997pgh.31.2023.03.08.07.58.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 07:58:47 -0800 (PST)
Message-ID: <8678e7e0-ae7a-3230-89d8-af071f800b04@gmail.com>
Date:   Wed, 8 Mar 2023 07:58:36 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH bpf-next v4 9/9] selftests/bpf: Test switching TCP
 Congestion Control algorithms.
Content-Language: en-US, en-ZW
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Kui-Feng Lee <kuifeng@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
        song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
        sdf@google.com
References: <20230307233307.3626875-1-kuifeng@meta.com>
 <20230307233307.3626875-10-kuifeng@meta.com>
 <CAEf4BzauUuFYfUVFSRY6u=NmVUfbmY1pH-p7yXMEWFN1SDjejA@mail.gmail.com>
From:   Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <CAEf4BzauUuFYfUVFSRY6u=NmVUfbmY1pH-p7yXMEWFN1SDjejA@mail.gmail.com>
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



On 3/7/23 17:10, Andrii Nakryiko wrote:
> On Tue, Mar 7, 2023 at 3:34 PM Kui-Feng Lee <kuifeng@meta.com> wrote:
>>
>> Create a pair of sockets that utilize the congestion control algorithm
>> under a particular name. Then switch up this congestion control
>> algorithm to another implementation and check whether newly created
>> connections using the same cc name now run the new implementation.
>>
>> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
>> ---
>>   .../selftests/bpf/prog_tests/bpf_tcp_ca.c     | 38 ++++++++++++
>>   .../selftests/bpf/progs/tcp_ca_update.c       | 62 +++++++++++++++++++
>>   2 files changed, 100 insertions(+)
>>   create mode 100644 tools/testing/selftests/bpf/progs/tcp_ca_update.c
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
>> index e980188d4124..caaa9175ee36 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
>> @@ -8,6 +8,7 @@
>>   #include "bpf_dctcp.skel.h"
>>   #include "bpf_cubic.skel.h"
>>   #include "bpf_tcp_nogpl.skel.h"
>> +#include "tcp_ca_update.skel.h"
>>   #include "bpf_dctcp_release.skel.h"
>>   #include "tcp_ca_write_sk_pacing.skel.h"
>>   #include "tcp_ca_incompl_cong_ops.skel.h"
>> @@ -381,6 +382,41 @@ static void test_unsupp_cong_op(void)
>>          libbpf_set_print(old_print_fn);
>>   }
>>
>> +static void test_update_ca(void)
>> +{
>> +       struct tcp_ca_update *skel;
>> +       struct bpf_link *link;
>> +       int saved_ca1_cnt;
>> +       int err;
>> +
>> +       skel = tcp_ca_update__open();
>> +       if (!ASSERT_OK_PTR(skel, "open"))
>> +               return;
>> +
>> +       err = tcp_ca_update__load(skel);
> 
> tcp_ca_update__open_and_load()
> 
>> +       if (!ASSERT_OK(err, "load")) {
>> +               tcp_ca_update__destroy(skel);
>> +               return;
>> +       }
>> +
>> +       link = bpf_map__attach_struct_ops(skel->maps.ca_update_1);
> 
> I think it's time to generate link holder for each struct_ops map to
> the BPF skeleton, and support auto-attach of struct_ops skeleton.
> Please do that as a follow up, once this patch set lands.

Got it.

> 
>> +       ASSERT_OK_PTR(link, "attach_struct_ops");
>> +
>> +       do_test("tcp_ca_update", NULL);
>> +       saved_ca1_cnt = skel->bss->ca1_cnt;
>> +       ASSERT_GT(saved_ca1_cnt, 0, "ca1_ca1_cnt");
>> +
>> +       err = bpf_link__update_map(link, skel->maps.ca_update_2);
>> +       ASSERT_OK(err, "update_struct_ops");
>> +
>> +       do_test("tcp_ca_update", NULL);
>> +       ASSERT_EQ(skel->bss->ca1_cnt, saved_ca1_cnt, "ca2_ca1_cnt");
>> +       ASSERT_GT(skel->bss->ca2_cnt, 0, "ca2_ca2_cnt");
> 
> how do we know that struct_ops programs were triggered? what
> guarantees that? if nothing, we are just adding another flaky
> networking test

When an ack is received, cong_control of ca_update_1 and ca_update_2
will be called if they are activated.  By checking ca1_cnt & ca2_cnt, we
know which one is activated.  Here, we check if the ca1_cnt keeps the
same and ca2_cnt increase to make that ca_update_2 have replaced
ca_update_1.

> 
>> +
>> +       bpf_link__destroy(link);
>> +       tcp_ca_update__destroy(skel);
>> +}
>> +
>>   void test_bpf_tcp_ca(void)
>>   {
>>          if (test__start_subtest("dctcp"))
>> @@ -399,4 +435,6 @@ void test_bpf_tcp_ca(void)
>>                  test_incompl_cong_ops();
>>          if (test__start_subtest("unsupp_cong_op"))
>>                  test_unsupp_cong_op();
>> +       if (test__start_subtest("update_ca"))
>> +               test_update_ca();
>>   }
>> diff --git a/tools/testing/selftests/bpf/progs/tcp_ca_update.c b/tools/testing/selftests/bpf/progs/tcp_ca_update.c
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
>> +
>> +#define min(a, b) ((a) < (b) ? (a) : (b))
>> +
>> +static inline struct tcp_sock *tcp_sk(const struct sock *sk)
>> +{
>> +       return (struct tcp_sock *)sk;
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
>> +SEC(".struct_ops.link")
>> +struct tcp_congestion_ops ca_update_1 = {
>> +       .cong_control = (void *)ca_update_1_cong_control,
>> +       .ssthresh = (void *)ca_update_ssthresh,
>> +       .undo_cwnd = (void *)ca_update_undo_cwnd,
>> +       .name = "tcp_ca_update",
>> +};
>> +
>> +SEC(".struct_ops.link")
>> +struct tcp_congestion_ops ca_update_2 = {
>> +       .cong_control = (void *)ca_update_2_cong_control,
>> +       .ssthresh = (void *)ca_update_ssthresh,
>> +       .undo_cwnd = (void *)ca_update_undo_cwnd,
>> +       .name = "tcp_ca_update",
>> +};
> 
> please add a test where you combine both .struct_ops and
> .struct_ops.link, it's an obvious potentially problematic combination
> 
> as I mentioned in previous patches, let's also have a negative test
> where bpf_link__update_map() fails

Sure

> 
>> --
>> 2.34.1
>>
