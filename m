Return-Path: <bpf+bounces-6039-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBBCB7645EC
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 07:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C71D2820DF
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 05:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECBDD8820;
	Thu, 27 Jul 2023 05:41:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A605C538B;
	Thu, 27 Jul 2023 05:41:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 538D0C433C8;
	Thu, 27 Jul 2023 05:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690436510;
	bh=tRQeUvtOWTVEnYHK/93U8TcFdC1blB4d+lsY7E7p0Ec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bo2LTR56mu0jXWM+3RWJdC5SGW9+sY+RU8Ft0YUjDKUTx4zvXPFIu30w4m1VFz8K3
	 fwoNR2WbMaPJI5qLbB/ivk+nrvO+ZVFhk2JRIyUDKnZNVIQ9tONHm5UjgLOUVkqiUa
	 hdLDT505vAYhyrZlJ/k83tny8+KEAKBBzxMCTZim32wegoxxvb4zLxs2mV1NGszDj3
	 cZI6dnGRNDZVBp14AaDSbJ/yWgWpMDOjhNSauVl4Xerxs6UNSf6zMxFvBFhPu0PNgC
	 +dJ8D1t7EHKpNIqTyALF4dTETlKqI4YtXR5zZ95+wEhPShP8ixeDAm5ZAeqlvX9fpr
	 By+qlOs9AFScQ==
Date: Thu, 27 Jul 2023 08:41:45 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	syzbot <syzbot+14736e249bce46091c18@syzkaller.appspotmail.com>,
	andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
	haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org,
	kpsingh@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, sdf@google.com, song@kernel.org,
	syzkaller-bugs@googlegroups.com, yhs@fb.com,
	Gal Pressman <gal@nvidia.com>
Subject: Re: [syzbot] [bpf?] WARNING: ODEBUG bug in tcx_uninstall
Message-ID: <20230727054145.GY11388@unreal>
References: <000000000000ee69e80600ec7cc7@google.com>
 <91396dc0-23e4-6c81-f8d8-f6427eaa52b0@iogearbox.net>
 <20230726071254.GA1380402@unreal>
 <20230726082312.1600053e@kernel.org>
 <20230726170133.GX11388@unreal>
 <896cbaf8-c23d-e51a-6f5e-1e6d0383aed0@linux.dev>
 <1f91fe12-f9ff-06c8-4a5b-52dc21e6df05@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1f91fe12-f9ff-06c8-4a5b-52dc21e6df05@linux.dev>

On Wed, Jul 26, 2023 at 04:33:40PM -0700, Martin KaFai Lau wrote:
> On 7/26/23 11:16 AM, Martin KaFai Lau wrote:
> > On 7/26/23 10:01 AM, Leon Romanovsky wrote:
> > > On Wed, Jul 26, 2023 at 08:23:12AM -0700, Jakub Kicinski wrote:
> > > > On Wed, 26 Jul 2023 10:12:54 +0300 Leon Romanovsky wrote:
> > > > > > Thanks, I'll take a look this evening.
> > > > > 
> > > > > Did anybody post a fix for that?
> > > > > 
> > > > > We are experiencing the following kernel panic in netdev commit
> > > > > b57e0d48b300 (net-next/main) Merge branch '100GbE' of
> > > > > git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
> > > > 
> > > > Not that I know, looks like this is with Daniel's previous fix already
> > > > present, and syzbot is hitting it, too :(
> > > 
> > > My naive workaround which restored our regression runs is:
> > > 
> > > diff --git a/kernel/bpf/tcx.c b/kernel/bpf/tcx.c
> > > index 69a272712b29..10c9ab830702 100644
> > > --- a/kernel/bpf/tcx.c
> > > +++ b/kernel/bpf/tcx.c
> > > @@ -111,6 +111,7 @@ void tcx_uninstall(struct net_device *dev, bool ingress)
> > >                          bpf_prog_put(tuple.prog);
> > >                  tcx_skeys_dec(ingress);
> > >          }
> > > -       WARN_ON_ONCE(tcx_entry(entry)->miniq_active);
> > > +       tcx_miniq_set_active(entry, false);
> > 
> > Thanks for the report. I will look into it.
> 
> I don't see how that may be triggered for now after Daniel's recent fix in
> commit dc644b540a2d ("tcx: Fix splat in ingress_destroy upon
> tcx_entry_free"). 

Both our regression and syzbot have this fix in the trees.


> Do you have a small reproducible case? Thanks.

Unfortunately no.

Thanks

> 
> > 
> > >          tcx_entry_free(entry);
> > >   }
> > > 
> > 
> > 
> 

