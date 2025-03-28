Return-Path: <bpf+bounces-54868-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE59A74FFE
	for <lists+bpf@lfdr.de>; Fri, 28 Mar 2025 19:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAB8A189881B
	for <lists+bpf@lfdr.de>; Fri, 28 Mar 2025 18:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FBEC1DE4DF;
	Fri, 28 Mar 2025 17:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eSejvD60"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D411DDC34
	for <bpf@vger.kernel.org>; Fri, 28 Mar 2025 17:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743184558; cv=none; b=AWCxD29fJ6S0fRi6xFGv+ZBRZWo0hXHuTsDxrGNK6iY/nTpA3L1JQSoO81tscI3vY1+XMjdmFGogdyLPPZb7+Z9Yde/yjx7PrR/mdgN5a+fXbyzqis4wkwjIsboQlhnYJFwQ/SvXh0blKkRRxPN7LA5Xrz1c4KmVHLD4ogfsmz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743184558; c=relaxed/simple;
	bh=Wy9h/1y+lKmUWQ5MGOquEdqOFFMzyccUgwfWDCtOnmk=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=ITBI9K2lwJRi1u66I++dMsbXLN60AZzg+tqlke8DyZli/XxWSbnPVnPas8Kedb8R5XD6J/18zpI/ppxrtu0K6wf0WI0GEOafZBTvGEhbJ775oGkLcOPlnwRdPIsOz6e0kximJayCwoGvwDXU/1YOqxRjyEJxDHMV071xNLOmZZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eSejvD60; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743184541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wy9h/1y+lKmUWQ5MGOquEdqOFFMzyccUgwfWDCtOnmk=;
	b=eSejvD60o35X2OqvZzS470vH2tcW6Nra8vm9dVBVCHi/j23O8TyrlZmuAfOGJmKVsVbKPO
	d2j87R57oYi4+uy/sn3qXsCbkzIoKP98agFgVh3UrX1q3ihW+a4a5M6BN1OH/IEQq5IwmM
	fAufN/objDjAkJnaDsxgL/ZjJt6SxGU=
Date: Fri, 28 Mar 2025 17:55:39 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Ihor Solodrai" <ihor.solodrai@linux.dev>
Message-ID: <fdbb0895eaa8e7e64928e5eb929194d170032a55@linux.dev>
TLS-Required: No
Subject: Re: parallel pahole hangs while building modules from
 nvidia-open-kernel-dkms
To: "Domenico Andreoli" <domenico.andreoli@linux.com>
Cc: dwarves@vger.kernel.org, alan.maguire@oracle.com, acme@kernel.org,
 andrii@kernel.org, bpf@vger.kernel.org
In-Reply-To: <933e199997949c0ac8a71551830f1e6c98d8bff0@linux.dev>
References: <Z-JzFrXaopQCYd6h@localhost>
 <83315e0bce204f7745448fff550574d44b09b4c1@linux.dev>
 <Z-ZmcwXyMtAQjaoE@localhost>
 <933e199997949c0ac8a71551830f1e6c98d8bff0@linux.dev>
X-Migadu-Flow: FLOW_OUT

On 3/28/25 9:25 AM, Ihor Solodrai wrote:
> [...]
>
> Could you please share the base vmlinux passed to the command that
> produces this error? Maybe you could provide instructions on how to
> build it?

I just noticed that you shared some input files in the original
report. I'm going to try and reproduce the issue with that, thanks.

>> [...]

