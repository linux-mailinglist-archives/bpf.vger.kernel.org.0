Return-Path: <bpf+bounces-7816-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 456F377CEF5
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 17:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2E4C2814F3
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 15:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7EF14AA9;
	Tue, 15 Aug 2023 15:19:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9050111B0
	for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 15:19:50 +0000 (UTC)
Received: from out-23.mta1.migadu.com (out-23.mta1.migadu.com [95.215.58.23])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0814CE5
	for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 08:19:48 -0700 (PDT)
Message-ID: <66b509b5-ec11-9d02-41e6-a98124ee3cd8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1692112787; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SvAk+vUX7cu3HocwquByTDD888HZRuYkU1uEyKA4TNg=;
	b=tjO7IQKuAFadmkDZ9lRYbksnghy2++7u5788n0izSQid0JGpZsxi2kB4hj/ZePWqXbaTFj
	+UsXEg0W7V4R9BWC/Q+8AGREtHThy9KAyJ4Ul8WN5KV7cJsU0mJkLGdvDnTWIX2McSz5Ur
	Ah+JzG692HPsbchaLxy18GtDl2eY1wM=
Date: Tue, 15 Aug 2023 08:19:42 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [RFC PATCH bpf-next 1/2] bpf: Add bpf_current_capable kfunc
Content-Language: en-US
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 bpf@vger.kernel.org
References: <20230814143341.3767-1-laoar.shao@gmail.com>
 <20230814143341.3767-2-laoar.shao@gmail.com>
 <56dc2449-f01c-f0a7-e31b-cfe6cd157aaa@linux.dev>
 <CALOAHbC9cka4Ma7KWOjGtFkjshU214z9NMaYXHiOTfc7dc7=tQ@mail.gmail.com>
 <39dfc028-1dc7-286b-57e6-271ca588bd68@linux.dev>
 <CALOAHbAqVLjQ+M+GCwywN3WeCSD=Hjx+GcBgtSC6Ws0Ef6x6Tw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CALOAHbAqVLjQ+M+GCwywN3WeCSD=Hjx+GcBgtSC6Ws0Ef6x6Tw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/14/23 10:49 PM, Yafang Shao wrote:
> On Tue, Aug 15, 2023 at 11:40 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>>
>>
>> On 8/14/23 7:45 PM, Yafang Shao wrote:
>>> On Tue, Aug 15, 2023 at 8:28 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>>>>
>>>>
>>>>
>>>> On 8/14/23 7:33 AM, Yafang Shao wrote:
>>>>> Add a new bpf_current_capable kfunc to check whether the current task
>>>>> has a specific capability. In our use case, we will use it in a lsm bpf
>>>>> program to help identify if the user operation is permitted.
>>>>>
>>>>> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
>>>>> ---
>>>>>     kernel/bpf/helpers.c | 6 ++++++
>>>>>     1 file changed, 6 insertions(+)
>>>>>
>>>>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>>>>> index eb91cae..bbee7ea 100644
>>>>> --- a/kernel/bpf/helpers.c
>>>>> +++ b/kernel/bpf/helpers.c
>>>>> @@ -2429,6 +2429,11 @@ __bpf_kfunc void bpf_rcu_read_unlock(void)
>>>>>         rcu_read_unlock();
>>>>>     }
>>>>>
>>>>> +__bpf_kfunc bool bpf_current_capable(int cap)
>>>>> +{
>>>>> +     return has_capability(current, cap);
>>>>> +}
>>>>
>>>> Since you are testing against 'current' capabilities, I assume
>>>> that the context should be process. Otherwise, you are testing
>>>> against random task which does not make much sense.
>>>
>>> It is in the process context.
>>>
>>>>
>>>> Since you are testing against 'current' cap, and if the capability
>>>> for that task is stable, you do not need this kfunc.
>>>> You can test cap in user space and pass it into the bpf program.
>>>>
>>>> But if the cap for your process may change in the middle of
>>>> run, then you indeed need bpf prog to test capability in real time.
>>>> Is this your use case and could you describe in in more detail?
>>>
>>> After we convert the capability of our networking bpf program from
>>> CAP_SYS_ADMIN to CAP_BPF+CAP_NET_ADMIN to enhance the security, we
>>> encountered the "pointer comparison prohibited" error, because
>>
>> Could you give a reproducible test case for this verifier failure
>> with CAP_BPF+CAP_NET_ADMIN capability? Is this due to packet pointer
>> or something else? Maybe verifier needs to be improved in these
>> cases without violating the promise of allow_ptr_leaks?
> 
> Here it is.
> 
> SEC("cls-ingress")
> int ingress(struct __sk_buff *skb)
> {
>          struct iphdr *iph = (void *)(long)skb->data + sizeof(struct ethhdr);
> 
>          if ((long)(iph + 1) > (long)skb->data_end)
>                  return TC_ACT_STOLEN;
>          return TC_ACT_OK;
> }
> 
> In this bpf prog, it will compare the pointer iph with skb->data_end,
> and thus it will fail the verifier.

Thanks. In this particular case, I think comparing packet ptr and 
data_end should not be considered as ptr_leaks. Probably Alexei
and Daniel can comment on this too.

