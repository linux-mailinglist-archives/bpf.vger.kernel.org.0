Return-Path: <bpf+bounces-21785-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DDA8520C7
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 22:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CE1BB22D9C
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 21:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413D24E1D7;
	Mon, 12 Feb 2024 21:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="yfGenmqT";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="o71XIrOG";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="lxHzGGev"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342BB4E1CC
	for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 21:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707774746; cv=none; b=YqOYc6t+DtRq50XyeIAU1P7RdNLDEnn73j6e+JJVXBlfZtfNoulBm+vA/SUWnxm24U0e/GGVyMNz16lC+PhHBBbXzisxX6gJ17P5crn0IiSN+t1qwRBiL3pk76Xb4aEvOlg356Mhnq0AdY8CcuTq2sI1QY0LkihvmCY0FLwj3+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707774746; c=relaxed/simple;
	bh=Z52nzP65CCj8PXVkjha2F0R2TiIBFtbvNYWjmxVfvlI=;
	h=To:Cc:References:In-Reply-To:Date:Message-ID:MIME-Version:Subject:
	 Content-Type:From; b=g5GvaWpZAG11jGBoaeRo0XkhaRFonPdsFWVioFhcvnGgZ/2ybKvbLgWd2FmJtkn5jutiLHoS/lxCGDzFyoEiwIJ6+sXgMARsh11rFelBBYyCXlU8/0bGZ5sFpzCGx/AHseT12suHVM3UzyzJQEaapfTNLs8H20EAh60M1gM84PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=yfGenmqT; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=o71XIrOG reason="signature verification failed"; dkim=fail (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=lxHzGGev reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id A408BC1519B0
	for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 13:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1707774744; bh=Z52nzP65CCj8PXVkjha2F0R2TiIBFtbvNYWjmxVfvlI=;
	h=To:Cc:References:In-Reply-To:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yfGenmqTSkFEI36u68qr56GJLgHJNmpvcZzrkXlI8jpuFWxHd1/ViqVC7Yvxwjh/P
	 jpmRfcYfFrkMo7w5GieI8ToW7kCLd2zarOL+fDio1rdiAnMlu/7QbR7NAavBwjRkgV
	 wPODLcrDiDrWqGOW+/rkzCmczak8KiUJXrv+cbtI=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id 6B0FBC1516EB;
 Mon, 12 Feb 2024 13:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1707774744; bh=Z52nzP65CCj8PXVkjha2F0R2TiIBFtbvNYWjmxVfvlI=;
 h=From:To:Cc:References:In-Reply-To:Date:Subject:List-Id:
 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
 b=o71XIrOGoBBI+XEuXtHvd/epffllLTePOXkm72Nakm+EIbCAtn3oyfXWgi3OQ8Zy3
 dUxBhfEwileuhraz7a8Gs/U4D6c6lAFauEAgYHpFQXkOV2HZRUgJDf6sjhQk53IFzt
 9J/PoxzLCGPHYtB4+KnHtlSCZGWcasaxGvbkaTXY=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 9FAABC1516EB
 for <bpf@ietfa.amsl.com>; Mon, 12 Feb 2024 13:52:22 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.854
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=googlemail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NJhy0IUV-XrI for <bpf@ietfa.amsl.com>;
 Mon, 12 Feb 2024 13:52:18 -0800 (PST)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id CAFB3C15170B
 for <bpf@ietf.org>; Mon, 12 Feb 2024 13:52:18 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-5d3912c9a83so174710a12.3
 for <bpf@ietf.org>; Mon, 12 Feb 2024 13:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1707774738; x=1708379538; darn=ietf.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=xSzzku9O08NX5s9mUmuY4UFBjA/m/rotu9BsWmCKqXI=;
 b=lxHzGGevncB4cTfQ7NGYsB7vOoU2AF3ri+fNOsrJNkogaYAtQrR9c0m6VQUTcDSH42
 mMAEF8cUcLlhuSXobbwReKXgVR3E42JQK5S6w3JBvFi2rjJCCNSYp93o4HFGXFwo316i
 cWZwfdQahSxD/CVsPu7MjJeEcd6c5KeWUqfT+aRsrVFpayBCVMbJKPWchKVzmsnPCMbB
 MkLm33BHiohOyDYlK38LEqUhFodoXtTUXdrOWyrM+2BCCUWmq80wJnEimP6fevt+y7mQ
 G78Z9sM1uxYDo2pyiLbBEzbx9bBb1lojMOFBJMBTkIzObvU9za75S7P4tyOI7aHou9BP
 1tDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707774738; x=1708379538;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xSzzku9O08NX5s9mUmuY4UFBjA/m/rotu9BsWmCKqXI=;
 b=tQmgYO3yZwF8RZXxCMBNNBYF3GiDYu/XFCFBkun76TXI8Ysp/XnERIugq6icWSUDKr
 SsBGcOQdK/YUF/2H/JVbZPqMqkGwl1QpOIPJp0AqgDvYobmQ2dN3ZCgYTvFqAh4lVzhm
 FQeyNiicIGcBuJA1mlu+gHADl/iZFDIj9aJ1AkU9Bvl+zOrOP5nuJLVk4SeekiOS0V5b
 mKFR/u9dFT4oAU2jkBYXOgybb/mU1AxKpbkIRE1XWmjvnGQIRD5M1jfuWnDWJjVh2vtf
 lBdYgZnwYnCOvcNYriPfx9IXDoI36Lrb6HhdfcqS/CwVbgcjk0nEXj7/cldXMP32apMU
 I6Kw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoDbqUxsVJzkYVHJoiwTbhnD2DpJ839TQtnainB7wF4nS2nxoy2j8TNPAyp5WBKtPjeq1GDAxDR8owQfY=
X-Gm-Message-State: AOJu0Ywh/yjNASEchjNANIiG7u/EQrxbBK6qw63SsbcrXra4MmIr3d0P
 Lilx/i8vHp0GHMaJClJwczM3pOiH2xQSwXEsrKdUFj95cy3pUNiLPxVHRxM3c5k=
X-Google-Smtp-Source: AGHT+IEd0mvSUzflQGwa1mNVWqzC62QasqHrF/Op9PhvU8QenBNqVes42V3UiTwNEkVizPI87aoE3g==
X-Received: by 2002:a17:90b:890:b0:297:244:94d4 with SMTP id
 bj16-20020a17090b089000b00297024494d4mr4260706pjb.43.1707774737999; 
 Mon, 12 Feb 2024 13:52:17 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUmCt7KTgkpPUbNfyWwNHq7d8cV9jFDz7V4OpBlUBej4IZGLDCwRXDRH2TiZR+c/oRKOBrTiUNfIhfyKtXxjtoz50LKSvp4bKfA4YDUvmnlzu2BDq9dO8AYqMMkQwnBUStJna1Gg2XBzpaoR1CsY3ywvtaQtZvElzSqAJUvMpIC0ph1yQ==
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net.
 [67.170.74.237]) by smtp.gmail.com with ESMTPSA id
 so10-20020a17090b1f8a00b00298a259fc26sm74989pjb.51.2024.02.12.13.52.16
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 12 Feb 2024 13:52:17 -0800 (PST)
X-Google-Original-From: <dthaler1968@gmail.com>
To: "'Yonghong Song'" <yonghong.song@linux.dev>,
 "'Jose E. Marchesi'" <jose.marchesi@oracle.com>,
 "'Dave Thaler'" <dthaler1968=40googlemail.com@dmarc.ietf.org>
Cc: <bpf@vger.kernel.org>,
	<bpf@ietf.org>
References: <20240212211310.8282-1-dthaler1968@gmail.com>
 <87le7ptlsq.fsf@oracle.com> <b5072dfb-ab2b-40eb-891e-630a02c58fe8@linux.dev>
In-Reply-To: <b5072dfb-ab2b-40eb-891e-630a02c58fe8@linux.dev>
Date: Mon, 12 Feb 2024 13:52:15 -0800
Message-ID: <036301da5dfd$be7d1b30$3b775190$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKk5nBwvPPKgL8m8zzpY/2G4YK4bQLYE4TWAif8DTavSi2JsA==
Content-Language: en-us
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/ZYquSeCkO1uyl8TJ5qnteAfi0r0>
Subject: Re: [Bpf] [PATCH bpf-next v2] bpf,
 docs: Add callx instructions in new conformance group
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>
X-Original-From: dthaler1968@googlemail.com
From: dthaler1968=40googlemail.com@dmarc.ietf.org

> -----Original Message-----
> From: Yonghong Song <yonghong.song@linux.dev>
> Sent: Monday, February 12, 2024 1:49 PM
> To: Jose E. Marchesi <jose.marchesi@oracle.com>; Dave Thaler
> <dthaler1968=40googlemail.com@dmarc.ietf.org>
> Cc: bpf@vger.kernel.org; bpf@ietf.org; Dave Thaler
> <dthaler1968@gmail.com>
> Subject: Re: [Bpf] [PATCH bpf-next v2] bpf, docs: Add callx instructions in new
> conformance group
> 
> 
> On 2/12/24 1:28 PM, Jose E. Marchesi wrote:
> >> +BPF_CALL  0x8    0x1  call PC += reg_val(imm)          BPF_JMP | BPF_X
> only, see `Program-local functions`_
> > If the instruction requires a register operand, why not using one of
> > the register fields?  Is there any reason for not doing that?
> 
> Talked to Alexei and we think using dst_reg for the register for callx insn is
> better. I will craft a llvm patch for this today. Thanks!

Why dst_reg instead of src_reg?
BPF_X is supposed to mean use src_reg.

But this thread is about reserving/documenting the existing practice,
since anyone trying to use it would run into interop issues because
of existing clang.   Should we document both and list one as deprecated?

Dave

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

