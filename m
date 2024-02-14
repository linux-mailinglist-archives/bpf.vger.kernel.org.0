Return-Path: <bpf+bounces-21993-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D363C854ED6
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 17:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EF2128F256
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 16:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2D9605DA;
	Wed, 14 Feb 2024 16:41:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB49A5DF03;
	Wed, 14 Feb 2024 16:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.27.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707928889; cv=none; b=P9/A7TSAsPlGrnR7d6PzQYTeyrO0Cok58yNh+d8y//ZwGhwDocKMQY49OX2mGNt7WfnhaWUsDh78WBqdFKYmXieGClpJgA5k5Xea4czwJUJd1QGjsUuv0r36LC15HAqimWLLaNIN44a8OlQDMc01JiUF8jYBLlM80HXdlX6FLVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707928889; c=relaxed/simple;
	bh=sKZqb4SpRZtsvwefnHUf/iXBlUPQk87OfSTdN84K9g4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PfwjMKZEfvUuXozuBBdZkIkjm5KyvvyjnO+EddJbTaTKNzgnYcyC54ldljBDG+BdTXDPGvpXKF/bIyghvPOWWspRipvuaspwVe+q8p/z+Ws9wp99AE6wOo80roeS8W/QR9sGXE45i0JaDuERpwzYBi5XzRqedDSNkcRCsl5VduI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=gnumonks.org; arc=none smtp.client-ip=213.95.27.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnumonks.org
Received: from [78.30.41.52] (port=34352 helo=gnumonks.org)
	by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <pablo@gnumonks.org>)
	id 1raIJy-001MeG-LF; Wed, 14 Feb 2024 17:41:20 +0100
Date: Wed, 14 Feb 2024 17:41:17 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Quentin Deslandes <qde@naccy.de>
Cc: "D. Wythe" <alibuda@linux.alibaba.com>, kadlec@netfilter.org,
	fw@strlen.de, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, coreteam@netfilter.org,
	netfilter-devel@vger.kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	ast@kernel.org
Subject: Re: [RFC nf-next v5 0/2] netfilter: bpf: support prog update
Message-ID: <ZcztLZPiz+FkF8kF@calendula>
References: <1704175877-28298-1-git-send-email-alibuda@linux.alibaba.com>
 <70114fff-43bd-4e27-9abf-45345624042c@naccy.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <70114fff-43bd-4e27-9abf-45345624042c@naccy.de>
X-Spam-Score: -1.7 (-)

On Wed, Feb 14, 2024 at 05:10:46PM +0100, Quentin Deslandes wrote:
> On 2024-01-02 07:11, D. Wythe wrote:
> > From: "D. Wythe" <alibuda@linux.alibaba.com>
> > 
> > This patches attempt to implements updating of progs within
> > bpf netfilter link, allowing user update their ebpf netfilter
> > prog in hot update manner.
> > 
> > Besides, a corresponding test case has been added to verify
> > whether the update works.
> > --
> > v1:
> > 1. remove unnecessary context, access the prog directly via rcu.
> > 2. remove synchronize_rcu(), dealloc the nf_link via kfree_rcu.
> > 3. check the dead flag during the update.
> > --
> > v1->v2:
> > 1. remove unnecessary nf_prog, accessing nf_link->link.prog in direct.
> > --
> > v2->v3:
> > 1. access nf_link->link.prog via rcu_dereference_raw to avoid warning.
> > --
> > v3->v4:
> > 1. remove mutex for link update, as it is unnecessary and can be replaced
> > by atomic operations.
> > --
> > v4->v5:
> > 1. fix error retval check on cmpxhcg
> > 
> > D. Wythe (2):
> >   netfilter: bpf: support prog update
> >   selftests/bpf: Add netfilter link prog update test
> > 
> >  net/netfilter/nf_bpf_link.c                        | 50 ++++++++-----
> >  .../bpf/prog_tests/netfilter_link_update_prog.c    | 83 ++++++++++++++++++++++
> >  .../bpf/progs/test_netfilter_link_update_prog.c    | 24 +++++++
> >  3 files changed, 141 insertions(+), 16 deletions(-)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/netfilter_link_update_prog.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/test_netfilter_link_update_prog.c
> > 
> 
> It seems this patch has been forgotten, hopefully this answer
> will give it more visibility.
> 
> I've applied this change on 6.8.0-rc4 and tested BPF_LINK_UPDATE
> with bpfilter and everything seems alright.

Just post it without RFC tag.

