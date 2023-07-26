Return-Path: <bpf+bounces-5984-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A32763D32
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 19:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A15561C2124B
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 17:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B776818027;
	Wed, 26 Jul 2023 17:01:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1492D18026;
	Wed, 26 Jul 2023 17:01:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6E8DC433C7;
	Wed, 26 Jul 2023 17:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690390897;
	bh=41IH+STJ6bMJLu2X89vfytzyvTOWg9NjdLg+SOjMTGs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t+TkpMHi+OOJTwfkr0gBDx+A3BVXrx0R6aEWRg3SRabDjbOkuNa9sdegsHvosOzy6
	 DF7TXXyuia2j2Z3CuCT/JRf9AfVpDfva8YvriMaGm3ADPFYQITJzGAaHDMco/hVajT
	 q1zjZjru4gDZY1q+MxIMcfuXX4jp0jAga5kjt2WgyH8h2/fMwD98QxUcX60rOThekF
	 09eSuHYpNK++akPLHgNQvuzg3WmuZNQElUoKpCDwdaenb1RY090YmSCILultRYCniL
	 uUdaD5ZCwscr6PWTAJKk+habMTDl8S/ncVcjNijnXbkDUGsZBF6YNqkIzur3duDtwj
	 dxrkEGrdE2f3Q==
Date: Wed, 26 Jul 2023 20:01:33 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	syzbot <syzbot+14736e249bce46091c18@syzkaller.appspotmail.com>,
	andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
	haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org,
	kpsingh@kernel.org, linux-kernel@vger.kernel.org,
	martin.lau@linux.dev, netdev@vger.kernel.org, sdf@google.com,
	song@kernel.org, syzkaller-bugs@googlegroups.com, yhs@fb.com,
	Gal Pressman <gal@nvidia.com>
Subject: Re: [syzbot] [bpf?] WARNING: ODEBUG bug in tcx_uninstall
Message-ID: <20230726170133.GX11388@unreal>
References: <000000000000ee69e80600ec7cc7@google.com>
 <91396dc0-23e4-6c81-f8d8-f6427eaa52b0@iogearbox.net>
 <20230726071254.GA1380402@unreal>
 <20230726082312.1600053e@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726082312.1600053e@kernel.org>

On Wed, Jul 26, 2023 at 08:23:12AM -0700, Jakub Kicinski wrote:
> On Wed, 26 Jul 2023 10:12:54 +0300 Leon Romanovsky wrote:
> > > Thanks, I'll take a look this evening.  
> > 
> > Did anybody post a fix for that?
> > 
> > We are experiencing the following kernel panic in netdev commit
> > b57e0d48b300 (net-next/main) Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
> 
> Not that I know, looks like this is with Daniel's previous fix already
> present, and syzbot is hitting it, too :(

My naive workaround which restored our regression runs is:

diff --git a/kernel/bpf/tcx.c b/kernel/bpf/tcx.c
index 69a272712b29..10c9ab830702 100644
--- a/kernel/bpf/tcx.c
+++ b/kernel/bpf/tcx.c
@@ -111,6 +111,7 @@ void tcx_uninstall(struct net_device *dev, bool ingress)
                        bpf_prog_put(tuple.prog);
                tcx_skeys_dec(ingress);
        }
-       WARN_ON_ONCE(tcx_entry(entry)->miniq_active);
+       tcx_miniq_set_active(entry, false);
        tcx_entry_free(entry);
 }


