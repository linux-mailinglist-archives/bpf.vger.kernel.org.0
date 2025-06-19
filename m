Return-Path: <bpf+bounces-61024-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA5EADFB9E
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 05:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 860C617DAB4
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 03:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4733238151;
	Thu, 19 Jun 2025 03:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gTBCJwUX"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9697022068A
	for <bpf@vger.kernel.org>; Thu, 19 Jun 2025 03:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750302520; cv=none; b=nzE4SCkMWTyThAQMs1iscacxVjanWZtZ8S9LTOP2r+uwvViwpkVCDkBGZLMcaqV0ZnzEKLAglEzRgX+tWbX5ih0bXfuBkILb6zHtmrBU0mets48LhP+pcLoUh48xO8Wbc7FPv4dTckGMVnaIzhh24oyN18LDPfEqX9UB+B/QEH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750302520; c=relaxed/simple;
	bh=SgZUuy/69sVZM3m3MmDNG0K4lul6I88SNISjtoCujJQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uvE7IcKavTfF4zcZD6xdIdAI/kqO6hpRYx95qCTEyLSatSH9JnTeT3LWenoHDG5h2GO/l0f9Wt/DQSpIzmfyjfV/9rfJ1Fsc1z0GekJTabd2DBOV3vpmTgYYdsg7qIOyF+Bq7DtqL99tJ7bW1Uajstcmz0A8DAXtWkrY/qO+/+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gTBCJwUX; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7b6ae7dc-1044-4551-bc3f-32430e34ba05@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750302505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qytNNDLpSkg/lD2MtoymL6iQx2TYpDFxPNNBttldr0E=;
	b=gTBCJwUXVXaxASFXz0e91moMfkdjXUKY0akiIUtiVMZaUd8AoeCoq8WdczxaV9UERZBuXs
	5YlagISrVG9r6dujGSmfLvuCKYpeeOdTqEzEw4uFWgHnckc8jTulO6n2jEDd75e/Aq15R9
	MNorKi0g0/CiL4TtAmTuhVXmzUtGSow=
Date: Thu, 19 Jun 2025 11:08:15 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 2/2] bpf: Add show_fdinfo for kprobe_multi
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
References: <20250616130233.451439-1-chen.dylane@linux.dev>
 <20250616130233.451439-2-chen.dylane@linux.dev>
 <CAADnVQ+hT6nCGoR5a0Z+52SrJzO9-ReBRds23mBfrG3SbwGFdw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <CAADnVQ+hT6nCGoR5a0Z+52SrJzO9-ReBRds23mBfrG3SbwGFdw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/6/19 09:46, Alexei Starovoitov 写道:
> On Mon, Jun 16, 2025 at 6:03 AM Tao Chen <chen.dylane@linux.dev> wrote:
>>
>> Show kprobe_multi link info with fdinfo, the info as follows:
>>
>> link_type:      kprobe_multi
>> link_id:        1
>> prog_tag:       a15b7646cb7f3322
>> prog_id:        21
>> type:   kprobe_multi
>> kprobe_cnt:     8
>> missed: 0
>> cookie           func
>> 1                bpf_fentry_test1
>> 7                bpf_fentry_test2
>> 2                bpf_fentry_test3
>> 3                bpf_fentry_test4
>> 4                bpf_fentry_test5
>> 5                bpf_fentry_test6
>> 6                bpf_fentry_test7
>> 8                bpf_fentry_test8
>>
>> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
>> ---
>>   kernel/trace/bpf_trace.c | 32 ++++++++++++++++++++++++++++++++
>>   1 file changed, 32 insertions(+)
>>
>> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
>> index 2d422f897ac..fcf19e233b5 100644
>> --- a/kernel/trace/bpf_trace.c
>> +++ b/kernel/trace/bpf_trace.c
>> @@ -2623,10 +2623,42 @@ static int bpf_kprobe_multi_link_fill_link_info(const struct bpf_link *link,
>>          return err;
>>   }
>>
>> +#ifdef CONFIG_PROC_FS
>> +static void bpf_kprobe_multi_show_fdinfo(const struct bpf_link *link,
>> +                                        struct seq_file *seq)
>> +{
>> +       struct bpf_kprobe_multi_link *kmulti_link;
>> +       char sym[KSYM_NAME_LEN];
>> +
>> +       kmulti_link = container_of(link, struct bpf_kprobe_multi_link, link);
>> +
>> +       seq_printf(seq,
>> +                  "type:\t%s\n"
>> +                  "kprobe_cnt:\t%u\n"
>> +                  "missed:\t%lu\n",
>> +                  kmulti_link->flags == BPF_F_KPROBE_MULTI_RETURN ? "kretprobe_multi" :
>> +                                        "kprobe_multi",
>> +                  kmulti_link->cnt,
>> +                  kmulti_link->fp.nmissed);
>> +
>> +       seq_printf(seq, "%-16s %-16s\n", "cookie", "func");
>> +       for (int i = 0; i < kmulti_link->cnt; i++) {
>> +               sprint_symbol_no_offset(sym, kmulti_link->addrs[i]);
>> +               seq_printf(seq,
>> +                          "%-16llu %-16s\n",
>> +                          kmulti_link->cookies[i],
>> +                          sym);
> 
> Why call sprint_symbol_no_offset() directly ?
> %pB is fine.
> +off doesn't disclose anything.
> 
> pw-bot: cr

My problem, sorry for that, i had some issues with using printk to show 
func name directly before. Actually, i used it incorrectly. How about 
%pS, it looks more accurate. Thanks!

%pB format
cookie           func
8                __pfx_bpf_fentry_test1+0x10/0x10
2                __pfx_bpf_fentry_test2+0x10/0x10
7                __pfx_bpf_fentry_test3+0x10/0x10

%pS format
cookie           func
8                bpf_fentry_test1+0x0/0x20
2                bpf_fentry_test2+0x0/0x20
7                bpf_fentry_test3+0x0/0x20

-- 
Best Regards
Tao Chen

