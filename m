Return-Path: <bpf+bounces-55557-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98653A82D1D
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 19:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57A393B8F1B
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 17:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D51270ED7;
	Wed,  9 Apr 2025 17:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bpJKXJZ3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2AE5D477;
	Wed,  9 Apr 2025 17:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744218228; cv=none; b=cRi2aMnsCkgSLYdvr41wbSYP/akCNlWfqW2uJ+Xvc7CBkA9dJGev4pxleIukbXAhxXcNwp64h7L1S/6PTmwaHKnqfAL8JASvUeTtG5heUXTECI7MEBnbYeMIZkqs9UlGGV/mIi87N5Qg+zdd3SkTnbQCtSZyjlHjMBTGulIo8yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744218228; c=relaxed/simple;
	bh=TATLEc8yWLoSrEOkEJVOcVvh6A655FoOwWh3JdEOR0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JC0BelN2+R2kgdzFm0CsMYrwzZuct+VHSjExKrWVc5Ev7Fi0mMf8nMCBwQCD38m6Ffmt3Ybn4yv8jvKYd3ZsHec3HdzDu2VNKqfqpUJlo3mqnqVojczJW8ILVcjT+xlB1Q+CXWucnQKfDJNLVHjVRtQBkJTnhqhugQU4QwqgPYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bpJKXJZ3; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7376dd56eccso7717522b3a.0;
        Wed, 09 Apr 2025 10:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744218226; x=1744823026; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gduFr9psKq3/rFKzYti1e6w9zW9vBtwhKjWFoDD4Umw=;
        b=bpJKXJZ30/NBIOFlWNH8Y8GDahPkkSP/DgH6LM4dmVMu3KcJ/IU8E4vfm9N4zl+geX
         DcBBu1cAPal831vDcz5id1gKVpYebMugxXt++XrxPNeILMfS4Ho3deeEFkiK1LDr/VGA
         hkgbvo07qVDjlX26+Ba2FWyxW6Hz/y7uJKocgDPdkHSmGXeJ6X4U2eCYPO0QOsjpcUs7
         h1/IyuIHQ8Kfec/SQYC89iW5utKi+SHWRU2xpgNHNlVCKHL+xkrcc6tjCujoGEoaQnIA
         eFZAlo9duKXfFbRu8EGes5iJZYY24czFJMGxeq+ZSZJHrx8DU7P8hqTDB2/RSAstYitb
         O9pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744218226; x=1744823026;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gduFr9psKq3/rFKzYti1e6w9zW9vBtwhKjWFoDD4Umw=;
        b=Srzyn8HzqvJe4jr3KG5MdX7NTX3y0Yifqt+MrVH/NUGmxD+2ug16cKx6Jhy5Pun94e
         0QUrtZ45q1+7TE8uXruLYjD8GOLjokMV9VEi6awawqbK90jkv54ocjI1rBnkd3q1HU5y
         m8HbvFn9ItWQpaBplk0iHIoFPHJSgECoP8/MtSD6KQJAQse9YZtPwdObGm31yoGfNlh6
         r7rpOm+ksdo1NN7++J0TRVAplTS3YXO2wrnnXY1OfQ/L9arFwCqS57DxsLTqSE8VJMxA
         wOSaJT5JkY/zJayJcjIaWgaKK5KfKdTbH1DUe7fkCDHC5Dx/K7a98LKae6B6CagljS7R
         8hzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUb2PJ2PxtmBTLvVpht8A51ASLDwbmLijvl//rSltT21Gb2IGUoQkldnmuGrHyvWEojIJ8WaCH7RFFrcjVL@vger.kernel.org, AJvYcCUn3UplurSLccvoOEu8EqDC7W0UnaXRlVM9ECCpFQXaDHJmSEf/FZIFdl6WzZAper4ZkEVKIsTHnVVG004=@vger.kernel.org, AJvYcCVdY6cWppsx8N4g2GGKPcgIfOh2IQomw3HTidWyKpkLIcs82M3Q3Gb4Ua1Qzl9OIdys0ghimGVvdFxJJu4=@vger.kernel.org, AJvYcCW4CaS/cfwH46QZjvgTtqKfT6crS28Ub5PeGo/4NftX5TeUXJ/i2Fgci/rMpCAV69LW6MZRBWoW@vger.kernel.org, AJvYcCWKe3H8xCi7C3mmTf/NiiCb+72kvCJ3hYcvkWorwOwXSGs5/L0WqD8sAY5mrzWxmM4lwihp91wsEw9/tKTL@vger.kernel.org, AJvYcCWogjZr+Hl7+8ab7Lqwv7CKqv15XHqcPfZuyOyL6U8U+hnbWUzzcBRQmEk5m4eFKWMaP5U=@vger.kernel.org, AJvYcCX+FsSNoIN/3b4Pl+tfmWmTj9wAyBbAhshFu3lXXT/tS8HTBdhqT9Dej6Zzgj+J0ZSR8CnAj8IyEvEDVlA=@vger.kernel.org, AJvYcCXajWdE7nLq3nqapprYGGERwMA95Mw5WS1AisfNhUGOox6eJmJOicnPjORbu0PdcQZVyp5QchOvpkff5uSnvoM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3CRntsMC9RlDN3WnZ8U7h0DjRDNOVPFnBvGATfThCARtzYrDZ
	iVnSV+m2TUPAFqSkdMorTax/zJ6bpYap0DGu72oNpzh3djQqgT9Y
X-Gm-Gg: ASbGncsfqwy7rhK8pf8/cho44iwsaPcrj/IIGNwovOi5pnDRseS8GQzmFs8M3fRkAAq
	oARwOL39zDChHkcsER/oVuw4SPzyZmbXAW4RdU3jPml3+GMET66K8RluNrhAmH52IZWEO/Qz3cx
	eebFWqMBOyE3zKGSVU8i7tdfiUBBKL/U2ZXIeRKJuYIxXG+kOPQU0hUKBLlGMheRWGtqh0EeOOr
	BYRb/Gc8ym4BisiWu5anhvkPj5j1G2neGIuf4CFTrBWZz36abnI5/AFvnUTeH5ZO83DmvhkkDf2
	erkjZa7Yvzh/O3aIC8vUDI85XvNJHgnFyeN4HPpm
X-Google-Smtp-Source: AGHT+IFo/aQceu0toKb44OYHKBYM0JofkQ3whuz+MJluns/fIT/s5YOPql0qpyNQQjmA8CWqrkcceg==
X-Received: by 2002:a05:6a00:2408:b0:730:95a6:3761 with SMTP id d2e1a72fcca58-73bae496ce6mr5244634b3a.3.1744218225458;
        Wed, 09 Apr 2025 10:03:45 -0700 (PDT)
Received: from localhost ([216.228.127.131])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bb1d54d32sm1590079b3a.72.2025.04.09.10.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 10:03:44 -0700 (PDT)
Date: Wed, 9 Apr 2025 13:03:42 -0400
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
	jirislaby@kernel.org, akpm@linux-foundation.org, jdelvare@suse.com,
	linux@roeck-us.net, alexandre.belloni@bootlin.com, pgaj@cadence.com,
	hpa@zytor.com, alistair@popple.id.au, linux@rasmusvillemoes.dk,
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
	jernej.skrabec@gmail.com, kuba@kernel.org,
	linux-kernel@vger.kernel.org, linux-fsi@lists.ozlabs.org,
	dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org,
	linux-media@vger.kernel.org, linux-mtd@lists.infradead.org,
	oss-drivers@corigine.com, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com, linux-serial@vger.kernel.org,
	bpf@vger.kernel.org, jserv@ccns.ncku.edu.tw, Frank.Li@nxp.com,
	linux-hwmon@vger.kernel.org, linux-i3c@lists.infradead.org,
	david.laight.linux@gmail.com, andrew.cooper3@citrix.com,
	Yu-Chun Lin <eleanor15x@gmail.com>
Subject: Re: [PATCH v4 02/13] media: media/test_drivers: Replace open-coded
 parity calculation with parity_odd()
Message-ID: <Z_aobrK3t7zdwZRK@yury>
References: <20250409154356.423512-1-visitorckw@gmail.com>
 <20250409154356.423512-3-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409154356.423512-3-visitorckw@gmail.com>

On Wed, Apr 09, 2025 at 11:43:45PM +0800, Kuan-Wei Chiu wrote:
> Refactor parity calculations to use the standard parity_odd() helper.
> This change eliminates redundant implementations.
> 
> Co-developed-by: Yu-Chun Lin <eleanor15x@gmail.com>
> Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
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

So, if val == 0 than parity_odd(val) is also 0, and this can be
simplified just to:
        return parity(val) ? 0 : 0x80;
Or I miss something?

>  }
>  
>  static void vivid_vbi_gen_set_time_of_day(u8 *packet)
> -- 
> 2.34.1

