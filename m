Return-Path: <bpf+bounces-76472-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64680CB6894
	for <lists+bpf@lfdr.de>; Thu, 11 Dec 2025 17:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9F9FC3007D8D
	for <lists+bpf@lfdr.de>; Thu, 11 Dec 2025 16:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF91316909;
	Thu, 11 Dec 2025 16:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ku2r8suq"
X-Original-To: bpf@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3133176FD;
	Thu, 11 Dec 2025 16:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765471468; cv=none; b=lsV8b/Atb4rdKK3ScIGrqRHE5dnyZur3NIqm+WfL47WgTWgH0HFIqgA8paEg5Ee8m6qcLE/2+WRJv4VpLAlKZusIPsU1hMhETt2ApdqIRCfZ5lIJL2hMs8Z6xUlR0Eg4tLRAnLmR3rhWisSjiYM0aN8tQXbIbSiMFvIkGF1LviI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765471468; c=relaxed/simple;
	bh=luioV9jG0x+ycdC+qgtQZCGwgcgS7N5p6F+2UgMJzCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oQAcnBsrcxblOI+UUxP8oAL80bucLluFHo4Vbpq/xaxBsEBNksp3OAiTDaC/th60zemHoRVtQgrpMw/njyRRyDQ9eRjKDLUJO9bIaCUGE86cFzsstrgf+4S1cxogfEIBjeJTJv3nyqxrje2/qNXpXQuAS3CyvfPtUIECWLNPWEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ku2r8suq; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
	bh=CCU5QQvpgAQXCoq5PAzW0VB8nAnsNlX74NC79cYvzj8=; b=Ku2r8suqWdh6/o0Z7AnIZIYnWC
	580e32nU/rrRKCWn66Kgv++gEZjDfMja1PSru3b3VEG44adj4gmGpYfom/w37SptyGF9g+eWxv6It
	K0c2xscUPvoWqBwUtBj/YOgB0WYFS021Vb/SVg6Lqo7BGunhCbrYjlyO4p2lrXljXKqnHec4sqQQ8
	3W5gupQvegFsogm4CHuUIsPwio7/zl9b+6OMmVg0MPLDW7uDw9WSyGc+vUgtMqsWoZb9CchXMBfDm
	LagiBas7jSjDRzx1v9saSD6KCqybIJ5OtcpLVQfVcaWBwHKdIGWHpZKVitH2mo7X7K5SN2j8/pOAQ
	5N6W7mvA==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTjm3-0000000Gz6Z-3OXY;
	Thu, 11 Dec 2025 16:44:15 +0000
Message-ID: <0deb4a78-20fd-4336-930d-46ba26549489@infradead.org>
Date: Thu, 11 Dec 2025 08:44:12 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 06/11] crypto: pkcs7: add ability to extract signed
 attributes by OID
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>,
 Jonathan Corbet <corbet@lwn.net>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 "Dr. David Alan Gilbert" <linux@treblig.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 James.Bottomley@HansenPartnership.com, dhowells@redhat.com,
 linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20251211021257.1208712-1-bboscaccy@linux.microsoft.com>
 <20251211021257.1208712-7-bboscaccy@linux.microsoft.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251211021257.1208712-7-bboscaccy@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/10/25 6:12 PM, Blaise Boscaccy wrote:
> From: James Bottomley <James.Bottomley@HansenPartnership.com>
> 
> Signers may add any information they like in signed attributes and
> sometimes this information turns out to be relevant to specific
> signing cases, so add an api pkcs7_get_authattr() to extract the value
> of an authenticated attribute by specific OID.  The current
> implementation is designed for the single signer use case and simply
> terminates the search when it finds the relevant OID.
> 
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> ---
>  crypto/asymmetric_keys/Makefile       |  4 +-
>  crypto/asymmetric_keys/pkcs7_aa.asn1  | 18 ++++++
>  crypto/asymmetric_keys/pkcs7_parser.c | 87 +++++++++++++++++++++++++++
>  include/crypto/pkcs7.h                |  4 ++
>  4 files changed, 112 insertions(+), 1 deletion(-)
>  create mode 100644 crypto/asymmetric_keys/pkcs7_aa.asn1

Hi,
Your patches from James, Paul, etc., are missing your
Signed-off-by: line.

-- 
~Randy


