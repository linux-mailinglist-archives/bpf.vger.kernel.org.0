Return-Path: <bpf+bounces-53547-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B75A563B3
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 10:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE0FF3B5A4B
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 09:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59AB20C019;
	Fri,  7 Mar 2025 09:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HdtNYCoE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35D91E1E10;
	Fri,  7 Mar 2025 09:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741339342; cv=none; b=CqsHdORhFK+i6UmY4XRMfompmSU7xqjymnTlNJYqX6SHafW4UIqKkLPDxC9DE6elbAj+V7sdPmsuZ2VRmfLM4XFWHAK8xoiyX6zx62h9sfzC53/jgpgN9jxLPTqMy2qwWxkPVyxjLF9ok+xSJ6EfBxNEaUAX9zwKtkgCjZHu/FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741339342; c=relaxed/simple;
	bh=puks5gz+Z0SWJNwNTjIqnOHXEonpz+7vxTX5Qf8VLug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qKUsGqO9KOkjTIvncv2uYFMlF5WViR49imQbejTw01tK6CyOF6dJZFXdS4NdR8jhVs9HJZOTP4FO7H9feoAeNVG+TgsuYw5TDrd969Ek7vpUoG/XuTwb9VeAHd+gJV5ON/TSGz40J6dYywytrX4vdofQy/nQL4hJry/q3cGtkbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HdtNYCoE; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2fee4d9c2efso2929231a91.3;
        Fri, 07 Mar 2025 01:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741339339; x=1741944139; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XztObitingC3692I+pBVpdt55S8NywKGMFDoLFkCI1M=;
        b=HdtNYCoEs1o43u72KKglQ6tmh0SIWEMcIshaywK+7/IAJoELDg+nZ9AGm9kvDFxlS3
         Ll1siGCp5THynSIOu69bZW7ckkG2S3PN1H/Y5xX0CIYInF/M2FIEr9s67B+JgfYfruRw
         jkRjhKUCs4PWAmQsxeAPMzXVpgGSpf+JGy58QNXP3zp5I6sh7K/pKg4b5Lv4SFDK2/Cw
         IUIxezUzCeajk4AwA87XLDF9ZH+dSdOQHizQJr8IV55lPK4xLpP/qNiJZdV8/K9sIMz4
         RJLU5ijmugjD9c94ip5ooM72Qyz7pcaHkc77NUevlDxgjnqVRncCEVifP6eI1X1nGOkj
         3rDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741339339; x=1741944139;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XztObitingC3692I+pBVpdt55S8NywKGMFDoLFkCI1M=;
        b=UTud2MfSOvPnRig6xoN7qMZ3EX0vBw9IkeI7XR+JM+H0jvvJUBN0kHmMtvp/gKelQi
         Zv1xR/r80b4LNHIfDZe0D6IHbnWnMYiRxTqmNryCjQmko3EucjRWo3HucQdpNOrZcF4w
         Qu54kLd+3IbTFv0bVYJiZV4iMc1uxcUKZP4Ci/8fs7VYmJ7DRVB7a1cZR4kDKH7Z9ioL
         P4BCuQJl7vi1socHaCpFLCjKbgxer54p3nNOeRWwMAtD0/uGa8ME+Q424B2I5TLAVo4r
         ke6kyRG32rooEHFS73UTj5ZgEu4pMaI1LQvQhrgh0W0FsU/Zkc5WZtEkil+Dzl1KOqyA
         8Wuw==
X-Forwarded-Encrypted: i=1; AJvYcCUJp/+WXaS2sCJS+GthxvCMie74YOBB9Z1dcY/jWYuLSyzXtbBHAaUDlCulpVHEPE6SkIs3pdh2AY74nNxV@vger.kernel.org, AJvYcCUtR1fXRsiRKZ4uFDIJdYrXzmSO3o9G6s4Z/1X9tXPF2O7CEOjWC7HcRtAiIhfOScHZ3Sua0e04j4JEjsjQ63U=@vger.kernel.org, AJvYcCVdu91V3aFh6QNaQOhW7cUzj6Nq+RsA3OVH6RMFGiEJHnk+KZYkdtglqEVuj64kuOE5rdkfVah9@vger.kernel.org, AJvYcCXSaa6FOb2mj/9HhnGRLHFADHBhqAl81qTfz9dOdeKFzEFwA7u0umjrJ7YxP0z+kBm+IvqpozgkfEV8SxBG@vger.kernel.org, AJvYcCXXqQy/yG1JzBB6S2bBvYejWq6pGj57raKkxWW4xhDZ584gWBwMDeFqNwkXbqGLcwMJ83HmHQAE/PcZLG0=@vger.kernel.org, AJvYcCXaS+fSFMwBDKhqaBbZsv/Pz20x4NfVqaM4RJim4lO88UmsRHutS9Q2Y+VRnWjUIH/WRCI=@vger.kernel.org, AJvYcCXlseOC/5/OPOH19PCwGM0L3P8dcCV7XQBEgN9nsdS6SVtruRv8YUNek9hXrJhY9YHPa81DYYcKyjbYoq4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT7kcXu8Ivn0NbKq6o0ZnqEQx7PQnJvU9SOZbFU7FPEJgkA5sx
	+3gsAVkIzKAPBNHbsSVbcalgQiUBg/Z0wbpCCoqXzl+WqU/kdPvq
X-Gm-Gg: ASbGncs8GvBQKvntRHW6ezDn2j3x+dACIjv47a+2lyv1Mfii/LUCHcZr+TTPPSalYNn
	sciwoFOdoEZK7RI89JPynnGZrzDpPJNztHUsi61SxbR6jcCpKZZdOXi5asqp0CjzJmbA/jFDFxx
	exIbilYcqKTts3098POy26YHJy1IVnSBie3zb6/wanjBM/saUG8d0CGTOIFAxaIUQaPILiy2J2S
	WsSIGRalpvkcODZxJsRbhThemcBQGpfJ1e9aaB3f/WhVPd5AAtFuQ0t6P+JW8dw3UFp3q/3nHI8
	zqqzGLXvvugHXrqbHbL4WFEvbqXqDUvB4A62d8t8DQmq8IvmGbjhwy2qOlfwnAkeRmaMNS/s
X-Google-Smtp-Source: AGHT+IGO3Fg5mznURfAXFZCPAiOd6NJZ8MzxOEXeMR65d6OVc42NCiVYA5M/yoTVlsiOwEwCHpbcoQ==
X-Received: by 2002:a17:90b:3911:b0:2fa:1a23:c01d with SMTP id 98e67ed59e1d1-2ff7ce8b5ffmr4029616a91.21.1741339339019;
        Fri, 07 Mar 2025 01:22:19 -0800 (PST)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff693e7fb5sm2876725a91.37.2025.03.07.01.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 01:22:18 -0800 (PST)
Date: Fri, 7 Mar 2025 17:22:08 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Jiri Slaby <jirislaby@kernel.org>
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
	yury.norov@gmail.com, akpm@linux-foundation.org, hpa@zytor.com,
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
	Yu-Chun Lin <eleanor15x@gmail.com>
Subject: Re: [PATCH v3 00/16] Introduce and use generic parity16/32/64 helper
Message-ID: <Z8q6wPWXImCeGI8P@visitorckw-System-Product-Name>
References: <20250306162541.2633025-1-visitorckw@gmail.com>
 <3dfc81eb-caa1-42fe-8fd6-61101de0ef13@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3dfc81eb-caa1-42fe-8fd6-61101de0ef13@kernel.org>

Hi Jiri,

On Fri, Mar 07, 2025 at 07:57:48AM +0100, Jiri Slaby wrote:
> On 06. 03. 25, 17:25, Kuan-Wei Chiu wrote:
> > Several parts of the kernel contain redundant implementations of parity
> > calculations for 16/32/64-bit values. Introduces generic
> > parity16/32/64() helpers in bitops.h, providing a standardized
> > and optimized implementation.
> > 
> > Subsequent patches refactor various kernel components to replace
> > open-coded parity calculations with the new helpers, reducing code
> > duplication and improving maintainability.
> > 
> > Co-developed-by: Yu-Chun Lin <eleanor15x@gmail.com>
> > Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
> > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > ---
> > In v3, I use parityXX() instead of the parity() macro since the
> > parity() macro may generate suboptimal code and requires special hacks
> > to make GCC happy. If anyone still prefers a single parity() macro,
> > please let me know.
> 
> What is suboptimal and where exactly it matters? Have you actually measured
> it?
> 
In the previous thread, David and Yury had different opinions regarding
the implementation details of the parity() macro. I am trying to find a
solution that satisfies most people while keeping it as simple as
possible.

I cannot point to any specific users who are particularly concerned
about efficiency, so personally, I am not really concerned about the
generated code either. However, I am not a fan of the #if gcc #else
approach, and Yury also mentioned that he does not like the >> 16 >> 16
hack. At the same time, David pointed out that GCC might generate
double-register math. Given these concerns, I leaned toward reverting
to the parityXX() approach.

If you still prefer using the parity() macro, we can revisit and
discuss its implementation details further.

> > Additionally, I changed parityXX() << y users to !!parityXX() << y
> > because, unlike C++, C does not guarantee that true casts to int as 1.
> 
> How comes? ANSI C99 exactly states:
> ===
> true
> which expands to the integer constant 1,
> ===
> 
I gave a more detailed response in my reply to Peter. If we can confirm
that casting bool to int will only result in 1 or 0, I will remove the
!! hack in the next version.

Regards,
Kuan-Wei


