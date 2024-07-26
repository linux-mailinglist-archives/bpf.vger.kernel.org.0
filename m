Return-Path: <bpf+bounces-35767-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F204093DA21
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 23:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 883EE1F23665
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 21:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0195149C41;
	Fri, 26 Jul 2024 21:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="O8568tUM"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB04F1CA80
	for <bpf@vger.kernel.org>; Fri, 26 Jul 2024 21:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722028710; cv=none; b=cPHV2m81Z4gW+wO9Yd4Z6HatZNC7mOyYlVMIKopv/RIZVi5xZeYMM+cicg1TG4I3/nsj1wbwvURfdgvMWgRmhjQLqWNKlRHVoK45acZkg0MkMRZKZG6kyf8pR+hUkl4t80YgUvYMYo1T/YzRodCNC4xXS6f2uExfHjVXV1d3UEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722028710; c=relaxed/simple;
	bh=8etI0bVmgu7hWp4lAFpxUo4WKkKlNyNP6SWDj9fydRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a+aUoNo/weUc3ctsFl2hJbPgLBrwspqw590fyypu2bhm65auTYYDSXUjr/wO769vhNSLa2BzSny5FhwyT4N0lgj4kJIjQ5FOA1qnlqKmZn6sS4uueGibvumcs/YE+guKobSUdldCC3uylObqQNXpDpDeOtg+rDJs2Wd/vqZ5YvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=O8568tUM; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <fbf3d07e-e537-4e61-99f6-5f34ad140f56@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722028706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8etI0bVmgu7hWp4lAFpxUo4WKkKlNyNP6SWDj9fydRA=;
	b=O8568tUMut+e/oB9efVydn9BYrbGVZdja3y8aYyCLc4UD8zHkNidtLbllNn8UhjDnWii2M
	jvq4elzMgPdceXdazw8M8wVfQ/26JtHL/8mOdVJLUQWrU7fxlRztOEiDx27Cnz6OBQJoHW
	GCE/T6T+xckHfMpSyW18c7bjxjG4TFY=
Date: Fri, 26 Jul 2024 14:18:17 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf] bpf/selftests: Fix ASSERT_OK condition check in
 uprobe_syscall test
Content-Language: en-GB
To: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
 Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
References: <20240726180847.684584-1-jolsa@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240726180847.684584-1-jolsa@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 7/26/24 11:08 AM, Jiri Olsa wrote:
> Fixing ASSERT_OK condition check in uprobe_syscall test,
> otherwise we return from test on pipe success.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


