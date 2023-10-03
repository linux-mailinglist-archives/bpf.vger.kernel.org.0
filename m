Return-Path: <bpf+bounces-11273-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA437B6938
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 14:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 2E18628194D
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 12:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1E821369;
	Tue,  3 Oct 2023 12:42:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46FA2915;
	Tue,  3 Oct 2023 12:42:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B168EC433C7;
	Tue,  3 Oct 2023 12:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696336923;
	bh=n/gvnyDmLNOIdHGyVUG1n2iNubomaubRw/p9BmDO7/g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HKJXrHdnzKRXkdfldlO23qFPVJN7Re1Fi3VXGg+AcwxekTWjIMN+/vlLSNv+xslCe
	 p/4ifCyC1XWBVV7u5zwV0TnihImgXntCOfJRs2fm8cT4rplPfaETqqxh0FKq4iT4oC
	 UYytDe7RArUIiChhg2BEGm9HxS1k07uwedvH7Q41LJd2Gf2fIj3UMTmKGwJx2UzbVT
	 ZoWKnU6D876pl+vuKAOaqK6ZvO4eqk6LRG31JAQ+8znk65tc3/2Fuj/7quQ5x+jfIJ
	 NPFOhWFtWGu1zJyQFuoreV2ptq30ZiR9eaPJmcO5vtl0EFTQNdZyIX7H/EJR/YuV5m
	 WzSFfzb4nfttg==
Date: Tue, 3 Oct 2023 05:41:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: John Fastabend <john.fastabend@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf <bpf@vger.kernel.org>,
 Networking <netdev@vger.kernel.org>, "davidhwei@meta.com"
 <davidhwei@meta.com>
Subject: Re: Sockmap's parser/verdict programs and epoll notifications
Message-ID: <20231003054156.52816535@kernel.org>
In-Reply-To: <651ba39d55792_53e4920861@john.notmuch>
References: <CAEf4BzYMAAhwscTWWTenvyr-PQ7E5tMg_iqXsPj_dyZEMVCrKg@mail.gmail.com>
	<64b4c5891096b_2b67208f@john.notmuch>
	<CAEf4Bzb2=p3nkaTctDcMAabzL41JjCkTso-aFrfv21z7Y0C48w@mail.gmail.com>
	<64ff278e16f06_2e8f2083a@john.notmuch>
	<CAEf4Bzb1fMy5beHKxCjvoeCqaYmQFvnjnMi9bgWoML0v27n3SQ@mail.gmail.com>
	<651ba0f13cb51_4fa3f20824@john.notmuch>
	<651ba39d55792_53e4920861@john.notmuch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 02 Oct 2023 22:16:13 -0700 John Fastabend wrote:
> > This with the other piece we want from our side to allow running
> > verdict and sk_msg programs on sockets without having them in a
> > sockmap/sockhash it would seem like a better system to me. The
> > idea to drop the sockmap/sockhash is because we never remove progs
> > once they are added and we add them from sockops side. The filter
> > to socketes is almost always the port + metadata related to the
> > process or environment. This simplifies having to manage the
> > sockmap/sockhash and guess what size it should be. Sometimes we
> > overrun these maps and have to kill connections until we can
> > get more space.

That's a step in the right direction for sure, but I still think that
Google's auto-lowat is the best approach. We just need a hook that
looks at incoming data and sets rcvlowat appropriately. That's it.
TCP looks at rcvlowat in a number of places to make protocol decisions,
not just the wake-up. Plus Google will no longer have to carry their
OOT patch..

