Return-Path: <bpf+bounces-34994-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F061934924
	for <lists+bpf@lfdr.de>; Thu, 18 Jul 2024 09:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C72C21F2254D
	for <lists+bpf@lfdr.de>; Thu, 18 Jul 2024 07:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85447823CE;
	Thu, 18 Jul 2024 07:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qlc7f3py"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98148172A;
	Thu, 18 Jul 2024 07:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721288582; cv=none; b=lQj6HnYghdP9EGFA/qIVseZwgPS3YbU9FG4EoXGF/qWxeS7evFrB40niHgLfk5iKdBJMvjB4MnWrvd04UIahw4iooGwo4Gqw+hGt6qsuTTz2ulGkZk2lLz9ulYnSg8eyRDOq4KCTtApdKAWJicAItkU55MzzFfBf2vVGsntmwgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721288582; c=relaxed/simple;
	bh=dgY9ctGV63+aAMBJiulUPmmgfSVxqHOrq8GV4P/WcKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iAE4sHgSR4sPux4gwHg5q+Vwv6e6kl/wRZqTidX0fA6kP0c1Wqv2C2XPJXaMHSKPVq2bZ3ApUyhWoYFfhjyYucm0bIHlZtXOiV3Q/+KFdVTOOuQCgFCYiWcGh2SjAIHqSytBwpmqrB399Q1ugE5eZE6p0N/ZjdxmbPP9jTIYWBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qlc7f3py; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EDC0C4AF0E;
	Thu, 18 Jul 2024 07:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721288581;
	bh=dgY9ctGV63+aAMBJiulUPmmgfSVxqHOrq8GV4P/WcKg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qlc7f3pywX2T3z+k8tNSelThsx9gTS/JkX6ybGOvxdsLBaeMzg1vviSITC/cPbfRo
	 uol0Cy3qGlMJtaQZD486BapAKuDfKcTCCR89KX82W5aqWBPtO2KzIr389OHi+lNmVG
	 8em/6AWe++FaW9ObWLGCbwMX8QtdweY9AgY0PAPSDo00RW2E4PNNIrfzWzTtL4Aik3
	 h7OcvgV3JslGLHuPmuoVgyL2fsFsnFBQ3clIOiE3kjSo1DxL27Ek+C8qrua52VuT2x
	 wPj33f/2oggk12Xu1v6tsOCqRhJqNe8wmBRFcrcyAcgzvUHG2LP5gcqx3vOHCAIhea
	 W2clBZ+7NICXA==
Date: Thu, 18 Jul 2024 09:42:55 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Jiri Kosina <jikos@kernel.org>, David Miller <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Mark Brown <broonie@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>, 
	Kui-Feng Lee <thinker.li@gmail.com>, Martin KaFai Lau <martin.lau@kernel.org>, 
	linux-input@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the bpf-next tree
Message-ID: <t4w4wdnnecux55skwvgnsp3z2jvaxhstvfgpr3ztgxogpxbxvq@irlwzwarbh7a>
References: <ZnB9X1Jj6c04ufC0@sirena.org.uk>
 <20240710091344.2f3f2029@canb.auug.org.au>
 <20240718114916.7fab0442@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240718114916.7fab0442@canb.auug.org.au>

Hi Stephen,

On Jul 18 2024, Stephen Rothwell wrote:
> Hi all,
> 
> On Wed, 10 Jul 2024 09:13:44 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > On Mon, 17 Jun 2024 19:15:59 +0100 Mark Brown <broonie@kernel.org> wrote:
> > >
> > > After merging the bpf-next tree, today's linux-next build (x86_64
> > > allmodconfig) failed like this:
> > > 
> > > /tmp/next/build/drivers/hid/bpf/hid_bpf_struct_ops.c:280:16: error: initialization of 'int (*)(void *, struct bpf_link *)' from incompatible pointer type 'int (*)(void *)' [-Werror=incompatible-pointer-types]
> > >   280 |         .reg = hid_bpf_reg,
> > >       |                ^~~~~~~~~~~
> > > /tmp/next/build/drivers/hid/bpf/hid_bpf_struct_ops.c:280:16: note: (near initialization for 'bpf_hid_bpf_ops.reg')
> > > /tmp/next/build/drivers/hid/bpf/hid_bpf_struct_ops.c:281:18: error: initialization of 'void (*)(void *, struct bpf_link *)' from incompatible pointer type 'void (*)(void *)' [-Werror=incompatible-pointer-types]
> > >   281 |         .unreg = hid_bpf_unreg,
> > >       |                  ^~~~~~~~~~~~~
> > > /tmp/next/build/drivers/hid/bpf/hid_bpf_struct_ops.c:281:18: note: (near initialization for 'bpf_hid_bpf_ops.unreg')
> > > 
> > > Caused by commit
> > > 
> > >   73287fe228721b ("bpf: pass bpf_struct_ops_link to callbacks in bpf_struct_ops.")
> > > 
> > > interacting with commit
> > > 
> > >   ebc0d8093e8c97 ("HID: bpf: implement HID-BPF through bpf_struct_ops")
> > > 
> > > from the HID tree.
> > > 
> > > I've fixed it up as below:
> > > 
> > > From e8aeaba00440845f9bd8d6183ca5d7383a678cd3 Mon Sep 17 00:00:00 2001
> > > From: Mark Brown <broonie@kernel.org>
> > > Date: Mon, 17 Jun 2024 19:02:27 +0100
> > > Subject: [PATCH] HID: bpf: Fix up build
> > > 
> > > Fix up build error due to 73287fe228721b ("bpf: pass bpf_struct_ops_link to callbacks in bpf_struct_ops.")
> > > 
> > > Signed-off-by: Mark Brown <broonie@kernel.org>
> > > ---
> > >  drivers/hid/bpf/hid_bpf_struct_ops.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/hid/bpf/hid_bpf_struct_ops.c b/drivers/hid/bpf/hid_bpf_struct_ops.c
> > > index 5f200557ff12b..744318e7d936b 100644
> > > --- a/drivers/hid/bpf/hid_bpf_struct_ops.c
> > > +++ b/drivers/hid/bpf/hid_bpf_struct_ops.c
> > > @@ -175,7 +175,7 @@ static int hid_bpf_ops_init_member(const struct btf_type *t,
> > >  	return 0;
> > >  }
> > >  
> > > -static int hid_bpf_reg(void *kdata)
> > > +static int hid_bpf_reg(void *kdata, struct bpf_link *link)
> > >  {
> > >  	struct hid_bpf_ops *ops = kdata;
> > >  	struct hid_device *hdev;
> > > @@ -229,7 +229,7 @@ static int hid_bpf_reg(void *kdata)
> > >  	return err;
> > >  }
> > >  
> > > -static void hid_bpf_unreg(void *kdata)
> > > +static void hid_bpf_unreg(void *kdata, struct bpf_link *link)
> > >  {
> > >  	struct hid_bpf_ops *ops = kdata;
> > >  	struct hid_device *hdev;
> > > -- 
> > > 2.39.2
> > >   
> > 
> > This fixup is now required when the hid and next-next trees are merged.
> 
> And now this is needed when the hid tree is merged with Linus' tree.
> 

Thanks a lot for all of your reminders.

The HID PR has been accepted and merged thanks to both of your merge
conflicts detection, Mark and you. So this conflict should no longer be a
problem.

Cheers,
Benjamin

