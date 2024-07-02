Return-Path: <bpf+bounces-33629-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FE8923F65
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 15:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BAE3B27170
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 13:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1E41B4C4D;
	Tue,  2 Jul 2024 13:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R4kvTvwW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FGOjKWG/"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88FF15B109;
	Tue,  2 Jul 2024 13:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719927874; cv=none; b=cRTuH3VV4/XIE0W/jpkP9RBdIGguP06+7tIsG6UEhgnpDAxWX3NVP8N08BzwrvKD1cbssieSzqa5PDWb0BakhTBpvMw4JrHWc7dpC3x/D38rHmWPm4ED6SAB9xRrFKn4MPZhn814pIRpnX5dVrROdH6QqqI9LzpFBqG3z5hg13k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719927874; c=relaxed/simple;
	bh=uwWCOocbTiqMexMFOxr9sqBw4EuSKPLf8t6lQCj9GgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AWNwQIZMeY15F1csSVf+Y1ZXQQdIk23rS9V2mAkgyeEFGYMwTg9lk5m+X4rBRTfOKUYPY+6AljJmvkqWG2hWEhOiVosdGfs5p1WAiy3ltadam3YtVBRcT3BMWkoE9rURNC08n77GbOfPYHOKlt1PcRssya13GffU8OHh3u8UevA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R4kvTvwW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FGOjKWG/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 2 Jul 2024 15:44:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719927870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uwWCOocbTiqMexMFOxr9sqBw4EuSKPLf8t6lQCj9GgQ=;
	b=R4kvTvwW5jDuDAe3/djYpffPbDmdG6DE2lG9nZU4Lw1/HAgm0pozIt2zvoIg/mti8ZjM8l
	IgVf85oDssP+p6wuf6kUXG29djLCPhn9rociRVc2LC8WJRRZUap2IrVOBB9oGOVK79EmaZ
	okRUPTfcdnapZ07lhfeAYhxBd7OgzwkYlKy1X/gdVWH96j/8GLOoURVQuCcjdclyR2BZ6J
	Y673te0MvZSgqch9BWQH29TOfjiKmgNQpnQCDRsjn4f/EyKVxt1q5XdI82JPS/EeQtGW/z
	M2PxwBdtlm4OZ9EC2g4oQolZEPttVECXaXfCVBpiDZ/ZgE84rfgG5ec4R1JjgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719927870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uwWCOocbTiqMexMFOxr9sqBw4EuSKPLf8t6lQCj9GgQ=;
	b=FGOjKWG/xovFLjHs3HJRk7aY/WqRrCf87xvmQgJ5i1qYfmp7QeTweghHbOqJzRdaTdkNxu
	6woO7+3PwgLhzEBQ==
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
Message-ID: <20240702134428.hUZawCsP@linutronix.de>
References: <20240628103020.1766241-1-bigeasy@linutronix.de>
 <171992763353.28501.245433484118524334.git-patchwork-notify@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <171992763353.28501.245433484118524334.git-patchwork-notify@kernel.org>

On 2024-07-02 13:40:33 [+0000], patchwork-bot+netdevbpf@kernel.org wrote:
> You are awesome, thank you!
no, I am not. The last one does not compile. I was waiting for some
feedback.
Let me send a fix real quick=E2=80=A6

Sebastian

