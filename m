Return-Path: <bpf+bounces-59423-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3583CACA800
	for <lists+bpf@lfdr.de>; Mon,  2 Jun 2025 03:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF09B17776E
	for <lists+bpf@lfdr.de>; Mon,  2 Jun 2025 01:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6471B6D01;
	Mon,  2 Jun 2025 00:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HzqDEi0J"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490342940B
	for <bpf@vger.kernel.org>; Mon,  2 Jun 2025 00:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748825297; cv=none; b=g8XMpVMMumJZ2aDjqm9nVFS8OCHwAmu/UwQKIPrneXAtFXb3+0Oy32G5zoPWdJO4PS8s0Vyu3Lb/adocDNZ8BeC65trQT7picj2UNQ1GewJq0VCH5p/0wRZgoM/OpW8AblZL8SxNoweTulhdbOB/VWcqCh40Vy9tc2R7MuA7fwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748825297; c=relaxed/simple;
	bh=Tpu7jcsryNw50tnbGlua4H91KB5ZkFiKpmVA6IaCmnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vhm4f9FPzbBDnQWO7sFXRuVv1qSBGRI7pKst61zTjQSQZZ4tM96AWuw+TtixfqzMVmsDC/ztWBn0GJ9eGLt4xAecypQjpO/j0JEcbcTpi8WQjACtvhwx+aBm9X/o3SGn7JTkYES5qpttCwe/kEfzCkhfd+b6VqUa9ct0AMtQ6T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HzqDEi0J; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e289f569-4610-4646-8c31-73e26cd11e59@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748825290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r2lt/v4lPln6H8UwtYZCotciCrkUlJDhSN+rhSibg0w=;
	b=HzqDEi0JpX1lavWO3j4Ij0miDJAsgJMOAWb6RsThHi8HJStF45wXGM6b9LubdFMvy94FmZ
	S+1cXnBkmwB6EmtiwvQ6uSKhVfoXRrCrdytoy2C8ZTFXQ+/NVbnnOwToaXXS8BAYz+2I2E
	+mL+FjiVED6KZ7JvL5KDIVE0LIiirHA=
Date: Sun, 1 Jun 2025 17:47:58 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix a testmod compilation failure
 due to missing const modifier
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
References: <20250602003627.1921138-1-yonghong.song@linux.dev>
 <CAADnVQ+neTJWCZ2rmEUVYYvtGyjHgpoN-0W6pYec+73GRqDdfA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQ+neTJWCZ2rmEUVYYvtGyjHgpoN-0W6pYec+73GRqDdfA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 6/1/25 5:38 PM, Alexei Starovoitov wrote:
> On Sun, Jun 1, 2025 at 5:36 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>> Commit 97d06802d10a ("sysfs: constify bin_attribute argument of bin_attribute::read/write()")
>> added constant modifier to 'struct bin_attribute *' for read/write
>> func pointer members. This caused compilation failure with clang20:
>>
>>     bpf_testmod.c:494:10: error: incompatible function pointer types initializing
>>    'ssize_t (*)(struct file *, struct kobject *, const struct bin_attribute *, char *, loff_t, size_t)'
>>    (aka 'long (*)(struct file *, struct kobject *, const struct bin_attribute *,
>>                   char *, long long, unsigned long)')
>>    with an expression of type 'ssize_t (struct file *, struct kobject *, struct bin_attribute *,
>>                                         char *, loff_t, size_t)'
>>    (aka 'long (struct file *, struct kobject *, struct bin_attribute *, char *, long long, unsigned long)')
>>    [-Wincompatible-function-pointer-types]
>>    494 |         .read = bpf_testmod_test_read,
>>        |                 ^~~~~~~~~~~~~~~~~~~~~
>>    ...
>>
>> The same compilation error for functions bpf_testmod_test_write() and bpf_testmod_uprobe_write().
>>
>> Fix the build failure by adding proper 'const' modifier.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> I already applied similar patch to bpf tree couple hours ago.

Ok, sounds good. I only checked bpf-next tree.



