Return-Path: <bpf+bounces-58348-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62966AB8F2B
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 20:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33FC0A02D9D
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 18:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965AD298C37;
	Thu, 15 May 2025 18:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gd5JGc1H"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1782989B3;
	Thu, 15 May 2025 18:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747333893; cv=none; b=jkLGIKAYbFpS5Fiq9NfNAxcVXbeKakKdUT7M3fwv/oAzuPtYX96Qq3hqelzWE8tO5SQhRAJ/QNDctQuWWvcFi8a/sjUfok8zr3SpyWGI4VATwhAV7620Aui5lnCT3lFxcuAhf5HzpMNb2GW1P6Nwxbikcyk4nslvD3ZHsAJLB+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747333893; c=relaxed/simple;
	bh=V+QLsQuPxIprTLyEzkj8L8nEDsigEA8EWaPGDx2twaI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NBVhdNj17jFDQuQwlwM7Gxlt+hVNCYv1y0E/3vcDMYZkznuSOGPWhwoO1yL+QDw8vZBeRTYsrgfeRKFdRVVCUjHrDEI9JjHNKWVGbURAvLalBaaIjFP5GfTTMhXw00nJ94CA6DmnA2THztcSUFnv9Ln9md1q0ChP7Xta4RKc728=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gd5JGc1H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B27DC4CEE7;
	Thu, 15 May 2025 18:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747333892;
	bh=V+QLsQuPxIprTLyEzkj8L8nEDsigEA8EWaPGDx2twaI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gd5JGc1Hfgk8dMBAZIdrjp6d4I8wV4j6cE7ZM4Lvh4GgR6o3GoCkXipqRNJ+Vr/vd
	 aI0j5aGQkUYcLPDdjijKmGG1czmTxi518v2ruL53hF6+f7d0OHyKC9C0tgqUneJ09v
	 03D1b42q8JVfLteMfCuGtSXkiLa2wkQInXBM8b2KB6OUO0WXLa7bntNYvhupreWTna
	 /yxTMHaYBYOZG121IzUuZue0MBTAYX52qoDqNje/NyBbsAixtbkaRqLNDQPaAF6dgk
	 GoR8ErxhXI9/M2P1xQJfJhN9yb7668CBH5i/tjGzNRIBrsIPNzeCZXB7XYlouqlYmz
	 CZkyrQNkdNZdA==
Date: Thu, 15 May 2025 11:31:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: patchwork-bot+netdevbpf@kernel.org
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, andrii@kernel.org,
 eddyz87@gmail.com, mykolal@fb.com, martin.lau@linux.dev,
 edumazet@google.com, kuni1840@gmail.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH v1 bpf-next] selftest: bpf: Relax TCPOPT_WINDOW
 validation in test_tcp_custom_syncookie.c.
Message-ID: <20250515113131.21203db4@kernel.org>
In-Reply-To: <20250515103642.01ed5f5a@kernel.org>
References: <20250514214021.85187-1-kuniyu@amazon.com>
	<174726243176.2534141.9628048963449437170.git-patchwork-notify@kernel.org>
	<20250515103642.01ed5f5a@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 May 2025 10:36:42 -0700 Jakub Kicinski wrote:
> On Wed, 14 May 2025 22:40:31 +0000 patchwork-bot+netdevbpf@kernel.org
> wrote:
> > Here is the summary with links:
> >   - [v1,bpf-next] selftest: bpf: Relax TCPOPT_WINDOW validation in test_tcp_custom_syncookie.c.
> >     https://git.kernel.org/bpf/bpf-next/c/4dd372de3fde  
> 
> Per the link in the commit description we need this in net-next :(
> Did it land in the non-network BPF tree? Or on the network branch?

Martin pointed out off list that the CI flow merges in bpf-next
so it won't matter, all good.

