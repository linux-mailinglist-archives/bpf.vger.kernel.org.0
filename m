Return-Path: <bpf+bounces-22140-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6F58578DB
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 10:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF5241C22BDC
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 09:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399391BC22;
	Fri, 16 Feb 2024 09:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PABjN2KR"
X-Original-To: bpf@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424D61BDCE
	for <bpf@vger.kernel.org>; Fri, 16 Feb 2024 09:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708075880; cv=none; b=duwktjlfpgw85Nh5LJpz3/uSojVZsW8yAMsNuOSFHb4HPssMuRwEkbBTqPGNGIZ5GvsqH+dE/rT8D+UL8YgU53zQ/qyN7ioXT1/VmsaPquua4Stvu1SYqfds1ehfWe07AgFWqsdPIsaya9Bbkc22Jma7flGguEdhF208qrpcBlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708075880; c=relaxed/simple;
	bh=rFtJ729OscU5lnPrwn5AVwpipL+YqOCJqI/5dm/ZNdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eUPXnRzIj9DFtKrclAgLPFmAMA48+KXerwpYSyEUfoTElUY7hlpOoc7weN9TGqD0xZfvTFEDQtBrKj0fwF5n6+anSYCCw8m79v1edPJTecWKXdOPle/10K4GnY1yK4zuzM/90fABaH3OfoSaSvmkqiADeDnDGwLunGLMx+NLJew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PABjN2KR; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Hicma0LaStbdWVQEFGL/bnJpIAjnQ4a5jIR0FW4imjs=; b=PABjN2KRs75C+Vfx0CBHiMH3+a
	IMl809OdPIdKP2dwV4WtmyhKmonCv6z3c+yNh1PmN6xGqPGKwdMbqpSMR8WccgpTboV23sgDBtPN6
	DbdMgAesHefcqhd0P324IXLgllyMtCH9Ziiy8dKsPNimINKks7E+SlaWSDO1RDWoE87KGN5uI0RTZ
	vWbukqoAplu9QZVoW8LOYnr/hh5gDDrij9RvwjB7i1adoKgsDN1/DWAQ/M/qwof95bm68zHecUK2y
	rXUc6tHxYBYprKiUL8AytPLnX23ErtT5sGWvhMsi8oSk9Bn0rqpY84HENFuL4bQzGXiHAiZItc7e4
	R2OeoUGw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rauYu-00000001jzU-2iun;
	Fri, 16 Feb 2024 09:31:16 +0000
Date: Fri, 16 Feb 2024 01:31:16 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Eddy Z <eddyz87@gmail.com>, Tejun Heo <tj@kernel.org>,
	Barret Rhoden <brho@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>, linux-mm <linux-mm@kvack.org>,
	Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH v2 bpf-next 04/20] mm: Expose vmap_pages_range() to the
 rest of the kernel.
Message-ID: <Zc8rZCQtsETe-cxU@infradead.org>
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
 <20240209040608.98927-5-alexei.starovoitov@gmail.com>
 <Zcx7lXfPxCEtNjDC@infradead.org>
 <CAADnVQKT9X1iSLXojVs1sWy4B-qEGccuk6S6u1d9GBmW9pBAeA@mail.gmail.com>
 <Zc22DluhMNk5_Zfn@infradead.org>
 <CAADnVQJ8azcUznU6KHhwEM99NUOx8oai8EOyay4dxLM6ho8mjw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQJ8azcUznU6KHhwEM99NUOx8oai8EOyay4dxLM6ho8mjw@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Feb 15, 2024 at 12:50:55PM -0800, Alexei Starovoitov wrote:
> So, since apply_to_page_range() is available to the kernel
> (xen, gpu, kasan, etc) then I see no reason why
> vmap_pages_range() shouldn't be available as well, since:

In case it wasn't clear before:  apply_to_page_range is a bad API to
be exported.  We've been working on removing it but it stalled.
Exposing something that allows a module to change arbitrary page table
bits is not a good idea.

Please take a step back and think of how to expose a vmalloc like
allocation that grows only when used as a proper abstraction.  I could
actually think of various other uses for it.


