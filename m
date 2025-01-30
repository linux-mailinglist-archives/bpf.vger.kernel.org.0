Return-Path: <bpf+bounces-50122-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05330A2307F
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 15:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F09118888E3
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 14:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C541E9916;
	Thu, 30 Jan 2025 14:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="sKEKC6A5"
X-Original-To: bpf@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6951E1BB6BC;
	Thu, 30 Jan 2025 14:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738247816; cv=none; b=dspOR5N9gv9ROE2y7s4DLT8tmbh4xSh5p6XBGrnMHutFoTODGggfbic3xa3EIHkbfWRBF/J6sxnxyZZfoNMToQEeXH+8TsKG+8lyzVqg3HnyGT8+O9SVgbyDC2t/x+V4sCQvjhKcewILdH9arLjYCiG5RxyWv5Q/5hOwpfSMkww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738247816; c=relaxed/simple;
	bh=w4zTxfa4CCDrQAqGDdWlBpCt/2B8kWrn1L7k7sZwIxw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Sr8QbhO9sA14/AMJsFleFefqK7aLmFnPbnhPJxJTdT70fv1WTS7R0Jgy2w3Gk35WYxUJfxfAyc8BfYr+PToiVnIhNsS9tZ1ANgoCkh+z6CqxBiT2r4/782/lShni0C1SApDjCmksFVzzOC2yJ2Wm5NXWAIswkYReQ3a0kPjbJq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=sKEKC6A5; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 2A488411A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1738247474; bh=o6c9Xty8LBnNCjw4IIteZjg2Dft0pgS1FqTeBELLb/s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=sKEKC6A5mJNrWh2OnYdq4XrzlSBVffqzWdJUguTsQbBj9drsXtFOgeef3xmLeJ4lg
	 /PjJl21/gpJUMJcSlyoXz4wFPT5XDnIcqabEboDohTJeSD0N/MfB7WMqkGWTIS7Rcy
	 OdwEOZI8s7lHDnUmCsPWv2hkfgANWG5YaoqVMpVDiqq/zBgs1t86wEURsyuYWeOxwq
	 DCzAjUgxGr+l3ZThZ45iElLUMPxwPJmLa6d/E+S7QRpN+O0OoPytaxBrAxtTyGVA4I
	 GhkQXOyCZymZcfdaKhZnERHVIT5HC1AE/yqk7CauHk3/AfrlNZnuMxWIRveSQykYgD
	 xUI2FJhDNiPiA==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 2A488411A9;
	Thu, 30 Jan 2025 14:31:14 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Donald Hunter <donald.hunter@gmail.com>, Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 linux-kernel@vger.kernel.org, Bill Wendling <morbo@google.com>, Justin
 Stitt <justinstitt@google.com>, Nick
 Desaulniers <ndesaulniers@google.com>, bpf@vger.kernel.org,
 llvm@lists.linux.dev, workflows@vger.kernel.org
Subject: Re: [RFC 0/6] Raise the bar with regards to Python and Sphinx
 requirements
In-Reply-To: <m2zfj87ij9.fsf@gmail.com>
References: <cover.1738166451.git.mchehab+huawei@kernel.org>
 <m2zfj87ij9.fsf@gmail.com>
Date: Thu, 30 Jan 2025 07:31:13 -0700
Message-ID: <87jzac2x1q.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Donald Hunter <donald.hunter@gmail.com> writes:

> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
>
>> This series comes after https://lore.kernel.org/linux-doc/87a5b96296.fsf@trenco.lwn.net/T/#t
>> It  increases the minimal requirements for Sphinx and Python.
>>
>> Sphinx release dates:
>>
>> 	Release 2.4.0 (released Feb 09, 2020)
>> 	Release 2.4.4 (released Mar 05, 2020) (current minimal requirement)
>> 	Release 3.4.0 (released Dec 20, 2020)
>> 	Release 3.4.3 (released Jan 08, 2021)
>>
>> 	(https://www.sphinx-doc.org/en/master/changes/index.html)
>
> It's worth mentioning here that my fix for the C performance regression
> landed in Sphinx 7.4.0. All versions from 3.0.0 to 7.3.x are much slower
> for building the kernel docs. See #12162 here:
>
> https://www.sphinx-doc.org/en/master/changes/7.4.html#id7

Indeed, we have noticed the speedup - much appreciated, thank you!

jon

