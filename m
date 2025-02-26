Return-Path: <bpf+bounces-52601-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F15DAA45250
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 02:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 829EC17632C
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 01:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E38619DF40;
	Wed, 26 Feb 2025 01:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="DSr0p5U6"
X-Original-To: bpf@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADA8199EBB;
	Wed, 26 Feb 2025 01:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740533965; cv=none; b=dOS7CTBjYzn+yCHcmpCBbAEWgHwdDiut8P9lzBSIdmKIRhE3Jcw1vBhOyyWdThHRE3Di2qQBT2ogsddVZN8E1OLjo7QxV4L14cw6WjK4VEOBKhhh+rhmaA6/NmeJ+vb+UvrEjlKEJqEcml8/RIfTViOEWDb9KolQJmQVYnvzsbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740533965; c=relaxed/simple;
	bh=T0pKCclIvHKyDRUHCJs7P4mfoEs4SIcJGp6SSmwXCZc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=l8J0kNGUdlNTI1ROnga+P6ZKjzmHhtm58VmT54d4SFKrvZU49bRDqNtemU45s5igZsN4W+2YCm/fWU+ZQxWPJkU6w+BBhKfe2BTTNqpbEch4mrZ3A8HI2hHEkvprDT9dTgg/v+rb7mZXyzYdNsH8WteQCCz82zAavl5g4EZDm0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=DSr0p5U6; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 51Q1ZSdu1502812
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 25 Feb 2025 17:35:29 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 51Q1ZSdu1502812
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1740533740;
	bh=T0pKCclIvHKyDRUHCJs7P4mfoEs4SIcJGp6SSmwXCZc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=DSr0p5U6PuFacB2sJlJBShpK+caegDMEmn8OYplTp/ukKNtEFfrkn97ga+OT2dXpz
	 K/n5OJZ9p7wF026A4N5Ms8I4Ha7wXxIE31o+eevCv66LWleUk5egaKa/T1wzR+OiP5
	 pBftNRMbRUke7ubIKWI6Trw88YIoPJ//UlgWSqbBalJrMQ6XLeWdsBqjIBFJ2BqBTU
	 NxN3soIqU4psmCdpeI68cUVCZ/T8YSni/GX+FUYtyTt8DqQzRz5FBJx8rRSkQsq+0n
	 LFOV9xO0DwzRQLOdgcR413cBdNqea/GHzmtBr2NpUvBJ8KgVfK7MCUU4fZDlrEdXny
	 PWA/+ls6AlysA==
Date: Tue, 25 Feb 2025 17:35:26 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Andrew Cooper <andrew.cooper3@citrix.com>
CC: Laurent.pinchart@ideasonboard.com, airlied@gmail.com,
        akpm@linux-foundation.org, alistair@popple.id.au,
        andrew+netdev@lunn.ch, andrzej.hajda@intel.com,
        arend.vanspriel@broadcom.com, awalls@md.metrocast.net, bp@alien8.de,
        bpf@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com,
        brcm80211@lists.linux.dev, dave.hansen@linux.intel.com,
        davem@davemloft.net, david.laight.linux@gmail.com,
        dmitry.torokhov@gmail.com, dri-devel@lists.freedesktop.org,
        eajames@linux.ibm.com, edumazet@google.com, eleanor15x@gmail.com,
        gregkh@linuxfoundation.org, hverkuil@xs4all.nl,
        jernej.skrabec@gmail.com, jirislaby@kernel.org, jk@ozlabs.org,
        joel@jms.id.au, johannes@sipsolutions.net, jonas@kwiboo.se,
        jserv@ccns.ncku.edu.tw, kuba@kernel.org, linux-fsi@lists.ozlabs.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-serial@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux@rasmusvillemoes.dk, louis.peens@corigine.com,
        maarten.lankhorst@linux.intel.com, mchehab@kernel.org,
        mingo@redhat.com, miquel.raynal@bootlin.com, mripard@kernel.org,
        neil.armstrong@linaro.org, netdev@vger.kernel.org,
        oss-drivers@corigine.com, pabeni@redhat.com,
        parthiban.veerasooran@microchip.com, rfoss@kernel.org, richard@nod.at,
        simona@ffwll.ch, tglx@linutronix.de, tzimmermann@suse.de,
        vigneshr@ti.com, visitorckw@gmail.com, x86@kernel.org,
        yury.norov@gmail.com
Subject: Re: [PATCH 02/17] bitops: Add generic parity calculation for u64
User-Agent: K-9 Mail for Android
In-Reply-To: <8052b316-9f72-42c7-9e11-e23e690d80c4@citrix.com>
References: <3BC57C78-1DFF-4B83-85AA-A908DBF2B958@zytor.com> <8052b316-9f72-42c7-9e11-e23e690d80c4@citrix.com>
Message-ID: <4259A207-7B5F-4D25-A8AE-144D24554201@zytor.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On February 25, 2025 1:43:27 PM PST, Andrew Cooper <andrew=2Ecooper3@citrix=
=2Ecom> wrote:
>> Incidentally, in all of this, didn't anyone notice __builtin_parity()?
>
>Yes=2E=C2=A0 It it has done sane for a decade on x86, yet does things suc=
h as
>emitting a library call on other architectures=2E
>
>https://godbolt=2Eorg/z/6qG3noebq
>
>~Andrew

And not even a smart one at that=2E

