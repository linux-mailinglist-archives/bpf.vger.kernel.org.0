Return-Path: <bpf+bounces-21194-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 810FD8492AE
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 04:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 179EEB20EA3
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 03:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD0B7493;
	Mon,  5 Feb 2024 03:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MAylQIpv"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929479449
	for <bpf@vger.kernel.org>; Mon,  5 Feb 2024 03:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707102773; cv=none; b=QEHBJtkEJOyr5FLO2PtQxn1ifhV100E+xVqswd+qBHKGbYwoKLnDB3qSylkuo8Nb709F/PU5XkczG0zwRvsWGOZVU9i8fOxQJQE1skCpRUzb4w6r+HI310jeU+b5Wk/W+Kl2J7NyKjwMzqjfHL58z9hdxWQ6k0ELXx2UBhur6As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707102773; c=relaxed/simple;
	bh=j7drw7tN58qOv27MFyGLr1KNJKqcS+zGZDuoiGH+DAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C5/I/f/Xaen/fH2VmxB9EP0VSv8s1czA4VYCc+2o7Vjj+4GYffu6K64A/OWiZ+wNhycydsKYdOZjJB7khtAHYEm7F7COzD7Kc1oBpVwnVbpSZ0ZkW5WZt5LM3xW4h9YTMRcEMQPMdpy9ZD55Co+EErQHJaBO7VCtVu6oqBvh/DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MAylQIpv; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <091fa367-10fa-4380-a0ee-d63a67192c46@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707102769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j7drw7tN58qOv27MFyGLr1KNJKqcS+zGZDuoiGH+DAo=;
	b=MAylQIpviF4s71LNoJqcTYXzJeyjZKzvPEBWfUisSa2oppu/IF+/Qz8+MgwJL0ZISmVRWd
	sUILd83nT3KjQBlUYOCr8XBl0qat75OlzdNwlocjT4b1eiw9ZGn0OwKEfYKcQS8wC/CI3G
	i1+M2cGEa0ErjQUFZFg4pEHpC1I4t54=
Date: Sun, 4 Feb 2024 19:12:42 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1 1/2] bpf: Transfer RCU lock state between
 subprog calls
Content-Language: en-GB
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: David Vernet <void@manifault.com>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>, Tejun Heo <tj@kernel.org>
References: <20240204230231.1013964-1-memxor@gmail.com>
 <20240204230231.1013964-2-memxor@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240204230231.1013964-2-memxor@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 2/4/24 3:02 PM, Kumar Kartikeya Dwivedi wrote:
> Allow transferring an imbalanced RCU lock state between subprog calls
> during verification. This allows patterns where a subprog call returns
> with an RCU lock held, or a subprog call releases an RCU lock held by
> the caller. Currently, the verifier would end up complaining if the RCU
> lock is not released when processing an exit from a subprog, which is
> non-ideal if its execution is supposed to be enclosed in an RCU read
> section of the caller.
>
> Instead, simply only check whether we are processing exit for frame#0
> and do not complain on an active RCU lock otherwise. We only need to
> update the check when processing BPF_EXIT insn, as copy_verifier_state
> is already set up to do the right thing.
>
> Suggested-by: David Vernet <void@manifault.com>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


