Return-Path: <bpf+bounces-41675-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F779999A6
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 03:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B18971C22B13
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 01:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD49FC12;
	Fri, 11 Oct 2024 01:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eoz6z7g7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCBBEAF1;
	Fri, 11 Oct 2024 01:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728610811; cv=none; b=OeQHwDJa2R6oRTfvk8NjSl84iQIL95hbZW358EwK6CPTx0aaVdcaj2Q1PP8MTDAL2IXNdujK/qaHJgrCNFtUiyGIRnhqnZeaXuYgRhjJzGS/SgbgEbAGciSWWuXUoc7aFySnGvQt593EI4becDwj+UlTfud57TYJ11Hpr9sfAPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728610811; c=relaxed/simple;
	bh=uf4s3+S0XTfvbkT/yLxpLUxfyKJIh/U0yq0hqxWhyi8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jkEZXMnbj5D4wIYamRolrdmibGLZ67sp0rCDbExdpvDOuq/iMWNiECW7Q1156GN8rla5oHkw2k6P5nGcXid204PM/IuOmF5f+2k6EXYoPdMgV6sLiZ3Qru3obd+fmTBW+PR546evkF6ERF65yKBq7gSsmIHGE4NJ+MItU0aC7a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eoz6z7g7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3396EC4CEC5;
	Fri, 11 Oct 2024 01:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728610811;
	bh=uf4s3+S0XTfvbkT/yLxpLUxfyKJIh/U0yq0hqxWhyi8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Eoz6z7g7mSFf1Ujw8G6FWmLFCRcKzthdPjl9Losop/fiR0ctBx8fVblF5e5H+1hEg
	 C/oPiTWDgZUQ4yifUO28D6yoGfjv1hPTGcuKT1GnddBcNneuYJX3pq2IwpHblyNuBV
	 HQALBTfzfcoD+On/GwPlD7ltnvUvlzPZjNpw7Tf4KGy5xiyPuCroh7iaSIA5y1VylZ
	 uWjv4IZA4phGn0id5WY8Qkq6rotqweoeqzTkOtytnkzUS/lT2Gu68t6AJwVBwg1+Lq
	 XUNvMt4U6azLBbQplrfCnZtq6tZCEhsykO3DTuLdQUrxrC3fwkPoYf3m1E9GPRa/GG
	 BsiMI9vL/Sf0w==
Date: Thu, 10 Oct 2024 18:40:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Toke
 =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John
 Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Magnus Karlsson
 <magnus.karlsson@intel.com>, nex.sw.ncis.osdt.itp.upstreaming@intel.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 00/18] idpf: XDP chapter III: core XDP changes
 (+libeth_xdp)
Message-ID: <20241010184009.13bce4bd@kernel.org>
In-Reply-To: <20241009152756.3113697-1-aleksander.lobakin@intel.com>
References: <20241009152756.3113697-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  9 Oct 2024 17:27:38 +0200 Alexander Lobakin wrote:
>   xdp: add generic xdp_build_skb_from_buff()

doesn't not apply, AFAICT, gotta respin

