Return-Path: <bpf+bounces-32423-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37BBA90DAE4
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 19:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D9F6B258D5
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 17:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F77914D2A6;
	Tue, 18 Jun 2024 17:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="kY4ATogn"
X-Original-To: bpf@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0C914431B
	for <bpf@vger.kernel.org>; Tue, 18 Jun 2024 17:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718732607; cv=none; b=FfUhfwQ9y/7sfX8MkhKmyilT3BeM4hmCExW+fRXRaIrQJKD1mKeo8GZH7YwnmEHRLNe3yKyXV8AbioBAPuA81cR8E4HVbRkzMP1PIuBzb9Ta+PvkRwIUWHvRD5rEuxEQy63QjRABVPOUeETTNe0hQorKZ6nFNTSlVHMqlXjxgBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718732607; c=relaxed/simple;
	bh=hD4dyAI/PYRubVNO1UKBSa6kK5kdbdsaRK1gQIEdEjU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=VE205gFSdDoHPLlTwbW+b9l1atXwQ3dhvecmF8fR+zVpGdBzkSTq6uWLPJVv2vXLj8xzLwU8iSUEYW9eNTepoR1xOAJ0NG9pGbKQh8nDXag9umgSAgfgCv/2DFsYI3LKRoVw/QrEmYMcSprvssOmPFkios9tdeFRcBqm0SPwvv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=kY4ATogn; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
X-Virus-Scanned: SPAM Filter at disroot.org
Date: Tue, 18 Jun 2024 18:43:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1718732600; bh=hD4dyAI/PYRubVNO1UKBSa6kK5kdbdsaRK1gQIEdEjU=;
	h=Date:From:To:Subject;
	b=kY4ATognRfJcvMgy0xgLUHp74PdeNY4I3c2NchPv9GsrwKt2QtI4/P4rbktQD9W6F
	 n70WS8Tya8yt5tCsP+O9HLrlOCyAVareYd/dOjQurgYWW4sybQ99JMCmb885WD7Fkk
	 F5o8DoDoP/fK5CosIJ7M18YeAPid8ukSY7AHhUF8hPnEUxCA/6grAKpV56a7WspziZ
	 fo9/noyHTA+H9uxTH2SpjG1ZKB2mJF1BimyPzJu8+WtAoPELLJ0aA21LWEyv3qNGBY
	 AcUuQPemaCy60ILwJrfUxjA/a9ByB3tNpBAgHDM0fi01BaaO7Vc09BrJF0tkneKJFi
	 x/CroKz2FS4jg==
From: BTD Master <btdmaster@disroot.org>
To: bpf@vger.kernel.org
Subject: kernel: memfd_create() called without MFD_EXEC or MFD_NOEXEC_SEAL
 set
Message-ID: <20240618184318.01aaaf4f@disroot.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

I would like to report the call to memfd_create in `src/libbpf.c` does
not specify MFD_NOEXEC_SEAL on newer kernels that allow
this feature, which is used to prevent code execution on the memory
area. It only specifies MFD_CLOEXEC.

This is reflected in the kernel logs:
[    4.853311] systemd[1]: memfd_create() called without MFD_EXEC or
MFD_NOEXEC_SEAL set

There is a similar patch in wayland for checking and versioning this
flag: https://gitlab.freedesktop.org/wayland/wayland/-/merge_requests/343/

Thanks!
btdmaster

