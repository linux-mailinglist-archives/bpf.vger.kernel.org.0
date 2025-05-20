Return-Path: <bpf+bounces-58597-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7772FABE40E
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 21:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF2FF7A53D4
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 19:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7F0281352;
	Tue, 20 May 2025 19:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fpxzjbtR"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CFB157487
	for <bpf@vger.kernel.org>; Tue, 20 May 2025 19:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747770667; cv=none; b=DEgyFwO2N5QvmP7wG02DDX7frtItdoqh/g8mdDdAb26VivAopjSjwF0CoT0eZFFKjkkbRHohOXROO2IJjYZijYnHQORKPuTHNu+IpzxJ43k/0hlmedy9uSaNNb+E2b30aILlsKzdxv0PrJ0H9Y7bLU0SJEGdSFLVj/a2oR32i8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747770667; c=relaxed/simple;
	bh=rtMhPgLF66Y12FegexlAHU6LQgkH4cDkYk+lbajOdNk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UuAvssPn5I2zletzGjewc0bOQoxa+6ZxQHaNzCRqWwlYr29PgURtsVngEBbRj7hq837K8diMIrNWYmo7fyEblOrZkS+lnApZWbuNOO1shFk4BSMU8rtslPuIRgrYsrIYkLE0wGnjMlSY/uuFsXjIhpaV51ZR9NDzzTZDF3SRGOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fpxzjbtR; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9a9d68fc-38c4-4c52-b62a-c0c4a522684d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747770661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9BzBJv+0GArlNa5r18tN778JHMk1TICmVHHcAfyKBEM=;
	b=fpxzjbtRfbY0ePa+w8Wh2xXTUsT8uCHELhH2CFoE3jIX+qyfl16SCiopbGcwqJloN3gzS1
	DIq2HNIDEcVO9eZE5i14d2DkEP1XgFWEarW2G5uNzD96JRkjHmCLh07bg7HtinETBFF6WU
	o/Z7zPHjb8bpUMhgANSZI+oobGKKED8=
Date: Tue, 20 May 2025 12:50:56 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Warn with bpf_unreachable() kfunc
 maybe due to uninitialized variable
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Kernel Team <kernel-team@fb.com>,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20250519203339.2060080-1-yonghong.song@linux.dev>
 <20250519203344.2060544-1-yonghong.song@linux.dev>
 <CAADnVQKR=i3qqxHcs3d2zcCEejz71z8GE2y=tghDPF2rFZUObg@mail.gmail.com>
 <85503b11-ccce-412e-b031-cc9654d6291d@linux.dev>
 <CAADnVQLvN-TshyvkY3u9MYc7h_og=LWz7Ldf2k_33VRDqKsUZw@mail.gmail.com>
 <1330496e-5dda-4b42-9524-4bfcfeb50ba7@linux.dev>
 <CAADnVQKipc=mML1ZjcMjKgKrP_L+wUPhAo0feFf6=DVqdWpCPQ@mail.gmail.com>
 <CAADnVQL7mrgvPbDCnsFAG5vhzmkEfxP9Z9nxRHR15gdtBHDsBg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQL7mrgvPbDCnsFAG5vhzmkEfxP9Z9nxRHR15gdtBHDsBg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 5/20/25 2:46 AM, Alexei Starovoitov wrote:
> On Tue, May 20, 2025 at 11:39 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>> So another idea...
>>
>> maybe we should remove special_kfunc_set instead?
>>
>> I recall we argued with Kumar years ago about it.
>> I don't remember why we kept it
>> and what purpose it serves now.
>>
>> What will break if we do:
>>
>> -               if (meta.btf == btf_vmlinux &&
>> btf_id_set_contains(&special_kfunc_set, meta.func_id)) {
>> +               if (meta.btf == btf_vmlinux) {
>>                          if (meta.func_id ==
>> special_kfunc_list[KF_bpf_obj_new_impl] ||
>>                              meta.func_id ==
>> special_kfunc_list[KF_bpf_percpu_obj_new_impl]) {
>>                                  struct btf_struct_meta *struct_meta;
>> @@ -13838,10 +13838,6 @@ static int check_kfunc_call(struct
>> bpf_verifier_env *env, struct bpf_insn *insn,
>>                                   * because packet slices are not refcounted (see
>>                                   * dynptr_type_refcounted)
>>                                   */
>> -                       } else {
>> -                               verbose(env, "kernel function %s
>> unhandled dynamic return type\n",
>> -                                       meta.func_name);
>> -                               return -EFAULT;
>>                          }
>>
>> ?
> Found old Kumar's reply:
> https://lore.kernel.org/bpf/20221120204625.ndtr7ygh7zgjxrsz@apollo/
>
> and my old reply:
> https://lore.kernel.org/bpf/20221120222922.udsuzkr5hcvjzot5@macbook-pro-5.dhcp.thefacebook.com/
>
> I think we need to remove special_kfunc_set,
> and then special_kfunc_list[] can stay as-is,
> and we can keep adding new kfuncs to it like bpf_unreachable in this case.

Okay, I will remove special_kfunc_set() then. Thanks!


