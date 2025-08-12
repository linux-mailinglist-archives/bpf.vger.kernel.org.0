Return-Path: <bpf+bounces-65412-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BABA2B21C0C
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 06:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3F777AA3D6
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 04:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7BC32D29B7;
	Tue, 12 Aug 2025 04:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RALoD4le"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2442D311C35;
	Tue, 12 Aug 2025 04:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754972210; cv=none; b=bzbKx9OdFx0jOPXxA/2OqC+08/4bWWhOgCGBQE3EUXLYE097nRA1bwKCQT46QnnWGFTv0yQlbSs/4pz9uKp5IVTj2Cnd/YYRRWgPgc7ft7/wawb7YGkwMj0iE7H8WpkqjxoIZyFIIrIhkLQtvsgew0Nr9Y+iOPTNDVQSd5MGeco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754972210; c=relaxed/simple;
	bh=X3twYd3rEByen+5ZxROJj8HXt/cistLvB4ugSZt3zUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=faj1I9M2kz2ALLOluI76XvvhXgE4tpu1NPaUcrOaihNbMD6FKpS1XPiVB7/XP1IBCrzUrgh46F3psyePbf7enpkTxnyUen07pAmF1cmrkSaumw3ynzLxCMtf9bLMrF3Vb/fkxNqF0e0EJbBrGOiEwfGVJQgqbDASh/t33kQfZ+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RALoD4le; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC07FC4CEF0;
	Tue, 12 Aug 2025 04:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754972208;
	bh=X3twYd3rEByen+5ZxROJj8HXt/cistLvB4ugSZt3zUk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RALoD4leH8QO2MA8KqU4C1A1RioUuGWm87g1naai4bOiJwsWTS6G3zFp18kuZ4p7c
	 K7CquNKFU+qAr37t+F90j7NVa5JajwIzaoj6IuDjMVf8Iu07mnR6bd3bjGxlkXh+aO
	 ANyErIrD1Hdvqtyp4VoNMIADLnAH2NRlSKq3mTMZewjpPLRU8imadSaMcmjIn1a8kB
	 wo/vb1OCsvbe35bsOKBuVnva5cNdzRVfQjLzMdVlYqgEHtFIbjWmqhJzmB3ufbFZtH
	 vKwYB0vfvA7pT8NQB0MOmZpG72yw3XBqHtEECRMGCMibStI21EwEh3YnQhXl4GLZ5q
	 FFY68eSB//0Xg==
Date: Mon, 11 Aug 2025 21:15:45 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	linux-crypto@vger.kernel.org,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH bpf-next] bpf: Use sha1() instead of sha1_transform() in
 bpf_prog_calc_tag()
Message-ID: <20250812041545.GH1268@sol>
References: <20250811201615.564461-1-ebiggers@kernel.org>
 <CAPhsuW7shC-cN7nGLiaVcAAtxbmet45R0XZ8zRS2P2H5Bom+dw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW7shC-cN7nGLiaVcAAtxbmet45R0XZ8zRS2P2H5Bom+dw@mail.gmail.com>

On Mon, Aug 11, 2025 at 05:57:58PM -0700, Song Liu wrote:
> On Mon, Aug 11, 2025 at 1:17 PM Eric Biggers <ebiggers@kernel.org> wrote:
> >
> > Now that there's a proper SHA-1 library API, just use that instead of
> > the low-level SHA-1 compression function.  This eliminates the need for
> > bpf_prog_calc_tag() to implement the SHA-1 padding itself.  No
> > functional change; the computed tags remain the same.
> >
> > Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> > ---
> >  include/linux/filter.h |  6 -----
> >  kernel/bpf/core.c      | 50 ++++++++----------------------------------
> >  2 files changed, 9 insertions(+), 47 deletions(-)
> 
> Nice clean up!
> 
> It appears this patch changes the sha1 of some programs, but not
> some other programs. For example, sha1 of program
> test_task_kfunc_flavor_relo_not_found from task_kfunc_success.bpf.o
> stays the same before and after the patch, while other programs from
> task_kfunc_success.bpf.o have different sha1 after the patch.
> 
> Is this expected?

I don't see how the behavior could have changed.  The previous code
calculated the SHA-1 value correctly, just in a hard-to-read way.  Is it
possible that those BPF programs changed between your two tests?  Did
you recompile them?

- Eric

