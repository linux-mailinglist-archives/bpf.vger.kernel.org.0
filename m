Return-Path: <bpf+bounces-68385-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE08BB578E8
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 13:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E53CD188F658
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 11:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9E93002CB;
	Mon, 15 Sep 2025 11:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bhPdxGmd"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025E33002C2
	for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 11:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757936831; cv=none; b=ikE/OF7R7gus2YvLXI5x9ZplyNn75lWilWytUoKscmQbAr5f9BNcGGd0sjMvOJobRmfbfw/hSLv2sBhvwEKq2Hz0YjEO1tDCzUG7p+DS3OMI+O+HKgCi6IO+7BAK4qHbn70QDxmfizyqYnATkeKA/UZHo/ntsczn8fpMkNwXRBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757936831; c=relaxed/simple;
	bh=A6DWAt1IiKGMi9S1OWi9k6r16LwHIPa0QldpsWcH2ag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QujY6kj5wO4yvw/7XO+pEJHqnwsGZ63KNFO2iWuikqD1wsVm84qiGzzWFeyJ88He5E/qblH5PT+CwxxUKDImRNalygPTOiCEByA6c/CIobk1/0HJIbIehr76nEbcQjyeBwAOasf0Ay69qMJ6rIUjXtie/59JXRB2Pr2AkhZNH98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bhPdxGmd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 863B6C4CEF1;
	Mon, 15 Sep 2025 11:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757936828;
	bh=A6DWAt1IiKGMi9S1OWi9k6r16LwHIPa0QldpsWcH2ag=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bhPdxGmdBZZnQaKBIYa5w+fDsSkjgQqAWQ0J76+m6RclY1EszU5H5jIsbqcjTWX6E
	 vCYiALmbaCHvEl7peFLrpHdhRdXH5XeqJk3PV1zLacGiGCBmcSMfmPzAbc6eKcL+xp
	 m5/igPoCydvO6o2Kej5UkAKVpeSY5tCTG5HOoaLROAe6wmqOyS3qSKZ2nqRmwdDLM7
	 3BgG7yU43Co72VzMedlILdAeyYMKefIYyPCzeAJI3Hp3hzteq3T4X5nUzS6OrzXiwU
	 et2XYnBY6rUIkcp++LvnoTPu9ckx93VH1zuz87f7HR200fL6WMDO36W02qZkZszhUq
	 9HjPx4LNHIn+g==
Message-ID: <db1f3718-f733-451b-9861-6ca45dc6edfb@kernel.org>
Date: Mon, 15 Sep 2025 12:47:04 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpftool: Search for tracefs at
 /sys/kernel/tracing first
To: Daniel Borkmann <daniel@iogearbox.net>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 bpf@vger.kernel.org
References: <20250912104343.58555-1-qmo@kernel.org>
 <055e1c7a-410f-4843-bec4-e545f032b145@iogearbox.net>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <055e1c7a-410f-4843-bec4-e545f032b145@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2025-09-15 13:33 UTC+0200 ~ Daniel Borkmann <daniel@iogearbox.net>
> On 9/12/25 12:43 PM, Quentin Monnet wrote:
> [...]
>> diff --git a/tools/bpf/bpftool/tracelog.c b/tools/bpf/bpftool/tracelog.c
>> index 31d806e3bdaa..49828a4f60c2 100644
>> --- a/tools/bpf/bpftool/tracelog.c
>> +++ b/tools/bpf/bpftool/tracelog.c
>> @@ -57,10 +57,8 @@ find_tracefs_mnt_single(unsigned long magic, char
>> *mnt, const char *mntpt)
>>   static bool get_tracefs_pipe(char *mnt)
>>   {
>>       static const char * const known_mnts[] = {
>> -        "/sys/kernel/debug/tracing",
>>           "/sys/kernel/tracing",
>> -        "/tracing",
>> -        "/trace",
>> +        "/sys/kernel/debug/tracing",
>>       };
>>       const char *pipe_name = "/trace_pipe";
>>       const char *fstype = "tracefs";
>> @@ -96,11 +94,11 @@ static bool get_tracefs_pipe(char *mnt)
>>         p_info("could not find tracefs, attempting to mount it now");
>>       /* Most of the time, tracefs is automatically mounted by debugfs at
>> -     * /sys/kernel/debug/tracing when we try to access it. If we
>> could not
>> +     * /sys/kernel/tracing when we try to access it. If we could not
>>        * find it, it is likely that debugfs is not mounted. Let's give
>> one
> 
> nit: Should this comment be tweaked further, or maybe even removed
> completely
> given the now stale references to debugfs there?


Hi Daniel! Re-reading it, I realise my change for the comment is not
even correct, /sys/kernel/tracing is not mounted automatically. So yes,
I'll send a v2 to remove it. Thanks for the review!

Quentin

