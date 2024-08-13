Return-Path: <bpf+bounces-37062-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFAB1950AF8
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 19:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1AB3B2363B
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 17:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4EA41A7048;
	Tue, 13 Aug 2024 16:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="Pkj94tWF"
X-Original-To: bpf@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A1C1A2C09;
	Tue, 13 Aug 2024 16:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723568395; cv=none; b=fE18jD8R6qZq0FRlnydpTV1UeIoMhlIKKudkg+C9K4n0Zzac7kmLkPcWbYbzNsOBBoyRWIUDBUt4LoV5yA61I7X/stBMKbEoxU/soROQ+Q34tBMUQ3/uPKy7AP+d2ZKsLVpna6NZMiOP7CPUzMbxg3dPNYXb1BjBwBRE53/J63U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723568395; c=relaxed/simple;
	bh=H+GSxbRciVzhtZLSyCldyivM6OBE/OBkYicOMwnH20s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ah9zaRrLne3J0opD7d9UH2ce15iO8NUBPUzwUR3qJqyVQs/jGBR/P0vEXdDaolPeXIatvtIO2ckDoqcHF6pT6P0uUnRAyb6V2T0EBNJpx1kIcGS2r5v9tkrrbHa2kJPj1tKWgvsZjfxTxj7LfSfQ4wJ5ABFIRbK1D0i0cUasLb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=Pkj94tWF; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=p45lBwAXRul2ADDWjeHKzk8SKP407UQNCGCoZE9Qvk8=; t=1723568393;
	x=1724000393; b=Pkj94tWFE66+cMUEJP4JH2Yu1ZWM2Kv73ff7btpxcu2pJwX/5dJ4aoSVHOUb0
	ERwaURVI8E8rLbAfgG018a1JpDZjXAWICebSXkspza+7GBKlLdWVf12XYVTREBZIsQoILuRTS7BvC
	1r1sxkU/OcTJhShzYelJ1tSus8HJ2O6cSDiCBQ3IyxhguhhOtTaQUzNmsZEkWnb8LQP1kk/JXkTw8
	vS8uVmKCUXv0c0ljqFwHHBl80zXnvy0q6mY82/BMbXrp+NGJ6WBKG9gogc5A7aXXl4uGWipsrpTw9
	h5zp/bnn3gO+5bNXUkMhuFVBgbQPVP7ZSrkmmbVoziGofLdjuw==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sdus8-0002zG-Oh; Tue, 13 Aug 2024 18:59:48 +0200
Message-ID: <4193d3e2-8b24-45d3-8454-f3eb7c73c36a@leemhuis.info>
Date: Tue, 13 Aug 2024 18:59:48 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] tools build: Avoid circular .fixdep-in.o.cmd
 issues
To: Brian Norris <briannorris@chromium.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Thomas Richter <tmricht@linux.ibm.com>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 linux-kernel@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>,
 bpf@vger.kernel.org, linux-kbuild@vger.kernel.org
References: <20240715203325.3832977-1-briannorris@chromium.org>
 <20240715203325.3832977-3-briannorris@chromium.org>
 <99ae0d34-ed76-4ca0-a9fd-c337da33c9f9@leemhuis.info>
 <ZruMaIGu8EoAE1Fy@google.com>
From: Thorsten Leemhuis <linux@leemhuis.info>
Content-Language: en-US, de-DE
Autocrypt: addr=linux@leemhuis.info; keydata=
 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 n7RI
In-Reply-To: <ZruMaIGu8EoAE1Fy@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1723568393;9434566f;
X-HE-SMSGID: 1sdus8-0002zG-Oh

On 13.08.24 18:40, Brian Norris wrote:
> On Mon, Aug 12, 2024 at 08:32:29AM +0200, Thorsten Leemhuis wrote:
>> Lo! TWIMC, this change broke my daily arm64 and x86_64 Fedora vanilla RPM
>> builds on all Fedora releases when it hit -next a few days ago. Reverting
>> it fixes the problem.
>>
>> The problem is related to the RPM magic somehow, as building worked fine
>> when when I omitted stuff like "-specs=/usr/lib/rpm/redhat/redhat-
>> hardened-cc1 -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1" from the
>> make call. So the real problem might be that space somewhere.
> [...]
> I don't have a Fedora installation on hand at the moment, and the logs
> don't seem to include most of the actual kernel build logs
> (stdout+stderr of a V=1 build might help), but I think what you've
> provided so far has highlighted one possible problem -- that the new
> one-shot compile+link is ignoring HOSTCFLAGS, which were previously
> respected via tools/build/Build.include. Could you try the following
> diff? I'll cook a proper patch and description later, but for now:
> 
> --- a/tools/build/Makefile
> +++ b/tools/build/Makefile
> @@ -44,4 +44,4 @@ ifneq ($(wildcard $(TMP_O)),)
>  endif
>  
>  $(OUTPUT)fixdep: $(srctree)/tools/build/fixdep.c
> -	$(QUIET_CC)$(HOSTCC) $(KBUILD_HOSTLDFLAGS) -o $@ $<
> +	$(QUIET_CC)$(HOSTCC) $(HOSTCFLAGS) $(KBUILD_HOSTLDFLAGS) -o $@ $<

Many thx for looking into this. Seems that does resolve the problem (I
did not perform a full build, but without this the build fails after a
few seconds, and now it ran through).

I don't care much, but feel free to add a

Tested-by: Thorsten Leemhuis <linux@leemhuis.info>

Thx again!

Ciao, Thorsten

