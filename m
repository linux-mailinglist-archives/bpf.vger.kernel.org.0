Return-Path: <bpf+bounces-67554-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9EFB4562A
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 13:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 940CF7AC353
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 11:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97E12F5484;
	Fri,  5 Sep 2025 11:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="KHzKYrYG"
X-Original-To: bpf@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0537C2D663F
	for <bpf@vger.kernel.org>; Fri,  5 Sep 2025 11:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757071203; cv=none; b=GZZmsWYCQtAuFXIM+1zp7Jn22rG8I+fBtc0ykxut7u8TXKYRNTCa4DMdDRI0VJT/VqnbMhFq+xaaYiLjgoyUuudVQzGgcuT89P2P3gDR9/o6RKs7NdNuXuyckewg6iNjX17DH82j0Acp/KU0axqoLVGcKYLvM6qTY6fjvjSqMW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757071203; c=relaxed/simple;
	bh=afsUc8PuRjeLuXlJZmnGleBbwTGv/Ox5bm7DtxcjOtE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=UOgOqzIHjrtfZBtFll9pi/XQWsh/AP6ezwFp9S3zHiO16zQ53a+OQ488woc/qUoTSkppGyB68Pfz8dX91AHwkM309VP6fYLWiWYYdcJcAd6vQPI8Qjf5Gk4DrxbdOboWZfbraw5l7Wyn9Py+45zgHJXv5PelvMgKcvb+hwBEepY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=KHzKYrYG; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1uuUTx-003VX9-AV; Fri, 05 Sep 2025 13:19:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=WF84LVkGbsTgdjp1EaQWr79paSh3G2ATCF8bfgOuj4w=; b=KHzKYrYGr7nsC+F4is/85HX8L/
	BhTGQ7uSN/EaGs7ngg2bqHfnsp6zk5BsZ4Xpq6ba0Vrf+7WCNUx7Uwgdj8GYGQdbk1nu/RsvdqmqN
	Jz55MgnLHjEBkOP/LoJ6FlM85yjOtGD2eF1jG5yuz1oufosAGkOMoysCGvy0mPppEusZmmpe6gwqY
	e9PfkK0V8vOFRsY75F+TtqKN9D5e3nzwQ/mcpOqzLn0hg0aYaS1wC6AVSLXRon6Rj9qHRXkz4PqVU
	KeUBl/WYTjFTzK/zYX67VFgirGSVFM1DmBhEzZXs5h/DVRG5ykZho6vTpZVwlkfp4RpjkCvfVo238
	VKYOmEhQ==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1uuUTw-0000fy-MQ; Fri, 05 Sep 2025 13:19:52 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uuUTr-002zcS-Nw; Fri, 05 Sep 2025 13:19:47 +0200
Message-ID: <01f6c3f5-be73-4505-8a34-212dee30b5fc@rbox.co>
Date: Fri, 5 Sep 2025 13:19:46 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH bpf-next 2/5] selftests/bpf: sockmap_redir: Fix OOB
 handling
To: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250905-redir-test-pass-drop-v1-0-9d9e43ff40df@rbox.co>
 <20250905-redir-test-pass-drop-v1-2-9d9e43ff40df@rbox.co>
Content-Language: pl-PL, en-GB
In-Reply-To: <20250905-redir-test-pass-drop-v1-2-9d9e43ff40df@rbox.co>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/5/25 13:11, Michal Luczaj wrote:
> In some test cases, OOB packets might have been left unread. Flush them out
> and introduce additional checks.
> 
> Signed-off-by: Michal Luczaj <mhal@rbox.co>

Sorry, this should also have:

Fixes: f0709263a07e ("selftests/bpf: Add selftest for sockmap/hashmap
redirection")


