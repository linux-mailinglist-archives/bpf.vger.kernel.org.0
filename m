Return-Path: <bpf+bounces-42840-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C3A9AB997
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 00:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1DDD28413F
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 22:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4CE1CDA24;
	Tue, 22 Oct 2024 22:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VqcKm/th"
X-Original-To: bpf@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2717B1CCEFA
	for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 22:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729636911; cv=none; b=mEVgjhJXkfRUABOpZKl3IFnok7QrcnRbfeXlYUh2YnJHNZKaVEbtk+n7EU1q6ZiXPVyOXShvZ3N9VUlRP7BxXeyx61KW/dbhCy+fOfCqecQX/pixCBTUHdEXXQ9pl/GLi75NDdFO9C76g/LV8kf9XI+vwCLR7EkWOk8iIak/uDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729636911; c=relaxed/simple;
	bh=WgNSbo/AImVhxf5W0qyt3YtRMTqVYFAooszjmMx4Iss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oKqpKUF8wSks1ujKiijHeYApC+co6WZLEQUeZmkU3rFLXHsHPeojb4tpkpUsdLQF2IE1kn3/oF5nai607msuGWAejjAr7LjqvUNNKE6tCJPNUOGFfOjpTIiJALmTUebp3czrM7AVKQ7z9u0h8iikWJCdLm1TuhPU9H6bOdNw/jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VqcKm/th; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8f572c9d-00c2-48b7-b57f-bd6445c5d514@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729636907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q9rEkTnLitVo+CR2r6cJsh/Zdkqkwgq+EGp91OH5fLI=;
	b=VqcKm/th54uz0ugPPNjM10vmQvPQ3Zp8bVZSnjMKnXHY0gQKaODrvCgUm+JMPW/QoUEbBu
	PsskcWFlONM8P9wHfSjzpebw6TXx/AXg6hRPkPBtGhoQ/Q6/7oFDTXX5dNHQLbkMEjZ7yb
	eCmAYjOchRiQt0Ui41RqpimaK7ZNuWA=
Date: Tue, 22 Oct 2024 15:41:38 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 1/9] bpf: Allow each subprog having stack size
 of 512 bytes
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>,
 Tejun Heo <tj@kernel.org>
References: <20241020191341.2104841-1-yonghong.song@linux.dev>
 <20241020191347.2105090-1-yonghong.song@linux.dev>
 <CAADnVQ+ZXMh_QKy0nd-n7my1SETroockPjpVVJOAWsE3tB_5sg@mail.gmail.com>
 <c6e5040b-9558-481f-b1fc-f77dc9ce90c1@linux.dev>
 <CAADnVQJCfiNEgrvf6GuaUadz6rDSNU6QB3grpOfk2-jQP6is4Q@mail.gmail.com>
 <179d5f87-4c70-438b-9809-cc05dffc13de@linux.dev>
 <CAADnVQL3+o7xV2LQcO-AArBmSEV=CQ7TQsuzBfTUnc_g+MhoMw@mail.gmail.com>
 <489b0524-49bc-4df4-8744-1badd40824be@linux.dev>
 <CAADnVQJJxyoLvFY88OEGzy0MUnL5O8KCMdedDdAvqYcWDJsDXw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQJJxyoLvFY88OEGzy0MUnL5O8KCMdedDdAvqYcWDJsDXw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 10/22/24 2:57 PM, Alexei Starovoitov wrote:
> On Tue, Oct 22, 2024 at 2:43 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>> To handle a subprog may be used in more than one
>> subtree (subprog 0 tree or async tree), I need to
>> add a 'visited' field to bpf_subprog_info.
>> I think this should work.
> This is getting quite complicated.
>
> But looks like we have even bigger problem:
>
> SEC("lsm/...")
> int BPF_PROG(...)
> {
>    volatile char buf[..];
>    buf[..] =
> }

If I understand correctly, lsm/... corresponds to BPF_PROG_TYPE_LSM prog type.
The current implementation only supports the following plus struct_ops programs.

+       switch (env->prog->type) {
+       case BPF_PROG_TYPE_KPROBE:
+       case BPF_PROG_TYPE_TRACEPOINT:
+       case BPF_PROG_TYPE_PERF_EVENT:
+       case BPF_PROG_TYPE_RAW_TRACEPOINT:
+               return true;
+       case BPF_PROG_TYPE_TRACING:
+               if (env->prog->expected_attach_type != BPF_TRACE_ITER)
+                       return true;
+               fallthrough;
+       default:
+               return false;
+       }

I do agree that lsm programs will have issues if using private stack
since preemptible is possible and we don't have recursion check for
them (which is right in order to provide correct functionality).

>
> The approach to have per-prog per-cpu priv stack
> doesn't work for the above.
> Sleepable and non-sleepable LSM progs are preemptible.
> Multiple tasks can be running the same program on the same cpu
> preempting each other.
> The priv stack of this prog will be corrupted.
>
> Maybe it won't be an issue for sched-ext prog
> attached to a cgroup, but it feels fragile for bpf infra
> to rely on implementation detail of another subsystem.
> We probably need to go back to the drawing board.

