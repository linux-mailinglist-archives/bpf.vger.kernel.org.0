Return-Path: <bpf+bounces-69443-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F0FB96A86
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 17:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AFA117DDF3
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 15:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451D22609CC;
	Tue, 23 Sep 2025 15:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="D8ZT0TGc"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA25A4A32
	for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 15:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758642640; cv=none; b=F82XUD5vyhTt+QL0jVLIOpic6Pj8V2MjbpEjYpp6iRMYmVGctDauNAkMv2RQlEceWueEgd3qEKLEwNy0WZHqHk8DY6+PZbA7frJOZQLnmk752gCMsXyRmMbRmCcMyBEI2aVnx9oIZf+WIPwmSBW/38lAJAko+Jdcj4lf5hjkteA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758642640; c=relaxed/simple;
	bh=D0Ys0V7YY+L+g2R6Qoa2zvPICTQBk78tdFFTcgsBLH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gN5oitYpQ3ZxnJrv9Yrc8FoW4KlRD1ZRkDTQMjNt5LBaPHd+m3bgLP/IVMf+TIVkUT7Ee9khP06q2nzUeeTFC85RYHSyUtUo5nqX9Or5Wd84arGGlkjIYtnhyFkdjjD6OGY3vs2P9E2cV5t4EAIzuesmDMmtUzxCXeP/X4KKGhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=D8ZT0TGc; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <99b04dfb-4d0e-4446-9957-72af96afd94b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758642635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yptEFbHZ9xnZajkN8TsAr9AKceLtZum3uc051ia07VA=;
	b=D8ZT0TGcNJr3MuyHv7P7EckFQXDOgXfLoKLxLlKS6RoMkGuFZf9DKgjQ/N+r3sO1CQT+WG
	M2oJhf+g8+1I2imnEYCe3TmaRjxgjVdJ+zi5X+jfwoDjNUAAM+H8K916uyYY1uBjqxOCI1
	iPPRawMPsgOxGW4mduzCchseC4fgzw0=
Date: Tue, 23 Sep 2025 08:50:11 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v8 8/9] selftests/bpf: BPF task work scheduling
 tests
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin Lau <kafai@meta.com>, Kernel Team <kernel-team@meta.com>,
 Eduard <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Mykyta Yatsenko <yatsenko@meta.com>
References: <20250923112404.668720-1-mykyta.yatsenko5@gmail.com>
 <20250923112404.668720-9-mykyta.yatsenko5@gmail.com>
 <CAADnVQKS0bWcSJns4zF_mmKnh4+is3faM5wPt1O-Y0FdiP7UeQ@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <CAADnVQKS0bWcSJns4zF_mmKnh4+is3faM5wPt1O-Y0FdiP7UeQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 9/23/25 7:59 AM, Alexei Starovoitov wrote:
> On Tue, Sep 23, 2025 at 4:24 AM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
>> +static void task_work_run(const char *prog_name, const char *map_name)
>> [...]
> 
> Applied, but this one is buggy.
> It seems to be missing perf_event cleanup.
> Pls send a fix asap.
> 
> ./test_progs -t bpf_cookie
> ...
> #18      bpf_cookie:OK
> Summary: 1/11 PASSED, 0 SKIPPED, 0 FAILED
> 
> ./test_progs -t task_work
> ...
> #434     task_work:OK
> #435/1   task_work_stress/no_delete:OK
> #435/2   task_work_stress/with_delete:OK
> #435     task_work_stress:OK
> Summary: 2/9 PASSED, 0 SKIPPED, 0 FAILED
> 
> ./test_progs -t bpf_cookie
> test_bpf_cookie:PASS:skel_open 0 nsec
> #18/1    bpf_cookie/kprobe:OK
> #18/2    bpf_cookie/multi_kprobe_link_api:OK
> #18/3    bpf_cookie/multi_kprobe_attach_api:OK
> #18/4    bpf_cookie/uprobe:OK
> #18/5    bpf_cookie/multi_uprobe_attach_api:OK
> #18/6    bpf_cookie/tracepoint:OK
> pe_subtest:FAIL:perf_fd unexpected perf_fd: actual -1 < expected 0
> #18/7    bpf_cookie/perf_event:FAIL
> #18/8    bpf_cookie/trampoline:OK
> #18/9    bpf_cookie/lsm:OK
> #18/10   bpf_cookie/tp_btf:OK
> #18/11   bpf_cookie/raw_tp:OK
> #18      bpf_cookie:FAIL
> 
> 
> Ihor,
> 
> we probably should extend CI to run test_progs twice in the same VM
> to catch such cleanup issues.

Acked. Will come up with something.

