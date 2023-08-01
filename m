Return-Path: <bpf+bounces-6615-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD58076BE63
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 22:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19B971C21018
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 20:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07C6263AC;
	Tue,  1 Aug 2023 20:18:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75D84DC6B
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 20:18:32 +0000 (UTC)
Received: from out-85.mta0.migadu.com (out-85.mta0.migadu.com [IPv6:2001:41d0:1004:224b::55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A97268C
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 13:18:29 -0700 (PDT)
Message-ID: <10d4b655-6232-efbd-9b5f-7d4637ef197d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1690921107; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IAo7WK+FXPsiNvfokH4Ee2k01vITZ5bQLjQP3UF12ws=;
	b=qVb/V7Abqk02sUZpjHgDTYH4khv1j4ubIKa/QPYOo6dadQ31poq4wk6ChcWO8PnkTbDzs3
	KcLOAt61YvJ5mo7Ht601HHgr5ukDn5jM5FRNPDDxS8yNhtyoKVHp+qdLno1YW/mDtQXPMs
	Dx4mxJ+IVdjeE7tgsBQJgSWeNRfeR/k=
Date: Tue, 1 Aug 2023 13:18:21 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next 1/3] bpf: Add support for bpf_get_func_ip helper
 for uprobe program
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
To: Yafang Shao <laoar.shao@gmail.com>, Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
 Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>
References: <20230801073002.1006443-1-jolsa@kernel.org>
 <20230801073002.1006443-2-jolsa@kernel.org>
 <CALOAHbDdurfzh7jRfqWVVS5RFRT44fx3zjQRNN8B66HJDNogAQ@mail.gmail.com>
 <20f1cf2e-6145-000a-0344-4c03c7b54e28@linux.dev>
In-Reply-To: <20f1cf2e-6145-000a-0344-4c03c7b54e28@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/1/23 12:44 PM, Yonghong Song wrote:
> 
> 
> On 8/1/23 4:53 AM, Yafang Shao wrote:
>> On Tue, Aug 1, 2023 at 3:30 PM Jiri Olsa <jolsa@kernel.org> wrote:
>>>
>>> Adding support for bpf_get_func_ip helper for uprobe program to return
>>> probed address for both uprobe and return uprobe.
>>>
>>> We discussed this in [1] and agreed that uprobe can have special use
>>> of bpf_get_func_ip helper that differs from kprobe.
>>>
>>> The kprobe bpf_get_func_ip returns:
>>>    - address of the function if probe is attach on function entry
>>>      for both kprobe and return kprobe
>>>    - 0 if the probe is not attach on function entry
>>>
>>> The uprobe bpf_get_func_ip returns:
>>>    - address of the probe for both uprobe and return uprobe
>>>
>>> The reason for this semantic change is that kernel can't really tell
>>> if the probe user space address is function entry.
>>>
>>> The uprobe program is actually kprobe type program attached as uprobe.
>>> One of the consequences of this design is that uprobes do not have its
>>> own set of helpers, but share them with kprobes.
>>>
>>> As we need different functionality for bpf_get_func_ip helper for 
>>> uprobe,
>>> I'm adding the bool value to the bpf_trace_run_ctx, so the helper can
>>> detect that it's executed in uprobe context and call specific code.
>>>
>>> The is_uprobe bool is set as true in bpf_prog_run_array_sleepable which
>>> is currently used only for executing bpf programs in uprobe.
>>
>> That is error-prone.  If we don't intend to rename
>> bpf_prog_run_array_sleepable() to bpf_prog_run_array_uprobe(), I think
>> we'd better introduce a new parameter 'bool is_uprobe' into it.
> 
> Agree that renaming bpf_prog_run_array_sleepable() to
> bpf_prog_run_array_uprobe() probably better. This way, it is
> self-explainable for `run_ctx.is_uprobe = true`.
> 
> If unlikely case in the future, another sleepable run prog array
> is needed. They can have their own bpf_prog_run_array_<..>
> and underlying bpf_prog_run_array_sleepable() can be factored out.

Or if want to avoid unnecessary code churn, at least add
a comment in bpf_prog_run_array_sleepable() to explain
that why it is safe to do `run_ctx.is_uprobe = true;`.

> 
>>
>>>
>>> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
>>> [1] 
>>> https://lore.kernel.org/bpf/CAEf4BzZ=xLVkG5eurEuvLU79wAMtwho7ReR+XJAgwhFF4M-7Cg@mail.gmail.com/
>>> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
>>> ---
>>>   include/linux/bpf.h            |  5 +++++
>>>   include/uapi/linux/bpf.h       |  7 ++++++-
>>>   kernel/trace/bpf_trace.c       | 21 ++++++++++++++++++++-
>>>   kernel/trace/trace_probe.h     |  5 +++++
>>>   kernel/trace/trace_uprobe.c    |  5 -----
>>>   tools/include/uapi/linux/bpf.h |  7 ++++++-
>>>   6 files changed, 42 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>>> index ceaa8c23287f..8ea071383ef1 100644
>>> --- a/include/linux/bpf.h
>>> +++ b/include/linux/bpf.h
>>> @@ -1819,6 +1819,7 @@ struct bpf_cg_run_ctx {
>>>   struct bpf_trace_run_ctx {
>>>          struct bpf_run_ctx run_ctx;
>>>          u64 bpf_cookie;
>>> +       bool is_uprobe;
>>>   };
>>>
>>>   struct bpf_tramp_run_ctx {
>>> @@ -1867,6 +1868,8 @@ bpf_prog_run_array(const struct bpf_prog_array 
>>> *array,
>>>          if (unlikely(!array))
>>>                  return ret;
>>>
>>> +       run_ctx.is_uprobe = false;
>>> +
>>>          migrate_disable();
>>>          old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
>>>          item = &array->items[0];
>>> @@ -1906,6 +1909,8 @@ bpf_prog_run_array_sleepable(const struct 
>>> bpf_prog_array __rcu *array_rcu,
>>>          rcu_read_lock_trace();
>>>          migrate_disable();
>>>
>>> +       run_ctx.is_uprobe = true;
>>> +
>>>          array = rcu_dereference_check(array_rcu, 
>>> rcu_read_lock_trace_held());
>>>          if (unlikely(!array))
>>>                  goto out;
> [...]
> 

