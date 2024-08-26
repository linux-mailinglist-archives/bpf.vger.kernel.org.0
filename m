Return-Path: <bpf+bounces-38104-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 403A695FC12
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 23:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A00AEB23C8C
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 21:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7111319CD11;
	Mon, 26 Aug 2024 21:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KgRByLon"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B3913B58F;
	Mon, 26 Aug 2024 21:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724708983; cv=none; b=DwvXsPODsEriWJv/F/aSCtIzR0zj8eKiTXNEB0CsyiVBvlmLhYSXAO8Wxla3rKWxAkYR8IVQCoUI5WhF4fvdJE4H0ojQSssGnWv0zQzXJFwGj4H5ftNIcXBmJev91L5J1mUB6KX5Q1WsdOfe0OvJa07YRZDq+okhO8XKR9kvqkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724708983; c=relaxed/simple;
	bh=VhiAYFWKYyBDz6sZ2NVP0Pj7YB6rqRESmEHJbAoKG2w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F0qA6FIzvRgMka03IfdD8zHHd5y+xfniLL2MkaZQqjwwfB3KULIGTptnLqdljCgboJFR3ZuaRFQFT34OdqQbcpbG/+/kbDQ4QF9E3S49ogC80B8lkTf82nnkQdPdoqGuf3esu1W7xkA8YXldMBYO61zpmypMSWCNXtVC7CN+IOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KgRByLon; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 253DBC52FD2;
	Mon, 26 Aug 2024 21:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724708982;
	bh=VhiAYFWKYyBDz6sZ2NVP0Pj7YB6rqRESmEHJbAoKG2w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KgRByLonCRFOa2/LQ2R8+LDyAyCpSzXJXYvwYgeQ79M4A4nx0AKSwCPPf3eddGD2F
	 WaafYmsIrG+vkBEa40hFcUyJeQIKUWRCtq+cbmt2uOASRKje4fKGBUgUtJkQNs5P9d
	 7PgN6P/ZSGX9vrjaRYn7pUy82u7mH+aWXCq+TqX6j4rpF3obmWGgkCkKP85/rzwBOG
	 xyNPAlcpbc4xn23F+6HH4t2hKYhNdqH2Zv1/wGLZnYRfHHhZhEIWvaVXJt/FusxE8Z
	 yluFq+P4m3oNLL4rsthudgOfd/fuOWobPzuYOnHRmpWgSlSamBXkt58KEY3ehAlzGG
	 r8Oh57icO8OYQ==
Date: Mon, 26 Aug 2024 14:49:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yaxin Chen <yaxin.chen1@bytedance.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, Cong Wang
 <cong.wang@bytedance.com>, John Fastabend <john.fastabend@gmail.com>, Jakub
 Sitnicki <jakub@cloudflare.com>
Subject: Re: [Patch net-next] tcp_bpf: remove an unused parameter for
 bpf_tcp_ingress()
Message-ID: <20240826144941.17f9f85c@kernel.org>
In-Reply-To: <20240823224843.1985277-1-yaxin.chen1@bytedance.com>
References: <20240823224843.1985277-1-yaxin.chen1@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Aug 2024 15:48:43 -0700 Yaxin Chen wrote:
> Parameter flags is not used in bpf_tcp_ingress().

LGTM, but reassigning to bpf-next.

