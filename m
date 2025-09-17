Return-Path: <bpf+bounces-68601-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 921C3B7CD07
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 14:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19E76520AFD
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 01:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C2D1FCF41;
	Wed, 17 Sep 2025 01:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NsCimc8J"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AC628695
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 01:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758072683; cv=none; b=rrxa4Uis0nwRVztimcUJzEhM2Rity8ekRruxBxBa9imfTk8hEytZ5xZucemDnX3qv54H/YgtKgyNBbBwvvIGMmzMWwUNIQFgd1BhMB49ISkx/oA3be3eyCo/XdLlBIrX8QgCpTPcx847TKTJP6ASwda979ZgquXG6osww9jwbiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758072683; c=relaxed/simple;
	bh=u5lW0pLv9+4EhUqqIY0EojsmYLqqRNzsPVGJzyPzyTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i8PTb9SCOZKWMww4DxvRWoI7Iji4zYnleq6BF7vePYyznorcKxTQnyPs1iyHXx80yT3v0JPTPAq1g9ZEADap1J6pCLOOaB0uoeDGZLzGuZyAKlpEz9J2Hd50vqnVGkknjH6bLBVwqER/fMG0yaeHLt5sqJF4SZaq6RD6uhWLW8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NsCimc8J; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758072678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wMoURYW4sWpgUzsRJYLqTrN7wpP/NRlYSdFQVLQpJhU=;
	b=NsCimc8J7ba8Gd+n1xwEGaiyX/ESmyzNZnAV/C6ZU8u9xl4Pf0AwM5gJP8jaNqgSwgQvpz
	tBBwvfDQktfmuF9biYsR3cDnByOHS1zDySMHxK+4O1klIFh+1v9BgKzajt/Vt8fH/DFAsM
	C4hFu3mtfydmYcFki3ulbJRMlCR51iI=
From: Menglong Dong <menglong.dong@linux.dev>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Alexei Starovoitov <ast@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Benjamin Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, tzimmermann@suse.de, simona.vetter@ffwll.ch,
 Jani Nikula <jani.nikula@intel.com>, LKML <linux-kernel@vger.kernel.org>,
 bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH v4 2/3] sched: make migrate_enable/migrate_disable inline
Date: Wed, 17 Sep 2025 09:30:50 +0800
Message-ID: <2383379.ElGaqSPkdT@7940hx>
In-Reply-To:
 <CAADnVQ+KzOiDeq5WrM-08js7XEH_CU0D9cb+a5iV_JsMm+RyWA@mail.gmail.com>
References:
 <20250828060354.57846-1-menglong.dong@linux.dev> <5041847.31r3eYUQgx@7940hx>
 <CAADnVQ+KzOiDeq5WrM-08js7XEH_CU0D9cb+a5iV_JsMm+RyWA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2025/9/17 09:29 Alexei Starovoitov <alexei.starovoitov@gmail.com> write:
> On Tue, Sep 16, 2025 at 6:26=E2=80=AFPM Menglong Dong <menglong.dong@linu=
x.dev> wrote:
> >
> > On 2025/9/16 19:07 Peter Zijlstra <peterz@infradead.org> write:
> > > On Thu, Aug 28, 2025 at 02:03:53PM +0800, Menglong Dong wrote:
> > >
> > > > +/* The "struct rq" is not available here, so we can't access the
> > > > + * "runqueues" with this_cpu_ptr(), as the compilation will fail in
> > > > + * this_cpu_ptr() -> raw_cpu_ptr() -> __verify_pcpu_ptr():
> > > > + *   typeof((ptr) + 0)
> > > > + *
> > > > + * So use arch_raw_cpu_ptr()/PERCPU_PTR() directly here.
> > > > + */
> > >
> > > Please fix broken comment style while you fix that compile error.
> >
> > It's a little embarrassing. The compile error is caused by the commit
> > 1b93c03fb319 ("rcu: add rcu_read_lock_dont_migrate()") in bpf-next tree,
> > which uses migrate_enable/migrate_disable in include/linux/rcupdate.h
> > but include the <linux/preempt.h>.
> >
> > I can fix it by replace the linux/preempt.h with linux/sched.h, but sho=
uld
> > I fix it in this series? I mean, the commit 1b93c03fb319 doesn't exist =
in
> > the tip for now :/
>=20
> If it's just a different include then go for it.
> Make sure there are no nasty build issues during the merge window.

OK!

>=20





