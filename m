Return-Path: <bpf+bounces-44518-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C34B9C3FD4
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 14:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33D031F22BCE
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 13:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED76A19CC3F;
	Mon, 11 Nov 2024 13:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qmon.net header.i=@qmon.net header.b="AXSG6YV7"
X-Original-To: bpf@vger.kernel.org
Received: from outbound.soverin.net (outbound.soverin.net [185.233.34.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0D51DA53
	for <bpf@vger.kernel.org>; Mon, 11 Nov 2024 13:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.233.34.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731333030; cv=none; b=SK0udbwAMu5vYYCKRlj+rEYb+YreMrp6EUhKgpO6gbmbyGUhIvmJmTOjMSQLVxvxrwzCNG0A25Voq+9nqqFjgaYcK/pWeE58Xuhj0F/QoxcJ/JYnoqd7xPIwLCMHrVCtIh6sIIqqk/BoJKSS3RgVCOM8CpasNbuvMM26Dd87fZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731333030; c=relaxed/simple;
	bh=lFc5lmkCmOdT3wcA2DboGy1EpIvJa7IGHBahEBSWdF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Z3SiWw9dEGmMDvJ5QSwS7vRSsrRrrDlczl9WiKuZoLDaW2WIGIIsR2DxogjpcrXXC3dT84ua4/7c+krLd6+CHKOtgszocBaext+9bFLpDeeW3st+eBeOWwUFCrkCGyxnIaCkQ/p2pvBKA0zkjwmcTw+epmlk1X0ulclAgC2RiIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qmon.net; spf=pass smtp.mailfrom=qmon.net; dkim=pass (2048-bit key) header.d=qmon.net header.i=@qmon.net header.b=AXSG6YV7; arc=none smtp.client-ip=185.233.34.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qmon.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qmon.net
Received: from smtp.soverin.net (c04cst-smtp-sov01.int.sover.in [10.10.4.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by outbound.soverin.net (Postfix) with ESMTPS id 4Xn9j82b8qzkW;
	Mon, 11 Nov 2024 13:42:52 +0000 (UTC)
Received: from smtp.soverin.net (smtp.soverin.net [10.10.4.99]) by soverin.net (Postfix) with ESMTPSA id 4Xn9j76gtWzCN;
	Mon, 11 Nov 2024 13:42:51 +0000 (UTC)
Authentication-Results: smtp.soverin.net;
	dkim=pass (2048-bit key; unprotected) header.d=qmon.net header.i=@qmon.net header.a=rsa-sha256 header.s=soverin1 header.b=AXSG6YV7;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qmon.net; s=soverin1;
	t=1731332572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2NdpUQSFZ7tYPISFb4iDa3603n4oz8gzLuNmSe28qy8=;
	b=AXSG6YV7nKjxzfxK46ZCpkiMr+hNt4+gh24psL0K9TmYMAxpDaeF6buI526LwubDPA3tAF
	qAIgUPDI8eS07hY7th4OLMVOpnZfwZuf6xVWMLMakXrxF2bDBuSvAJFPF73cZ1wYpZY969
	KRQYizeRIuRiRPRLnKgBoZKu31cmaaRXJ0dvqSBZtboy7F0rl55RDm4FPN4FAlJUPWk1YK
	+p09aAA0CEtFMoTCUyA9CbJPoabtnE88BGEfAoMJnM4O43fwl6ZI2E5pGCufsKNZFv/MsX
	2xC5FUJKBpTrMQXuPdw0fkFacajfqRLkBCCBpyTFjE5IL/9qXYkWpNow/svOYQ==
Message-ID: <c8c4f6aa-8a72-42ea-b926-0daa4074b7ad@qmon.net>
Date: Mon, 11 Nov 2024 13:42:51 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] bpftool: Set srctree correctly when not building out of
 source tree
To: Daan De Meyer <daan.j.demeyer@gmail.com>, bpf@vger.kernel.org
References: <20241110184429.823986-1-daan.j.demeyer@gmail.com>
From: Quentin Monnet <qmo@qmon.net>
Content-Language: en-GB
In-Reply-To: <20241110184429.823986-1-daan.j.demeyer@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spampanel-Class: ham

2024-11-10 19:44 UTC+0100 ~ Daan De Meyer <daan.j.demeyer@gmail.com>
> This allows building bpftool directly via "make -C tools/bpf/bpftool".
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


Hi and thanks! Can you please provide more context on what the change is
supposed to fix, please? "make -C tools/bpf/bpftool" should work already.

Please also sign-off your patches.

Thanks,
Quentin

