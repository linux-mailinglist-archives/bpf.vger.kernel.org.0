Return-Path: <bpf+bounces-46041-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0A79E307C
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 01:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A542166B3D
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 00:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CDF04A28;
	Wed,  4 Dec 2024 00:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5FcLY/N"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C4B4C6E;
	Wed,  4 Dec 2024 00:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733273519; cv=none; b=CtZVnRv9ovia/cYjDsnDMnCQzUdtvaMohVF/v8+O97o3xjOpRA5cn82jk2mA5QCNchMPSwJuPuRImE7s9AS+wM1kVEJF4Oj0O4g+xZdT5J7LtBRUoZ/4FvAtcFcNS0cnz3DHeT4sJ7KK0lg9JF6HFsps2/DHE+hGDMxjM76rRu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733273519; c=relaxed/simple;
	bh=couke5zqObDh6jfTvyi0RoSa3UQwJPldsoPVcoy3YNg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F3xxKkFqxt3LHk4WiGDB/tyWCqVAQtdzvAXJ2ure3YCYXlnEBhIC5wspq1O6fBDRTmjo1X7CuxO2b1QItm9eDwYBlCBfFXkhhzRU4bh70kgWuZNZtZO0Huk5IJtvwvVz+QPEEqOwjeuPDV2dV7gf8qVaC2sr2fuFJOrVMW8Om8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5FcLY/N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7689FC4CEDC;
	Wed,  4 Dec 2024 00:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733273519;
	bh=couke5zqObDh6jfTvyi0RoSa3UQwJPldsoPVcoy3YNg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h5FcLY/NdEHm4JxdBMdSDwV3OOZPqzN1QrAQl82nEqJUPqTXu1AKhp+rvlEY6MnJO
	 TqFMiJVfW9HwXw4xk9iJx7Cf/Eb2V/R8JZadrd2stYabeg2uENy0P2J0ikV/o0RVjJ
	 5ZK7X2RjTKRAVoR1ovqVBJWplkuU7gqDUHNyQO2zunBuaHz8SKXWighBactEEZJirT
	 vjDgptqU8IE5QFsZqUA6n3u/6sM3TJC8QovauP5HHwbIBn78hfbmSIjPyJ2US2KopJ
	 pFs0rx/ML5yEA51oxK6vhezgNI5lYlIMRCrgDvMTFZQinlq6aqA1Dx0yGq+LugOzD5
	 rgBDw0wM3Czkg==
Date: Tue, 3 Dec 2024 16:51:57 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Daniel Xu <dxu@dxuuu.xyz>, Lorenzo Bianconi
 <lorenzo.bianconi@redhat.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Jesper
 Dangaard Brouer <hawk@kernel.org>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, David Miller <davem@davemloft.net>, "Eric Dumazet"
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 <netdev@vger.kernel.org>
Subject: Re: [RFC/RFT v2 0/3] Introduce GRO support to cpumap codebase
Message-ID: <20241203165157.19a85915@kernel.org>
In-Reply-To: <4f49d319-bd12-4e81-9516-afd1f1a1d345@intel.com>
References: <cover.1726480607.git.lorenzo@kernel.org>
	<amx5t3imrrh56m7vtsmlhdzlggtv2mlhywk6266syjmijpgs2o@s2z7dollcf7l>
	<ZwZe6Bg5ZrXLkDGW@lore-desk>
	<55d2ac1c-0619-4b24-b8ab-6eb5f553c1dd@intel.com>
	<ZwZ7fr_STZStsnln@lore-desk>
	<c3e20036-2bb3-4bca-932c-33fd3801f138@intel.com>
	<c21dc62c-f03e-4b26-b097-562d45407618@intel.com>
	<01dcfecc-ab8e-43b8-b20c-96cc476a826d@intel.com>
	<b319014e-519c-4c2d-8b6d-1632357e66cd@app.fastmail.com>
	<rntmnecd6w7ntnazqloxo44dub2snqf73zn2jqwuur6io2xdv7@4iqbg5odgmfq>
	<05991551-415c-49d0-8f14-f99cb84fc5cb@intel.com>
	<a2ebba59-bf19-4bb9-9952-c2f63123b7cd@app.fastmail.com>
	<6db67537-6b7b-4700-9801-72b6640fc609@intel.com>
	<20241202144739.7314172d@kernel.org>
	<4f49d319-bd12-4e81-9516-afd1f1a1d345@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 3 Dec 2024 12:01:16 +0100 Alexander Lobakin wrote:
> >> @ Jakub,  
> > 
> > Context? What doesn't work and why?  
> 
> My tests show the same perf as on Lorenzo's series, but I test with UDP
> trafficgen. Daniel tests TCP and the results are much worse than with
> Lorenzo's implementation.
> I suspect this is related to that how NAPI performs flushes / decides
> whether to repoll again or exit vs how kthread does that (even though I
> also try to flush only every 64 frames or when the ring is empty). Or
> maybe to that part of the kthread happens in process context outside any
> softirq, while when using NAPI, the whole loop is inside RX softirq.
> 
> Jesper said that he'd like to see cpumap still using own kthread, so
> that its priority can be boosted separately from the backlog. That's why
> we asked you whether it would be fine to have cpumap as threaded NAPI in
> regards to all this :D

Certainly not without a clear understanding what the problem with 
a kthread is.

