Return-Path: <bpf+bounces-2568-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 133F272F29C
	for <lists+bpf@lfdr.de>; Wed, 14 Jun 2023 04:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 364591C209C5
	for <lists+bpf@lfdr.de>; Wed, 14 Jun 2023 02:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2774442B;
	Wed, 14 Jun 2023 02:34:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A564421
	for <bpf@vger.kernel.org>; Wed, 14 Jun 2023 02:34:47 +0000 (UTC)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7593C1BC5;
	Tue, 13 Jun 2023 19:34:45 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-54fac311c94so1159185a12.3;
        Tue, 13 Jun 2023 19:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686710085; x=1689302085;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cTQxmfVyE7uwyA6JQEgaLbqmCd7eXy/aalgo1LpEu0g=;
        b=mq4rG7mzhtWdrOlbXPRhXocr7VJ4TRc4q87TGZZt+xmh4AXK5TAkFkdK7AOUOF0ok3
         Zfox+aGIvLnFeU5ol0G4emjEmT7BcsH+vqqVC08+qW4iTOp5/5QxhbiFmhYKIa2VMTR5
         xL9Dt8MwVC9/WjJQZyirPww46AKCNL/67ispFqxcWB91ypsMqa/VCWzJzOSosROdCD5t
         tBuIziwMls7+wbDf5O91VnY14k5v5Cn6oPQ2SdGhcaGSKCuFTtVt2Gev3+tAqdPJ9oIG
         GmyOWWUHli8BwVMMSFZ0p6/xlS9++yH84ILOaugSXiDnZUipb0FuYV/UvFFiEDdCWT7n
         0/jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686710085; x=1689302085;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cTQxmfVyE7uwyA6JQEgaLbqmCd7eXy/aalgo1LpEu0g=;
        b=PUQov21ZHOM1MQRU1Pu1V9lSVD/rj3RM0zaZEBu0Tgq3R9pAUQO4+b/xY9JzLYlwlo
         5e/S33e0O7Xccv18TyjwL+tLL40jCLxz/UD1OmJCeieZtuyNAiq/aSVIZ94g55/0oNKa
         nIHZldFixNpiuwUSSYSD/KHk/SNdkOWCSlKJqneamoP3y8qNNiPtw6ivTSkWrkpElvvs
         Qdmf5Ln71mTUDfi2fghL0zL5aQC34e1gM+nSUDABOdUPhrlapI97anXBt9Hv5SoljhwJ
         G7xT4AQNkAzb2thAmPllUAwmuOotb7kH3bNL3KvBbNu8h8YYw+NnZ+7N7G608MzO0LkH
         6rqA==
X-Gm-Message-State: AC+VfDxprhwJLRzlZY1C8ELm/evOODWWIoxcNjESaVHAkwcN/LdzYFEK
	H83sJT8XQTlHeTpExwJpfj4=
X-Google-Smtp-Source: ACHHUZ7+k3wgHl1n+7ApyC1gbtquCwFkCVvCKS0LdKLYhFhtQQVivduq7R9y5mTTzYmATSoNRERgvQ==
X-Received: by 2002:a05:6a20:6a11:b0:ff:c184:7c76 with SMTP id p17-20020a056a206a1100b000ffc1847c76mr467272pzk.24.1686710084715;
        Tue, 13 Jun 2023 19:34:44 -0700 (PDT)
Received: from ?IPV6:2620:10d:c085:21c8::1259? ([2620:10d:c090:400::5:86a3])
        by smtp.gmail.com with ESMTPSA id g18-20020a170902869200b001b01fc7337csm10887812plo.247.2023.06.13.19.34.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 19:34:44 -0700 (PDT)
Message-ID: <394cb661-4d19-8d44-d211-526fb80024ec@gmail.com>
Date: Tue, 13 Jun 2023 19:34:41 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 bpf-next 08/10] bpf: Support ->fill_link_info for
 perf_event
Content-Language: en-US
To: Yafang Shao <laoar.shao@gmail.com>, Yonghong Song <yhs@meta.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 quentin@isovalent.com, rostedt@goodmis.org, mhiramat@kernel.org,
 bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20230612151608.99661-1-laoar.shao@gmail.com>
 <20230612151608.99661-9-laoar.shao@gmail.com>
 <09da5bbd-1ef1-edd3-d83c-bba04b4f53da@meta.com>
 <CALOAHbCfEDmkbLeQG1wmBF7q3AaMSyZpxRGyFJ=9VugUdDpCsQ@mail.gmail.com>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <CALOAHbCfEDmkbLeQG1wmBF7q3AaMSyZpxRGyFJ=9VugUdDpCsQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 6/12/23 19:47, Yafang Shao wrote:
> On Tue, Jun 13, 2023 at 1:36 AM Yonghong Song <yhs@meta.com> wrote:
>>
>>
>>
>> On 6/12/23 8:16 AM, Yafang Shao wrote:
>>> By introducing support for ->fill_link_info to the perf_event link, users
>>> gain the ability to inspect it using `bpftool link show`. While the current
>>> approach involves accessing this information via `bpftool perf show`,
>>> consolidating link information for all link types in one place offers
>>> greater convenience. Additionally, this patch extends support to the
>>> generic perf event, which is not currently accommodated by
>>> `bpftool perf show`. While only the perf type and config are exposed to
>>> userspace, other attributes such as sample_period and sample_freq are
>>> ignored. It's important to note that if kptr_restrict is not permitted, the
>>> probed address will not be exposed, maintaining security measures.
>>>
>>> A new enum bpf_link_perf_event_type is introduced to help the user
>>> understand which struct is relevant.
>>>
>>> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
>>> ---
>>>    include/uapi/linux/bpf.h       |  32 +++++++++++
>>>    kernel/bpf/syscall.c           | 124 +++++++++++++++++++++++++++++++++++++++++
>>>    tools/include/uapi/linux/bpf.h |  32 +++++++++++
>>>    3 files changed, 188 insertions(+)
>>>
>>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>>> index 23691ea..8d4556e 100644
>>> --- a/include/uapi/linux/bpf.h
>>> +++ b/include/uapi/linux/bpf.h
>>> @@ -1056,6 +1056,16 @@ enum bpf_link_type {
>>>        MAX_BPF_LINK_TYPE,
>>>    };
>>>
>>> +enum bpf_perf_link_type {
>>> +     BPF_PERF_LINK_UNSPEC = 0,
>>> +     BPF_PERF_LINK_UPROBE = 1,
>>> +     BPF_PERF_LINK_KPROBE = 2,
>>> +     BPF_PERF_LINK_TRACEPOINT = 3,
>>> +     BPF_PERF_LINK_PERF_EVENT = 4,
>>> +
>>> +     MAX_BPF_LINK_PERF_EVENT_TYPE,
>>> +};
>>> +
>>>    /* cgroup-bpf attach flags used in BPF_PROG_ATTACH command
>>>     *
>>>     * NONE(default): No further bpf programs allowed in the subtree.
>>> @@ -6443,7 +6453,29 @@ struct bpf_link_info {
>>>                        __u32 count;
>>>                        __u32 flags;
>>>                } kprobe_multi;
>>> +             struct {
>>> +                     __u64 config;
>>> +                     __u32 type;
>>> +             } perf_event; /* BPF_LINK_PERF_EVENT_PERF_EVENT */
>>> +             struct {
>>> +                     __aligned_u64 file_name; /* in/out: buff ptr */
>>> +                     __u32 name_len;
>>> +                     __u32 offset;            /* offset from name */
>>> +                     __u32 flags;
>>> +             } uprobe; /* BPF_LINK_PERF_EVENT_UPROBE */
>>> +             struct {
>>> +                     __aligned_u64 func_name; /* in/out: buff ptr */
>>> +                     __u32 name_len;
>>> +                     __u32 offset;            /* offset from name */
>>> +                     __u64 addr;
>>> +                     __u32 flags;
>>> +             } kprobe; /* BPF_LINK_PERF_EVENT_KPROBE */
>>> +             struct {
>>> +                     __aligned_u64 tp_name;   /* in/out: buff ptr */
>>> +                     __u32 name_len;
>>> +             } tracepoint; /* BPF_LINK_PERF_EVENT_TRACEPOINT */
>>>        };
>>> +     __u32 perf_link_type; /* enum bpf_perf_link_type */
>>
>> I think put perf_link_type into each indivual struct is better.
>> It won't increase the bpf_link_info struct size. It will allow
>> extensions for all structs in the big union (raw_tracepoint,
>> tracing, cgroup, iter, ..., kprobe_multi, ...) etc.
> 
> If we put it into each individual struct, we have to choose one
> specific struct to get the type before we use the real struct, for
> example,
>      if (info.perf_event.type == BPF_PERF_LINK_PERF_EVENT)
>                goto out;
>      if (info.perf_event.type == BPF_PERF_LINK_TRACEPOINT &&
>                 !info.tracepoint.tp_name) {
>                 info.tracepoint.tp_name = (unsigned long)&buf;
>                 info.tracepoint.name_len = sizeof(buf);
>                 goto again;
>        }
>        ...
> 
> That doesn't look perfect.

How about adding a common struct?

  struct {
        __u32 type;
  } perf_common;

Then you check info.perf_common.type.


> 
> However I agree with you that the perf_link_type may disallow the
> extensions for the big union.  I will think about it.
> 

