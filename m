Return-Path: <bpf+bounces-51881-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BECEA3AC9C
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 00:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62F9B188AC81
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 23:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32BB81DDC1D;
	Tue, 18 Feb 2025 23:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tnXpOafl"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9572A1D61B1
	for <bpf@vger.kernel.org>; Tue, 18 Feb 2025 23:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739921909; cv=none; b=aNmTGM+xA1PF1Vogytu8DSE7st1mvPqREnudlZGw6C7rQnf1La938aNJt/YofeR/TgdlpeodBMo3vPrL8amEYY2JDcwAkOSE9XsKlZCwXd8IMP5UT1zeE4OX02fkFrKDQbC2GCtmLUTbvEztjAXKDnWZ0+BfwFZmnxdDg6t1wiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739921909; c=relaxed/simple;
	bh=54FVSRGcC2rsBfqo3QsjOLWTLAJZC/VditjcootSkbY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I5ZvlZe1ZgFmhlLk6BSNeIa1vNAaFoUGrITesfKVqrOFU/NJYB9NjnCNOZ07/b1OB1QdMHJx8NK2BoI7CEc22R5bqyCL6DvV+Ia2Wpj539uXLGXHEoM3HRPI5YNNQkDMpfGsPB5W7/K3rwyK96MJgMxuYjfgAiDVJfuGOr4v0sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tnXpOafl; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4dc10429-29dd-47bb-bd5f-6a8654ed2fec@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739921904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=54FVSRGcC2rsBfqo3QsjOLWTLAJZC/VditjcootSkbY=;
	b=tnXpOaflyyC9voJnYySLhiqkXORPjFW742YwlsbnkOM2als1VylXMMl5xLhvDj+qgk9EQ0
	rb+qEdChd6aFUC6CoPyyLNK1bKV4WigoiDmWU+FkWQpAVxw9kOHi1i+Qeon5E+Coi9ox3u
	8FFWh+m4QZ9rt+54/70O4cIC7Zq19io=
Date: Tue, 18 Feb 2025 15:38:17 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/3] tcp: add TCP_RTO_MAX_MIN_SEC definition
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, kuniyu@amazon.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 ykolal@fb.com, bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20250217034245.11063-1-kerneljasonxing@gmail.com>
 <20250217034245.11063-2-kerneljasonxing@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250217034245.11063-2-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/16/25 7:42 PM, Jason Xing wrote:
> Add minimum value definition as the lower bound of RTO MAX
> set by users. No functional changes here.

If it is no-op, why it is needed? The commit message didn't explain it either.
I also cannot guess how patch 2 depends on patch 1.

pw-bot: cr

