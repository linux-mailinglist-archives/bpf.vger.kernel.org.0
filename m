Return-Path: <bpf+bounces-33630-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B75FA923F59
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 15:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E96FF1C21ACD
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 13:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6641B4C55;
	Tue,  2 Jul 2024 13:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Yi8H3Vgk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gC89sqd0"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA4A38F83;
	Tue,  2 Jul 2024 13:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719927951; cv=none; b=Q5ubu+CSA1K+HbWsMl8T4NoWSocKS1OUwSAeZ/MH/oikE6ImthrlFOxJTiVKF8+D41QKAzNS6r2EYvG0Ie5RO8s9j3Uq4DAn2l1CurlUezovf3Bk+0f7PdEn+WtjZkC2bb6j5jXtGdhXjesuwgAuYpG9ihcUoYbLT+9BwMlBYTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719927951; c=relaxed/simple;
	bh=7eBs+dCNLtwPz5PHZ7yz/JnX3Irvb3XKfvlQUaj/rAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A9TQlJLLKiNlkguMa2KOHd+30VmwWOARIsjhBjkEbo7Ew/1MbiUG4qcEqpfc18bTjbGjHS1SXHgGzydT2Tw32D7aZHYQKWgBbqVn0y6JaJDvpG5jsnSM8+vfqwpJ8FjX790oainMyc/MfMVDbzPx95xffe+IE0nBgR0IKM03T1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Yi8H3Vgk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gC89sqd0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 2 Jul 2024 15:45:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719927948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7eBs+dCNLtwPz5PHZ7yz/JnX3Irvb3XKfvlQUaj/rAs=;
	b=Yi8H3VgkGTgr0JTs6g46EzhSw8YrQlP9LiZQEkrfA1OEStrulpkqzJ04M4vBM2dUthgGqP
	gTsaIe2Zgjc7qnrwC46qJefaSkXly6LkI+9/IzcCF6DiBTVB/bhZq4R/FaMJCl5s3PeX+5
	77IsAOhbHOa3BEGct3LKkN7FGkOxT7zOqIBAmjLmrB00V69woUsLInKCO9ZwNe79sEHugo
	Jj+iMsm7m/6NzJn1XSyW4dZ85hMhbKHRIlilvha3PDoCHO3DjRSD+NNS+q7MSYjg4l+V68
	vRLSlR9HiXx+buFQF7iJBcD0V82Zst/JBVTPAlBcUUEWAkYhf5gd9GpBzumufg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719927948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7eBs+dCNLtwPz5PHZ7yz/JnX3Irvb3XKfvlQUaj/rAs=;
	b=gC89sqd0NhduLWjv3FqQ38KNAiPZaLD006CIgEAMZy+pxWa/Cjx/JiY0dNOlpuoWcyLcnd
	MrQuPZ3Ys/xr7XDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: patchwork-bot+netdevbpf@kernel.org
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, bjorn@kernel.org,
	davem@davemloft.net, ast@kernel.org, andrii@kernel.org,
	daniel@iogearbox.net, eddyz87@gmail.com, edumazet@google.com,
	haoluo@google.com, kuba@kernel.org, hawk@kernel.org,
	jolsa@kernel.org, john.fastabend@gmail.com,
	jonathan.lemon@gmail.com, kpsingh@kernel.org,
	maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
	martin.lau@linux.dev, pabeni@redhat.com, song@kernel.org,
	sdf@fomichev.me, tglx@linutronix.de, yonghong.song@linux.dev
Subject: Re: [PATCH net-next 0/3] net: bpf_net_context cleanups.
Message-ID: <20240702134546.2CeHYMhf@linutronix.de>
References: <20240628103020.1766241-1-bigeasy@linutronix.de>
 <171992763353.28501.245433484118524334.git-patchwork-notify@kernel.org>
 <20240702134428.hUZawCsP@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240702134428.hUZawCsP@linutronix.de>

On 2024-07-02 15:44:30 [+0200], To patchwork-bot+netdevbpf@kernel.org wrote:
> On 2024-07-02 13:40:33 [+0000], patchwork-bot+netdevbpf@kernel.org wrote:
> > You are awesome, thank you!
> no, I am not. The last one does not compile. I was waiting for some
> feedback.
> Let me send a fix real quick=E2=80=A6

Sorry. Wrong series. All good.

Sebastian

