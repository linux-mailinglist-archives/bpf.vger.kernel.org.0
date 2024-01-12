Return-Path: <bpf+bounces-19412-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6458382BAE1
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 06:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A2B91C24B4D
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 05:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E788F5B5CF;
	Fri, 12 Jan 2024 05:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZfZ/uoG7"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2F25B5B1
	for <bpf@vger.kernel.org>; Fri, 12 Jan 2024 05:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9b8d48aa-6997-4d4a-a0e9-0efd287f7f0d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705037638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZPQgoEdDQBwrM0RkQGnQp4L9Em8kPXedY59y+8a9g9g=;
	b=ZfZ/uoG7qQIhytz5SC06Djlbw0KJCtoMtI4IkuPXwtuGxCYIGYPlp06+e504BWw9gFgLYs
	xY1WOJooV/w+KRdiFHmvs8Cd14Bih0k+hvZBuolVpedP9UptJKeMQwPRL7Nfn+QGedmxhm
	VApSVhPGemRN3Wsefj9AN4OLLSLFK4E=
Date: Thu, 11 Jan 2024 21:33:53 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 bpf 2/3] bpf: Avoid iter->offset making backward
 progress in bpf_iter_udp
Content-Language: en-GB
To: Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org
Cc: 'Alexei Starovoitov ' <ast@kernel.org>,
 'Andrii Nakryiko ' <andrii@kernel.org>,
 'Daniel Borkmann ' <daniel@iogearbox.net>, netdev@vger.kernel.org,
 kernel-team@meta.com, Aditi Ghag <aditi.ghag@isovalent.com>
References: <20240110175743.2220907-1-martin.lau@linux.dev>
 <20240110175743.2220907-3-martin.lau@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240110175743.2220907-3-martin.lau@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 1/10/24 9:57 AM, Martin KaFai Lau wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
>
> There is a bug in the bpf_iter_udp_batch() function that stops
> the userspace from making forward progress.
>
> The case that triggers the bug is the userspace passed in
> a very small read buffer. When the bpf prog does bpf_seq_printf,
> the userspace read buffer is not enough to capture the whole bucket.
>
> When the read buffer is not large enough, the kernel will remember
> the offset of the bucket in iter->offset such that the next userspace
> read() can continue from where it left off.
>
> The kernel will skip the number (== "iter->offset") of sockets in
> the next read(). However, the code directly decrements the
> "--iter->offset". This is incorrect because the next read() may
> not consume the whole bucket either and then the next-next read()
> will start from offset 0. The net effect is the userspace will
> keep reading from the beginning of a bucket and the process will
> never finish. "iter->offset" must always go forward until the
> whole bucket is consumed.
>
> This patch fixes it by using a local variable "resume_offset"
> and "resume_bucket". "iter->offset" is always reset to 0 before
> it may be used. "iter->offset" will be advanced to the
> "resume_offset" when it continues from the "resume_bucket" (i.e.
> "state->bucket == resume_bucket"). This brings it closer to
> the bpf_iter_tcp's offset handling which does not suffer
> the same bug.
>
> Cc: Aditi Ghag <aditi.ghag@isovalent.com>
> Fixes: c96dac8d369f ("bpf: udp: Implement batching for sockets iterator")
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


