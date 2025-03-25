Return-Path: <bpf+bounces-54629-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A04A6F0DC
	for <lists+bpf@lfdr.de>; Tue, 25 Mar 2025 12:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B09961691FC
	for <lists+bpf@lfdr.de>; Tue, 25 Mar 2025 11:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DE2255E2C;
	Tue, 25 Mar 2025 11:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qmon.net header.i=@qmon.net header.b="r3FoCtrO"
X-Original-To: bpf@vger.kernel.org
Received: from outbound.soverin.net (outbound.soverin.net [185.233.34.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9586816A395;
	Tue, 25 Mar 2025 11:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.233.34.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742901359; cv=none; b=RiRGfnGNgJ+dV3umT6GgdPTb9KGp3nRAvztzAxmx8BqVFMo8nnH7MPFeca1g9NXKlLJ/WaUX+F6VYcrTyZ4SbIUOfzM4aw42YUPlurUlpAoUBArub6GRVw8lqMr2sGzj/eCA53Fc42w2nTnMWnaUB8gKiRzHBTj8YcGLkpvb1do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742901359; c=relaxed/simple;
	bh=bTLjwuVyybm/I/wCHz+nDM/wvGZp90Vk4U3oPodejdg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qxdwwBRvOAaAlpyTlAmT62giVv0zXbiImXpgO1bZZPav7k/8aUYGeKydv2DOfncDtINGGAQLSUzkTlBluCxTqBDxLWmTE2vGhxlDH9PLfdABGU+/gz9+GYd1cQtSBrdyl/yZy8j2g90fSVZ4JciNQuwD9H/Nv342vOQHy+onCAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qmon.net; spf=pass smtp.mailfrom=qmon.net; dkim=pass (2048-bit key) header.d=qmon.net header.i=@qmon.net header.b=r3FoCtrO; arc=none smtp.client-ip=185.233.34.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qmon.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qmon.net
Received: from smtp.soverin.net (c04cst-smtp-sov02.int.sover.in [10.10.4.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by outbound.soverin.net (Postfix) with ESMTPS id 4ZMRyF59pSz5Y;
	Tue, 25 Mar 2025 11:09:25 +0000 (UTC)
Received: from smtp.soverin.net (smtp.soverin.net [10.10.4.100]) by soverin.net (Postfix) with ESMTPSA id 4ZMRyD4TSVzML;
	Tue, 25 Mar 2025 11:09:24 +0000 (UTC)
Authentication-Results: smtp.soverin.net;
	dkim=pass (2048-bit key; unprotected) header.d=qmon.net header.i=@qmon.net header.a=rsa-sha256 header.s=soverin1 header.b=r3FoCtrO;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qmon.net; s=soverin1;
	t=1742900965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cGOfD2XTG3f2KGCnBBCpnWBs5ydWIF56orN3h4fexfI=;
	b=r3FoCtrOdZY5uz3a4IWefaYR/yF9GCJwVwz6OPF/s3+iZQezt1m0luRyELbSFNh1oXjS3Y
	TenjkE7Pwl+to1A2eAgE1ZuFPvbXdKH0zUapeJsie8/v1M4fCtmCNVz/ljAbFwSluvla5V
	cUwZbqQJCvpCUyAvwKvjAWZa2PkZsbanYqQDP/o3hR+3A+niH8kRgZMqA07gp/OdgzzQeN
	SCpJAliHzTXy3L/ydV3sEdoh+2Ee9BD7WPcV7ulIgJFMM8L7crZUjWD6r02rbzO3UXbVDU
	x+Onj0gIaJ+s5ljhcJZwVRyZq1QimJrCZKV/nycNsBmjrrLMXmRWX0pBLcceZA==
X-CM-Envelope: MS4xfE9qJlPwytaJvqH5tq1m5QU56wWQBwUboh0Qh6Yd9gPG3SfGIEto9BX9dKfT5mpckLp6hdBINDG1q65gThfj8VIClkPgn3mJ+gwirrZuazommNFE7IVj f8pr3U4gUKXfDXH9/HS4vCY4QB+ycLV97kwbthBKcJKphbKv4/clwyNx5phT0PVdlrFynOx3BW/v61eZV/Xwy7uLbQMxLLUtDLTSjfKhjgcwBPENDF1iunsZ 1pa3vf8wIMJR9J6b86EksOEXARDZDDa7g5G4zoNAKMbUiwjQ/QQwruJlEGIGadx8Qjy/Zc0DUaxCp4hvLjZEC86gwgq6Qyd7qOwt8fM9r5Pui8OilCkRpakL lX70dETd699Ogy4m4MnbmpHYwqV7LS2PDeBBtr0av5iRrl0ov5xtVaXURGB1YSG39F2lLT4ddjq8wlBThQ79j39LTLOWoiBPH1FtOKaFBX+ZDVW+3IaxLxUU Ja4Pnl+rUa0s9ti265wJnrKHJ2lB7mLFXNtzyD9ihJLPqfDP1TQ6/6LxPcB6CYqgmljjQ3n37XnGLCwLZXwdrF03sYzpFs4G7j19BiP9cxfzPzmQ95pnNBg1 M28Bu9gKEAYQ23bly3Hd9ZqyEImn0l2S9+LJHcgo5DrdhvJKmLdHLv7lSZYEz6SL+1M=
X-CM-Analysis: v=2.4 cv=I7afRMgg c=1 sm=1 tr=0 ts=67e28ee5 a=vzOQIoBu8N4nb49veeH0EQ==:617 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VnNF1IyMAAAA:8 a=K2RAGah4TdK_Dg0oFeQA:9 a=QEXdDO2ut3YA:10
Message-ID: <8b0b2a41-203d-41f8-888d-2273afb877d0@qmon.net>
Date: Tue, 25 Mar 2025 11:09:24 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [linux-next-20250324]/tool/bpf/bpftool fails to complie on
 linux-next-20250324
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
 Saket Kumar Bhaskar <skb99@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>, bpf <bpf@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org,
 jkacur@redhat.com, lgoncalv@redhat.com, gmonaco@redhat.com,
 williams@redhat.com, tglozar@redhat.com, rostedt@goodmis.org
References: <5df6968a-2e5f-468e-b457-fc201535dd4c@linux.ibm.com>
From: Quentin Monnet <qmo@qmon.net>
Content-Language: en-GB
In-Reply-To: <5df6968a-2e5f-468e-b457-fc201535dd4c@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spampanel-Class: ham

2025-03-25 16:02 UTC+0530 ~ Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Greetings!!!
> 
> 
> bpftool fails to complie on linux-next-20250324 repo.
> 
> 
> Error:
> 
> make: *** No rule to make target 'bpftool', needed by '/home/linux/
> tools/testing/selftests/bpf/tools/include/vmlinux.h'. Stop.
> make: *** Waiting for unfinished jobs.....


Thanks! Would be great to have a bit more context on the error (and on
how to reproduce) for next time. Bpftool itself seems to compile fine,
the error shows that it's building it from the context of the selftests
that seems broken.


> Git bisect points to commit: 8a635c3856ddb74ed3fe7c856b271cdfeb65f293 as
> first bad commit.

Thank you Venkat for the bisect!

On a quick look, that commit introduced a definition for BPFTOOL in
tools/scripts/Makefile.include:

	diff --git a/tools/scripts/Makefile.include .../Makefile.include
	index 0aa4005017c7..71bbe52721b3 100644
	--- a/tools/scripts/Makefile.include
	+++ b/tools/scripts/Makefile.include
	@@ -91,6 +91,9 @@ LLVM_CONFIG	?= llvm-config
	 LLVM_OBJCOPY	?= llvm-objcopy
	 LLVM_STRIP	?= llvm-strip
	
	+# Some tools require bpftool
	+BPFTOOL		?= bpftool
	+
	 ifeq ($(CC_NO_CLANG), 1)
	 EXTRA_WARNINGS += -Wstrict-aliasing=3

But several utilities or selftests under tools/ include
tools/scripts/Makefile.include _and_ use their own version of the
$(BPFTOOL) variable, often assigning only if unset, for example in
tools/testing/selftests/bpf/Makefile:

	BPFTOOL ?= $(DEFAULT_BPFTOOL)

My guess is that the new definition from Makefile.include overrides this
with simply "bpftool" as a value, and the Makefile fails to build it as
a result.

If I guessed correctly, one workaround would be to rename the variable
in Makefile.include (and in whatever Makefile now relies on it) into
something that is not used in the other Makefiles, for example
BPFTOOL_BINARY.

Please copy the BPF mailing list on changes impacting BPF tooling (or
for BPF-related patchsets in general).

Thanks,
Quentin

