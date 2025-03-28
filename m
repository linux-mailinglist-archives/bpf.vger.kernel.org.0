Return-Path: <bpf+bounces-54860-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F4128A74E84
	for <lists+bpf@lfdr.de>; Fri, 28 Mar 2025 17:25:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 518041796B0
	for <lists+bpf@lfdr.de>; Fri, 28 Mar 2025 16:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488971D934D;
	Fri, 28 Mar 2025 16:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ii5DYMBc"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D80A935;
	Fri, 28 Mar 2025 16:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743179150; cv=none; b=dmpw3jqM4aOkSvrpZ+WmjE1MUA+3qoz2wLKpt/2mHeh3xDtXFfrMq8djH5+Y9oVbs7lxzNasls1pC6KNrKUS5xfgZg0wcoDzvK6/eEHr2ar7YCiJjM0NV4uh5TrBkTkyH3xYj3QKqlLNHHzNIeZMVB4U2f1p/wg3P9nE59dSjv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743179150; c=relaxed/simple;
	bh=fnoEx1aCjz57EbYnq6OMx+FSQiWBTUdAwQ3n1+ZaniA=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=Omv0z+57CHmGl2T/D8EBXAnYziUuTvyQcPFFBh85cKnsj++2weA9/1kUrrqL1Qu5UxZlvB1Vai3dxvob6SyxAVXctP5U/SWAXsSD4PO9ky2CwzKU209Xt0A5CxQhJqU3W4gM7o30gtQqfvGZahLqUvCHnC0qsyoSsVC9xAqQuwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ii5DYMBc; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743179145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JlCOnsYtYcn+vBdk4NFDULZGaWj4NIuETfwcq+R4QjQ=;
	b=ii5DYMBcTMI8XD7Z6vrYN7pRKfDbIKEUamxw51r2Z+bs/L5DSQSo32OBf69aeuZPNM2r0N
	ky2RC/OYd8SRQHMMrKMlc0Bom7tj0HjRjdCE0tsDNM+2vmTSu/ktJAEKe+vLB4ue8WSvmX
	qTzBedJowlnzm0Qk6QtXS5cVADz/5Pk=
Date: Fri, 28 Mar 2025 16:25:44 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Ihor Solodrai" <ihor.solodrai@linux.dev>
Message-ID: <933e199997949c0ac8a71551830f1e6c98d8bff0@linux.dev>
TLS-Required: No
Subject: Re: parallel pahole hangs while building modules from
 nvidia-open-kernel-dkms
To: "Domenico Andreoli" <domenico.andreoli@linux.com>
Cc: dwarves@vger.kernel.org, alan.maguire@oracle.com, acme@kernel.org,
 andrii@kernel.org, bpf@vger.kernel.org
In-Reply-To: <Z-ZmcwXyMtAQjaoE@localhost>
References: <Z-JzFrXaopQCYd6h@localhost>
 <83315e0bce204f7745448fff550574d44b09b4c1@linux.dev>
 <Z-ZmcwXyMtAQjaoE@localhost>
X-Migadu-Flow: FLOW_OUT

On 3/28/25 2:05 AM, Domenico Andreoli wrote:
> On Wed, Mar 26, 2025 at 08:48:51PM +0000, Ihor Solodrai wrote:
>> On 3/25/25 2:10 AM, Domenico Andreoli wrote:
>>> Hi,
>>>
>>>   This a forward of Debian bug report [0] where you can find more
>>> details. At [1] and [2] you can get the kernel and module to reproduc=
e.
>>> I could reproduce on both amd64 and arm64 using pahole 1.29.
>>>
>>> This is marked as serious severity because it makes the autobuilder h=
ang
>>> as well [3].
>>>
>>> Could you please help?
>>>
>>> Regards,
>>> Domenico
>>
>> Hi Domenico, thanks for the bug report.
>
> Hi Ihor,
>
>>
>> I debugged the hanging, and it appears that "abort" handling in case
>> of a BTF encoding error was overlooked in recent changes to speedup
>> parallel encoding.
>>
>> Could you please try the diff below, and check if it resolves the
>> hanging?
>>
>
> Yes, I tried it and the hanging is gone.
>
> Now both parallel and sequential invocations fail with this error:
>
>   dwarf_expr: unhandled 0x12 DW_OP_ operation
>   Unsupported DW_TAG_reference_type(0x10): type: 0x28172
>   Error while encoding BTF.
>   dwarf_expr: unhandled 0x12 DW_OP_ operation
>   dwarf_expr: unhandled 0x12 DW_OP_ operation
>   dwarf_expr: unhandled 0x12 DW_OP_ operation
>   libbpf: failed to find '.BTF' ELF section in nvidia-modeset.ko
>   pahole: nvidia-modeset.ko: Invalid argument
>
> I guess this is another story that was simply covered by the previous b=
ug.

The "invalid argument" message and non-0 exit code are now appearing
because the encoding error is correctly propagated with the patch I
sent you.

The root cause of the problem you're seeing is unhandled DWARF
input. The resulting BTF is wrong in all cases: with or w/o the patch,
parallel or sequential.

The important part of the error message is:

    Unsupported DW_TAG_reference_type(0x10): type: 0x28172

This makes BTF encoder abort.

Could you please share the base vmlinux passed to the command that
produces this error? Maybe you could provide instructions on how to
build it?

>
>> diff --git a/dwarf_loader.c b/dwarf_loader.c
>> index 84122d0..e1ba7bc 100644
>> --- a/dwarf_loader.c
>> +++ b/dwarf_loader.c
>> @@ -3459,6 +3459,7 @@ static struct {
>>  	 */
>>  	uint32_t next_cu_id;
>>  	struct list_head jobs;
>> +	bool abort;
>>  } cus_processing_queue;
>>=20=20
>>=20 enum job_type {
>> @@ -3479,6 +3480,7 @@ static void cus_queue__init(void)
>>  	pthread_cond_init(&cus_processing_queue.job_added, NULL);
>>  	INIT_LIST_HEAD(&cus_processing_queue.jobs);
>>  	cus_processing_queue.next_cu_id =3D 0;
>> +	cus_processing_queue.abort =3D false;
>>  }
>>=20=20
>>=20 static void cus_queue__destroy(void)
>> @@ -3535,8 +3537,9 @@ static struct cu_processing_job *cus_queue__enqd=
eq_job(struct cu_processing_job
>>  		pthread_cond_signal(&cus_processing_queue.job_added);
>>  	}
>>  	for (;;) {
>> +		bool abort =3D __atomic_load_n(&cus_processing_queue.abort, __ATOMI=
C_SEQ_CST);
>>  		job =3D cus_queue__try_dequeue();
>> -		if (job)
>> +		if (job || abort)
>>  			break;
>>  		/* No jobs or only steals out of order */
>>  		pthread_cond_wait(&cus_processing_queue.job_added, &cus_processing_=
queue.mutex);
>> @@ -3653,6 +3656,9 @@ static void *dwarf_loader__worker_thread(void *a=
rg)
>>=20=20
>>=20 	while (!stop) {
>>  		job =3D cus_queue__enqdeq_job(job);
>> +		if (!job)
>> +			goto out_abort;
>> +
>>  		switch (job->type) {
>>=20=20
>>=20 		case JOB_DECODE:
>> @@ -3688,6 +3694,8 @@ static void *dwarf_loader__worker_thread(void *a=
rg)
>>=20=20
>>=20 	return (void *)DWARF_CB_OK;
>>  out_abort:
>> +	__atomic_store_n(&cus_processing_queue.abort, true, __ATOMIC_SEQ_CST=
);
>> +	pthread_cond_signal(&cus_processing_queue.job_added);
>>  	return (void *)DWARF_CB_ABORT;
>>  }
>>=20=20
>>=20@@ -4028,7 +4036,7 @@ static int cus__process_file(struct cus *cus, =
struct conf_load *conf, int fd,
>>=20=20
>>=20 	/* Process the one or more modules gleaned from this file. */
>>  	int err =3D dwfl_getmodules(dwfl, cus__process_dwflmod, &parms, 0);
>> -	if (err < 0)
>> +	if (err)
>>  		return -1;
>>=20=20
>>=20 	// We can't call dwfl_end(dwfl) here, as we keep pointers to strin=
gs
>>
>
> Is this patch already final or do you prefer I'd wait for review and ma=
rge first?

I'd prefer the patch to get reviewed and merged into pahole/next
first. I'll submit it separately.

But as I said, it fixes just the hanging part, not the root cause of
the error.

>
> I would apply it on top of Debian's 1.29 and release a new 1.29-3 packa=
ge.
>
> Thank,
> dom
>

