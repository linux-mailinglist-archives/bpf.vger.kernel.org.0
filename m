Return-Path: <bpf+bounces-35046-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0111A937273
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 04:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FAE61F21E56
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 02:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89FE8F77;
	Fri, 19 Jul 2024 02:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="w7jNfObQ"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E00184D
	for <bpf@vger.kernel.org>; Fri, 19 Jul 2024 02:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721355723; cv=none; b=ak1gxvXspI2UMPF5Z3zVZ++9yVcibpcTq9Zz+1FZrn7bCL8T31X9Vlpdjz780Ffd5zaNmazvaLKb6SYecj7fpwtTBHQx1FMAVz2x93ao8d3SXMnTdX75WMVGdn4zS4FpTZehvsbB9ilaGIl+mxDr/S7zxVHhb8qlu76RArrlVpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721355723; c=relaxed/simple;
	bh=OGb48PhbvK8H+IcX+yr7uc56hIVaWqdbQcaMRfPenGo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TEJexDmDe0Wk+uzSNaPsQB1o+kkUYRuAUCB3FuBEcXcOG4JWuc9m1hg7dXl6BsENjWO+01SEwR0h9P5nNihtxj2qClzwmoYPP2ybWWnyuuZQjOqDJy9pX5bk/YR2ihlJtMxesMAa2WXKH/n24R+Jtzp5MbL5QsvGgHOHt5S1+N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=w7jNfObQ; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: alexei.starovoitov@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721355718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j6Uu43x98t4sVo9ymM6kp7LEo+jkrJuXjpqsFUatoiQ=;
	b=w7jNfObQYOmpBLiHBmX3ANFMR23LTEOaD9Y4oYNTF+CbVsbaVKFgA2+TcrcrRGopG8n0c8
	VNLjbC55yTL31xRQwYUO64EVKrsw4/8b23GEg8CSMjdgiwP7Z2N4HkeXmQJ/tztV+oq+ih
	z2tIh9wokV/GaSNHpWeY5Y4n32XCGuM=
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: ast@kernel.org
X-Envelope-To: andrii@kernel.org
X-Envelope-To: daniel@iogearbox.net
X-Envelope-To: kernel-team@fb.com
X-Envelope-To: martin.lau@kernel.org
Message-ID: <66b5c1ea-d945-4d72-8003-e807452918fa@linux.dev>
Date: Thu, 18 Jul 2024 19:21:51 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 2/2] [no_merge] selftests/bpf: Benchmark
 runtime performance with private stack
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
References: <20240718205158.3651529-1-yonghong.song@linux.dev>
 <20240718205203.3652080-1-yonghong.song@linux.dev>
 <1297da19-18a7-4727-8dab-e45ef0651e14@linux.dev>
 <CAADnVQJ_-FR45o89SWJWZPD4+A+AEArJf1Pjw41=9f0+Ujzg+g@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQJ_-FR45o89SWJWZPD4+A+AEArJf1Pjw41=9f0+Ujzg+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 7/18/24 5:36 PM, Alexei Starovoitov wrote:
> On Thu, Jul 18, 2024 at 2:44 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>>>     $ perf record -- ./bench -w3 -d10 -a --nr-batch-iters=4096 private-stack
>>>       18.94%  bench                                              [k]
>>>       16.88%  bench    bpf_prog_bcf7977d3b93787c_func1           [k] bpf_prog_bcf7977d3b93787c_func1
>>>       15.77%  bench    bpf_trampoline_6442522961                 [k]
> ...
>
>>> NOTE: I tried 6.4 perf and 6.10 perf, both of which have issues. I will investigate this further.
>> I tried with perf built with latest bpf-next and with no-private-stack, the issue still
>> exists. Will debug more.
> Try this fix:
> https://lore.kernel.org/all/20240714065533.1112616-1-houtao@huaweicloud.com/

It does fix the problem. The 'perf report' for private-stack flavor:

   18.94%  bench    bpf_prog_71f1b7d5309b304a_bench_trigger_fentry_batch  [k] bpf_prog_71f1b7d5309b304a_bench_trigger_fentry_batch
   16.50%  bench    bpf_prog_bcf7977d3b93787c_func1                       [k] bpf_prog_bcf7977d3b93787c_func1
   15.75%  bench    bpf_trampoline_6442522961                             [k] bpf_trampoline_6442522961
   11.72%  bench    [kernel.vmlinux]                                      [k] migrate_enable
   11.63%  bench    [kernel.vmlinux]                                      [k] __bpf_prog_enter_recur
   11.37%  bench    [kernel.vmlinux]                                      [k] __bpf_prog_exit_recur
    6.17%  bench    [kernel.vmlinux]                                      [k] migrate_disable
    3.59%  bench    bpf_prog_d9703036495d54b0_trigger_driver              [k] bpf_prog_d9703036495d54b0_trigger_driver
    3.51%  bench    [kernel.vmlinux]                                      [k] bpf_get_numa_node_id
    0.05%  bench    bench                                                 [.] bpf_prog_test_run_opts

>
> btw you were cc-ed on it. your @ fb goes to spam ? ;)

It is in my inbox. Sadly I skipped it since it is for perf system and I focused on
several of my patches in the last few days.


