Return-Path: <bpf+bounces-63093-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD52B0268F
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 23:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D29187BCB5D
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 21:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D9A21C18E;
	Fri, 11 Jul 2025 21:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CPeBve69"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C973155389
	for <bpf@vger.kernel.org>; Fri, 11 Jul 2025 21:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752270927; cv=none; b=u8xAew/aKqlAW4qnvJxXfoD0eZ+S+4RQq7wGOOE2EuOqnJ0NOQgrnHIU3B8aP8WcVF61Z36QDwrtji5x3RDcfwaOIL6R01a4SSu/yLPOeeabu2dwnQke5MpxkVDKH2yxKMGh4cY47DBx4mu5HZO3670Z5QcUMiemHZIwiGgdERI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752270927; c=relaxed/simple;
	bh=uliHomY+cYepLuBfXuWwYdF74RiVKAx2zeLcC+oRaD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nLNdCeK6TXVgzNSVmSwBZoXSprqR5a/PtFKQlLGCGXxGCDt+jbrF12f3QaJX+Vc4tJ/z6eB4+oi8aNxLKNv/qnAin7bR4Qsucf8UklbCV0or44M8+iSgZekXoYxpQIme9euvwb9hZUNlA8R1cz/sx3VYKIoB+VDecQmHFy2h8bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CPeBve69; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <28afe230-8b65-40c9-910c-a2cd339ca785@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752270922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uliHomY+cYepLuBfXuWwYdF74RiVKAx2zeLcC+oRaD4=;
	b=CPeBve69O8dyMPu6OpMtNX6QfNOUMf+c9PMaS/2YtKmGwvt93QorEd+RAMAI4QhGXgFYe+
	4SBHkhz5/QrJeBAScYbXpD18hxgGNs5oe4s9rZxYOI1TOFDqAdrQd4pgOC/7YcZ1NJF3Mo
	VD/UldtHtdoe2tgLYgGs4qXTbLs922c=
Date: Fri, 11 Jul 2025 14:55:17 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC bpf-next v1 2/4] bpf: Support cookie for linked-based
 struct_ops attachment
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Amery Hung <ameryhung@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Tejun Heo <tj@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>,
 Kernel Team <kernel-team@meta.com>, bpf <bpf@vger.kernel.org>
References: <20250708230825.4159486-1-ameryhung@gmail.com>
 <20250708230825.4159486-3-ameryhung@gmail.com>
 <68f4b77c-3265-489e-9190-0333ed54b697@linux.dev>
 <CAMB2axO3Ma7jYa00fbSzB8ZFZyekS13BNJ87rsTfbfcSZhpc6w@mail.gmail.com>
 <2d1b45f3-3bde-415d-8568-eb4c2a7dd219@linux.dev>
 <CAMB2axMDUr+s+f9K-4sj-5vSkPQV4RXHo8y73VH9V2JQbKZOxQ@mail.gmail.com>
 <CAEf4BzaUK0i7QFkKi800TQhAKw2WL+FyoG3eFP6nq_r-TUPBKw@mail.gmail.com>
 <CAMB2axONnVJ5BY-YOASWGUGpaZa-P64Yf5f6AbX+O8fjCiZNfw@mail.gmail.com>
 <CAADnVQJxu5hsDw0iCP68eRW3v2CXRBos8asfN1x9F=gVyGmqbw@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAADnVQJxu5hsDw0iCP68eRW3v2CXRBos8asfN1x9F=gVyGmqbw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/11/25 1:21 PM, Alexei Starovoitov wrote:
> Can we put cookie into map_extra during st_ops map creation time and
> later copy it into actual cookie place in a trampoline?

+1. good idea. This should do.

