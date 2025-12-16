Return-Path: <bpf+bounces-76766-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7F3CC524D
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 22:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A93FC302B780
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 21:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3A82D9EC4;
	Tue, 16 Dec 2025 21:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ryIHEgT2"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3866C12DDA1;
	Tue, 16 Dec 2025 21:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765918935; cv=none; b=kSrTJ5qA4lnTs04dc9VzHUzsJk+3LdeyYNtFCiGNq4p7WuY5NXnHQ+T5/qyOQg14G5RmrF98cNFyB+HBh8Tq7SQfJppMsV82hA20uK62TkPOg3BysR/f0vDYdPSBSNZSnNZZTsd6bo4EXqFj9Rst9kBaFBYGfn0aK70LIAVpoFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765918935; c=relaxed/simple;
	bh=meVBAdtu33shxgNOu6+kF0Cz6t+w4kKZ0df3LVi/XmI=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lFimnTYdFg84f8Alv9QuGSSE0MRAO93WUwg33UxuS1YG+3tG01k+LxcAL7OoiaxxI87LpP+q9onOES/yf8RXe8jHuqUf8caOH+gaUJEYssEoMcMsWpenCqLJyAnL9K6Ji8yjcrCxkgppTlNO8qCCLHriGIPPEriRI+8BKjsn52Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ryIHEgT2; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia (unknown [40.78.13.173])
	by linux.microsoft.com (Postfix) with ESMTPSA id 102BC200D63F;
	Tue, 16 Dec 2025 13:02:11 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 102BC200D63F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1765918933;
	bh=lB6FZIlqsRi5fFQ/DxgZiOZDsW0DVT1YbjP8D0ZEIxo=;
	h=From:To:Subject:In-Reply-To:References:Date:From;
	b=ryIHEgT2vh5nUir3eX374kzR0pAM/YBXkO8rk7UZ/OtY7OZV4m0naeuGdcHUcUUQZ
	 OjLQ4IjN+6QFS7ZbvmoLVloJA/+NxYIacGIECoDvRfjWyzNCUO0NAbxioK5KPDgnvk
	 Uq/wJ5xLrF2W6V12TDwyLOg5DGRzrVr+fkdZ72PY=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: Randy Dunlap <rdunlap@infradead.org>, Jonathan Corbet <corbet@lwn.net>,
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge
 E. Hallyn" <serge@hallyn.com>, =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=
 <mic@digikod.net>, =?utf-8?Q?G=C3=BCnther?=
 Noack <gnoack@google.com>, "Dr. David Alan Gilbert" <linux@treblig.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 James.Bottomley@HansenPartnership.com, dhowells@redhat.com,
 linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [RFC 08/11] security: Hornet LSM
In-Reply-To: <f7e997ac-2312-4d18-96d7-d6abb190a5c3@infradead.org>
References: <20251211021257.1208712-1-bboscaccy@linux.microsoft.com>
 <20251211021257.1208712-9-bboscaccy@linux.microsoft.com>
 <f7e997ac-2312-4d18-96d7-d6abb190a5c3@infradead.org>
Date: Tue, 16 Dec 2025 13:02:11 -0800
Message-ID: <87zf7igmy4.fsf@microsoft.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Randy Dunlap <rdunlap@infradead.org> writes:

> On 12/10/25 6:12 PM, Blaise Boscaccy wrote:
>> diff --git a/Documentation/admin-guide/LSM/Hornet.rst b/Documentation/admin-guide/LSM/Hornet.rst
>> new file mode 100644
>> index 0000000000000..0fb5920e9b68f
>> --- /dev/null
>> +++ b/Documentation/admin-guide/LSM/Hornet.rst
>> @@ -0,0 +1,38 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +======
>> +Hornet
>> +======
>> +
>> +Hornet is a Linux Security Module that provides extensible signature
>> +verification for eBPF programs. This is selectable at build-time with
>> +``CONFIG_SECURITY_HORNET``.
>> +
>> +Overview
>> +========
>> +
>> +Hornet addresses concerns from users who require strict audit
>> +trails and verification guarantees, especially in security-sensitive
>> +environments. Map hashes for extended verification are passed in via
>> +the existing PKCS#7 uapi and verifified by the crypto
>
>                                 verified
> and preferably         UAPI
>
>> +subsystem. Hornet then calculates the verification state of the
>> +program (full, partial, bad, etc) and then invokes a new downstream
>
>                                 etc.)
>

Copy that. Thanks Randy.

-blaise

>> +LSM hook to delegate policy decisions.
>> +
>> +Tooling
>> +=======
>> +
>> +Some tooling is provided to aid with the development of signed eBPF
>> +light-skeletons.
>> +
>> +extract-skel.sh
>> +---------------
>> +
>> +This shell script extracts the instructions and map data used by the
>> +light skeleton from the autogenerated header file created by bpftool.
>> +
>> +gen_sig
>> +---------
>> +
>> +gen_sig creates a pkcs#7 signature of a data payload. Additionally it
>> +appends a signed attribute containing a set of hashes.
>
> -- 
> ~Randy

