Return-Path: <bpf+bounces-69119-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 496DFB8D321
	for <lists+bpf@lfdr.de>; Sun, 21 Sep 2025 03:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26518189F52D
	for <lists+bpf@lfdr.de>; Sun, 21 Sep 2025 01:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61EFD1684A4;
	Sun, 21 Sep 2025 01:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oUSCh3xn"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2FC323E
	for <bpf@vger.kernel.org>; Sun, 21 Sep 2025 01:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758418920; cv=none; b=qQumn7tH3B3zAw01YWO5BrKdx9s/ZNUr05eQJzcbQ6dXn5d4TD8fIQbPihPwK4qGX6M33BnEF7Iwj4dW/xoYtxHO76fIpVtqDrI5kDTMheUElpJDZY47fZUa6s+8E7C9DZ0u1K6L/CvdSOZsDjHeSwZaJH1+5d7lo81UVXu57Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758418920; c=relaxed/simple;
	bh=/0uTxHtrTInsQU47tHTuCm/lFoOnK2BiYyu8DgU6ydo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qg94oXzg+7ezvgQAX92iwFfutz8dANC5JWHrfvDa+2nTKAARS0MEpQjFtvS4Dl2XUlo9nuylnDPIFFZU9RT9sUGrBoGiO26bLM5ZkaR/lzgAVx4KEqlJK393ep8mnJLLv89hQDkkvUhLWn73+CB28prGPflZAFr+HPd6vANZw4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oUSCh3xn; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <22db8dd3-5df4-401d-8d63-5e0f2294bfd3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758418915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WpHTF/LeUi7nlGqkmmlqalAC7lWPFrHQTRdADn3RbvM=;
	b=oUSCh3xnruueHHlXrj3Up8QIHgpXS4pdzXCGoo9GfcdcNU8NgF/3iTQTuQfwgXWe4NyBre
	U1r9z832Bkd7USBM7D7awVxrTNQAcrlg+xbEPsDhqyel6TbSdE81yc4miE8cPhmBCwPN9A
	a1iGVKw7znkLq3oIFSuPcquwG5vkFzM=
Date: Sat, 20 Sep 2025 18:41:50 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] libbpf: Silence newly-added and unused sections
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20250920153531.3675700-1-yonghong.song@linux.dev>
 <bb7aca1aa66dc0791cbdb16934b4b4a139a63695.camel@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <bb7aca1aa66dc0791cbdb16934b4b4a139a63695.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 9/20/25 5:30 PM, Eduard Zingerman wrote:
> On Sat, 2025-09-20 at 08:35 -0700, Yonghong Song wrote:
>> With latest llvm22, when building bpf selftest, I got the following info
>> emitted by libbpf:
>>    ...
>>    libbpf: elf: skipping unrecognized data section(14) .comment
>>    libbpf: elf: skipping section(15) .note.GNU-stack (size 0)
>>    ...
>>
>> The reason is due to llvm patch [1]. Previously, bpf class BPFMCAsmInfo
>> inherits class MCAsmInfo. With [1], BPFMCAsmInfo inherits class
>> MCAsmInfoELF. Such a change added two more sections in the bpf binary, e.g.
>>    [Nr] Name              Type            Address          Off    Size   ES Flg Lk Inf Al
>>    ...
>>    [23] .comment          PROGBITS        0000000000000000 0035ac 00006d 01  MS  0   0  1
> This section is generated by MCELFStreamer::emitIdent(), virtual
> function.
>
>>    [24] .note.GNU-stack   PROGBITS        0000000000000000 003619 000000 00      0   0  1
> And this one is generated by MCELFStreamer::initSections() virtual
> function and is controlled by NoExecStack formal parameter.
>
> MCELFStreamer instance for BPF backend is created by function
> BPFMCTargetDesc.cpp:createBPFMCStreamer().
>
> I think we can define a sub-class BPFMCELFStreamer, override the above
> virtual functions and suppress generation of the sections above.
>
> [...]

Two llvm pull request:
   to avoid generating .comment section:
     https://github.com/llvm/llvm-project/pull/159958
   to avoid generating .note.GNU-stack section:
     https://github.com/llvm/llvm-project/pull/159960


