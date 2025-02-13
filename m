Return-Path: <bpf+bounces-51478-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 583B8A3525D
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 00:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFBA23AB9C7
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 23:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD251C8603;
	Thu, 13 Feb 2025 23:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="om6qQM+g"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D924E275419
	for <bpf@vger.kernel.org>; Thu, 13 Feb 2025 23:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739490928; cv=none; b=DeNe78ARj4s3kHZqoMfyFkae3LrbOU+YjGffhIjXWDEpxSVZ7t9drWK+u7FAB5f6l2KyrCVco9sZ2vSOYiqWKCOO7L4riZ9etGYgZoUefKCWINWpG4MM2/1agrpHT7QhASTYORLQkfkQhTB6X79M+20lNbcf91+sb63vFwSfucA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739490928; c=relaxed/simple;
	bh=LXcDrX4DNiryH7pVQm3v/K7gXJY3yGfZFPe/ygAyfz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VtSjIXdTzWh70kOzjgP2RbAK/6ULiSGXNfnRlqx9EffSMgIhW+MizTuE1v/7ERlAT3Ue7cAN89M4ndI2mCnWg00adESeUrgX1PaT6T6DLGvt/W5j1ossg2NyGfDYJzDQGXs/kzsde7Mp7LyIsWAmcostFRkCtVIbzOJOHSj74xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=om6qQM+g; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <cfe7a83f-a2de-4157-8a43-abbe95968b05@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739490923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1It1/3P9kW2YumZlyEGA7VHWrQRddbB/YbTT1iipQ40=;
	b=om6qQM+gmhkuiBi1oc28wLDgeMpNgB4FRhogQ5DTtzBwDCFSQwhU/ztUYvx0IfjmZR0Cy2
	3qvO3XmJ3Wbu8p1QOGfWhsOIaTJAfOlSpye8c24A2C98kP4lZTpwMATq4ckaTPsiwt3BlH
	xPGu6aYAs6GFiq72KRwFFjInru+CqcU=
Date: Thu, 13 Feb 2025 15:55:17 -0800
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
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250213233217.553258-1-ameryhung@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/13/25 3:32 PM, Amery Hung wrote:
> Fix a race condition between the main test_progs thread and the traffic
> monitoring thread. The traffic monitor thread tries to print a line
> using multiple printf and use flockfile() to prevent the line from being
> torn apart. Meanwhile, the main thread doing io redirection can reassign
> or close stdout when going through tests. A deadlock as shown below can
> happen.
> 
>         main                      traffic_monitor_thread
>         ====                      ======================
>                                   show_transport()
>                                   -> flockfile(stdout)
> 
> stdio_hijack_init()
> -> stdout = open_memstream(log_buf, log_cnt);
>     ...
>     env.subtest_state->stdout_saved = stdout;
> 
>                                      ...
>                                      funlockfile(stdout)
> stdio_restore_cleanup()
> -> fclose(env.subtest_state->stdout_saved);

Great debugging.

Does it mean that the main thread will start the next test before the 
traffic_monitor_thread has finished? Meaning the traffic_monitor_stop() does not 
wait for the traffic_monitor_thread somehow?

> 
> After the traffic monitor thread lock stdout, A new memstream can be
> assigned to stdout by the main thread. Therefore, the traffic monitor
> thread later will not be able to unlock the original stdout. As the
> main thread tries to access the old stdout, it will hang indefinitely
> as it is still locked by the traffic monitor thread.
> 
> The deadlock can be reproduced by running test_progs repeatedly with
> traffic monitor enabled:
> 
> for ((i=1;i<=100;i++)); do
>    ./test_progs -a flow_dissector_skb* -m '*'
> done
> 
> Fix this by only calling printf once and remove flockfile()/funlockfile().

Yep. I agree this patch should be the better way to print the one-liner regardless.


