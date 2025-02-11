Return-Path: <bpf+bounces-51167-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F23C1A31360
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 18:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FCE33A4AE3
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 17:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC25419AD99;
	Tue, 11 Feb 2025 17:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="LujDI75O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yPqDjUvv"
X-Original-To: bpf@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A9A156C69;
	Tue, 11 Feb 2025 17:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739295929; cv=none; b=aqof9ZibqftIp2TG+xPgiZBZz2CUHqnJKMcSwC8UBP1UVvnUoKvCqbcux5oZ17UvHBOqgJszYIpanSe3bhhIp49SOyhEPB5dbEAid0pa0pfJTX4LBHWtGTx+UTJsMEKMfhXG5owF0XwbCZSzgu6qtMrbyiM7d6gNs/QyN8g8Osc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739295929; c=relaxed/simple;
	bh=Cyr8xNX4CD2amZmI5NG6bxTs4j3Nl6bQnMObGiScGQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rp79P5ZoSHhxmYsCp8NPL5o/AbC2yeKDjwUlskCBycknZf72zKXo0ROxkAU8x5PmPYI7ygj2QKS7zWz8wQIqk94S0YwyJuv8zL7hwiBjz3S6tJ0B0tGbHP3oFjJiY0m1exZdny290neoN+HV6eGvksGqjiaf33gh2GXQu4VP1pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=LujDI75O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yPqDjUvv; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 271D3114012F;
	Tue, 11 Feb 2025 12:45:26 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Tue, 11 Feb 2025 12:45:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1739295926; x=1739382326; bh=TfcLRWsOlI
	eIaKdeFDqkhNFH2enF1gy8hw8yD6zvWOY=; b=LujDI75Oe869hpGwb7PsRhdVN6
	IVZ+NX7yd/e1q7IiG3t77U39aRufSlnd5h7kz6WgMBf0dIrXX+Izo6IEALVxrNcn
	R54BsfdAlq4UM4n46mg2sWjoGm8lg0GBnPsJfJ0fa3iwxnrMprmD9CVtpABo+J2l
	RmP+8bRE13OSU2OPYxLNjNKCv0cC55hb0GDQeKqnAxFv1yHcnJbE2RLg4tghxL18
	P81FFM9ZIN+FimEsoMVubT8i/7mXksEeMdn+QLj55mnP5mOKztXtlvegNNqIi8xD
	Kscjndv0fOrWx44TFawsGxEG78ts1YiseUn6cio2OLhQu0nj5ac9UeCZ8gig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739295926; x=1739382326; bh=TfcLRWsOlIeIaKdeFDqkhNFH2enF1gy8hw8
	yD6zvWOY=; b=yPqDjUvvuEz6SxsQ3qtSUctSU3vrMFrc0yI56GqfrOifN3Ffrwg
	r8JoSxuTj/Tc7hLdJaAnaCNzc5VxgEa+Zdfjnv9fLhSt0eYDYkHL5k22D8eIjCNx
	gAzwVa7azCKZVPsD/vvR3TONxdy77Y9F8qw+izJBbQAcsD6pjeV2KlaNF3o8FrFW
	KUhKGIdDuE5BirLXJquYbiDVzFkbhNTZjBl9i/qPG7Nal0GUtogzNvO2K/uAV0vd
	KSfdw5XUocNjzsYcz4+VWKtvmeFg7HVgjBc4JYs+utWjlE87sO3U2wij4IZ8pAbi
	x7qqe0JPJaS5NVuTwxnfNSd7muyDTbgNMCA==
X-ME-Sender: <xms:tYyrZ6RvoyBV4PKemeOuhaxXhrEwaM2FfacHDC2Ikq6MOwXo-WkZ4A>
    <xme:tYyrZ_z8CSdDZsTJon_ChSazZGkHi9FCQTzKSVxmFOr_zUWoDuqR-B5_UglJ57L2Z
    E_Au0L-vs-YJNmMSg>
X-ME-Received: <xmr:tYyrZ313O1DyBNymkY_GaG2rKJUjVeNZzU9YN-h5N1UrLovvk0nmU0WWmuOwFuNJYeQmWdr6S8p-ZsUPC1AvtIq96Nkg7EfUzswPJvphYrrGvg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegudeifecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenfghrlhcuvffnffculdefhedmnecujfgurhepfffhvfevuffk
    fhggtggujgesthdtsfdttddtvdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihuse
    gugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpeefhfffhfehgfefgfevvdeiheev
    gfetudeifeetueehudefledutdekveekgeffgfenucffohhmrghinhepghhnuhdrohhrgh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihu
    segugihuuhhurdighiiipdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepmhgrshgrhhhirhhohieskhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepfhhrrghnkhdrsghinhhnshesihhmghhtvggtrdgtohhmpdhrtghpthhtohepmhgrth
    htrdgtohhsthgvrhesihhmghhtvggtrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgv
    rhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprggtmhgvsehrvg
    guhhgrthdrtghomhdprhgtphhtthhopegsphesshhushgvrdguvgdprhgtphhtthhopehn
    rghthhgrnheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhhitgholhgrshesfhhjrg
    hslhgvrdgvuhdprhgtphhtthhopegsphhfsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:tYyrZ2Cay2gQABQWSPPkNM8HOnaiu4jrL4Wc6YDukFMEPz2-bExCjw>
    <xmx:tYyrZzi_Jli-GvmMwwxEQP1VXLkWjBeQVSQvHT2tbOhUG_9a_biOmw>
    <xmx:tYyrZypX0rB0KnglFWN-7h_u8JQAZDB56FJuKy74YZDZjr7CdNgNOw>
    <xmx:tYyrZ2hqNH0_nk9MJqhATXC_xYKMTu1MA0wXny75iueEUlrsr1_NXg>
    <xmx:tYyrZ4aPG-UJeDmEUJgduFymhbFcnXzDrazHS7R3l8_2GxZoI5OE7hdG>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Feb 2025 12:45:23 -0500 (EST)
Date: Tue, 11 Feb 2025 10:45:22 -0700
From: Daniel Xu <dxu@dxuuu.xyz>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Frank Binns <frank.binns@imgtec.com>, 
	Matt Coster <matt.coster@imgtec.com>, linux-kernel@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, Borislav Petkov <bp@suse.de>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, bpf@vger.kernel.org, 
	linux-kbuild@vger.kernel.org
Subject: Re: [PATCH] tools: fix annoying "mkdir -p ..." logs when building
 tools in parallel
Message-ID: <6bwwjyvhajytkvwumbjbj5glk27w3cqf4ylobfyhhclioypsfs@hen3m6i2cdga>
References: <20250211002930.1865689-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211002930.1865689-1-masahiroy@kernel.org>

Hi Masahiro,

Thanks for looking into this! Much better than my attempt :P

On Tue, Feb 11, 2025 at 09:29:06AM +0900, Masahiro Yamada wrote:
> When CONFIG_OBJTOOL=y or CONFIG_DEBUG_INFO_BTF=y, parallel builds
> show awkward "mkdir -p ..." logs.
> 
>   $ make -j16
>     [ snip ]
>   mkdir -p /home/masahiro/ref/linux/tools/objtool && make O=/home/masahiro/ref/linux subdir=tools/objtool --no-print-directory -C objtool
>   mkdir -p /home/masahiro/ref/linux/tools/bpf/resolve_btfids && make O=/home/masahiro/ref/linux subdir=tools/bpf/resolve_btfids --no-print-directory -C bpf/resolve_btfids
> 
> Defining MAKEFLAGS=<value> on the command line wipes out command line
> switches from the resultant MAKEFLAGS definition, even though the command
> line switches are active. [1]
> 
> The first word of $(MAKEFLAGS) is a possibly empty group of characters
> representing single-letter options that take no argument. However, this
> breaks if MAKEFLAGS=<value> is given on the command line.
> 
> The tools/ and tools/% targets set MAKEFLAGS=<value> on the command
> line, which breaks the following code in tools/scripts/Makefile.include:
> 
>     short-opts := $(firstword -$(MAKEFLAGS))
> 
> If MAKEFLAGS really needs modification, it should be done through the
> environment variable, as follows:
> 
>     MAKEFLAGS=<value> $(MAKE) ...
> 
> That said, I question whether modifying MAKEFLAGS is necessary here.
> The only flag we might want to exclude is --no-print-directory, as the
> tools build system changes the working directory. However, people might
> find the "Entering/Leaving directory" logs annoying.
> 
> I simply removed the offending MAKEFLAGS=.
> 
> [1]: https://savannah.gnu.org/bugs/?62469
> 
> Fixes: a50e43332756 ("perf tools: Honor parallel jobs")
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Tested-by: Daniel Xu <dxu@dxuuu.xyz>

