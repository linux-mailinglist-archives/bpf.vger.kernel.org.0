Return-Path: <bpf+bounces-47730-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4639FEEC9
	for <lists+bpf@lfdr.de>; Tue, 31 Dec 2024 11:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A00F33A25DE
	for <lists+bpf@lfdr.de>; Tue, 31 Dec 2024 10:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFB8192B90;
	Tue, 31 Dec 2024 10:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="UEC2ZwhD"
X-Original-To: bpf@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8E813D521;
	Tue, 31 Dec 2024 10:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735641425; cv=none; b=ptE4bPan0kktAudBErgHNHFb9FRyIAeYhVT9sijO/wfO51PvS84N3CKXYpBj3XHdenf55t8FlxY5exM7dfofzpASyaSP86b6SOVXhR7CBiYN4O5iVclLWBG4lCvm+y/ARcoLzEhw8dLiVBVUwuWIHHZlHuDtwF9EVno6i/E4cOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735641425; c=relaxed/simple;
	bh=4WpB7p6ZcZfKydZjt9Pw6SFgQmWRdOIiB6z20vQcdqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H4ITaCkmLPVQ6jHJHL1lcpHar/gDDv0T7fTshudDC236slBMl9DzxkeChYc0YElvXj8iLxpfywdOm4Ok5hgULLdvYhvwkRqsaSOIufoKArthKUadCRGOv5mJGes3dsGJRc5cvuwTq+sTUFebDGvWKZyeo65EmbLe89XKtKLesg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=UEC2ZwhD; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1735641050;
	bh=4WpB7p6ZcZfKydZjt9Pw6SFgQmWRdOIiB6z20vQcdqg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UEC2ZwhDxV5XTXZrc9RSUrw990XCjxNtuzV1rt4h9taux0InFTexNqNvKISUQnu9M
	 ANQRa+jNB+4qFDnWpi4a4kRn2pMBslONPxV4D4jq32v+cuC03aKz2cIlMx2ocJ1GXg
	 MS+kr7jeBlqxCdj2D+xwmyVbnKSSvy+11GntmUOI=
Date: Tue, 31 Dec 2024 11:30:50 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	ppc-dev <linuxppc-dev@lists.ozlabs.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-modules@vger.kernel.org, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] sysfs: constify bin_attribute argument of
 sysfs_bin_attr_simple_read()
Message-ID: <0cbfd352-ee3b-4670-afae-8e56d888e8c3@t-8ch.de>
References: <20241228-sysfs-const-bin_attr-simple-v2-0-7c6f3f1767a3@weissschuh.net>
 <CAADnVQ+E0z8mY4BF9qamPh1XV9qs2jZ03bfYz2tVw8E4nFVWBw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+E0z8mY4BF9qamPh1XV9qs2jZ03bfYz2tVw8E4nFVWBw@mail.gmail.com>

On 2024-12-30 16:50:41-0800, Alexei Starovoitov wrote:
> On Sat, Dec 28, 2024 at 12:43 AM Thomas Weißschuh <linux@weissschuh.net> wrote:
> >
> > Most users use this function through the BIN_ATTR_SIMPLE* macros,
> > they can handle the switch transparently.
> >
> > This series is meant to be merged through the driver core tree.
> 
> hmm. why?

Patch 1 changes the signature of sysfs_bin_attr_simple_read().
Before patch 1 sysfs_bin_attr_simple_read() needs to be assigned to the
callback member .read, after patch 1 it's .read_new.
(Both callbacks work exactly the same, except for their signature,
.read_new is only a transition mechanism and will go away again)

> I'd rather take patches 2 and 3 into bpf-next to avoid
> potential conflicts.
> Patch 1 looks orthogonal and independent.

If you pick up 2 and 3 through bpf-next you would need to adapt these
assignments. As soon as both patch 1 and the modified 2 and 3 hit
Linus' tree, the build would break due to mismatches function pointers.
(Casting function pointers to avoid the mismatch will blow up with KCFI)
Of course Linus can fix this up easily, but it somebody would need to
keep track of it and I wanted to avoid manual intervention.
Or we spread out both parts over two development cycles; maybe Greg can
even pick up patch 1 late in the 6.13 cycle.

Personally I am fine with any approach.

