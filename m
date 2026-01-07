Return-Path: <bpf+bounces-78157-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2047DCFFD0C
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 20:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 365C33314F41
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 19:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB5B3328E0;
	Wed,  7 Jan 2026 19:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cuM29+Qo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399B232F741
	for <bpf@vger.kernel.org>; Wed,  7 Jan 2026 19:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767812743; cv=none; b=HGzguIRuxLWa1KOirPvXpZWNJtD17I6xRIuCddMZnNpYgLt6FjhbfJ7ATLcTIMNOw0IPd7kvoXuyMjkzre3ojUu2r8Clkcg2fKculyfwoCLxAg92havQtk7gNI9bj9Bxb7JG91SpSKZOpgOxIBOUNKdCEcsdI6/yJ5oCFErGjuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767812743; c=relaxed/simple;
	bh=Z9K1U5qcHc6IKvb1kBZrpQlxEokyPVVSVMGXJ5dObn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j4SwPw2G2pulzTwl0b4bb82OoM61AUTCICUl+lWqSSoPvOW5yCVlWnnlxLgrFtlQ7AF7PbN+IehCvxENFD8qaNZqi2TiH4nQ3tGW01ceQ98cFb88VQcetdth22Lgg+gM458pT15x7F4ccWy5veIrarL8cvxrhDa+UIwJjhiJem0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cuM29+Qo; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47aa03d3326so20839705e9.3
        for <bpf@vger.kernel.org>; Wed, 07 Jan 2026 11:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767812740; x=1768417540; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yV2GAzN/rOYaFDderfCFwznQg734j5qWy6h3Uqhklv4=;
        b=cuM29+QoLclZBiRWCeYNsiYvVq9Bll4Z+1x26darFHLrw7CBMV2ehcZ5JjtrqqUqLR
         Yzxu05HFwCEp+L/yJYYYqdwFBL6lK2kyJQX/PjM5rwqyZOsh+Ys2uzfd9SWULDnb/zx1
         sGFw+aMyA+Vahtreza9W95tiCc3yKSjtDvn0NvbXX9H3Zr/74la5XXP3iikp5TMFRQAx
         CymTuwwUqdDxFdCwJhm7OTjhMU4wxEApKvg4824jDGQ8YOCnkNdMiHK6NH7MVS6HB+ND
         stLEMwTEv/+14K69ipJiG2inKhGeI0V1ypcHIyt1oiPuX4nY3cP7jfcD/EwDiiE6UL6h
         oQcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767812740; x=1768417540;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yV2GAzN/rOYaFDderfCFwznQg734j5qWy6h3Uqhklv4=;
        b=u5pKCTv/kYt4NSfQGjTgFMJyqXVTxcshQCr5gDQ4gModbapNcSzvQKZ2t4mHnIlk5Z
         Tj3cWOSxRBSQ3yRyAye80R+xLu7TS17fUAEJpMR1wHL5F/7XF86PzWoz2RHfPx+ThkYQ
         /STzpShDZpVyUmHwYfZ/nXuMxyT8LAhtcma/vWPmwyOvloaO2MyKkbaYJcS9Tmid7XS0
         2NaFEOkG3do74jryKqOZgdj2fwsuB6n3V6g8WVaNNMaMGXx4SdauE4B/aEG6aPwdvgn8
         j7lwv8Uiwod+B34JLGF1hT94NXaWyapJzmL5b/BcIe0Lvq8TfUWXo0fvOFSEn5vGThBI
         WTag==
X-Gm-Message-State: AOJu0YyJQKdZtwA+nGmZkfuPPtwm38XaefaiBGnD2CPgtW0NQF8U3x/r
	veX2bgFaDQ+4M8ysu7u/4NDBosrtqwq3aSm368vFY6A1lvNFkrJU8PHL
X-Gm-Gg: AY/fxX61FKHEEf24IZN8mPSbRMRmYS395ONbXjLzjR5FwA3GnFrm0NVPyun7ERnrj5D
	1AXY0mj7DnmNNBQo+Zuje+kHdvK9VAmcYj2vhgC4sZ/re2B1IHXKqKC2wQmqsCy47N2t6Tnmg7W
	sphBp0TVFnw9g62hdPWmSu09r2vr5r2TRSGvbFeIPnJWJguOuH0O73CmWb6DenisFT214ocWTAY
	S/7KzJg/qqOow6q15mNOOma+VW0UgGr8GXegNAL+DmpdOdUW7BuhqdQaCtPoffn5bi54IBdjISe
	LnB/M3WRjhGXugRMqYKDSo7RyjzV86IM3e2HCf6vPJJ8ds+ddGUTf71syzHd69ym4N5bjh1z4iG
	fU71KW9LlEiFySkkaiWC55Evd6w3KeOoaWyW+A92pexrzXTZ4J2AU2VzLEFM9K2eXIBt9X1RvJ1
	6HE14E9OGTgj3TYvgBhGwh87JFXA+DERkWtcun6jdgg4iLtoY=
X-Google-Smtp-Source: AGHT+IHyy9s+ZUVKJ+rFCDUfHXHwkqBs2cte5XZUdotZJAZmzxhrf4Iw8bX8j9IYH/rJFAJ+PLhWTg==
X-Received: by 2002:a05:600c:3152:b0:45d:dc85:c009 with SMTP id 5b1f17b1804b1-47d84b1a04amr47874555e9.10.1767812740116;
        Wed, 07 Jan 2026 11:05:40 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1126:4:5e8:9143:852f:9288? ([2620:10d:c092:500::5:d4be])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5df8besm11338361f8f.26.2026.01.07.11.05.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jan 2026 11:05:39 -0800 (PST)
Message-ID: <e4eee776-e9c7-4186-b239-733f81a9ae4a@gmail.com>
Date: Wed, 7 Jan 2026 19:05:37 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 04/10] bpf: Add lock-free cell for NMI-safe async
 operations
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 eddyz87@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
References: <20260107-timer_nolock-v3-0-740d3ec3e5f9@meta.com>
 <20260107-timer_nolock-v3-4-740d3ec3e5f9@meta.com>
 <CAP01T77h5caT6EprhREYMNmjTkbBZ9-OT7HkxdnJUNNME2evQQ@mail.gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <CAP01T77h5caT6EprhREYMNmjTkbBZ9-OT7HkxdnJUNNME2evQQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/7/26 18:30, Kumar Kartikeya Dwivedi wrote:
> On Wed, 7 Jan 2026 at 18:49, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com> wrote:
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> Introduce mpmc_cell, a lock-free cell primitive designed to support
>> concurrent writes to struct in NMI context (only one writer advances),
>> allowing readers to consume consistent snapshot.
>>
>> Implementation details:
>>   Double buffering allows writers run concurrently with readers (read
>>   from one cell, write to another)
>>
>>   The implementation uses a sequence-number-based protocol to enable
>>   exclusive writes.
>>    * Bit 0 of seq indicates an active writer
>>    * Bits 1+ form a generation counter
>>    * (seq & 2) >> 1 selects the read cell, write cell is opposite
>>    * Writers atomically set bit 0, write to the inactive cell, then
>>      increment seq to publish
>>    * Readers snapshot seq, read from the active cell, then validate
>>      that seq hasn't changed
>>
>> mpmc_cell expects users to pre-allocate double buffers.
>>
>> Key properties:
>>   * Writers never block (fail if lost the race to another writer)
>>   * Readers never block writers (double buffering), but may require
>>   retries if write updates the snapshot concurrently.
>>
>> This will be used by BPF timer and workqueue helpers to defer NMI-unsafe
>> operations (like hrtimer_start()) to irq_work effectively allowing BPF
>> programs to initiate timers and workqueues from NMI context.
>>
>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>> ---
> We already have a dual-versioned concurrency control primitive in the
> kernel (seqcount_latch_t). I would just use that instead of
> reinventing it here. I don't see much of a difference except writer
> serialization, which can be done on top of it. If it was already
> considered and discarded for some reason, please add that reason to
> the commit message.
yes, multiple concurrent  writers support would is the main difference
between seqcount_latch_t and my implementation. I'll switch to
seqcount_latch_t and external synchronization for writers.
>>   [...]
>>


