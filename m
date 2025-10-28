Return-Path: <bpf+bounces-72551-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8C0C1542C
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 15:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98CB13BA5FE
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 14:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FADA2472BA;
	Tue, 28 Oct 2025 14:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GQKaAQq/"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02AE238D54
	for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 14:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761662934; cv=none; b=uPL5vcVesV+q0fEYwqhskPa/xFa+OHqhD+3t6vEqvawtBB1MjyWBfDV2hFd9dy+yKxe/m/ICIDC4DNKajo1tmwIRWEQlcJozubQKzAdqIoQX0SjSJJGafO+NtcA50d8cpv/XKy+9sNXlZRRNLftzCuBxklTxM4AEPy1dahlBadM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761662934; c=relaxed/simple;
	bh=nsp/vYBKPAKXSXwyzefzj3kkAqAeGqOO5aOAfMQ1t1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lVWJdunS7EL7d0F6tr5Q8ifxAQZifwrep/mkXhlX1YzjarMB9Iwit31R2GpI/AAo9zR85hVroIegNd73ZwugP12+Y1wZX7dkeXz3R5gkOpTsfvnDUiK4srIPXXlm6JrYL/2UVmDCaZ22mXfLER2PXMWt5A1ad6lridrUy+Pcx0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GQKaAQq/; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <971495da-bc0e-46d4-bda4-5e9b8310ca3e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761662930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KO8xNdDiC0GfQKPOVB85ZS7KFE86udwGgsf60vNTK3g=;
	b=GQKaAQq/twkOLdGTujtKKebi9ryX/7K8MOLDeRG7WGWYcBwDj4BxC5Evs2/h9PHfViwS19
	8XHqPtRsvDDGpiX6s7bCti+YucePdyFRYzd5RnLKGRMf+gMvpos+hEyGh4TS9vj2trJgSY
	1DElGaNSIt2pkbOza2k3VLgPK3prR+g=
Date: Tue, 28 Oct 2025 22:48:39 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v3 3/4] bpf: Free special fields when update local
 storage maps
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 memxor@gmail.com, linux-kernel@vger.kernel.org, kernel-patches-bot@fb.com
References: <20251026154000.34151-1-leon.hwang@linux.dev>
 <20251026154000.34151-4-leon.hwang@linux.dev>
 <CAMB2axPhcYctJYz0bH032-Kc1h2LcJL74O5iS5g=8Qp74GPK_g@mail.gmail.com>
 <377791b5-2294-4ced-a0d3-918c7e078b2b@linux.dev>
 <CAMB2axPx2RajLzhoOsnffhrOxkw7Zy=D=vHam_Y_5wKS0cqf0g@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAMB2axPx2RajLzhoOsnffhrOxkw7Zy=D=vHam_Y_5wKS0cqf0g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/10/28 01:04, Amery Hung wrote:
> On Mon, Oct 27, 2025 at 9:15 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>> Hi Amery,
>>
>> On 2025/10/27 23:44, Amery Hung wrote:
>>> On Sun, Oct 26, 2025 at 8:41 AM Leon Hwang <leon.hwang@linux.dev> wrote:

[...]

>>>>                 selem = SELEM(old_sdata);
>>>>                 goto unlock;
>>>>         }
>>>> @@ -654,6 +656,7 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
>>>>
>>>>         /* Third, remove old selem, SELEM(old_sdata) */
>>>>         if (old_sdata) {
>>>> +               bpf_obj_free_fields(smap->map.record, old_sdata->data);
>>>
>>> Is this really needed? bpf_selem_free_list() later should free special
>>> fields in this selem.
>>>
>>
>> Yes, it’s needed. The new selftest confirms that the special fields are
>> not freed when updating a local storage map.
>>
> 
> Hmmm. I don't think so.
> 
>> Also, bpf_selem_unlink_storage_nolock() doesn’t invoke
>> bpf_selem_free_list(), unlike bpf_selem_unlink_storage(). So we need to
>> call bpf_obj_free_fields() here explicitly to free those fields.
>>
> 
> bpf_selem_unlink_storage_nolock() unlinks the old selem and adds it to
> old_selem_free_list. Later, bpf_selem_free_list() will call
> bpf_selem_free() to free selem in bpf_selem_free_list, which should
> also free special fields in the selem.
> 
> The selftests may have checked the refcount before an task trace RCU
> gp and thought it is a leak. I added a 300ms delay before the checking
> program runs and the test did not detect any leak even without this
> specific bpf_obj_free_fields().

Yeah, you're right. Thanks for the clear explanation.

I also verified it by adding a 300ms delay.

So this bpf_obj_free_fields() call isn't needed — I'll drop it in the
next revision.

Thanks,
Leon


