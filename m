Return-Path: <bpf+bounces-43992-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3EC9BC36D
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 03:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B20D28294F
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 02:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6409C4F218;
	Tue,  5 Nov 2024 02:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="J+MZ8qDk"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEDF36AF5
	for <bpf@vger.kernel.org>; Tue,  5 Nov 2024 02:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730775215; cv=none; b=NQt7zhuKbAToUdfggoNb4c/cl4nP2LH/8qC/E1rA/STdLMV+J9+upW2XDkhSA8xXWGFbjtQk61GX334Z9OfFmttmAmIMY+2LBi4BknFhu+QF7Pjo16y+1FDWC2GHT7oHbqSXrXUhv0jgrX8xRGRnzZGt7859d+e++YVKWr6tqqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730775215; c=relaxed/simple;
	bh=0pSrSXXeV0IFH6Uo3JFZhrEBOVEPAr4DIMy6HqYDZuk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZF1JBw5j0WGxQfBlIXkSY4BKmdPAIFHPgY3/wxaJifaAfuRuK4pJZUsEBkxE/6+4aoCT9BkVsPt+7JNmgGWdLdL4nbh1jaVCQ60HAj2JOyySlYkiLe6VqrVjoDwtiK8uICaMujPuPhOCHaw0gF6Qs186bs0a7n2cCST4w+Hy2BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=J+MZ8qDk; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6c78f973-341e-4260-aed4-a5cb8e873acc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730775209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sO+hhU0VwbpzdP/N2QstfdtzEydLNxwil0imVUdP1wI=;
	b=J+MZ8qDk+X6vHmBYLcsm8VU6s9xTmOmnGMvXbMzTleLM6M5zWtjDxpIsUnqE5QOIaJP7cM
	GmT5sBrWDiDu1vKwW+Jw/gogZAMsVtkuSak4LgojPRusYA27c17mChg1KXfF0QL++ODCAi
	6MdHsH6OMBE6xZnfjSFxngdbgrHlxmE=
Date: Mon, 4 Nov 2024 18:53:22 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v9 02/10] bpf: Return false for
 bpf_prog_check_recur() default case
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>,
 Tejun Heo <tj@kernel.org>
References: <20241104193455.3241859-1-yonghong.song@linux.dev>
 <20241104193505.3242662-1-yonghong.song@linux.dev>
 <CAADnVQLr5Rz+L=4CWPxjBGLcYEctLRpPfh642LtNjXKTbyKPgQ@mail.gmail.com>
 <36294e71-4d0b-465d-9bf5-c5640aa3a089@linux.dev>
 <CAADnVQLXbsuzHX6no+CSTAOYxt27jNY5qgtrML6vqEVsggfgRQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQLXbsuzHX6no+CSTAOYxt27jNY5qgtrML6vqEVsggfgRQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 11/4/24 5:55 PM, Alexei Starovoitov wrote:
> On Mon, Nov 4, 2024 at 5:35 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>> On 11/4/24 5:21 PM, Alexei Starovoitov wrote:
>>> On Mon, Nov 4, 2024 at 11:35 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>>>> The bpf_prog_check_recur() funciton is currently used by trampoline
>>>> and tracing programs (also using trampoline) to check whether a
>>>> particular prog supports recursion checking or not. The default case
>>>> (non-trampoline progs) return true in the current implementation.
>>>>
>>>> Let us make the non-trampoline prog recursion check return false
>>>> instead. It does not impact any existing use cases and allows the
>>>> function to be used outside the trampoline context in the next patch.
>>> Does not impact ?! But it does.
>>> This patch removes recursion check from fentry progs.
>>> This cannot be right.
>> The original bpf_prog_check_recur() implementation:
>>
>> static inline bool bpf_prog_check_recur(const struct bpf_prog *prog)
>> {
>>           switch (resolve_prog_type(prog)) {
>>           case BPF_PROG_TYPE_TRACING:
>>                   return prog->expected_attach_type != BPF_TRACE_ITER;
>>           case BPF_PROG_TYPE_STRUCT_OPS:
>>           case BPF_PROG_TYPE_LSM:
>>                   return false;
>>           default:
>>                   return true;
>>           }
>> }
>>
>> fentry prog is a TRACING prog, so it is covered. Did I miss anything?
> I see. This is way too subtle.
> You're correct that fentry is TYPE_TRACING,
> so it could have "worked" if it was used to build trampolines only.
>
> But this helper is called for other prog types:
>
>          case BPF_FUNC_task_storage_get:
>                  if (bpf_prog_check_recur(prog))
>                          return &bpf_task_storage_get_recur_proto;
>                  return &bpf_task_storage_get_proto;
>
> so it's still not correct, but for a different reason.

There are four uses for func bpf_prog_check_recur() in kernel based on 
cscope: 0 kernel/bpf/trampoline.c bpf_trampoline_enter 1053 if 
(bpf_prog_check_recur(prog)) 1 kernel/bpf/trampoline.c 
bpf_trampoline_exit 1068 if (bpf_prog_check_recur(prog)) 2 
kernel/trace/bpf_trace.c bpf_tracing_func_proto 1549 if 
(bpf_prog_check_recur(prog)) 3 kernel/trace/bpf_trace.c 
bpf_tracing_func_proto 1553 if (bpf_prog_check_recur(prog)) The 2nd and 
3rd ones are in bpf_trace.c. 1444 static const struct bpf_func_proto * 
1445 bpf_tracing_func_proto(enum bpf_func_id func_id, const struct 
bpf_prog *prog) 1446 { 1447 switch (func_id) { ... 1548 case 
BPF_FUNC_task_storage_get: 1549 if (bpf_prog_check_recur(prog)) 1550 
return &bpf_task_storage_get_recur_proto; 1551 return 
&bpf_task_storage_get_proto; 1552 case BPF_FUNC_task_storage_delete: 
1553 if (bpf_prog_check_recur(prog)) 1554 return 
&bpf_task_storage_delete_recur_proto; 1555 return 
&bpf_task_storage_delete_proto; ... 1568 default: 1569 return 
bpf_base_func_proto(func_id, prog); 1570 } 1571 } They are used for 
tracing programs. So we should be safe here. But if you think that 
changing bpf_proc_check_recur() and calling function 
bpf_prog_check_recur() in bpf_enable_priv_stack() is too subtle, I can 
go back to my original approach which makes all supported prog types 
explicit in bpf_enable_priv_stack().


