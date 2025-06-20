Return-Path: <bpf+bounces-61142-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E31AE11B8
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 05:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A9B94A376D
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 03:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94D91C5F27;
	Fri, 20 Jun 2025 03:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mh73/h4Q"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24334433B1
	for <bpf@vger.kernel.org>; Fri, 20 Jun 2025 03:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750389740; cv=none; b=ZsOE7NCR9Q8rKLCJgiCQplLbfyzr3XOar+u7152pHnK5Mg+RS59nI7nk1QwFCzYavmqM5fk6c9aNX3Pjub7F49j31FYdAU0GCChBVrDA//jP9aCe/W+cUhhbqiPqtdvV0bg7P2J/EeJLseOfhyySLWP3V2oIrxPUXbcZQVSCSJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750389740; c=relaxed/simple;
	bh=BNVZL1LwSlKQ2Hwemkrc1kvOKy4tqch5FGs7pVe0NsE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JVhdNgIzZylJlKXLVDlNiR1mFZ4UygQ2sY2TB+noGzU8HMX55b0Qh5Xop9vmxWw8FKJGS8gcdvLXlTM+DNM9cnhZlE2zYmSvTMBPwSKT5i8vGsIS5QwlObVHsqNj3HhIrEq0GkqbpsxKU3PRYoclFSaj9zBv2Qk48abZOyZUbEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mh73/h4Q; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <28a6e8ae-7344-4c09-a779-af0d833d8578@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750389722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yiYHAkxGzw2ln42MzS53hzpnRDIheaafpYaL8k6tDvA=;
	b=mh73/h4QeFY3OkDc8dwZdRmQypRhWlNdTh8jivXqn5WIYL+6wa1OycpmOo/kvhSdXXT50J
	FN2FYGs2v9HTj9BrmlHwMV94B2HP1JZJmNctXmM5jyZQyywIaS0jqj/hxWd6yqBzSjv7Bc
	lUoPZbOhClFMcV5Qg7X8el9oPz7JIyo=
Date: Fri, 20 Jun 2025 11:21:45 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 2/2] bpf: Add show_fdinfo for kprobe_multi
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
References: <20250619034257.70520-1-chen.dylane@linux.dev>
 <20250619034257.70520-2-chen.dylane@linux.dev>
 <CAADnVQLyAeo9ztPoJzU1QJUQf6SMptVNoOzZza02xPuXO1ES2g@mail.gmail.com>
 <9eedd830-9222-4ac0-8ccd-72499fb85b13@linux.dev>
 <CAADnVQJcdVCKPu8aPPj5hZExNTFYAYTd5xkF=Ljfm__+ugirGg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <CAADnVQJcdVCKPu8aPPj5hZExNTFYAYTd5xkF=Ljfm__+ugirGg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/6/20 10:59, Alexei Starovoitov 写道:
> On Thu, Jun 19, 2025 at 7:46 PM Tao Chen <chen.dylane@linux.dev> wrote:
>>
>> 在 2025/6/20 01:17, Alexei Starovoitov 写道:
>>> On Wed, Jun 18, 2025 at 8:44 PM Tao Chen <chen.dylane@linux.dev> wrote:
>>>>
>>>> Show kprobe_multi link info with fdinfo, the info as follows:
>>>>
>>>> link_type:      kprobe_multi
>>>> link_id:        1
>>>> prog_tag:       a15b7646cb7f3322
>>>> prog_id:        21
>>>> type:   kprobe_multi
>>>
>>> ..
>>>
>>>> +       seq_printf(seq,
>>>> +                  "type:\t%s\n"
>>>> +                  "kprobe_cnt:\t%u\n"
>>>> +                  "missed:\t%lu\n",
>>>> +                  kmulti_link->flags == BPF_F_KPROBE_MULTI_RETURN ? "kretprobe_multi" :
>>>> +                                        "kprobe_multi",
>>>
>>> why print the same info twice ?
>>> seq_printf(m, "link_type:\t%s\n", bpf_link_type_strs[type]);
>>> in bpf_link_show_fdinfo() already did it in a cleaner way.
>>>
>>
>> link_type only shows 'kprobe_multi', maybe we can show the format like:
> 
> Ohh. Especially so. It would be wrong and confusing to display:
> link_type:      kprobe_multi
> type: kretprobe_multi
> 
> Let's fix 'link_type' to display it properly.

Yeah, but it seems that 'link_type' is a common field for other link 
types, you mean use 'link_type' to show 'kprobe_multi' or 'kretprobe_multi'?

-- 
Best Regards
Tao Chen

