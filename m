Return-Path: <bpf+bounces-21437-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8841C84D579
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 23:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB66EB2436E
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 22:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D161384AE;
	Wed,  7 Feb 2024 21:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="HxV3jL0v";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="nDTaDaky";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Vms32Ua+"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE11E12F5B0
	for <bpf@vger.kernel.org>; Wed,  7 Feb 2024 21:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341998; cv=none; b=I+OGk5zYR5Lm6wkF8O5zgcajLnJ57+LrYFqUvPKDpcb2VZR7pWgqDDaz5T8kjW1fCtSx61aiKat6Ktv0Ltcat62PzyinSl79MrpeRmFC0uP2PTa0hOSsjCQqUKX+W2Musy50ny1U4GmYJHjVvlgREeAHh3mXHqxmTkPLi0yBpII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341998; c=relaxed/simple;
	bh=8mepsUtPkYOSTzxEdBWUq87crislJyuRYSTcVq6qbGk=;
	h=To:Date:Message-ID:MIME-Version:Subject:Content-Type:From; b=PKo0llBjVW+Hem/WK8pMm23mDowTs5XWMGQOEAeNrJ2gC5LKTYYBIday8CgLVD23ZNv1AWMgqFMuT3ZVvXT+wGnnOe8HFA03IiEgnIM0DVy1ES1AQ+VmvWzA+5UKji4giScXcWC5VDsPpCjEVm1D2zanmvasWeKL9ApFGarTZPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=HxV3jL0v; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=nDTaDaky reason="signature verification failed"; dkim=fail (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Vms32Ua+ reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 1CC44C151086
	for <bpf@vger.kernel.org>; Wed,  7 Feb 2024 13:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1707341996; bh=8mepsUtPkYOSTzxEdBWUq87crislJyuRYSTcVq6qbGk=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From;
	b=HxV3jL0vMayaf0YVzweXG2L1Z/K67GA+VhYQzrXiRn00gVUo1vTWaH1DVfhWwJlAO
	 8R6gwktBeKd3IkXbaO6mKCsg528kK0Gj3S3hsLQnItiKcNygmmRP4kBS9ootDS7qua
	 5r8rFezWxorfUz/wuh2YlZVmbZX8f8AlkXiadpCY=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id DD8A7C14F73F;
 Wed,  7 Feb 2024 13:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1707341995; bh=8mepsUtPkYOSTzxEdBWUq87crislJyuRYSTcVq6qbGk=;
 h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
 List-Post:List-Help:List-Subscribe;
 b=nDTaDaky9tuQ2K2Rs0EZxv81eZz2bBMYFPJkFSMhZIbUlJWQFCafbRtQ3wI4gcejK
 kooAcCoa30l7Cax2RYjjsrKFT8L4JRoWKiMmEL9RJSZDCSSGT2aTCw9MlkUqdTMoX+
 YgVcLk6i8A7FBOsZCRDeOgqPX/9GbaPeRAlH2eZw=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 4E703C14F73F
 for <bpf@ietfa.amsl.com>; Wed,  7 Feb 2024 13:39:55 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -6.855
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=googlemail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TPmpHYBTAKdh for <bpf@ietfa.amsl.com>;
 Wed,  7 Feb 2024 13:39:51 -0800 (PST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 81822C14F6F7
 for <bpf@ietf.org>; Wed,  7 Feb 2024 13:39:51 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3be6df6bc9bso702394b6e.0
 for <bpf@ietf.org>; Wed, 07 Feb 2024 13:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1707341990; x=1707946790; darn=ietf.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=5Bo+rUlNDVzlryYbG3bVCAl8cdRpvlaWBhWYb2fuEds=;
 b=Vms32Ua+bEgcCl6ipNcE8whUjzDGoJDz+S1M9aNf98lhpf9B4ETH/RyaVzooHDDrFo
 9FRi9sjRXO85ZdlwmgKpCOov0IzbIj0K68zXcT8zQC1rS7Io87Njx1PQ4NzcKiv453Yb
 JXgoz/QUsGEywmava5VtoAuOhIXtN+8/bJscVitqj3ovvRjq0PmzR64yUBH2smmWk5+K
 liKHaANjbS8Oe49LcJHalvE3LVV0YkxRSOmHN+FqLJ651EAVDEpK38CDoNaN3X69317S
 2gybKJyc7rcWJYpSUHroXERhTKvRDKKHrbDlIZucP6eHgv2rpw8uhyjibzzp9LVjodnH
 Fyqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707341990; x=1707946790;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:to:from:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5Bo+rUlNDVzlryYbG3bVCAl8cdRpvlaWBhWYb2fuEds=;
 b=NXeN6QvZfVtokDaErpaCCz8o53ISlreBHLUezOWhv0hFhrKw1TRK/Z1RQ/m/swfNH3
 35VFDyx8jZnYVrIzKa76j63zSRnU8OcrKXUdSsgtcXfJaK0fxrryCc87oUaOoQXmMmbH
 Rv/oqfFdlnw92vKsztyvM07xaGAqn48rmlTn2cG6t21Xc2h7JWGj4Ay8knUaeUHdzEvy
 sw4OVHbk+zt99Y71E5YJv7PF4ZcGRvbjKLXqAr2g/6d+HhB06Wd8aWVA62fhV+AHAzhv
 +d7mOWoXMhKV4WO6aW4i3OfsLQM8lFA9C9Cw8i4irel3MFh4+rXObI3n4SLTGRTyYfsq
 z1aA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXyqHLgWyYnLky/wUgd0MVH+ZIcK0+20EAD+9e6pehjynfv/5dlZbaACcipR1lAbOXSU2d6F4awPcUIuw=
X-Gm-Message-State: AOJu0YxKIXUb8Le+Fy8YfSF/TMdHFAnm7NRRsdlw5Iq4qnLpKly4ZWs+
 ov903N0MHKlqBkg/KlJq7lCpS70ZMvm7AZMkg0BHuFUzecCxf5DJkqCrZLxbmAA=
X-Google-Smtp-Source: AGHT+IFJ2/65DlJHKzesOI873fE3l0W3hSRAytYkTEHkdWUFjrpER/eIh9GjviHOZtrYTRdPCfjL4Q==
X-Received: by 2002:a05:6808:130f:b0:3bf:ce31:6019 with SMTP id
 y15-20020a056808130f00b003bfce316019mr8907514oiv.34.1707341989980; 
 Wed, 07 Feb 2024 13:39:49 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWYRP0J0EzV0FHIgF8bKHOUNzZiUTcaLdu6u4FX9XW657G1qcqpZ63sOiD12LUhuXJJy/XfS66YSQQUbzc=
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net.
 [67.170.74.237]) by smtp.gmail.com with ESMTPSA id
 d26-20020a05680808fa00b003bed4bba856sm343797oic.13.2024.02.07.13.39.49
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 07 Feb 2024 13:39:49 -0800 (PST)
X-Google-Original-From: <dthaler1968@gmail.com>
To: "'bpf'" <bpf@vger.kernel.org>,
	<bpf@ietf.org>
Date: Wed, 7 Feb 2024 13:39:47 -0800
Message-ID: <134701da5a0e$2c80c710$85825530$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdpaDivXny4Y9ENcR/Cft79/6KPXPQ==
Content-Language: en-us
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/SEpn3OL9TabNRn-4rDX9A6XVbjM>
Subject: [Bpf] ISA document title question
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

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

