Return-Path: <bpf+bounces-57730-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F4EAAF213
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 06:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 540B84E1416
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 04:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1146E1D516C;
	Thu,  8 May 2025 04:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LzSC2HjN"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA9178F37
	for <bpf@vger.kernel.org>; Thu,  8 May 2025 04:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746677995; cv=none; b=YU6p3HuHWipVT5wvui0c9ulNVMt25AEk9m+TfDfElDoYGKJVpd9Cmkk7LiPYWNUdgfZQWdt6zEg6D5ulpB0wDhPc37eM1Y5NAP+inJrDtWTxmZhfH6cf1RC1jaxRgmRgCpPLVQYYMziR+k1tnvkrBBzT45IGy3DxslMIzeqV+ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746677995; c=relaxed/simple;
	bh=BUzJZRrkNhWtzNOdhiEDWMtBvuoTKe8Ckp6X0i9sA3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X/+FO+yS10AmzHOg27I1uVz4qRqrSzLBkA73fJbLT87dQ3FMTD+czPv5Q0tGdyOZxFNeVqCsRlJjOeQSHWdD9Xb9NV8jluARN4r4Dem5/IzpZTecyHZ2HExYMQ4xP8X1FPwGgaIKOUFKrNb+5xneypyEF8QtKvdsybJhh2nS2+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LzSC2HjN; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <96dc859c-40b3-4b08-9315-a38a5a446b5c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746677991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qe98IIAdRkQTtugJqL2mavoVqX9H22AZ7XKZZBc07f0=;
	b=LzSC2HjNGPcErllkKWIf6Aa44UokMWHcIV5i7YxSvMo3+vSBSHA3nxuPM3LDZ5Ac+WQ2HL
	gRsqpH7Pi2tXLmZPsemT5TzlMVg1Ekgl508OLInrgaotG9xeLZo/9NoBiUMepRKOHFh45J
	tBcMwKAI3Upa6cT5DWk392rPEN0KbJA=
Date: Wed, 7 May 2025 21:19:44 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next 1/4] cgroup: Add bpf prog revisions to struct
 cgroup_bpf
Content-Language: en-GB
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
References: <20250411011523.1838771-1-yonghong.song@linux.dev>
 <20250411011528.1839359-1-yonghong.song@linux.dev>
 <CAEf4BzYs-qgxGPpZ7R-W7xUOP69bq_DJZ3A1J20DqqzqgvHv1g@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAEf4BzYs-qgxGPpZ7R-W7xUOP69bq_DJZ3A1J20DqqzqgvHv1g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 4/23/25 7:19 AM, Andrii Nakryiko wrote:
> On Thu, Apr 10, 2025 at 6:15 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>> One of key items in mprog API is revision for prog list. The revision
>> number will be increased if the prog list changed, e.g., attach, detach
>> or replace.
>>
>> Add 'revisions' field to struct cgroup_bpf, representing revisions for
>> all cgroup related attachment types. The initial revision value is
>> set to 1, the same as kernel mprog implementations.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   include/linux/bpf-cgroup-defs.h | 1 +
>>   kernel/cgroup/cgroup.c          | 5 ++++-
>>   2 files changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/bpf-cgroup-defs.h b/include/linux/bpf-cgroup-defs.h
>> index 0985221d5478..a3cbbd00731a 100644
>> --- a/include/linux/bpf-cgroup-defs.h
>> +++ b/include/linux/bpf-cgroup-defs.h
>> @@ -62,6 +62,7 @@ struct cgroup_bpf {
>>           * when BPF_F_ALLOW_MULTI the list can have up to BPF_CGROUP_MAX_PROGS
>>           */
>>          struct hlist_head progs[MAX_CGROUP_BPF_ATTACH_TYPE];
>> +       atomic64_t revisions[MAX_CGROUP_BPF_ATTACH_TYPE];
> for cgroups all the attachment and detachment happens under
> cgroup_mutex, so I don't think we need atomic64_t, just plain u64 will
> work

Indeed Make sense.

>
>>          u8 flags[MAX_CGROUP_BPF_ATTACH_TYPE];
>>
>>          /* list of cgroup shared storages */
>> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
>> index ac2db99941ca..dea7d12c8927 100644
>> --- a/kernel/cgroup/cgroup.c
>> +++ b/kernel/cgroup/cgroup.c
>> @@ -2053,7 +2053,7 @@ static int cgroup_reconfigure(struct fs_context *fc)
>>   static void init_cgroup_housekeeping(struct cgroup *cgrp)
>>   {
>>          struct cgroup_subsys *ss;
>> -       int ssid;
>> +       int i, ssid;
>>
>>          INIT_LIST_HEAD(&cgrp->self.sibling);
>>          INIT_LIST_HEAD(&cgrp->self.children);
>> @@ -2071,6 +2071,9 @@ static void init_cgroup_housekeeping(struct cgroup *cgrp)
>>          for_each_subsys(ss, ssid)
>>                  INIT_LIST_HEAD(&cgrp->e_csets[ssid]);
>>
>> +       for (i = 0; i < ARRAY_SIZE(cgrp->bpf.revisions); i++)
>> +               atomic64_set(&cgrp->bpf.revisions[i], 1);
>> +
>>          init_waitqueue_head(&cgrp->offline_waitq);
>>          INIT_WORK(&cgrp->release_agent_work, cgroup1_release_agent);
>>   }
>> --
>> 2.47.1
>>


