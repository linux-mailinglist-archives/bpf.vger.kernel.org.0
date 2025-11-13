Return-Path: <bpf+bounces-74359-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44187C56605
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 09:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE7883B9F35
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 08:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5711833344D;
	Thu, 13 Nov 2025 08:51:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from psionic.psi5.com (psionic.psi5.com [185.187.169.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279543321B1;
	Thu, 13 Nov 2025 08:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.187.169.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763023915; cv=none; b=i/6/aPWUw0U4ZYFGH3TynJRsdz7duHeJrPX9qq/dTM4B48DHWTAF79mXOjBeZM6v0CZ1+Q3z1U39XOKWH44J8jEgPyaw/fPUzFJFAMzGvtk9J4ih5g1IEUsvM9Ecr6FeTFwaJoi34hs0Nc3t8aYOZyLifhQQRNwXjwRvPy2kQFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763023915; c=relaxed/simple;
	bh=S7pPfWGZ4EjCWlRERtwP+Fbc/6nDLBdMUBB2WFHYGxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pc53ZABa7yW41pEZTz7RroH5Rh8UpLAc0EZC01U0g6pRH1PtdfFEeb5gehJfL2d1HHdBn5qGju+1pMTZDbJhRE5tik3L5ADL6ZvVaBaiGlue9DV9oJcvFS9EiL502pZEgxKB4or3v3EdDJz9Gx/tAHvUFKxjiclZINz2VSFMrAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de; spf=pass smtp.mailfrom=hogyros.de; arc=none smtp.client-ip=185.187.169.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hogyros.de
Received: from [192.168.10.94] (unknown [39.110.247.193])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by psionic.psi5.com (Postfix) with ESMTPSA id 614A23F072;
	Thu, 13 Nov 2025 09:51:39 +0100 (CET)
Message-ID: <c4028d3f-69f1-47f2-bd76-f9f5fb432fb7@hogyros.de>
Date: Thu, 13 Nov 2025 17:51:36 +0900
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next v2] lib/bpf_legacy: Use userspace SHA-1 code
 instead of AF_ALG
To: Ard Biesheuvel <ardb@kernel.org>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: Eric Biggers <ebiggers@kernel.org>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-crypto@vger.kernel.org
References: <20250929194648.145585-1-ebiggers@kernel.org>
 <20251112121212.66e15a2d@phoenix>
 <CAMj1kXEM62YLP2oLEA447hCFidTqE0E76XrTO02B373=sa0Jkw@mail.gmail.com>
Content-Language: en-US
From: Simon Richter <Simon.Richter@hogyros.de>
In-Reply-To: <CAMj1kXEM62YLP2oLEA447hCFidTqE0E76XrTO02B373=sa0Jkw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 11/13/25 4:25 PM, Ard Biesheuvel wrote:

> Also, I strongly agree with Eric that a syscall interface to perform
> crypto s/w arithmetic that could easily execute in user space is
> something that should have never been added, and creates portability
> concerns for no good reason.

Would it make sense to add crypto (and other transform) operations to 
the vdso, and make the decision whether the syscall is beneficial from 
there, depending on request/batch size (speed vs overhead tradeoff), 
data source/sink and available hardware?

For example, "gzip -d" pulling data from a file and writing to a file 
will need to transfer the data to userspace first, process it there, 
then transfer it back to kernelspace so it can be written to a file.

That's a lot of syscall and transfer overhead compared to just a single 
"decompress this file" call that keeps the data entirely in kernelspace 
-- so we benefit already even if there is no hardware gzip decompressor, 
and users that have one (such as myself) would benefit even further.

    Simon

