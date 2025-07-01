Return-Path: <bpf+bounces-61956-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E58AEFEB9
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 17:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACA7B446026
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 15:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E9127A101;
	Tue,  1 Jul 2025 15:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="w4fAoeGh"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E951DE8A8
	for <bpf@vger.kernel.org>; Tue,  1 Jul 2025 15:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751385427; cv=none; b=d5DeoSchzy+SV+diyMcotjYzl/fq9b8NumpLvi/1YyCQyjCVjnS3LiGKEgWHokxN98hvfZzsE/emGzoSC7cWXniN6TKCrWuuwjEIOHLPXGOIfnr5JLp4xoyul86yWuwKWAB8uDJvdOFeNFJ4btF5sLm3af66ZwV+MIdGb7Zto94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751385427; c=relaxed/simple;
	bh=nX7GgLgryEuHs4wvNXUUQnK03UkheR+3/k6yxra3vho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nd7ZLwBkfabo5QGVoDmXT1IN1fHJsLz4ihREEpTDTlkv3er5LRlV1vDtX3PtuJUoNi1wn+CAqYAhhwkd9K0Dz8Mc91dCZicyum7vnPKYcdA/dprNoxFsQi4XQTEjDG2pxFUJBM3MTLlQ1GrWnBAJnQfLKdbdhi1i9i6d3IrK5Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=w4fAoeGh; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e77c3c0c-b215-4bb4-87b4-1a2e5c346632@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751385421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jQSLYTNmwQt51gJNVDL4Es/VqqrW4zoAkpo7dFgFq6Y=;
	b=w4fAoeGhYOQc6upi1dWDm9xh+9iHArNGoHRRI4nhr36Xgxn6e5Mg7RNKBIk6Pyhh0l5W3w
	ZAgo9JhjDRjACEXUJLg1WDBplNvnpFZoBgGpdH/7HrBEkQABRC2QS7aWt/UpVJFDaCuCY7
	XZSBiCU5kiP3sPadC5Ekmx8OaJSQiQI=
Date: Tue, 1 Jul 2025 08:56:56 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf 1/2] bpf: Reject %p% format string in bprintf-like
 helpers
Content-Language: en-GB
To: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Florent Revest <revest@chromium.org>
References: <9d7c0974af8ab9b99723bd3f72d4bea8972d7cb5.1750953849.git.paul.chaignon@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <9d7c0974af8ab9b99723bd3f72d4bea8972d7cb5.1750953849.git.paul.chaignon@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 6/26/25 9:06 AM, Paul Chaignon wrote:
>      static const char fmt[] = "%p%";
>      bpf_trace_printk(fmt, sizeof(fmt));
>
> The above BPF program isn't rejected and causes a kernel warning at
> runtime:
>
>      Please remove unsupported %\x00 in format string
>      WARNING: CPU: 1 PID: 7244 at lib/vsprintf.c:2680 format_decode+0x49c/0x5d0
>
> This happens because bpf_bprintf_prepare skips over the second %,
> detected as punctuation, while processing %p. This patch fixes it by
> not skipping over punctuation. %\x00 is then processed in the next
> iteration and rejected.
>
> Reported-by: syzbot+e2c932aec5c8a6e1d31c@syzkaller.appspotmail.com
> Fixes: 48cac3f4a96d ("bpf: Implement formatted output helpers with bstr_printf")
> Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


