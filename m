Return-Path: <bpf+bounces-41779-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B415499AC77
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 21:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DCF4B211CE
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 19:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B553E1CB317;
	Fri, 11 Oct 2024 19:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GEEMux9W"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CD61C9DFD;
	Fri, 11 Oct 2024 19:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728674018; cv=none; b=pKnrMKYkbbKclCaPVXEmfzqny9bo3ZZ+nZcH6OVPEMYpmjsJHDZHtvjuB1z6IdSJj3QNGmkKCUow5dj4/u7yoij0vGqmaDM3CrnsPMvC1ZsZwadSc0cX4djwYIL+uCp3rhURr2Rhw5Kj0E/TSOuZ9SesNLCTNjpxDsvnW1bUetc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728674018; c=relaxed/simple;
	bh=dW3DEue8pH156XSw6e8kr83B3PJXGaUHI7/vg7NPJBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FWsp8nuhdKsQir6mS+GuY7/FeaRVUGpzbZY69bu8vSXHMDzuk6g5EzwZ1ieEI7m0QbvxBZNCdj2CgUIXXKrN5bPC5JBWQXdWj78NrevkDXlZBpDC/7zZpasVtAC69QAMEZ1Ij41I4jbL9NEQIdi9sh43Iof5oNkUD0kS3MeFvvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GEEMux9W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE469C4CEC3;
	Fri, 11 Oct 2024 19:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728674017;
	bh=dW3DEue8pH156XSw6e8kr83B3PJXGaUHI7/vg7NPJBA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GEEMux9WepdfRoOXDG39ZOmXkE9K4ZfVsvVC8csGPD8XMe606As/d0JF2yFfpjLQR
	 Q+i+kKOWP53SFAfFCRUq7TnFgaWiAcQH1xu8n7LnXM1t+j/6vJzQ7ohXJN1ns0NrUo
	 tRha77uyt4wycWAId6sYtOiILyFFgqM+Xoy1hoT/aBwAEjnSnuAfXIzYw8/oUU/TuL
	 hPu39O15kzhhO5A3Ak2KC9lquP/3PaHpm2D6bi0Ulv9XQBWN2SY9iaODz7nPr+JMWt
	 Gq3sSB2OgKebqvwqjuSPpjfTcOASnh3fMJSLBRp8OmmM/jt4bFED7SI/sKNuA7zWHM
	 61l6iPpMhyHnw==
Date: Fri, 11 Oct 2024 12:13:34 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm <linux-mm@kvack.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v5 bpf-next 1/3] bpf: Add kmem_cache iterator
Message-ID: <Zwl43rM2X2D4D5z-@google.com>
References: <20241010232505.1339892-1-namhyung@kernel.org>
 <20241010232505.1339892-2-namhyung@kernel.org>
 <CAADnVQ+5hq0g3K6B_uPWg4AzrTjus0kKyqtgd1-UyME9TPZL-w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+5hq0g3K6B_uPWg4AzrTjus0kKyqtgd1-UyME9TPZL-w@mail.gmail.com>

Hello Alexei,

On Fri, Oct 11, 2024 at 11:33:31AM -0700, Alexei Starovoitov wrote:
> On Thu, Oct 10, 2024 at 4:25 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > The new "kmem_cache" iterator will traverse the list of slab caches
> > and call attached BPF programs for each entry.  It should check the
> > argument (ctx.s) if it's NULL before using it.
> >
> > Now the iteration grabs the slab_mutex only if it traverse the list and
> 
> traverses
> 
> > releases the mutex when it runs the BPF program.  The kmem_cache entry
> > is protected by a refcount during the execution.
> >
> > It includes the internal "mm/slab.h" header to access kmem_cache,
> > slab_caches and slab_mutex.  Hope it's ok to mm folks.
> 
> What was the reason you dropped Vlastimil's and Roman's acks
> from this patch while keeping them in patch 2 ?

I wanted to make sure the slab maintainers agree with the refcounting and
the locking logic changes.  But I forgot to add back Vlastimil's Acked
for the v4 which is the same in this regard.

> 
> Folks pls Ack again if it looks ok.
> 
> I'm ready to apply, but would like the acks first.
> 
> Also I'd like to remove the above paragraph
> from mm/slab.h from the commit log.
> It was good to ask during v1, but looks odd at v5.

Sure, feel free to make any changes.

Thanks,
Namhyung


