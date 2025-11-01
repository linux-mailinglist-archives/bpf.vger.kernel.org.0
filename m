Return-Path: <bpf+bounces-73216-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB062C273EC
	for <lists+bpf@lfdr.de>; Sat, 01 Nov 2025 01:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15401189DDEB
	for <lists+bpf@lfdr.de>; Sat,  1 Nov 2025 00:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD82E1A285;
	Sat,  1 Nov 2025 00:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U8zNrg05"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48119635;
	Sat,  1 Nov 2025 00:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761955522; cv=none; b=mrFVqGAMZCZOlNaP8VfMpshUrozianqJ7Wf95wvb4j2rDl0ptXYmhD68qjX+cKsL+3z0iVg5gBYKdJ2UuvtULETarm2+ssC34Qw/j61SWs2bDxIXGgiKjoD1kRD/P1MgVa+HVgZPpPSR4zN1ptICv8XMqroiXlEEMylkI2vFtnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761955522; c=relaxed/simple;
	bh=fE+D5VHaBMCyso+4WPiJDK8Yfqjxkb3GgzV/RQzuLZY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z7fFrhABSvKsntFv8bBcSygLt+Q3ajNV5V7NjkGl2X2VkAl1ut5Qka9AEAErXlar4xL0zNwr6eUHIkdt2oeM2izAxUcYKfKIF1Zr6342hgPvDYjxhY2cDEMGY8XMN2wKrpKTqDO2zutMzDgGZsAvX1bY3nebqc25sWL+jYO+xXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U8zNrg05; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E7C5C4CEE7;
	Sat,  1 Nov 2025 00:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761955521;
	bh=fE+D5VHaBMCyso+4WPiJDK8Yfqjxkb3GgzV/RQzuLZY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=U8zNrg05CpI9dSyR/5aCQfzJtZjteo0RCZMs+Hu7x7KptXgqIYHQKCaghTLfricev
	 TPEHgDoCg/ezZOKeDUsAru0qAjTKDL0n2PwSL41aTYVhDZVolW1DasiZLcj2yKX4pm
	 H+LlCriQfX8BmihG14MHJvMHYfyRih3NVBX6q3AgdyAedfvwR+TvU6THWYKtl6fPRu
	 /JDGO7vMIit6209QeXGvd20LuL51XaAZvNxKqlPNbPf52VgvdeGaKWNmqOE8p1FsVe
	 ATH/3KpTkL0AXnLJGo9xVyCYU2qGMODJcnF5pRt1B20d1Mf57kb8gA5XH6MrI83j8e
	 IM5CVagA9Uc1Q==
Date: Fri, 31 Oct 2025 17:05:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, "Gustavo A. R. Silva"
 <gustavo@embeddedor.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima
 <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [net-next PATCH v4 1/7] net: Convert proto_ops bind() callbacks
 to use sockaddr_unsized
Message-ID: <20251031170520.0b8486cf@kernel.org>
In-Reply-To: <20251029214428.2467496-1-kees@kernel.org>
References: <20251029214355.work.602-kees@kernel.org>
	<20251029214428.2467496-1-kees@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Oct 2025 14:43:58 -0700 Kees Cook wrote:
> Update all struct proto_ops bind() callback function prototypes from
> "struct sockaddr *" to "struct sockaddr_unsized *" to avoid lying to the
> compiler about object sizes. Calls into struct proto handlers gain casts
> that will be removed in the struct proto conversion patch.

I fail to spot whether the new type is defined :)
Or is the new type not defined at all?
If it is probably best to have that as a separate patch.

