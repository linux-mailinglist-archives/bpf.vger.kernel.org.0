Return-Path: <bpf+bounces-76487-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 14469CB71FB
	for <lists+bpf@lfdr.de>; Thu, 11 Dec 2025 21:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73E5E3028E57
	for <lists+bpf@lfdr.de>; Thu, 11 Dec 2025 20:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1138531A553;
	Thu, 11 Dec 2025 20:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ejUvQZ0u"
X-Original-To: bpf@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1023192B75;
	Thu, 11 Dec 2025 20:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765483652; cv=none; b=t0eQkjz0PVhjO3uJyN/KzKmLRD8jnHULzGGhqdv0/b45yECEV+sAcv02J+6hy8dzUZ6e5F4/JmOeTDmVUvyD5U2qYD78hN3Uoh995Ru4UNlnnK134iHvZokrp/1AQmmJGup2vaqA0sJi8NIM4Y0PwhpxC82yTVj0DO9IzClIHBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765483652; c=relaxed/simple;
	bh=nwEtSzoWdQCqAhT1d6k30xO9WYye85wdxc155XDH4dQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DXJruTUetGHoFKcoInpTrN4VoUkeGj94Y+qHXC7KmycW+7oGKBRlmpeLie/mS21FJuSN3mGDQcn+7Mq/8THjs5TAGgbU9VRB653kO9tQl3eGAHV6rm69l9RN/KlX6f1fQv0zV0geX7LCyOP3vNUtRTqPH/IZ6cTSn2jDvUpuJiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ejUvQZ0u; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
	bh=JUiYwqBQsrLJjctTG3xhmoacDmlSDDxQQ2A0MBpDNcY=; b=ejUvQZ0u7psCummZuhrynAYYFk
	bBIfP4+AK/Y1h5whO9Rv1/wSuoTUVjzGDG+DtjXkUIW2ZZVwFrY3of+cnkwVLZosHwtsyG9khav6T
	ak8DhdokTJJJMdYYZ/Tkf+xBgq450fEVv+eBD+vsSvYHalBK6LrBx8d7DP+0hFfWwU+PqzehTBMZw
	dxb366APIX5rn9I0xgw8gYsx7KQuKgT1grqJLgcXr+pG8uh5QHOUH1a7QgvRjcnacCycCyaE24aJ6
	ov8rU/L3wwD/ieWlha7WaVfWcmiZshV7eiflehARr9sjLoKwkeRQtDmuxq369HxIMnlG4/GPzI/mp
	EZtmqmVg==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTmwa-0000000HCam-18BG;
	Thu, 11 Dec 2025 20:07:20 +0000
Message-ID: <f7e997ac-2312-4d18-96d7-d6abb190a5c3@infradead.org>
Date: Thu, 11 Dec 2025 12:07:16 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 08/11] security: Hornet LSM
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
 <20251211021257.1208712-9-bboscaccy@linux.microsoft.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251211021257.1208712-9-bboscaccy@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/10/25 6:12 PM, Blaise Boscaccy wrote:
> diff --git a/Documentation/admin-guide/LSM/Hornet.rst b/Documentation/admin-guide/LSM/Hornet.rst
> new file mode 100644
> index 0000000000000..0fb5920e9b68f
> --- /dev/null
> +++ b/Documentation/admin-guide/LSM/Hornet.rst
> @@ -0,0 +1,38 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +======
> +Hornet
> +======
> +
> +Hornet is a Linux Security Module that provides extensible signature
> +verification for eBPF programs. This is selectable at build-time with
> +``CONFIG_SECURITY_HORNET``.
> +
> +Overview
> +========
> +
> +Hornet addresses concerns from users who require strict audit
> +trails and verification guarantees, especially in security-sensitive
> +environments. Map hashes for extended verification are passed in via
> +the existing PKCS#7 uapi and verifified by the crypto

                                verified
and preferably         UAPI

> +subsystem. Hornet then calculates the verification state of the
> +program (full, partial, bad, etc) and then invokes a new downstream

                                etc.)

> +LSM hook to delegate policy decisions.
> +
> +Tooling
> +=======
> +
> +Some tooling is provided to aid with the development of signed eBPF
> +light-skeletons.
> +
> +extract-skel.sh
> +---------------
> +
> +This shell script extracts the instructions and map data used by the
> +light skeleton from the autogenerated header file created by bpftool.
> +
> +gen_sig
> +---------
> +
> +gen_sig creates a pkcs#7 signature of a data payload. Additionally it
> +appends a signed attribute containing a set of hashes.

-- 
~Randy


