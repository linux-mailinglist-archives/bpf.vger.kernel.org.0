Return-Path: <bpf+bounces-67831-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 368D7B49F17
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 04:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0D133BF39B
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 02:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB6923BD1B;
	Tue,  9 Sep 2025 02:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aRlymM3I"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23931A5B8A
	for <bpf@vger.kernel.org>; Tue,  9 Sep 2025 02:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757384422; cv=none; b=VC6NBWnPk/65Lnv2bhYHr9ZIkK9f5aG3mIdPa91qXYwwBgNUbjnqOgjeldse2ZU/hQZYuqwvg03ZFy9nmYI2slXDBypja2qO50jaB73rS70bQHE3+kEUfbzdoMFC9617a7Fay/deJObcB9j4hXg8XBpk0vNySO5By/85HQQmQG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757384422; c=relaxed/simple;
	bh=PmGwcfIipMYMa6wdJwx8vZQMIgZ2+eS8h/C7a7XuL1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NVNDQpp+07CddQL4iJdWAJh45j9wvQGvawZQ2HJ2ZlJC61RqqmlI7t+nyM2YDeHa3DyW1pUH4nJzOpzGUB1dvmJX+o7IVz9y9f5Vi4IyzBl6hsT1J1Yhiq97t9NKTXbEIhu1pzU7L0iU1IF7ixzERE2g+nYYlivCx9+zTRuwXgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aRlymM3I; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ce0daf63-a8a2-4424-aaad-dba7ea5b7128@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757384413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r2SgfSQcmKGl+Gbp1Ue4mo8LHL/qYK+7Xa+qr8Dr9jM=;
	b=aRlymM3I8og3VvtPA1SUT+lSTzsxAS7dK3RxL3XPoeYfPNBk7Vq7hUha9eMunER+RqAz2d
	40tmPP/EH/YkROyD2Dq5EkpxV/IFMruetrwzdVNnjJAgo/kBae/Z/Hhl86xGfS452KQ/Mr
	cOn9U3paXEWpvvpHdbD+mF7tV4m/smU=
Date: Tue, 9 Sep 2025 10:20:04 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 1/9] bpf: Generalize data copying for percpu
 maps
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jiri Olsa <jolsa@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 Song Liu <song@kernel.org>, Eduard <eddyz87@gmail.com>,
 Daniel Xu <dxu@dxuuu.xyz>, =?UTF-8?Q?Daniel_M=C3=BCller?= <deso@posteo.net>,
 kernel-patches-bot@fb.com
References: <20250908143644.30993-1-leon.hwang@linux.dev>
 <20250908143644.30993-2-leon.hwang@linux.dev>
 <CAADnVQLSYy6FNrgX82GPFypwm-LCqGs31QfzoXC=Yunhov-cyQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAADnVQLSYy6FNrgX82GPFypwm-LCqGs31QfzoXC=Yunhov-cyQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 9/9/25 01:35, Alexei Starovoitov wrote:
> On Mon, Sep 8, 2025 at 7:37 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>

[...]

>> @@ -313,11 +312,7 @@ int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value)
>>         size = array->elem_size;
>>         rcu_read_lock();
>>         pptr = array->pptrs[index & array->index_mask];
>> -       for_each_possible_cpu(cpu) {
>> -               copy_map_value_long(map, value + off, per_cpu_ptr(pptr, cpu));
>> -               check_and_init_map_value(map, value + off);
>> -               off += size;
>> -       }
>> +       bpf_percpu_copy_data(map, pptr, value, size);
> 
> Same issue as before. This is not equivalent.
> Stop this "refactoring".
> 

Got it.

I’ll drop this refactoring and keep the original per-CPU copy logic as
is, and focus only on adding the BPF_F_CPU / BPF_F_ALL_CPUS support.

Thanks,
Leon

