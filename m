Return-Path: <bpf+bounces-26912-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4426C8A644B
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 08:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 752721C214CC
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 06:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7956EB6F;
	Tue, 16 Apr 2024 06:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bQI5xsD9"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703706E5E8
	for <bpf@vger.kernel.org>; Tue, 16 Apr 2024 06:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713250041; cv=none; b=heblC3soLoAV8OrHbzScxZSHgOJ9NASFN+msr1JYaeJwF/o/93ACHVTdF7cMFvmY02Mw1AibJScVxaV+sGnleV2Hy3k1+jJ79iH1DAQmKyjrMJ+623aNMdbkJyhOTsp4fLZS1DXJMPaDkp6uRC4e7Vef5H8dSFsn1nwlakvUFn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713250041; c=relaxed/simple;
	bh=KJGx9L/Y2VXsTFjWdCI2wBba8I/NOm8/O1NN/CJ6FpA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i6r2gfWp5XWU0RpX+UNFm8Vn9BqekG7V6mi8XK8mtwD6Jmz+y9LHnKscZy5EUSO9wHnMNkFiYce9bboKqAi6iJNLELOxShOKE01KWqvLsZtkqA6tdyLfo7BmapWwb19g04uQy7gZb+QJHkX2CEuaHPVf2V00Qa42KjBqhECt+5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bQI5xsD9; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3df13496-a644-4a3a-9f9b-96ccc070f2a3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713250037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KJGx9L/Y2VXsTFjWdCI2wBba8I/NOm8/O1NN/CJ6FpA=;
	b=bQI5xsD9HsnJRF1cXVgXGozf3UwBouiwrOwIuPC/+nF51wOHacDzAMnt8jZ2vyJ1B0vcmJ
	PypP1dc6ODTwK3LSuzm3SaRTIkXOH5TipzVlPU1HmOzqSnsXVtYG0TRWs9g3P2Fn5AWAHz
	AZ9JdAduCnkzfn1uxDE1as2NYlyRSkg=
Date: Mon, 15 Apr 2024 23:47:08 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 bpf-next 4/6] selftests/bpf: Add IPv4 and IPv6 sockaddr
 test cases
To: Jordan Rife <jrife@google.com>, bpf@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, Kui-Feng Lee <thinker.li@gmail.com>,
 Artem Savkov <asavkov@redhat.com>, Dave Marchevsky <davemarchevsky@fb.com>,
 Menglong Dong <imagedong@tencent.com>, Daniel Xu <dxu@dxuuu.xyz>,
 David Vernet <void@manifault.com>, Daan De Meyer <daan.j.demeyer@gmail.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
References: <20240412165230.2009746-1-jrife@google.com>
 <20240412165230.2009746-5-jrife@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20240412165230.2009746-5-jrife@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/12/24 9:52 AM, Jordan Rife wrote:
> This patch lays the groundwork for testing IPv4 and IPv6 sockaddr hooks
> and their interaction with both socket syscalls and kernel functions
> (e.g. kernel_connect, kernel_bind, etc.) and moves the test cases from
> the old-style bpf/test_sock_addr.c self test into the sock_addr
> prog_test.

Can the test_sock_addr.{c,sh} be retired after this patch?

If that is the case, please create another patch to remove them in the next respin.


