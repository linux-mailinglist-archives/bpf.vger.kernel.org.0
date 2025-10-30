Return-Path: <bpf+bounces-72973-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7579C1E71D
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 06:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9A883BBDB1
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 05:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D757E32D0EE;
	Thu, 30 Oct 2025 05:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="H7FEbpgI"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625D82F5474
	for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 05:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761802654; cv=none; b=cfxFK4VS6Ir3/sC7G4UMf4zBHRBhJB7n6ik+OXdBDTw00GhLE5wQRA3xSx9PRrEi1bTsrvTrLuS2zTFJTF+v0/X1GQ9lAZr1cLOnyuvj5/UXwyG6XvbQv1otzHgcG9FfzlCsUCZoqfun3BKd8ZMW1HMIPFgw029o72RMHG66WDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761802654; c=relaxed/simple;
	bh=46mmGozAfgW5lEgPJaUtGVs4MXmDyYgf5TybHmNQQ7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kYxce3p8uCPMcO0msGTV1NpOoDTJCTBKl6afWGgWa5LlXUWSyouC9r0fER3HDRjfhsMkeMBHgfGsHCQPWdz4nnOGGxmRqvxUooSG0O31Tlx8BAvORkQbG1QAN9vLfYt8z/OroGi9XE1Mf3olWX+kpuKbXKvDgqo2KMnOzTN3+v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=H7FEbpgI; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <44fb71fe-2913-4541-9e4c-a8e9647a7300@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761802639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vW/UvmAQlpIrKevONore/gC6Amc4prfuUc9Jfz4b8f4=;
	b=H7FEbpgI1XeHKqoDskomsDd2bTDMo0tCv6tAYx4x5WPUcrbJ9OshraNqGschWCdQKqPXdf
	CsI/CqhBJIEZFY4zrtlfvvWlZs0AdIeQgfGuhqoYw3k0NaGVQRMTZq27TUqJLlmfqsusfA
	EMYOggVPUjozlOmgycJ8Va5zAWs1IJ8=
Date: Thu, 30 Oct 2025 13:37:07 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v3 0/4] bpf: Free special fields when update hash and
 local storage maps
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 patchwork-bot+netdevbpf@kernel.org, Menglong Dong
 <menglong8.dong@gmail.com>, bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 LKML <linux-kernel@vger.kernel.org>, kernel-patches-bot@fb.com
References: <20251026154000.34151-1-leon.hwang@linux.dev>
 <176167501101.2338015.15567107608462065375.git-patchwork-notify@kernel.org>
 <CAEf4BzbTJCUx0D=zjx6+5m5iiGhwLzaP94hnw36ZMDHAf4-U_w@mail.gmail.com>
 <23eddad8-aae3-44ce-948a-f3a8808c1e24@linux.dev>
 <CAADnVQJHAxKmhDdJ_SkgHMf3adiS8MmD5MJCfiFfxU+8peT9-Q@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAADnVQJHAxKmhDdJ_SkgHMf3adiS8MmD5MJCfiFfxU+8peT9-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 30/10/25 00:38, Alexei Starovoitov wrote:
> On Tue, Oct 28, 2025 at 11:50 PM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>>
>> Right, this is the classic NMI vs spinlock deadlock:
> 
> Leon,
> 
> please stop copy pasting what AI told you.
> I'd rather see a human with typos and grammar mistakes.

Got it.

Thanks,
Leon


