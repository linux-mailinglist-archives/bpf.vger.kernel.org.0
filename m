Return-Path: <bpf+bounces-35698-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C7693CCF6
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 05:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34F761F21769
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 03:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C7D22EED;
	Fri, 26 Jul 2024 03:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qAsrsY4E"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D572520DF4
	for <bpf@vger.kernel.org>; Fri, 26 Jul 2024 03:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721964057; cv=none; b=ewuyaOvugyd0J5FokGRoEwy0LcLITkzjimieITRva82Fzj84TRDQEdRQnyHKd8wQXL66ht/m80+eLKwWPNn47ZkgKOsAK7GAguB5tNKlot/hDvbJSk5o6OYkpyTxCYqneI/qClCzpG9WqLEgCBItVclLVi3MOkxdhvJO+CnLAww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721964057; c=relaxed/simple;
	bh=4WepF0HRN3VM9+biLOvaC3eODHGXrKTNHeQ8ZLGLY8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jf23Gx+prFVjntMXgkiV4nhqLCduWwuBG2R59XTEYhsvdFO+XH2fDJWE1QatTRT+3UPQCwRbFg4HVXBYb3Yf0I48+/UxKUjwc5Q2ECStyUN0gdFA8oi2o9G/RuSGTld2PlCVUMjSoPrDJV7Xf6nUw2csdmlsjK05b0PIVgTojhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qAsrsY4E; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <887f510b-161f-401c-8744-2504a4c135c3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721964052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4WepF0HRN3VM9+biLOvaC3eODHGXrKTNHeQ8ZLGLY8Y=;
	b=qAsrsY4EJKj4vQO6KJkLzg5/SsYpaXGYpF6O5gZh3p7y2iURUIuYy6pvVRSxTyAIfpGneG
	dbBBCdfaUMok+DxWpWCF+cSsgT9HNC1Ex+V2R8DqshNtx6WEyU6K9t9I460iBevmhYI6x5
	1/Ikkv3UVpelBJ7vVNdi/IUiytTqJc4=
Date: Thu, 25 Jul 2024 20:20:40 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] bpf: export btf_find_by_name_kind and bpf_base_func_proto
To: Ming Lei <ming.lei@redhat.com>, Kui-Feng Lee <sinquersw@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
 song@kernel.org, andrii@kernel.org, drosen@google.com, kuifeng@meta.com,
 thinker.li@gmail.com, Benjamin Tissoires <bentiss@kernel.org>,
 Jiri Kosina <jikos@kernel.org>
References: <20240724031930.2606568-1-ming.lei@redhat.com>
 <5be6678d-d310-4961-a57c-45b311879017@gmail.com> <ZqDFzmDfHN1igZVp@fedora>
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <ZqDFzmDfHN1igZVp@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 7/24/24 2:13 AM, Ming Lei wrote:
> On Tue, Jul 23, 2024 at 09:43:12PM -0700, Kui-Feng Lee wrote:
>>
>> On 7/23/24 20:19, Ming Lei wrote:
>>> Export btf_find_by_name_kind and bpf_base_func_proto, so that kernel
>>> module can use them.
>>>
>>> Almost all existed struct_ops users(hid, sched_ext, ...) need the two APIs.
>>>
>>> Without this change, hid-bpf can't be built as module.
>> Could you give me more context?
>> Give me a link of an example code or something?
>> Or explain the use case?
> The merged patchset "Registrating struct_ops types from modules" is
> trying to allow module to register struct_ops, which often needs
> bpf_base_func_proto()(for allowing generic helpers available in
> prog) and btf_find_by_name_kind() (for implementing .btf_struct_access).
>
> One example is hid-bpf, which is a driver and supposed to build as module,
> but it can't be done because the two APIs aren't exported.

Could you give more specific examples about where these two APIs are
used in hid-bpf?

>
> I am working on ublk bpf support, which needs bpf_base_func_proto() at
> least, and might require btf_find_by_name_kind() in future.
>
>
> Thanks,
> Ming
>
>

