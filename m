Return-Path: <bpf+bounces-63426-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DC3B074FE
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 13:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57F427A7666
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 11:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C71E28B41E;
	Wed, 16 Jul 2025 11:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DASq/s3K"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32A91B4F1F
	for <bpf@vger.kernel.org>; Wed, 16 Jul 2025 11:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752666443; cv=none; b=F4rZ+ibI7g8CO/xLdS89j0cEelWIApGw+CPbvxKX8J11Bn6AMdj90M7zBXWslZC68adODRZQBb/DUC7lEELSxdIBfueRIUhr7uyH4f/lkQfngbWzOmB6Fe6rpuiVRyI3Dmk+ZL4GZdisI8h8kcJ85K4Bas0auMqdXmJTDvViEIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752666443; c=relaxed/simple;
	bh=yDDAJEpZf+lUqfoEU0akUVtKLnubm2iRh5Qg5aVI1Jc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tmQxMxcfQA7DWvAaJ369dj71VcieLfXSlSFyKMs4LhsE/WjzYDfJzzk1mHUlwaCHbsnZitAZoc6vBJn9cFL2d/j6Xk6e+8eeCw62kIm+tYkehJRQupVruhLsVRHNuZyrXtq7ZMf2aFNnsfY4pXFKPOU4yxwg8cpxxZQ7WoskzQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DASq/s3K; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752666433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wiod6XbhM/QrU3bpL3n3j3qQ4Gej0nHSyPhBljvPbrI=;
	b=DASq/s3KZdpoixfH0oN++ixavr4/BgpnyqylFzFDQUMHIma/Qwsnxnmh9mG+ugX/0q0YP0
	qdShpcD7pQ/oaf8s59z4U1cAy/HAGQ6gotrN9WjQVMyKPYIFdMb2Uq0q0Y0HqnRTHBdadQ
	BI4IwKkbfcr53Q5wsFIwtxuU5JltC0w=
From: Menglong Dong <menglong.dong@linux.dev>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Menglong Dong <menglong8.dong@gmail.com>, alexei.starovoitov@gmail.com,
 rostedt@goodmis.org, jolsa@kernel.org, bpf@vger.kernel.org,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH bpf-next v2 15/18] libbpf: add skip_invalid and attach_tracing for
 tracing_multi
Date: Wed, 16 Jul 2025 19:46:05 +0800
Message-ID: <3937006.kQq0lBPeGt@7940hx>
In-Reply-To:
 <CAEf4BzY4RaB5n1k7-O5XtCAOc9Rq=sYS1zLt_mDLih=4ypvb7g@mail.gmail.com>
References:
 <20250703121521.1874196-1-dongml2@chinatelecom.cn>
 <21970a1e-dcda-4c23-af84-553419007a38@linux.dev>
 <CAEf4BzY4RaB5n1k7-O5XtCAOc9Rq=sYS1zLt_mDLih=4ypvb7g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Migadu-Flow: FLOW_OUT

On Wednesday, July 16, 2025 1:23 AM Andrii Nakryiko <andrii.nakryiko@gmail.com> write:
[......]
> 
> The right answer here is you need to know what's attachable and what's
> not, instead of just ignoring attachment failures somewhere deep
> inside libbpf API. Filter and check before you try to attach. There is
> /sys/kernel/tracing/available_filter_functions and some similar
> blacklist file, consult that, filter out stuff that's not attachable.
> 
> We won't be adding libbpf APIs just to make some selftests easier to
> write by being sloppy.
> 
> >
> > This should be a common use case. And let me do more research to see if
> > we can do such filter out of the libbpf.
> 
> I have similar issues with retsnoop ([0]) and do just fine without
> abusing libbpf API.
> 
>   [0] https://github.com/anakryiko/retsnoop/blob/master/src/mass_attacher.c#L749

Thank you for the reference, and I think it will work to do such
filtering in the selftests.





