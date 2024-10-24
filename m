Return-Path: <bpf+bounces-43022-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBB19ADE0D
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 09:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99D5CB23FE1
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 07:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121681AE01E;
	Thu, 24 Oct 2024 07:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F4XOFNrU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7503A1AD403;
	Thu, 24 Oct 2024 07:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729755869; cv=none; b=WZ1DZLjJEyhbVkgSd5r7wo35GgV5padSSGjEte8sokm1wu76arpVv9xb7BOYvb+QtXeLkFzVBV4BuZklNTFiGiXy53RT9kY+jk/Dexnkm8ncHLIZZq1bt7g0H1PWxr2UH+8dXALeF4AGnX7neRbBtWiBq4u3Xi5X23JdCzRHryc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729755869; c=relaxed/simple;
	bh=zylwN3ythosBgJwCjjnHYB5VcHWDkTD5jqrqiuJzVLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=emvyHLwpN+k7BajckJa0ro8t6XuFJNzk281T9jOyiCeQrGMG0VGi1ABhzParxMw3SWLC6sXxiO6gp11rOBgyHv7YshaFrp3RKjSm6b0ZIXzSYHQPEDrAZouW2WVu63TNBI/1XW0Tuw1bYjlMBWsTkH5PO0Alc6vlm5nyrL2DbmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F4XOFNrU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E8BAC4CEE5;
	Thu, 24 Oct 2024 07:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729755868;
	bh=zylwN3ythosBgJwCjjnHYB5VcHWDkTD5jqrqiuJzVLw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F4XOFNrU1T3xszMOzuwJGlqqbGnrssI8S8Uh061izZujPIYSl65IzbFbZ9bEGiWS6
	 ju2otyQ0OStQHyCJyJp1hBvmaa04H4soC6kEzf5IkbdHIE/YFpWBetSrdBBD48PS6M
	 LUQU4UQdSKI2WN6Hweo7V/75zOTs6ceClClF036MWf/mNF9cvonEQVNAxGD5pZq6cm
	 b4tennYpK8Ks5Z2W55o97e/JGoYcn0rXX1UAK2S0rCofmj+6dA+k+iptc5VJjweNcn
	 kgZo2evHKpkKdVhWO+G/hoXgpf2KAn8lvk1wuYwf2M1g65e/fa7ph0COTR2R6G+ddI
	 Wqy2szMQ4JhjA==
Date: Thu, 24 Oct 2024 00:44:25 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, bpf@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add a test for open coded
 kmem_cache iter
Message-ID: <Zxn62WotvxH0UZ_h@google.com>
References: <20241017080604.541872-1-namhyung@kernel.org>
 <20241017080604.541872-2-namhyung@kernel.org>
 <CAEf4BzaipQcGFWQu+o5d+aXVMN17LDnHOv9MwrZis1wpiCWwCw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzaipQcGFWQu+o5d+aXVMN17LDnHOv9MwrZis1wpiCWwCw@mail.gmail.com>

On Mon, Oct 21, 2024 at 04:36:49PM -0700, Andrii Nakryiko wrote:
> On Thu, Oct 17, 2024 at 1:06 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > The new subtest is attached to sleepable fentry of syncfs() syscall.
> > It iterates the kmem_cache using bpf_for_each loop and count the number
> > of entries.  Finally it checks it with the number of entries from the
> > regular iterator.
> >
> >   $ ./vmtest.sh -- ./test_progs -t kmem_cache_iter
> >   ...
> >   #130/1   kmem_cache_iter/check_task_struct:OK
> >   #130/2   kmem_cache_iter/check_slabinfo:OK
> >   #130/3   kmem_cache_iter/open_coded_iter:OK
> >   #130     kmem_cache_iter:OK
> >   Summary: 1/3 PASSED, 0 SKIPPED, 0 FAILED
> >
> > Also simplify the code by using attach routine of the skeleton.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  .../testing/selftests/bpf/bpf_experimental.h  |  6 ++++
> >  .../bpf/prog_tests/kmem_cache_iter.c          | 28 +++++++++++--------
> >  .../selftests/bpf/progs/kmem_cache_iter.c     | 24 ++++++++++++++++
> >  3 files changed, 46 insertions(+), 12 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
> > index b0668f29f7b394eb..cd8ecd39c3f3c68d 100644
> > --- a/tools/testing/selftests/bpf/bpf_experimental.h
> > +++ b/tools/testing/selftests/bpf/bpf_experimental.h
> > @@ -582,4 +582,10 @@ extern int bpf_wq_set_callback_impl(struct bpf_wq *wq,
> >                 unsigned int flags__k, void *aux__ign) __ksym;
> >  #define bpf_wq_set_callback(timer, cb, flags) \
> >         bpf_wq_set_callback_impl(timer, cb, flags, NULL)
> > +
> > +struct bpf_iter_kmem_cache;
> > +extern int bpf_iter_kmem_cache_new(struct bpf_iter_kmem_cache *it) __weak __ksym;
> > +extern struct kmem_cache *bpf_iter_kmem_cache_next(struct bpf_iter_kmem_cache *it) __weak __ksym;
> > +extern void bpf_iter_kmem_cache_destroy(struct bpf_iter_kmem_cache *it) __weak __ksym;
> > +
> 
> we should be getting this from vmlinux.h nowadays, so this is probably
> unnecessary

I got some build errors without this.  I'll leave it for v2.

Thanks,
Namhyung

