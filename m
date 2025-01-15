Return-Path: <bpf+bounces-48995-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C729A12EF2
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 00:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98A6716282E
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 23:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B931DC759;
	Wed, 15 Jan 2025 23:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mxqV2Thi"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6EF1DC198;
	Wed, 15 Jan 2025 23:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736982138; cv=none; b=okAKYNsDVXCVYjuKaedyRhZFx9afmkIJ4nw9STxMDYK/4kKOI1ZoOmBlGBOawO+LyDhxRiXXNpyALmnjpDfaK9+6nShQFsqQOwnNuuAI5YkBo0iOl2z12+KkrDi2AixFWnXbzFV4cqer+ONqn/JByqQDAYUqnnwa24P8tky0tG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736982138; c=relaxed/simple;
	bh=DacBAuD4fjRczrTS96ULO7JHfdlZ+fv4ZPHrtaJZ4No=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PD/V7UurZoLVxbZ+E4wg3JMMKnwJOeuIE00VFPTM99klXTsZzNzMgFIfwgm5evF2RAIbMERt+hHlLVZB+SuPzf7dV/+mMSJSmyxU5oB1hYj3WAYGNn6M/wX/yyqrb5b7ekwHdjfbOlr/mxF4CDHuMnjf/zP5lQmdBlK/mdYO0cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mxqV2Thi; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <680677c2-563a-43f5-b3e5-f2442f154a61@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736982134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OPgJFv7CZ4lWok7pbtc/HVrkUKiExFsgi7ANFc/6t+M=;
	b=mxqV2ThiiG2/1rz0keHof5SetnV5G/xHl2wS4k23A3O6G+6zVhWHx9IhXURGSFWCYsHQM5
	zFSAF36oUmIHjgJyqejOTiXlLbUrVKnUZgeHY1cTiru8MPbEI3cXpS5CN4HFWAsRKnWTvj
	U4ruxRHW3/QXAUyLsb2ulx2PFM2EXvE=
Date: Wed, 15 Jan 2025 15:02:07 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v5 09/15] net-timestamp: support SCM_TSTAMP_ACK
 for bpf extension
To: Jason Xing <kerneljasonxing@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
 willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org
References: <20250112113748.73504-1-kerneljasonxing@gmail.com>
 <20250112113748.73504-10-kerneljasonxing@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20250112113748.73504-10-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/12/25 3:37 AM, Jason Xing wrote:
> Handle the ACK timestamp case. Actually testing SKBTX_BPF flag
> can work, but we need to Introduce a new txstamp_ack_bpf to avoid
> cache line misses in tcp_ack_tstamp(). To be more specific, in most
> cases, normal flows would not access skb_shinfo as txstamp_ack
> is zero, so that this function won't appear in the hot spot lists.
> Introducing a new member txstamp_ack_bpf works similarly.

This change and some of the earlier changes (e.g. adding SKBTX_BPF) will need an 
ack from netdev.


