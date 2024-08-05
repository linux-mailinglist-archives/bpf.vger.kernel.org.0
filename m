Return-Path: <bpf+bounces-36406-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB995948190
	for <lists+bpf@lfdr.de>; Mon,  5 Aug 2024 20:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A10CC1F235A0
	for <lists+bpf@lfdr.de>; Mon,  5 Aug 2024 18:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBCD15F3E0;
	Mon,  5 Aug 2024 18:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jWZm8fn7"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583F715B10C
	for <bpf@vger.kernel.org>; Mon,  5 Aug 2024 18:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722882625; cv=none; b=bKkotvMnQz8WYESIPdl/fyQ2RniND2XHLx2WiDQh36KLDIEN8p3fqQgISuKyV5Njpc/Mo1FfCWxijGV3H8JGvQ8iv4rdxkM1Nk039CIRsOiN4g7ajlUfQOvL0UU99LmKV7mK9nEqLnVMg1fCpIcZ+K+qqGy8/PQZOEr5n/+dJFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722882625; c=relaxed/simple;
	bh=svnjTKPf+iMml5Qha912YT+ArFTJpHwO+27NZZiB1QI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DI0G6kdZl1AqzvHqo5fWMF0QvU7v1H/r6diN7Sq4UFFv/bl+msqjtBLbSAjjv95r3CcW779Q82mUygniAlgHS+u9KoJyNjZ+qUaYfnYk/92VOXbldSKYW+SAqPD2TIaZvXlEzAKTjVBWa2Za8rbom4qZv8cgRmqjTMNIwQTn3Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jWZm8fn7; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 5 Aug 2024 11:30:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722882620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OIXIzoEVWeFpOpo6RMGLeyng9gBukpKAnZG5EbPjY7Y=;
	b=jWZm8fn7vJCuvbu5KSRTvV0WZpSDKCBDV8SZHovg/0dCGePhbEozlx2MXeH0z2gsoHJCtb
	ypVPWlbopC2UQtCwHTCVqjoxEL7XKhWTHMxxanLvYqO1hCQNIRJsvbGpl6MprbHXcnxeah
	xuYbtVT1eajOb1NgBX5rtElb73pWm78=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, bpf@vger.kernel.org, linux-mm@kvack.org, 
	akpm@linux-foundation.org, adobriyan@gmail.com, ak@linux.intel.com, osandov@osandov.com, 
	song@kernel.org, jannh@google.com, Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH v3 bpf-next 06/10] lib/buildid: implement sleepable
 build_id_parse() API
Message-ID: <exs5meqpvcepjd7ymsl4ro6smwirtt3pu5bi3rll7652qftcim@2qdus7b75pff>
References: <20240730203914.1182569-1-andrii@kernel.org>
 <20240730203914.1182569-7-andrii@kernel.org>
 <CAEf4BzZ7hGgBeLgLnALM8fuFJw+UqdPPJ4E4a1sAdvWttaBSpw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZ7hGgBeLgLnALM8fuFJw+UqdPPJ4E4a1sAdvWttaBSpw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Jul 31, 2024 at 02:56:00PM GMT, Andrii Nakryiko wrote:
> On Tue, Jul 30, 2024 at 1:39 PM Andrii Nakryiko <andrii@kernel.org> wrote:
> >
> > Extend freader with a flag specifying whether it's OK to cause page
> > fault to fetch file data that is not already physically present in
> > memory. With this, it's now easy to wait for data if the caller is
> > running in sleepable (faultable) context.
> >
> > We utilize read_cache_folio() to bring the desired file page into page
> > cache, after which the rest of the logic works just the same at page level.
> >
> > Suggested-by: Omar Sandoval <osandov@fb.com>
> > Cc: Shakeel Butt <shakeel.butt@linux.dev>
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  lib/buildid.c | 50 ++++++++++++++++++++++++++++++++++----------------
> >  1 file changed, 34 insertions(+), 16 deletions(-)
> >
> > diff --git a/lib/buildid.c b/lib/buildid.c
> > index 5c869a2a30ab..6b5558cd95bf 100644
> > --- a/lib/buildid.c
> > +++ b/lib/buildid.c
> > @@ -20,6 +20,7 @@ struct freader {
> >                         struct page *page;
> >                         void *page_addr;
> >                         u64 file_off;
> > +                       bool may_fault;
> >                 };
> >                 struct {
> >                         const char *data;
> > @@ -29,12 +30,13 @@ struct freader {
> >  };
> >
> >  static void freader_init_from_file(struct freader *r, void *buf, u32 buf_sz,
> > -                                  struct address_space *mapping)
> > +                                  struct address_space *mapping, bool may_fault)
> >  {
> >         memset(r, 0, sizeof(*r));
> >         r->buf = buf;
> >         r->buf_sz = buf_sz;
> >         r->mapping = mapping;
> > +       r->may_fault = may_fault;
> >  }
> >
> >  static void freader_init_from_mem(struct freader *r, const char *data, u64 data_sz)
> > @@ -60,6 +62,17 @@ static int freader_get_page(struct freader *r, u64 file_off)
> >         freader_put_page(r);
> >
> >         r->page = find_get_page(r->mapping, pg_off);
> > +
> > +       if (!r->page && r->may_fault) {
> > +               struct folio *folio;
> > +
> > +               folio = read_cache_folio(r->mapping, pg_off, NULL, NULL);
> > +               if (IS_ERR(folio))
> > +                       return PTR_ERR(folio);
> > +
> > +               r->page = folio_file_page(folio, pg_off);
> > +       }
> > +
> 
> mm folks, is this the sane way to do this? Can you please take a look
> and provide your ack? Thank you!

Yes I think this is sane. I just had to check if read_cache_folio() is
also elevating a reference to the folio similar to find_get_page() and I
think it is doing so. I will go through the series soon.


