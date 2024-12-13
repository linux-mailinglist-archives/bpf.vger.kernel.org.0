Return-Path: <bpf+bounces-46825-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7137C9F05A6
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 08:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F4A4169EB0
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 07:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A40199FA2;
	Fri, 13 Dec 2024 07:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="ohI0IvaJ"
X-Original-To: bpf@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F097196D8F;
	Fri, 13 Dec 2024 07:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734075834; cv=none; b=Wj+hz//hnQcJwJEzWS6wHNaXlMwBZ2ijxtqOdO3U2UXCjSI/I9iq2buSrhnZTDFwPFeKMI9DcsQkZqAow3nOioMabRJCNR6k4Wz/t/GakAcuWARqWVy6rbIQGxyZPGRG0zXGfWh9iyeoyReotOTQ8dKoo9toz2gf0aryuDLBcmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734075834; c=relaxed/simple;
	bh=lHwtD1iPNGzdJwYjIGoo8w0zLrhQgGX7/hX9tiBWhM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MN1T8uBOT+bxrs/M5qQOuRarwyp34nn+hObMu9afr5LhmvxdVHSVk4MtcFgoSE6yT/avli5HnQdRyOtIpTjMWkt15ntnc1HuhyLBsa3c1qf0oCYvOe8yxAxkHeGIHiASZMKj3QI3wLoJOSsR0qrxMDgH+WkCoG3fl0C8uLQbEUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=ohI0IvaJ; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1734075826;
	bh=lHwtD1iPNGzdJwYjIGoo8w0zLrhQgGX7/hX9tiBWhM4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ohI0IvaJ5l9TNKXFl3u2YGdIyF/Va5/dQjCulUrI7V490GJY9EOjo9j7wMsjITTC7
	 pc3iTWYawwbQ9UmwE2rFrXjOFGwmG6JEWGIGIV+E172fpwZa2XnJ2KxDF3NkpU/50o
	 uOeiloPI/w2dHQjKKp4tLqJokisytzKAKFS6T77w=
Date: Fri, 13 Dec 2024 08:43:46 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Armin Wolf <W_Armin@gmx.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>, 
	Hans de Goede <hdegoede@redhat.com>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 2/4] platform/x86: wmi-bmof: Switch to
 sysfs_bin_attr_simple_read()
Message-ID: <d1580513-6297-46b5-b4e0-c2063496b2ed@t-8ch.de>
References: <20241205-sysfs-const-bin_attr-simple-v1-0-4a4e4ced71e3@weissschuh.net>
 <20241205-sysfs-const-bin_attr-simple-v1-2-4a4e4ced71e3@weissschuh.net>
 <2fbf5d9d-8cfe-4ce4-a268-ec84c261d1bd@gmx.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2fbf5d9d-8cfe-4ce4-a268-ec84c261d1bd@gmx.de>

Hi Armin,

On 2024-12-13 01:21:37+0100, Armin Wolf wrote:
> Am 05.12.24 um 18:35 schrieb Thomas Weißschuh:
> 
> > The generic function from the sysfs core can replace the custom one.
> 
> Sorry for taking quite a bit to respond, i totally overlooked this patch.
> 
> This patch is superseded by a patch of mine: https://lore.kernel.org/platform-driver-x86/20241206215650.2977-1-W_Armin@gmx.de/
> 
> This reworks the binary attribute handling inside the driver to use the new .bin_size() callback. This allows the
> driver to have a static binary attribute which does not need a memory allocation.
> 
> Because i think we cannot use sysfs_bin_attr_simple_read() anymore. So maybe you can just drop this patch?

Works for me, thanks!

Thomas

> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > ---
> >   drivers/platform/x86/wmi-bmof.c | 12 ++----------
> >   1 file changed, 2 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/platform/x86/wmi-bmof.c b/drivers/platform/x86/wmi-bmof.c
> > index df6f0ae6e6c7904f97c125297a21166f56d0b1f0..e6c217d70086a2896dc70cf8ac1c27dafb501a95 100644
> > --- a/drivers/platform/x86/wmi-bmof.c
> > +++ b/drivers/platform/x86/wmi-bmof.c
> > @@ -25,15 +25,6 @@ struct bmof_priv {
> >   	struct bin_attribute bmof_bin_attr;
> >   };
> > 
> > -static ssize_t read_bmof(struct file *filp, struct kobject *kobj, struct bin_attribute *attr,
> > -			 char *buf, loff_t off, size_t count)
> > -{
> > -	struct bmof_priv *priv = container_of(attr, struct bmof_priv, bmof_bin_attr);
> > -
> > -	return memory_read_from_buffer(buf, count, &off, priv->bmofdata->buffer.pointer,
> > -				       priv->bmofdata->buffer.length);
> > -}
> > -
> >   static int wmi_bmof_probe(struct wmi_device *wdev, const void *context)
> >   {
> >   	struct bmof_priv *priv;
> > @@ -60,7 +51,8 @@ static int wmi_bmof_probe(struct wmi_device *wdev, const void *context)
> >   	sysfs_bin_attr_init(&priv->bmof_bin_attr);
> >   	priv->bmof_bin_attr.attr.name = "bmof";
> >   	priv->bmof_bin_attr.attr.mode = 0400;
> > -	priv->bmof_bin_attr.read = read_bmof;
> > +	priv->bmof_bin_attr.read_new = sysfs_bin_attr_simple_read;
> > +	priv->bmof_bin_attr.private = priv->bmofdata->buffer.pointer;
> >   	priv->bmof_bin_attr.size = priv->bmofdata->buffer.length;
> > 
> >   	ret = device_create_bin_file(&wdev->dev, &priv->bmof_bin_attr);
> > 

