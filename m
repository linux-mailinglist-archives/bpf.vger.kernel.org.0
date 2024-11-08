Return-Path: <bpf+bounces-44323-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4F59C1590
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 05:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FBEA2833C0
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 04:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA74D13AA5D;
	Fri,  8 Nov 2024 04:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="HDIeIRG4"
X-Original-To: bpf@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664F613CF82
	for <bpf@vger.kernel.org>; Fri,  8 Nov 2024 04:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731040873; cv=none; b=h3wsrV7gB9v69A6irS/0LCTiEb0nlqwEZ/rrbn7hMvHiURl/j3+oZBYfmxrv4mnAEsUoFOzuLtKa/9ocf28HjY8TqPbMI0ilb2lliqDMd88qWkWfvDpGCWZTOFxW25b43TuibEDlRdkX3OEzvQxMMh5e40Prttrdl4shS50c1gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731040873; c=relaxed/simple;
	bh=CWIzEsREQT9k2V6xeOQ59kKLq64SsrIUaY1VlW5vEfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W/kYJ23zr7sGmXsqeyK+AFztReaViPSGPSdfNzgOIFc+Y/N3rUPlkDr2hA9+cDA4Y/E2W/N/qFXPLh7TVju5vx9TEwhc3MiSsRD9PmaqH5hmeBqHL3V4ACiOtU+29YSgrymw84o/OO47oeUeeItUB/30MfTf8AQCvwwd5sLcnOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=HDIeIRG4; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731040867; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=PIafAXucs8YjvSxDmUIKleG0hdjCoppUTkkbAwih2Qw=;
	b=HDIeIRG4lgM9Vb70DvkNWlDbdeKdnIss6Ueefjp7WLf7uz0JRezJwrBtw3hyWWSPVnC58ZG66dsRNqgdPJc+rUVNiDyYxnFjQJRwWjeVrSoNLycgf2g+oYibX7aqVctU8iY7fUtAekuighMjsu48q6EoeGCz4K32OMb6rOTHGCQ=
Received: from 30.221.128.91(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0WIxgikD_1731040866 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 08 Nov 2024 12:41:07 +0800
Message-ID: <940bc790-62ea-44c6-bd7c-e8bb1f747678@linux.alibaba.com>
Date: Fri, 8 Nov 2024 12:41:05 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] selftests/bpf: skip the timer_lockup test for
 single-CPU nodes
To: Viktor Malik <vmalik@redhat.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
References: <20241107115231.75200-1-vmalik@redhat.com>
From: Philo Lu <lulie@linux.alibaba.com>
In-Reply-To: <20241107115231.75200-1-vmalik@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/11/7 19:52, Viktor Malik wrote:
> The timer_lockup test needs 2 CPUs to work, on single-CPU nodes it fails
> to set thread affinity to CPU 1 since it doesn't exist:
> 
>      # ./test_progs -t test_lockup

nit: s/test_lockup/timer_lockup

>      test_timer_lockup:PASS:timer_lockup__open_and_load 0 nsec
>      test_timer_lockup:PASS:pthread_create thread1 0 nsec
>      test_timer_lockup:PASS:pthread_create thread2 0 nsec
>      timer_lockup_thread:PASS:cpu affinity 0 nsec
>      timer_lockup_thread:FAIL:cpu affinity unexpected error: 22 (errno 0)
>      test_timer_lockup:PASS: 0 nsec
>      #406     timer_lockup:FAIL
> 
> Skip the test if only 1 CPU is available.
> 
> Signed-off-by: Viktor Malik <vmalik@redhat.com>
> Fixes: 50bd5a0c658d1 ("selftests/bpf: Add timer lockup selftest")
> ---

Can reproduce this issue and this patch solves it.

Tested-by: Philo Lu <lulie@linux.alibaba.com>

Cheers.
-- 
Philo


