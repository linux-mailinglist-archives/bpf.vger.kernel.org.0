Return-Path: <bpf+bounces-74969-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC24C69A85
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 14:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 9EE962B829
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 13:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9013313525;
	Tue, 18 Nov 2025 13:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YOpIZ3S5"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8C31A5B8B
	for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 13:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763473526; cv=none; b=HetmQ4ED3NIEmWIyFhsz/Ip7kEHlUMpBltciEfnffUjtu85kzOs/5xrVLSyTR31rKbNYEKNkAxVyeU6i/yNSVWZNYN9sGK1/7luTCbTyKThqLPs3WsIcCR5OXBb138VU8Qj6qJ6InN+MohOKAl0P++mL7ja21RESpsXHonaF5XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763473526; c=relaxed/simple;
	bh=w1mWsjOcrsPhjc4R8mAA3gTC71UH37uVKrh/Ni8utEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=X4EJNkaiwZbzl6mQc+2O+IGCyAZxE18+WXCApZv/xESeIc622OGRT6nFkEKcj0LcfSavOrtUkYCXx+gopWrC22s2XVLoT36NDcosFHEypTov0S5uwzNjYMfvYN+d5K1cEwdVuZv1/CSRCD0KW4MTSqGB79trVLGQNd0g6KpsRtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YOpIZ3S5; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <dd3d34a0-c5e9-44f0-a813-c972e91b8eb0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763473512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QGKPQF0y5A/yl97OC4p5pS+sRK08oluFnC6kWkR5B3I=;
	b=YOpIZ3S5q0kbPjioWTGJBBU9szS/gtDM082eqwDEsrAeoT1hpU+PzzHC0TiOTxS0XaoC+9
	HBm2yLdFIaNxEXXDwD+tBAlTDey2widJ83jEHb8BIsmJ6yB2qoGaHQrQeHTzJgtyZZDqvE
	u4i3ZQ5gstOPQugl6pX0Xc9Gg+qinPI=
Date: Tue, 18 Nov 2025 13:45:09 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/4] selftests/bpf: Add tests for SHA hash kfuncs
To: Daniel Hodges <git@danielhodges.dev>, Andrii Nakryiko
 <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:BPF [SELFTESTS] (Test Runners & Infrastructure)"
 <bpf@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
References: <20251117211413.1394-1-git@danielhodges.dev>
 <20251117211413.1394-3-git@danielhodges.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20251117211413.1394-3-git@danielhodges.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 17/11/2025 21:13, Daniel Hodges wrote:
> Add selftests to validate the SHA-256, SHA-384, and SHA-512 hash kfuncs
> introduced in the BPF crypto subsystem. The tests verify both correct
> functionality and proper error handling.
> 
> Test Data:
> All tests use the well-known NIST test vector input "abc" and validate
> against the standardized expected outputs for each algorithm. This ensures
> the BPF kfunc wrappers correctly delegate to the kernel crypto library.
> 
> Signed-off-by: Daniel Hodges <git@danielhodges.dev>

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

