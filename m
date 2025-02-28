Return-Path: <bpf+bounces-52917-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 447ABA4A587
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 23:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5243716B3AE
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 22:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C0E1DE3A3;
	Fri, 28 Feb 2025 22:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JFOD6HxX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C7B1D9663;
	Fri, 28 Feb 2025 22:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740780124; cv=none; b=eqiaE8QYq5FeJNxtUqd2xHax5vKVx5F9L9MDwMVtf1JnbmBD+htLNuYhdp3+gA7vAneu2dRpDQ16kGeaiJQdHd1ZWZ1ebwgQEsi9IPuqO143G1uZzNjqx6PMV8B7WWwHvi6rkWJIR9lXg/y2bdZldKPztA9kEY9OmIOAnyvlO/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740780124; c=relaxed/simple;
	bh=Nw/MKOIkxVmmkDc/avI1b9nUxkB/g/7R9GAVpsyzNOM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CM+v2J2b/+gO5qB4vqp3ppIK4zz/N75qXimErQUGNcEK68PIJMFoGUONsNOz7jvK6CoVCoHAFJo+cq8gGg1nNJXHAIPayp5xawtP0IN3mLhIV2VBzgfwF5LEhQJURIomw+SQ7bUVfma+vt2NMc5uPoqQirCsRGLviPe49vcCi4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JFOD6HxX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DCC9C4CED6;
	Fri, 28 Feb 2025 22:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740780124;
	bh=Nw/MKOIkxVmmkDc/avI1b9nUxkB/g/7R9GAVpsyzNOM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JFOD6HxX/SimWYikwyJ6TJKw8IM3P3stZZ984ZVQomWcpRhdlivUrQl7KfqlfwHK7
	 TH41f/Mzj/VCIZNWTYWH+v3CO7br6pFCDw6Er/VFGZ5zGvmsgh05UBPj4wkuWqUW0y
	 mvHSa0rM21sftK8ZSi6tb8+nnsxS1sCHUrG2i2IHJmYrvPQZZLUIo1Hze5bXpgodoX
	 SMWpJ7oL5ZQu6LRcxpVnQ3dvpNBM1elrITOyJ1ifWi6R1Gpj1zxU61JBqgEyRbWaoS
	 TNL4zV+mfUFNQ1OFFm9Xx/eTQPNhwK4+W6CcHQO7bzRJUc7UgsV7F3v9o0om57cQYf
	 EZrliZf0W/tRA==
Date: Fri, 28 Feb 2025 14:02:02 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: horms@kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, ricardo@marliere.net, viro@zeniv.linux.org.uk,
 dmantipov@yandex.ru, aleksander.lobakin@intel.com,
 linux-ppp@vger.kernel.org, linux-kernel@vger.kernel.org, mrpre@163.com,
 syzbot+853242d9c9917165d791@syzkaller.appspotmail.com
Subject: Re: [PATCH net-next v4 1/1] ppp: Fix KMSAN warning by initializing
 2-byte header
Message-ID: <20250228140202.7f39a30c@kernel.org>
In-Reply-To: <wm7gi3hafgaruhnjaz5bqdv7yrduf6cum3gljylypzqkvw2ctw@b2zb75i2hpid>
References: <20250226013658.891214-1-jiayuan.chen@linux.dev>
	<20250226013658.891214-2-jiayuan.chen@linux.dev>
	<20250227174812.50d2eabe@kernel.org>
	<wm7gi3hafgaruhnjaz5bqdv7yrduf6cum3gljylypzqkvw2ctw@b2zb75i2hpid>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Feb 2025 12:55:41 +0800 Jiayuan Chen wrote:
> > The exact same problem seems to be present in ppp_receive_nonmp_frame()
> > please fix them both.
> > -- 
> > pw-bot: cr  
> Thanks, Jakub! I'll do that.
> 
> I was previously worried that the commit message would be too long,
> so I put the detailed information in the cover letter instead. I'll make
> the commit message more concise.

FWIW we commit the cover letter as well, as a merge commit.
So both would end up in the tree.

