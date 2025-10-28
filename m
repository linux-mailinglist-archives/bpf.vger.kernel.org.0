Return-Path: <bpf+bounces-72581-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1224C15D0A
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 17:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30025188FE53
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 16:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF46428689A;
	Tue, 28 Oct 2025 16:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="B9zf4fnZ"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CC0285CA2
	for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 16:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761668684; cv=none; b=EaX1h29QEi6ZD6tElmW99whsg4DOVOSkn+46VGFW0L+tWLHkQ9vUx2LFh8XIPHlZ6CY/5GRhbDItuF9Ll4ZnKw2yoHIE9Nnk8RzX9n4AJj+T0gaBJlYmY13XWB98UADzPR6lcNJIQJFB8vnlxCkdB5qspts221IX8rTTzxlEqYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761668684; c=relaxed/simple;
	bh=HNLCSr4FXQd/7ll40qCSdRZ4P9xFpVh1iCX5RuPBAzw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FgjNX8Luch2NBL/kws0RXE8Vki7AdBQSLsONpxenaqp9lBuO8MMIrVqnVPmlyn1DmoKNUpLZrQvssrwpEzJQuhRITMRC9GkpzVmFH39XtmxUiViuuYfo4pLhoa3A5eLE+GYGZLDF5oFZGLG8qRRLyUJk8AIDwTAbLe1Tm23zmgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=B9zf4fnZ; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <01719c2d-ddd1-4f96-8bae-40144f0410c7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761668681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HNLCSr4FXQd/7ll40qCSdRZ4P9xFpVh1iCX5RuPBAzw=;
	b=B9zf4fnZva6RF7EwZrAdUUCNqXhMYSXOaX1qOloois9lkiJH3PuoKnP4QWQOxHRMwLNGUe
	w18ht4zhn94tcAqMyhImUmdOhC/o7bpR7XjkwhLSVaR3bMZeXxs1JZnOzD7uELn7Y8IfxC
	Bo8sPxicr6CBWCud2HMDjTzvhAJ2Guk=
Date: Tue, 28 Oct 2025 09:24:32 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] libbpf: optimize the redundant code in the
 bpf_object__init_user_btf_maps() function.
Content-Language: en-GB
To: Jianyun Gao <jianyungao89@gmail.com>, linux-kernel@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>,
 "open list:BPF [LIBRARY] (libbpf)" <bpf@vger.kernel.org>
References: <20251024080802.642189-1-jianyungao89@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20251024080802.642189-1-jianyungao89@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 10/24/25 1:08 AM, Jianyun Gao wrote:
> In the elf_sec_data() function, the input parameter 'scn' will be
> evaluated. If it is NULL, then it will directly return NULL. Therefore,
> the return value of the elf_sec_data() function already takes into
> account the case where the input parameter scn is NULL. Therefore,
> subsequently, the code only needs to check whether the return value of
> the elf_sec_data() function is NULL.
>
> Signed-off-by: Jianyun Gao <jianyungao89@gmail.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


