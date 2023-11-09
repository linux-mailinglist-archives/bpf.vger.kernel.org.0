Return-Path: <bpf+bounces-14543-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A977E61EE
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 02:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEBE0B20F0F
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 01:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C28115C2;
	Thu,  9 Nov 2023 01:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K1SghrsW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85581379;
	Thu,  9 Nov 2023 01:52:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE21EC433C7;
	Thu,  9 Nov 2023 01:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699494737;
	bh=g640RsaBvaVURXc5cFBVKVE/AYu/M06cPPtFkXzZ1bM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K1SghrsWNDkQ3HuK8O04Mfwn0DZSNKH47wWU9CPndposxlqxDR/5TYHF7Dc3mBqx/
	 MxoEShNA2MXaBtzYWFgFa/6k60n/mV1vD1N6E+dfe7RPt8ZIzcfd0xUnwSzQlKzlGg
	 DnfottDzPrxa1iIzTgM/j/htscOFAFx+gO50XVmhjuIkaE8vJHsAiPkpFoVPbwONQO
	 wjPqjUSehsXBgWwgkPTKWE0i8QHxI7KDRG0oFKzc7+RECzWXk6vdsWpAOqtQYp9GJ6
	 uRQvfenkayLIgyTbN8MnjH6WQOqYjHWdOyOZGpNLTmhEZpLGzZwg66vYvbH82GZVqr
	 n56Kh6B3mHMlw==
Date: Wed, 8 Nov 2023 17:52:15 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Nelson, Shannon" <shannon.nelson@amd.com>
Cc: Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>, Jesper
 Dangaard Brouer <hawk@kernel.org>, David Ahern <dsahern@gmail.com>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, Daniel Borkmann
 <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>
Subject: Re: BPF/XDP: kernel panic when removing an interface that is an
 xdp_redirect target
Message-ID: <20231108175215.351d22bf@kernel.org>
In-Reply-To: <fa95d5d0-35c0-497e-aea8-a35f9f6304f4@amd.com>
References: <e3085c47-7452-4302-8401-1bda052a3714@amd.com>
	<87h6lxy3zq.fsf@toke.dk>
	<fa95d5d0-35c0-497e-aea8-a35f9f6304f4@amd.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 8 Nov 2023 13:30:21 -0800 Nelson, Shannon wrote:
> > Another source of a bug like this could be that your driver does not in
> > fact call xdp_do_flush() before exiting its NAPI cycle, so that there
> > will be packets from the previous cycle in the bq queue, in which case
> > the assumption mentioned in the linked document obviously breaks down.
> > But that would also be a driver bug :)  
> 
> We do call the xdp_do_flush() at the end of the NAPI cycle, just before 
> calling napi_complete_done().

Just to be sure - flush has to happen on every cycle, not only
before calling napi_complete_done().

