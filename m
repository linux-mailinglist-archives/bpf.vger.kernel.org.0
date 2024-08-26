Return-Path: <bpf+bounces-38095-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF9B95F930
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 20:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CDA61F23238
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 18:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB7B198E83;
	Mon, 26 Aug 2024 18:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V+8TfrQ2"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CF9768FD
	for <bpf@vger.kernel.org>; Mon, 26 Aug 2024 18:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724698115; cv=none; b=EIy4GZGXBeiGdQ9Kr/ergYxYzQwQpttj1HtrmaIShnZFswg2Rv1kAF2mF8cIk/ZLDjgZwkKu3fthjpuqciwfMs2wTOcZvo4YNoEJ+0K4LTQP1Z+b+7i2YULOIeeDSreDvYz/Z4uaiFZ1+wsBYYbIyomgONn7xKGksJF6U2dUefI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724698115; c=relaxed/simple;
	bh=EiEe1+ONZhy0DMtBG+AiOFsgeB681Pwsf2p93wZ1cQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GuH1HweS7YFqtUtbqI4drq8A6A6LHk6xuQZGWbA/Ji/5IOA8FlVLATELpKWAy/N9cfBjZ4DEvaMZ5Hm+1aLYsyvlnuZa97JTZkxesLvf015AVspC8qin05TcYzUfj2+olsIF3RqFo21xDQEPUd8tu5R9nBnvjzw25IDBXAJfRJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V+8TfrQ2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724698112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KBwWIF15moftoUIZC46ahJXVO1ZjxBGUC6YpiTLQ/4o=;
	b=V+8TfrQ2HGAZRXyrTT1elrwi0ofokejk1fShA69NNgXQD9SCoY7GO2O10+jjs68SMpYGKS
	mXcQA0RI69eNPYQTQDWkyfhAoggBy96ZDMfH5JOUvVKen/c+4+WLBrFgS3KrskXbqjHL01
	bbLtvMqCKOuh4R1xIdM55ILalzs4eOQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-298-BjvKq1OjMXu6cLLofMO5VQ-1; Mon,
 26 Aug 2024 14:48:31 -0400
X-MC-Unique: BjvKq1OjMXu6cLLofMO5VQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 30CF21955D48;
	Mon, 26 Aug 2024 18:48:27 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.22.65.61])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B768F30001A1;
	Mon, 26 Aug 2024 18:48:20 +0000 (UTC)
Date: Mon, 26 Aug 2024 14:48:18 -0400
From: Phil Auld <pauld@redhat.com>
To: Sedat Dilek <sedat.dilek@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>, dwarves@vger.kernel.org,
	Jiri Olsa <olsajiri@gmail.com>, masahiroy@kernel.org,
	linux-kernel@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, linux-kbuild@vger.kernel.org,
	bpf@vger.kernel.org, msuchanek@suse.com
Subject: Re: [RFC] kbuild: bpf: Do not run pahole with -j on 32bit userspace
Message-ID: <20240826184818.GC117125@pauld.westford.csb>
References: <20240820085950.200358-1-jirislaby@kernel.org>
 <ZsSpU5DqT3sRDzZy@krava>
 <523c1afa-ed9d-4c76-baea-1c43b1b0c682@kernel.org>
 <c2086083-4378-4503-b3e2-08fb14f8ff37@kernel.org>
 <7ebee21d-058f-4f83-8959-bd7aaa4e7719@kernel.org>
 <a45nq7wustxrztjxmkqzevv3mkki5oizfik7b24gqiyldhlkhv@4rpy4tzwi52l>
 <ZsdYGOS7Yg9pS2BJ@x1>
 <f170d7c2-2056-4f47-8847-af15b9a78b81@kernel.org>
 <Zsy1blxRL9VV9DRg@x1>
 <CA+icZUWMxzAFtr8vsUUQ9OCR68K=F6d6MANx8HMTQntq494roA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+icZUWMxzAFtr8vsUUQ9OCR68K=F6d6MANx8HMTQntq494roA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Mon, Aug 26, 2024 at 08:42:10PM +0200 Sedat Dilek wrote:
> On Mon, Aug 26, 2024 at 7:03 PM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > On Mon, Aug 26, 2024 at 10:57:22AM +0200, Jiri Slaby wrote:
> > > On 22. 08. 24, 17:24, Arnaldo Carvalho de Melo wrote:
> > > > On Thu, Aug 22, 2024 at 11:55:05AM +0800, Shung-Hsi Yu wrote:
> > > > I stumbled on this limitation as well when trying to build the kernel on
> > > > a Libre Computer rk3399-pc board with only 4GiB of RAM, there I just
> > > > created a swapfile and it managed to proceed, a bit slowly, but worked
> > > > as well.
> > >
> > > Here, it hits the VM space limit (3 G).
> >
> > right, in my case it was on a 64-bit system, so just not enough memory,
> > not address space.
> >
> > > > Please let me know if what is in the 'next' branch of:
> >
> > > > https://git.kernel.org/pub/scm/devel/pahole/pahole.git
> >
> > > > Works for you, that will be extra motivation to move it to the master
> > > > branch and cut 1.28.
> >
> > > on 64bit (-j1):
> > > * master: 3.706 GB
> > > (* master + my changes: 3.559 GB)
> > > * next: 3.157 GB
> >
> > > on 32bit:
> > >  * master-j1: 2.445 GB
> > >  * master-j16: 2.608 GB
> > >  * master-j32: 2.811 GB
> > >  * next-j1: 2.256 GB
> > >  * next-j16: 2.401 GB
> > >  * next-j32: 2.613 GB
> > >
> > > It's definitely better. So I think it could work now, if the thread count
> > > was limited to 1 on 32bit. As building with -j10, -j20 randomly fails on
> > > random machines (32bit processes only of course). Unlike -j1.
> >
> > Cool, I just merged a patch from Alan Maguire that should help with the
> > parallel case, would be able to test it? It is in the 'next' branch:
> >
> > ⬢[acme@toolbox pahole]$ git log --oneline -5
> > f37212d1611673a2 (HEAD -> master) pahole: Teduce memory usage by smarter deleting of CUs
> >
> 
> *R*edzce? memory usage ...
>

If you meant that further typo it's golden, and if not the irony is rich :)

Either way this is my favorite email of the day!


Cheers,
Phil


> -Sedat-
> 
> > Excerpt of the above:
> >
> >     This leads to deleting ~90 CUs during parallel vmlinux BTF generation
> >     versus deleting just 1 prior to this change.
> >
> > c7ec9200caa7d485 btf_encoder: Add "distilled_base" BTF feature to split BTF generation
> > bc4e6a9adfc72758 pahole: Sync with libbpf-1.5
> > 5e3ed3ec2947c69f pahole: Do --lang_exclude CU filtering earlier
> > c46455bb0379fa38 dwarf_loader: Allow filtering CUs early in loading
> > ⬢[acme@toolbox pahole]$
> >
> > - Arnaldo
> >
> 

-- 


