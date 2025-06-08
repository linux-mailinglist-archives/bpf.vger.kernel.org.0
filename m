Return-Path: <bpf+bounces-60011-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF599AD12A7
	for <lists+bpf@lfdr.de>; Sun,  8 Jun 2025 16:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FD0C7A53BE
	for <lists+bpf@lfdr.de>; Sun,  8 Jun 2025 14:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8F72116F5;
	Sun,  8 Jun 2025 14:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lBPJ766E"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223FC282EB
	for <bpf@vger.kernel.org>; Sun,  8 Jun 2025 14:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749393142; cv=none; b=L62nlSQOjAEFOrWXscvUR5/BKuokTy2GjxcABqjMHHNc67skQAowi5IblejJx1vQdFtSGudN9x7duhNihth/xivaHGZNx+eHLm/so/z0fnzg7pbaJh+UreKEeiDk+97qGKsBA9IvO3zxtoYUtNN03g49jpuHiZ8+kthDFq3yV3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749393142; c=relaxed/simple;
	bh=H0PThwnqughyGQkOdqDlsMIblLKvsgoeeYY5tjXdJKQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ci2a0vgZo1Agb6BW0e1tqzz+ZP41OHQI/d/BY9EboGySdB19qaKDMhVFc1JSzI1+ceF8pQZviZ1GzhDNe5lfFS+kqdZ7/qNPJhaBnZMDDIDEuCH0r7paK682rrIytmb5UoCjjzWbJWQMwalvY1pFJK6LzqHoIMxpbskXaIFRYKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lBPJ766E; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a09cbf07-f6b9-4808-a955-2f506c320585@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749393136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GWGpWO4XZip3DDSvOV06d85tUhqZHEdZ1brs1WQyrzs=;
	b=lBPJ766EukbyvQ1Uy3PN+0uY9B4zWhk2+1hmw7Di08Jm1Y96qWA61F7pvalbdATyGGFTHL
	hbl+V/kkq9+xiuymQsk5Q4TyXFAuaRPkdh4pFjTOsp5ujCYfabn5iVm7Cw9L0/ZeRRsYco
	cJ7JVRJ2crhdwuZPWrcGZsmDV7WNd7w=
Date: Sun, 8 Jun 2025 07:32:02 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] Documentation: Enhance readability in BPF docs
Content-Language: en-GB
To: Eslam Khafagy <eslam.medhat1993@gmail.com>
Cc: skhan@linuxfoundation.org, David Vernet <void@manifault.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Dave Thaler <dthaler1968@googlemail.com>,
 "open list:BPF [DOCUMENTATION] (Related to Standardization)"
 <bpf@vger.kernel.org>,
 "open list:BPF [DOCUMENTATION] (Related to Standardization)" <bpf@ietf.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20250607222434.227890-1-eslam.medhat1993@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250607222434.227890-1-eslam.medhat1993@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 6/7/25 3:24 PM, Eslam Khafagy wrote:
> The phrase "dividing -1" is one I find confusing.  E.g.,
> "INT_MIN dividing -1" sounds like "-1 / INT_MIN" rather than the inverse.
> "divided by" instead of "dividing" assuming the inverse is meant.
>
> Signed-off-by: Eslam Khafagy <eslam.medhat1993@gmail.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>

> ---
>   Documentation/bpf/standardization/instruction-set.rst | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
> index ac950a5bb6ad..39c74611752b 100644
> --- a/Documentation/bpf/standardization/instruction-set.rst
> +++ b/Documentation/bpf/standardization/instruction-set.rst
> @@ -350,8 +350,8 @@ Underflow and overflow are allowed during arithmetic operations, meaning
>   the 64-bit or 32-bit value will wrap. If BPF program execution would
>   result in division by zero, the destination register is instead set to zero.
>   Otherwise, for ``ALU64``, if execution would result in ``LLONG_MIN``
> -dividing -1, the destination register is instead set to ``LLONG_MIN``. For
> -``ALU``, if execution would result in ``INT_MIN`` dividing -1, the
> +divided by -1, the destination register is instead set to ``LLONG_MIN``. For
> +``ALU``, if execution would result in ``INT_MIN`` divided by -1, the
>   destination register is instead set to ``INT_MIN``.
>   
>   If execution would result in modulo by zero, for ``ALU64`` the value of


