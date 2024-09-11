Return-Path: <bpf+bounces-39613-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D3497556A
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 16:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7FAF28AAFC
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 14:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8CC11A01C6;
	Wed, 11 Sep 2024 14:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FxtKS0sr"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C0B19E975
	for <bpf@vger.kernel.org>; Wed, 11 Sep 2024 14:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726065018; cv=none; b=AClyInpTJWEVeQBugP2w/Kuavcw/lpjZM2kqdW31aX0ly3SjSxn1y93Y9DIGkukf8VdP8kVUSfhR/tkWdhTOXYDF2z/dh2tvDheQxaggYlrzlQxdNZU1V4ARGN2/4rqGZQCrMzGifC+mDWWcQsHwobNPmbkP/j/0PoWuhpBMFew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726065018; c=relaxed/simple;
	bh=+4QjCpeX0EhllRn14vr83aEVRvHtUQfIDSzhS0yYi8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ph2HXnTeifDBvb3BxWVpL+1pFl62QX0+av3/7Ng5y+/QEm27PYWZZhDsDINKOadLFKIrRscRxTqnDuShhy3wBDT12WCJ7wSk9Jw1DTu6surRxNZD0sCYFWI321V/54p6bPVT7ZZA/EKofk0VHh9MVaCQ0jyCOnD3I6k7IFj8mzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FxtKS0sr; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <eb09643f-0be7-476c-bc9c-067fc38d3637@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726065012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+4QjCpeX0EhllRn14vr83aEVRvHtUQfIDSzhS0yYi8I=;
	b=FxtKS0sr0yc9OhkwnHuZxKYmQ370j73xH+WrWnSvy+soFiGICdq4u23Qwb7UK+fOIdB0Jv
	nif4mmdPUeG36TklXpv/d0xOxHJE1gs1q23adTsNLogG+goMDPBUQ2/i5OYlpHu9XkX/bd
	9LcJGNMaD8unTpnzj1z3qOXjJ3PhQ1I=
Date: Wed, 11 Sep 2024 07:30:04 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] docs/bpf: Add constant values for linkages
Content-Language: en-GB
To: Will Hawkins <hawkinsw@obs.cr>, bpf@vger.kernel.org, bpf@ietf.org
References: <20240911055033.2084881-1-hawkinsw@obs.cr>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240911055033.2084881-1-hawkinsw@obs.cr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 9/10/24 10:50 PM, Will Hawkins wrote:
> Make the values of the symbolic constants that define the valid linkages
> for functions and variables explicit.
>
> Signed-off-by: Will Hawkins <hawkinsw@obs.cr>

LGTM. Thanks!

Acked-by: Yonghong Song <yonghong.song@linux.dev>


