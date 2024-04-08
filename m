Return-Path: <bpf+bounces-26198-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A05BA89C912
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 17:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 536C2286DBD
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 15:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF251422C5;
	Mon,  8 Apr 2024 15:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ATM3KCev"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C000322091
	for <bpf@vger.kernel.org>; Mon,  8 Apr 2024 15:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712591718; cv=none; b=Zra/aNluf9G5wp/f9b9FzDd9UfvmZp/HzPaOHL/ggJYiLnDJoNWz+JSnaRaisN0l1qc1WA/O5V+xviwe3y11h0q2rRiHd68bGf/xcYTajauiuS8ObeBNtkAjZ8LKodyQzpVQrLwlX0W+70UqRzveolRbXSHsiViGrjgiXFg5CnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712591718; c=relaxed/simple;
	bh=hE817CDdKg+SxH2QMPBR35McYv5Tljp1R3u9MzigeBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jsd/2x0eKF1I8FKdA8CqFYLQawkjJMOcUgt2qYVGN8d4WS83GUtKUPD/T9/oU5tVzWCcXw3N0HkjNv4Zzj7abU4X0zjhZZEutogTiJKrFsrbpWAU1V/of+cF2VOaSVmPtZNjiTxA/EePVry4mvcKdlxvOP6BsFlIdL0imFnSykg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ATM3KCev; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5ee0db00-0895-448a-aa62-c5c9f6a3f5f4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712591714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hE817CDdKg+SxH2QMPBR35McYv5Tljp1R3u9MzigeBQ=;
	b=ATM3KCevoHmmre2IztwZOXdXCKD9HWVHAPNDZkvxNwe5+l6Cd50ZD8FUOhh1yCqbMY2dMq
	DxLnFmhGSXmY2FSg2wPbRpQukfq4MxvzhYfZH3EC1dQ4kvbtHx38taRFWdA01d6eXlZaKf
	3LjTBxcM4y/751iTolO+pRLeGwQI+7w=
Date: Mon, 8 Apr 2024 08:55:08 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 1/2] selftests/bpf: Add F_SETFL for fcntl in
 test_sockmap
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Jakub Sitnicki <jakub@cloudflare.com>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, bpf@vger.kernel.org,
 mptcp@lists.linux.dev
References: <cover.1712539403.git.tanggeliang@kylinos.cn>
 <2f9f84be1366ca68b1123dd2f3fd06034e1bd3a4.1712539403.git.tanggeliang@kylinos.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <2f9f84be1366ca68b1123dd2f3fd06034e1bd3a4.1712539403.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 4/7/24 6:36 PM, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> Incorrect arguments are passed to fcntl() in test_sockmap.c when invoking
> it to set file status flags. If O_NONBLOCK is used as 2nd argument and
> passed into fcntl, -EINVAL will be returned (See do_fcntl() in fs/fcntl.c).
> The correct approach is to use F_SETFL as 2nd argument, and O_NONBLOCK as
> 3rd one.
>
> In nonblock mode, if EWOULDBLOCK is received, continue receiving, otherwise
> some subtests of test_sockmap will fail.
>
> Fixes: 16962b2404ac ("bpf: sockmap, add selftests")
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


