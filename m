Return-Path: <bpf+bounces-41385-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55770996766
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 12:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D83FE281818
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 10:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADDB18F2DA;
	Wed,  9 Oct 2024 10:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R0qqQdLW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A8918BC36;
	Wed,  9 Oct 2024 10:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728470159; cv=none; b=DvNjFyfofuK8zfKFN+C9EFa1Hxt/umn8rm5cq6m0qD7jVd/9aybIYtIoQVTWhnhT8JTc36FduQfjAn7lEa0xTVVJ8cyUTGW19Vfx+2jP5gmzV+uxBirWVPqkc6cQivNPgSVPBxggNNE92OJjIMvRt06uTsD2YaJI2Kx9up+73B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728470159; c=relaxed/simple;
	bh=dxh0uEpbnl4YUFu8vCE4kg9SVY7NzZOGXbkINTFN82A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M2+O2fZdoEvU+5TlEeXHgo1eCKg/1gU05NakpTbYMEvwpK6IeV1k6wH56ldlwqxr874Y1pJDD1Df1560WKQXhngs43/oF4U/urnaO5go8+Qvs1Q2g164nEq/YQlKbFd3noPMXRiMTvqBTCI3gbzTOVIf8qw04wkbWeuimbXJBPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R0qqQdLW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 444EBC4CEC5;
	Wed,  9 Oct 2024 10:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728470159;
	bh=dxh0uEpbnl4YUFu8vCE4kg9SVY7NzZOGXbkINTFN82A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R0qqQdLWcpznVsXkP11aNhQX2M05ik9AKGWy0E+dOQ4NroPWyzTmb5UNSQPTzNFvh
	 ukjwLQFCOS4ElwWMFENJvy1JorVya3KUCg7Lg7k1U+k6MPggWQn7vc/L1Wn5m3Efc9
	 S+aSWf2yV4VaEYArRP1RqQq91TWzxZZlQObH6oy8lU2iTG3n+EjxinABa33RWqdmJg
	 5Fgv8gpuQdcqxgSxynAjKy67wMxjWsuOQa57MYM7+jqRhyU81ZvMPrcGrB9RJw8Piu
	 h2YdXc+Jrn9b9eDjo3GIRGxbW3MzMcarmFfJIK97SwlusgU7X4uIu0q/ZJFV7mNC+S
	 Wc0uP9+8wMYCg==
Date: Wed, 9 Oct 2024 12:35:52 +0200
From: Christian Brauner <brauner@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, 
	linux-trace-kernel@vger.kernel.org, peterz@infradead.org, oleg@redhat.com, rostedt@goodmis.org, 
	mhiramat@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jolsa@kernel.org, paulmck@kernel.org, willy@infradead.org, surenb@google.com, 
	akpm@linux-foundation.org, linux-mm@kvack.org, mjguzik@gmail.com, jannh@google.com, 
	mhocko@kernel.org, vbabka@suse.cz, mingo@kernel.org, 
	Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v2 tip/perf/core 3/5] fs: add back RCU-delayed freeing of
 FMODE_BACKING file
Message-ID: <20241009-eisvogel-zugelangt-d211199df267@brauner>
References: <20241001225207.2215639-1-andrii@kernel.org>
 <20241001225207.2215639-4-andrii@kernel.org>
 <20241003-lachs-handel-4f3a9f31403d@brauner>
 <20241004-holzweg-wahrgemacht-c1429b882127@brauner>
 <CAEf4BzY5fy1VVykbSdcLbVhaHRuT6pRNYNgpYteaD79vRM7N5A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzY5fy1VVykbSdcLbVhaHRuT6pRNYNgpYteaD79vRM7N5A@mail.gmail.com>

On Fri, Oct 04, 2024 at 12:58:00PM GMT, Andrii Nakryiko wrote:
> On Fri, Oct 4, 2024 at 1:01 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Thu, Oct 03, 2024 at 11:13:54AM GMT, Christian Brauner wrote:
> > > On Tue, Oct 01, 2024 at 03:52:05PM GMT, Andrii Nakryiko wrote:
> > > > 6cf41fcfe099 ("backing file: free directly") switched FMODE_BACKING
> > > > files to direct freeing as back then there were no use cases requiring
> > > > RCU protected access to such files.
> > > >
> > > > Now, with speculative lockless VMA-to-uprobe lookup logic, we do need to
> > > > have a guarantee that struct file memory is not going to be freed from
> > > > under us during speculative check. So add back RCU-delayed freeing
> > > > logic.
> > > >
> > > > We use headless kfree_rcu_mightsleep() variant, as file_free() is only
> > > > called for FMODE_BACKING files in might_sleep() context.
> > > >
> > > > Suggested-by: Suren Baghdasaryan <surenb@google.com>
> > > > Cc: Christian Brauner <brauner@kernel.org>
> > > > Cc: Amir Goldstein <amir73il@gmail.com>
> > > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > > ---
> > >
> > > Reviewed-by: Christian Brauner <brauner@kernel.org>
> >
> > Fwiw, I have another patch series for files that I'm testing that will
> > require me to switch FMODE_BACKING to a SLAB_TYPSAFE_BY_RCU cache. That
> > shouldn't matter for your use-case though.
> 
> Correct, we assume SLAB_TYPESAFE_BY_RCU semantics for the common case
> anyways. But hopefully my change won't cause major merge conflicts
> with your patch set.

Please drop this patch and pull the following tag which adds
SLAB_TYPE_SAFE_BY_RCU protection for FMODE_BACKING files aligning them
with regular files lifetime (even though not needed). The branch the tag
is based on is stable and won't change anymore:

git pull -S git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git tags/vfs-6.13.for-bpf.file

