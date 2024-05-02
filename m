Return-Path: <bpf+bounces-28417-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 953968B92DC
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 02:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5DB91C2142D
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 00:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE99C8CE;
	Thu,  2 May 2024 00:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hWf6D9aj"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A8B12E40;
	Thu,  2 May 2024 00:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714610351; cv=none; b=OpQ/JF6CT+Qu38s6YJrduPqKwxNJfRTxRI1n7NtQeOZnK8TUcCsZDHwWlc2L8o9VRL3JI5MC5n4CyGI6gDz5B5v2pfvhPbO0rhAM9BtNfJ20SMJzFLcMIoqsjHa+gUU4SYjZ/TX5+WY4sHMkgssgxLGq9q0TncXv7WV7YVNoZ7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714610351; c=relaxed/simple;
	bh=Z9VX1f1FC95GMs7ZfpvcoQfILXoK5owTzy1b0L6NINA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VQRzYCS+9JDIoRhFJHi2KefCEySF10KnyruQKPD9GlNQMPmd7xc107tndsmANIiBCqHsL8Pcnmp7KM/t2Ty4lRNHRW21mbWRqiYKt6+hcLp6im+hNo4rWMw0QcBI/BDJtwukSU+ElU6AlU+YvZPYdvK9hg5X3CpR92wDNo+pxiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hWf6D9aj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA81AC072AA;
	Thu,  2 May 2024 00:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714610351;
	bh=Z9VX1f1FC95GMs7ZfpvcoQfILXoK5owTzy1b0L6NINA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hWf6D9aj3JEwmqdjyhZg++cqIJqbk9FeDJxgkwhqsD+O91/wewmFEjy2PAlyBHeIC
	 roo6VnRY8tD0goY8Py8JIM2EwANm9Dv/b7g2DlgBf2LROAC99SlMOZJPHXi3F1FxGt
	 bRxnM5lhfnmc4rRrgot8Y9LfRpQoRcLAFjekTzuKgNiOAYdMw1CNkIMlY7W1WkcUBq
	 XdHY52Mv88KlQTGA1vUqAyl4sq0uxTZfMiEg0LISG5XYTEw42HHSsL416ixfM4msTy
	 PixK79X90PMKC/9voqQIFMnEryfC/Ch4NgHGiCB05iw9a8GRaNad1ryMt0JELrI84O
	 p9ka5JISicmFw==
Date: Wed, 1 May 2024 17:39:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Miao Xu <miaxu@meta.com>, Eric Dumazet <edumazet@google.com>, "David S .
 Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, David Ahern
 <dsahern@kernel.org>, Martin Lau <kafai@meta.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/3] Add test for the use of new args in
 cong_control
Message-ID: <20240501173909.3b7d3138@kernel.org>
In-Reply-To: <a9aa6df0-b6ee-4512-acbe-7e30c98bba25@linux.dev>
References: <20240501074338.362361-1-miaxu@meta.com>
	<20240501074338.362361-3-miaxu@meta.com>
	<a9aa6df0-b6ee-4512-acbe-7e30c98bba25@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 1 May 2024 13:19:38 -0700 Martin KaFai Lau wrote:
> On 5/1/24 12:43 AM, Miao Xu wrote:
> > This patch adds a selftest to show the usage of the new arguments in
> > cong_control. For simplicity's sake, the testing example reuses cubic's
> > kernel functions.  
> 
> Jakub, is it ok to target the set for the bpf-next?

SGTM!

