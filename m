Return-Path: <bpf+bounces-51635-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A3DA36B78
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 03:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2E493B25E7
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 02:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B7E146D57;
	Sat, 15 Feb 2025 02:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ngq2Cjk0"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C3C1078F
	for <bpf@vger.kernel.org>; Sat, 15 Feb 2025 02:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739587171; cv=none; b=eVeIHp4JbXzRc5sTy1hkdWenimJjGKFdughMqDbFAZDuX19fxfpZDpk6IjEbQ6SbxBCf6rSm1rHgAn7hBi6QUzXnirkg/iXekN70SvE133CG8NS54+OtfWhVs4fj7T+uDjaLnk+ZF3rtcibGewwnR7YrTDYhQP++ryWZEmIL8ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739587171; c=relaxed/simple;
	bh=PRSzxunal1ITQFP6OQ8WURsSphZ0eJAA2ZvAwE8E2ug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hn8eHR4cFIdsM5SS/xvbb+dgs805bkuTdlmd6NIieqrIck1KcBo9B8Hba5tR/BLNBP4sUbSgxrb/Dj1Z2ibr2234oOfd8BTAXKfHi+3uHpALlCZkiBSdRojbqLyNcUMDy2YCZ9xUOEio8yn12uPnvBZyo+k1ukS8jsi3/YDONiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ngq2Cjk0; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d7e21933-cd3b-43a2-9678-4f0e592ec87a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739587166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NbHmdbolauoHSWeTkAMTQwQrllAhAEGsRt2pwbxLJBk=;
	b=ngq2Cjk0aEXum0U2E7t9HnvFzsJtLtQDoDnqAZlbKCNeOARfdQya8I4Z+ZQ8biMgTMCcnP
	dSMEv0FXvZH/VhtCq9JbBQuDiS1FPVzQLmzZ3Cdrd4Nltt6GJFv4pVocpq2ES9xO5ZV2rw
	UiqOv0Ev72S2VoiZgF852ZIV283U3Q0=
Date: Fri, 14 Feb 2025 18:39:18 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 2/3] bpf: add TCP_BPF_RTO_MAX for bpf_setsockopt
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Stanislav Fomichev <stfomichev@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 horms@kernel.org, ncardwell@google.com, kuniyu@amazon.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20250213004355.38918-1-kerneljasonxing@gmail.com>
 <20250213004355.38918-3-kerneljasonxing@gmail.com>
 <Z66DL7uda3fwNQfH@mini-arch>
 <CAL+tcoATv6HX5G6wOrquGyyj8C7bFgRZNnWBwnPTKD1gb4ZD=g@mail.gmail.com>
 <039bfa0d-3d61-488e-9205-bef39499db6e@linux.dev>
 <CAL+tcoBAv5QuGeiGYUakhxBwVEsut7Gaa-96YOH03h57jtTVaQ@mail.gmail.com>
 <86453e67-d5dc-4565-bdd6-6383273ed819@linux.dev>
 <CAL+tcoApvV0vyiTKdaMWMp8F=ZWSodUg0zD+eq_F6kp=oh=hmA@mail.gmail.com>
 <b3f30f7d-e0c3-4064-b27e-6e9a18b90076@linux.dev>
 <CAL+tcoB2EO_FJis4wp7WkMdEZQyftwuG2X6z0UrJEFaYnSocNg@mail.gmail.com>
 <3dab11ad-5cba-486f-a429-575433a719dc@linux.dev>
 <CAL+tcoAhQTMBxC=qZO0NpiqRCdfGEkD7iWxSg7Odfs4eO7N_JQ@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAL+tcoAhQTMBxC=qZO0NpiqRCdfGEkD7iWxSg7Odfs4eO7N_JQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/14/25 3:53 PM, Jason Xing wrote:
> Another related topic about rto min test, do you think it's necessary
> to add TCP_BPF_RTO_MIN into the setget_sockopt test?

hmm... not sure why it is related to the existing TCP_BPF_RTO_MIN.
I thought this patch is adding the new TCP_RTO_MAX_MS...

or you want to say, while adding a TCP_RTO_MAX_MS test, add a test for the 
existing TCP_BPF_RTO_MIN also because it is missing in the setget_sockopt?
iirc, I added setget_sockopt.c to test a patch that reuses the kernel 
do_*_{set,get}sockopt. Thus, it assumes the optname supports both set and get. 
TCP_BPF_RTO_MIN does not support get, so I suspect setget_sockopt will not be a 
good fit. They are unrelated, so I would leave it out of your patch for now.

