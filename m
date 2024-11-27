Return-Path: <bpf+bounces-45716-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7DF9DAAB1
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 16:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FA0F166B7D
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 15:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34781FF7D8;
	Wed, 27 Nov 2024 15:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="mjJ2AMfo"
X-Original-To: bpf@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5E11FF7C2;
	Wed, 27 Nov 2024 15:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732720940; cv=none; b=gqpgWazjsh1QLBLbuS+WrYb6Mm2skxkLvYnK+76tyQIJ+A2ZLCLZc3RPQUmdikHveB6jbAF8AX8sWiIpP9EQnJk8lbJz/lbgi/yQ3EcLP51RFucfrd35WyFIBqrflj2xEWhHh/8QxyNThXUTY3TD4kSDDc8CFm/CXf3VMzeGarI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732720940; c=relaxed/simple;
	bh=+3InKqe2qAdjjp6xq492AfyD2EpLQw09TtoBCofPou0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CVGVKkyOSKlMaXlrv6PrKLEiJr5C542zMGvAipF27RaFO4DGsbKfxCcPHyj/eoJlM4EcPfcv3xrt9HfJPIa+jTSwnx6H34uUI/OeduyawrYq+mAocuWW3Isw6dwv3JZyuCYGJLhaplKxZHL/OG0dIzxqfSAQrxnDlgCYHV01Ka4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=mjJ2AMfo; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1732720932;
	bh=+3InKqe2qAdjjp6xq492AfyD2EpLQw09TtoBCofPou0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mjJ2AMfow3qyyyaZ/euCqvl1CQvjDkdHeH5in1HTXovuhc542WrBmfTYCthwS0yFX
	 5bSfgK9R2COTMCNVET3k5q2K06tVUFzmP8p1Z+iAZfHL35wPD7ruvT/Q4ltjdsIbNV
	 KjXPlAFu8XtjB7vEOo9k+9VytTil06sXOcaT5kiE=
Date: Wed, 27 Nov 2024 16:22:12 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] btf: Use BIN_ATTR_SIMPLE_RO() to define vmlinux attribute
Message-ID: <998be751-3e7d-46e7-896e-6fd089f5dfa5@t-8ch.de>
References: <20241122-sysfs-const-bin_attr-bpf-v1-1-823aea399b53@weissschuh.net>
 <CAADnVQLV=7Mt+DTX84u_4kP_pVNhbyHMvL29BPcFQjOj7RpM7A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLV=7Mt+DTX84u_4kP_pVNhbyHMvL29BPcFQjOj7RpM7A@mail.gmail.com>

On 2024-11-26 17:52:29-0800, Alexei Starovoitov wrote:
> On Fri, Nov 22, 2024 at 4:57 AM Thomas Weißschuh <linux@weissschuh.net> wrote:
> >
> > The usage of the macro allows to remove the custom handler function,
> > saving some memory. Additionally the code is easier to read.
> >
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > ---
> > Something similar can be done to btf_module_read() in kernel/bpf/btf.c.
> > But doing it here and now would lead to some conflicts with some other
> > sysfs refactorings I'm doing. It will be part of a future series.
> > ---
> >  kernel/bpf/sysfs_btf.c | 21 +++++----------------
> >  1 file changed, 5 insertions(+), 16 deletions(-)
> >
> > diff --git a/kernel/bpf/sysfs_btf.c b/kernel/bpf/sysfs_btf.c
> > index fedb54c94cdb830a4890d33677dcc5a6e236c13f..a24381f933d0b80b11116d05463c35e9fa66acb1 100644
> > --- a/kernel/bpf/sysfs_btf.c
> > +++ b/kernel/bpf/sysfs_btf.c
> > @@ -12,34 +12,23 @@
> >  extern char __start_BTF[];
> >  extern char __stop_BTF[];
> >
> > -static ssize_t
> > -btf_vmlinux_read(struct file *file, struct kobject *kobj,
> > -                struct bin_attribute *bin_attr,
> > -                char *buf, loff_t off, size_t len)
> > -{
> > -       memcpy(buf, __start_BTF + off, len);
> > -       return len;
> > -}
> > -
> > -static struct bin_attribute bin_attr_btf_vmlinux __ro_after_init = {
> > -       .attr = { .name = "vmlinux", .mode = 0444, },
> > -       .read = btf_vmlinux_read,
> > -};
> > +static __ro_after_init BIN_ATTR_SIMPLE_RO(vmlinux);
> 
> To be honest I really don't like when code is hidden by macros like this.
> Looks like you guys already managed to sprinkle it in a few places.
> 
> btf_vmlinux_read() can be replaced with sysfs_bin_attr_simple_read().
> This part is fine, but macro pls dont.
> It doesn't help readability.
> imo mode = 0444 vs mode = 0400 is easier to understand
> instead of _RO vs _ADMIN_RO suffix.

I'm fine with either solution.

My patch is motivated by my current effort to constify 'struct
bin_attribute' throughout the kernel.
With the macro I only have to touch this location once,
without it twice.

If we go with a plain sysfs_bin_attr_simple_read() please let me do the
patch in another series I have prepared, to be submitted after 6.13-rc1.

> __ro_after_init should be a part of it, at least.

I see where you are coming from, it would break the pattern with all the
other attribute macros however.

> I'd like to hear what other maintainers think about
> such obfuscation.

Ack.

