Return-Path: <bpf+bounces-69445-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07DC4B96AA4
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 17:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C49782E1AC7
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 15:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF07E265CB2;
	Tue, 23 Sep 2025 15:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aZmzvq78"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA4FF9C1
	for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 15:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758642774; cv=none; b=V2Uu6ctWzq65QwTV2/W/8IUPhOD8EwOdV1QWxMqsj/ZwCb6dT9lCxDXXQLl2GPVZ8itT9sRll38sZPXDp5135aSCgdyV5GR4ZL4Xd+hY+jcoCbKsazYZGpyWYLAsNIvIHWZJ+pNOxHZxYLnhnWKNaz7ZN8c5lQPg3dsOIbEZWBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758642774; c=relaxed/simple;
	bh=PnpRvo09XTjbG2aAavbxTie+QSPI947MmMHhOImIDNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SSbYsanZrvckDus4LTAdusXOCJdagBKFY4NyTJ3rqr+t9IMEkGcH74I2sbjRrVlOmHg0zMyQ2CtQYxqpVNKKr3xK6cJL1oZe7FY3vRIWci0J2xXbxaiV/R4M8tiScokeOeiJoKfoc1bHwa8uT6npBLZn1To1n8PlHQnqt0Cayf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aZmzvq78; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f1a52806-9f01-4ee2-a45e-b618b803eabd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758642769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L5q1uku/Oh2asAwKNHxn7ONSxaJvndYdtaJFhqtsfjY=;
	b=aZmzvq78MAfqgatem/bWdtQFYlBVVbvHcPuEkPoK7dWP3l+M/cIIV8CX1RcCnI7V5Iqhpi
	oW4bu4G2S7SWXis13LsJNZxdtqFk9sKMIsP0gsXgiibFvN/SD7/r75nfZiIw8m2MQpgbbl
	8HLMYSEHhmqCKNzXLxphL2hOeqvmx4w=
Date: Tue, 23 Sep 2025 23:52:43 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next v2 4/6] bpf: Add common attr support for
 map_create
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Menglong Dong <menglong8.dong@gmail.com>
References: <20250911163328.93490-1-leon.hwang@linux.dev>
 <20250911163328.93490-5-leon.hwang@linux.dev>
 <CAEf4BzbX_j5guUYuNNgR4dANR11tzLriDGOCOfxS9zRFmQdi7g@mail.gmail.com>
 <CAADnVQLHk0iMweeFQZJONbjDLBfSXnJkT0-KFNPukqzEHbuxXw@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAADnVQLHk0iMweeFQZJONbjDLBfSXnJkT0-KFNPukqzEHbuxXw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/9/18 05:49, Alexei Starovoitov wrote:
> On Wed, Sep 17, 2025 at 2:39 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
>>
>> On Thu, Sep 11, 2025 at 9:33 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>>

[...]

>>>
>>> +       if (common_attrs->log_buf) {
>>> +               log = kvzalloc(sizeof(*log), GFP_KERNEL);
>>> +               if (!log)
>>> +                       return -ENOMEM;
>>> +               err = bpf_vlog_init(log, BPF_LOG_FIXED, u64_to_user_ptr(common_attrs->log_buf),
>>> +                                   common_attrs->log_size, NULL);
>>> +               if (err) {
>>> +                       kvfree(log);
>>> +                       return err;
>>> +               }
>>> +       }
>>
>> what if we keep bpf_verifier_log on stack? It's 1KB, should be still
>> fine to be on kernel stack, no?
>
> 1k is a lot. I'm pretty nervous about stack usage. kmalloc is cheap.
> Let's use it. I'd drop 'v' part. There is no way it will fallback
> to valloc() even if we double BPF_VERIFIER_TMP_LOG_SIZE in the future.

I'll drop 'v' part in the next revision.

Thanks,
Leon

