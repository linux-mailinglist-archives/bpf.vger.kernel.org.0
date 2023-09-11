Return-Path: <bpf+bounces-9621-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 135A279A3E8
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 08:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C336A2810C3
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 06:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557D13C24;
	Mon, 11 Sep 2023 06:50:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EF6188;
	Mon, 11 Sep 2023 06:50:23 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AABF6106;
	Sun, 10 Sep 2023 23:50:22 -0700 (PDT)
Date: Mon, 11 Sep 2023 08:50:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1694415020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a2io0zqAD/xA8XIZ8XPgfhYmExX7VHlsM0djcORO23k=;
	b=O+Z1pwtXZF4A9BpeMvuDPjm8QM4M/uuIz647UfZ1o+DINIeJWZLDAYCGiXAuNG91AebBP+
	Niv9fWxQO7P2TWB7CRKGWolPhwob8IFMD//nHJBfiTIvlDclQnByh2Bzz/+fk8F81HyCE5
	OczF46ElHw2TyhSRflorrr63YIJUc6jy94UcYQhaH5vNeWvjF9oss0sTKMjS/LbE4QmhXO
	IkG5w3/XMmBUkkV87IGUl1yfjQNUEBjzneKhMqSX2WklZF3hEh3h3rX9zo1Rg4NpibC1Lr
	PauU9bspR++AguOiukXqkysM42+lD8Kntv/mmE4dIG3xph8KJt/a/FqiZULXvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1694415020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a2io0zqAD/xA8XIZ8XPgfhYmExX7VHlsM0djcORO23k=;
	b=F9AP7NtqxRIzr7aw1tUlWfEjw1Vhjk/Y9lNePmxwRqlAC3n2CCwC0e/kcPVqhwzY+y3rPV
	YeOK4Fj19AroAiAA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Hou Tao <houtao@huaweicloud.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrii Nakryiko <andrii@kernel.org>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>, KP Singh <kpsingh@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH net 4/4] bpf, cpumap: Flush xdp after
 cpu_map_bpf_prog_run_skb().
Message-ID: <20230911065016.IkkQJSfN@linutronix.de>
References: <20230908135748.794163-1-bigeasy@linutronix.de>
 <20230908135748.794163-5-bigeasy@linutronix.de>
 <1cf255a3-e48b-0a90-28ce-1a9c47095fc2@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1cf255a3-e48b-0a90-28ce-1a9c47095fc2@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023-09-09 10:49:09 [+0800], Hou Tao wrote:
> Hi,
Hi,

> > --- a/kernel/bpf/cpumap.c
> > +++ b/kernel/bpf/cpumap.c
> > @@ -248,12 +248,12 @@ static int cpu_map_bpf_prog_run(struct bpf_cpu_map_entry *rcpu, void **frames,
> >  
> >  	nframes = cpu_map_bpf_prog_run_xdp(rcpu, frames, xdp_n, stats);
> >  
> > -	if (stats->redirect)
> > -		xdp_do_flush();
> > -
> >  	if (unlikely(!list_empty(list)))
> >  		cpu_map_bpf_prog_run_skb(rcpu, list, stats);
> >  
> > +	if (stats->redirect)
> > +		xdp_do_flush();
> > +
> 
> The purpose of xdp_do_flush() is to flush xdp frames stashed in per-cpu
> cpu_map_flush list into xdp_bulk_queue. But for redirected skbs, these
> skbs will be directly added into xdp_bulk_queue() in
> cpu_map_generic_redirect(), so I think xdp_do_flush() is not needed for
> redirected skbs.

Now that I checked the down streams of cpu_map_bpf_prog_run_skb() it
does not queue anything to the per-CPU lists like I assumed.  You are
right, it is no needed.

Sorry for the confusion.

> >  	rcu_read_unlock_bh(); /* resched point, may call do_softirq() */
> >  
> >  	return nframes;
> 

Sebastian

