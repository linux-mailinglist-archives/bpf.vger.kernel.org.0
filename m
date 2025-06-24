Return-Path: <bpf+bounces-61359-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FCFAE5FB4
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 10:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15D063B10FF
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 08:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD94826AAB2;
	Tue, 24 Jun 2025 08:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PpLmtlIF"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3EE26A1AE;
	Tue, 24 Jun 2025 08:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750754538; cv=none; b=D+x6Y2dQFv7nLKAh4apSc3X+ZgERGMX9iBKDzBZfspEW28zbw8mcqctMMIfGOt3lDosPIS+Hm2/p0Rrk/jehuWHKq8WBacjVPxDPmcSqMhlXKxTnc9BjFZEu8K7sItjCWP1jlrFmS0ZBX7+ktLFQ2t3Tszn3oVOqbuIJIBWIBV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750754538; c=relaxed/simple;
	bh=JNxmCOn+43Sbv41n8e4LqlcYZYgh/zmwix+cz4TxWH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BqP7xUa8MtTSmO6FEWRsBavGogRZlqeVnz1gEsUljj4l0NHrqS7CAqw8xmuP/elUuG2Kb6O1UM3MfSK2eUS/9v8Z+JObOFwHFTAsLsFIyf5Jdtx2v+RK7GIFxROLQ6YEIVEnMPLZ1iP6cpy+871IK/wzwWcIy06tq2S9kP2GRV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PpLmtlIF; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3cdf1037-7e2d-4cc8-8298-10feee43deac@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750754533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RVR4RpAzyL8WQswFc+IpH0lvnrWvd7pq5SJsr4lEcA8=;
	b=PpLmtlIFoLB6KDNJe4fHjRlnEQdKL3fBTXHpZ2rUMYIpFQbvJRl58Tmcpj+fL/AV5Lsy9H
	9rCB9lStTech20GoylrtNVXNMln3tKiJPPmt4z6EGqgabJbSerGu4pl2jsPUdWg0u4TxzH
	qiaf7XWI6FRvtqZ7GH/gO58s8Crj764=
Date: Tue, 24 Jun 2025 16:42:06 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 2/3] bpf: Add show_fdinfo for uprobe_multi
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: kpsingh@kernel.org, mattbobrowski@google.com, song@kernel.org,
 jolsa@kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, yonghong.song@linux.dev,
 john.fastabend@gmail.com, sdf@fomichev.me, haoluo@google.com,
 rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
References: <20250623134342.227347-1-chen.dylane@linux.dev>
 <20250623134342.227347-2-chen.dylane@linux.dev>
 <CAEf4BzY2dZ5KgcCH59rrQwZYaDZPt_-p4GHK8zMFP+RNPnNa=w@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <CAEf4BzY2dZ5KgcCH59rrQwZYaDZPt_-p4GHK8zMFP+RNPnNa=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/6/24 06:14, Andrii Nakryiko 写道:
> On Mon, Jun 23, 2025 at 6:45 AM Tao Chen <chen.dylane@linux.dev> wrote:
>>
>> Show uprobe_multi link info with fdinfo, the info as follows:
>>
>> link_type:      uprobe_multi
>> link_id:        10
>> prog_tag:       7db356c03e61a4d4
>> prog_id:        42
>> uprobe_cnt:     3
>> pid:    0
>> path:   /home/dylane/bpf/tools/testing/selftests/bpf/test_progs
>> offset           ref_ctr_offset   cookie
>> 0xa69f13         0x0              2
>> 0xa69f1e         0x0              3
>> 0xa69f29         0x0              1
>>
>> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
>> ---
>>   kernel/trace/bpf_trace.c | 44 ++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 44 insertions(+)
>>
>> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
>> index 8ecb1a9f85d..90209dda819 100644
>> --- a/kernel/trace/bpf_trace.c
>> +++ b/kernel/trace/bpf_trace.c
>> @@ -3171,10 +3171,54 @@ static int bpf_uprobe_multi_link_fill_link_info(const struct bpf_link *link,
>>          return err;
>>   }
>>
>> +#ifdef CONFIG_PROC_FS
>> +static void bpf_uprobe_multi_show_fdinfo(const struct bpf_link *link,
>> +                                        struct seq_file *seq)
>> +{
>> +       struct bpf_uprobe_multi_link *umulti_link;
>> +       char *p, *buf;
>> +
>> +       umulti_link = container_of(link, struct bpf_uprobe_multi_link, link);
>> +
>> +       buf = kmalloc(PATH_MAX, GFP_KERNEL);
>> +       if (!buf)
>> +               return;
>> +
>> +       p = d_path(&umulti_link->path, buf, PATH_MAX);
>> +       if (IS_ERR(p)) {
>> +               kfree(buf);
>> +               return;
>> +       }
>> +
>> +       seq_printf(seq,
>> +                  "uprobe_cnt:\t%u\n"
>> +                  "pid:\t%u\n"
>> +                  "path:\t%s\n",
>> +                  umulti_link->cnt,
>> +                  umulti_link->task ? task_pid_nr_ns(umulti_link->task,
>> +                          task_active_pid_ns(current)) : 0,
> 
> nit: either keep stuff like this on single line, or if it's too long
> or awkward, add a local variable. Formatting it like this is very hard
> to follow and looks pretty ugly...
> 

will fix it in v6, thanks.

>> +                  p);
>> +
>> +       seq_printf(seq, "%-16s %-16s %-16s\n", "offset", "ref_ctr_offset", "cookie");
>> +       for (int i = 0; i < umulti_link->cnt; i++) {
>> +               seq_printf(seq,
>> +                          "%#-16llx %#-16lx %-16llu\n",
>> +                          umulti_link->uprobes[i].offset,
>> +                          umulti_link->uprobes[i].ref_ctr_offset,
>> +                          umulti_link->uprobes[i].cookie);
>> +       }
>> +
>> +       kfree(buf);
>> +}
>> +#endif
>> +
>>   static const struct bpf_link_ops bpf_uprobe_multi_link_lops = {
>>          .release = bpf_uprobe_multi_link_release,
>>          .dealloc_deferred = bpf_uprobe_multi_link_dealloc,
>>          .fill_link_info = bpf_uprobe_multi_link_fill_link_info,
>> +#ifdef CONFIG_PROC_FS
>> +       .show_fdinfo = bpf_uprobe_multi_show_fdinfo,
>> +#endif
>>   };
>>
>>   static int uprobe_prog_run(struct bpf_uprobe *uprobe,
>> --
>> 2.48.1
>>


-- 
Best Regards
Tao Chen

