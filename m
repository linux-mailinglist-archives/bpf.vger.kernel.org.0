Return-Path: <bpf+bounces-52991-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D26DA4AF04
	for <lists+bpf@lfdr.de>; Sun,  2 Mar 2025 04:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF3BF3ABA77
	for <lists+bpf@lfdr.de>; Sun,  2 Mar 2025 03:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1441420DD;
	Sun,  2 Mar 2025 03:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aP8FiN+6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B4AA944;
	Sun,  2 Mar 2025 03:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740885026; cv=none; b=jnInRAJ9+lWtqLo0Stv1bF6t8X9Yv9BmQuTtxqJZvFgi/j2ibgr8gPwpcOR87M4QyJdb0wTKxioYCqoNSRojq7a6Z7sM8T5xcTBt6VOyegFRmKGcIkGbHtz6aF5bnIBEmxnUmDQzzAfg5H0t1N+vHIUBctfsbJcR9+ylBcIa10A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740885026; c=relaxed/simple;
	bh=GfVA9iYjHO8XmgappW8jDQpwvJ712gVxe73p2a1Wyq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lzh32sx/liWbb4DfR9vKx0j0bfrp+eIMKC4FIwMoTyfYwwXdmre9o0eHSy9Rw4G2z4u46W+H35EgjEmwO3Pe343VUeNITLYm3S0K99PsnPsERjqwdsi9W/EJNqdhcYakY3FMTI/Bf7h+or9ry1RQeWK0bXH2zhPoZ7DJGSu/GjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aP8FiN+6; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6fd5a24a8d8so10823717b3.1;
        Sat, 01 Mar 2025 19:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740885024; x=1741489824; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4LbN5fYyUHQt3Ti89i5IrvWdlm9UYzm7rEomie5t+cc=;
        b=aP8FiN+6DzcA/R8Iq7Ni+fzBMbE02fMUhwsW7ph3YRnZtct6+VS9+G7bjd/Sce0xNR
         Tlqv3E4XyuUENeY4hXUXpT60iQOVAnPYusgrVwHQ6JIuZ6nRCWusSxLWIIpwKmgOZoHY
         kHvqI83E/ez7J9AZI4xubsgJO7rIxYntfXJCGhhW8rjO7SglfH2N1rV7Iumxo61sS2rz
         HT/5b5CBElZZI0qSM1cCp1w0o/Bvsh3tKzOJzEOoVg6ToTX5DVYmmTQh0tzDr+HQ5pkD
         R52zu8eG+KkolVRICvFRmWw9DbxdCsiuP1nd+XqxmV+TQ6VWTKcnFzlIdL+uzH9f546+
         K6lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740885024; x=1741489824;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4LbN5fYyUHQt3Ti89i5IrvWdlm9UYzm7rEomie5t+cc=;
        b=FF7jRWTTwgsBL8iBQ0XoO+84RgoaFH4756o+47LEdVz/Ll28sM49a+bry0youadyds
         FjsR9c4es64Q56+/QVqhjWXKGgMcRylmh4nHLKbI2Ksowd+fHs0PvK1r0XO8+0vXZtgo
         aB7fiFDOWRd6Ehnm+Kyp69NVzjCCGJmOvQUsIppXVS+ueNnq/k2bK3xK1TY3QK71F9UW
         UkwUcFfgy1ICGr4I/adwC4OVDxOghQYHm6MCkFMdRuhxatcUODEqBCR0sU24i8Lpa8U2
         OrQ0qsiviF+Gzk/e8Q3ktGAEibDvd60HtLToiNNEY71DuSLJeXMBzo3BxbZHVNhUZ1Cj
         jrQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvgHHlOROPfy417MvznPgThn1XsayAYj6A97m/bubaIhAwJzRzULDYZWbGi2CGUTROJ2OmE7umPPoIfc3K@vger.kernel.org, AJvYcCWLQrWs3aosqLafWlzRaYlL0thsPLxHJG2WAtM4ZXde++cpEgCE1Vz8WN9GL1UHeHmpjWcZiLCqpxavBow=@vger.kernel.org, AJvYcCWXb7dDkoKWYLasvTV/HsWyliF813vB7Qn8YYoyDL71MFSTo4Ax0RAmjoUGRRSMCeRz+SxAlVFtnwNONb0=@vger.kernel.org, AJvYcCX4OaqZy0sc5fPo+IyEYahpOt1bSVgbSKjBIwo5d6k3K1gCnJ6QUgLo0gz8AKEcro8yuts=@vger.kernel.org, AJvYcCXE5bLHyey3rju9G/ceeiL54zMIs3naCKPN5BY/Be/CkxVr0oEU2UZ6w7YiOBVWg7t0mS05IBsO@vger.kernel.org, AJvYcCXV5KF9GsUcDNqXAAcaG9rftfA7Tlb2ArwDPI513W2Wv3p9mhGdE/nkUxkJizORqIPalQZpkezv62X7YWypoh8=@vger.kernel.org, AJvYcCXh3q353AZlTupjo01BAraT0ws4EgJrI8YJZfKgRg8PxgQLCQZT1eiR47Qd++iuMP7WZaXHDg/uXNQiYd9T@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3N9Jcu8DHASSKddK6RLPCGML8T1/uns2KZBRbonj1fOjaL8su
	crjplkCosc49rT4zVhrKMw66v2DkG7TjU4CunlicpYbf/lBAjhHa
X-Gm-Gg: ASbGncvPShCKLwgvKZBwtzReaLityn5is4F1+cQmVLxHkoEupn0DrVxFFPD9xsbGGXD
	oaZIo4skHgeZa52mU6YliaBWj84iF5I4Rv7JvHc8ma5tOhalH4Ij8ZddLIoh5obi48rdN1qEUjd
	389ujoaaHJ78zujhXrQF6S4dh/ySsmHW0tgcQu9iOkF5C+0JKljbdvtkhnjJKiwFMdzzL5nMlgU
	Vku8Pk6ccvumui5Dn+tes5/xEdUSkIQPJU1iMlF+bSL1tOfquG+tkifgSo2gQGquvUdGN69/pM1
	MUG4sa/7w+AcvUUYec1XdiPzR6BFHxGeshb0pPyDjy9aiZUKiIDLs9rFYWkFuLlP8t64lTVm/s7
	NJ+xr
X-Google-Smtp-Source: AGHT+IEy03FjYEvkbsUi6/ttRTlOKe4T1PD9HCNrsgjQ3AH1f8i6gR4SnirQZ7DNyXo/QUPkw2L8/g==
X-Received: by 2002:a05:690c:4b12:b0:6fb:9450:b0c3 with SMTP id 00721157ae682-6fd4a02b0d8mr124121857b3.19.1740885024067;
        Sat, 01 Mar 2025 19:10:24 -0800 (PST)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6fd3cb9dac4sm13986657b3.102.2025.03.01.19.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 19:10:22 -0800 (PST)
Date: Sat, 1 Mar 2025 22:10:20 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, jk@ozlabs.org,
	joel@jms.id.au, eajames@linux.ibm.com, andrzej.hajda@intel.com,
	neil.armstrong@linaro.org, rfoss@kernel.org,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
	dmitry.torokhov@gmail.com, mchehab@kernel.org,
	awalls@md.metrocast.net, hverkuil@xs4all.nl,
	miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
	louis.peens@corigine.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	parthiban.veerasooran@microchip.com, arend.vanspriel@broadcom.com,
	johannes@sipsolutions.net, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, akpm@linux-foundation.org, hpa@zytor.com,
	alistair@popple.id.au, linux@rasmusvillemoes.dk,
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
	jernej.skrabec@gmail.com, kuba@kernel.org,
	linux-kernel@vger.kernel.org, linux-fsi@lists.ozlabs.org,
	dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org,
	linux-media@vger.kernel.org, linux-mtd@lists.infradead.org,
	oss-drivers@corigine.com, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com, linux-serial@vger.kernel.org,
	bpf@vger.kernel.org, jserv@ccns.ncku.edu.tw,
	david.laight.linux@gmail.com, andrew.cooper3@citrix.com,
	Yu-Chun Lin <eleanor15x@gmail.com>
Subject: Re: [PATCH v2 01/18] lib/parity: Add __builtin_parity() fallback
 implementations
Message-ID: <Z8PMHLYHOkCZJpOh@thinkpad>
References: <20250301142409.2513835-1-visitorckw@gmail.com>
 <20250301142409.2513835-2-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250301142409.2513835-2-visitorckw@gmail.com>

On Sat, Mar 01, 2025 at 10:23:52PM +0800, Kuan-Wei Chiu wrote:
> Add generic C implementations of __paritysi2(), __paritydi2(), and
> __parityti2() as fallback functions in lib/parity.c. These functions
> compute the parity of a given integer using a bitwise approach and are
> marked with __weak, allowing architecture-specific implementations to
> override them.
> 
> This patch serves as preparation for using __builtin_parity() by
> ensuring a fallback mechanism is available when the compiler does not
> inline the __builtin_parity().
> 
> Co-developed-by: Yu-Chun Lin <eleanor15x@gmail.com>
> Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---
>  lib/Makefile |  2 +-
>  lib/parity.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 49 insertions(+), 1 deletion(-)
>  create mode 100644 lib/parity.c
> 
> diff --git a/lib/Makefile b/lib/Makefile
> index 7bab71e59019..45affad85ee4 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -51,7 +51,7 @@ obj-y += bcd.o sort.o parser.o debug_locks.o random32.o \
>  	 bsearch.o find_bit.o llist.o lwq.o memweight.o kfifo.o \
>  	 percpu-refcount.o rhashtable.o base64.o \
>  	 once.o refcount.o rcuref.o usercopy.o errseq.o bucket_locks.o \
> -	 generic-radix-tree.o bitmap-str.o
> +	 generic-radix-tree.o bitmap-str.o parity.o
>  obj-y += string_helpers.o
>  obj-y += hexdump.o
>  obj-$(CONFIG_TEST_HEXDUMP) += test_hexdump.o
> diff --git a/lib/parity.c b/lib/parity.c
> new file mode 100644
> index 000000000000..a83ff8d96778
> --- /dev/null
> +++ b/lib/parity.c
> @@ -0,0 +1,48 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * lib/parity.c
> + *
> + * Copyright (C) 2025 Kuan-Wei Chiu <visitorckw@gmail.com>
> + * Copyright (C) 2025 Yu-Chun Lin <eleanor15x@gmail.com>
> + *
> + * __parity[sdt]i2 can be overridden by linking arch-specific versions.
> + */
> +
> +#include <linux/export.h>
> +#include <linux/kernel.h>
> +
> +/*
> + * One explanation of this algorithm:
> + * https://funloop.org/codex/problem/parity/README.html

I already asked you not to spread this link. Is there any reason to
ignore it?

> + */
> +int __weak __paritysi2(u32 val);
> +int __weak __paritysi2(u32 val)
> +{
> +	val ^= val >> 16;
> +	val ^= val >> 8;
> +	val ^= val >> 4;
> +	return (0x6996 >> (val & 0xf)) & 1;
> +}
> +EXPORT_SYMBOL(__paritysi2);
> +
> +int __weak __paritydi2(u64 val);
> +int __weak __paritydi2(u64 val)
> +{
> +	val ^= val >> 32;
> +	val ^= val >> 16;
> +	val ^= val >> 8;
> +	val ^= val >> 4;
> +	return (0x6996 >> (val & 0xf)) & 1;
> +}
> +EXPORT_SYMBOL(__paritydi2);
> +
> +int __weak __parityti2(u64 val);
> +int __weak __parityti2(u64 val)
> +{
> +	val ^= val >> 32;
> +	val ^= val >> 16;
> +	val ^= val >> 8;
> +	val ^= val >> 4;
> +	return (0x6996 >> (val & 0xf)) & 1;
> +}
> +EXPORT_SYMBOL(__parityti2);

OK, it seems I wasn't clear enough on the previous round, so I'll try
to be very straightforward now.

To begin with, the difference between __parityti2 and __paritydi2 
doesn't exist. I'm seriously. I put them side by side, and there's
no difference at all.

Next, this all is clearly an overengineering. You bake all those weak,
const and (ironically, missing) high-efficient arch implementations.
But you show no evidence that:
 - it improves on code generation,
 - the drivers care about parity()'s performance, and
 - show no perf tests at all.

So you end up with +185/-155 LOCs.

Those +30 lines add no new functionality. You copy-paste the same
algorithm again and again in very core kernel files. This is a no-go
for a nice consolidation series.

In the previous round reviewers gave you quite a few nice suggestions.
H. Peter Anvin suggested to switch the function to return a boolean, I
suggested to make it a macro and even sent you a patch, Jiri and David
also spent their time trying to help you, and became ignored.

Nevertheless. NAK for the series. Whatever you end up, if it comes to
v3, please make it simple, avoid code duplication and run checkpatch.

Thanks,
Yury

