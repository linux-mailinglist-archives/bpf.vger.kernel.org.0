Return-Path: <bpf+bounces-51461-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 248BBA34DD2
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 19:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 797C816A1F5
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 18:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B187245AE5;
	Thu, 13 Feb 2025 18:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Kztbnl7b"
X-Original-To: bpf@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7CF245021;
	Thu, 13 Feb 2025 18:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739471968; cv=none; b=AlGFU/2s+EhnkSElmVC4jSdj/6K6l7mlKpuXqvPFIb0oSz1XYvVI6Qamzj86umwV3MfSupj2uXUNFYQyi04ZHGvxb4dwobBNaNjOiJwGDhC//ydhnTrZIgWm3pEnpOKLZfdlgLFfcuiSOcFh8uLzel0sFfaFUhqGc6jeszs1SBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739471968; c=relaxed/simple;
	bh=IL4JfZ8f/GmNV2oysYaN+vVvAghC4NR4d9vaXPutmxU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PIywRpEMbJRzitcKTQkZiSAKq5tQoUvUGDKzIOGUXxrCN9llrNsOwbZeKKQwJerNPObA/OO0goxxFxEQTXjDvBODfxj/b9I+DhhqqBprGfZyqnWnWfWAkm0984ngLg62WH97iXq4KzgiUfectLFSBEOy3A+QQnLvHviEbjZ7Z4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=Kztbnl7b; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 2E41640411
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1739471966; bh=hWkxJ1YfLob73I7zxkcyS5NjQGuT1JLfL25ucCp224w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Kztbnl7bnXKKL9nmBXC8dduAeQpXAai0HXznNTtO0ezpnwdepmRaJTQNzAwyAG9Io
	 UrPsV+FC/qluP3qW4UNtBd+sANT3CRFpjkgGYu2qpm53RY/Q2BoTQf68/CyHt8yRMB
	 sUJWB2GJPb4RD/GwTPyxKlbk8OsehSmf+goCfe6ynqwY1rH6nKLy9BwubgH7dxfmx2
	 Wg98MTfummjoZlzmoL+4OsjHeMkKOFKr2hE2z74llUpgCsITq6IKcTBT4VOjCu4Bdz
	 XEbK8PFV/BTYVvFlmFKh9bqMO1WQdSdS00rFHrAyAeiLQMigmx9PGg3VKOSlZ9nNP0
	 TnZWQ1aRMp7mw==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 2E41640411;
	Thu, 13 Feb 2025 18:39:26 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Linux Doc Mailing
 List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>, linux-kernel@vger.kernel.org, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>, Nick
 Desaulniers <ndesaulniers@google.com>, bpf@vger.kernel.org,
 llvm@lists.linux.dev, workflows@vger.kernel.org
Subject: Re: [PATCH 0/4] Raise the bar with regards to Python and Sphinx
 requirements
In-Reply-To: <cover.1739254187.git.mchehab+huawei@kernel.org>
References: <cover.1739254187.git.mchehab+huawei@kernel.org>
Date: Thu, 13 Feb 2025 11:39:25 -0700
Message-ID: <871pw14rky.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> This series  increases the minimal requirements for Sphinx and Python, and
> drop some backward-compatible code from Sphinx extension.

OK, I've gone ahead and applied this series - let's see who screams...

Thanks,

jon

