Return-Path: <bpf+bounces-42066-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C6799F1FD
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 17:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 152B31F22A74
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 15:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3113F1E6339;
	Tue, 15 Oct 2024 15:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+9nQ8G7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C291714BE;
	Tue, 15 Oct 2024 15:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729007483; cv=none; b=pK5GqF4jjU/xKoQ5NRLB+e67TNe9pnG54ooPzgmUDjgnPNwEx0eUbBcb9DW90usqYIg3rLHwA9ywE2j7G4FmzS4o9oAeK4kk/KeqjxhjHy5oK8lWIjwTLQU76CHuPh2YOWpEikfyUVqGxGVeempPEfTTufDhGdOlUxjtKiC1h5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729007483; c=relaxed/simple;
	bh=grArdQkCShh+C6dJgpxXV1EytHE5WpU0yGVIeKNoxNg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oJKREqFxUBM5gUFZVyYa9GtCUpzZyi5Wo7Eb7hh9AYdpg+wMPfeCyh65AhqpBd+DdY1PtGTh1TugoNXbkk5Ak0q8NTbd9oUSynKF7M844MrVe22BR0bADDgmPl0XmYix4NLYE7tKCnHWjy8jKurrf0mpVXbPN0OI3w0NPLSNtuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+9nQ8G7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56560C4CEC6;
	Tue, 15 Oct 2024 15:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729007483;
	bh=grArdQkCShh+C6dJgpxXV1EytHE5WpU0yGVIeKNoxNg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=c+9nQ8G7Y9i/LwN7VNpV0DrdRQZkNBQPlKR8dE3HSexY+pKDsTc/SCMK2hMsar88w
	 syKDfIFrTL9X/Qg9yNQQ0AHFsO6hOj3SW0KGr9OCMmTBp8cWOiYxpJrdYVga0K1/SX
	 96iKIpBlsOWG/PRp4+eurZrZDHsM8qFZREzbIa0UZq+TDhm0ooUsjIJYDJs0L3PNHs
	 bMgCuSovbXQTndefYSXXcNaQhTsofxc93EYdkTt49wyOVokXLmXFogNrvy8GkDw5tY
	 Y6q0VoLjkA0JkzvDGD/z3Ed4BaigFe8R6RJ2lUUBoFA+Lab2t4Gy1m3D2uPOmRAeE5
	 cLFPyx5C3n3ig==
Date: Tue, 15 Oct 2024 08:51:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>, Lorenzo Bianconi
 <lorenzo@kernel.org>, Andrii Nakryiko <andriin@fb.com>, Jussi Maki
 <joamaki@gmail.com>, Jay Vosburgh <jv@jvosburgh.net>,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Liang Li
 <liali@redhat.com>
Subject: Re: [PATCH net] bpf: xdp: fallback to SKB mode if DRV flag is
 absent.
Message-ID: <20241015085121.5f22e96f@kernel.org>
In-Reply-To: <20241015033632.12120-1-liuhangbin@gmail.com>
References: <20241015033632.12120-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Oct 2024 03:36:32 +0000 Hangbin Liu wrote:
> After commit c8a36f1945b2 ("bpf: xdp: Fix XDP mode when no mode flags
> specified"), the mode is automatically set to XDP_MODE_DRV if the driver
> implements the .ndo_bpf function. However, for drivers like bonding, which
> only support native XDP for specific modes, this may result in an
> "unsupported" response.
> 
> In such cases, let's fall back to SKB mode if the user did not explicitly
> request DRV mode.

Looks like the issue is reported by QA rather than a real user.
A weak -1 from me on building such unreliable heuristics into
the kernel. As BPF CI's failure points out the ops can return
EOPNOTSUPP for multiple reasons while dev_xdp_mode() only checks 
if the driver *has* ndo_bpf, not if it fails.

