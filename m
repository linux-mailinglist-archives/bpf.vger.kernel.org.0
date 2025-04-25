Return-Path: <bpf+bounces-56681-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72447A9C109
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 10:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A22571B867A2
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 08:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32308234963;
	Fri, 25 Apr 2025 08:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="t27exWrh"
X-Original-To: bpf@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1618D22D4DA
	for <bpf@vger.kernel.org>; Fri, 25 Apr 2025 08:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745570085; cv=none; b=EI8un8f1BLsJigKMPlTAXG5LlCm6cSdTBiFQHe03xpa6T6KwZoVC4tCdGS1ELq7IFAVzDmWUAqAo0RugfUyuIH+dqTlcCq4px6SKs6OCFaGZmqT0kH2q6GVYWlBqS1w0+GgBvh7bWODmo3hyNwy66130oud5icrs1P79w9iyPC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745570085; c=relaxed/simple;
	bh=zqsD8xYMTJiUyTNPJ2v23CAoV/EGj6ZV4YLILcwsABc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Prsur8P08hMcuwAfFTgduqQf8h5A673ZbtiOfbYNjM5r+iNVZBhD5rdwL2/Z5d4j6u+/GyMxdsKdNXB9FaTYiKgn5LFW/KN0Wu18OI2jHt+FbUB+zyx21SlYSZW2P6g0YM3i26NYXgb9VT/dKKGj7V8C/hxt4O0EEMaFZjrjgkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=t27exWrh; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
X-KPN-MessageId: 38cf2ff0-21b0-11f0-bc2a-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 38cf2ff0-21b0-11f0-bc2a-005056ab378f;
	Fri, 25 Apr 2025 10:35:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:from:to:subject:mime-version:date:message-id;
	bh=8/yvxp3z86rFOheLRFHFBHKY1EtIc/D5T7iQnuCrnGI=;
	b=t27exWrhxfrd/PunXsL+ZON/teXOUj69jJjeYPGfTZDsKbU2UhY6QxA5jZzSC2UfHti+CtC2R3YA1
	 2IsXKPGHqZyDmXCGVG1ocuiCaZbdz/PbJO+RwQmHPFtqnuQ379ia7IoJ56FXvxR5uyp2HBSvGXU/w1
	 Z9p2CK+pULqCDhKP67uLZYhiaC3ymBvqV6fhQnTdg/GgMTgy6FvqbFqWiDPwTcQdqha3eAeMvwKqNV
	 DS29lnDXjD4Qlvsq3awtRnnspWtKmCgoyMZW57lFwVfG6J+bJgoYIoDt5Ndg4YcB2cWAJUJqAqQOPS
	 /PK7PcEKKutczhZAsCdqyck4dGTG43w==
X-KPN-MID: 33|RIBl8qxlgmujX1FKwnzX9VyDT0ZAKCskxgm1P0W9jXQ8nZR5BAM8OCvJo8UWjik
 QYKCL9im91mYQLHEnPxtOf00QLEo2aniGRp+aXvEOCRo=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|kGQgDhys4HLyRALAx1+V9H0952u3JpG31JHo29NpY2zKbQx4XFVTCuo4pjiOlhB
 VdHI+mBwEKxtWXkx1o1G1Nw==
Received: from [192.168.1.10] (80-60-128-215.fixed.kpn.net [80.60.128.215])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 0336f9f5-21b0-11f0-855b-005056ab7584;
	Fri, 25 Apr 2025 10:34:36 +0200 (CEST)
Message-ID: <a00591dd-0698-4cd1-9715-446f973b877b@xs4all.nl>
Date: Fri, 25 Apr 2025 10:33:49 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/13] media: media/test_drivers: Replace open-coded
 parity calculation with parity_odd()
To: Kuan-Wei Chiu <visitorckw@gmail.com>, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
 jk@ozlabs.org, joel@jms.id.au, eajames@linux.ibm.com,
 andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, dmitry.torokhov@gmail.com,
 mchehab@kernel.org, awalls@md.metrocast.net, hverkuil@xs4all.nl,
 miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
 louis.peens@corigine.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, parthiban.veerasooran@microchip.com,
 arend.vanspriel@broadcom.com, johannes@sipsolutions.net,
 gregkh@linuxfoundation.org, jirislaby@kernel.org, yury.norov@gmail.com,
 akpm@linux-foundation.org, jdelvare@suse.com, linux@roeck-us.net,
 alexandre.belloni@bootlin.com, pgaj@cadence.com
Cc: hpa@zytor.com, alistair@popple.id.au, linux@rasmusvillemoes.dk,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
 linux-fsi@lists.ozlabs.org, dri-devel@lists.freedesktop.org,
 linux-input@vger.kernel.org, linux-media@vger.kernel.org,
 linux-mtd@lists.infradead.org, oss-drivers@corigine.com,
 netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com,
 linux-serial@vger.kernel.org, bpf@vger.kernel.org, jserv@ccns.ncku.edu.tw,
 Frank.Li@nxp.com, linux-hwmon@vger.kernel.org,
 linux-i3c@lists.infradead.org, david.laight.linux@gmail.com,
 andrew.cooper3@citrix.com, Yu-Chun Lin <eleanor15x@gmail.com>
References: <20250409154356.423512-1-visitorckw@gmail.com>
 <20250409154356.423512-3-visitorckw@gmail.com>
Content-Language: en-US, nl
From: Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20250409154356.423512-3-visitorckw@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/04/2025 17:43, Kuan-Wei Chiu wrote:
> Refactor parity calculations to use the standard parity_odd() helper.
> This change eliminates redundant implementations.
> 
> Co-developed-by: Yu-Chun Lin <eleanor15x@gmail.com>
> Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>

Reviewed-by: Hans Verkuil <hverkuil@xs4all.nl>

Regards,

	Hans

> ---
>  drivers/media/test-drivers/vivid/vivid-vbi-gen.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/media/test-drivers/vivid/vivid-vbi-gen.c b/drivers/media/test-drivers/vivid/vivid-vbi-gen.c
> index 70a4024d461e..5e1b7b1742e4 100644
> --- a/drivers/media/test-drivers/vivid/vivid-vbi-gen.c
> +++ b/drivers/media/test-drivers/vivid/vivid-vbi-gen.c
> @@ -5,6 +5,7 @@
>   * Copyright 2014 Cisco Systems, Inc. and/or its affiliates. All rights reserved.
>   */
>  
> +#include <linux/bitops.h>
>  #include <linux/errno.h>
>  #include <linux/kernel.h>
>  #include <linux/ktime.h>
> @@ -165,12 +166,7 @@ static const u8 vivid_cc_sequence2[30] = {
>  
>  static u8 calc_parity(u8 val)
>  {
> -	unsigned i;
> -	unsigned tot = 0;
> -
> -	for (i = 0; i < 7; i++)
> -		tot += (val & (1 << i)) ? 1 : 0;
> -	return val | ((tot & 1) ? 0 : 0x80);
> +	return val | (parity_odd(val) ? 0 : 0x80);
>  }
>  
>  static void vivid_vbi_gen_set_time_of_day(u8 *packet)


