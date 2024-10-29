Return-Path: <bpf+bounces-43372-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE069B4256
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 07:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C78A1C21848
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 06:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1EF2010FC;
	Tue, 29 Oct 2024 06:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iIPABrPO"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7665F28E7
	for <bpf@vger.kernel.org>; Tue, 29 Oct 2024 06:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730182770; cv=none; b=lvB/0sB+Dz4BgE/7UTAZGq9l7X2uvp5KfpaOKncGDfQZo10ZTRFBP9en4Ylb8cyfn6s7M+R8GmBr6daf94giXgtFosP1Qu0Dfp7q+Tusu7zyyGHiQ7QiaM5yN38XoPl7Uyo7lX91/78/NmMsZjK3Atfx3JWjnfP4N3W2wrmmaeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730182770; c=relaxed/simple;
	bh=ks8tvZ0ZvY26sNQwxDerxvDeQ1sfaqOfyRfWrP33GvU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KU74L/WH9hGJ7wjfvQ96jHlEBNCMBgVGD7HY1jk6he8VYEKuOtbhbtNI+HQ3yp3eGTUCfUJcyl6kyf892poeCKDSEg2tuQuHfZGZHFH5yqot756lYOdz+2B+npsizwz7/ui0iuBnhFKx9EMMZFCwTz7bNhdF1WtSqjeAuisj+BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iIPABrPO; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b5aed7cd-3a1b-4d0a-a9fe-e8a2a7778cdd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730182765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u9WMyaBrz6Rc0EJzD5VFAXnB0tURCwG65EccTTtVhZE=;
	b=iIPABrPOj+oSHPAq2eq2zMhUCV9lYAgYd9qoza9iTFvtQc+6DG+hQDv0WOY6h1UNY/1JN5
	b1PWRYfrK/fVvz0nxuuA/G3Tx7dOPh54LVYdMdR3i1q+EkcZDcu8H81pXnI+u5fJcjELia
	dvusQZZSj1xto12O3X0R8mRO0Dszcio=
Date: Mon, 28 Oct 2024 23:19:17 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: Add test cases for various
 pointer specifiers
Content-Language: en-GB
To: Ilya Shchipletsov <rabbelkin@mail.ru>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Florent Revest <revest@chromium.org>,
 Nikita Marushkin <hfggklm@gmail.com>, lvc-project@linuxtesting.org,
 linux-kernel@vger.kernel.org
References: <20241028195343.2104-1-rabbelkin@mail.ru>
 <20241028195343.2104-3-rabbelkin@mail.ru>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20241028195343.2104-3-rabbelkin@mail.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 10/28/24 12:53 PM, Ilya Shchipletsov wrote:
> Extend snprintf negative tests to cover pointer specifiers to prevent possible
> invalid handling of %p% from happening again.
>
>   ./test_progs -t snprintf
>   #302/1   snprintf/snprintf_positive:OK
>   #302/2   snprintf/snprintf_negative:OK
>   #302     snprintf:OK
>   #303     snprintf_btf:OK
>   Summary: 2/2 PASSED, 0 SKIPPED, 0 FAILED
>
> Co-developed-by: Nikita Marushkin <hfggklm@gmail.com>
> Signed-off-by: Nikita Marushkin <hfggklm@gmail.com>
> Signed-off-by: Ilya Shchipletsov <rabbelkin@mail.ru>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


