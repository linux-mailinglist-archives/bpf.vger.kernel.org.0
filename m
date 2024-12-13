Return-Path: <bpf+bounces-46770-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D70309F00C0
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 01:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91360284F93
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 00:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C597A291E;
	Fri, 13 Dec 2024 00:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="HKdT9lJw"
X-Original-To: bpf@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98059621;
	Fri, 13 Dec 2024 00:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734049347; cv=none; b=h/8XCn2QyQdFqFbimGw+SlJXPR+Vv5wfwwzJ57ihjW6xVgckfY4iI8YzAcE7Akv23ofU7aGziegtJm6sEGCP3YJ5QZ59xcFBYuvu2Xnt8ZhUIIMwgaDM0Xt7cU0OC/c4a/oTpyOLfu3ME1/al8wHP2VxNO0zKmnM04NR9T2tSdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734049347; c=relaxed/simple;
	bh=3HNRmm/Q08QVyzMZ8XAUhAQfTbZ5JZRDoufN4hfqVDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ts8S8oYt2vymu7RbzMQW16Xw4ceEvvk3Sc7keV/hs58x9EDw5z3MqvUQLP0JZdCj5CmSXdA9P5yTks6VrKjyBdqF9o4a1rFiXWnXAKh2wWPFI/KP7teNXhZ4c+NmpwCqFPK+JhrqNd8xsKW67clDlgFUgWpKsHsqqQxA5RspIh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=HKdT9lJw; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1734049310; x=1734654110; i=w_armin@gmx.de;
	bh=pc4caFALq5op4/J6K3vAuBSZziJYzazQYmi+f4y4us4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=HKdT9lJw3caw772k0PNQomNYQqYZLiR13f8Vfz2/qvVrZZ5bHgHey1wk5jWWdlNO
	 xy4bMsqhzHz9PaFZ9q6OUKvpuicmDCQ4wObsyAV9A92JXqxpTEQwfugFK3vgNofln
	 9JP95F7Ogsj8Oe/K0l35N/wyfxOuULix1ZNtsJVTjpZo0Gp/YajB2c0LpmIXH5csO
	 dmEqk98u1WIKa1wsNJOvSenjaOdoe3wm8nM0o/nG3YRkKnHkwQ+lmch33baUegI9w
	 kCy9m8bJE3hPpW+josuT5veKifWkQU4ltg1U4fB9Hr8Y872BvYGrjPJXpeykH8IAi
	 zfxb1VH/inKDSOXIUQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.14] ([91.14.230.110]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MPXhA-1szFyp3XOM-00QRfF; Fri, 13
 Dec 2024 01:21:50 +0100
Message-ID: <2fbf5d9d-8cfe-4ce4-a268-ec84c261d1bd@gmx.de>
Date: Fri, 13 Dec 2024 01:21:37 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] platform/x86: wmi-bmof: Switch to
 sysfs_bin_attr_simple_read()
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Luis Chamberlain
 <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-modules@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 bpf@vger.kernel.org
References: <20241205-sysfs-const-bin_attr-simple-v1-0-4a4e4ced71e3@weissschuh.net>
 <20241205-sysfs-const-bin_attr-simple-v1-2-4a4e4ced71e3@weissschuh.net>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20241205-sysfs-const-bin_attr-simple-v1-2-4a4e4ced71e3@weissschuh.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sEqBGP2Ac0vGkBppc5TPHNF5GODfInD0hzbaCS0ddgYsItdBe5p
 2xdFdNBD2/3IFGQJS5l4ixxknu73P0PueOGSf9tMm/O8niUy+knHcsKr0WKRhQC8gmbaBRO
 zRP2UQtl9CHmKQKZsGzQuvW6QSUTtv15p13jP7TsWPqOn7D9/3d8lvbKady/tS3sg6AjSv+
 +gzIUgEAv0ESzIp9jiRtA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Q8yG4hNuxB0=;/TD9fKXzbRQiKwXr8w07+qxNhlk
 i9vONWUhyajPHgxY29yscwuFBNzChl/gBenVrS5CfDX0TkBkU0QEVpCzoBgJYq8JCG8Ib+XKz
 GU2fHxVRhscQyya3JySoKYRe4kfB2swn75GzgCw1PGvOIgV35oGKOHx4ZGs7bASK1FLGp4eNJ
 E4VZjhq4A4IFE/QZVk2JfeUbBoJ5jSYfeRBzb0HNpXU4xt0NwzQxkApcWAaQUE0m56Oyfbw/Y
 ihAjBrKUhYp76EnJcWbBFmll/Ln4bixJh2eclJdiYDzhZbddr3TzwxHXueHqwmZHJFKvDAp/g
 /FHYbkNwA26UNhauIj01Gb4BEAQw4A/npxYsD5FtyFOuxglv+5fucEmKZt21NHEY7t6ciBTGI
 b/cP1EOMstYEbPCKBldxE+j8g6vLgsEYl1k9ddA/s4hanj2x8zywItg54ZQOxuQOixBo3WS6k
 HGToeT69iUuBtqTAAF86BYLlHFG9p/n1xIJCcK+8NN1frLriWHTp0ypcYxfjt8AqiQF9hAZvr
 iTOxhdtEsr/10FkKIqHcqPNBYXdmYII+/Vt5/QOZd9MCKDOcISxmJpchayy5ER0EHeNaW+Obs
 aYe08KwjSpKZmtiA+Z0n8242n77wdKhRumxxZ5xFJZ82bGFZH8OPfFAOpru6vI1UosCMAw4EI
 xtTsnicAWtx+rsCPkNFAmAjsk0HtcqyG9yPepjiyA/JYqz95eSo6YpoeJ1Y6P3oJAWIA0QDab
 1fx02yBOS2xC8EnFQYNutlv09PeRIlMyWkY+tTWLt+jSDTl8oikDC2Np9UDo9SlsDuTMnCXrw
 GK7P6Ik0Xy52/pyuFYelHuero7udeVxxt0r/eXM6+g/WUU6A2AFNf+hBpnyRzWmrV7lExakvq
 CzKEHT+/JyDmLBsM7LjUKkmYNukMj2px+bj3hsKpzLjUZzq+8YzbWiVa007QspHQd9URppJ9K
 tCHDbQrIrfqbItGZeV3da0wqkjAqrOVvtF6PszvoOA32E7Tjh0qcc6GO5Ao8B0buAIanTSRsU
 9D8UD98oTXLhcjTLYDSztcAYd8LWoI9xYZZvdokPBDim9rnucTKvwyoyUyxGBMBHPG+xoyn6r
 YUBmZMg6vosbDcYZyJsE+BpIGE0PEI

Am 05.12.24 um 18:35 schrieb Thomas Wei=C3=9Fschuh:

> The generic function from the sysfs core can replace the custom one.

Sorry for taking quite a bit to respond, i totally overlooked this patch.

This patch is superseded by a patch of mine: https://lore.kernel.org/platf=
orm-driver-x86/20241206215650.2977-1-W_Armin@gmx.de/

This reworks the binary attribute handling inside the driver to use the ne=
w .bin_size() callback. This allows the
driver to have a static binary attribute which does not need a memory allo=
cation.

Because i think we cannot use sysfs_bin_attr_simple_read() anymore. So may=
be you can just drop this patch?

Thanks,
Armin Wolf

> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> ---
>   drivers/platform/x86/wmi-bmof.c | 12 ++----------
>   1 file changed, 2 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/platform/x86/wmi-bmof.c b/drivers/platform/x86/wmi-=
bmof.c
> index df6f0ae6e6c7904f97c125297a21166f56d0b1f0..e6c217d70086a2896dc70cf8=
ac1c27dafb501a95 100644
> --- a/drivers/platform/x86/wmi-bmof.c
> +++ b/drivers/platform/x86/wmi-bmof.c
> @@ -25,15 +25,6 @@ struct bmof_priv {
>   	struct bin_attribute bmof_bin_attr;
>   };
>
> -static ssize_t read_bmof(struct file *filp, struct kobject *kobj, struc=
t bin_attribute *attr,
> -			 char *buf, loff_t off, size_t count)
> -{
> -	struct bmof_priv *priv =3D container_of(attr, struct bmof_priv, bmof_b=
in_attr);
> -
> -	return memory_read_from_buffer(buf, count, &off, priv->bmofdata->buffe=
r.pointer,
> -				       priv->bmofdata->buffer.length);
> -}
> -
>   static int wmi_bmof_probe(struct wmi_device *wdev, const void *context=
)
>   {
>   	struct bmof_priv *priv;
> @@ -60,7 +51,8 @@ static int wmi_bmof_probe(struct wmi_device *wdev, con=
st void *context)
>   	sysfs_bin_attr_init(&priv->bmof_bin_attr);
>   	priv->bmof_bin_attr.attr.name =3D "bmof";
>   	priv->bmof_bin_attr.attr.mode =3D 0400;
> -	priv->bmof_bin_attr.read =3D read_bmof;
> +	priv->bmof_bin_attr.read_new =3D sysfs_bin_attr_simple_read;
> +	priv->bmof_bin_attr.private =3D priv->bmofdata->buffer.pointer;
>   	priv->bmof_bin_attr.size =3D priv->bmofdata->buffer.length;
>
>   	ret =3D device_create_bin_file(&wdev->dev, &priv->bmof_bin_attr);
>

