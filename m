Return-Path: <bpf+bounces-36937-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5F794F775
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 21:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDE021F22A69
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 19:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72641917C0;
	Mon, 12 Aug 2024 19:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SzDO81X+"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A9018F2CB
	for <bpf@vger.kernel.org>; Mon, 12 Aug 2024 19:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723490718; cv=none; b=oRaBjYIsvivQvcPF6McvHppDovD1rQkyc+5Nz6saMaDB2ZU5Y1G/eOot19+Gvw/Ms6ekOPH8F7OmWk4Ze/2VsCdahJBIUh1afmwvt5oDTxuq86mLE8mLO/m00L57PKv4yNcDd+XyQWJ9bo7h3oVKrPdl784z/7jnM04icc/Uesg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723490718; c=relaxed/simple;
	bh=iaYZkpwvbW8Fxk0F02wbvEY/BH18iaDQKbywqSsY6CM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TbmFIYjJdGK68IywB3RBRLVYQ5mlKLH6XpDlc3Kky8uh83HfkPkhJNGWNvdfkekA6821pL19DfWPgkbD3cUG+FUB3ldQlg325elkpUjrxsYawQbAa93+U+6cEXEo1HNSi13x6NtHyFh6kNXJbN1foUXWSUlDkh2H9ty2NkL26mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SzDO81X+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723490716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V0i5d9v7X1l3ubpz0F2qG2g28SR1YyQRgT0SFjyAASI=;
	b=SzDO81X+oxMvwvwizfaBKkbaimiPwPXw9yKlICwaVI8s+eDyQ9e9r+LcHOclQLozqu7ET2
	bjstJB/Qtszh9qtpMwTJBhM87VN6iJzSEzW2uqiuDI/61n6/Rj4VHwGgaGFhU1tpa1j7Xt
	gq918rXRp/+BynZicwrSjTO86r47GEI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-128-lA2PaeWKMh2j0Hy6U-uE_Q-1; Mon,
 12 Aug 2024 15:25:11 -0400
X-MC-Unique: lA2PaeWKMh2j0Hy6U-uE_Q-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 18AE5188FE4F;
	Mon, 12 Aug 2024 19:25:01 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.73])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 1CFDE19541B6;
	Mon, 12 Aug 2024 19:24:35 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 12 Aug 2024 21:24:54 +0200 (CEST)
Date: Mon, 12 Aug 2024 21:24:31 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: syzbot <syzbot+f7a1c2c2711e4a780f19@syzkaller.appspotmail.com>,
	Andrii Nakryiko <andrii@kernel.org>, jolsa@kernel.org,
	acme@kernel.org, adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com, irogers@google.com,
	kan.liang@linux.intel.com, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, mark.rutland@arm.com,
	mhiramat@kernel.org, mingo@redhat.com, namhyung@kernel.org,
	peterz@infradead.org, syzkaller-bugs@googlegroups.com,
	bpf <bpf@vger.kernel.org>
Subject: Re: [syzbot] [perf?] KASAN: slab-use-after-free Read in
 __uprobe_unregister
Message-ID: <20240812192405.GD11656@redhat.com>
References: <000000000000382d39061f59f2dd@google.com>
 <20240811121444.GA30068@redhat.com>
 <20240811123504.GB30068@redhat.com>
 <CAEf4Bza8Ptd4eLfhqci2OVgGQZYrFC-bn-250ErFPcsKzQoRXA@mail.gmail.com>
 <20240812100028.GA11656@redhat.com>
 <CAEf4BzZ6coCZHY_KMnSQQUyc_-xziKurOQ0j3xaCvHhnDaafuQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZ6coCZHY_KMnSQQUyc_-xziKurOQ0j3xaCvHhnDaafuQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 08/12, Andrii Nakryiko wrote:
>
> adding bpf ML, given it's bpf's code base

Thanks,

> On Mon, Aug 12, 2024 at 3:00 AM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > > --- a/kernel/trace/bpf_trace.c
> > > +++ b/kernel/trace/bpf_trace.c
> > > @@ -3491,8 +3491,10 @@ int bpf_uprobe_multi_link_attach(const union
> > > bpf_attr *attr, struct bpf_prog *pr
> > >         }
> > >
> > >         err = bpf_link_prime(&link->link, &link_primer);
> > > -       if (err)
> > > +       if (err) {
> > > +               bpf_uprobe_unregister(&path, uprobes, cnt);
> >
> > I disagree. This code already uses the "goto error_xxx" pattern, why
>
> Well, if you have strong preferences,

Well, YES and NO ;) please see below.

> so be it (it's too trivial code
> to argue about).

Agreed. On a closer look both the code and the problem look very trivial.

But note that nobody noticed this trivial problem before. Including me who
had to change this trivial code to adapt to the recent API changes.

May be this means that we should keep the error handling in this function
more consistent ;)

> We do have quite a lot of "hybrid" error handling

And YES, I don't like this kind of error handling.

But, at the same time: NO, I never-never argue with the maintainers when it
comes to "cosmetic" issues.

My main point was (and you seem to agree) that this simpler patch above won't
simplify the routing. I too thought about the change above initially.

-------------------------------------------------------------------------------
> Yep, absolutely, given the bpf_uprobe_unregister() change, I don't see
> any problem for it to go together with your refactorings.
>
> For the fix:
>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>

Thanks! I'll write the changelog and send this patch with your ack included
tomorrow.

Oleg.


