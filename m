Return-Path: <bpf+bounces-61137-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E789AE1134
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 04:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 020E217F0A1
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 02:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6741C5D53;
	Fri, 20 Jun 2025 02:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sZQ90c6i"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE7B1A288
	for <bpf@vger.kernel.org>; Fri, 20 Jun 2025 02:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750387573; cv=none; b=Z+xwUJJaxbfp99MWX4n7nvZquJ5eaJ5eLYcJAhwlKka8+0Xyfc2bFTuwSiUydmr2C3OvgOQ5SJ3HOPFxBbs544wVDlRwPz7kxBTpnDGHbib3BL0zPN/5pVdCpruIYow62dZKnOf1ANtoXm6rSOw4Sq/+rEIHDnzth6xkbTLqL1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750387573; c=relaxed/simple;
	bh=t4gjhn+JnmvuUxa3BiFn451KQfDVJ8qO65IO06u1JzM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fgoKSeT5tcwsYiYEp7C6XS1R9O5HL+A9cwTJs1SCMANg9KIPHi2yWxrd4FgWBzD1JljLKGaD10FWpqYLGm24G7M/RhouUUrqRtST1re+75uVlrqKoyJ0PC8Mpzf1BuzMQ7a1T2mdfGAsSxENbRRhLKfNXIu2ag+rfhhCbBqxT7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sZQ90c6i; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9eedd830-9222-4ac0-8ccd-72499fb85b13@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750387568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JwfnmNENQgWbWLAJgNr0YpJvx//VvI8W+nKQ5vtSGrc=;
	b=sZQ90c6i+iiNiRtu2Qz0X/3N1IrMVKVd+TWCo6maaaR7ZNrJp9XozHb/5e/OnTZNA2i68S
	S95tBr92dpk9OsyQ/y3xbr6HcVf8fsilk+vjfnBFoiOJZC7uqNS12EXukhEipKxboGOuvY
	QHEOuiW818H4dZKXUv5SPXnMX2NlXv0=
Date: Fri, 20 Jun 2025 10:45:58 +0800
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
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <CAADnVQLyAeo9ztPoJzU1QJUQf6SMptVNoOzZza02xPuXO1ES2g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/6/20 01:17, Alexei Starovoitov 写道:
> On Wed, Jun 18, 2025 at 8:44 PM Tao Chen <chen.dylane@linux.dev> wrote:
>>
>> Show kprobe_multi link info with fdinfo, the info as follows:
>>
>> link_type:      kprobe_multi
>> link_id:        1
>> prog_tag:       a15b7646cb7f3322
>> prog_id:        21
>> type:   kprobe_multi
> 
> ..
> 
>> +       seq_printf(seq,
>> +                  "type:\t%s\n"
>> +                  "kprobe_cnt:\t%u\n"
>> +                  "missed:\t%lu\n",
>> +                  kmulti_link->flags == BPF_F_KPROBE_MULTI_RETURN ? "kretprobe_multi" :
>> +                                        "kprobe_multi",
> 
> why print the same info twice ?
> seq_printf(m, "link_type:\t%s\n", bpf_link_type_strs[type]);
> in bpf_link_show_fdinfo() already did it in a cleaner way.
> 

link_type only shows 'kprobe_multi', maybe we can show the format like:
// for kretprobe_multi
retprobe: true

// for kprobe_multi
retprobe: false

> Same issue in the other patch.
> 
> pw-bot: cr


-- 
Best Regards
Tao Chen

