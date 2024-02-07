Return-Path: <bpf+bounces-21436-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8224084D577
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 23:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8EF8B27F49
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 22:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF96712C7E6;
	Wed,  7 Feb 2024 21:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="LMJSxs8u"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050BE86AE3
	for <bpf@vger.kernel.org>; Wed,  7 Feb 2024 21:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341992; cv=none; b=cXOzG3HvIxtdIt8J2t1NMyy4Hdl8Xfje2SSXO04EU4eIIP8suoPIUFb9ZpAlJoJQd++XkZsFH0dsOGq3scbzEUPyClN4RiryzIRC5GEdPo2mtrMvlmitaWmpa3Nauop/aK5L0WkSFwrAkvufLWw1duL0mpxlDOjuAr3hBw7/+es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341992; c=relaxed/simple;
	bh=37BFNXM6PL73qP2ag01+MxIT/GP6MKGQA5xnlP6lRcw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ryb9aUzx/m3QkUhMg4ueVHQDWlDC55t464Vk4u86yMlIJUD13yJYwKHJ3h2kOkSGpmkfz+A4bdUhZNFTv/vU++Uy97hmzBjVtL9BOqPrtuAuWunIYc5CKQ1H1xXbn+OxUQduZMFdLKTzX+3gE3apSsFnX8d88uLZ/jTHRUWD8H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=LMJSxs8u; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3bfd40ff56fso580753b6e.2
        for <bpf@vger.kernel.org>; Wed, 07 Feb 2024 13:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1707341990; x=1707946790; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5Bo+rUlNDVzlryYbG3bVCAl8cdRpvlaWBhWYb2fuEds=;
        b=LMJSxs8uZKIfezl4Bqj9qoCc++c38gET9Hy9APUCq6XMDIoVJvzoNpMCGPrtkyqjpP
         ZfNLGrtVPf+zw05Qt9uOeuhGbqVmBSAyUYiB/m+SV1I5aYruU0iDZ/Ok5wJZyuYAy2re
         dESCOfAsD2SDJt59a/wx8bP4634qwbq/gJ4z4ZDFEn2zao5c+1aGvnVaI13POHVqVX24
         XpKL42w1oQ9zazdQGZA/Mvn/ElwbvoI64i6DZL7AZrlHm/uTMcujnDlhaLdvBhmvvvy1
         N8l4+Qc6i/SmOKpAM3ieFKV27+x0aISaTm4gXAkUYZazd3yh7pvGEZfOSk1GeYVRvX5q
         Lj6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707341990; x=1707946790;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5Bo+rUlNDVzlryYbG3bVCAl8cdRpvlaWBhWYb2fuEds=;
        b=tWxUUt9gnLon+IywhEibqwsp41F/qoujaKLn+99d+OW3YYlhs0xuGeERkb4WfvbdpF
         eiAoOqmyWJU1fr8ZKj1KrgY5/0ajn+z9U5yA2KWuSOzWBEEiRK61JIlLCGQGhy4nnXHm
         EopRGpF6AEmhQhDtIF5iY8aQWK6B+NUx7hgrDRoF2ZrZoWLzAtB4q4/Bnt3kMGKWOKCL
         UpfUa04zDKjCCRkdxKZIF/rQf5MV5SZiyqgzgp3rY5r1Mrx1n7opZVtl0fnepKi6D/To
         8IPYfUTNPeJTGW83u6+Vp+KBa/Yf6CgGUgrdeCJdd4gx/RmfbcePDsK8gNY6vTC+AvTT
         JEhw==
X-Gm-Message-State: AOJu0YyHJbqYAny+6GEUthOQG3yBp3T2gwaeX3fHLU+RSMOElIberemH
	5jtTJby42AogX8mU0TKE8uA+L5ogpE9D3VVfJf3WbT5TY2ED1+ybQul2qelw18w=
X-Google-Smtp-Source: AGHT+IFJ2/65DlJHKzesOI873fE3l0W3hSRAytYkTEHkdWUFjrpER/eIh9GjviHOZtrYTRdPCfjL4Q==
X-Received: by 2002:a05:6808:130f:b0:3bf:ce31:6019 with SMTP id y15-20020a056808130f00b003bfce316019mr8907514oiv.34.1707341989980;
        Wed, 07 Feb 2024 13:39:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWYRP0J0EzV0FHIgF8bKHOUNzZiUTcaLdu6u4FX9XW657G1qcqpZ63sOiD12LUhuXJJy/XfS66YSQQUbzc=
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net. [67.170.74.237])
        by smtp.gmail.com with ESMTPSA id d26-20020a05680808fa00b003bed4bba856sm343797oic.13.2024.02.07.13.39.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Feb 2024 13:39:49 -0800 (PST)
From: dthaler1968@googlemail.com
X-Google-Original-From: <dthaler1968@gmail.com>
To: "'bpf'" <bpf@vger.kernel.org>,
	<bpf@ietf.org>
Subject: ISA document title question
Date: Wed, 7 Feb 2024 13:39:47 -0800
Message-ID: <134701da5a0e$2c80c710$85825530$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdpaDivXny4Y9ENcR/Cft79/6KPXPQ==
Content-Language: en-us

The Internet Draft filename is draft-ietf-bpf-isa-XX, and the charter has:
> [PS] the BPF instruction set architecture (ISA) that defines the
> instructions and low-level virtual machine for BPF programs,

That is, "instruction set architecture (ISA)", but the document itself has:
> =======================================
> BPF Instruction Set Specification, v1.0
> =======================================
>
> This document specifies version 1.0 of the BPF instruction set.

Notably, no "architecture (ISA)".   Also, we now have a mechanism
to extend it with conformance groups over time, so "v1.0" seems
less relevant and perhaps not important given there's only one
version being standardized at present.

What do folks think about changing the doc to say:
> =======================================
> BPF Instruction Set Architecture
> =======================================
>
> This document specifies the BPF instruction set architecture (ISA).
?

Dave


