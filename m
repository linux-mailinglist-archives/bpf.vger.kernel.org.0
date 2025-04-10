Return-Path: <bpf+bounces-55629-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6EB2A83819
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 07:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02BB444636B
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 05:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F751FBCAA;
	Thu, 10 Apr 2025 05:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Nhyg+23K"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681F11EB190
	for <bpf@vger.kernel.org>; Thu, 10 Apr 2025 05:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744261760; cv=none; b=Iiy1tNQL8CB8y2MNMfGoOB+UZm09TVs7SlKiGcdnFKHpzNc6pnpA91Vy2otnd4Pd/6mBx4P8ic3WLWdnyGw7UDinx0cEeoEkh68H/kQDkDmwpAWahW+vfL5ZchN3LDOFsO70WBvPhYrOose0sjcZ2LI4CyIrnrR+770XujculOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744261760; c=relaxed/simple;
	bh=G16oVcschOk1bCBWwdD3ZsJUcsex2zjDzFXRZC7O9eo=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=fhUxBR27rahQz77ZGzQrdrcryOUdkUZHpgwot8x8RFnBj7SBRTf//ysydEeZne69NB65Xo+X2qf4zX0jPBa5YaC3KIsSaMEmMyLFtPw1zymQgMxW888A2YusBrWTt4GYH3zWl0iFrrQX7XG1bl3IedmVVrb+ei/W90NGcT/TE/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Nhyg+23K; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2d0920c6f96so232365fac.1
        for <bpf@vger.kernel.org>; Wed, 09 Apr 2025 22:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1744261757; x=1744866557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G16oVcschOk1bCBWwdD3ZsJUcsex2zjDzFXRZC7O9eo=;
        b=Nhyg+23KIvdj2ds/dNoqaEQBtAsf+l8ko22/0+4jtvRN2tw9Xc7oxEI8f8BdnYDTiE
         wy/7saWqUY6bU6A6WaAv1yLARvwdxE1XGz4cX1LXU3HkjRenBGaTqV/cwhECJall2SEs
         b3T7jLsPsW0YtLGXBqKsEw1OfECpoBHejRrc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744261757; x=1744866557;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G16oVcschOk1bCBWwdD3ZsJUcsex2zjDzFXRZC7O9eo=;
        b=JcAHOTUc7864QBeEpm2mZ+SCOyblLLxJ6kXSu0OsVbLJkB8ua2Dm2k9IYC2c3hi5CW
         PhCW2yOWicHyHVs6mGfWgznSuHpvmfLfa2LICx/heDi1GYzV2HMntx4Dom2MtpsCuBnH
         5Vu5jOcsMldVzGCt//IyI+HQpGS77VJzUVWF1aj5+cYiCRZc5G1x7isqv/Q3G+SQnvMt
         LT2z4qKSb/cikJTMPFQ4Z7ZKGRHQyqcySHjzmlF/fDfbMpCQsOv1Q+ZqodpSN4emCTP9
         fiXElhDXH3S41XWZduQ7f4eYEWcTfSq0fdCpx0KR3Q93DTIvImDSd4JXA3MtrgB1v6eX
         tObQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGRfOvL4I0duHMnUt3xVxeqKVKdAmIPoAurrVnUckdoV3fz7pc+4SyB4l1fDCDtPVvljA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpEip5m+3iPbQr391yhgs5fCEkLIa/eydkfrsP8CKUyaGn0qXd
	HxGtSooJipXZT8r4MYX/+JsnLAWs4+i4Vg1bCIGZBSTq6/gPzVqaDORDM1Gbyw==
X-Gm-Gg: ASbGncsiZ491mNpCPS3FOsx1qPPLIRj5z86FVLg2OaNPL+udqRBpF1q5BaCR4yReYJQ
	UQyQPE+r2ziuK/9cHRHQJ2RryoKy6caxMNeylhRHGqy8FwAmjcNeAwJog0epinmRDz4AGAkuWSH
	bDDsSf+iEeENdWiBBuCFKkUKyTAN+7WFb+22w9s+Hrm2KT8wm5SGTU1UD2cWSLtdUnJ/UdH4hOM
	RvYAVvvF+zvd0d+JJQyZp51Uhv8F5eGW5hR9ZZS5PogWMSk7uNCpW5QBWTjL9fN1mxE87r0y+4O
	rFhPojpFvEPbGkE07SLb2WdVwrQU7szd8c/TAoxwDN5bv5tfqAj5GE8d67lIS59BoQwCBWb++wo
	9tzE=
X-Google-Smtp-Source: AGHT+IHf2dIBsgMwlqUxzHqfg0izmCh/XeIh4+y37IHWa4xRZwCt6+2s0H2VCnvp55v7eCTsGxhXjQ==
X-Received: by 2002:a05:6871:3320:b0:27b:61df:2160 with SMTP id 586e51a60fabf-2d0b383616dmr840067fac.31.1744261757422;
        Wed, 09 Apr 2025 22:09:17 -0700 (PDT)
Received: from [192.168.178.39] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2d096cd3764sm534917fac.31.2025.04.09.22.09.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 22:09:16 -0700 (PDT)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Johannes Berg <johannes@sipsolutions.net>, "Kuan-Wei Chiu" <visitorckw@gmail.com>, <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>, <jk@ozlabs.org>, <joel@jms.id.au>, <eajames@linux.ibm.com>, <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>, <rfoss@kernel.org>, <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>, <dmitry.torokhov@gmail.com>, <mchehab@kernel.org>, <awalls@md.metrocast.net>, <hverkuil@xs4all.nl>, <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>, <louis.peens@corigine.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>, <parthiban.veerasooran@microchip.com>, <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>, <yury.norov@gmail.com>, <akpm@linux-foundation.org>, <jdelvare@suse.com>, <linux@roeck-us.net>, <alexandre.belloni@bootlin.com>, <pgaj@cadence.com>
CC: <hpa@zytor.com>, <alistair@popple.id.au>, <linux@rasmusvillemoes.dk>, <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>, <jernej.skrabec@gmail.com>, <kuba@kernel.org>, <linux-kernel@vger.kernel.org>, <linux-fsi@lists.ozlabs.org>, <dri-devel@lists.freedesktop.org>, <linux-input@vger.kernel.org>, <linux-media@vger.kernel.org>, <linux-mtd@lists.infradead.org>, <oss-drivers@corigine.com>, <netdev@vger.kernel.org>, <linux-wireless@vger.kernel.org>, <brcm80211@lists.linux.dev>, <brcm80211-dev-list.pdl@broadcom.com>, <linux-serial@vger.kernel.org>, <bpf@vger.kernel.org>, <jserv@ccns.ncku.edu.tw>, <Frank.Li@nxp.com>, <linux-hwmon@vger.kernel.org>, <linux-i3c@lists.infradead.org>, <david.laight.linux@gmail.com>, <andrew.cooper3@citrix.com>, "Yu-Chun Lin" <eleanor15x@gmail.com>
Date: Thu, 10 Apr 2025 07:08:58 +0200
Message-ID: <1961e19ee10.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <740c7de894d39249665c6333aa3175762cfb13c6.camel@sipsolutions.net>
References: <20250409154356.423512-1-visitorckw@gmail.com>
 <20250409154356.423512-4-visitorckw@gmail.com>
 <25b7888d-f704-493b-a2d7-c5e8fff9cfb4@broadcom.com>
 <740c7de894d39249665c6333aa3175762cfb13c6.camel@sipsolutions.net>
User-Agent: AquaMail/1.54.1 (build: 105401536)
Subject: Re: [PATCH v4 03/13] media: pci: cx18-av-vbi: Replace open-coded parity calculation with parity_odd()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On April 10, 2025 12:06:52 AM Johannes Berg <johannes@sipsolutions.net> wrote:

> On Wed, 2025-04-09 at 20:43 +0200, Arend van Spriel wrote:
>>
>> This is orthogonal to the change to parity_odd() though. More specific
>> to the new parity_odd() you can now do following as parity_odd()
>> argument is u64:
>>
>> err = !parity_odd(*(u16 *)p);
>
> Can it though? Need to be careful with alignment with that, I'd think.

My bad. You are absolutely right.

Gr. AvS
>



