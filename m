Return-Path: <bpf+bounces-23245-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 161AF86F177
	for <lists+bpf@lfdr.de>; Sat,  2 Mar 2024 17:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15DB01C20905
	for <lists+bpf@lfdr.de>; Sat,  2 Mar 2024 16:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A4421370;
	Sat,  2 Mar 2024 16:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mXqNI4jP"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A98A18E37
	for <bpf@vger.kernel.org>; Sat,  2 Mar 2024 16:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709398166; cv=none; b=hnaSvXtt5vIWER871UC52MYQm/ep/UFZtHRj59jcNm8L97Zb37McPJalN/VsN56mlrq9uqH9IFkzsyVQJEooKTntyCPeNKbfH7arNH1pGovIQ3Ilhep1qrwNz4Lxqwp+XvvptQ+2A9tYj9bkfzCEqcqsM0rqfbA2hGZbXvWGPx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709398166; c=relaxed/simple;
	bh=/quNeClKh78Sz91EBOi6K9rHr+BlGtFMvoQlcwHOhd0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=bIyM67xYlmuenVIV6TXqRwKO1jg0fjKOforuV/iM6fTr43VozARDgs2aIR6l+FojeAo0xi5J/OtlDQjvimyaV/Zlm9uHsvzAYgaZrl7dTzYaqpJg8zB9IYyiYsMMwYMwNlcT6mpDQH5nwE/8ycKAlz1+qnFh8Vqpi8Ma96FZKmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mXqNI4jP; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8188fb77-c4b2-4418-9956-f1cd0408d26c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709398162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gY8NzI/VHkC518Jlw7ZbO4SkDRbaZBthEX9hhMYcwmU=;
	b=mXqNI4jPxLf5TSPwedm9iLRgPZVaL2eNlr93o2oSI2V3AFfELoMeGeCMsrEOoVzEAvHF6p
	DAK+Xl0cJVUqV/3UkPzxCPSxtrAhmYE2ibS62JvvAWT6NBCPKuBx/W5NSM1Wdrx33lEmky
	8Yvk55emr/fbbXOzUaVS2d6q4vzMjUQ=
Date: Sat, 2 Mar 2024 08:49:13 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 0/4] selftests/bpf: Fix a couple of test failures
 with LTO kernel
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20240302162044.1498741-1-yonghong.song@linux.dev>
Content-Language: en-GB
In-Reply-To: <20240302162044.1498741-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 3/2/24 8:20 AM, Yonghong Song wrote:
> With a LTO kernel built with clang, I encountered two test failures,
> ksyms and kprobe_multi_bench_attach/kernel. Both test failures are
> due to static variable/function renaming due to cross-file inlining.
> The solution is to either skip the test or filter out those renamed
> functions. A helper function check_lto_kernel() is introduced to
> identify whether the underlying kernel is built with LTO or not.
> Please see each individual patches for details.
>
> Yonghong Song (4):
>    selftests/bpf: Replace CHECK with ASSERT macros for ksyms test
>    selftests/bpf: Add check_lto_kernel() helper
>    selftests/bpf: Fix possible ksyms test failure with LTO kernel
>    selftests/bpf: Fix possible kprobe_multi_bench_attach test failure
>      with LTO kernel
>
>   .../bpf/prog_tests/kprobe_multi_test.c        |  7 +++
>   .../testing/selftests/bpf/prog_tests/ksyms.c  | 42 +++++++++--------
>   tools/testing/selftests/bpf/testing_helpers.c | 47 +++++++++++++++++++
>   tools/testing/selftests/bpf/testing_helpers.h |  1 +
>   4 files changed, 78 insertions(+), 19 deletions(-)
>
Please ignore this one. It is my git send script issue with Message-Id vs. Message-ID.
Will post actual series soon.


