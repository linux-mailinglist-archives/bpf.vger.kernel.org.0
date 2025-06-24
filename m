Return-Path: <bpf+bounces-61358-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F89AE5FA6
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 10:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 366F27AAE56
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 08:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9AA26A1CF;
	Tue, 24 Jun 2025 08:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rGHG0uzv"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE4526A1B6;
	Tue, 24 Jun 2025 08:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750754491; cv=none; b=QbvZFQMShmzuTf2ykiZF6ij0ijFTuJ6dNYq7LZEnsgOtQY6YdWDQwIGNf5Zm4xEp2omhwXWr5OuQbLNyTsvVXMR0XFpvrwUtZAjpK8RZjZoSUWhX+bc0pjk70mRxAv3so/HPo0gBKRWpzH+iF+ledbTUTSPWlQHJf5bMLFXUc+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750754491; c=relaxed/simple;
	bh=ztZh7mz/a3j9KG8cS+UzY10q30DeYc8CF1/dXuCQmsE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZI2L8DQlR/YGPp6Dg/Au6lLRdxt4FjyXmL1jDodAEsjjtJ9SshapkSEbNeEAgan8+NYvpoG09vqCH3b8ZPwkw751AhHUcWLSA9JEVM/IGH3KFGtdy/pAzyAJE4J2xy24U5ashe/x1L2zBuw4GFr9CRoyKSuNL9pkjt+BuQW35N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rGHG0uzv; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9034e367-e7e1-43b5-bd7c-70fc9a58335d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750754485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gCp9O6FP7lAapUYvR/E0GJYFRXsfzMtADoUf1M9Lpw4=;
	b=rGHG0uzvuVO7/8YuzW9HIMvfUNk/DM7SPLU+z+vdhmW5mn4ZrJuQYmq2ryBQZKsIvQhh+I
	ZUErfP4AaC/zKDi+kHZKU3Rk+ric2qRwNLrprgU3s5cC9ZWvufex3unYigFEY8U5o1F2VA
	bVNfD72bHeWMBEGgmrxrvJtMYRGFWrw=
Date: Tue, 24 Jun 2025 16:41:17 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 1/3] bpf: Show precise link_type for
 {uprobe,kprobe}_multi fdinfo
To: Jiri Olsa <olsajiri@gmail.com>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>,
 Song Liu <song@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
References: <20250623134342.227347-1-chen.dylane@linux.dev>
 <CAADnVQ+aZw4-3Ab9nLWrZUg78sc-SXuEGYnPrdOChw8m9sRLvw@mail.gmail.com>
 <CAEf4BzZVw4aSpdTH+VKkG_q6J-sQwSFSCyU+-c5DcA5euP49ng@mail.gmail.com>
 <aFpeyZnOuJ3Xr4J6@krava>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <aFpeyZnOuJ3Xr4J6@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/6/24 16:16, Jiri Olsa 写道:
> On Mon, Jun 23, 2025 at 01:59:18PM -0700, Andrii Nakryiko wrote:
>> On Mon, Jun 23, 2025 at 10:56 AM Alexei Starovoitov
>> <alexei.starovoitov@gmail.com> wrote:
>>>
>>> On Mon, Jun 23, 2025 at 6:44 AM Tao Chen <chen.dylane@linux.dev> wrote:
>>>>
>>>> Alexei suggested, 'link_type' can be more precise and differentiate
>>>> for human in fdinfo. In fact BPF_LINK_TYPE_KPROBE_MULTI includes
>>>> kretprobe_multi type, the same as BPF_LINK_TYPE_UPROBE_MULTI, so we
>>>> can show it more concretely.
>>>>
>>>> link_type:      kprobe_multi
>>>> link_id:        1
>>>> prog_tag:       d2b307e915f0dd37
>>>> ...
>>>> link_type:      kretprobe_multi
>>>> link_id:        2
>>>> prog_tag:       ab9ea0545870781d
>>>> ...
>>>> link_type:      uprobe_multi
>>>> link_id:        9
>>>> prog_tag:       e729f789e34a8eca
>>>> ...
>>>> link_type:      uretprobe_multi
>>>> link_id:        10
>>>> prog_tag:       7db356c03e61a4d4
>>>>
>>>> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
>>>> ---
>>>>   include/linux/trace_events.h | 10 ++++++++++
>>>>   kernel/bpf/syscall.c         |  9 ++++++++-
>>>>   kernel/trace/bpf_trace.c     | 28 ++++++++++++++++++++++++++++
>>>>   3 files changed, 46 insertions(+), 1 deletion(-)
>>>>
>>>> Change list:
>>>>    v4 -> v5:
>>>>      - Add patch1 to show precise link_type for
>>>>        {uprobe,kprobe}_multi.(Alexei)
>>>>      - patch2,3 just remove type field, which will be showed in
>>>>        link_type
>>>>    v4:
>>>>    https://lore.kernel.org/bpf/20250619034257.70520-1-chen.dylane@linux.dev
>>>>
>>>>    v3 -> v4:
>>>>      - use %pS to print func info.(Alexei)
>>>>    v3:
>>>>    https://lore.kernel.org/bpf/20250616130233.451439-1-chen.dylane@linux.dev
>>>>
>>>>    v2 -> v3:
>>>>      - show info in one line for multi events.(Jiri)
>>>>    v2:
>>>>    https://lore.kernel.org/bpf/20250615150514.418581-1-chen.dylane@linux.dev
>>>>
>>>>    v1 -> v2:
>>>>      - replace 'func_cnt' with 'uprobe_cnt'.(Andrii)
>>>>      - print func name is more readable and security for kprobe_multi.(Alexei)
>>>>    v1:
>>>>    https://lore.kernel.org/bpf/20250612115556.295103-1-chen.dylane@linux.dev
>>>>
>>>> diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
>>>> index fa9cf4292df..951c91babbc 100644
>>>> --- a/include/linux/trace_events.h
>>>> +++ b/include/linux/trace_events.h
>>>> @@ -780,6 +780,8 @@ int bpf_get_perf_event_info(const struct perf_event *event, u32 *prog_id,
>>>>                              unsigned long *missed);
>>>>   int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog);
>>>>   int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog);
>>>> +void bpf_kprobe_multi_link_type_show(const struct bpf_link *link, char *link_type, int len);
>>>> +void bpf_uprobe_multi_link_type_show(const struct bpf_link *link, char *link_type, int len);
>>>>   #else
>>>>   static inline unsigned int trace_call_bpf(struct trace_event_call *call, void *ctx)
>>>>   {
>>>> @@ -832,6 +834,14 @@ bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
>>>>   {
>>>>          return -EOPNOTSUPP;
>>>>   }
>>>> +static inline void
>>>> +bpf_kprobe_multi_link_type_show(const struct bpf_link *link, char *link_type, int len)
>>>> +{
>>>> +}
>>>> +static inline void
>>>> +bpf_uprobe_multi_link_type_show(const struct bpf_link *link, char *link_type, int len)
>>>> +{
>>>> +}
>>>>   #endif
>>>>
>>>>   enum {
>>>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>>>> index 51ba1a7aa43..43b821b37bc 100644
>>>> --- a/kernel/bpf/syscall.c
>>>> +++ b/kernel/bpf/syscall.c
>>>> @@ -3226,9 +3226,16 @@ static void bpf_link_show_fdinfo(struct seq_file *m, struct file *filp)
>>>>          const struct bpf_prog *prog = link->prog;
>>>>          enum bpf_link_type type = link->type;
>>>>          char prog_tag[sizeof(prog->tag) * 2 + 1] = { };
>>>> +       char link_type[64] = {};
>>>>
>>>>          if (type < ARRAY_SIZE(bpf_link_type_strs) && bpf_link_type_strs[type]) {
>>>> -               seq_printf(m, "link_type:\t%s\n", bpf_link_type_strs[type]);
>>>> +               if (link->type == BPF_LINK_TYPE_KPROBE_MULTI)
>>>> +                       bpf_kprobe_multi_link_type_show(link, link_type, sizeof(link_type));
>>>> +               else if (link->type == BPF_LINK_TYPE_UPROBE_MULTI)
>>>> +                       bpf_uprobe_multi_link_type_show(link, link_type, sizeof(link_type));
>>>> +               else
>>>> +                       strscpy(link_type, bpf_link_type_strs[type], sizeof(link_type));
>>>> +               seq_printf(m, "link_type:\t%s\n", link_type);
>>>
>>> New callbacks just to print a string?
>>> Let's find a different way.
>>>
>>> How about moving 'flags' from bpf_[ku]probe_multi_link into bpf_link ?
>>> (There is a 7 byte hole there anyway)
>>> and checking flags inline.
>>>
>>> Jiri, Andrii,
>>>
>>> better ideas?
>>
>> We can just remember original attr->link_create.attach_type in
>> bpf_link itself, and then have a small helper that will accept link
>> type and attach type, and fill out link type representation based on
>> those two. Internally we can do the special-casing of  uprobe vs
>> uretprobe and kprobe vs kretprobe transparently to all the other code.
>> And use that here in show_fdinfo
> 
> but you'd still need the flags, no? to find out if it's return probe
> 
> I tried what Alexei suggested and it seems ok and simple enough
> 
> jirka
> 
> 
> ---
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 5dd556e89cce..287c956cdbd2 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1702,6 +1702,7 @@ struct bpf_link {
>   	 * link's semantics is determined by target attach hook
>   	 */
>   	bool sleepable;
> +	u32 flags;
>   	/* rcu is used before freeing, work can be used to schedule that
>   	 * RCU-based freeing before that, so they never overlap
>   	 */
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 56500381c28a..f1d9ee9717a1 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3228,7 +3228,14 @@ static void bpf_link_show_fdinfo(struct seq_file *m, struct file *filp)
>   	char prog_tag[sizeof(prog->tag) * 2 + 1] = { };
>   
>   	if (type < ARRAY_SIZE(bpf_link_type_strs) && bpf_link_type_strs[type]) {
> -		seq_printf(m, "link_type:\t%s\n", bpf_link_type_strs[type]);
> +		if (link->type == BPF_LINK_TYPE_KPROBE_MULTI)
> +			seq_printf(m, "link_type:\t%s\n", link->flags == BPF_F_KPROBE_MULTI_RETURN ?
> +				   "kretprobe_multi" : "kprobe_multi");
> +		else if (link->type == BPF_LINK_TYPE_UPROBE_MULTI)
> +			seq_printf(m, "link_type:\t%s\n", link->flags == BPF_F_UPROBE_MULTI_RETURN ?
> +				   "uretprobe_multi" : "uprobe_multi");
> +		else
> +			seq_printf(m, "link_type:\t%s\n", bpf_link_type_strs[type]);
>   	} else {
>   		WARN_ONCE(1, "missing BPF_LINK_TYPE(...) for link type %u\n", type);
>   		seq_printf(m, "link_type:\t<%u>\n", type);
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 0a06ea6638fe..81d7a4e5ae15 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2466,7 +2466,6 @@ struct bpf_kprobe_multi_link {
>   	u32 cnt;
>   	u32 mods_cnt;
>   	struct module **mods;
> -	u32 flags;
>   };
>   
>   struct bpf_kprobe_multi_run_ctx {
> @@ -2586,7 +2585,7 @@ static int bpf_kprobe_multi_link_fill_link_info(const struct bpf_link *link,
>   
>   	kmulti_link = container_of(link, struct bpf_kprobe_multi_link, link);
>   	info->kprobe_multi.count = kmulti_link->cnt;
> -	info->kprobe_multi.flags = kmulti_link->flags;
> +	info->kprobe_multi.flags = kmulti_link->link.flags;
>   	info->kprobe_multi.missed = kmulti_link->fp.nmissed;
>   
>   	if (!uaddrs)
> @@ -2976,7 +2975,7 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
>   	link->addrs = addrs;
>   	link->cookies = cookies;
>   	link->cnt = cnt;
> -	link->flags = flags;
> +	link->link.flags = flags;
>   
>   	if (cookies) {
>   		/*
> @@ -3045,7 +3044,6 @@ struct bpf_uprobe_multi_link {
>   	struct path path;
>   	struct bpf_link link;
>   	u32 cnt;
> -	u32 flags;
>   	struct bpf_uprobe *uprobes;
>   	struct task_struct *task;
>   };
> @@ -3109,7 +3107,7 @@ static int bpf_uprobe_multi_link_fill_link_info(const struct bpf_link *link,
>   
>   	umulti_link = container_of(link, struct bpf_uprobe_multi_link, link);
>   	info->uprobe_multi.count = umulti_link->cnt;
> -	info->uprobe_multi.flags = umulti_link->flags;
> +	info->uprobe_multi.flags = umulti_link->link.flags;
>   	info->uprobe_multi.pid = umulti_link->task ?
>   				 task_pid_nr_ns(umulti_link->task, task_active_pid_ns(current)) : 0;
>   
> @@ -3369,7 +3367,7 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
>   	link->uprobes = uprobes;
>   	link->path = path;
>   	link->task = task;
> -	link->flags = flags;
> +	link->link.flags = flags;
>   
>   	bpf_link_init(&link->link, BPF_LINK_TYPE_UPROBE_MULTI,
>   		      &bpf_uprobe_multi_link_lops, prog);

Hi, Jiri, Andrii,

Jiri's patch looks more simple, and i see other struct xx_links wrap 
bpf_link, which have attach_type field like:
struct sockmap_link {
         struct bpf_link link;
         struct bpf_map *map;
         enum bpf_attach_type attach_type;
};
If we create attach_type filed in bpf_link, maybe these struct xx_link 
should also be modified. BTW, as Jiri said, we still can not find return 
probe type from attach_type.

-- 
Best Regards
Tao Chen

