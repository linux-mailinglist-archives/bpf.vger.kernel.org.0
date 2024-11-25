Return-Path: <bpf+bounces-45565-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3F09D7CDB
	for <lists+bpf@lfdr.de>; Mon, 25 Nov 2024 09:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD591B22FEC
	for <lists+bpf@lfdr.de>; Mon, 25 Nov 2024 08:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1299A188A3B;
	Mon, 25 Nov 2024 08:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="ShHmTJzs"
X-Original-To: bpf@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E385103F;
	Mon, 25 Nov 2024 08:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732523131; cv=none; b=iMONq4s9pYr0UilYsuhaHxngltFmNrN6V5QTXBKuwfOP2MZfFoPHgiZiCedzZ6qPO6Hxx8ZC67Cqotjn5/aUiqT3Mw94GkYn+oU+/rFQ00n7H1ucbOH+6mFQJ6k7JlrN1VCrWpVCcwYac6SmLPl48AURxMY0q1o2659WxYfjHW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732523131; c=relaxed/simple;
	bh=zJPZNHvvatGfDq+PTg1NsIrBHPezuPeUrcPTMfRxqtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ssd0dUVilhMA7Q3RuneHFTwDUaoHut23Xb0ntF36tiCv+MHqqaPcnD0lwnx+BFJDkMnyuh4PBEZ20gPA2Xg91Y8td+px3tLkhBYnByjSitWrruGypRRuMADVFhGCGvb617RjfGznL0pBCenHkDMOwbkF4dN84vJRuu46DnPFtoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=ShHmTJzs; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1732523125;
	bh=zJPZNHvvatGfDq+PTg1NsIrBHPezuPeUrcPTMfRxqtE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ShHmTJzs1a/OoPfTwyc+Vgpq6+4sgXAZBxZ/z5bCHSvpITjamOfJCWAmbv/KDTLMu
	 1OTNv1czCBAwRKo5kH1YEz4wrYBOZi5S3KGDheu7bQWRruSROXM76DhAeI5/G7Iehs
	 rfkjVp9XbDJRgP12D3E52HE3Nh40XVzjNPgtTYQw=
Date: Mon, 25 Nov 2024 09:25:24 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, audit@vger.kernel.org, 
	selinux@vger.kernel.org
Subject: Re: [PATCH] bpf, lsm: Fix getlsmprop hooks BTF IDs
Message-ID: <a77471ed-1c18-4469-be4c-c9e00f8a3b80@t-8ch.de>
References: <20241123-bpf_lsm_task_getsecid_obj-v1-1-0d0f94649e05@weissschuh.net>
 <CAADnVQ++-VwPnem-xY+Urec0=zi71s-Pmzox+TXYgaVpshHtEA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ++-VwPnem-xY+Urec0=zi71s-Pmzox+TXYgaVpshHtEA@mail.gmail.com>

On 2024-11-24 15:45:04-0800, Alexei Starovoitov wrote:
> On Sat, Nov 23, 2024 at 2:19 AM Thomas Weißschuh <linux@weissschuh.net> wrote:
> >
> > The hooks got renamed, adapt the BTF IDs.
> > Fixes the following build warning:
> >
> >   BTFIDS  vmlinux
> > WARN: resolve_btfids: unresolved symbol bpf_lsm_task_getsecid_obj
> > WARN: resolve_btfids: unresolved symbol bpf_lsm_current_getsecid_subj
> >
> > Fixes: 37f670aacd48 ("lsm: use lsm_prop in security_current_getsecid")
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > ---
> >  kernel/bpf/bpf_lsm.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> > index 3bc61628ab251e05d7837eb27dabc3b62bcc4783..5be76572ab2e8a0c6e18a81f9e4c14812a11aad2 100644
> > --- a/kernel/bpf/bpf_lsm.c
> > +++ b/kernel/bpf/bpf_lsm.c
> > @@ -375,8 +375,8 @@ BTF_ID(func, bpf_lsm_socket_socketpair)
> >
> >  BTF_ID(func, bpf_lsm_syslog)
> >  BTF_ID(func, bpf_lsm_task_alloc)
> > -BTF_ID(func, bpf_lsm_current_getsecid_subj)
> > -BTF_ID(func, bpf_lsm_task_getsecid_obj)
> > +BTF_ID(func, bpf_lsm_current_getlsmprop_subj)
> > +BTF_ID(func, bpf_lsm_task_getlsmprop_obj)
> 
> Maybe we can remove these two instead?
> I couldn't come up with a reason for bpf_lsm to attach to these two.

Personally I have no idea about bps_lsm, how it works or how it is used.
I only tried to get rid of the warning.
If you prefer I can drop the IDs.

In my opinion this is a discussion that would have been better in
the original patch, if the CI would have caught it.


Thomas

