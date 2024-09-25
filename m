Return-Path: <bpf+bounces-40318-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E7F9864D4
	for <lists+bpf@lfdr.de>; Wed, 25 Sep 2024 18:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BD94B276CF
	for <lists+bpf@lfdr.de>; Wed, 25 Sep 2024 16:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233F712BEBB;
	Wed, 25 Sep 2024 16:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N6uCIXFT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562AD481CE;
	Wed, 25 Sep 2024 16:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727281607; cv=none; b=PHKF2f4UExHHSnz+vLf97rPra42gyfKhn1pZXe4gYdc4Is7j8xJLE5unITSivIsOtPL/YOtZwgt/LcnXI6E8WKWpkyz+q9l1blCKEHe1b6XooY/R0JWgwuNcYcWNsffckxP/0hblu85C2yDBpCDuWtTONwrMGRqpIK34fd45cMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727281607; c=relaxed/simple;
	bh=/R54fp8hKNPO/2V67vGlkWeekKvDry3xBMaa2KQ2i2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nmh4KALrK19f1RI888q+mRKe2KatLBAJtumjBDHb+wlI53eYdYiyb8iLULh+mjhKls0qUjU9OsFxtV5qt7dMvIYJfqGVQk0OfF/gPNp4O0RT51MRgljTevCBt9Et2kPjg+JLdH9ztg3hw4rOIRIP2W/U4HiYvOnXRzzBDUSGJS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N6uCIXFT; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20792913262so81650105ad.3;
        Wed, 25 Sep 2024 09:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727281606; x=1727886406; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VuGWKm5UENWosvHzMemZt6HnQELzPD/LdCepurLCaBk=;
        b=N6uCIXFT7LaI2Uwcc6fI9jzObgef+VuI5kmwac6LMTR4SW5jqtegxqYJvgVCeQUNsD
         atTBG8sakgIsa4wJSb34dApUW0sz9U0z+1JOfI7ej7g7x7J4bHEEDlSn17/X+x3ZWxzQ
         Ka0F0H9rNQRLttRjpBHDAmz3qhrm4UynsBjTlPz+3198tCCVANhUVYysROsDy90MqwM5
         cevjfqcGzCSA178/cGemR5uMJfrrQIHXMZ8RC9vQyt57M0FEmhJL3aB+MqtXBOEPUMtG
         8224oX1OUwvWvSaYC1hoIlKzEhu1ou1RoGCQNb360i32JG5WeOBLjfZG3xGjZjX+QssO
         22zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727281606; x=1727886406;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VuGWKm5UENWosvHzMemZt6HnQELzPD/LdCepurLCaBk=;
        b=Tk7q7/JTfNph2e+wGdJXmw7TGZsw+Ee+z595ShW+5KRl97S9SsLgcOxfptiQLI1qte
         bHZf2NlSkmYGoQwMirmca9DIQ+SUHtp4n3ZttEj1a51wq4ZDq5CQT+iuNhPY/L6pVYaN
         U4YBrFspmNOpVIGXeyhbnRiHZh5P29mWSGVwxq1rEWku1fJC+thRDLTyX0IoQ0BrVSrZ
         ceMBAlvaChlyzYunbV6+cb8SAXfNpxcZA6tv7aJd+AXfsE4sl/zs1fnHaXG8abru6QRJ
         xa4gIXbRaTjD1YBki7O5R3jWYn2+trVmtI7PUzRMUKJ4mgqc75M2N5tbm/WGp2HBLUT4
         p1qA==
X-Forwarded-Encrypted: i=1; AJvYcCV2DrHTUYHclIUbzZaXV8WlPlH/PE1hsvsue/wsB0FGoV2qNfKNrVudAr/w+yWMw4D0/B2JLCJnErmj7M+n@vger.kernel.org, AJvYcCW6CoAqejcZiJTJicllBF3/fPACyxb9nWhbxDrtYw4oP4NTfXitykrQCGhrDnwbgVsagD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUV+C220pDs2dIS8gRMVwxA+AGgPk8MNDNZ6Npa9lA8Kl2mzZC
	d+gkYR9k6GBy9MCMvIpAq5PJZeDbXDfPpC7BAeDkS/jGRX6bwP3l
X-Google-Smtp-Source: AGHT+IFKJxV65iNSlOxlbZu84lyBy1ZAaOgS6UVZBoSWyxARv3dMtCEKeI72k4gPOE5Ffk6sHC9K/w==
X-Received: by 2002:a17:902:da8e:b0:205:56e8:4a3f with SMTP id d9443c01a7336-20afc654e19mr46462755ad.61.1727281605361;
        Wed, 25 Sep 2024 09:26:45 -0700 (PDT)
Received: from [192.168.50.122] ([117.147.91.209])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20af1720c98sm26386215ad.73.2024.09.25.09.26.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2024 09:26:44 -0700 (PDT)
Message-ID: <8bc57566-2867-49f5-8b66-7c5f32c1a0c8@gmail.com>
Date: Thu, 26 Sep 2024 00:25:25 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpftool: Remove llvm-strip from Makefile
To: Daniel Borkmann <daniel@iogearbox.net>, patchwork-bot+netdevbpf@kernel.org
Cc: qmo@kernel.org, ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240924165202.1379930-1-chen.dylane@gmail.com>
 <172725782851.519668.2924142510144708471.git-patchwork-notify@kernel.org>
 <4f58b093-ca1f-426a-8102-4b00ccaf4973@iogearbox.net>
From: Tao Chen <chen.dylane@gmail.com>
In-Reply-To: <4f58b093-ca1f-426a-8102-4b00ccaf4973@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2024/9/25 18:32, Daniel Borkmann 写道:
> On 9/25/24 11:50 AM, patchwork-bot+netdevbpf@kernel.org wrote:
>> Hello:
>>
>> This patch was applied to bpf/bpf-next.git (master)
>> by Daniel Borkmann <daniel@iogearbox.net>:
>>
>> On Wed, 25 Sep 2024 00:52:02 +0800 you wrote:
>>> As Quentin and Andrri said [0], bpftool gen object strips
>>> out DWARF already, so remove the repeat operation.
>>>
>>> [0] https://github.com/libbpf/bpftool/issues/161
>>>
>>> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
>>> Suggested-by: Quentin Monnet <qmo@kernel.org>
>>> Signed-off-by: Tao Chen <chen.dylane@gmail.com>
>>>
>>> [...]
> I'll toss this shortly from the tree again, this missed that bpftool gen 
> object call
> needs to strip out dwarf.

Hi Daniel, i saw linker_sanity_check_elf will ignore the dwarf sec, 
which means bpftool gen object will strip, is my understanding correct?

static int linker_sanity_check_elf(struct src_obj *obj)
{
	...
	if (is_dwarf_sec_name(sec->sec_name))
		continue;
	...
}
>>> Here is the summary with links:
>>>    - [bpf-next] bpftool: Remove llvm-strip from Makefile
>>>      https://git.kernel.org/bpf/bpf-next/c/25bfc6333e32
>>>
>>> You are awesome, thank you!


-- 
Best Regards
Dylane Chen

