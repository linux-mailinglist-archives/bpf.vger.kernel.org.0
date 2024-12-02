Return-Path: <bpf+bounces-45964-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D629E0F36
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 00:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CEDC1630CF
	for <lists+bpf@lfdr.de>; Mon,  2 Dec 2024 23:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455E11DFDA3;
	Mon,  2 Dec 2024 23:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ma9DtIb4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EE81DEFC2;
	Mon,  2 Dec 2024 23:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733180664; cv=none; b=Iilws4avQVsGnQ5aIuydmf27moFSt45TmR1wNTKSvmwVtMYMgu0S6YU3diifFNJ4qu2tpejZwB4t8TGP0gkpoqwEk17bQnGHvN4WOqdWnp8ULN6gcJraycZ3oekVIlUbOmB/qnIdRfadnlgzA6izmNvjgcdASOpHN3YWN8wuLfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733180664; c=relaxed/simple;
	bh=cUcN11o068f8TJvGEYCOeVGL/9NE9jBDPC16oMTHyg4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a5mTuR65M6Wxo6SUkH7DQqoXrYrAasgUKKVieykHqQ5VWS9+7Yrs4EL4f4YbA/0xpFYg7IWIVhnwpgqmsSq1y8poWZ4x5QxYRPr34+pmzFTodK9j+taL4spTSn7BcqADDayeyEiN90inWvO6naNvPiufdjdnS6X5CdeXfbx1Lnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ma9DtIb4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B126CC4CED1;
	Mon,  2 Dec 2024 23:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733180664;
	bh=cUcN11o068f8TJvGEYCOeVGL/9NE9jBDPC16oMTHyg4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ma9DtIb4yu7nOsCnJfIs4udVB/3JxD3QI8pAF+/6HZDUD75QtUW8AwcwX1sWtpp/O
	 gO/0Pkpv8CAy6tTfLOxWv5IxPWM1KaDlWtGLz6naPC3k90IWmLM9KGoBocoSPSjaLv
	 qKbshYXYt/Lt2dKp1UExBBgpeCu8Enmhv6HVNI60j1srRZufQ3vDbIotN+KwHvXs30
	 kKwJm4ZiKPWNaqei0x6CR5bbTs770J2o2s57mXMpoaTIxINOTulnDL1XZjaWs07rTk
	 fG2ynxLu/H7xElmUJCvmN7IR1TrQi3ns+OYIDyXuhN29tS+IICdMaCkREbVNgZJ2T0
	 bTuBFjevHT+0Q==
Date: Mon, 2 Dec 2024 15:04:22 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Levi Zim via B4 Relay <devnull+rsworktech.outlook.com@kernel.org>
Cc: rsworktech@outlook.com, John Fastabend <john.fastabend@gmail.com>, Jakub
 Sitnicki <jakub@cloudflare.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/2] Fix NPE discovered by running bpf kselftest
Message-ID: <20241202150422.013b4767@kernel.org>
In-Reply-To: <20241130-tcp-bpf-sendmsg-v1-0-bae583d014f3@outlook.com>
References: <20241130-tcp-bpf-sendmsg-v1-0-bae583d014f3@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 30 Nov 2024 21:38:21 +0800 Levi Zim via B4 Relay wrote:
>  net/core/skmsg.c   | 5 +++--
>  net/ipv4/tcp_bpf.c | 8 ++++----

Haven't looked at the code, but these files are BPF related.
I'll reassign the patch to BPF maintainers, and please use "PATCH bpf"
instead of "PATCH net" for next revisions.

