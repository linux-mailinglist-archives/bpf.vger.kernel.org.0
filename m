Return-Path: <bpf+bounces-34744-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0523930775
	for <lists+bpf@lfdr.de>; Sat, 13 Jul 2024 23:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75F96B2163F
	for <lists+bpf@lfdr.de>; Sat, 13 Jul 2024 21:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009E8146581;
	Sat, 13 Jul 2024 21:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gtucker.io header.i=@gtucker.io header.b="JfMaPYD9"
X-Original-To: bpf@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320C61B28D;
	Sat, 13 Jul 2024 21:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720905938; cv=none; b=EwzH5KkYeb1ViMA4h/S2NqI3aF7KyBGI57ZyGEamGkb4NRBxbnRCe62GNKil1gzdK6AvY64R+LU9Xn4nbBUhKARxJ2SgxDwVWeEWQujM7ZL49ma0u6sZIsDAIQ6STliNPV9J4eq5ZACLgRqB1Xj5ImjD04z7FoAEjYV2XrCxmXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720905938; c=relaxed/simple;
	bh=ri7Wmc2d4XDZpPrGlBZhDc5B+IGRkiA04hklPX/XNUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gw6dOWVb5GIAIu1hUIFiUsXzmZ4qG3tLFNhwmgsqSsGLogZz2AZO/QVvA2fE1pPejV1i4MEwgW/y00DYkuwHD2vbKsZvH+9ajgfTN6/vBXw7dh7nJeDJpVHr4DJgUBqBWwB3j3eBfUZi+teUbRRTRc8brDS22VOzJ1bx0WzxDY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gtucker.io; spf=pass smtp.mailfrom=gtucker.io; dkim=pass (2048-bit key) header.d=gtucker.io header.i=@gtucker.io header.b=JfMaPYD9; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gtucker.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gtucker.io
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2F22D40002;
	Sat, 13 Jul 2024 21:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gtucker.io; s=gm1;
	t=1720905927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eAGGW19rH40uPtJv5EREDlDHWbR0oXa+b8CqEV1Kpd4=;
	b=JfMaPYD9fBuKaccUEcaF5s12S3MtGXFXRBNtzJFJV7lmIYXhymJrXQSx8UWvrQkGlw1Pe8
	9jMna9WHWucBbwsdHsI975FWaQFupbvcL5aeezgk5hP7lMObC4owtAgI/G/EHRc1MqG9NP
	mRCxDgVUk2o8uXIOpnR/Colhq9VpQQJcahRLitTopOm1cwfP6bFhzsmEbG5oh55rYIIKdV
	E0qWoFNQ2vmDvKjuoJigJyMdhmGtbHDRIqN7U/yVknkSROncRFEHISb8swzKhIjPNBsFa/
	TLZ4UjVdTO79Y6Cil4ETKhIBPMVGlwKMpKsRhKu8yugmJtfNrEF7K3+oWrrRnA==
Message-ID: <0bcb07c8-8722-4224-a7e1-233e25369e2f@gtucker.io>
Date: Sat, 13 Jul 2024 23:25:25 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Plumbers Testing MC potential topic: specialised toolchains
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>,
 Miguel Ojeda <ojeda@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, llvm@lists.linux.dev,
 rust-for-linux@vger.kernel.org, yurinnick@meta.com, bpf@vger.kernel.org,
 Sasha Levin <sashal@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
 automated-testing@lists.yoctoproject.org
References: <f80acb84-1d98-44d3-84b7-d976de77d8ce@gtucker.io>
 <CANiq72mgTiOsnnLUP-JewoFsScV668WstP0bP2Lj+LGxd7L3sg@mail.gmail.com>
Content-Language: en-GB
From: Guillaume Tucker <gtucker@gtucker.io>
Organization: gtucker.io
In-Reply-To: <CANiq72mgTiOsnnLUP-JewoFsScV668WstP0bP2Lj+LGxd7L3sg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: gtucker@gtucker.io

Hi Miguel,

On 09/07/2024 01:07, Miguel Ojeda wrote:
> Hi Guillaume, all,
> 
> A couple of comments on the Rust bits for context.
> 
> On Tue, Jul 9, 2024 at 12:10 AM Guillaume Tucker <gtucker@gtucker.io> wrote:
>>
>> Then Rust support in the kernel is still work-in-progress, so the
>> rustc compiler version has to closely follow the kernel revision.
> 
> I wouldn't say the reason is that the support in the kernel is
> work-in-progress, but rather that `rustc` does not have all the
> features the kernel needs (and "stable").
> 
> In any case, the version pinning will soon be over -- we are likely
> going to have a minimum in v6.11:
> 
>     https://lore.kernel.org/rust-for-linux/20240701183625.665574-1-ojeda@kernel.org/
> 
> We are starting small, but it is already enough to cover the major
> rolling distributions: Arch, Fedora, Debian Sid (outside the freeze
> period) and perhaps Testing too, Gentoo, Nix unstable, openSUSE
> Slowroll and Tumbleweed...
> 
> So, for some distributions, the Rust toolchain for the kernel can
> already be directly from the distribution. So maybe it doesn't count
> as "specialised" anymore? (at least for some distributions)
> 
> Of course, I know that you include cutting-edge too :)

Ah that's great news.  And yes I think it's still "specialised"
if you want to build linux-next or rust-for-linux using the
cutting-edge rustc with extra features.

So instead of always requiring the latest rustc, it would now
have a range of versions with a minimum supported in mainline.

>> The current state of the art are the kernel.org toolchains:
>>
>>   https://mirrors.edge.kernel.org/pub/tools/
>>
>> These are for LLVM and cross-compilers, and they already solve a
>> large part of the issue described above.  However, they don't
>> include Rust (yet), and all the dependencies need to be installed
>> manually which can have a significant impact on the build
> 
> Rust is there thanks to Nathan! :) Please see:
> 
>     https://mirrors.edge.kernel.org/pub/tools/llvm/rust/

Of course, sorry I think it's the second time I make the mistake
in a month of not looking one level down under llvm...  Nice!

Thanks,
Guillaume


