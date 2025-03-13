Return-Path: <bpf+bounces-53967-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF08A5FC34
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 17:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21294189557B
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 16:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76E926B2A7;
	Thu, 13 Mar 2025 16:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="TAd1C3YU"
X-Original-To: bpf@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C97326A0E3;
	Thu, 13 Mar 2025 16:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741884007; cv=none; b=Ho5ccutEvWUvgehKhax/lAM1zDIUjz9c3dLl67HOMwbhsXUsxRVle+DnSU4xqdoPd7Qyu+Cpq0q8xz+dP+E7YT655C1rHAKsFbe/gImTP8Xecs8o31E7EPnZB+lE2m92//Uqoi71JBcTb4LfGWSBgzVcXliIbFO/BA0HKSQMhy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741884007; c=relaxed/simple;
	bh=SaFIw7UgTgo6VXgT9++j90cTZypncDuuppnQ2OyQAgc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=XwrVdY4yIgQLzHK/yci8I062cMN8L9HWzu3DZOXND7271pUjNd1O7agzs70OJWiMj/zpgKq58vOo+xFhQrKA6PdkUpUDKOrGGvWcxhYuFVf/nfdg8SSgDCGEAGYx7BCyrAN3hiv0+T5s4dq/SGu1JgAFQuQzRd+bpBo6sRndv9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=TAd1C3YU; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 52DGaDdt3043136
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 13 Mar 2025 09:36:13 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 52DGaDdt3043136
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1741883777;
	bh=SaFIw7UgTgo6VXgT9++j90cTZypncDuuppnQ2OyQAgc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=TAd1C3YUnz1/m04KvWprrt25c59hDoEqP/HObNA2f0Bp4rp+Nb9PEJCNVXCw14Iiu
	 q9Abs6+zDLtcCpZhdLC2JCZczf1qLTKYIQIMECs16cttjTwMK/9bSrYGHwOie5HClz
	 /jcP+3xeKGlwUu0aUrtIeDMZT1ZuV3Y4f2fDZOzvoKjLs6qNj/nOaMpj13f7/0wDQR
	 FTgUDEoLrytWaP9YL4WrPdL93XJwGvTwIwSUgo+vtkpLhxBsY0ibsq0svVoyhEkaAa
	 CHnCGjith9nzaUr6Ath+5dakagWjzMXxHAYsyl+rXq8ZXPjgmXLSW6QTYUQphTnOMM
	 hLTpcEZzd0lKw==
Date: Thu, 13 Mar 2025 09:36:11 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Yury Norov <yury.norov@gmail.com>
CC: Jacob Keller <jacob.e.keller@intel.com>,
        David Laight <david.laight.linux@gmail.com>,
        Jiri Slaby <jirislaby@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Kuan-Wei Chiu <visitorckw@gmail.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, jk@ozlabs.org, joel@jms.id.au, eajames@linux.ibm.com,
        andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
        dmitry.torokhov@gmail.com, mchehab@kernel.org, awalls@md.metrocast.net,
        hverkuil@xs4all.nl, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com, louis.peens@corigine.com, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        parthiban.veerasooran@microchip.com, arend.vanspriel@broadcom.com,
        johannes@sipsolutions.net, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, alistair@popple.id.au,
        linux@rasmusvillemoes.dk, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-fsi@lists.ozlabs.org,
        dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org,
        linux-media@vger.kernel.org, linux-mtd@lists.infradead.org,
        oss-drivers@corigine.com, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
        brcm80211-dev-list.pdl@broadcom.com, linux-serial@vger.kernel.org,
        bpf@vger.kernel.org, jserv@ccns.ncku.edu.tw,
        Yu-Chun Lin <eleanor15x@gmail.com>
Subject: Re: [PATCH v3 01/16] bitops: Change parity8() return type to bool
User-Agent: K-9 Mail for Android
In-Reply-To: <Z9MGxknjluvbX19w@thinkpad>
References: <20250306162541.2633025-1-visitorckw@gmail.com> <20250306162541.2633025-2-visitorckw@gmail.com> <9d4b77da-18c5-4551-ae94-a2b9fe78489a@kernel.org> <Z8ra0s9uRoS35brb@gmail.com> <a4040c78-8765-425e-a44e-c374dfc02a9c@kernel.org> <20250307193643.28065d2d@pumpkin> <cbb26a91-807b-4227-be81-8114e9ea72cb@intel.com> <0F794C6F-32A9-4F34-9516-CEE24EA4BC49@zytor.com> <Z9MGxknjluvbX19w@thinkpad>
Message-ID: <795281B1-9B8A-477F-8012-DECD14CB53E5@zytor.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On March 13, 2025 9:24:38 AM PDT, Yury Norov <yury=2Enorov@gmail=2Ecom> wro=
te:
>On Wed, Mar 12, 2025 at 05:09:16PM -0700, H=2E Peter Anvin wrote:
>> On March 12, 2025 4:56:31 PM PDT, Jacob Keller <jacob=2Ee=2Ekeller@inte=
l=2Ecom> wrote:
>
>[=2E=2E=2E]
>
>> >This is really a question of whether you expect odd or even parity as
>> >the "true" value=2E I think that would depend on context, and we may n=
ot
>> >reach a good consensus=2E
>> >
>> >I do agree that my brain would jump to "true is even, false is odd"=2E
>> >However, I also agree returning the value as 0 for even and 1 for odd
>> >kind of made sense before, and updating this to be a bool and then
>> >requiring to switch all the callers is a bit obnoxious=2E=2E=2E
>>=20
>> Odd =3D 1 =3D true is the only same definition=2E It is a bitwise XOR, =
or sum mod 1=2E
>
>The x86 implementation will be "popcnt(val) & 1", right? So if we
>choose to go with odd =3D=3D false, we'll have to add an extra negation=
=2E
>So because it's a purely conventional thing, let's just pick a simpler
>one?
>
>Compiler's builtin parity() returns 1 for odd=2E
>
>Thanks,
>Yury

The x86 implementation, no, but there will be plenty of others having that=
 exact definition=2E

