Return-Path: <bpf+bounces-51506-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E71A35384
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 02:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CEC516C8EC
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 01:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818D03595C;
	Fri, 14 Feb 2025 01:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Na8xQlqB"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC4B6FC5
	for <bpf@vger.kernel.org>; Fri, 14 Feb 2025 01:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739495303; cv=none; b=C+Yg4DusOou7HPrYwHNycXAIjwL0WfItUhqw3GZPXabZrK/7V/CUQTsCmUIFlHJS5rhlNK8MHu8Y5lJTjXcQvRtF78ZlT7upW/mJBt5+5aPYa9imWy3ukh38lefb+AC5uc4J1T83n5iuHWchoD9kgeKBTpwlW38GaQ27AF+n1Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739495303; c=relaxed/simple;
	bh=1xDU4h9kMctteQCnQUnApuwn7/ZAVzH3gfKjm5H6Y5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F0/BX0ZKzznX138llBW2D0pMfVcDqi7VHawymkk+zAI+Hd+an9Cvw1ZBQBL+V+3cjfFc/rFjjggcvFLxw7FZuMYhpeAQn/HVePGGRSNl/PD8LQm2qeM9gcovDW96OHVj65ltWWElvTYoeOtjBBMKT5LsvgtQzjhREimUTmKhMHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Na8xQlqB; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e5d5b25f-cee8-436c-ab3a-b92bd417e70e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739495293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ezTPseWuvvhzwWsViJMs94/VcBw0KIartZO/PL7ArsM=;
	b=Na8xQlqBiMSTEUuex+pOP6YVaIGLy4RUdArHuUAtqcaayCHZUNq/D04zZe2kd/n0AAxbNa
	q3Ujxn3sxGCprh9MtaruZp34h/mpLO9l1kU2DNr9qVpzhgUtAXA3iHvRD/GUWwiArh0WNK
	+QJa8xW+2bAP2f2CL9GDnu2nPF4sDkc=
Date: Thu, 13 Feb 2025 17:08:08 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1] selftests/bpf: Fix stdout race condition in
 traffic monitor
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 alexei.starovoitov@gmail.com, martin.lau@kernel.org, kernel-team@meta.com
References: <20250213233217.553258-1-ameryhung@gmail.com>
 <cfe7a83f-a2de-4157-8a43-abbe95968b05@linux.dev>
 <CAMB2axPo5PKKEe3_7opjV4KftCqpDZo9m=iRZZ=g+mUqDeZzqw@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAMB2axPo5PKKEe3_7opjV4KftCqpDZo9m=iRZZ=g+mUqDeZzqw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2/13/25 4:19 PM, Amery Hung wrote:
> On Thu, Feb 13, 2025 at 3:55 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>
>> On 2/13/25 3:32 PM, Amery Hung wrote:
>>> Fix a race condition between the main test_progs thread and the traffic
>>> monitoring thread. The traffic monitor thread tries to print a line
>>> using multiple printf and use flockfile() to prevent the line from being
>>> torn apart. Meanwhile, the main thread doing io redirection can reassign
>>> or close stdout when going through tests. A deadlock as shown below can
>>> happen.
>>>
>>>          main                      traffic_monitor_thread
>>>          ====                      ======================
>>>                                    show_transport()
>>>                                    -> flockfile(stdout)
>>>
>>> stdio_hijack_init()
>>> -> stdout = open_memstream(log_buf, log_cnt);
>>>      ...
>>>      env.subtest_state->stdout_saved = stdout;
>>>
>>>                                       ...
>>>                                       funlockfile(stdout)
>>> stdio_restore_cleanup()
>>> -> fclose(env.subtest_state->stdout_saved);
>>
>> Great debugging.
>>
>> Does it mean that the main thread will start the next test before the
>> traffic_monitor_thread has finished? Meaning the traffic_monitor_stop() does not
>> wait for the traffic_monitor_thread somehow?
> 
> That part I think is fine. The race condition here happen between
> subtests within the same "netns_new" scope. For example,
> test_flow_dissector_skb_less_direct_attach.

Got it. Thanks for the fix. Applied.


