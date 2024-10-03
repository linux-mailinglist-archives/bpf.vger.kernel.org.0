Return-Path: <bpf+bounces-40883-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 564D498FA04
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 00:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1AB31F21F70
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 22:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3A01CEAC5;
	Thu,  3 Oct 2024 22:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gnuI0/fR"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F49E1CDFA8;
	Thu,  3 Oct 2024 22:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727995488; cv=none; b=GOMX3Cenav8IhRE0dhywxmOBosLX5eYdKXPumOTXmR45XQRvhu7xznTNyv29xHWgDsxFUwo069mg2vbU0zgJTkxetCaZDJh7sljHqxUh9B72jMjXhNFmiB/GQ76olv8wNmNeSXwz7osHbhfuq/FHvR2GfqcPfePEqUlbPdPUYuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727995488; c=relaxed/simple;
	bh=Tx7IcxKh9CFY7niZORFkGf/fuCQnvsD/7M8vQd9DozE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XBVhSIDZLhdUI1upbByDIVS/YhZyt0WQ3tnzCa5fWbE8A1ZlWZKoq//OHIQUb68rMBlpDEsaKW/Pgqf/JsqswF5ZN+AHdxJyEl887ijtYib7LtRZEDnKduhDZytjJuL19Bqh02Tw4wU/4DYdol21zFwJOa6+2k8WBtW0++8Snjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gnuI0/fR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12885C4CEC5;
	Thu,  3 Oct 2024 22:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727995487;
	bh=Tx7IcxKh9CFY7niZORFkGf/fuCQnvsD/7M8vQd9DozE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gnuI0/fRQ0aySn2FIqITx97czlbluwGZvShIT2diI41bIPBJu0kE85lTGvl7fGuuL
	 X+g2D0BNhPuelZI+ownjpRpqWe1lismMiXLqBR6Ce+4MgbxUl6m1tSKh+KdkO42v3l
	 YBTjiF9FhFasFG4zi1GHQoYzIH1nGEqmunMchHZgKvxaRSRJrTgNay7oGKP5qdfF/l
	 KnGAMEPyOXHjBnCD4VerTWUwFCL0E8yPbDbvMglrx1lSJGTJph8+nsZND63D96i4qR
	 IzzUTOUXXchX0VvyFiwMcN1C8XaWT8kIvxc6yzVkTBfmdl5XpUndKXL50z/Yhgicli
	 bwm8KCDb7F0Ig==
Date: Thu, 3 Oct 2024 15:44:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, linux-net-drivers@amd.com, bpf@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Toke =?UTF-8?B?SMO4aWxhbmQtSsO4?=
 =?UTF-8?B?cmdlbnNlbg==?= <toke@redhat.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Edward Cree
 <ecree.xilinx@gmail.com>, Eric Dumazet <edumazet@google.com>, Jesper
 Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Martin Habets <habetsm.xilinx@gmail.com>, Paolo
 Abeni <pabeni@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Yury
 Vostrikov <mon@unformed.ru>
Subject: Re: [PATCH net] sfc: Don't invoke xdp_do_flush() from netpoll.
Message-ID: <20241003154446.05250ca3@kernel.org>
In-Reply-To: <20241002125837.utOcRo6Y@linutronix.de>
References: <20241002125837.utOcRo6Y@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 2 Oct 2024 14:58:37 +0200 Sebastian Andrzej Siewior wrote:
> Fixes: 401cb7dae8130 ("net: Reference bpf_redirect_info via task_struct on PREEMPT_RT.")

FTR I think this could have imploded even before, just a lot lower
probability.

