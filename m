Return-Path: <bpf+bounces-53507-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17AA5A557B5
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 21:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 478BB1887B32
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 20:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A3C1A2C3A;
	Thu,  6 Mar 2025 20:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yo8GMXYQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D521A23BD;
	Thu,  6 Mar 2025 20:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741293950; cv=none; b=gBpufuVS7owY7AJpKyHGEiChOHs5GjxdhQ/GvxD+OB/y0gmFRRgDkrzXfPX/VcL6RXzeipxQh3wJ8h8LzePDDBy23PhxeKEFK7UCdurfP9k3WEun2plUEyQw53ZO8NIrG1Xtdm8sURa0A7mCMifAI1vkCI+2N476C9GofsHisZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741293950; c=relaxed/simple;
	bh=YRiEklZgyKif9YQuFPeDNCuPRKOpVl4Sp4NBuCatdYk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EqdfaPhY605s4c6GqFcl/zo0MjHxNNOqB426UKNjTnw9V2K9ivq5XtcBYGh7xcW5b53IoBsy7jESaXPkT9am8zzlxDZi+32fsNKMqt8MpVrrpuRf6y1jQGxvO8kqLTAn/WxeBm8NR3n3ybrVonMpMz+B3mue2lvNJKMlffuRzB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yo8GMXYQ; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-390d98ae34dso876605f8f.3;
        Thu, 06 Mar 2025 12:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741293947; x=1741898747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U/2AW/XQ+C1Dkr/bifBKVXkd3UKdww00iQvvrQ69JSo=;
        b=Yo8GMXYQY66Qke/AigSX3nfeldGlI4YA8pihoQyOws62kK/g2lLRepvjNAgN+XL6cR
         ZBqg5LkSaU3JXTpUBUFJheGjOmvViwCbwV2t/v6AxJegDBfljJCkazn2KioQou8rgkJ1
         VqMHqOwujeGuYyx6dYQubWKWZVgG150yAvNIRLSf5MfxerDbgCLcnu3aoEjy+be4FppB
         Xie6o5bIcKevKXUWUmPgHbrrvDche+/zHf3uh1oXVEUxPK9BuNgCttNmi3QWQLZDIj0E
         mrABgL4PTwo5Hy25mk4gYqaa94/c4x61pnMQSy4fwItFJdFhJHNzoYy5euy+blTnPiAA
         3wmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741293947; x=1741898747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U/2AW/XQ+C1Dkr/bifBKVXkd3UKdww00iQvvrQ69JSo=;
        b=dGk4qQnr5wTn0Qt6k6QAu/0Eq5sBYTc3fiB1xeSxjUtuXuScwx1F9Ls7+pQeMQaL5h
         cbgaWMd2Ue89OBod/8v50SpZmKwQDcUkd6ID1wZnoUz824WONUe5K9BZP05/Kvg9Hdk/
         Vja/7tw0VTkPXBY/pudXc1edRllvOQKRLThBG3G1UzTZLYiyq6W8WXAWVd+K+EOLVutR
         pa/V/3TLkCNdjbg6BWL23g4SLT5hSP2FAOZnfy8sMpAOxeWIzmG3e42AuL+GsJxmvJ0P
         GZ9qXJJ5GZZUJeaG9Bjm0tT839FvCJXeO0lPWNO3ZASr84Wfnn8vSwEaRgExibSGzvkb
         Ua5A==
X-Forwarded-Encrypted: i=1; AJvYcCUAA6Y2WGbWYU+CfGFBVpNZp27DAMP5AXS6Yi603QwE/qdsMqn6klEBZ8Q3vyPMR7RwjCILOT7e@vger.kernel.org, AJvYcCVLpF6g/9OucMzsFrmUNI6Zep3ugGq6WrIlzXGlSoqd9u8es1OlPFuMyL5eSWTC4Pcerz5xoJYrIS4Mpvo=@vger.kernel.org, AJvYcCVb/K+WKCPbEriErmdbYMpqC4JhbsmKk1Ko+aDksTb+dFHszy1l/EtwwZlsYqkPOy/R4+liiXoneZm1glFv@vger.kernel.org, AJvYcCWMUC6Xz/HI0Fs5x2itxY03lT3gnHWLPu/zdqb3KOZ30Nd1Qv7D+ET1s1qJYCgBMU3WCA1gohZwYLbWyEoA@vger.kernel.org, AJvYcCWRBwtOHCvnkEG52PyJyybFHECALqeRSUKIkKhePFHMjJPfFB50341yxdMdGhyihwbALtkfNxbjLfItXx/hzuE=@vger.kernel.org, AJvYcCXHqXLyitFhoJGpm+nGHxoOKXslNU6p16OgAtpgod9J2qpeZoygAIRmRWaTRt1tJTSAgD0=@vger.kernel.org, AJvYcCXhZ6RBFFDE6j/t5bUBHV6e7fdLCXeQB/LGXJxdN/BQpBjSx2tu7cUKBbz5xpbztTGjd/pN141sOomb9RQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv1tkDo+b+EAxhTsNHEFESwkWTPtgZEXGF+ZbhaSzuSC0M5WyU
	t/kPBAG/wX+QebzoUo5aBWmHJ06RyMmbqgKXipm51sNI/Ar6xF5x
X-Gm-Gg: ASbGncsQoFz0KdJ5miS5ff6gASWPNKOWRLiMzEQXLHirJgIwJzw5cGb1NcuxBwr7w9X
	gD3ERHVQsRamYkJakm9mbiynZN0cCVG5AxOAnCBq/fG0B+geRsf/xsVnlkAf1xwhM5G3MEznnlB
	NPfOVGK7kjapW6Qk+1cPV0U26V4Xg72ZdGAS/51PTBDb8mBskqARsIrhWcA19M9mUUHjTOoavfK
	pwVkWr92bbSizQ6c441xIvsG4wqxG/qgu6xPiRflAeb2dphewEjNdpcoQNwLqku6v/g+JUM+zx6
	iV1F51T7UQRoVK/+JnPo1ItDxIxwCjvT1ycXYpfK5Cn3jhuSM6JEmxuYHH7X9lkLNmC1ROQ4Tsd
	moGlN3Rk=
X-Google-Smtp-Source: AGHT+IGypB/6b6ARKmDBu94pyV9a8VQg2efcRX5KU7nOp2iuQaxkdpIq9rBXtaXWDKzDk6KRW6vJqA==
X-Received: by 2002:a05:6000:4112:b0:391:b87:37ad with SMTP id ffacd0b85a97d-39132dad239mr349795f8f.42.1741293946634;
        Thu, 06 Mar 2025 12:45:46 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c01de21sm3140996f8f.59.2025.03.06.12.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 12:45:46 -0800 (PST)
Date: Thu, 6 Mar 2025 20:45:44 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, jk@ozlabs.org, joel@jms.id.au,
 eajames@linux.ibm.com, andrzej.hajda@intel.com, neil.armstrong@linaro.org,
 rfoss@kernel.org, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 dmitry.torokhov@gmail.com, mchehab@kernel.org, awalls@md.metrocast.net,
 hverkuil@xs4all.nl, miquel.raynal@bootlin.com, richard@nod.at,
 vigneshr@ti.com, louis.peens@corigine.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 parthiban.veerasooran@microchip.com, arend.vanspriel@broadcom.com,
 johannes@sipsolutions.net, gregkh@linuxfoundation.org,
 jirislaby@kernel.org, yury.norov@gmail.com, akpm@linux-foundation.org,
 hpa@zytor.com, alistair@popple.id.au, linux@rasmusvillemoes.dk,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
 linux-fsi@lists.ozlabs.org, dri-devel@lists.freedesktop.org,
 linux-input@vger.kernel.org, linux-media@vger.kernel.org,
 linux-mtd@lists.infradead.org, oss-drivers@corigine.com,
 netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com,
 linux-serial@vger.kernel.org, bpf@vger.kernel.org, jserv@ccns.ncku.edu.tw,
 Yu-Chun Lin <eleanor15x@gmail.com>
Subject: Re: [PATCH v3 01/16] bitops: Change parity8() return type to bool
Message-ID: <20250306204544.35086b52@pumpkin>
In-Reply-To: <20250306162541.2633025-2-visitorckw@gmail.com>
References: <20250306162541.2633025-1-visitorckw@gmail.com>
	<20250306162541.2633025-2-visitorckw@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  7 Mar 2025 00:25:26 +0800
Kuan-Wei Chiu <visitorckw@gmail.com> wrote:

> Change return type to bool for better clarity. Update the kernel doc
> comment accordingly, including fixing "@value" to "@val" and adjusting
> examples. Also mark the function with __attribute_const__ to allow
> potential compiler optimizations.

If the result type is 'bool' you should just check it.
Not compare against true/false.

	David

> 
> Co-developed-by: Yu-Chun Lin <eleanor15x@gmail.com>
> Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---
>  include/linux/bitops.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/bitops.h b/include/linux/bitops.h
> index c1cb53cf2f0f..44e5765b8bec 100644
> --- a/include/linux/bitops.h
> +++ b/include/linux/bitops.h
> @@ -231,26 +231,26 @@ static inline int get_count_order_long(unsigned long l)
>  
>  /**
>   * parity8 - get the parity of an u8 value
> - * @value: the value to be examined
> + * @val: the value to be examined
>   *
>   * Determine the parity of the u8 argument.
>   *
>   * Returns:
> - * 0 for even parity, 1 for odd parity
> + * false for even parity, true for odd parity
>   *
>   * Note: This function informs you about the current parity. Example to bail
>   * out when parity is odd:
>   *
> - *	if (parity8(val) == 1)
> + *	if (parity8(val) == true)
>   *		return -EBADMSG;
>   *
>   * If you need to calculate a parity bit, you need to draw the conclusion from
>   * this result yourself. Example to enforce odd parity, parity bit is bit 7:
>   *
> - *	if (parity8(val) == 0)
> + *	if (parity8(val) == false)
>   *		val ^= BIT(7);
>   */
> -static inline int parity8(u8 val)
> +static inline __attribute_const__ bool parity8(u8 val)
>  {
>  	/*
>  	 * One explanation of this algorithm:


