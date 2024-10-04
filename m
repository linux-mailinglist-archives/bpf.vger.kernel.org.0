Return-Path: <bpf+bounces-40919-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD9E98FE5F
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 10:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2AEB281C13
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 08:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A535813B58F;
	Fri,  4 Oct 2024 08:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uPAQ/fIA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC6B84D29;
	Fri,  4 Oct 2024 08:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728028902; cv=none; b=OPUL+DU/42ARJ2YqczWDUJmdvV4NQmt41ieKAArPXW9Z2okm1/PTjbaWHZV6zL3L3OHRYL5ah9bBLT31aKDOfT8POFXD09cvAauxesCyIlsCmN+3TVXpIxEnw2912bV6Hn0yR76ncUHs7XsWoBdHjJPxWnJ5CrYz7ULt6aofsRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728028902; c=relaxed/simple;
	bh=czh6SU5zL2iJcYy6jW4TFILwI5XBwlvFj/KY4P03WUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OeKLpDwqRrGT26Aq1BoqEh8A8bEi/w/2Km0Lqg3/cbjO1OuC3Bl97M82jgNejcd6BmV5dbKCZfdJY9SVOrF4P18t+8NobPgg9NqKAPkoZ/dqllsXJ/TOWS2BBvLPZFVyV7YKUvn8e9CThycXq24KT0NEJTRIGdOwdgOqBVhcCrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uPAQ/fIA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C8BFC4CECD;
	Fri,  4 Oct 2024 08:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728028901;
	bh=czh6SU5zL2iJcYy6jW4TFILwI5XBwlvFj/KY4P03WUg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uPAQ/fIAE/QAAjeYGXWo1YTo3Y0qqWBhc/8Y/n0CMFHT2N1RT8KtWDpQStMeiGlkt
	 rbq2a1fnLhcuWcxo3xc3K2rQ0DOJ4IUq8kQQyNc1baSXmayh3uPGajSN6/K9CjE5HX
	 7UjKViGzApNDpCSTdeI0WcidECgzLJgnwAEW959FuxTuCr26DAKT/MyLXbMvygh08X
	 rAB+T91BbTMa5I9efZZvLvdc8O/T6kmDhnb7zrYqN4kTjejmW90sIyfPoCVI+3ZJJ/
	 C6AFH41VHQIBZzj241AyYWqiQStA2hNt6zLdbAqhNOa5qrUIFB9hb9ismRdq+xvV7O
	 7zs6JklKtCP+g==
Date: Fri, 4 Oct 2024 10:01:35 +0200
From: Christian Brauner <brauner@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, peterz@infradead.org, 
	oleg@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org, willy@infradead.org, 
	surenb@google.com, akpm@linux-foundation.org, linux-mm@kvack.org, mjguzik@gmail.com, 
	jannh@google.com, mhocko@kernel.org, vbabka@suse.cz, mingo@kernel.org, 
	Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v2 tip/perf/core 3/5] fs: add back RCU-delayed freeing of
 FMODE_BACKING file
Message-ID: <20241004-holzweg-wahrgemacht-c1429b882127@brauner>
References: <20241001225207.2215639-1-andrii@kernel.org>
 <20241001225207.2215639-4-andrii@kernel.org>
 <20241003-lachs-handel-4f3a9f31403d@brauner>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241003-lachs-handel-4f3a9f31403d@brauner>

On Thu, Oct 03, 2024 at 11:13:54AM GMT, Christian Brauner wrote:
> On Tue, Oct 01, 2024 at 03:52:05PM GMT, Andrii Nakryiko wrote:
> > 6cf41fcfe099 ("backing file: free directly") switched FMODE_BACKING
> > files to direct freeing as back then there were no use cases requiring
> > RCU protected access to such files.
> > 
> > Now, with speculative lockless VMA-to-uprobe lookup logic, we do need to
> > have a guarantee that struct file memory is not going to be freed from
> > under us during speculative check. So add back RCU-delayed freeing
> > logic.
> > 
> > We use headless kfree_rcu_mightsleep() variant, as file_free() is only
> > called for FMODE_BACKING files in might_sleep() context.
> > 
> > Suggested-by: Suren Baghdasaryan <surenb@google.com>
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: Amir Goldstein <amir73il@gmail.com>
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> 
> Reviewed-by: Christian Brauner <brauner@kernel.org>

Fwiw, I have another patch series for files that I'm testing that will
require me to switch FMODE_BACKING to a SLAB_TYPSAFE_BY_RCU cache. That
shouldn't matter for your use-case though.

