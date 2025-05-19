Return-Path: <bpf+bounces-58468-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6039AABB298
	for <lists+bpf@lfdr.de>; Mon, 19 May 2025 02:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF74F3B3CC2
	for <lists+bpf@lfdr.de>; Mon, 19 May 2025 00:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87AC9AD4B;
	Mon, 19 May 2025 00:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Iyytp/QL"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059CA38B
	for <bpf@vger.kernel.org>; Mon, 19 May 2025 00:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747613410; cv=none; b=tLYdgkxD7xUkDaX0+on1l0XFP1KXcXQTaczr2n55+X+B6tpeJq+VbKW83XZSLF9BLaIf8gO//4CuvMBnHaVVZyt1MoeJMVLBepCWNU4Vggjosi2MaCNjk4VYn2/vJQ4pyd3ev3D/szLZVhfX2Lxd+b3jG6Q1YAZXm/gUZ/+NPr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747613410; c=relaxed/simple;
	bh=oqVlpvFxZ2oUhGtmsG5GATyuQjZ9U6PisKC1dJUH+pk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jVNbSXSblkEGbW3lJOtDVrDrAj+nZcZduy13ihiw23UBWZ27LGXf09gVSbDPUCII03NRrPmjJNf5qyWimFrvg1o3AjG8Utyu2FFAF2aFp1ACkJ+KLFo5O+7pFIqYMKn/fezr8oNChS3E+zPianl2zXXMQIP1pvyI6JeYmHWf01g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Iyytp/QL; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <711ce529-3a81-4f89-8c3b-43a5139190ef@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747613403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pps3wpGlMKoYJUF44jl2urXN/r2RlMEZU71NzJUBrZA=;
	b=Iyytp/QL1zwq/Pch3Qd5Vj/ejZTPXmeC1daIRC0jj3XBIN4sZcMCoEY1NcecE4RIezEyQd
	88GiBFR4HpWHsQ8iBiethx27RATMLU2CcyyNyJ2Kdt9G0EUumROrcRJecE6zuxapbPrh62
	uUmxtC0S9kNp1IcNujF6AAUGVS4KJyk=
Date: Sun, 18 May 2025 17:09:58 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Warn with new bpf_unreachable()
 kfunc maybe due to uninitialized var
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
References: <20250515200635.3427478-1-yonghong.song@linux.dev>
 <CAADnVQL9A8vB-yRjnZn8bgMrfDSO17FFBtS_xOs5w-LSq+p74g@mail.gmail.com>
 <1742bbe7-7f7a-4eef-a0a9-feb2cda50bbd@linux.dev>
 <CAADnVQJurPs_e3Lx9O7qZ+=HPk7XarXoGXeTiARbw8bW+-txGA@mail.gmail.com>
 <b32cd638-5ba1-4af5-80e6-3103786a7c8e@linux.dev>
 <CAADnVQKWU3Ap8Wm_DFFkYVYxenEMPdJZw7KjAPJ=RJXR9Q=FGg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQKWU3Ap8Wm_DFFkYVYxenEMPdJZw7KjAPJ=RJXR9Q=FGg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 5/18/25 11:41 PM, Alexei Starovoitov wrote:
> On Sat, May 17, 2025 at 11:14 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>>
>> On 5/16/25 5:31 AM, Alexei Starovoitov wrote:
>>> On Fri, May 16, 2025 at 2:17 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>>> So I then decided to add an 'exit' insn after bpf_unreachable() in llvm.
>>>> See latest https://github.com/llvm/llvm-project/pull/131731 (commit #2).
>>>> So we won't have any control flow issues in code. With newer llvm change,
>>> That's a good idea. Certainly better than special case this 'noreturn'
>>> semantic in the verifier.
>> Current latest llvm21 will cause kernel build failure:
>>     https://patchew.org/linux/20250506-default-const-init-clang-v2-1-fcfb69703264@kernel.org/
>> I will wait for the fix in bpf-next and then submit v3.
> that's not going to be soon. why delay the whole thing?
> submit with selftests that include inline asm and delay C only selftest.

Sure. Will submit with inline asm tests soon.


