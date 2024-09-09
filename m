Return-Path: <bpf+bounces-39232-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8BFE970E08
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 08:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8E1B1C21E39
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 06:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2CC1AD9C8;
	Mon,  9 Sep 2024 06:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="nVviHyVz"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8921AD41C
	for <bpf@vger.kernel.org>; Mon,  9 Sep 2024 06:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725864046; cv=none; b=ZKSJve2ESjQy5/HPXGYISCKgi4WsBfYIpVFkHyHyU/aMYmTJhymU8xwV2TmjM3l1wRNFXHJkHRVZC8SEcrgKez1VpDvqt4u7tEbsCRbe6Ua3FsQmHYd4g1A+VMTJTiceEzeTH7yoqBaMcwsUmTRQBWuJiOFq/UczjiAK4pOZEjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725864046; c=relaxed/simple;
	bh=mEw3DnDDLCzhLTnjoacLWZfDclvHLQ/0ndhRPj4jGCk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Lfpi+29kt+6QSMRzHfjc81xUFcnVG0XXqHiH/dI2ZcxJvLnTAJnA0YleYRuCc0OmJXHMaFUqW6iXFqlzenxiSeTrGcbAPBN8CGhb6Uc7TS0qzPgMSp9c4NNgZTzZtRGw4eYHy2EU+oXlqYC4Ez87N/9M9fH3sVCHZQkhrvsaaE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=nVviHyVz; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1725864041;
	bh=54hk2p1maVgXQGJ3OCTm/U8cy6tgPAEmLuVVz391iHU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=nVviHyVzOyVlcqiWLb3rMH2A3l1O6yWQ2EVNz2VEuO+gROFJSG1/r2Jl/AsEYi5OS
	 i2BlJvetLug6p0fnUHcWF3M/8RD0tl4TaBPUIFZTQegTVqe2f8V+OwqSyJcDFRxpCu
	 PGYj0zANfKph1R3WT0qloWqM9iqTHqXd3nbSLgCl2MVSYChxR+M+mRyCEDHUE5rwRQ
	 DbpJ7YJBPKr7ayyiodxjDeJ0Dzv5RXB4+hjHf6T2CUjdCGIv8yIUGaTHyB6aK7OTgs
	 vMWqvQ4uyrIcC3DfPM1iAIbna5ixSY/6XlV3y9F4t+NArrsLPA5l2acZApxA0xB0Ca
	 +woBzfoTxo4tg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4X2HK55bS3z4w2F;
	Mon,  9 Sep 2024 16:40:41 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Masami Hiramatsu <mhiramat@kernel.org>, Michael Ellerman
 <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Abhishek Dubey <adubey@linux.ibm.com>,
 naveen@kernel.org, hbathini@linux.ibm.com, npiggin@gmail.com,
 mhiramat@kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v4 RESEND] powerpc: Replace kretprobe code with rethook
 on powerpc
In-Reply-To: <20240908221053.ad2ed73bf42db9273aac419c@kernel.org>
References: <20240830113131.7597-1-adubey@linux.ibm.com>
 <172562357215.467568.2172858907419105155.b4-ty@ellerman.id.au>
 <20240908221053.ad2ed73bf42db9273aac419c@kernel.org>
Date: Mon, 09 Sep 2024 16:40:41 +1000
Message-ID: <87bk0x49ee.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Masami Hiramatsu (Google) <mhiramat@kernel.org> writes:
> On Fri, 06 Sep 2024 21:52:52 +1000
> Michael Ellerman <patch-notifications@ellerman.id.au> wrote:
>
>> On Fri, 30 Aug 2024 07:31:31 -0400, Abhishek Dubey wrote:
>> > This is an adaptation of commit f3a112c0c40d ("x86,rethook,kprobes:
>> > Replace kretprobe with rethook on x86") to powerpc.
>> > 
>> > Rethook follows the existing kretprobe implementation, but separates
>> > it from kprobes so that it can be used by fprobe (ftrace-based
>> > function entry/exit probes). As such, this patch also enables fprobe
>> > to work on powerpc. The only other change compared to the existing
>> > kretprobe implementation is doing the return address fixup in
>> > arch_rethook_fixup_return().
>> > 
>> > [...]
>> 
>> Applied to powerpc/next.
>> 
>> [1/1] powerpc: Replace kretprobe code with rethook on powerpc
>>       https://git.kernel.org/powerpc/c/19f1bc3fb55452739dd3d56cfd06c29ecdbe3e9f
>
> Thanks, and sorry for late reply, but I don't have any objection.

Thanks. No worries. 

cheers

