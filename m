Return-Path: <bpf+bounces-33296-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DC491B1B1
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 23:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C248E1C223CF
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 21:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109DD1A08B4;
	Thu, 27 Jun 2024 21:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+XvF8Qy"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895EB13A3E8;
	Thu, 27 Jun 2024 21:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719524962; cv=none; b=CXX8jxZxg1vRX2TBhFP2OaxccsMlRfo7ZPP6yUEtQlSm4p+Y6fRew+nvKRmR194GMu6uTrGxaPzRm3lwLCVPAzWGGIaN1FTtl4iAxkPNj3/sTJNK4cJ+KvsQzDDT5+iLTrwcnbUQo0cPAvHdVFRgZlquu64ZXLP63RijRrEkk0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719524962; c=relaxed/simple;
	bh=945GM0TkoMKEQM4FpG0tSsSuX0Lk7YmHfPfkvBO8xf4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KktOq4AwTa9XeWlugGlzfI8LyRYDHS8t9yRwhHqjUlAnY3U4KYBpfbrumrZGW73+LyHXxUe8ZEqB31+DAb0XfievzvdXftf/5vbZ2vJXe3NDqtRZ/u/WQCxEr7hSEMuiCtM6Xid8QANh0FIYNewXhgtC9lyTje7H+jRaoJDOZEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+XvF8Qy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3404C2BBFC;
	Thu, 27 Jun 2024 21:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719524962;
	bh=945GM0TkoMKEQM4FpG0tSsSuX0Lk7YmHfPfkvBO8xf4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R+XvF8QyFhhxX/bRpNG+46jsLUzEOmy89lnjAgkdu3XXamgT+/9GNhLU3cMb2hQ+Y
	 7EAw6L6MTN/uN9IzFWxK8+X2GdIKaG+0niAcebNYXx1SgSaKmEYFyisb/lSl3/Lqac
	 7v9HM+mgVE4vz3xMI+XQZXFEwZOJAa8bT+3fjrlOPScgc58dysdBqgrO3mTR5LFlkQ
	 b9qtu/aI1kSNyqJt8Jf1awDcVjUJFmX7Ma7/KO/TI9RiCEgdx+4imY68v/F4BotRQh
	 4wQT0FvtQ2y/noiWeuoDjnI1wiZXYdbVEpxEzh7lZY/yeKh4Cxb5B+Gusnlaz/0zNg
	 lBL3Sh5iFW7+g==
Date: Thu, 27 Jun 2024 14:49:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, Lex Siegel
 <usiegl00@gmail.com>, Neil Brown <neilb@suse.de>
Subject: Re: [PATCH net] net, sunrpc: Remap EPERM in case of connection
 failure in xs_tcp_setup_socket
Message-ID: <20240627144920.788d282e@kernel.org>
In-Reply-To: <72b5939b13efd4fde6e9c0f9fb00edd314f4bcce.1719392816.git.daniel@iogearbox.net>
References: <72b5939b13efd4fde6e9c0f9fb00edd314f4bcce.1719392816.git.daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Jun 2024 11:13:47 +0200 Daniel Borkmann wrote:
>  net/sunrpc/xprtsock.c | 7 +++++++

Could you repost with a wider CC list? We don't take all sunrpc patches,
this one makes sense but best to avoid any misunderstandings.

