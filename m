Return-Path: <bpf+bounces-62029-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFDCAF085E
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 04:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EFD642455C
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 02:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322CA19C554;
	Wed,  2 Jul 2025 02:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pOf/w6cw"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35DBFBF6
	for <bpf@vger.kernel.org>; Wed,  2 Jul 2025 02:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751422522; cv=none; b=GDAgXkyP/+EhOqYHd6PLAhMssxrlsyXgm4RNgffXzUS2x031tbXLIzIuWF6aqwQ5mNKS/ZUznflgmQKXqnUk5Dt3rxravsqVN0q6w+Nlg8LXnkKSQ48Jby0d4GTIgnug+K72hykibaYYMzGuHZ2xMrEVPaXMiU1BXV9fKIDU494=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751422522; c=relaxed/simple;
	bh=jqOmHfl6MqpU00nfbSrc3bGz28jU+Q5UotEHKQLp9U8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KX3MgbrU6qyrbxBZaBVIGCEgcoBrXowEQdq5rc1o/4UXs0IdaQnTw4PeCxKFVlN4Sdc+gbYCrgNGNTStjJYx7hcUTntww66GQHGM6Bf0+MPO45+g6APx/4AfuCr9dk+x6dJvK9mfZarGGQ7oGTvCqCwXuqSx+cOFnn3xcLMBznQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pOf/w6cw; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <983eacae-5b5d-4d26-a3e4-3c3eb808c5f2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751422508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tBwSK9N/m8nUDhskzFpAoJI0BngUsU1KOySDZuAUtKA=;
	b=pOf/w6cwS2Dmsb3ERB016LiVzkVmTGRN1LTYBmEqiNxePEOnm1n6pjNMyNNwBbHx/rc8ZP
	m+qKNPjOtVBstKu6YXnAy7tcoHfguvwMMmd9jmN31xw5hYQXAqNe9abSqm11UOQvhOIl0n
	muM6xJDag0n5/Te1k75F3eiW9qGmx0c=
Date: Wed, 2 Jul 2025 10:14:58 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 1/3] bpf: Show precise link_type for
 {uprobe,kprobe}_multi fdinfo
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Matt Bobrowski <mattbobrowski@google.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
References: <20250627082252.431209-1-chen.dylane@linux.dev>
 <CAADnVQLWZH0sQk6ni-AWb+SRJ+H_sE=Gvwn3wdu+UC=mJiPPrg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <CAADnVQLWZH0sQk6ni-AWb+SRJ+H_sE=Gvwn3wdu+UC=mJiPPrg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/7/2 04:39, Alexei Starovoitov 写道:
> On Fri, Jun 27, 2025 at 1:23 AM Tao Chen <chen.dylane@linux.dev> wrote:
>>
>> Alexei suggested, 'link_type' can be more precise and differentiate
>> for human in fdinfo. In fact BPF_LINK_TYPE_KPROBE_MULTI includes
>> kretprobe_multi type, the same as BPF_LINK_TYPE_UPROBE_MULTI, so we
>> can show it more concretely.
>>
>> link_type:      kprobe_multi
>> link_id:        1
>> prog_tag:       d2b307e915f0dd37
>> ...
>> link_type:      kretprobe_multi
>> link_id:        2
>> prog_tag:       ab9ea0545870781d
>> ...
>> link_type:      uprobe_multi
>> link_id:        9
>> prog_tag:       e729f789e34a8eca
>> ...
>> link_type:      uretprobe_multi
>> link_id:        10
>> prog_tag:       7db356c03e61a4d4
>>
>> As Andrii suggested attach_type can be recorded in bpf_link, there is
>> still a 6 byte hole in bpf_link, we can fill the hole with attach_type
>> soon.
>>
>> Co-authored-by: Jiri Olsa <jolsa@kernel.org>
>> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
>> ---
>>   include/linux/bpf.h      |  1 +
>>   kernel/bpf/syscall.c     |  9 ++++++++-
>>   kernel/trace/bpf_trace.c | 10 ++++------
>>   3 files changed, 13 insertions(+), 7 deletions(-)
>>
>> Change list:
>>    v5 -> v6:
>>      - Move flags into bpf_link to get retprobe info
>>        directly.(Alexei, Jiri)
>>    v5:
>>    https://lore.kernel.org/bpf/20250623134342.227347-1-chen.dylane@linux.dev
>>
>>    v4 -> v5:
>>      - Add patch1 to show precise link_type for
>>        {uprobe,kprobe}_multi.(Alexei)
>>      - patch2,3 just remove type field, which will be showed in
>>        link_type
>>    v4:
>>    https://lore.kernel.org/bpf/20250619034257.70520-1-chen.dylane@linux.dev
>>
>>    v3 -> v4:
>>      - use %pS to print func info.(Alexei)
>>    v3:
>>    https://lore.kernel.org/bpf/20250616130233.451439-1-chen.dylane@linux.dev
>>
>>    v2 -> v3:
>>      - show info in one line for multi events.(Jiri)
>>    v2:
>>    https://lore.kernel.org/bpf/20250615150514.418581-1-chen.dylane@linux.dev
>>
>>    v1 -> v2:
>>      - replace 'func_cnt' with 'uprobe_cnt'.(Andrii)
>>      - print func name is more readable and security for kprobe_multi.(Alexei)
>>    v1:
>>    https://lore.kernel.org/bpf/20250612115556.295103-1-chen.dylane@linux.dev
>>
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index 5b25d278409..3d8fecc9b17 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -1702,6 +1702,7 @@ struct bpf_link {
>>           * link's semantics is determined by target attach hook
>>           */
>>          bool sleepable;
>> +       u32 flags :8;
> 
> There is a 7-byte hole here.
> Let's use 'u32 flags' right now and optimize later if necessary.

Ok, will change it in v7.

-- 
Best Regards
Tao Chen

