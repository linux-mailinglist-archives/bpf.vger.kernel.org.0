Return-Path: <bpf+bounces-45658-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9E09D9EF3
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 22:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43691166885
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 21:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F11C1DFD9F;
	Tue, 26 Nov 2024 21:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="nrfPjwbI"
X-Original-To: bpf@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AD31DF963;
	Tue, 26 Nov 2024 21:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732657339; cv=none; b=fEwpqqgttsG+b6mu+xwfWzYb4vjkeH7hLIBedgmgK3Sl/V9Uq0e709gwAgtVpiTG0LIhhyBcGQV2xc7U2BCVQWk+85w7kNhDG2gmAXMtJPJxrvxMNVB9K9c09VEf2Biap0jao7T9ATjrdlPH3FUnW0AEARSoiHuAYZmrLfxiniY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732657339; c=relaxed/simple;
	bh=KLOxZqYqAMVocTruSnmp0YRWLPlKl6C/iQVIZbJW18w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jnxiD/KW27mxpWfJ8HTcS0MvJn+CCLaUF5UIZxL9eByJn+xiyVhz6Y4jO8zNzF7v1KpMgfZd5DAL4uCaeYI66AgrGtd9KzLOx8/PcEzwIlSGlS+hdVdyFLIZEaaLEtY1N0c61zp8reQIoqTJT0+98U1vKMJb/2PxtL8Yjn3h1kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=nrfPjwbI; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1732657336;
	bh=KLOxZqYqAMVocTruSnmp0YRWLPlKl6C/iQVIZbJW18w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nrfPjwbIU85kXd+xpm7HaeyT8NnV9bAFCG9ftOLTlHe9z8yvhTi6q04pTaUqxB21f
	 xfpv1qTfFpSTbWAU5SupZhHT3CzHIX8/K91kSwGkslgxtoBYdHv2mt5pFA7RbLiDS+
	 awbYg+e7KKD3MjZX0D3m76rBlgeJfbDC9y6ipLbU=
Date: Tue, 26 Nov 2024 22:42:15 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btf: Use BIN_ATTR_SIMPLE_RO() to define vmlinux attribute
Message-ID: <5307ea3b-6720-4ca9-827e-7338f255908f@t-8ch.de>
References: <20241122-sysfs-const-bin_attr-bpf-v1-1-823aea399b53@weissschuh.net>
 <CAEf4BzbNs=MVNDztRW_76f8aQkm44ykiibqGa2REThWM4dVa_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbNs=MVNDztRW_76f8aQkm44ykiibqGa2REThWM4dVa_g@mail.gmail.com>

On 2024-11-26 13:37:26-0800, Andrii Nakryiko wrote:
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
> 
> Nice, let's simplify. But why change the name to generic "vmlinux" if
> it's actually btf_vmlinux? Can we keep the original btf-specific name?

The file in sysfs is named "vmlinux", /sys/kernel/btf/vmlinux.
This is what needs to be passed to the macro, it will name both the
variable and the file after it.

One alternative would be to use __BIN_ATTR_SIMPLE_RO() which allows a
custom name.

> 
> pw-bot: cr
> 
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
> >
> >  struct kobject *btf_kobj;
> >
> >  static int __init btf_vmlinux_init(void)
> >  {
> > -       bin_attr_btf_vmlinux.size = __stop_BTF - __start_BTF;
> > +       bin_attr_vmlinux.private = __start_BTF;
> > +       bin_attr_vmlinux.size = __stop_BTF - __start_BTF;
> >
> > -       if (bin_attr_btf_vmlinux.size == 0)
> > +       if (bin_attr_vmlinux.size == 0)
> >                 return 0;
> >
> >         btf_kobj = kobject_create_and_add("btf", kernel_kobj);
> >         if (!btf_kobj)
> >                 return -ENOMEM;
> >
> > -       return sysfs_create_bin_file(btf_kobj, &bin_attr_btf_vmlinux);
> > +       return sysfs_create_bin_file(btf_kobj, &bin_attr_vmlinux);
> >  }
> >
> >  subsys_initcall(btf_vmlinux_init);
> >
> > ---
> > base-commit: 28eb75e178d389d325f1666e422bc13bbbb9804c
> > change-id: 20241122-sysfs-const-bin_attr-bpf-737286bb9f27
> >
> > Best regards,
> > --
> > Thomas Weißschuh <linux@weissschuh.net>
> >

