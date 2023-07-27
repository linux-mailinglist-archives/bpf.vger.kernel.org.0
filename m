Return-Path: <bpf+bounces-6031-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5881764396
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 03:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D95C31C21478
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 01:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E212015BE;
	Thu, 27 Jul 2023 01:57:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A297C;
	Thu, 27 Jul 2023 01:57:33 +0000 (UTC)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F70212A;
	Wed, 26 Jul 2023 18:57:32 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-666edfc50deso254586b3a.0;
        Wed, 26 Jul 2023 18:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690423051; x=1691027851;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LEjsP/ltbm5croJfxAs5qlFOgriD4zQ0avuotGYBbu4=;
        b=eahNYGggeEgvUDyzlrIDhQQo1b2wEk+7H/Ca1jCf76MDplSkUIUN1YTX7vg6hfjaB1
         FIRMYg2akZseLF37c1g/4dyPCO56IVd3vAOfh+fhvlGX/rmMy8FMWvXi3EnqyHFrU8mR
         Qwttgzji9V/IcTt4pqUumai3R+9vz3qO51k7A9b5E6MgNttXaaAjVPO+Vd5Bx0uq3Gf8
         U1WF8var4akqoo4V5xotMXoq7Q6j3OzOWNz23EJuLYSGXqlwICnkkv1/aDgvtG0ysKMx
         FYURav52FaO9iwMGkHN1fvxpSuqBhmUZVt7VdRlrfKJj4UXGZsAO6ZgMmnJlsmIFAtgt
         Ksiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690423051; x=1691027851;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LEjsP/ltbm5croJfxAs5qlFOgriD4zQ0avuotGYBbu4=;
        b=kbWh+/eFARSO3AxnPkEpU0VNvCHeCAyWMpvulMvnZ6XhIu0fH+TgEp3d7EsXcSm0Bp
         0MqZ4XV3Vdujka4MeFBrLR80M5keFR/PBMC8ecXwQMgDDzOaBbaYJ0m75rRFRyo60Yeu
         elqzs8owG66pnJ6S6Nl5Vjgv+2J9ZfqDH2KmNCUguWHtwIgQMrQklfS8mHT4xfcuglGu
         HK2G+4Ox3DzYJhHcf/0mFdY63Fx6o0+OrznO1GAHHOAmwoSbCcbkBJUJlZ8H9BBEc9nO
         D1ShypJ2YVF1++nhe193L2gwehUEedgK/5b9p7xr680hT7E0OUdMwMETFWQRMnEe29kY
         SEXw==
X-Gm-Message-State: ABy/qLYpKGHJ+z64y2VQIppFnE/zcFoytL/yvB3ZB9XCKlWDaGF2J8s6
	TiZqsHBMEuHyvih9TY2VtCg=
X-Google-Smtp-Source: APBJJlEBJ5hmV0TI+3igCwAAXKrV3f3iRW2hHj66Vn9M8yi4NRyOIXRzPPVSjSOKYkiw6fAtAPdtmw==
X-Received: by 2002:a05:6a21:788f:b0:117:3c00:77ea with SMTP id bf15-20020a056a21788f00b001173c0077eamr1404141pzc.0.1690423051326;
        Wed, 26 Jul 2023 18:57:31 -0700 (PDT)
Received: from [10.22.68.111] ([122.11.166.8])
        by smtp.gmail.com with ESMTPSA id c17-20020aa78811000000b0066ccb8e8024sm262131pfo.30.2023.07.26.18.57.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 18:57:30 -0700 (PDT)
Message-ID: <f1506d01-6063-e314-832b-ad3c72a580f1@gmail.com>
Date: Thu, 27 Jul 2023 09:57:25 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [RESEND PATCH bpf-next v3 2/2] selftests/bpf: Add testcase for
 xdp attaching failure tracepoint
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, song@kernel.org, yhs@fb.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, hawk@kernel.org,
 tangyeechou@gmail.com, kernel-patches-bot@fb.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20230720155228.5708-1-hffilwlqm@gmail.com>
 <20230720155228.5708-3-hffilwlqm@gmail.com>
 <d988118b-3e02-24e3-281a-cff821f7abef@linux.dev>
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <d988118b-3e02-24e3-281a-cff821f7abef@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
	HK_RANDOM_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 27/7/23 05:52, Martin KaFai Lau wrote:
> On 7/20/23 8:52 AM, Leon Hwang wrote:
>> Add a test case for the tracepoint of xdp attaching failure by bpf
>> tracepoint when attach XDP to a device with invalid flags option.
>>
>> The bpf tracepoint retrieves error message from the tracepoint, and
>> then put the error message to a perf buffer. The testing code receives
>> error message from perf buffer, and then ASSERT "Invalid XDP flags for
>> BPF link attachment".
>>
>> Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
>> ---
>>   .../selftests/bpf/prog_tests/xdp_attach.c     | 65 +++++++++++++++++++
>>   .../bpf/progs/test_xdp_attach_fail.c          | 52 +++++++++++++++
>>   2 files changed, 117 insertions(+)
>>   create mode 100644 tools/testing/selftests/bpf/progs/test_xdp_attach_fail.c
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_attach.c b/tools/testing/selftests/bpf/prog_tests/xdp_attach.c
>> index fa3cac5488f5d..99f8d03f3c8bd 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/xdp_attach.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_attach.c
>> @@ -1,5 +1,6 @@
>>   // SPDX-License-Identifier: GPL-2.0
>>   #include <test_progs.h>
>> +#include "test_xdp_attach_fail.skel.h"
>>     #define IFINDEX_LO 1
>>   #define XDP_FLAGS_REPLACE        (1U << 4)
>> @@ -85,10 +86,74 @@ static void test_xdp_attach(const char *file)
>>       bpf_object__close(obj1);
>>   }
>>   +struct xdp_errmsg {
>> +    char msg[64];
>> +};
>> +
>> +static void on_xdp_errmsg(void *ctx, int cpu, void *data, __u32 size)
>> +{
>> +    struct xdp_errmsg *ctx_errmg = ctx, *tp_errmsg = data;
>> +
>> +    memcpy(&ctx_errmg->msg, &tp_errmsg->msg, size);
>> +}
>> +
>> +static const char tgt_errmsg[] = "Invalid XDP flags for BPF link attachment";
>> +
>> +static void test_xdp_attach_fail(const char *file)
> 
> The test crashed: https://github.com/kernel-patches/bpf/actions/runs/5672753995/job/15373384795#step:6:8037
> 
> Please monitor the CI test result in the future.
> 

Get it. I'll fix it as soon as possible. And make sure all the CI tests are passed.

>> +{
>> +    __u32 duration = 0;
>> +    int err, fd_xdp, fd_link_xdp;
>> +    struct bpf_object *obj = NULL;
>> +    struct test_xdp_attach_fail *skel = NULL;
>> +    struct bpf_link *link = NULL;
>> +    struct perf_buffer *pb = NULL;
>> +    struct xdp_errmsg errmsg = {};
>> +
>> +    LIBBPF_OPTS(bpf_link_create_opts, opts);
>> +
>> +    skel = test_xdp_attach_fail__open_and_load();
>> +    if (!ASSERT_OK_PTR(skel, "test_xdp_attach_fail_skel"))
>> +        goto out_close;
>> +
>> +    link = bpf_program__attach_tracepoint(skel->progs.tp__xdp__bpf_xdp_link_attach_failed,
>> +                          "xdp", "bpf_xdp_link_attach_failed");
>> +    if (!ASSERT_OK_PTR(link, "attach_tp"))
>> +        goto out_close;
>> +
>> +    /* set up perf buffer */
>> +    pb = perf_buffer__new(bpf_map__fd(skel->maps.xdp_errmsg_pb), 1,
>> +                  on_xdp_errmsg, NULL, &errmsg, NULL);
>> +
>> +    err = bpf_prog_test_load(file, BPF_PROG_TYPE_XDP, &obj, &fd_xdp);
>> +    if (CHECK_FAIL(err))
>> +        goto out_close;
>> +
>> +    opts.flags = 0xFF; // invalid flags to fail to attach XDP prog
>> +    fd_link_xdp = bpf_link_create(fd_xdp, IFINDEX_LO, BPF_XDP, &opts);
>> +    if (CHECK(fd_link_xdp != -22, "bpf_link_create_failed",
> 
> Please stay with the ASSERT_* macro.
> 

Get it.


Thanks,
Leon

