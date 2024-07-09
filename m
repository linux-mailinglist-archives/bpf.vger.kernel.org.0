Return-Path: <bpf+bounces-34193-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1638092AF61
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 07:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41D9F1C213FD
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 05:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F1812D74F;
	Tue,  9 Jul 2024 05:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2dKBCNNb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JmlU6NuU"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0049D139F;
	Tue,  9 Jul 2024 05:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720502303; cv=none; b=R+cJw71sngOh0n0Fl6WBzEkxzzI9/CCbCzQHskdJpC5RsTv17ibK6Ilh0AvEHt8Vt7Nye+tYnipA+hSx/NEdeTKrBKl5eDrNRBhvYxX4Wpb697oPrLnGTkX4eSQyKuiyjah24S/KaiKmpCaOZwyCcpH7WrHU2e1qJJ66SP13icg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720502303; c=relaxed/simple;
	bh=qgpD9Xm3eIAvemJyHOC25PJSBE/ZeCv6E8FFQ90B4Co=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=saTSKf4uVseKmXpzFIQxc+i76U1GmsWiHBNn2UHMECNUWSnqkIajoID1cAzTifh57qg7uGHyh4cV7go/Ne37DPiLwDaQ+WAUVY2l5SWZSud2bT8Dp035sabzj7eKqP644xOLGvy+AA9z1KPxjTYSOtt1yTfcMH/tVqhPmwgGmbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2dKBCNNb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JmlU6NuU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 9 Jul 2024 07:18:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720502298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e5INdA8Zpb1j7Zp4xb0ZccJRNZV3+GT9QnSCw5XbqyI=;
	b=2dKBCNNbI6h3X7HgP9Zi9x/bnTdMYTJacq1mszuTqdgL0jZUt0fPiYeMQnnwMdSByC5F8a
	v5sdusMkYoFfgNNeWO/3I8qHf/H/NyFSpAweAJD+iItbYc+4C6fYGzArzNfh/Ktq024SdQ
	uJ8R6sChiqBKx4bWNVnNCh7VpJyNmPbyVAZ4WaOtxgot7mf7LVugWLdQOQ5gScurLpYc7y
	K4bCq6ZNSC8pBp1GSMQJQ0dWHlsVGJCmeuGu9Y6LO/gic6Z/w/Kkpnx54gbvcsmMjJktGG
	X+e5hSCkMmt7JMLd7Z8X150HdCgjXzDzQhKTqMgVOSs0Qv4Q6Jyq2ETgMfqgng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720502298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e5INdA8Zpb1j7Zp4xb0ZccJRNZV3+GT9QnSCw5XbqyI=;
	b=JmlU6NuU673AYVBpuYTObef2UioCawPtY6O3yxMWciEPsieqKkNMGS4/BTj8KeI7nC1I3U
	J21UKFkQE2gt2sDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: syzbot <syzbot+608a2acde8c5a101d07d@syzkaller.appspotmail.com>,
	netdev@vger.kernel.org, bpf@vger.kernel.org, andrii@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
	dsahern@kernel.org, eddyz87@gmail.com, edumazet@google.com,
	haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org,
	kpsingh@kernel.org, kuba@kernel.org, pabeni@redhat.com,
	sdf@fomichev.me, sdf@google.com, song@kernel.org,
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH bpf-next] seg6: Ensure that seg6_bpf_srh_states can only
 be accessed from input_action_end_bpf()
Message-ID: <20240709051817.VmyBTQ86@linutronix.de>
References: <000000000000571681061bb9b5ad@google.com>
 <20240705104133.NU9AwKDS@linutronix.de>
 <82c77e30-6e9d-44c3-bdcd-7da17654fa81@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <82c77e30-6e9d-44c3-bdcd-7da17654fa81@linux.dev>

On 2024-07-08 17:03:58 [-0700], Martin KaFai Lau wrote:
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index 403d23faf22e1..ea5bc4a4a6a23 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -6459,6 +6459,8 @@ BPF_CALL_4(bpf_lwt_seg6_store_bytes, struct sk_buff *, skb, u32, offset,
> >   	void *srh_tlvs, *srh_end, *ptr;
> >   	int srhoff = 0;
> > +	if (!bpf_net_ctx_seg6_state_avail())
> > +		return -EINVAL;
> 
> The syzbot stack shows that the seg6local bpf_prog can be run by test_run
> like: bpf_prog_test_run_skb() => bpf_test_run(). "return -EINVAL;" will
> reject and break the existing bpf prog doing test with test_run.

But wouldn't this be the case anyway because seg6_bpf_srh_states::srh
isn't assigned?

> bpf_test_run() has already done the local_bh_disable() and
> bpf_net_ctx_set(). How about doing the
> local_[un]lock_nested_bh(&seg6_bpf_srh_states.bh_lock) in bpf_test_run()
> when the prog->type == BPF_PROG_TYPE_LWT_SEG6LOCAL?

Okay. Sure. And I assume it is limited that only those two call paths
can invoke this type of BPF program.

Sebastian

