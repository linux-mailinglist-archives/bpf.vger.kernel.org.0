Return-Path: <bpf+bounces-77295-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6423CCD6E46
	for <lists+bpf@lfdr.de>; Mon, 22 Dec 2025 19:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0274F30321D7
	for <lists+bpf@lfdr.de>; Mon, 22 Dec 2025 18:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D96326948;
	Mon, 22 Dec 2025 18:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LJAp/BO7"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1BB31ED8F
	for <bpf@vger.kernel.org>; Mon, 22 Dec 2025 18:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766428131; cv=none; b=kTLpmaje0DblVXdus7+F7jlo2cMqurJU0E9xzojI0ftuVF+iRAhFyF1TMSJivGHGynen9U+n9wYWMMXdlA7QvFrGt2KGLGQ205W5lD+ME2fIeXe+w/4vt9tUZY88yt15EfEIqztJJiT/s9LOXznqZ45TNA/uTu9MaWw7qJFO4Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766428131; c=relaxed/simple;
	bh=asmLFeZXzVOBTgZXT1lN6vKdiWrrVIS9v0v5m+NjrQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MFIDykGe4hgfjbUEFfHXTg7u6xQ/hA8Sden9iJSNIsDlbIdkHjCrt7cLNB2bIPuyXW2kdT2QPvYtZ5aIl8cduki3XrfIYFlDY1mxKT3s7aRYnwMzC9UHslbYrGp8e/5em5Q7kRFh9ErR8rXxNDCqgfk3OW+f1F3xnCJ6LhAHkoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LJAp/BO7; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <cdde31c9-04c1-4d46-bb09-c36c23ec40c2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766428127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=asmLFeZXzVOBTgZXT1lN6vKdiWrrVIS9v0v5m+NjrQg=;
	b=LJAp/BO7Ei1QVhaizthVy/Bq0C8EI26jQw+0C45ZLmKmbQFdscOZnssNdeviiDu0LPQFmb
	slLoctruA7lGUHJC7O8bufMU3kGD+FOU0JkFHk9MdLv6RH5pQth8mDRf+rwS0XRg8si9wH
	AxoBYoQWFs32dWLtcpyTg7GQIiXWSwI=
Date: Mon, 22 Dec 2025 10:28:28 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/2] bpf: allow calling kfuncs from raw_tp
 programs
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay12@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, kernel-team@meta.com
References: <20251222133250.1890587-1-puranjay@kernel.org>
 <20251222133250.1890587-2-puranjay@kernel.org>
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20251222133250.1890587-2-puranjay@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 12/22/25 5:32 AM, Puranjay Mohan wrote:
> Associate raw tracepoint program type with the kfunc tracing hook. This
> allows calling kfuncs from raw_tp programs.
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


