Return-Path: <bpf+bounces-44526-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A02C9C4207
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 16:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27A4B2878F8
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 15:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2B119F12D;
	Mon, 11 Nov 2024 15:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qmon.net header.i=@qmon.net header.b="FCLcnHcG"
X-Original-To: bpf@vger.kernel.org
Received: from outbound.soverin.net (outbound.soverin.net [185.233.34.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17211BC58
	for <bpf@vger.kernel.org>; Mon, 11 Nov 2024 15:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.233.34.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731339562; cv=none; b=H6SEjMbCg59vFbjr0y69SbfJyyACH1DjvJuTIWHcnCwLT8ojwmfB4sXQ3iXSDr6/s6TOmnZJehyYzzHFDQ0k/t4P/SBAeD5UxK5ziZ91LC9aHN/Ee1jw9f49EtIMMVbgs2aeipmgjd1ERqrrAx0YagIE3pRr6MDZS6I8zLLH6io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731339562; c=relaxed/simple;
	bh=Vv40MpjHanV+0vl5R+TroH3DBZzOPEdti7yxvS9vaGY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=M/cEEpTTuLcyIJUmLENiBXYZRHXFy5Qw4TN8pgmqExWaUBWJlKDRZzhfdLW8e5UbgcFcWLwlxImiI9eTaYDSW3UPNaWJQm6FeHtHH9tuFgGgRTEVLfzCkW+zhMzAb4kkZIv3WzDtf2qCyX2Geu6sMGnPAmm4mNvPimaXVHq+j1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qmon.net; spf=pass smtp.mailfrom=qmon.net; dkim=pass (2048-bit key) header.d=qmon.net header.i=@qmon.net header.b=FCLcnHcG; arc=none smtp.client-ip=185.233.34.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qmon.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qmon.net
Received: from smtp.soverin.net (c04cst-smtp-sov02.int.sover.in [10.10.4.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by outbound.soverin.net (Postfix) with ESMTPS id 4XnDHP30YRzwq;
	Mon, 11 Nov 2024 15:39:13 +0000 (UTC)
Received: from smtp.soverin.net (smtp.soverin.net [10.10.4.100]) by soverin.net (Postfix) with ESMTPSA id 4XnDHN6h6CzLm;
	Mon, 11 Nov 2024 15:39:12 +0000 (UTC)
Authentication-Results: smtp.soverin.net;
	dkim=pass (2048-bit key; unprotected) header.d=qmon.net header.i=@qmon.net header.a=rsa-sha256 header.s=soverin1 header.b=FCLcnHcG;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qmon.net; s=soverin1;
	t=1731339553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ot3TiqStbzlqAUM2K83YUmmDFbh03HEzThgavjlR39k=;
	b=FCLcnHcGqM4vI5naIhHj/1MpbrPa7UxAUi0TtuN3DUeucjHUw3E6O3o0Rel8szY6M7HqyP
	Bi5H/vIyaZo1e4xFEizQdZ2YMYKFTuXbXp1aNazpl/h56tfd7E60qQu1bQtNE2Zgjm0EX4
	Uc/7NktCMTQQE0eAecm5RP1T9fhVU69hOizswpITfjEYtVXuUi/xDagME52JnPj1QFOF9n
	it35pmqK1HK+C5dCjti4KEQ7KZ/DgeE0CPaQRDnAtosIB9vKhPtscByPjCxNxFxFwFnlUj
	wjRse9RJiQbB498ExW/o+TxhtoMFYyD1kR7pd0L09GEFwbC1KTrGbDM5lh/6cA==
Message-ID: <1319dcc5-979b-43d5-8737-ae7716648937@qmon.net>
Date: Mon, 11 Nov 2024 15:39:12 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] bpftool: Set srctree correctly when not building out
 of source tree
To: Daan De Meyer <daan.j.demeyer@gmail.com>, bpf@vger.kernel.org
References: <20241111140305.832808-1-daan.j.demeyer@gmail.com>
From: Quentin Monnet <qmo@qmon.net>
Content-Language: en-GB
In-Reply-To: <20241111140305.832808-1-daan.j.demeyer@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spampanel-Class: ham

2024-11-11 15:02 UTC+0100 ~ Daan De Meyer <daan.j.demeyer@gmail.com>
> This allows building bpftool directly via "make -C tools/bpf/bpftool".
> 
> Without this change, building bpftool via "make -C tools/bpf/bpftool"
> fails with the following error:
> 
> """
> + make ARCH=x86 -C tools/bpf/bpftool bootstrap
> Makefile:127: tools/build/Makefile.feature: No such file or directory
> make[3]: *** No rule to make target 'tools/build/Makefile.feature'.  Stop.
> error: Bad exit status from /var/tmp/rpm-tmp.3p0IcJ (%build)
> """
> 
> This is the same workaround that is also applied in tools/bpf/Makefile.


My understanding of the check on building_out_of_srctree in
tools/bpf/Makefile (from commit 55d554f5d140's description) is that it
fixes the build from "make TARGETS=bpf kselftest", not from "make -C
tools/bpf".

Trying again "make ARCH=x86 -C tools/bpf/bpftool bootstrap" at the root
of the Linux repo, not building out-of-tree, this works fine for me,
without the need for your patch. I'm trying to understand what your
setup is and what creates the failure that you observe (and that I can't
reproduce), so I'd like more context if possible. Are you just running
that command from the root of the tree? If that's the case, what values
do you observe for $(srctree) and $(building_out_of_srctree) when
entering bpftool's Makefile?

Your v2 also still misses your sign-off, and please remember as well to
add all relevant maintainers in copy of your email.


> ---
>  tools/bpf/bpftool/Makefile | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> index ba927379eb20..7c7d731077c9 100644
> --- a/tools/bpf/bpftool/Makefile
> +++ b/tools/bpf/bpftool/Makefile
> @@ -2,6 +2,12 @@
>  include ../../scripts/Makefile.include
>  
>  ifeq ($(srctree),)
> +update_srctree := 1
> +endif
> +ifndef building_out_of_srctree
> +update_srctree := 1
> +endif
> +ifeq ($(update_srctree),1)
>  srctree := $(patsubst %/,%,$(dir $(CURDIR)))
>  srctree := $(patsubst %/,%,$(dir $(srctree)))
>  srctree := $(patsubst %/,%,$(dir $(srctree)))


