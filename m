Return-Path: <bpf+bounces-44540-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 259BC9C4566
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 19:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5C6B1F22DED
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 18:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8DA1AF0D0;
	Mon, 11 Nov 2024 18:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EjYHMt7i"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFC51AD3E2
	for <bpf@vger.kernel.org>; Mon, 11 Nov 2024 18:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731351308; cv=none; b=a/DTpd3fKC8WwZKLFjgsLH6cNAoTZtr62igfSBF417IOEX1Mm1+wzjxrdE8E9fa0hVaTm/LiYwzGY8N5/BtnPT0CpjOabZAL1mACG9R2HTcU3mzCUw7vAhLpQgdDzM8qEGGmyym5hElwW4nx73HowmYET9EMsZPrPS5lUjGm/lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731351308; c=relaxed/simple;
	bh=86p+N+9KLmvtVpxvznunNn39/uFbW20dDzRmkBUbmPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UXr1QWzn/0OGnktdSfXWJe2ye8FRtSrVyizTwz+WomwaM1TuEZXm4k6Do4bpYVppSwPAr4CM0rr2IJm3+I4Fe0+BYaF4t/PCHjU/fRdAbpB/MSfGE+4qwQ4mTdTjcuuHFTzctFVmL7GPAUy3KJYT61Mp4cLqA1X8jAsN2om90ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EjYHMt7i; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b8aab7b4-c85f-40d3-bffb-44ab91b33abd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731351304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Ksxvlz0YmcPwVYbWS0zz3T+vAnkok3NLXUiIJi8FDk=;
	b=EjYHMt7i54BudcCXhcugBaZt44JSbOCLMZARa6058i63izYTTC3WcCdNOOZ+KUbqYjxeXU
	d6tj4ABzP4zFZWs57jBPDF+UQHywR7ajoU/iF9+YZRod/CQtdr3tLQjcfTVmrdqGWomZJr
	KxTZ2TO/MU5SgXYpqi42z2OqQ0phri0=
Date: Mon, 11 Nov 2024 10:54:56 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH dwarves 3/3] dwarf_loader: Check DW_OP_[GNU_]entry_value
 for possible parameter matching
Content-Language: en-GB
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>,
 Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, dwarves@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Song Liu <song@kernel.org>
References: <20241108180508.1196431-1-yonghong.song@linux.dev>
 <20241108180524.1198900-1-yonghong.song@linux.dev> <ZzHURz01dzLHO2H4@krava>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <ZzHURz01dzLHO2H4@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT




On 11/11/24 1:54 AM, Jiri Olsa wrote:
> On Fri, Nov 08, 2024 at 10:05:24AM -0800, Yonghong Song wrote:
>> Song Liu reported that a kernel func (perf_event_read()) cannot be traced
>> in certain situations since the func is not in vmlinux bTF. This happens
>> in kernels 6.4, 6.9 and 6.11 and the kernel is built with pahole 1.27.
>>
>> The perf_event_read() signature in kernel (kernel/events/core.c):
>>     static int perf_event_read(struct perf_event *event, bool group)
>>
>> Adding '-V' to pahole command line, and the following error msg can be found:
>>     skipping addition of 'perf_event_read'(perf_event_read) due to unexpected register used for parameter
>>
>> Eventually the error message is attributed to the setting
>> (parm->unexpected_reg = 1) in parameter__new() function.
>>
>> The following is the dwarf representation for perf_event_read():
>>      0x0334c034:   DW_TAG_subprogram
>>                  DW_AT_low_pc    (0xffffffff812c6110)
>>                  DW_AT_high_pc   (0xffffffff812c640a)
>>                  DW_AT_frame_base        (DW_OP_reg7 RSP)
>>                  DW_AT_GNU_all_call_sites        (true)
>>                  DW_AT_name      ("perf_event_read")
>>                  DW_AT_decl_file ("/rw/compile/kernel/events/core.c")
>>                  DW_AT_decl_line (4641)
>>                  DW_AT_prototyped        (true)
>>                  DW_AT_type      (0x03324f6a "int")
>>      0x0334c04e:     DW_TAG_formal_parameter
>>                    DW_AT_location        (0x007de9fd:
>>                       [0xffffffff812c6115, 0xffffffff812c6141): DW_OP_reg5 RDI
>>                       [0xffffffff812c6141, 0xffffffff812c6323): DW_OP_reg14 R14
>>                       [0xffffffff812c6323, 0xffffffff812c63fe): DW_OP_GNU_entry_value(DW_OP_reg5 RDI), DW_OP_stack_value
>>                       [0xffffffff812c63fe, 0xffffffff812c6405): DW_OP_reg14 R14
>>                       [0xffffffff812c6405, 0xffffffff812c640a): DW_OP_GNU_entry_value(DW_OP_reg5 RDI), DW_OP_stack_value)
>>                    DW_AT_name    ("event")
>>                    DW_AT_decl_file       ("/rw/compile/kernel/events/core.c")
>>                    DW_AT_decl_line       (4641)
>>                    DW_AT_type    (0x0333aac2 "perf_event *")
>>      0x0334c05e:     DW_TAG_formal_parameter
>>                    DW_AT_location        (0x007dea82:
>>                       [0xffffffff812c6137, 0xffffffff812c63f2): DW_OP_reg12 R12
>>                       [0xffffffff812c63f2, 0xffffffff812c63fe): DW_OP_GNU_entry_value(DW_OP_reg4 RSI), DW_OP_stack_value
>>                       [0xffffffff812c63fe, 0xffffffff812c640a): DW_OP_reg12 R12)
>>                    DW_AT_name    ("group")
>>                    DW_AT_decl_file       ("/rw/compile/kernel/events/core.c")
>>                    DW_AT_decl_line       (4641)
>>                    DW_AT_type    (0x03327059 "bool")
> hi,
> I don't see that on gcc compiled kernel, is that related to clang?

Yes, the case I tried to fix is from clang compiled kernel.

>
>
>   <1><318d475>: Abbrev Number: 74 (DW_TAG_subprogram)
>      <318d476>   DW_AT_name        : (indirect string, offset: 0xf5776): perf_event_read
>      <318d47a>   DW_AT_decl_file   : 1
>      <318d47a>   DW_AT_decl_line   : 4746
>      <318d47c>   DW_AT_decl_column : 12
>      <318d47d>   DW_AT_prototyped  : 1
>      <318d47d>   DW_AT_type        : <0x3135e35>
>      <318d481>   DW_AT_low_pc      : 0xffffffff8135be90
>      <318d489>   DW_AT_high_pc     : 0x196
>      <318d491>   DW_AT_frame_base  : 1 byte block: 9c    (DW_OP_call_frame_cfa)
>      <318d493>   DW_AT_call_all_calls: 1
>      <318d493>   DW_AT_sibling     : <0x318d900>
>   <2><318d497>: Abbrev Number: 30 (DW_TAG_formal_parameter)
>      <318d498>   DW_AT_name        : (indirect string, offset: 0x491590): event
>      <318d49c>   DW_AT_decl_file   : 1
>      <318d49c>   DW_AT_decl_line   : 4746
>      <318d49e>   DW_AT_decl_column : 47
>      <318d49f>   DW_AT_type        : <0x313a680>
>      <318d4a3>   DW_AT_location    : 0x70c118 (location list)
>      <318d4a7>   DW_AT_GNU_locviews: 0x70c110
>   <2><318d4ab>: Abbrev Number: 30 (DW_TAG_formal_parameter)
>      <318d4ac>   DW_AT_name        : (indirect string, offset: 0x51a865): group
>      <318d4b0>   DW_AT_decl_file   : 1
>      <318d4b0>   DW_AT_decl_line   : 4746
>      <318d4b2>   DW_AT_decl_column : 59
>      <318d4b3>   DW_AT_type        : <0x3136055>
>      <318d4b7>   DW_AT_location    : 0x70c144 (location list)
>      <318d4bb>   DW_AT_GNU_locviews: 0x70c13e
>
> locations:
>      0070c144 ffffffff8135be90 (base address)
>      0070c14d v000000000000000 v000000000000000 views at 0070c13e for:
>               ffffffff8135be90 ffffffff8135bed2 (DW_OP_reg4 (rsi))
>      0070c152 v000000000000000 v000000000000000 views at 0070c140 for:
>               ffffffff8135bed2 ffffffff8135bf17 (DW_OP_reg14 (r14))
>      0070c158 v000000000000000 v000000000000000 views at 0070c142 for:
>               ffffffff8135bf17 ffffffff8135c026 (DW_OP_entry_value: (DW_OP_reg4 (rsi)); DW_OP_stack_value)
>      0070c162 <End of list>
>
>
> other than that lgtm and I like the change Eduard suggested
>
> thanks,
> jirka
>
[...]

