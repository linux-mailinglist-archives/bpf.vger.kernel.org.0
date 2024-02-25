Return-Path: <bpf+bounces-22706-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E438862C90
	for <lists+bpf@lfdr.de>; Sun, 25 Feb 2024 20:21:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D69DBB20ECE
	for <lists+bpf@lfdr.de>; Sun, 25 Feb 2024 19:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1CF18EA2;
	Sun, 25 Feb 2024 19:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="kE6OKCVf"
X-Original-To: bpf@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2943211;
	Sun, 25 Feb 2024 19:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708888873; cv=none; b=PIL3gaDL9AxwKvubZDxtfsFCjBe1pXoSeROeQKSK9VUCNzsXjvF7eNhGHCqRtiTK0GIrtbeigmM072dCZI7JUzX91KHlGJog54NjxKlEpDeISpSwCYCcJpQu9pEzinBnKP4RwcDA8gEgJXEnE8IXBpQ4agRel4xlAeskytUme1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708888873; c=relaxed/simple;
	bh=rrAT4rFu4smIAZj32TWPlmxx4U1g/H7Bh2KKM+/G+eo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U/JMfXwv5Sho2y3gcu4GKmgT9n2Fg6xDvQjM8ROMEwiaRhcbla/Ql5mO0zWf9gDDtVkgC9Bc9yCcCwNqvioAgRBLiFcg4RVDaIHIgekr2xJTZDc/NzH2xgKd57NHbDJLVbbSHHOxviEEZ4Dr4auP2lsiyBYB7aZiX6zPuB9OyHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=kE6OKCVf; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=NR36v4rk5vaVw4rsMd0szl+As6U9bET7cOj8TCFDyNM=; b=kE6OKCVfsmTqg730pZP/QKRBH7
	0ovgABvlV9qsmD6PzXigkiTZiQYIgCsVqYdxzjmcMXUoOCctPfL4btWhlc9CawYukpt5vySnkpXD9
	ygY7jNkMrF9tk2xpAhqGyC6J4u6mqEuO4fcu0fEnrzUZIulzBnoc62gdRUpjvwf+CAjdSAAO8EV6a
	HwN8GjrpujEo5JT2Qz4Yx4gFPPakKBIP6qVaPUgJRR7KXVk+G99LCHLtRUuwEwQpt1OS3maTq3puW
	JPhyNkRlz5zacRy6ZkqaX2r2AL6xX3jPvjAPDOC42TfRmbQBZQPBlguJvX8wwlcXNSNsRzsB5dZiW
	U7TZRh6g==;
Received: from [187.90.173.251] (helo=[192.168.1.60])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1reJmy-003LxR-8t; Sun, 25 Feb 2024 20:03:52 +0100
Message-ID: <aa25173c-6be0-5533-67d7-ea46648f1860@igalia.com>
Date: Sun, 25 Feb 2024 16:03:44 -0300
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [syzbot] [mm?] BUG: unable to handle kernel paging request in
 copy_from_kernel_nofault
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, "x86@kernel.org" <x86@kernel.org>,
 Jann Horn <jannh@google.com>, Daniel Borkmann <daniel@iogearbox.net>,
 Alexei Starovoitov <ast@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Borislav Petkov <bp@alien8.de>, John Fastabend <john.fastabend@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, bpf <bpf@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
 "luto@kernel.org" <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>
References: <87r0jwquhv.ffs@tglx>
 <c4c422ac-d017-9944-7d03-76ad416b19a4@igalia.com>
 <CAADnVQ+9vTBj9GgxotLF0_oV7cNFRebmcq_DNUm+cRJHQXCz1Q@mail.gmail.com>
 <85cdc364-e19f-625a-16e4-4efc6451fc7d@igalia.com>
 <CAADnVQKYu5RXGwq3rCJfzGq5AA-msdgBu4gA0tY0ASGXnXu0Hg@mail.gmail.com>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <CAADnVQKYu5RXGwq3rCJfzGq5AA-msdgBu4gA0tY0ASGXnXu0Hg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/02/2024 22:11, Alexei Starovoitov wrote:
> [...]
> 
> Correct.
> Please double check with your two syzbot tests.

Thanks for confirming!

Tested the fixes both for 5.15.y and 6.1.y - working fine =)
Cheers,


Guilherme

