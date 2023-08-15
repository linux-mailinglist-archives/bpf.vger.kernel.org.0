Return-Path: <bpf+bounces-7785-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD93F77C670
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 05:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5DDB1C20BFE
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 03:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8881FDF;
	Tue, 15 Aug 2023 03:40:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623171C13
	for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 03:40:59 +0000 (UTC)
Received: from out-125.mta1.migadu.com (out-125.mta1.migadu.com [IPv6:2001:41d0:203:375::7d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A43FE73
	for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 20:40:55 -0700 (PDT)
Message-ID: <39dfc028-1dc7-286b-57e6-271ca588bd68@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1692070853; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RFcbhSIHFN/1ulSMz9ceaxTvELA9lidVkcQJtkEUjU8=;
	b=YUvCAePq0C3+i0gSxtJXUEvVUFphm+HVgk090m27+JmZct36O/0AS6VyR+uLoZdxUrHokL
	/sOfS0P3T+R4x1Dzq9oqVXO0DYf53GmhfnvHftu6E03asoO7KCECqe1zoutl8T08g9vAqq
	hvSF5FjxG6wd/tJHaPiBpPXHMr6NLUs=
Date: Mon, 14 Aug 2023 20:40:45 -0700
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
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CALOAHbC9cka4Ma7KWOjGtFkjshU214z9NMaYXHiOTfc7dc7=tQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/14/23 7:45 PM, Yafang Shao wrote:
> On Tue, Aug 15, 2023 at 8:28 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>>
>>
>> On 8/14/23 7:33 AM, Yafang Shao wrote:
>>> Add a new bpf_current_capable kfunc to check whether the current task
>>> has a specific capability. In our use case, we will use it in a lsm bpf
>>> program to help identify if the user operation is permitted.
>>>
>>> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
>>> ---
>>>    kernel/bpf/helpers.c | 6 ++++++
>>>    1 file changed, 6 insertions(+)
>>>
>>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>>> index eb91cae..bbee7ea 100644
>>> --- a/kernel/bpf/helpers.c
>>> +++ b/kernel/bpf/helpers.c
>>> @@ -2429,6 +2429,11 @@ __bpf_kfunc void bpf_rcu_read_unlock(void)
>>>        rcu_read_unlock();
>>>    }
>>>
>>> +__bpf_kfunc bool bpf_current_capable(int cap)
>>> +{
>>> +     return has_capability(current, cap);
>>> +}
>>
>> Since you are testing against 'current' capabilities, I assume
>> that the context should be process. Otherwise, you are testing
>> against random task which does not make much sense.
> 
> It is in the process context.
> 
>>
>> Since you are testing against 'current' cap, and if the capability
>> for that task is stable, you do not need this kfunc.
>> You can test cap in user space and pass it into the bpf program.
>>
>> But if the cap for your process may change in the middle of
>> run, then you indeed need bpf prog to test capability in real time.
>> Is this your use case and could you describe in in more detail?
> 
> After we convert the capability of our networking bpf program from
> CAP_SYS_ADMIN to CAP_BPF+CAP_NET_ADMIN to enhance the security, we
> encountered the "pointer comparison prohibited" error, because

Could you give a reproducible test case for this verifier failure
with CAP_BPF+CAP_NET_ADMIN capability? Is this due to packet pointer
or something else? Maybe verifier needs to be improved in these
cases without violating the promise of allow_ptr_leaks?

> allow_ptr_leaks is enabled only when CAP_PERFMON is set. However, if
> we enable the CAP_PERFMON for the networking bpf program, it can run
> tracing bpf prog, perf_event bpf prog and etc, that is not expected by
> us.
> 
> Hence we are planning to use a lsm bpf program to disallow it from
> running other bpf programs. In our lsm bpf program we will check the
> capability of processes, if the process has cap_net_admin, cap_bpf and
> cap_perfmon but don't have cap_sys_admin we will refuse it to run
> tracing and perf_event bpf program. While if a process has  cap_bpf
> and cap_perfmon but doesn't have cap_net_admin, that said it is a bpf
> program which wants to run trace bpf, we will allow it.
> 
> We can't use lsm_cgroup because it is supported on cgroup2 only, while
> we're still using cgroup1.
> 
> Another possible solution is enable allow_ptr_leaks for cap_net_admin
> as well, but after I checked the commit which introduces the cap_bpf
> and cap_perfmon [1], I think we wouldn't like to do it.
> 
> [1]. https://lore.kernel.org/bpf/20200513230355.7858-3-alexei.starovoitov@gmail.com/

