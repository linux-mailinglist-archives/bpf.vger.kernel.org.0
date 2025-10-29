Return-Path: <bpf+bounces-72720-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8186CC1A0BA
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 12:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9BB8C5808D3
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 11:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79DA331A42;
	Wed, 29 Oct 2025 11:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="As0ogIMo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Zo4aZ89o"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDA3335091;
	Wed, 29 Oct 2025 11:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761737338; cv=none; b=c3CCtnkvNnrH6FheG4IqFnsEPQltsprDPTLDOcU1VU6s5sP55xzsF51Qkm8l3s5kk3ABZKg6B/EbJkMx1z8da/eLQyGSD2juMw1ZHSQQrlJuip0A3XfnZjtBtGmQJUNNHo1Z5eT59P/MUVcqp6u51SlxBhjsWAKdiQ4xE1wiO4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761737338; c=relaxed/simple;
	bh=Mv+1E8etoCgDP3bz8A9b50Vpx0C+KRGIBeAjz0H3eKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fvA1kSO81ypa8AK4S1IaKFCXjf0LOEmGCnATPzUi9Qo6Mn2dl9gQcvJqHP9XMzBWrraxy/G0dEEUu4PhG7xxmNUY+puuFFRnqNvMzbC2GzUmt1OpD/ENxy2FMwiCGV2wizZmtf1rqEYbtr05//sfGsnmGCMjHgHpmslpBXUULWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=As0ogIMo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Zo4aZ89o; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 29 Oct 2025 12:28:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761737330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mv+1E8etoCgDP3bz8A9b50Vpx0C+KRGIBeAjz0H3eKU=;
	b=As0ogIMoE2eFOvZ0RbnoHyeQrwhm/YIRIoiFghUv9xvF21tdzFz4VII3wocV0dimToTlSk
	pKXlkOsSs0YqFvWWJWG6unAd0XW3SOh7timMutU3uUetvaIcb12+RF7THehFyTJTleSwqD
	jqTEaPq47AkBmAIN/XCSwxD0K4q4AwLzxnFeXh+utRBYj8P1hrKvaua0GX36LXakKbTtPa
	f3D9XhqtHWcffhXunmK4h3X3B4JhiA5Lgou3ksd8B4RVw0kgbJCqatnesxUpP6WpKmXqJT
	GyK2zBjULRz2gaocI63Ov4YD0H036E1WOLqC3LyIuwIbJrAkAchizajzesMAvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761737330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mv+1E8etoCgDP3bz8A9b50Vpx0C+KRGIBeAjz0H3eKU=;
	b=Zo4aZ89oxN92/246kUF9Gw2VR0NZsbpJ4SZkzfgAY7PVmQp533w21Z8pB5ehRvk/Zb6SRM
	6Cr46N2f02NfRxAA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Sahil Chandna <chandna.sahil@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>,
	syzbot+b0cff308140f79a9c4cb@syzkaller.appspotmail.com,
	andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com,
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
	linux-kernel@vger.kernel.org, listout@listout.xyz,
	martin.lau@linux.dev, netdev@vger.kernel.org, sdf@fomichev.me,
	song@kernel.org, syzkaller-bugs@googlegroups.com,
	linux-rt-devel@lists.linux.dev
Subject: Re: [syzbot] [bpf?] WARNING in bpf_bprintf_prepare (3)
Message-ID: <20251029112849.JpP8SlBO@linutronix.de>
References: <68f6a4c8.050a0220.1be48.0011.GAE@google.com>
 <14371cf8-e49a-4c68-b763-fa7563a9c764@linux.dev>
 <aPklOxw0W-xUbMEI@chandna.localdomain>
 <8dd359dd-b42f-4676-bb94-07288b38fac1@linux.dev>
 <aP5_JbddrpnDs-WN@chandna.localdomain>
 <95e1fd95-896f-4d33-956f-a0ef0e0f152c@linux.dev>
 <aQH5EtKBbklfH0Wq@chandna.localdomain>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aQH5EtKBbklfH0Wq@chandna.localdomain>

On 2025-10-29 16:52:58 [+0530], Sahil Chandna wrote:
> Shall I submit a patch with your suggested changes ?

would you mind waiting a bit?

> Regards,
> Sahil

Sebastian

