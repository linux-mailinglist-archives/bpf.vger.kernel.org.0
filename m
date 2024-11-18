Return-Path: <bpf+bounces-45088-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A5A9D1192
	for <lists+bpf@lfdr.de>; Mon, 18 Nov 2024 14:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C7C91F23246
	for <lists+bpf@lfdr.de>; Mon, 18 Nov 2024 13:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D0E19F103;
	Mon, 18 Nov 2024 13:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Wmv8surA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TN+9ygrN"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECEC19ABCB
	for <bpf@vger.kernel.org>; Mon, 18 Nov 2024 13:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731935614; cv=none; b=Z5zkGyUpOczlYN90atjjzJRj9tFh6lBZmbJ93Cv8sJJc9Q2+2aCSzOu2SqOevc+TjtaoLxZLlSlxn4DFMAWi/ntZmzc/O/eXSMkn5F9WdVvRpoeyAESNO6tSLasB2du0StQ0RCgFwSaW3WQttZgf9kXSIrLJPINH4unag7VwMQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731935614; c=relaxed/simple;
	bh=8HlmLLINpsRgOITtwVgov0iTf5puejiIwnhgOdYSDA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p16hRXiY/bkF2jqS4KTnIBn7JYdOi0zdZVgm2mSrQUfDkxKjTvqWqNvDo8ysq5FQcO8Sh8rTCpjEy7UcmGhv3ypsM4ROU+Lb4oB13EDbxMbQUvUPRqUzqzWM6WvW22UtDZS6hHdn+d62yhFPi5binfPoT0cy+erqWoMmy4XHFX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Wmv8surA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TN+9ygrN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 18 Nov 2024 14:13:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731935609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IDGY6urNwnHcj+DVKk96Kbkm8KOR/uO+ixZrXJZy9Ew=;
	b=Wmv8surAjzzcwq6O5YLZ4VMOKVIVdHag9MFCG30+MY/VOS6aGH6e6/3dFnxiTNQb28cDAg
	l46ROnp6yPcXpLY5idmbdUtiRh1qGYDF5xH+iwzZng1vNtGzcPaKzXhdwl3Mc9WOWs0JDC
	MIJUhy59oQSbBpediUo/s/OaH7keXqnnKJeRkU9JOCCIuqaILrGfcIcIMC08PwC/EjFT3k
	lJ7BYhCr3haR+sv1AEh1pUK+HakAi2m/PYEkZLQyQf0zxschNZl6am2SERixA+ZDlWt++y
	zPouQpXNFqn2QwizlXyBwe8/wuC+oEQ7CPMu+2lfAcwkkwSb9UB+TU6yIOBSZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731935609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IDGY6urNwnHcj+DVKk96Kbkm8KOR/uO+ixZrXJZy9Ew=;
	b=TN+9ygrNtwTKkmbyLUMBHzu2DSS3CXyGC66jBBmk2Za9TCON8nGbJ5OaMkr69KDP/s/lBw
	GqE6JUN+EtH0+ADg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	houtao1@huawei.com, xukuohai@huawei.com
Subject: Re: [PATCH bpf-next 04/10] bpf: Handle in-place update for full LPM
 trie correctly
Message-ID: <20241118131327.7s83iQCp@linutronix.de>
References: <20241118010808.2243555-1-houtao@huaweicloud.com>
 <20241118010808.2243555-5-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241118010808.2243555-5-houtao@huaweicloud.com>

On 2024-11-18 09:08:02 [+0800], Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> When a LPM trie is full, in-place updates of existing elements
> incorrectly return -ENOSPC.
> 
> Fix this by deferring the check of trie->n_entries. For new insertions,
> n_entries must not exceed max_entries. However, in-place updates are
> allowed even when the trie is full.

This and the previous patch look like a fix to an existing problem.
Shouldn't both have a fixes tag?

> Signed-off-by: Hou Tao <houtao1@huawei.com>

Sebastian

