Return-Path: <bpf+bounces-51178-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 151A8A31668
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 21:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 380573A3F08
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 20:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687AF1EE003;
	Tue, 11 Feb 2025 20:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="no3ze73k"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563B826561A
	for <bpf@vger.kernel.org>; Tue, 11 Feb 2025 20:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739304384; cv=none; b=ap0Gofb8LSfCj1gzK1YxMHyT5+2iiGAdVHZh5RjtcsANnTJwlpvagh9yLCwcrj8bgMCi9PqxQPlQ3YjYIq6C5QXjsgTtsa3W38ED4M8Lkw1UVhgXFo7YMHO/UE4DF1N8UQ2uzRvlfwY7emDZuUBSgiuLUh01+/kpE+0SEmlZjIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739304384; c=relaxed/simple;
	bh=laogS5xf3BkdJjoVokr2gIJNXQw6RTpmUOh2P/Bk9/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EPhCXceeovFA6i9PCO6lKUHYMJod75sfznsyXZV+OepSk110wPtGLmdfLz+ppHkkINEyzck4kp/aotNJMS6GKa/O+6JWkhPc3WmK+Ax+qSUAQKVhY7BbKTzySMpoupyNvgbcu+QB+wSKSGk4qxNouUOy7Qct209TyOW0oG7PklU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=no3ze73k; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <78987b29-44e2-4318-a6a5-391b7cd76a16@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739304380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=teEjt09nyR0qT2F5yFfTBmQa37iL3QgjkucBtUk4Boc=;
	b=no3ze73kgkmpvw1xwVXvHvXSq7EtPs/ALLybNSQO+NqBk4SxF0luYkJlziAnMkGTYDGyGy
	lfgjMX4qKy8jZOdXGIJh/LL2y2gzuEH4hi7wpr4Tz+qfEX4yW2sk2LuUhye4edPkJDfDi3
	4TyCiWTfhTJqkQwRaDTdlloqX5qjUP0=
Date: Tue, 11 Feb 2025 12:06:13 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1 1/2] bpf: changes_pkt_data: correct the 'main'
 error
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, mykolal@fb.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20250204023946.16031-1-kerneljasonxing@gmail.com>
 <20250204023946.16031-2-kerneljasonxing@gmail.com>
 <7b348ab7-7378-40bc-98e7-98eb1377f9c2@linux.dev>
 <CAL+tcoA2wV1CvAV1TZAvrRuxOntb0fEDpgOsC2-FVtYr-go=1w@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <CAL+tcoA2wV1CvAV1TZAvrRuxOntb0fEDpgOsC2-FVtYr-go=1w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2/6/25 10:48 PM, Jason Xing wrote:
> On Fri, Feb 7, 2025 at 2:04 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>
>> On 2/3/25 6:39 PM, Jason Xing wrote:
>>> When compiling the selftests, the following error is printed out:
>>> selftests/bpf/prog_tests/changes_pkt_data.c: In function ‘test_aux’:
>>> selftests/bpf/prog_tests/changes_pkt_data.c:22:27: error: ‘main’ is usually a function [-Werror=main]
>>>     struct changes_pkt_data *main = NULL;
>>
>> The bpf CI has been testing this piece with different compilers. I also don't
>> see it in my environment. How to reproduce it and which compiler?
> 
> The gcc version is "gcc version 8.5.0" which is an old one. Yep, there

gcc 8.5 is old. I don't even know if it supports compiling the bpf prog in the 
bpf selftests.  Please update the compiler.

