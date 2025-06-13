Return-Path: <bpf+bounces-60571-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B704AD80FD
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 04:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F3EE7A4D2D
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 02:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1D423185F;
	Fri, 13 Jun 2025 02:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MugD2vs9"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7171FE477
	for <bpf@vger.kernel.org>; Fri, 13 Jun 2025 02:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749781736; cv=none; b=nTFJ8MkG+d39g+jqEhk33QGku6olsYGaer5V6tXaTwbFr60jVhaNRQcPfXxn6uHDDcNq+35y5nnEmhjI8pZKmsvg9gq/ZNHjC3tZ/1h/2gm19JtQbJ36gfR08c047R9K4S1sLJIS9ItL77fAJa7sK51Aq6Fxd0WLu1jkBn5x3mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749781736; c=relaxed/simple;
	bh=Z790ia3hhxJSz1+18ONd2BJAGrEX/umegvd5gEVMIME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IlTn0Y5Iev0HRpRNKdDwyWMO323S+uB6+IjUqmJ7y+nUT+I1HP8xyDO2ICpeXIRh+2iiYkNfu+OXbsklx8Vu7bv9zLkVgG/3Q3KiLlYT+XzFZCCuOLrUr3UCBtJNSseuPEOROb4gg7CAedRYa2PxkladnEUy6aQaRfIzW1/ZLmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MugD2vs9; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6473772f-0de8-41f2-9ff7-b448287f5d84@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749781732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0ytn+bcuObQ7MKdcELlJIkA6LwJWViBRc7WumuqHenU=;
	b=MugD2vs99UfQT+anwxTgfoFugtxLmOZ//V9ijbL5YwOdq0vG46KCsAjf8/tpBD72FTkqFR
	AqD1+o7aaUef/xGdgqKFB/T6F0JIyBgdWbJJQIDOxvxXLGGblkmt0YCnscghyX62e2byci
	B+h10+RaeWZVCClWmjDZoKlfzCEMlNo=
Date: Fri, 13 Jun 2025 10:28:05 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/2] bpf: Add show_fdinfo for uprobe_multi
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 mattbobrowski@google.com, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20250612115556.295103-1-chen.dylane@linux.dev>
 <CAEf4BzbxGS85nKK8qAYkSE1HEj7hVshmr9xGsZcP5di0Fu02xQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <CAEf4BzbxGS85nKK8qAYkSE1HEj7hVshmr9xGsZcP5di0Fu02xQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/6/13 05:27, Andrii Nakryiko 写道:
> On Thu, Jun 12, 2025 at 4:56 AM Tao Chen <chen.dylane@linux.dev> wrote:
>>
>> Show uprobe_multi link info with fdinfo, the info as follows:
>>
>> link_type:      uprobe_multi
>> link_id:        9
>> prog_tag:       e729f789e34a8eca
>> prog_id:        39
>> type:   uprobe_multi
>> func_cnt:       3
>> pid:    0
>> path:   /home/dylane/bpf/tools/testing/selftests/bpf/test_progs
>> offset: 0xa69ed7
>> ref_ctr_offset: 0x0
>> cookie: 3
>> offset: 0xa69ee2
>> ref_ctr_offset: 0x0
>> cookie: 1
>> offset: 0xa69eed
>> ref_ctr_offset: 0x0
>> cookie: 2
>>
>> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
>> ---
>>   kernel/trace/bpf_trace.c | 48 ++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 48 insertions(+)
>>
>> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
>> index 24b94870b50..c4ad82b8fd8 100644
>> --- a/kernel/trace/bpf_trace.c
>> +++ b/kernel/trace/bpf_trace.c
>> @@ -3157,10 +3157,58 @@ static int bpf_uprobe_multi_link_fill_link_info(const struct bpf_link *link,
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
>> +                  "type:\t%s\n"
>> +                  "func_cnt:\t%u\n"
> 
> it's not really *func* (e.g., for USDTs it's basically guaranteed to
> be somewhere inside the function, potentially in many places within
> the same function), I'd use generic "uprobe_{cnt,count}"
> 
>

will change it in v2, thanks for the advice.

>> +                  "pid:\t%u\n"
>> +                  "path:\t%s\n",
>> +                  umulti_link->flags == BPF_F_UPROBE_MULTI_RETURN ?
>> +                                        "uretprobe_multi" : "uprobe_multi",
>> +                  umulti_link->cnt,
>> +                  umulti_link->task ? task_pid_nr_ns(umulti_link->task,
>> +                          task_active_pid_ns(current)) : 0,
>> +                  p);
>> +
>> +       for (int i = 0; i < umulti_link->cnt; i++) {
>> +               seq_printf(seq,
>> +                          "offset:\t%#llx\n"
>> +                          "ref_ctr_offset:\t%#lx\n"
>> +                          "cookie:\t%llu\n",
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

