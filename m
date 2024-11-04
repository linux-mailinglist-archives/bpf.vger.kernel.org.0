Return-Path: <bpf+bounces-43893-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 284D89BB82E
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 15:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83212B20C3F
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 14:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5661B6CEA;
	Mon,  4 Nov 2024 14:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ptr1337.dev header.i=@ptr1337.dev header.b="JTqRjBC1"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ptr1337.dev (mail.ptr1337.dev [202.61.224.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48731369B6;
	Mon,  4 Nov 2024 14:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.224.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730731457; cv=none; b=m6MmKpCfjFIk9oOlqzYbD3PmWgNSeyeAtFjILrINgE61fbpGlM7zGWLvTA2xk/EoS9CPWsOnnr8V+TltsXBGQ4V+ZWpcwSTy0x39IiavXyisf3YfgFCN7YE/nlJfo/s8EpOUe/1xBH/8NFhA1mII1N+AdX/QK6NQahpfsbOq1PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730731457; c=relaxed/simple;
	bh=1dB37Cc49m8JjFGCFvSOY5+g5lvy/roy/zoGscLJP3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zt4HWNK4fM9PuC41KI6RAfUE1edlFpzj/MgXRvvZOr+QRhqHelKyF20kAAHHnCO9nv3q1ctKmYqfjnfOk0NmypK+BpCyjBYVL3H5ffgsZWTUtBCzw1k+BLUOTeXnPtCBNemmnsdc3ihlufAbgLxFCDvt6ryDwX2q9ptx2ZmBcwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ptr1337.dev; spf=pass smtp.mailfrom=ptr1337.dev; dkim=pass (2048-bit key) header.d=ptr1337.dev header.i=@ptr1337.dev header.b=JTqRjBC1; arc=none smtp.client-ip=202.61.224.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ptr1337.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ptr1337.dev
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7429F2805A2;
	Mon,  4 Nov 2024 15:44:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ptr1337.dev; s=dkim;
	t=1730731447; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references:autocrypt;
	bh=2lEoLjVmg2x1tyqnCSNq6wpXarqIH33FEICWMKbfM3E=;
	b=JTqRjBC16vhOyZkQxUA6j6P67qF3d29SAcp8bISeSSnIl1wGbzEoVqGHJlxnYYxl4ItfV6
	VKhYd3chIFsJQDUmj/5r3H98j668GR7LJILcBhxnFGs7Ag3T9BTU2CMSW5qRDi2BFdWWw2
	hverlXdzUyqCAsKalgcES+x0rhDbZ6wxHa5GYUpwEusePhYJYnB4oj43kDUAuWBtagK9Y/
	WunxAQNZ4y4Hv8uw9GtYJoaZ8lyC+dyJRUCWf2sMgkWqBFlIAr6eD9sripXpYDwlNOlmJ/
	H7O3v/6GnlxLuaWtRF0Mjbl08Yu/heoTtdPsw4gvwSZMCTkDjvyQBXcjA/Bl1A==
Message-ID: <b5c2bf57-c051-40e3-a4a6-ccd38b728752@ptr1337.dev>
Date: Mon, 4 Nov 2024 15:44:04 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kbuild: add resolve_btfids to pacman PKGBUILD
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: jose.fernandez@linux.dev, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?=
 <linux@weissschuh.net>, Christian Heusel <christian@heusel.eu>,
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
References: <20241102120533.1592277-1-admin@ptr1337.dev>
 <CAK7LNAQ=sCsTXB_O58W=AH=k8Vqzoi+hh6-BKhEjZYh-+xCvBQ@mail.gmail.com>
Content-Language: en-US
From: Peter Jung <admin@ptr1337.dev>
Autocrypt: addr=admin@ptr1337.dev; keydata=
 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
 gOKqiuxfQT4ByeLKUXhQY5ciKpjPTg==
In-Reply-To: <CAK7LNAQ=sCsTXB_O58W=AH=k8Vqzoi+hh6-BKhEjZYh-+xCvBQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3


On 03.11.24 10:47, Masahiro Yamada wrote:
> On Sat, Nov 2, 2024 at 9:06 PM Peter Jung<admin@ptr1337.dev> wrote:
>> If the config is using DEBUG_INFO_BTF, it is required to,
>> package resolve_btfids with.
>> Compiling dkms modules will fail otherwise.
>>
>> Add a check, if resolve_btfids is present and then package it, if required.
>>
>> Signed-off-by: Peter Jung<admin@ptr1337.dev>
>> ---
>>   scripts/package/PKGBUILD | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/scripts/package/PKGBUILD b/scripts/package/PKGBUILD
>> index f83493838cf9..4010899652b8 100644
>> --- a/scripts/package/PKGBUILD
>> +++ b/scripts/package/PKGBUILD
>> @@ -91,6 +91,11 @@ _package-headers() {
>>                  "${srctree}/scripts/package/install-extmod-build" "${builddir}"
>>          fi
>>
>> +       # required when DEBUG_INFO_BTF_MODULES is enabled
>> +       if [ -f tools/bpf/resolve_btfids/resolve_btfids ]; then
>> +               install -Dt "$builddir/tools/bpf/resolve_btfids" tools/bpf/resolve_btfids/resolve_btfids
>> +       fi
>> +
> This is not the right place.
>
> scripts/package/install-extmod-build is a script to set up
> the build environment to build external modules.
> It is shared by rpm-pkg, deb-pkg, and pacman-pkg.
>
>
> https://github.com/torvalds/linux/blob/v6.12-rc5/scripts/package/install-extmod-build#L34
>
> You will see how objtool is copied.
>
>
>
>
> (Anyway, it depends on your urgency.
> My hope is to support objtool and resolve_btfids in more generic ways.)
>

Thanks Masahiro for the suggestion. I will look into and likely bring a v2.
I did not know about other distribution/package managers, if this is 
also a problem at them.

At archlinux we have included this since a while already in the 
PKGBUILD, see here:
https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/blob/main/PKGBUILD?ref_type=heads#L151-152

I will also make the change to grep for DEBUG_INFO_BTF in the config 
with the is_enabled function, instead of checking the path


Regards,

Peter


