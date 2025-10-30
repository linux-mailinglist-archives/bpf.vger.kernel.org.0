Return-Path: <bpf+bounces-72974-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCA7C1E73E
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 06:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9B5A74E650D
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 05:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE5A31A80D;
	Thu, 30 Oct 2025 05:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oTinanvm"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F111228CA9;
	Thu, 30 Oct 2025 05:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761803097; cv=none; b=BCWDlie9VLfz40fIyIQgOLV7G5hTP1FnxEy7thXriMI5uGztCm1WXKy6GN5SzIvSqgOc3iWuhCnpFyDu3zChEUzchJ/c98M/BcA0T7JhgLayPuxX926QUZ+AJVvUcKwCenv7JraZ+KkgwDjQrSods44j/ypzU8qNMUDm8pRoTfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761803097; c=relaxed/simple;
	bh=uo66Dy0uiF0O+hdZ0X1088dBsMEaPVjdELsKtaWghds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jO/Qm0ZpSilm94+ZBKZFTpUKNWrVoRGWGFDoJI5KN4ZTJS7Se8g62w25fi9o68zy/1VLn4OW2IQBR9M7fmzpPW9sqHnl30cFB3cNvzL0Bdf9Xc1KFB7IfxEaQDpKi1DFbQMPstLIGFxK41T9NIMV31uq8c6C3Dx7QN/nvYpGZOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oTinanvm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECC88C4CEF1;
	Thu, 30 Oct 2025 05:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761803097;
	bh=uo66Dy0uiF0O+hdZ0X1088dBsMEaPVjdELsKtaWghds=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oTinanvmdKQeEKjDjTOy++2bJoot2SCmxBRawWsxysLQbRg/k3ZIikeH4+zXurga2
	 pnOa361ka2FwbyoFKOZla+jPiemosGE1ZNCUcihtwhA5NzGeKVHA6lRbaVSkcf3hIj
	 /CJcsaPC7NG8Xwy4Rt/cv19INZ+DiPGXGiBaqxQ1qvBLcE54IaWNdHfjP4bEihColI
	 ToNMWoAD15Ednnu7DMjgxTHrtRR6MggOGrzJ8tBTG6q9HpozMLqPCWOn0fho6oyp4H
	 vqdZh+9v8FCGvBuDDGqBi2Dvx5a6ScdEm/i883wZzbj6sQE1ndlc/GLPC9wnMBgZ4K
	 rAnVXmKJpqUvQ==
Date: Wed, 29 Oct 2025 22:44:54 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Quentin Monnet <qmo@kernel.org>
Cc: KP Singh <kpsingh@kernel.org>, bpf@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [BUG] bpftool: Build failure due to opensslv.h
Message-ID: <aQL7VuWn8xa--8qg@google.com>
References: <aP7uq6eVieG8v_v4@google.com>
 <2cb226f8-a67c-4bdb-8c59-507c99a46bab@kernel.org>
 <aP-5fUaroYE5xSnw@google.com>
 <d6a63399-361f-4f1c-845c-b69192bfc822@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d6a63399-361f-4f1c-845c-b69192bfc822@kernel.org>

On Tue, Oct 28, 2025 at 10:05:52AM +0100, Quentin Monnet wrote:
> 2025-10-27 11:27 UTC-0700 ~ Namhyung Kim <namhyung@kernel.org>
> > On Mon, Oct 27, 2025 at 11:41:01AM +0000, Quentin Monnet wrote:
> >> 2025-10-26 21:01 UTC-0700 ~ Namhyung Kim <namhyung@kernel.org>
> >>> Hello,
> >>>
> >>> I'm seeing a build failure like below in Fedora 40 and others.  I'm not
> >>> sure if it's reported already but it failed to build perf tools due to
> >>> errors in the bootstrap bpftool.
> >>>
> >>>     CC      /build/util/bpf_skel/.tmp/bootstrap/sign.o
> >>>   sign.c:16:10: fatal error: openssl/opensslv.h: No such file or directory
> >>>      16 | #include <openssl/opensslv.h>
> >>>         |          ^~~~~~~~~~~~~~~~~~~~
> >>>   compilation terminated.
> >>>   make[3]: *** [Makefile:256: /build/util/bpf_skel/.tmp/bootstrap/sign.o] Error 1
> >>>   make[3]: *** Waiting for unfinished jobs....
> >>>   make[2]: *** [Makefile.perf:1213: /build/util/bpf_skel/.tmp/bootstrap/bpftool] Error 2
> >>>   make[1]: *** [Makefile.perf:289: sub-make] Error 2
> >>>   make: *** [Makefile:76: all] Error 2
> >>>
> >>> I think it's from the recent signing change.  I'm not familiar with
> >>> openssl but I guess there's a proper feature check for it.  Is this a
> >>> known issue?
> >>
> >>
> >> Hi Namhyung,
> > 
> > Hello!
> > 
> >>
> >> This looks related to the program signing change indeed, commit
> >> 40863f4d6ef2 ("bpftool: Add support for signing BPF programs")
> >> introduced a dependency on OpenSSL's development headers for bpftool.
> >> It's not gated behind a feature check. On Fedora, I think the headers
> >> come with openssl-devel, do you have this package installed?
> > 
> > No I don't, but I guess it should be able to build on such systems.  Or
> > is it required for bpftool?  Anyway I feel like it should have a feature
> > check and appropriate error messages.
> > 
> 
> +Cc KP
> 
> We usually have feature checks when optional features bring in new
> dependencies for bpftool, but we haven't discussed it this time. My
> understanding was that program signing is important enough that it
> should always be present in newer versions of bpftool, making OpenSSL
> one of the required dependencies going forward.

Yeah, the problem is that it also affects to perf build.

> 
> We don't currently have feature checks to tell when required
> dependencies are missing for bpftool (it's just the build failing, in
> that case). I know perf does a great job at it, we could look into it
> for bpftool, too.

It's in the tools/build directory. :)

Thanks,
Namhyung


