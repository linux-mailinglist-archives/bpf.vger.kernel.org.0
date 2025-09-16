Return-Path: <bpf+bounces-68547-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8705FB5A2E2
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 22:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DED401C055A5
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 20:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF53C32F49E;
	Tue, 16 Sep 2025 20:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QrZWCvCZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F5D32857B;
	Tue, 16 Sep 2025 20:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758054326; cv=none; b=pm/Hnxsw3aWn/+g3cEFXlm+/wzLtUDqFhk8EtEB7WelCeaTBHGFzS7RAOH7LINSOalDMT2If6GhsB/i5THcotQP4uL+0N/q/Dk47Or6dsgrvgY9cmacjMJn12Ha3uhwtd82VLEjiC7j144mcKrxZEBcW6yk2GRECp8iZ5DuRN2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758054326; c=relaxed/simple;
	bh=CvgkQu4TUhOa47lyuAbCn4/3+TH4DxnUlcqkKV9Nk4w=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=bGe+o9kAS6NhCtxnZujxdbXpiYSFdRT8jx6r2S7H9JnVfFwLlfMAQqoAH9vXeCvFdEZzogfbBjupQeNo5U5VV3vVcESU6ifVhddwYPoOlF93SqTsNb1ajYlHlNZWDFCtT/SCBBjtuZ/SUvX2EtUsgyzHHXWzNky+gN2VUCDG7sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QrZWCvCZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B4F6C4CEEB;
	Tue, 16 Sep 2025 20:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758054326;
	bh=CvgkQu4TUhOa47lyuAbCn4/3+TH4DxnUlcqkKV9Nk4w=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=QrZWCvCZ0nm3fq3SLqWP96pHJzjZXsfyJW2UTrCEN3WbkyvYtEadE7Ap12cOmzrlV
	 KL4dUhzrY+/kr77UG0dmgPn6AXMPdAcqoP/80qIGn5Eukm7rkQG+2qDKdCWJq6KvYh
	 20X8KyIyP6t7qNkFMlndw1ZwhMY3HbYOpLwIH+pCCYgVbBrKP0RwEIBrwGqjn0v7hr
	 cvdDpUeeM1+tS1LtW+zUYKizxOtmsGIcSo41L+LZFyGBMuOarSp4s2Gj7OOnJsiQqC
	 2uicdq1weVQv3SDmIGV/bMDYEskyGKp2QhlpfKSN9ys0gELEUvvfQahJKFiwPwwi6v
	 hOavFbzeHWsww==
Message-ID: <39d35f3d-6fbc-4cb3-ab80-4e2b275b06c0@kernel.org>
Date: Tue, 16 Sep 2025 21:25:21 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Quentin Monnet <qmo@kernel.org>
Subject: Re: [PATCH bpf-next 1/2] bpftool: Add HELP_SPEC_OPTIONS in token.c
To: Tao Chen <chen.dylane@linux.dev>, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250916054111.1151487-1-chen.dylane@linux.dev>
Content-Language: en-GB
In-Reply-To: <20250916054111.1151487-1-chen.dylane@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2025-09-16 13:41 UTC+0800 ~ Tao Chen <chen.dylane@linux.dev>
> $ ./bpftool token help
> 
> Usage: bpftool token { show | list }
>        bpftool token help
>        OPTIONS := { {-j|--json} [{-p|--pretty}] | {-d|--debug} }
> 
> Fixes: 2d812311c2b2 ("bpftool: Add bpf_token show")
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>


Acked-by: Quentin Monnet <qmo@kernel.org>

Thanks!

I'll review your v2 with Alexei's comment addressed for your second patch.

