Return-Path: <bpf+bounces-45256-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6229D3841
	for <lists+bpf@lfdr.de>; Wed, 20 Nov 2024 11:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91375285C33
	for <lists+bpf@lfdr.de>; Wed, 20 Nov 2024 10:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17037198E69;
	Wed, 20 Nov 2024 10:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CB9pfzxo"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F4C174EDB
	for <bpf@vger.kernel.org>; Wed, 20 Nov 2024 10:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732098180; cv=none; b=NlSptyoA0dOgxhU7W/5NHeFeh5mspjfdKAtG3UqgdPoHvF6diNaphVcyNhpUO4W8KNs5prFLZ3r7flmkNY+uHVkZrU3rCDlkAMMNPJILh7d7zCrPCZMw5q9K8am503DF9Gn19g5tDrB6SKsPwWJZ07Zfz8JBnP64CdvlYVIbVY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732098180; c=relaxed/simple;
	bh=kJQDEeMh5yQymd7/4zNyXAyvNMvAn8pbTvK9MW3F1j4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C8iOJ4AicpWCO+Tga7G8j4DQtYxKG/oM96aNW8O0XisBCk/SXZKgfuIhjft6yMol9xIIhnn1MNq5YHI8pPf4V3WojzzsFto27U2DulHPnQouVpbSkmjGRd1VSgIYTcB+pRKhwrfjaA9dTTZJjUTWvK8sIK7oAajCzm3Rf4irVwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CB9pfzxo; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6BHYRXy9lLaaBbd09VImTq6Rn50W4X4567EqZRkeTsQ=; b=CB9pfzxoXqNdnea45S13GW9nVz
	OiMmlRet2bv4yQjYfZUir1rmaicloAg0pVBGRuIjsJ086tAjDiP5d/vkTpeM7AdCzbuPdOcLgtTnf
	16s9gXgpwYsh0BYhQP/YIP8EUR/oQjVbi18ayEvx7NktKnB+cttBWZOrefugTlVa8jpZ9p2lTqXlw
	38U5AEbLbyu0v+ssq8oub7kzzElAb/wUORNzUz9cQXeRTJh0QxuvPxaNrjHqkzi8SYaz/lSntiay3
	SPIHCBEOosL4kWT3+2JRT04nREsm8heOOUdOgkm90wTxYr1oUWty25O1g2tuDCZcAxfyVPCYQKJiW
	kM7zG+ZQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tDhqm-00000000SnB-3qXl;
	Wed, 20 Nov 2024 10:22:21 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 04D013006AB; Wed, 20 Nov 2024 11:22:20 +0100 (CET)
Date: Wed, 20 Nov 2024 11:22:19 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
	bpf@vger.kernel.org, x86@kernel.org, rcu@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Wanpeng Li <wanpengli@tencent.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Jason Baron <jbaron@akamai.com>, Kees Cook <keescook@chromium.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Juerg Haefliger <juerg.haefliger@canonical.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Nadav Amit <namit@vmware.com>, Dan Carpenter <error27@gmail.com>,
	Chuang Wang <nashuiliang@gmail.com>,
	Yang Jihong <yangjihong1@huawei.com>,
	Petr Mladek <pmladek@suse.com>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>, Song Liu <song@kernel.org>,
	Julian Pidancet <julian.pidancet@oracle.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Dionna Glaze <dionnaglaze@google.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Juri Lelli <juri.lelli@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Yair Podemsky <ypodemsk@redhat.com>,
	Daniel Wagner <dwagner@suse.de>, Petr Tesarik <ptesarik@suse.com>
Subject: Re: [RFC PATCH v3 06/15] jump_label: Add forceful jump label type
Message-ID: <20241120102219.GF19989@noisy.programming.kicks-ass.net>
References: <20241119153502.41361-1-vschneid@redhat.com>
 <20241119153502.41361-7-vschneid@redhat.com>
 <20241120000532.maqzgsn7m34lti6u@jpoimboe>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120000532.maqzgsn7m34lti6u@jpoimboe>

On Tue, Nov 19, 2024 at 04:05:32PM -0800, Josh Poimboeuf wrote:
> On Tue, Nov 19, 2024 at 04:34:53PM +0100, Valentin Schneider wrote:
> > +++ b/include/linux/jump_label.h
> > @@ -200,7 +200,8 @@ struct module;
> >  #define JUMP_TYPE_FALSE		0UL
> >  #define JUMP_TYPE_TRUE		1UL
> >  #define JUMP_TYPE_LINKED	2UL
> > -#define JUMP_TYPE_MASK		3UL
> > +#define JUMP_TYPE_FORCEFUL      4UL
> > +#define JUMP_TYPE_MASK		7UL
> 
> Hm, I don't think we can (ab)use this pointer bit on 32-bit arches, as
> the address could be 4 byte aligned?

Right, you can force the alignment of the thing, workqueues do similar
hacks to get more bits.

