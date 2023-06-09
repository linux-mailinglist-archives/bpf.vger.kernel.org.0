Return-Path: <bpf+bounces-2233-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BA9729C9D
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 16:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C061128196D
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 14:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58255182B5;
	Fri,  9 Jun 2023 14:19:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE7D17AC9
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 14:19:33 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C465635A9;
	Fri,  9 Jun 2023 07:19:31 -0700 (PDT)
Date: Fri, 9 Jun 2023 16:19:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1686320369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MYK4KNvEFkce/VyaNbpjmJmft8NrOeqE2CvuyKuAfes=;
	b=00/wnt2416KaOYbjeftQ8Aw+6g1+/xH5Bykdi+M2tCTxDTjKIH5TVVjahoeDe+387DvZm6
	jfj/q3HU0x5tkqj8+luaIWB4Le1dDXb66+AS8ZW5oaZaipeHwgtJrF35cD7xEDyS8Nl+BG
	peJuNm8aFmcpAKCssyvGB4OuETtzPdV3N6dKLQQpxf1NF/hwQy81tG+0ascouCLkjqFPYy
	kelvqqw9RjNA1OTEIzDORT3/uQZqc3pFjuT1Y4/vQnTg0P/c7NVVmVwuMxLVD5zLDK3yP/
	cFNnUQpkW73apHeq1L5liIAq2aAOQLQ5nCYnumvpNbfUPJvgFG9BnKGju6RapQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1686320369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MYK4KNvEFkce/VyaNbpjmJmft8NrOeqE2CvuyKuAfes=;
	b=/2PZz2T0R7tryMOE67dyWbMyv5wThnzmqRzYWYK6AeCsBz28nKSB6tV/RufqH3SpjOby9q
	TiGdhGrQFYAhRUDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3] bpf: Remove in_atomic() from bpf_link_put().
Message-ID: <20230609141928.CDC3_W5W@linutronix.de>
References: <20230509132433.2FSY_6t7@linutronix.de>
 <CAEf4BzZcPKsRJDQfdVk9D1Nt6kgT4STpEUrsQ=UD3BDZnNp8eQ@mail.gmail.com>
 <CAADnVQLzZyZ+cPqBFfrqa8wtQ8ZhWvTSN6oD9z4Y2gtrfs8Vdg@mail.gmail.com>
 <CAEf4BzY-MRYnzGiZmW7AVJYgYdHW1_jOphbipRrHRTtdfq3_wQ@mail.gmail.com>
 <20230525141813.TFZLWM4M@linutronix.de>
 <CAEf4Bzaipoo6X_2Fh5WTV-m0yjP0pvhqi7-FPFtGOrSzNpdGJQ@mail.gmail.com>
 <20230526112356.fOlWmeOF@linutronix.de>
 <CAEf4Bzawgrn2DhR9uvXwFFiLR9g+j4RYC6cr3n+eRD_RoKBAJA@mail.gmail.com>
 <20230605163733.LD-UCcso@linutronix.de>
 <CAEf4BzZ=VZcLZmtRefLtRyRb7uLTb6e=RVw82rxjLNqE=8kT-w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEf4BzZ=VZcLZmtRefLtRyRb7uLTb6e=RVw82rxjLNqE=8kT-w@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023-06-05 15:47:23 [-0700], Andrii Nakryiko wrote:
> I understand it's safe today, but I'm more worried for future places
> that will do bpf_link_put(). Given it's only close() and BPF FS
> unlink() that require synchronous semantics, I think it's fine to make
> bpf_link_put() to be async, and have bpf_link_put_sync() (or direct,
> or whatever suffix) as a conscious special case.

Okay, let me do that then.

> > This is invoked from the RCU callback (which is usually softirq):
> >         destroy_inode()
> >          -> call_rcu(&inode->i_rcu, i_callback);
> >
> > Freeing memory is fine but there is a mutex that is held in the process.
> 
> I think it should be fine for BPF link destruction then?

bpf_any_put() needs that "may sleep" exception for BPF_TYPE_LINK if it
comes from RCU.
I will swap that patch to be async by default and make sync for
bpf_any_put() if called from close (except for the RCU case).

Sebastian

