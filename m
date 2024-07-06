Return-Path: <bpf+bounces-33991-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 294249293B8
	for <lists+bpf@lfdr.de>; Sat,  6 Jul 2024 15:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D19A11F21C24
	for <lists+bpf@lfdr.de>; Sat,  6 Jul 2024 13:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2718412F398;
	Sat,  6 Jul 2024 13:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IjUDjFLE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="srWxZbri"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C664C79;
	Sat,  6 Jul 2024 13:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720271608; cv=none; b=NWKBj4VGXoy3ko8Hi5bfKHLtDsFV66w9rv8Nhetk0ktWkj5ZPC5Ng6z8hoLVKuQTOQbDxY4oyBKONC8IWkXpx8RhKtjy7LTm52luEfNTJKHk6zIN0KvNEi7J93Sy7NZr3aASQavXcFfC9kgVtGWfgKX0l8Qig3Tb3BsfZjWdf+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720271608; c=relaxed/simple;
	bh=ZrTRU6FJcwcvxcjQ5CaOXSXfqPwR5U88tYXX6lDz9oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i48DphuNPXtMRicPjDBuX9YRbiIU8RDcoI/cTiz7ABfkWprIKx74hLegE3tpjOJXHGilDqbgf9BMGtvZyCwDXqt2P3IjQ7hSFdChReBMOVkOntek0RZgEcBSh7eH3OqpP1Gew73WR/0US5/mvtW7Onh52vHvBS6U2QuziGj/hic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IjUDjFLE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=srWxZbri; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 6 Jul 2024 15:13:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720271599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZrTRU6FJcwcvxcjQ5CaOXSXfqPwR5U88tYXX6lDz9oo=;
	b=IjUDjFLEkP2tgYGO0WSs/0SLi1vxxL2ZioqNlFjVtI3bgBepDAdZ/5gjL2FHDA3XgvxC6O
	zXNqrb3/ctq8onRnDpOOh+BzRdZO3FABhcRhJ4Wl+D3bDfyIyeIHa6Jp9a/pomt66W0JZx
	18B7U/PiH8BbYtF7BEqolVHxw7DjjPeQGgvmv7ZQQFKsy1/Qo2kHnln9Sva39kSXtK6A5X
	hE+/42Lx1Y0UQa0qLjASF639Bi5TmzaByYN0X25a9eGLntRsD1In+wEyS5CIHLsPUuYche
	gH70D2uZUE1nQs0vML3/2BjdBvJLlSUeTgiEFJfVsztIIIJ4PwORjGigZjAhcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720271599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZrTRU6FJcwcvxcjQ5CaOXSXfqPwR5U88tYXX6lDz9oo=;
	b=srWxZbrilrJ6z+Ql+CVnw0cehffOu4VCMfjyX27q7OU7UCMxAPDzSQFLQHSQlX4PuGt4OF
	pA2VuziMzbuosyBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: syzbot <syzbot+08811615f0e17bc6708b@syzkaller.appspotmail.com>,
	syzbot <syzbot+380f7022f450dd776e64@syzkaller.appspotmail.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
	daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com,
	haoluo@google.com, hawk@kernel.org, john.fastabend@gmail.com,
	jolsa@kernel.org, kpsingh@kernel.org, kuba@kernel.org,
	linux-kernel@vger.kernel.org, martin.lau@linux.dev,
	netdev@vger.kernel.org, patchwork-bot@kernel.org, sdf@fomichev.me,
	song@kernel.org, syzkaller-bugs@googlegroups.com,
	yonghong.song@linux.dev
Subject: Re: [syzbot] [bpf?] [net?] general protection fault in
 dev_map_redirect
Message-ID: <20240706131317.Vx3MriDC@linutronix.de>
References: <000000000000adb970061c354f06@google.com>
 <000000000000767898061c8e30e8@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <000000000000767898061c8e30e8@google.com>

#syz fix: tun: Assign missing bpf_net_context.
#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git main

Sebastian

