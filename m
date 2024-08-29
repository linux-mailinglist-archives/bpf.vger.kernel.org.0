Return-Path: <bpf+bounces-38423-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EA9964BF8
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 18:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D5131F2310C
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 16:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF7A1B5825;
	Thu, 29 Aug 2024 16:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="krKTnK5L"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90F41B0120
	for <bpf@vger.kernel.org>; Thu, 29 Aug 2024 16:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724950235; cv=none; b=EtiSMVezatyqgXbiPPk/J3tSFk8nqkMm+jTSHWTsuZiPD1z+pjsujXIiwxyh7DNmDfLjkPcwnSYmYrZvbR78cU2Lgu8ovF+Sa+S/PC8j4IQy4aQ+JiFz+l3l/LdpQz0fakdCyeXQgvXaV5etN2gsK6AQeLU4Zde7fQxC82T/Vrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724950235; c=relaxed/simple;
	bh=dD4PvjbZZ23Cf4eOMekq2pj4kQL6uLWLecmPT1bKoGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YCjYB4zwxNkuuoc+/dJiiyIpizSVRU2wUqM8FuMKd2XQ5sj1LY/XEEroNY9I1wAMu4augA5t7Rpu8UJkvXRgdj1MGTCxzT9KezeDzg5fWV7Yy+/TztCiTZvZiI4MNhOmN7nhKNMf/5JJIHUWRehAuhsKL1tsqmYKdk/xeLetkD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=krKTnK5L; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <161d7d7f-a99c-449c-8ee2-c4f74ea543cc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724950230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dD4PvjbZZ23Cf4eOMekq2pj4kQL6uLWLecmPT1bKoGc=;
	b=krKTnK5LCCfyZ6m3U34s/PDOF8MRUHrJOYyNbXdw5I1IcTgZiy4tO8ocG/wtVuEllcNm/n
	wviAJ7Og+B8aG6+uUpxirUNn/WTQJaLFtDI1y69QdjowsLGWltkoZ7CCsPHrr2+0H/wGyF
	N7JwhjVs/YIysGWM5ojAOLyCUCgY6Jw=
Date: Thu, 29 Aug 2024 09:50:24 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf, x64: Fix a jit convergence issue
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>,
 Daniel Hodges <hodgesd@meta.com>
References: <20240825200406.1874982-1-yonghong.song@linux.dev>
 <CAADnVQ+5HD1ZxBqpDgNuwPkO1+VGzm1yqhxuDD4HYtkRYHwXiA@mail.gmail.com>
 <7e2ad37e-e750-4cbd-8305-bf16bbebcc53@linux.dev>
 <CAADnVQLbknLw9fOhgbSNaNzKi5gfQTP74vXQu3D1P2OVF81b+Q@mail.gmail.com>
 <0723964d-97b9-4b48-995c-3c9efa980f5a@linux.dev>
 <CAADnVQJ1WRVy1Zto=7N86PpYshLyjTXwwtawrhuok3ydAsjTCQ@mail.gmail.com>
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQJ1WRVy1Zto=7N86PpYshLyjTXwwtawrhuok3ydAsjTCQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 8/29/24 9:37 AM, Alexei Starovoitov wrote:
> On Wed, Aug 28, 2024 at 6:55 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>>
>> So we need to apply the same checking is_imm8_cond_offset() to jmp insn.
>> This should cover all cases.
> Looks like it.
> If I'm reading it correctly is_imm8_cond_offset() doesn't need
> to be 127-4 for jmp. It can be 127-3, since jmp insn can grow by 3 bytes.

Right, 127-3 should work for jmp insn.

> But to avoid thinking twice I'd use the same is_imm8_cond_offset()
> for both jmp_cond and jmp.

Sounds good. I will add this into commit message as well.


