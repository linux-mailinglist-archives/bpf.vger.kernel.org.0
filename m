Return-Path: <bpf+bounces-65338-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA64EB20A0F
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 15:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95B8B4246D5
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 13:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155F82DC33B;
	Mon, 11 Aug 2025 13:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="r4tJjMQT"
X-Original-To: bpf@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E664419342F;
	Mon, 11 Aug 2025 13:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754918736; cv=none; b=sfqTPuyy9wOTzO1I4O78mwJYIKR1GRHfT/1j5K9m0gdYZu106apyyxiX9lsr9W/yxPY9TsljYD5WngKOR7WZj5B2FT28FI+5N6bRpPpKNKHkq+R6SSaG1dRaj0QI0TRaGU/7xnOpuVhNfC8p3tHYljv6BC43kEw1sjXYww0v+wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754918736; c=relaxed/simple;
	bh=GDVBiZYwIFUyxpBUZYd0DLfIKs9PQ9AJ0SA3VYv13dQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=TaA9xqqts/QHExbM3Is20wbtX9Yiuc36Vfbs06+hVtCmsicFtJHOLiUHaO8PVfk/JHnjIZSUSBcMaLgp0lsNliylZ0KP6UFwCuDegJwNgDb4SSWXtRDaDa8AmERwv3IWOrkmrMDpmPiuJSfDCMenRC7QGmCB66k5x28OI13B+YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=r4tJjMQT; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1754918716; x=1755523516; i=markus.elfring@web.de;
	bh=GDVBiZYwIFUyxpBUZYd0DLfIKs9PQ9AJ0SA3VYv13dQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=r4tJjMQTI8Utq8X6gal76bXQ/AjDoz4hEsbMOtqgaeyBW+Yz55NF+30Whv/dvNq0
	 +cXoQJNs1nhJmLT6N9tEuJ1Gsbj7dZwy6FdxtOkABru3eo4VurQ+N8vCHzsiybRq/
	 laoneCKxc2ulzp/QlorAgGyI8AbH+CzySa70sjHsD1k+/3EDmHNtMt5adWWtyNBDo
	 5T8MAJJcqkkuq4zchh0+yMEQvbudMJfTg9yi2KMZrN3Wq2Zr6n5i9EFf3gwM5/n4y
	 WW15yhBV+Kjra3mqLan8lj4S8xhj6DT6FKgEbQvHylQPnlLdN76YfwksR7eqWFBXF
	 4uDhZmXpQgR4aR1Ftg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.213]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N4621-1uc8y52sL3-00wmJg; Mon, 11
 Aug 2025 15:25:16 +0200
Message-ID: <09db6175-070f-46c9-adb1-05e0355d7183@web.de>
Date: Mon, 11 Aug 2025 15:25:14 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Qianfeng Rong <rongqianfeng@vivo.com>, bpf@vger.kernel.org,
 Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Song Liu <song@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Yonghong Song <yonghong.song@linux.dev>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20250811123949.552885-1-rongqianfeng@vivo.com>
Subject: Re: [PATCH] bpf: replace kvfree with kfree for kzalloc memory
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250811123949.552885-1-rongqianfeng@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xOp/fIIDAkWrt117YR82TdPVAVyH5qq+vPyRgJ7RdeCxjCwkd23
 ulM6MI4pEViXTcV5TPIy7ZEiIGtv7OnDAsmYy2xiaukq1Fgo4z8o10iOAevn9AU+5WX3NY5
 l8ESAVbyNGTnzcbMOQ0qUvruQW4PyDIIiAzmYeYtYftxCHPrZ5MoST0sMfP3uCVehYy1g3d
 3yYIzxCUgxeX5UG6lLAyQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tGWB1ekECLU=;ZiktIkbGy3ITXGeo3skTpcsX+R4
 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

=E2=80=A6
> Replace kvfree() with kfree() to avoid unnecessary is_vmalloc_addr()
> check in kvfree().

Under which circumstances would you become interested to apply the attribu=
te =E2=80=9C__free=E2=80=9D
(also in the affected if branch)?
https://elixir.bootlin.com/linux/v6.16/source/include/linux/slab.h#L476

Regards,
Markus

