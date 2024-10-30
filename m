Return-Path: <bpf+bounces-43604-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 829FB9B6F54
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 22:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4723828061B
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 21:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B2C22A4B9;
	Wed, 30 Oct 2024 21:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rNRCyCUY"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDABE22A4A6;
	Wed, 30 Oct 2024 21:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730324141; cv=none; b=omBkPciPBGoMvXR7vQbuoM0NA9ShpT8SJqat56LgAIaZk7Qcs0wwz7aH8YYNWyXtMCnxSt+HzzRHJ9Mq5MU2HbWwkANvqZgGjehRYSyV1UoSWEmLWjCbZuDE5Xt7kCJF5K/1vajZQ8UWoaWH2GaMrs69a944lcN0wv7vA38dMxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730324141; c=relaxed/simple;
	bh=v5pLVI2ucbwhcoIURapql+oZOGKKOhgXmdQ2dbMOADQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ned4OVF8hFm6solPBOqFuEURE47V4ImQdzwp0snCYZAxOG9lsC9LrSRdB4yGDnbAiNG06rVKQgWxkMyzFimTsbTqWii5dsPyp9MUBp52WeVrUqeLDWJSguJiZUPa9lRYjXQ+Hc4s/9LBimu4M8QFLNp7e39aUOYsTHYa31RYMSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rNRCyCUY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C7B1C4CECE;
	Wed, 30 Oct 2024 21:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730324140;
	bh=v5pLVI2ucbwhcoIURapql+oZOGKKOhgXmdQ2dbMOADQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rNRCyCUYFtBOaRu6gW4krYeC+MqSKedWai4cW33aGntkqKOYMOoZnunEQ9Rwcj6c5
	 eDcq8piHO84drnpqV7u6z+VT37qs8BMx2wv7SIuwFOH8/FexO3aRxYh4U0oILNshap
	 eKknqGpB9pU8hWbhk9rvZD9dcL0q6DmmY3f2pm5WrgNK/XAMqyHHVYKcmgIvJHd783
	 8/KYgZ0YUa0UtSQT4aBQR7/62WRuSIC6FzFzG/TECTayft6Sy2sHaO8RPpk81WwuX5
	 jzXbYTzHvnDCRWd/pVLPHTqgoS39pLNBgeuBNPKBZcn2UQyksmRfLJu+BLjsruzoQu
	 8cFOqfo5w1krw==
Date: Wed, 30 Oct 2024 14:35:38 -0700
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
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v2 bpf-next 2/2] selftests/bpf: Add a test for open coded
 kmem_cache iter
Message-ID: <ZyKmquDn3SNFzzgl@google.com>
References: <20241024074815.1255066-1-namhyung@kernel.org>
 <20241024074815.1255066-2-namhyung@kernel.org>
 <CAADnVQLA=QE9HwH+9tA+G8uppXK0-yk-hbiBHaOmjkjVENYCsA@mail.gmail.com>
 <ZyGOng76IBUs8PtY@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZyGOng76IBUs8PtY@google.com>

On Tue, Oct 29, 2024 at 06:40:46PM -0700, Namhyung Kim wrote:
> Hello,
> 
> On Thu, Oct 24, 2024 at 11:08:00AM -0700, Alexei Starovoitov wrote:
> > On Thu, Oct 24, 2024 at 12:48 AM Namhyung Kim <namhyung@kernel.org> wrote:
> > >
> > > The new subtest is attached to sleepable fentry of syncfs() syscall.
> > > It iterates the kmem_cache using bpf_for_each loop and count the number
> > > of entries.  Finally it checks it with the number of entries from the
> > > regular iterator.
> > >
> > >   $ ./vmtest.sh -- ./test_progs -t kmem_cache_iter
> > >   ...
> > >   #130/1   kmem_cache_iter/check_task_struct:OK
> > >   #130/2   kmem_cache_iter/check_slabinfo:OK
> > >   #130/3   kmem_cache_iter/open_coded_iter:OK
> > >   #130     kmem_cache_iter:OK
> > >   Summary: 1/3 PASSED, 0 SKIPPED, 0 FAILED
> > >
> > > Also simplify the code by using attach routine of the skeleton.
> > >
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > ---
[SNIP]
> > > +SEC("fentry.s/" SYS_PREFIX "sys_syncfs")
> > > +int open_coded_iter(const void *ctx)
> > > +{
> > > +       struct kmem_cache *s;
> > > +
> > > +       if (tgid != bpf_get_current_pid_tgid() >> 32)
> > > +               return 0;
> > 
> > Pls use syscall prog type and prog_run() it.
> > No need to attach to exotic syscalls and filter by pid.
> 
> Sure, will update in v3.
> 
> > 
> > > +
> > > +       bpf_for_each(kmem_cache, s) {
> > > +               struct kmem_cache_result *r;
> > > +
> > > +               r = bpf_map_lookup_elem(&slab_result, &open_coded_seen);
> > > +               if (!r)
> > > +                       break;
> > > +
> > > +               open_coded_seen++;
> > > +
> > > +               if (r->obj_size != s->size)
> > > +                       break;
> > 
> > The order of 'if' and ++ should probably be changed ?
> > Otherwise the last object isn't sufficiently checked.
> 
> I don't think so.  The last element should be an actual slab cache and
> then the iterator will return NULL to break the loop.  I don't expect it
> will hit the if statement.

Oh, it seems you meant checking the obj_size.  Ok then, I can move the
increment after the check.

Thanks,
Namhyung


