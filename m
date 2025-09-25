Return-Path: <bpf+bounces-69747-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B82BA091E
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 18:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 20DE44E38DB
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 16:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B11303CBD;
	Thu, 25 Sep 2025 16:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="f886UFyd"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300393596B
	for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 16:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758817199; cv=none; b=MlEh98Vam/UM8VCW3dIQo+aEJ2kTFaQ8za/88tsJBkTsPI0DHMAiyxK1iGxTrKpK9aza1CdlvXRijGBsr4aYcsz/lk496MmM4MwWYRg7KxP63Uwg4hxHSqUlsupuyOnpVn1ZbJpaPlp9zDb2WV7n0z7Nt60xXJpSGLSZd4YkU9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758817199; c=relaxed/simple;
	bh=MYtK8vJj5/2Cw+bnmxLwl+w3ncDzgbwjrpm87YACW/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=piNJPPaONTf2MvKt+YIcQ5G+IALH6+BP7aSkdyISw0DmKyxperPaUGCrZO7m9/K6dr5AHQ0Z+641W/QzPgnGBEEAFqlvLwTu89FPPTZFQqLhrc2pzq81xp7YjRMW4smAsj4i0n2cRuYuEwoOr+uDn4Fxu8CrdNcJPn8BsyN5YjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=f886UFyd; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a486f7ec-698b-4089-ba5c-30172d898db1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758817185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B/fcKec7nCfCYMoChwjrym0cIPBZQwDJ0nUj5VjWfZc=;
	b=f886UFydl6m2Efq2B3isrmet6ovEBDsuvg5eozy4ohs5Vq001oUW1WMqaLE2FrjTdSuJlQ
	hFGO1l1bXrViusjubaZZmfyVhgbDBunL8zsf3zjCwHmGh+Tx+Xj+s8C/40tzs8utDpqI8s
	jLU9tiL59LySn1hw1wbuniNEW8drXrI=
Date: Thu, 25 Sep 2025 09:19:40 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1 3/6] selftests/bpf: update bpf_wq_set_callback
 macro
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, dwarves <dwarves@vger.kernel.org>,
 Alan Maguire <alan.maguire@oracle.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Eduard <eddyz87@gmail.com>,
 Tejun Heo <tj@kernel.org>, Kernel Team <kernel-team@meta.com>
References: <20250924211716.1287715-1-ihor.solodrai@linux.dev>
 <20250924211716.1287715-4-ihor.solodrai@linux.dev>
 <CAADnVQLG1=xr9OWKZna0hjfswZ+pZ8RM3fAtsVd+aYW7xaFFcQ@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <CAADnVQLG1=xr9OWKZna0hjfswZ+pZ8RM3fAtsVd+aYW7xaFFcQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 9/25/25 2:53 AM, Alexei Starovoitov wrote:
> On Wed, Sep 24, 2025 at 10:17 PM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>>
>> Subsequent patch introduces bpf_wq_set_callback kfunc with an
>> implicit bpf_prog_aux argument.
>>
>> To ensure backward compatibility add a weak declaration and make
>> bpf_wq_set_callback macro to check for the new kfunc first.
>>
>> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
>> ---
>>  tools/testing/selftests/bpf/bpf_experimental.h | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
>> index d89eda3fd8a3..341408d017ea 100644
>> --- a/tools/testing/selftests/bpf/bpf_experimental.h
>> +++ b/tools/testing/selftests/bpf/bpf_experimental.h
>> @@ -583,8 +583,13 @@ extern int bpf_wq_start(struct bpf_wq *wq, unsigned int flags) __weak __ksym;
>>  extern int bpf_wq_set_callback_impl(struct bpf_wq *wq,
>>                 int (callback_fn)(void *map, int *key, void *value),
>>                 unsigned int flags__k, void *aux__ign) __ksym;
>> +extern int bpf_wq_set_callback(struct bpf_wq *wq,
>> +               int (callback_fn)(void *map, int *key, void *value),
>> +               unsigned int flags) __weak __ksym;
>>  #define bpf_wq_set_callback(timer, cb, flags) \
>> -       bpf_wq_set_callback_impl(timer, cb, flags, NULL)
>> +       (bpf_wq_set_callback ? \
>> +               bpf_wq_set_callback(timer, cb, flags) : \
>> +               bpf_wq_set_callback_impl(timer, cb, flags, NULL))
> 
> There is also drivers/hid/bpf/progs/hid_bpf_helpers.h
> Pls double check that hid-bpf still compiles and works.

Yes, I noticed the usage.

I plan to send separate patches to hid when this series gets closer to
landing.

