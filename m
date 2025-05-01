Return-Path: <bpf+bounces-57147-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C4DAA648D
	for <lists+bpf@lfdr.de>; Thu,  1 May 2025 22:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17E301BA3177
	for <lists+bpf@lfdr.de>; Thu,  1 May 2025 20:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EAA824677E;
	Thu,  1 May 2025 20:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SocxuC8t"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4011DB13A
	for <bpf@vger.kernel.org>; Thu,  1 May 2025 20:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746129878; cv=none; b=kWUz6uzi7E3yWjDgVgjl5t4CbQes877fBx+RZ/NOu7Ur2sLh08+0QwqkDH5JfNqMbrF9WMknt9QlcTZzRhJqzGiE/uTZWIWv0EglJ1IH4DBBeql2wG+9xfioJgouoc/KjmjIvyG9bwL6vEQV5Nl2aln5HriUuF3K0VB1TRYu86k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746129878; c=relaxed/simple;
	bh=cVXw+4zJ5Xuoq3BhdJoJtUHU2FPL5v1HrrGVn4410B4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ucEJNYCERK4xEI12tTjR623wp1OuAjI6ST6owQs3hHbxyYnsOrMzkfdrROabsAL4By0P9eG+lE/p5/UgkRHFef2oN3YwIxneD5P/8u9whALrRQx62g8Jp2oKLDT67tcmUsCDRwV/LJmER4ZAZqmrNnZjQrhNHHM2RBeojIcZIRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SocxuC8t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67719C4CEE3;
	Thu,  1 May 2025 20:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746129878;
	bh=cVXw+4zJ5Xuoq3BhdJoJtUHU2FPL5v1HrrGVn4410B4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SocxuC8tG8Ma1pM061k3HCjxRdtbv/jgGo0G++FomhXKFyv6hMVMm63wi9+NBQc8I
	 P3/2CP8AcUfpyFS/9cpt+hahQEbCAPES0Giv9FHa0M2CV4U3iQfMF4Q22MLxTerrA/
	 qJzdYXC6mxPduubvl3xkzCtwl9w2hMD2oycPrMCoeJrq0tgdC43quVPU7WFrA6H+Sl
	 M5DEileM4ASvpBj12h8EN7f5gUxRievwM0V+XykBEXu9GNqo2mr+9wKlb7IEyupmPw
	 mQoKXOsTWvmY+shd8cd/ZeYxV2h6R9HGoGTLdTI5ZCIDvr2T3T0XTC9YLH7ejjum+A
	 T3fWdCmm44Eww==
Message-ID: <55e5aab0-6aa7-4b79-908a-5cbfdc7bd7cd@kernel.org>
Date: Thu, 1 May 2025 21:04:34 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] bpftool: Fix regression of "bpftool cgroup tree"
 EINVAL on older kernels
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 YiFei Zhu <zhuyifei@google.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Kenta Tada <tadakentaso@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Ian Rogers <irogers@google.com>,
 Greg Thelen <gthelen@google.com>, Mahesh Bandewar <maheshb@google.com>,
 Minh-Anh Nguyen <minhanhdn@google.com>,
 Sagarika Sharma <sharmasagarika@google.com>,
 XuanYao Zhang <xuanyao@google.com>
References: <20250428211536.1651456-1-zhuyifei@google.com>
 <CAEf4BzZXpWC8nWb4zF37PpDX0Y+Bk9=vw8iL5Ehqcjr-Bw=dNQ@mail.gmail.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <CAEf4BzZXpWC8nWb4zF37PpDX0Y+Bk9=vw8iL5Ehqcjr-Bw=dNQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2025-05-01 10:54 UTC-0700 ~ Andrii Nakryiko <andrii.nakryiko@gmail.com>
> On Mon, Apr 28, 2025 at 2:15 PM YiFei Zhu <zhuyifei@google.com> wrote:
>>
>> If cgroup_has_attached_progs queries an attach type not supported
>> by the running kernel, due to the kernel being older than the bpftool
>> build, it would encounter an -EINVAL from BPF_PROG_QUERY syscall.
>>
>> Prior to commit 98b303c9bf05 ("bpftool: Query only cgroup-related
>> attach types"), this EINVAL would be ignored by the function, allowing
>> the function to only consider supported attach types. The commit
>> changed so that, instead of querying all attach types, only attach
>> types from the array `cgroup_attach_types` is queried. The assumption
>> is that because these are only cgroup attach types, they should all
>> be supported. Unfortunately this assumption may be false when the
>> kernel is older than the bpftool build, where the attach types queried
>> by bpftool is not yet implemented in the kernel. This would result in
>> errors such as:
>>
>>   $ bpftool cgroup tree
>>   CgroupPath
>>   ID       AttachType      AttachFlags     Name
>>   Error: can't query bpf programs attached to /sys/fs/cgroup: Invalid argument
>>
>> This patch restores the logic of ignoring EINVAL from prior to that patch.
>>
>> Fixes: 98b303c9bf05 ("bpftool: Query only cgroup-related attach types")
>> Reported-by: Sagarika Sharma <sharmasagarika@google.com>
>> Reported-by: Minh-Anh Nguyen <minhanhdn@google.com>
>> Signed-off-by: YiFei Zhu <zhuyifei@google.com>
>> ---
>>  tools/bpf/bpftool/cgroup.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/bpf/bpftool/cgroup.c b/tools/bpf/bpftool/cgroup.c
>> index 93b139bfb9880..3f1d6be512151 100644
>> --- a/tools/bpf/bpftool/cgroup.c
>> +++ b/tools/bpf/bpftool/cgroup.c
>> @@ -221,7 +221,7 @@ static int cgroup_has_attached_progs(int cgroup_fd)
>>         for (i = 0; i < ARRAY_SIZE(cgroup_attach_types); i++) {
>>                 int count = count_attached_bpf_progs(cgroup_fd, cgroup_attach_types[i]);
>>
>> -               if (count < 0)
>> +               if (count < 0 && errno != EINVAL)
>>                         return -1;
> 
> let's maybe change count_attached_bpf_progs() to return error directly
> as returned by bpf_prog_query(), instead of translating that to -1 and
> then requiring relying on errno?
> 
> so just
> 
> if (ret)
>     return ret;
> 
> and then just
> 
> if (count < 0 && count != -EINVAL)
>     return /* well whatever, I'd return error probably instead of -1 again */
> 
> Thoughts?

It feels maybe slightly less intuitive to me to compare "count" - rather
than "errno" - with "-EINVAL", but I don't mind really. It does make
sense to check the return code from the function. Looks OK from my side.

Thanks,
Quentin

