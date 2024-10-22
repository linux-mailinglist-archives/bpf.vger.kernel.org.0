Return-Path: <bpf+bounces-42848-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5634A9ABA3E
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 01:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 853591C22C29
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 23:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6741CEEA4;
	Tue, 22 Oct 2024 23:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qgM3v+9p"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313021CEE82
	for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 23:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729641243; cv=none; b=X9WC0PlMsFzZhUMuStBIQbYfHn7jPsGaSbQ7p05KzoHqj7PbqUb9CSkP+AX4P1WVJgR/lW/pe3M0od7mfyTJYwMTlqpR71rxibFRSXu2qtXTBBgXTGp2GfO+oXtXN0avtk/Rfm8mq3Qj/K4kiXT90qKfky+I4iA4DXl1ms27ng8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729641243; c=relaxed/simple;
	bh=lNGvoEdvsNGeXTcPZk/COZXpKYhVhOe9FYFIHiP7xQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YW+W2HyzR/hwJP95LUsQjk42nVix5w6rPSu301CdXa+Yo0cDIsBrsFEDAP6w0K3PJgQ9qoPh8gfAGF2IXDEosTBCc/wn4EZF+oUAME2r/aPaVGhzML/8O7+1bZ+XJCrHiFK9A9TyhASVJsDPz0QWx+cImGSjdJOZB7kGGL/C9Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qgM3v+9p; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a89fb4e8-5164-4b98-b958-2b92cb6e4822@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729641238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MVAY898YJSM9VwJRWtncr8ydzdANXdITgfkKeR7i9b0=;
	b=qgM3v+9pJuYPhKD1OOMQt58Odq/nFDa3YROgjxwzMBC06dONeZ/pzhJIEAm6acytTqgOnR
	LB79wk4YvJ/5tWVuKcXdIHNDCkEF5oyl8uGmQqx88ccw9cUA+MVIMw85hYU+gnB1myNG35
	PaA4WBfEm7mi4bvJ+NACn+J+4FkIp60=
Date: Tue, 22 Oct 2024 16:53:39 -0700
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
 <8f572c9d-00c2-48b7-b57f-bd6445c5d514@linux.dev>
 <CAADnVQ+hCW+BqFMuUQsiTNqd7jz=Lupo-h0N=f2tdeUS0vcB1g@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQ+hCW+BqFMuUQsiTNqd7jz=Lupo-h0N=f2tdeUS0vcB1g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 10/22/24 3:59 PM, Alexei Starovoitov wrote:
> On Tue, Oct 22, 2024 at 3:41 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>> On 10/22/24 2:57 PM, Alexei Starovoitov wrote:
>>> On Tue, Oct 22, 2024 at 2:43 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>>> To handle a subprog may be used in more than one
>>>> subtree (subprog 0 tree or async tree), I need to
>>>> add a 'visited' field to bpf_subprog_info.
>>>> I think this should work.
>>> This is getting quite complicated.
>>>
>>> But looks like we have even bigger problem:
>>>
>>> SEC("lsm/...")
>>> int BPF_PROG(...)
>>> {
>>>     volatile char buf[..];
>>>     buf[..] =
>>> }
>> If I understand correctly, lsm/... corresponds to BPF_PROG_TYPE_LSM prog type.
>> The current implementation only supports the following plus struct_ops programs.
>>
>> +       switch (env->prog->type) {
>> +       case BPF_PROG_TYPE_KPROBE:
>> +       case BPF_PROG_TYPE_TRACEPOINT:
>> +       case BPF_PROG_TYPE_PERF_EVENT:
>> +       case BPF_PROG_TYPE_RAW_TRACEPOINT:
>> +               return true;
>> +       case BPF_PROG_TYPE_TRACING:
>> +               if (env->prog->expected_attach_type != BPF_TRACE_ITER)
>> +                       return true;
>> +               fallthrough;
>> +       default:
>> +               return false;
>> +       }
>>
>> I do agree that lsm programs will have issues if using private stack
>> since preemptible is possible and we don't have recursion check for
>> them (which is right in order to provide correct functionality).
> static inline bool bpf_prog_check_recur(const struct bpf_prog *prog)
> {
>          switch (resolve_prog_type(prog)) {
>          case BPF_PROG_TYPE_TRACING:
>                  return prog->expected_attach_type != BPF_TRACE_ITER;
>          case BPF_PROG_TYPE_STRUCT_OPS:
>          case BPF_PROG_TYPE_LSM:
>                  return false;
>          default:
>                  return true;
>          }
> }
>
> LSM prog is an example. The same issue is with struct_ops progs.
> But struct_ops sched-ext progs is main motivation for adding
> priv stack.
>
> sched-ext will signal to bpf that it needs priv stack and
> we would have to add "recursion no more than 1" check
> and there is a chance (like above LSM prog demonstrates)
> that struct_ops will be hitting this recursion check
> and the prog will not be run.
> The miss count will increment, of course, but the whole
> priv stack feature for struct_ops becomes unreliable.
> Hence the patches become questionable.
> Why add a feature when the main user will struggle to use it.

Indeed, this is a known issue we kind of already aware of.
The recursion check (regardless it is one or four) may cause
prog no run if actual recursion level is beyond what recursion
check is doing.

I guess we indeed need to go back to drawing board again,
starting from struct_ops which is the main motivation of this
idea.


