Return-Path: <bpf+bounces-33069-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC53D916D93
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 17:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4091DB26461
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 15:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0161171E5E;
	Tue, 25 Jun 2024 15:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hYlGvi3+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6B445978;
	Tue, 25 Jun 2024 15:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719330893; cv=none; b=ckaLBNLbDGiTz/NOrEYwMBMOdUoOpI+utcJDVthGM+nanTkhtXbA/E2pcs0k80tcxIJ/fyIevVSxrtPuhCkPZcFapr47Shfg6u7ZysQstyWgSCUGPwmRXZ6SbYQLp3NLem5A1NWJD6fJz+ANz8+3WS2cfoo7XLncqxHyakzu5a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719330893; c=relaxed/simple;
	bh=MYCOtf0uRzHZ3eR6TN/Xx66bhkBDqHJ8W0YBKOxdBTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KqaiUXMqNR1YBIhqQSeOvfWPPaz9zFCRJclbZSwpDkVf2osacn6KEUg/tR0U4r7Km0VOH1IyXglOF3x5cmCwH8EDVSary5Gti7MAce+YtLtU/JkLItAPCvErscSv3YKMzfYAiGQb5Ds1kSvQxA/duO5N8mAn0oAXg9SqSj9GR/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hYlGvi3+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59E2BC32781;
	Tue, 25 Jun 2024 15:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719330893;
	bh=MYCOtf0uRzHZ3eR6TN/Xx66bhkBDqHJ8W0YBKOxdBTc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hYlGvi3+HVNY5dkhVgWnsMZ2RaXcZjFPqtc5GahEsGart9KlpH78TBIzGplLjoLcM
	 9WjCDQCqHb3lQ9o/ux+RsrxEQh0Rx67fURh4N/D33LPip/NsVBc8j1nGV1aodlnWHS
	 z0pf4UIdM27bkrsRQag2IPB/9rvdsxeMiKNEurO5YKM1Uc9fZHjmWiEjvCc734R5OC
	 EDg4mYZmJSiD7wrUsk0niueZ7dD9Vx48V0elwYVQBv4y1yT9HZB5ZzSoZCnWR0QhaP
	 n7//VCl5yEIon5+DHX5Ps5+j4m5JVpXxGN3FAbPH03vAuk6y2Rn9MiAbmOwKJQ+KvC
	 WnFoKnxfBIaSw==
Date: Tue, 25 Jun 2024 17:54:47 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Thinker Li <thinker.li@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>, 
	Jiri Kosina <jikos@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	linux-input@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the bpf-next tree
Message-ID: <ud5j6hbozgg6em43volidpffykdtd2lpf32etmdiyksorl2cb4@whtseaibw2xw>
References: <ZnB9X1Jj6c04ufC0@sirena.org.uk>
 <CAFVMQ6R8ZZE+9jWM1vhEuz2PsLyCgKhpaVD377TKEu4AfGO_iA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFVMQ6R8ZZE+9jWM1vhEuz2PsLyCgKhpaVD377TKEu4AfGO_iA@mail.gmail.com>

On Jun 24 2024, Thinker Li wrote:
> Hi Mark,
> 
> I'm sorry for not getting back to you sooner. I have been traveling
> since my last message.
> I guess this patch is for the HID tree. The changes in this patch are great.

Ok, thanks for the review. However, the need appears because there is a
conflicting update in the bpf tree.

May I ask the bpf maintainers (Daniel/Alexei/Andrii) for an immutable
tag I could merge to so I can take this patch from Mark?

> 
> However, I suggest you implement ".update" if you think it is
> reasonable for HID,
> although it is not a MUST-BE. ".update" provides a good feature that
> user space programs
> can update an implementation on the flight.

FWIW, Mark handles linux-next, so not sure he has deep knowledge of
HID-BPF, and not sure he wants too :)

Regarding .update, I'm not sure it's worth the effort for hid-bpf. Right
now HID-BPF programs are just a one-shot: you load them, pin them and
forget. This might be different when systemd starts implementing a HID
firewall, but we can cross that bridge when we see fit.

Cheers,
Benjamin

> 
> On Mon, Jun 17, 2024 at 11:16 AM Mark Brown <broonie@kernel.org> wrote:
> >
> > Hi all,
> >
> > After merging the bpf-next tree, today's linux-next build (x86_64
> > allmodconfig) failed like this:
> >
> > /tmp/next/build/drivers/hid/bpf/hid_bpf_struct_ops.c:280:16: error: initialization of 'int (*)(void *, struct bpf_link *)' from incompatible pointer type 'int (*)(void *)' [-Werror=incompatible-pointer-types]
> >   280 |         .reg = hid_bpf_reg,
> >       |                ^~~~~~~~~~~
> > /tmp/next/build/drivers/hid/bpf/hid_bpf_struct_ops.c:280:16: note: (near initialization for 'bpf_hid_bpf_ops.reg')
> > /tmp/next/build/drivers/hid/bpf/hid_bpf_struct_ops.c:281:18: error: initialization of 'void (*)(void *, struct bpf_link *)' from incompatible pointer type 'void (*)(void *)' [-Werror=incompatible-pointer-types]
> >   281 |         .unreg = hid_bpf_unreg,
> >       |                  ^~~~~~~~~~~~~
> > /tmp/next/build/drivers/hid/bpf/hid_bpf_struct_ops.c:281:18: note: (near initialization for 'bpf_hid_bpf_ops.unreg')
> >
> > Caused by commit
> >
> >   73287fe228721b ("bpf: pass bpf_struct_ops_link to callbacks in bpf_struct_ops.")
> >
> > interacting with commit
> >
> >   ebc0d8093e8c97 ("HID: bpf: implement HID-BPF through bpf_struct_ops")
> >
> > from the HID tree.
> >
> > I've fixed it up as below:
> >
> > From e8aeaba00440845f9bd8d6183ca5d7383a678cd3 Mon Sep 17 00:00:00 2001
> > From: Mark Brown <broonie@kernel.org>
> > Date: Mon, 17 Jun 2024 19:02:27 +0100
> > Subject: [PATCH] HID: bpf: Fix up build
> >
> > Fix up build error due to 73287fe228721b ("bpf: pass bpf_struct_ops_link to callbacks in bpf_struct_ops.")
> >
> > Signed-off-by: Mark Brown <broonie@kernel.org>
> > ---
> >  drivers/hid/bpf/hid_bpf_struct_ops.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/hid/bpf/hid_bpf_struct_ops.c b/drivers/hid/bpf/hid_bpf_struct_ops.c
> > index 5f200557ff12b..744318e7d936b 100644
> > --- a/drivers/hid/bpf/hid_bpf_struct_ops.c
> > +++ b/drivers/hid/bpf/hid_bpf_struct_ops.c
> > @@ -175,7 +175,7 @@ static int hid_bpf_ops_init_member(const struct btf_type *t,
> >         return 0;
> >  }
> >
> > -static int hid_bpf_reg(void *kdata)
> > +static int hid_bpf_reg(void *kdata, struct bpf_link *link)
> >  {
> >         struct hid_bpf_ops *ops = kdata;
> >         struct hid_device *hdev;
> > @@ -229,7 +229,7 @@ static int hid_bpf_reg(void *kdata)
> >         return err;
> >  }
> >
> > -static void hid_bpf_unreg(void *kdata)
> > +static void hid_bpf_unreg(void *kdata, struct bpf_link *link)
> >  {
> >         struct hid_bpf_ops *ops = kdata;
> >         struct hid_device *hdev;
> > --
> > 2.39.2
> >

