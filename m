Return-Path: <bpf+bounces-45929-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E869E01D3
	for <lists+bpf@lfdr.de>; Mon,  2 Dec 2024 13:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 311C8282F8A
	for <lists+bpf@lfdr.de>; Mon,  2 Dec 2024 12:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BABC205E0A;
	Mon,  2 Dec 2024 12:08:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DAD205AD5;
	Mon,  2 Dec 2024 12:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733141283; cv=none; b=lW4pEYeesg8wB107FwbUGPdSdXWtCYG9agw3keiofz8V+kYkhsrE4QJa53ZQSMVE8LtHSAEQ86MHeaz/O3ryNH+IyvQE8/E1pwFIQv5z+C4UW/A/txug+5MdzLjsYK9MnIdoJ80okuDPStC8JEMzOLL6g8+6rnRksxB7fZ2x75c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733141283; c=relaxed/simple;
	bh=irNblZLdrYCtBnpyQvHjSa1m/xatk0N7MgeGuCUEzDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ia9rCWdoV7ntNvWb8SR1DwBku5jktmVACprU3HkenLE/sQhSVunXDtDXnnzoT+n9qnuA+RsBuykBCwaFi6hOaEFowl0NVARuuoIXN2AGoSYJhCzhnrF60zN2cP3g+f1HT8KY0+bb/K2C6oGNqQ0rFmuIvIaTftwz0rx8XwZxyOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 7789D1C00C4; Mon,  2 Dec 2024 13:07:59 +0100 (CET)
Date: Mon, 2 Dec 2024 13:07:58 +0100
From: Pavel Machek <pavel@denx.de>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Benjamin Tissoires <bentiss@kernel.org>,
	Tatsuyuki Ishi <ishitatsuyuki@gmail.com>,
	Jiri Kosina <jkosina@suse.com>, jikos@kernel.org,
	linux-input@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.19 4/4] HID: bpf: Fix NKRO on Mistel MD770
Message-ID: <Z02jHuRaDGfObqlV@duo.ucw.cz>
References: <20241124125856.3341388-1-sashal@kernel.org>
 <20241124125856.3341388-4-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vsDwWDiTVz93/nan"
Content-Disposition: inline
In-Reply-To: <20241124125856.3341388-4-sashal@kernel.org>


--vsDwWDiTVz93/nan
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Benjamin Tissoires <bentiss@kernel.org>
>=20
> [ Upstream commit 9bc089307e8dff7797233308372b4a90ce8f79be ]
>=20
> Mistel MD770 keyboard (using Holtek Semiconductor, Inc. controller) has
> a quirk in report descriptor in one of its interfaces (more detail in
> the source file). Fix up the descriptor to allow NKRO to work again.
>=20
> Tested by loading the BPF program and confirming that 8 simultaneous
> keypresses work.

Ummm. No. drivers/hid/bpf/progs/ not existing in 4.19 should be a
hint.

Best regards,
								Pavel
							=09
> +++ b/drivers/hid/bpf/progs/Mistel__MD770.bpf.c
> @@ -0,0 +1,154 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2024 Tatsuyuki Ishi
> + */
> +
> +#include "vmlinux.h"
> +#include "hid_bpf.h"
> +#include "hid_bpf_helpers.h"
> +#include <bpf/bpf_tracing.h>
> +
> +#define VID_HOLTEK	0x04D9
> +#define PID_MD770	0x0339
> +#define RDESC_SIZE	203
> +
> +HID_BPF_CONFIG(
> +	HID_DEVICE(BUS_USB, HID_GROUP_GENERIC, VID_HOLTEK, PID_MD770)
> +);
> +
> +/*
> + * The Mistel MD770 keyboard reports the first 6 simultaneous key presses
> + * through the first interface, and anything beyond that through a second
> + * interface. Unfortunately, the second interface's report descriptor ha=
s an
> + * error, causing events to be malformed and ignored. This HID-BPF driver
> + * fixes the descriptor to allow NKRO to work again.
> + *
> + * For reference, this is the original report descriptor:
> + *
> + * 0x05, 0x01,        // Usage Page (Generic Desktop)        0
> + * 0x09, 0x80,        // Usage (System Control)              2
> + * 0xa1, 0x01,        // Collection (Application)            4
> + * 0x85, 0x01,        //  Report ID (1)                      6
> + * 0x19, 0x81,        //  Usage Minimum (129)                8
> + * 0x29, 0x83,        //  Usage Maximum (131)                10
> + * 0x15, 0x00,        //  Logical Minimum (0)                12
> + * 0x25, 0x01,        //  Logical Maximum (1)                14
> + * 0x95, 0x03,        //  Report Count (3)                   16
> + * 0x75, 0x01,        //  Report Size (1)                    18
> + * 0x81, 0x02,        //  Input (Data,Var,Abs)               20
> + * 0x95, 0x01,        //  Report Count (1)                   22
> + * 0x75, 0x05,        //  Report Size (5)                    24
> + * 0x81, 0x01,        //  Input (Cnst,Arr,Abs)               26
> + * 0xc0,              // End Collection                      28
> + * 0x05, 0x0c,        // Usage Page (Consumer Devices)       29
> + * 0x09, 0x01,        // Usage (Consumer Control)            31
> + * 0xa1, 0x01,        // Collection (Application)            33
> + * 0x85, 0x02,        //  Report ID (2)                      35
> + * 0x15, 0x00,        //  Logical Minimum (0)                37
> + * 0x25, 0x01,        //  Logical Maximum (1)                39
> + * 0x95, 0x12,        //  Report Count (18)                  41
> + * 0x75, 0x01,        //  Report Size (1)                    43
> + * 0x0a, 0x83, 0x01,  //  Usage (AL Consumer Control Config) 45
> + * 0x0a, 0x8a, 0x01,  //  Usage (AL Email Reader)            48
> + * 0x0a, 0x92, 0x01,  //  Usage (AL Calculator)              51
> + * 0x0a, 0x94, 0x01,  //  Usage (AL Local Machine Browser)   54
> + * 0x09, 0xcd,        //  Usage (Play/Pause)                 57
> + * 0x09, 0xb7,        //  Usage (Stop)                       59
> + * 0x09, 0xb6,        //  Usage (Scan Previous Track)        61
> + * 0x09, 0xb5,        //  Usage (Scan Next Track)            63
> + * 0x09, 0xe2,        //  Usage (Mute)                       65
> + * 0x09, 0xea,        //  Usage (Volume Down)                67
> + * 0x09, 0xe9,        //  Usage (Volume Up)                  69
> + * 0x0a, 0x21, 0x02,  //  Usage (AC Search)                  71
> + * 0x0a, 0x23, 0x02,  //  Usage (AC Home)                    74
> + * 0x0a, 0x24, 0x02,  //  Usage (AC Back)                    77
> + * 0x0a, 0x25, 0x02,  //  Usage (AC Forward)                 80
> + * 0x0a, 0x26, 0x02,  //  Usage (AC Stop)                    83
> + * 0x0a, 0x27, 0x02,  //  Usage (AC Refresh)                 86
> + * 0x0a, 0x2a, 0x02,  //  Usage (AC Bookmarks)               89
> + * 0x81, 0x02,        //  Input (Data,Var,Abs)               92
> + * 0x95, 0x01,        //  Report Count (1)                   94
> + * 0x75, 0x0e,        //  Report Size (14)                   96
> + * 0x81, 0x01,        //  Input (Cnst,Arr,Abs)               98
> + * 0xc0,              // End Collection                      100
> + * 0x05, 0x01,        // Usage Page (Generic Desktop)        101
> + * 0x09, 0x02,        // Usage (Mouse)                       103
> + * 0xa1, 0x01,        // Collection (Application)            105
> + * 0x09, 0x01,        //  Usage (Pointer)                    107
> + * 0xa1, 0x00,        //  Collection (Physical)              109
> + * 0x85, 0x03,        //   Report ID (3)                     111
> + * 0x05, 0x09,        //   Usage Page (Button)               113
> + * 0x19, 0x01,        //   Usage Minimum (1)                 115
> + * 0x29, 0x08,        //   Usage Maximum (8)                 117
> + * 0x15, 0x00,        //   Logical Minimum (0)               119
> + * 0x25, 0x01,        //   Logical Maximum (1)               121
> + * 0x75, 0x01,        //   Report Size (1)                   123
> + * 0x95, 0x08,        //   Report Count (8)                  125
> + * 0x81, 0x02,        //   Input (Data,Var,Abs)              127
> + * 0x05, 0x01,        //   Usage Page (Generic Desktop)      129
> + * 0x09, 0x30,        //   Usage (X)                         131
> + * 0x09, 0x31,        //   Usage (Y)                         133
> + * 0x16, 0x01, 0x80,  //   Logical Minimum (-32767)          135
> + * 0x26, 0xff, 0x7f,  //   Logical Maximum (32767)           138
> + * 0x75, 0x10,        //   Report Size (16)                  141
> + * 0x95, 0x02,        //   Report Count (2)                  143
> + * 0x81, 0x06,        //   Input (Data,Var,Rel)              145
> + * 0x09, 0x38,        //   Usage (Wheel)                     147
> + * 0x15, 0x81,        //   Logical Minimum (-127)            149
> + * 0x25, 0x7f,        //   Logical Maximum (127)             151
> + * 0x75, 0x08,        //   Report Size (8)                   153
> + * 0x95, 0x01,        //   Report Count (1)                  155
> + * 0x81, 0x06,        //   Input (Data,Var,Rel)              157
> + * 0x05, 0x0c,        //   Usage Page (Consumer Devices)     159
> + * 0x0a, 0x38, 0x02,  //   Usage (AC Pan)                    161
> + * 0x95, 0x01,        //   Report Count (1)                  164
> + * 0x81, 0x06,        //   Input (Data,Var,Rel)              166
> + * 0xc0,              //  End Collection                     168
> + * 0xc0,              // End Collection                      169
> + * 0x05, 0x01,        // Usage Page (Generic Desktop)        170
> + * 0x09, 0x06,        // Usage (Keyboard)                    172
> + * 0xa1, 0x01,        // Collection (Application)            174
> + * 0x85, 0x04,        //  Report ID (4)                      176
> + * 0x05, 0x07,        //  Usage Page (Keyboard)              178
> + * 0x95, 0x01,        //  Report Count (1)                   180
> + * 0x75, 0x08,        //  Report Size (8)                    182
> + * 0x81, 0x03,        //  Input (Cnst,Var,Abs)               184
> + * 0x95, 0xe8,        //  Report Count (232)                 186
> + * 0x75, 0x01,        //  Report Size (1)                    188
> + * 0x15, 0x00,        //  Logical Minimum (0)                190
> + * 0x25, 0x01,        //  Logical Maximum (1)                192
> + * 0x05, 0x07,        //  Usage Page (Keyboard)              194
> + * 0x19, 0x00,        //  Usage Minimum (0)                  196
> + * 0x29, 0xe7,        //  Usage Maximum (231)                198
> + * 0x81, 0x00,        //  Input (Data,Arr,Abs)               200  <- cha=
nge to 0x81, 0x02 (Data,Var,Abs)
> + * 0xc0,              // End Collection                      202
> + */
> +
> +SEC(HID_BPF_RDESC_FIXUP)
> +int BPF_PROG(hid_rdesc_fixup_mistel_md770, struct hid_bpf_ctx *hctx)
> +{
> +	__u8 *data =3D hid_bpf_get_data(hctx, 0, HID_MAX_DESCRIPTOR_SIZE);
> +
> +	if (!data)
> +		return 0; /* EPERM check */
> +
> +	if (data[201] =3D=3D 0x00)
> +		data[201] =3D 0x02;
> +
> +	return 0;
> +}
> +
> +HID_BPF_OPS(mistel_md770) =3D {
> +	.hid_rdesc_fixup =3D (void *)hid_rdesc_fixup_mistel_md770,
> +};
> +
> +SEC("syscall")
> +int probe(struct hid_bpf_probe_args *ctx)
> +{
> +	ctx->retval =3D ctx->rdesc_size !=3D RDESC_SIZE;
> +	if (ctx->retval)
> +		ctx->retval =3D -EINVAL;
> +
> +	return 0;
> +}
> +
> +char _license[] SEC("license") =3D "GPL";

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--vsDwWDiTVz93/nan
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ02jHgAKCRAw5/Bqldv6
8mBpAJ4+zrTF62wmLMLh/dDetCm2qKVLdgCeJpSDNMGscifSd8bvj38q0sGxIk4=
=c6pS
-----END PGP SIGNATURE-----

--vsDwWDiTVz93/nan--

