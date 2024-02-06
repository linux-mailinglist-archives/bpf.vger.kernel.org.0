Return-Path: <bpf+bounces-21352-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A79184BA14
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 16:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17C8B284879
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 15:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9B51339A8;
	Tue,  6 Feb 2024 15:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="trFYHg7c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mfrFbvzQ"
X-Original-To: bpf@vger.kernel.org
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7836133417
	for <bpf@vger.kernel.org>; Tue,  6 Feb 2024 15:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707234489; cv=none; b=prsQPLyQCcitT/J87ZTy+oQ6NDW5qoqXKjPwKNf/q8AI7oWe+DkUHY/tTT7HK4L2AkMsQUt3SCooXnArKYkOBQQgio19WyBD4XSKQY9Edf8W6qTq24TxtA/SGwEhCREL6Xrgab7hjBv0GC71Ed5OOzmkc2w/Ovitn6agkD4kRVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707234489; c=relaxed/simple;
	bh=PxOlhuGka41fcij7p6lLUbT5zBQsh5slkMfDcuR4rPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pLOOe3j5mRbfigj/1stSHqrwxZbK9lT6aoK3lUrgNnEWqCFLKQ3UZHfCqJVFZJQSbVFfx3yXpXaRL07IVM2sztU0UlD0HWroRzdEAFSrCPlYByReTc630QEOECaKRwbGaD7VySX6fh8AoXRnFqr/T2zDd+Qgc4+uDP/5N/1iB4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=trFYHg7c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mfrFbvzQ; arc=none smtp.client-ip=66.111.4.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id C6EDD5C017F;
	Tue,  6 Feb 2024 10:48:06 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 06 Feb 2024 10:48:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1707234486; x=1707320886; bh=935MLtA+pU
	RKMb7vm/rzhNOzs3AQhY2R+3DJf+WvlCM=; b=trFYHg7c1caF3yC3vuJzzqRVLj
	xmhPUiBdJI4rzyKyU9NqTZ/RGIDZe3i46F8jJfX9INOzvZqoVZvlA7aTx5tKDQmA
	/vpDsPUhjEj62klxAtt7guMWKrDDQXa6jffi4GdLbcS4HdkO74rYNxocNFNA2lMX
	kCfGdttqwzSpTnOUEfzPY7hFjwIZr8P54q0UuNina5bNUOf0mSA6PDPCPMgNrZHB
	9MlqPTH5NVTemyQPgvQO18WRTKMLRBtbogcJQi0KXhWGUO9EzdkQpdfmrLFwlJCI
	Q0vlq5n3el7BTKQU5xZ+0ydnQhUxpx0Dk4PV/nuXhplQ5eM2a8VnINPeHMHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707234486; x=1707320886; bh=935MLtA+pURKMb7vm/rzhNOzs3AQ
	hY2R+3DJf+WvlCM=; b=mfrFbvzQV6earsixEQgTRHi25UgJ5GLslB5yW0sIMhdX
	cVdHg6KcvSd69VoUQ+SxqHSCu3ShhIDQ/L55o4/l/23jb/a6zX1NjZNY5zWw/vRH
	BskYCS5ocDQPT2x0w+X7hLjuy6dBk3kkRXJKOkVWR6lmSPizA1SF20Fpt97UNOFg
	k3j4HBjhxumATs/fNPGn/LmWr71TSJByYbZ47sSYm6AyXVSOrMSpt+ZpDmmx0geF
	+LrfdK2LoEPxvxq9h0LbIQgqxKUiBa7Jgtubgqa8RUj1AmzHhbL3cT06eSZvgC4u
	2wnt3ABK0D+mhSW5pcjMdw1NkiBzaZ0JnHjLAYim6g==
X-ME-Sender: <xms:tlTCZYKsFGeqCuKVil0laAQ5j_I0LvLoOd3jyRBBlC7e75AfQBZqdQ>
    <xme:tlTCZYJbmIIkDOlGI5lwxhL37EmhmZIt1G7Hft1ITCY1Yh8Sxah3o8ug-lqi8Q_QH
    LzoUALFLScYyN4Kmg>
X-ME-Received: <xmr:tlTCZYsaTozDqO8PcOcQtNnJNNjOzsQcQexnpI7TdtLHvcGwS1or8h2z2WkgPKBkZFtWnFWASf5KOaImFMwxrKW9XlO5oAA3LcNgN6k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtddtgdehtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculddvfedmnecujfgurhepfffhvfevuffkfhggtggujgesthdtsfdttddt
    vdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqeenuc
    ggtffrrghtthgvrhhnpefgleetueetkeegieekheethfffleetkeeiiefgueffhedvveei
    teehkeffgeduveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiih
    ii
X-ME-Proxy: <xmx:tlTCZVabITB27HIBZwQ9o7qQmhdu3EQQHz3KN2uc0xxXwg6jPTkBsA>
    <xmx:tlTCZfYrarPjO6jU8k8ebhf2_hTM69fdc_S3GMGm35aFLHNX85wWPg>
    <xmx:tlTCZRBYYiMmFeeyBAndZP7t1n831GC31IEV9JOvSFLlvAbgZlPB5A>
    <xmx:tlTCZQKgIcX8vxO_K6-nHVDKrn59X39RiameEHIUHPhICDG9VndF5Q>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Feb 2024 10:48:05 -0500 (EST)
Date: Tue, 6 Feb 2024 08:48:03 -0700
From: Daniel Xu <dxu@dxuuu.xyz>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com, haoluo@google.com, 
	jolsa@kernel.org, tj@kernel.org, void@manifault.com, bpf@vger.kernel.org, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: Re: [PATCH v6 bpf-next 4/5] selftests/bpf: Mark cpumask kfunc
 declarations as __weak
Message-ID: <azki6pjel4kiiiaooifbfi5xurst3v5r6c6f4ntwf7zavwzme2@j5sso24qntsf>
References: <20240206081416.26242-1-laoar.shao@gmail.com>
 <20240206081416.26242-5-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206081416.26242-5-laoar.shao@gmail.com>

On Tue, Feb 06, 2024 at 04:14:15PM +0800, Yafang Shao wrote:
> After the series "Annotate kfuncs in .BTF_ids section"[0], kfuncs can be
> generated from bpftool. Let's mark the existing cpumask kfunc declarations
> __weak so they don't conflict with definitions that will eventually come
> from vmlinux.h.
> 
> [0]. https://lore.kernel.org/all/cover.1706491398.git.dxu@dxuuu.xyz
> 
> Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Cc: Daniel Xu <dxu@dxuuu.xyz>
> ---
>  .../selftests/bpf/progs/cpumask_common.h      | 57 ++++++++++---------
>  1 file changed, 29 insertions(+), 28 deletions(-)

Thanks!

Acked-by: Daniel Xu <dxu@dxuuu.xyz>

[..]

