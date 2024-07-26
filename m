Return-Path: <bpf+bounces-35705-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06AFF93CDC5
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 07:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1DCCB222E1
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 05:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1133A1AC;
	Fri, 26 Jul 2024 05:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aSwx3mmJ"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E959CA34
	for <bpf@vger.kernel.org>; Fri, 26 Jul 2024 05:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721972403; cv=none; b=LB6oGzS7IfUvr1IAakQ63csU0lC/VUgGb4+uCcShRGFJJJkU9BUm1AkIC7zmkQTAL2d5pFUuVP8EaTqqwrKILdTyOPYykvXwJeGIfN6rxjHnyxUuhiOLVv37q44RU+cLkYXX4VXKP0dq207YFRmYVrRsW+W/1vAXAQUxfT+9dIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721972403; c=relaxed/simple;
	bh=RaQrVM/CQ3kCj+PouLJPvnsiWV3w6SfUdXYIwMV3Myw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PZE5+UmVPbG4hpkxohRjSABzvz995UMWsBHKxPK0z3W5Q1GFcMC4efFE9X/O1sY2ISdCGnd6DfzOujUXuX42jVr2YIsELXQwf/yrf8ZegbkBOU0uVS6ApfhUkr31e9L38zeLV8IzuWaF34Varevc3k3C438yxlhwMo5QXCwz2pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aSwx3mmJ; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a529d615-1cb5-4d5a-a78e-06e71676fc5f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721972399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rg+u+rcpn6v9R3yOt0ZjmkXd1yF6O30pO4otWFnE4jA=;
	b=aSwx3mmJV6NAcWyfrORuqkIHGgSuJDSKc6IeYG12ijKhU3DjxFvDvNH/cOEGh5jB8FRxTi
	n9LEwgeKkcFEHarSIpZ1wnB23BE/g5XNTuDHxzpfLvsGdikK4qc0Vt1mbYDVEPrNoPiXp5
	CCrlpBfODx+PPRR8oghQVcz9xDANZl8=
Date: Thu, 25 Jul 2024 22:39:51 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] bpf: export btf_find_by_name_kind and bpf_base_func_proto
Content-Language: en-GB
To: Ming Lei <ming.lei@redhat.com>
Cc: Kui-Feng Lee <sinquersw@gmail.com>, bpf@vger.kernel.org, ast@kernel.org,
 martin.lau@linux.dev, song@kernel.org, andrii@kernel.org, drosen@google.com,
 kuifeng@meta.com, thinker.li@gmail.com,
 Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>
References: <20240724031930.2606568-1-ming.lei@redhat.com>
 <5be6678d-d310-4961-a57c-45b311879017@gmail.com> <ZqDFzmDfHN1igZVp@fedora>
 <887f510b-161f-401c-8744-2504a4c135c3@linux.dev>
 <CAFj5m9KMvObO1KP+TdxBdE5psnDKv4RaAUOCjOAXJ0gSpB22Hg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAFj5m9KMvObO1KP+TdxBdE5psnDKv4RaAUOCjOAXJ0gSpB22Hg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 7/25/24 8:45 PM, Ming Lei wrote:
> On Fri, Jul 26, 2024 at 11:21 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>> On 7/24/24 2:13 AM, Ming Lei wrote:
>>> On Tue, Jul 23, 2024 at 09:43:12PM -0700, Kui-Feng Lee wrote:
>>>> On 7/23/24 20:19, Ming Lei wrote:
>>>>> Export btf_find_by_name_kind and bpf_base_func_proto, so that kernel
>>>>> module can use them.
>>>>>
>>>>> Almost all existed struct_ops users(hid, sched_ext, ...) need the two APIs.
>>>>>
>>>>> Without this change, hid-bpf can't be built as module.
>>>> Could you give me more context?
>>>> Give me a link of an example code or something?
>>>> Or explain the use case?
>>> The merged patchset "Registrating struct_ops types from modules" is
>>> trying to allow module to register struct_ops, which often needs
>>> bpf_base_func_proto()(for allowing generic helpers available in
>>> prog) and btf_find_by_name_kind() (for implementing .btf_struct_access).
>>>
>>> One example is hid-bpf, which is a driver and supposed to build as module,
>>> but it can't be done because the two APIs aren't exported.
>> Could you give more specific examples about where these two APIs are
>> used in hid-bpf?
> Sure, hid-bpf struct_ops has been merged to linus tree already.
>
> However, it can't be built as module because the two APIs aren't exported:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/hid/bpf/hid_bpf_struct_ops.c

Okay, From the above hid_bpf_struct_ops.c, I do see bpf_base_func_proto() and
btf_find_by_name_kind() are used.

Your change looks good to me. Please add more details in the commit message and resubmit.
Your subject
    [PATCH] bpf: export btf_find_by_name_kind and bpf_base_func_proto
please change to
    [PATCH bpf-next] bpf: export btf_find_by_name_kind and bpf_base_func_proto

The above 'bpf-next' ensures CI to test your patch.

>
> Thanks,
> Ming
>

