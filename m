Return-Path: <bpf+bounces-38910-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87AF496C667
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 20:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E199281F30
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 18:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE811E1A30;
	Wed,  4 Sep 2024 18:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="v1p+ohVh"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4084A1E1A0F
	for <bpf@vger.kernel.org>; Wed,  4 Sep 2024 18:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725474543; cv=none; b=iAhK8j0elvq4aUh3PrZ2gLq2IqvlHvn9eJCCS2lyQRwOZn5PAHWjpzXTvMOFVNRGQasv5BaGXtcMuN8EIJM0lkPMQ9XLp4XzBNik9LsrBBuUQ2YjLggWcInxAX1l1TIjROOjY9UZiBC3vma0xs6rcjtByq5nwlEUYF1uyuYMAfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725474543; c=relaxed/simple;
	bh=GEg7bzLTgm/v9Gavip/cXyBqetnf5rMrvJNyjDXY+sE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NBwMtBMyU1YkCFqqjgrQYHcONvF422ACO0yisgPwb4kDbAH2J+yRvG8mtM1TQY2m9wDG7YR9aLPYZYHvgKO9TT2LoMzEHIuy7W+1XeIWAb+DuRc9e6kkEf7c+y8fDrO2equErjZ8lgv8EHUoJ+5M8EKzs+2mX7cXW3vEVMwKKzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=v1p+ohVh; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3d3f7579-5749-487f-aa13-81bedca8d15e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725474539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GEg7bzLTgm/v9Gavip/cXyBqetnf5rMrvJNyjDXY+sE=;
	b=v1p+ohVh6cr8FNlBb2bd5l9bh0iIaeow5Zlhbr6Nwa+Ab5VwcQAptcQdsLyw/DGtsue0Ne
	RPNNF0VLy1QYxaLYRjRP/a+fy3kByB0oMxkKfGzaPDpYvzlOXE5ShI2YbeBN51pFh2z2zp
	bv5mU7jADkKWUA3/egt36ekPjdlLvSg=
Date: Wed, 4 Sep 2024 11:28:55 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Add a selftest for x86 jit
 convergence issues
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
References: <20240903225949.2066234-1-yonghong.song@linux.dev>
 <20240903225954.2066646-1-yonghong.song@linux.dev>
 <CAADnVQKEbSrRjautnd7eb+zvNfRintUZTVfACKhVmsrfvN6pfg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQKEbSrRjautnd7eb+zvNfRintUZTVfACKhVmsrfvN6pfg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 9/4/24 9:58 AM, Alexei Starovoitov wrote:
> On Tue, Sep 3, 2024 at 4:00 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>> +#include <linux/bpf.h>
>> +#include <bpf/bpf_helpers.h>
>> +#include "bpf_misc.h"
>> +
>> +#if defined(__TARGET_ARCH_x86)
> Does our test framework need this ifdef and dummy_test below?
> There is __arch_x86_64 below.
> Isn't it enough?

It should be enough. Other arch should be correct although
they do not have convergence issue.

Let me remove above "#if defined(__TARGET_ARCH_x86)" and
do a test again to ensure everything is okay.

>
>> +SEC("socket")
>> +__description("bpf_jit_convergence je <-> jmp")
>> +__success __retval(0)
>> +__arch_x86_64

