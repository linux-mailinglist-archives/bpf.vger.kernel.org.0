Return-Path: <bpf+bounces-63187-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CD1B03EFB
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 14:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1661E3AF29B
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 12:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4A02451C3;
	Mon, 14 Jul 2025 12:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WRyZBQZ2"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350AB139579
	for <bpf@vger.kernel.org>; Mon, 14 Jul 2025 12:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752497329; cv=none; b=TP+iAaP/Vcs1DN1GHA6GY1yuYjNwUrO+ojSdYW7/m9G72/BHWux95KYNkRml7xkbBCyfVxTPddafcgt9Tdzm837nx+dWCvlsSA6p7jIyeZChVnUMavd88Dh24nU6ab8dlwn7ZzCqqmGM3pVwgLDi6FiS5LIG2iCkssaJQCXV5V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752497329; c=relaxed/simple;
	bh=SvZPMfI0+8ffXokCKaw7oWkuPFj84Zqhm/RTy/pDIUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hgdJSDrzRsTznsCa+NbM1Rnd+pBthSy4n8hOc/x3Z0MIpVTbDoiH+Pgjk7GUjgqNGlud+ApDap31devUXLPiMRGi7857nxJ61vBxQNdRM7uqP0zBxNG5gC7hxZxeLT/Dhx5LkVrptyzxwPxaceAtK4Ai2iLopYy5P01eRSyuVhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WRyZBQZ2; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2174c0a8-b7e7-4a57-ae63-d686eb3d9089@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752497324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hfCzrRxQoGQu9m33iotNxfuZbBxqTk4/wF1PgGUAGxo=;
	b=WRyZBQZ28MxyF+XOiJBBI7N6+IzkgzxSXhThvCQt1QiC2VPay2ckX5GF2WQLM+6/RXQepR
	6lq442LHktiyc4v5C1WZeJ2xj9t6DvY8i8A4Biq2WLsq2UPFz2ITGraWYEkIwEpw8mtCwX
	mDrQeqXjiJ20ZBUvE88H6sns241Fc/Y=
Date: Mon, 14 Jul 2025 20:48:32 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next v2 2/3] bpf, libbpf: Support BPF_F_CPU for
 percpu_array map
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net
References: <20250707160404.64933-1-leon.hwang@linux.dev>
 <20250707160404.64933-3-leon.hwang@linux.dev>
 <CAEf4BzYa6_EHLkf7F+e9B18wc5oK7KizA7x5CEQ3jT7Lx4V3Cg@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAEf4BzYa6_EHLkf7F+e9B18wc5oK7KizA7x5CEQ3jT7Lx4V3Cg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/7/12 02:10, Andrii Nakryiko wrote:
> On Mon, Jul 7, 2025 at 9:04 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>> This patch adds libbpf support for the BPF_F_CPU flag in percpu_array maps,
>> introducing the following APIs:
>>
>> 1. bpf_map_update_elem_opts(): update with struct bpf_map_update_elem_opts
>> 2. bpf_map_lookup_elem_opts(): lookup with struct bpf_map_lookup_elem_opts
>> 3. bpf_map__update_elem_opts(): high-level wrapper with input validation
>> 4. bpf_map__lookup_elem_opts(): high-level wrapper with input validation
>>
>> Behavior:
>>
>> * If opts->cpu == (u32)~0, the update is applied to all CPUs.
>> * Otherwise, it applies only to the specified CPU.
>> * Lookup APIs retrieve values from the target CPU when BPF_F_CPU is used.
>>
>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
>> ---
>>  tools/lib/bpf/bpf.c           | 23 ++++++++++++++
>>  tools/lib/bpf/bpf.h           | 36 +++++++++++++++++++++-
>>  tools/lib/bpf/libbpf.c        | 56 +++++++++++++++++++++++++++++++----
>>  tools/lib/bpf/libbpf.h        | 53 ++++++++++++++++++++++++++++-----
>>  tools/lib/bpf/libbpf.map      |  4 +++
>>  tools/lib/bpf/libbpf_common.h | 14 +++++++++
>>  6 files changed, 172 insertions(+), 14 deletions(-)
>>
> 
> LGTM, just see the note about libpbf.map file, thanks.
> 
>> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
>> index 1bbf77326420..d21288991d1c 100644
>> --- a/tools/lib/bpf/libbpf.map
>> +++ b/tools/lib/bpf/libbpf.map
>> @@ -436,6 +436,10 @@ LIBBPF_1.6.0 {
>>                 bpf_linker__add_buf;
>>                 bpf_linker__add_fd;
>>                 bpf_linker__new_fd;
>> +               bpf_map__lookup_elem_opts;
>> +               bpf_map__update_elem_opts;
>> +               bpf_map_lookup_elem_opts;
>> +               bpf_map_update_elem_opts;
> 
> I'm planning to cut libbpf 1.6 release early next week, so for the
> next revision please add it into 1.7 section
> 

No problem.

Thanks,
Leon

[...]

