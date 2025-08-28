Return-Path: <bpf+bounces-66908-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E14D4B3ACFA
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 23:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3AE0164D85
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 21:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C5E29A322;
	Thu, 28 Aug 2025 21:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ayggmNeQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361AE149C6F;
	Thu, 28 Aug 2025 21:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756417806; cv=none; b=nqxO5fpHjxUk20/1+B3bldDyDzTHGye1M+qFbN9hCmp09glkTgQ9NgisHSsU5OAIgCzldNPNtChv0aXIYf6oIJ8PAJNG19BVAVZ2zpS6U2nPqTH+4VobkSOQ7axOYRQWusu8xJv+cKgZBHRNlMcczFp7lMeBRN+UgYEAdh0D8nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756417806; c=relaxed/simple;
	bh=4Y4J6JquET82yYOKsdSO3p46GETUY7cRdw3zU1Y47NY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=JO9lpOwIO4+LnOnMO4BIgYwLTGtiolapo/5CE8N14vhO39SQU+y3MYGpDVezTh5p/4TYDqa+N5o82a/NJTqF6/gcRGeZuI9KWkJnBoA05QrR/DCON/JEvaKfw9qyvwwM+6+1vdtqjLbVeoYwcsASSV3XT+MhU1xiiak+6uNKOYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ayggmNeQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC5E5C4CEEB;
	Thu, 28 Aug 2025 21:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756417805;
	bh=4Y4J6JquET82yYOKsdSO3p46GETUY7cRdw3zU1Y47NY=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=ayggmNeQ6jWVzGfgIn3J/tTcKORg8NpOIes7vSK9PcFoCSm7fGwJ9Z45Qw6lRZPPr
	 u4gHCXlu35ra6ZobagPCDcaqbVTPOT9pH/zUrn9U5fP3I0lImCk5Muqpsc5xY0kfFC
	 NNcDAtGGg0iVVvAnz7IiWB4Q5qnqYh0/KzT0msk5KYibTUGl2PGHOKZyMu4F288ojh
	 0WAV2azFiI9yF2WoLKD4WPH0/1mFU2FDwoEpifsDjEjJbzVUeJDA0Ayj6shTzGN+wl
	 PXrnUDQxC5rRmsEcUbEAZ/htNtEY/eP4qVpA0dK2PIj4dB8cs/tpD0s2spOqt/FjYb
	 phE9JOxeiXRHA==
Message-ID: <b0cc6fef-2048-4798-881f-61ae0366b726@kernel.org>
Date: Thu, 28 Aug 2025 22:50:02 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Quentin Monnet <qmo@kernel.org>
Subject: Re: [PATCH v7 0/2] bpftool: Refactor config parsing and add CET
 symbol matching
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, chenyuan_fl@163.com
Cc: olsajiri@gmail.com, andrii@kernel.org, ast@kernel.org,
 bpf@vger.kernel.org, chenyuan@kylinos.cn, daniel@iogearbox.net,
 linux-kernel@vger.kernel.org, yonghong.song@linux.dev
References: <aKL4rB3x8Cd4uUvb@krava>
 <20250825022002.13760-1-chenyuan_fl@163.com>
 <CAEf4Bzb_3ac0dPnkuMqs-dCrTEWqjVt-fsGWGyHAai_bUxubNA@mail.gmail.com>
Content-Language: en-GB
In-Reply-To: <CAEf4Bzb_3ac0dPnkuMqs-dCrTEWqjVt-fsGWGyHAai_bUxubNA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2025-08-27 14:53 UTC-0700 ~ Andrii Nakryiko <andrii.nakryiko@gmail.com>
> On Sun, Aug 24, 2025 at 7:20 PM <chenyuan_fl@163.com> wrote:
>>
>> From: Yuan CHen <chenyuan@kylinos.cn>
>>
>> 1. **Refactor kernel config parsing**
>>    - Moves duplicate config file handling from feature.c to common.c
>>    - Keeps all existing functionality while enabling code reuse
>>
>> 2. **Add CET-aware symbol matching**
>>    - Adjusts kprobe hook detection for x86_64 CET (endbr32/64 prefixes)
>>    - Matches symbols at both original and CET-adjusted addresses
>>
> 
> Quentin, can you please take a quick look at this patch set, when you
> get a chance? Thanks!


Yes! Both patches look good to me. For the series:

Acked-by: Quentin Monnet <qmo@kernel.org>

Thanks for this work

