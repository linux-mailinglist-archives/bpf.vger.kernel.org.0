Return-Path: <bpf+bounces-37564-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A19957A62
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 02:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74C791F23805
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 00:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BEF0A927;
	Tue, 20 Aug 2024 00:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AVNC1OlM"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462EF4C66
	for <bpf@vger.kernel.org>; Tue, 20 Aug 2024 00:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724113229; cv=none; b=Znkzx64fki34vSUfOO0g/fbNs/dlJrfPiRde6c4fGLX8/PMo48YGa8E324/iEeTko5/f82e+kccPLiH9+32jyxRF/h+Yq2zlIeI9kDeH3XR0kd/fB3/ZHNm304YztwQP+aF5kRiB3IJsDhxoX/cCMzou7PEZIIiypH113uSqFXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724113229; c=relaxed/simple;
	bh=VksYsUWOD3KZG1LL5Mp2atFCr6kNFIF9nUPp4+pXJG0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bQ3XDkRR4tHTgBRFNTKpXHxkjGt1FD+zmm3+O4Hj4zVGK0zYKiCfdYEA1pkboN8xJtcM2dV0d+hUyOn1JOc7noA9drN8Bkg5CNVFLzXt73mTiqYQ+r9NVj+CFogxVDs9TW1YOP3+SC1ndS1sXqh7C7X9RvI3RU9LxlZIKg6J/i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AVNC1OlM; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <00a9a863-165a-4a8d-9166-dac58e240e61@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724113225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kQaP6+4/ve3SwlwrauuiZeE4uLmF8wFyYGEC2/eT9Zg=;
	b=AVNC1OlMsxI7lqfIQ2kA9oYDn5egSSqaFv7hsKo/c4h6z90vQ9uKStzLHw4+S17KsMSMcd
	+o3Gfrfov5vH9pijGj9Ii/aRwDVriC9GRHOQU9uiz7BG+qZkRnrtSFb7jdSkoCj2/orLtx
	nkl7Mejor73On5M15WQvb3iX3Sn0F+4=
Date: Mon, 19 Aug 2024 17:20:17 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 0/6] selftests/bpf: Various sockmap-related
 fixes
To: Michal Luczaj <mhal@rbox.co>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Jakub Sitnicki <jakub@cloudflare.com>, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240731-selftest-sockmap-fixes-v2-0-08a0c73abed2@rbox.co>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240731-selftest-sockmap-fixes-v2-0-08a0c73abed2@rbox.co>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/31/24 3:01 AM, Michal Luczaj wrote:
> Series takes care of few bugs and missing features with the aim to improve
> the test coverage of sockmap/sockhash.
> 
> Last patch is a create_pair() rewrite making use of
> __attribute__((cleanup)) to handle socket fd lifetime.

Applied to bpf-next/net. Thanks.


