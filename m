Return-Path: <bpf+bounces-68920-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE85B887DC
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 10:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87B501C841D2
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 08:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7C12F1FDC;
	Fri, 19 Sep 2025 08:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jHFhhzd6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F421B1DC9B1;
	Fri, 19 Sep 2025 08:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758272224; cv=none; b=DUqqaUDzThTMFlgljq9PaM6VqCyemHxS8dvza+sPuoQPvXThutjZdeFlfOO6MDjiUsQm+SgcMk1ujU1Q7HlDHWUzZ0yrMusutUp8hJjG+nYwbgrm+FC3U0CjvRYkoVf217TNCoBS6/vktIYMj1oCuDHDURG8TfBCPltnrkzgyKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758272224; c=relaxed/simple;
	bh=QN+u40tBqyG8bJRlet+Ooj0R6+GElWYsz9DHvw+iMlw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VuFKym+FIuZc1Iz6aGFIxmQEU/DU6OUxTa+jYWkCuckD9Yj9lAbFvb7QFK9G2f8MNvE0GlA1HCZ/yD++8af9iHLQ9x8385eL4HckNZ/ZasYS9oBRIA7CohtYL2sB3TTFURxwETvjvNgugivpVSFG4xeLR40e34JXtxxXEVU5ofo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jHFhhzd6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51917C4CEF0;
	Fri, 19 Sep 2025 08:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758272223;
	bh=QN+u40tBqyG8bJRlet+Ooj0R6+GElWYsz9DHvw+iMlw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jHFhhzd6ld/N82cQWDHhCwhWfZLsx196eRTQJiLObwbi7+mfVl0PbNEI27DpQvqdo
	 GI4l7iki81CLx9s+jv3M1WV/+NPs8/vPOyoTvfaQVROlWmdrhhFuAdj/pQl+z/Nb8X
	 HGC7O2O06lLBY0H0vTcBHSqMNi3I7K1gKipXFu9SLw/r7b3G8NGsK4Iu12hZCozk2A
	 yPhnd1KmzE777kLPIsAeG+JEvJtHZ/eVoHDEccu4wHaHSht+kIo7sWOB+aWhBzVHuv
	 XqAF/skyT3WOoPFevQn2zgA6VCFt4rQX4EsF7KKVxssUjYHuFIIKB8st+ORgSPCbZK
	 g2HvUVmtPuNyw==
Message-ID: <be97c55b-a7ae-471b-8113-0c936634110f@kernel.org>
Date: Fri, 19 Sep 2025 09:56:59 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 2/2] bpftool: Fix UAF in get_delegate_value
To: Tao Chen <chen.dylane@linux.dev>, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250919034816.1287280-1-chen.dylane@linux.dev>
 <20250919034816.1287280-2-chen.dylane@linux.dev>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20250919034816.1287280-2-chen.dylane@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2025-09-19 11:48 UTC+0800 ~ Tao Chen <chen.dylane@linux.dev>
> The return value ret pointer is pointing opts_copy, but opts_copy
> gets freed in get_delegate_value before return, fix this by free
> the mntent->mnt_opts strdup memory after show delegate value.
> 
> Fixes: 2d812311c2b2 ("bpftool: Add bpf_token show")
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>


Reviewed-by: Quentin Monnet <qmo@kernel.org>

Thank you!

