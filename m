Return-Path: <bpf+bounces-42802-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E179AB50A
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 19:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F321F283539
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 17:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A151BCA1B;
	Tue, 22 Oct 2024 17:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kZ7+5KPE"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131D91A4F01
	for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 17:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729618028; cv=none; b=FZRryi9B0PRjXZ5C54pAh36Bt54uCFy2KxDwxrXZAdQAZJ5YFY9F00oibo0UlZJ0A9+VNiav/AO1jqoaRuPZZmUziL6SJgLaMp7CW+hZthIeLPL0NJ6AoUWoc8BF5x7kJ6dXqHdhhkC+Q06xuY56wzRopCsTlDMAYNnONgZx9PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729618028; c=relaxed/simple;
	bh=UCDNVj0IgOxzDDP5JBH/y/0ztaZgnT/Y0qP3RD1NSiM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FSKDQsn1kQHuG+ywNKNIXxUVgjfGqVztEosuub09kT3Bx9eFDqgZo5w4ODcFiCxMwvL3JMVM3Y/k51i1ahokJWNXo2w3zc7+r+k8ZgwwDM5ZQH1pJCQ+m4QFfX3c8k4FNg0lGVCQLG7zSJ8fJI6ERLtn2XtsojJjnVHLPdxg18w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kZ7+5KPE; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b280e12b-b4e8-4019-ad29-23808d360aee@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729618023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JNvSEL2gVzrPwImr06HWyigAhvK59zdhXrvDupNFgK4=;
	b=kZ7+5KPE+IuwNNMW4GUWgdXrPgzoEMVTSORWEcALqEW0MTPObHruKpQZkbUvT3wS7G5eO4
	GIJofFqVPYWq/0PuiDyrRioSwZ90HjTNqnMVg8kzrqvXvLSq19ExF/Uc/t88S1/mYT/ZDP
	vMjecGpLnN9JL333V/45DGYsIjV4cSY=
Date: Tue, 22 Oct 2024 10:26:54 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 3/9] bpf: Support private stack for struct ops
 programs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>,
 Tejun Heo <tj@kernel.org>
References: <20241020191341.2104841-1-yonghong.song@linux.dev>
 <20241020191400.2105605-1-yonghong.song@linux.dev>
 <CAADnVQ+o35Gf3nmNQLob9PHXj5ojQvKd64MaK+RBJUEOAW1akQ@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAADnVQ+o35Gf3nmNQLob9PHXj5ojQvKd64MaK+RBJUEOAW1akQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 10/21/24 6:34 PM, Alexei Starovoitov wrote:
> On Sun, Oct 20, 2024 at 12:16 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>> To identify whether a st_ops program requests private stack or not,
>> the st_ops stub function is checked. If the stub function has the
>> following name
>>     <st_ops_name>__<member_name>__priv_stack
>> then the corresponding st_ops member func requests to use private
>> stack. The information that the private stack is requested or not
>> is encoded in struct bpf_struct_ops_func_info which will later be
>> used by verifier.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   include/linux/bpf.h         |  2 ++
>>   kernel/bpf/bpf_struct_ops.c | 35 +++++++++++++++++++++++++----------
>>   kernel/bpf/verifier.c       |  8 +++++++-
>>   3 files changed, 34 insertions(+), 11 deletions(-)
>>
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index f3884ce2603d..376e43fc72b9 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -1491,6 +1491,7 @@ struct bpf_prog_aux {
>>          bool exception_boundary;
>>          bool is_extended; /* true if extended by freplace program */
>>          bool priv_stack_eligible;
>> +       bool priv_stack_always;
>>          u64 prog_array_member_cnt; /* counts how many times as member of prog_array */
>>          struct mutex ext_mutex; /* mutex for is_extended and prog_array_member_cnt */
>>          struct bpf_arena *arena;
>> @@ -1776,6 +1777,7 @@ struct bpf_struct_ops {
>>   struct bpf_struct_ops_func_info {
>>          struct bpf_ctx_arg_aux *info;
>>          u32 cnt;
>> +       bool priv_stack_always;
>>   };
>>
>>   struct bpf_struct_ops_desc {
>> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
>> index 8279b5a57798..2cd4bd086c7a 100644
>> --- a/kernel/bpf/bpf_struct_ops.c
>> +++ b/kernel/bpf/bpf_struct_ops.c
>> @@ -145,33 +145,44 @@ void bpf_struct_ops_image_free(void *image)
>>   }
>>
>>   #define MAYBE_NULL_SUFFIX "__nullable"
>> -#define MAX_STUB_NAME 128
>> +#define MAX_STUB_NAME 140
>>
>>   /* Return the type info of a stub function, if it exists.
>>    *
>> - * The name of a stub function is made up of the name of the struct_ops and
>> - * the name of the function pointer member, separated by "__". For example,
>> - * if the struct_ops type is named "foo_ops" and the function pointer
>> - * member is named "bar", the stub function name would be "foo_ops__bar".
>> + * The name of a stub function is made up of the name of the struct_ops,
>> + * the name of the function pointer member and optionally "priv_stack"
>> + * suffix, separated by "__". For example, if the struct_ops type is named
>> + * "foo_ops" and the function pointer  member is named "bar", the stub
>> + * function name would be "foo_ops__bar". If a suffix "priv_stack" exists,
>> + * the stub function name would be "foo_ops__bar__priv_stack".
>>    */
>>   static const struct btf_type *
>>   find_stub_func_proto(const struct btf *btf, const char *st_op_name,
>> -                    const char *member_name)
>> +                    const char *member_name, bool *priv_stack_always)
>>   {
>>          char stub_func_name[MAX_STUB_NAME];
>>          const struct btf_type *func_type;
>>          s32 btf_id;
>>          int cp;
>>
>> -       cp = snprintf(stub_func_name, MAX_STUB_NAME, "%s__%s",
>> +       cp = snprintf(stub_func_name, MAX_STUB_NAME, "%s__%s__priv_stack",
>>                        st_op_name, member_name);
> 
> I don't think this approach fits.
> pw-bot: cr
> 
> Also looking at original
> commit 1611603537a4 ("bpf: Create argument information for nullable arguments.")
> that added this %s__%s notation I'm not sure why we went
> with that approach.
> 
> Just to avoid adding __nullable suffix in the actual callback
> and using cfi stub callback names with such suffixes as
> a "proxy" for the real callback?
> 
> Did we ever use this functionality for anything other than
> bpf_testmod_ops__test_maybe_null selftest ?
> 
> Martin ?

The __nullable is to tag an argument of an ops. The member in the struct (e.g. 
tcp_congestion_ops) is a pointer to FUNC_PROTO and its argument does not have an 
argument name to tag. Hence, we went with tagging the actual FUNC in the cfi object.

The __nullable argument tagging request was originally from sched_ext but I also 
don't see its usage in-tree for now.

For the priv_stack tagging, I also don't think it is a good way of doing it. It 
is like adding __nullable to flag the ops may return NULL pointer which I also 
tried to avoid in the bpf-qdisc patch set.

