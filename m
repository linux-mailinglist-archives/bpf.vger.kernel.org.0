Return-Path: <bpf+bounces-57558-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7172AACDF1
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 21:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC81C1C21270
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 19:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97AC51DF723;
	Tue,  6 May 2025 19:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bGbRqFfD"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791ED3595E
	for <bpf@vger.kernel.org>; Tue,  6 May 2025 19:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746559189; cv=none; b=R+7KwzWicDe5+gsp8XCCJezXMfjRxDX78o6L7EU+xSjHMAMe1BT3egt1egvtFQi3NjoJMK766h53CXdOgaC48/W8y4lCDxs8Hko9z2svOSiGqvn/tOmM7kjr+Bu35qUlHpnrIxdON89462+bTy//4U4F49nDnOy+/JocwlWzmc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746559189; c=relaxed/simple;
	bh=O4iUXLWrZXZck8vlO/L6Vrt4ipaBA7stezc8WKyzAHc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PpvFC0RJvEjU7XliwOiGKET8p0cTvdUEXrF24QNKtmydRBecNh3u9757Em9B6v7yTYZoivTQPlDtHXn1v2kAnvs505Jm6J/MnLryZuF7axMjo2im1mKDuHXCUxUdrukZyR+FRHEoJH+ShaXmn6AcYs7g4yposZxmTPphUvrXcBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bGbRqFfD; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <bbe5b4db-0c32-4695-9f2b-ebc042c040cd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746559185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rGGM4QzihND7W8iisc3MSKWoS/VAPC5ZZRQIJ+BalY8=;
	b=bGbRqFfDP/IV+uIomjlLc3wNt8hMA3cxt3tC//iH+nitmlI3MLOPKRTuK/N1LaK0yPrNT1
	1XhS7y1AOBaMyf7aMdzU4L95m+BlSh/Fw0XbnJYmntghVl0FgfQXULcmwHDTbXdVxb2vn0
	P4oxbIi5LkbHre48Y3mWpwUKcsBozf8=
Date: Tue, 6 May 2025 12:19:41 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v2 2/2] bpf: Clarify handling of mark and tstamp by
 redirect_peer
To: Paul Chaignon <paul.chaignon@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 bpf@vger.kernel.org, Network Development <netdev@vger.kernel.org>
References: <1728ead5e0fe45e7a6542c36bd4e3ca07a73b7d6.1746460653.git.paul.chaignon@gmail.com>
 <ccc86af26d43c5c0b776bcba2601b7479c0d46d0.1746460653.git.paul.chaignon@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <ccc86af26d43c5c0b776bcba2601b7479c0d46d0.1746460653.git.paul.chaignon@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/5/25 12:58 PM, Paul Chaignon wrote:
> When switching network namespaces with the bpf_redirect_peer helper, the
> skb->mark and skb->tstamp fields are not zeroed out like they can be on
> a typical netns switch. This patch clarifies that in the helper
> description.
> 
> Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>

Jakub, could you help to land them to the net tree? Thanks.

Acked-by: Martin KaFai Lau <martin.lau@kernel.org>


