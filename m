Return-Path: <bpf+bounces-19454-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9500A82BF2C
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 12:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBF451C22E79
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 11:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E2067E8A;
	Fri, 12 Jan 2024 11:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OWbqIxGY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JdeACgwt"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693B064CFF;
	Fri, 12 Jan 2024 11:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 12 Jan 2024 12:23:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705058637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ipRmzQ27dl1DxnG+lFoUSErLcW1ZeSdEpT87MdBHov8=;
	b=OWbqIxGYriukbUuN3UMPklkgruSimjDJSDUOwZ5gBcO0O0DDs0Yz/NMj3gNm5LDTT+M10q
	uWTbxGDIWi2mAwtPP8Rxr0hIaAQTbwiDYy/T94L1MypdJ5dREUmbTKW+4L0BqzdmcYkBUg
	QBzw0257rqdWGTtxj5YAP21j5ip+5sjCiEKNr/fAodeDFbtmOgJVYwwyo+vPanLrcJPztN
	g/CmxWfcvyJ0qMlvxEzcxL+lH3sTMivUUcaQ1lf2ZHmAWRCg84u4Mts42BUPxCUk4eA+a9
	zIuUvov5uKxL9FTkij35cgRyPKvGOkEMjZlFdTnvdDwIldEwv/nieuZJaMYJQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705058637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ipRmzQ27dl1DxnG+lFoUSErLcW1ZeSdEpT87MdBHov8=;
	b=JdeACgwtioEI2COU5SpvVfU1cwQPg/wWwhEkVp+hhJLmUw8TlVFHJ6c4tXwbBnjcQkd74r
	GDlENmh/5R6pSSCw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Boqun Feng <boqun.feng@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	David Ahern <dsahern@kernel.org>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 12/24] seg6: Use nested-BH locking for
 seg6_bpf_srh_states.
Message-ID: <20240112112355.k1vpvtth@linutronix.de>
References: <20231215171020.687342-1-bigeasy@linutronix.de>
 <20231215171020.687342-13-bigeasy@linutronix.de>
 <a8d155ec7d43bf3308fcfa3387dc16d1723617c6.camel@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a8d155ec7d43bf3308fcfa3387dc16d1723617c6.camel@redhat.com>

On 2023-12-18 09:33:39 [+0100], Paolo Abeni wrote:
> > --- a/net/ipv6/seg6_local.c
> > +++ b/net/ipv6/seg6_local.c
> > @@ -1420,41 +1422,44 @@ static int input_action_end_bpf(struct sk_buff *skb,
> >  	}
> >  	advance_nextseg(srh, &ipv6_hdr(skb)->daddr);
> >  
> > -	/* preempt_disable is needed to protect the per-CPU buffer srh_state,
> > -	 * which is also accessed by the bpf_lwt_seg6_* helpers
> > +	/* The access to the per-CPU buffer srh_state is protected by running
> > +	 * always in softirq context (with disabled BH). On PREEMPT_RT the
> > +	 * required locking is provided by the following local_lock_nested_bh()
> > +	 * statement. It is also accessed by the bpf_lwt_seg6_* helpers via
> > +	 * bpf_prog_run_save_cb().
> >  	 */
> > -	preempt_disable();
> > -	srh_state->srh = srh;
> > -	srh_state->hdrlen = srh->hdrlen << 3;
> > -	srh_state->valid = true;
> > +	scoped_guard(local_lock_nested_bh, &seg6_bpf_srh_states.bh_lock) {
> > +		srh_state = this_cpu_ptr(&seg6_bpf_srh_states);
> > +		srh_state->srh = srh;
> > +		srh_state->hdrlen = srh->hdrlen << 3;
> > +		srh_state->valid = true;
> 
> Here the 'scoped_guard' usage adds a lot of noise to the patch, due to
> the added indentation. What about using directly
> local_lock_nested_bh()/local_unlock_nested_bh() ?

If this is preferred, sure.

> Cheers,
> 
> Paolo

Sebastian

