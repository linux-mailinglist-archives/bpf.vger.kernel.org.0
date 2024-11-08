Return-Path: <bpf+bounces-44381-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E6F9C2542
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 20:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BA631C217F0
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 19:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3120219C572;
	Fri,  8 Nov 2024 19:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VdgJVHgx"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9278E233D83
	for <bpf@vger.kernel.org>; Fri,  8 Nov 2024 19:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731092467; cv=none; b=FpYnHlgiJPGHrlebjaVqNCk91+/SmsapG4v/dP5zMC7ilEdGLJelmhSGDqgND3w5pouhhxJYFfKoVxAPHhsf3wG5ETIy9xiI3Z5kR2Uz1A5zbMp1RsQUX75SHRlvJe4tNWObPE/21CjUBC7sPlbvh8p2GErg4KsnPke/F5AnwZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731092467; c=relaxed/simple;
	bh=VnvczCRmvxmbRu1VaVuyfuslYoJJuVqu5lcnkeVJ7oU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K2nORKF68DcthuNoh2CtLfKzAzucqhv/EclWAMTRb6vQBgM2e8V4cclTZzujeHq/3ivIC6aliqzqMkgcnhYdTOc5DpkpqJRh3haovn2yPfmPLMvwI/4mHpFutDj2UpPQGKF/ri/k37hQBsglrml2+aWEmW7uh5jEG5DXTt/4u9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VdgJVHgx; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ae954e1c-46c0-4ee6-90b4-5b17880dba22@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731092463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VoGK5QITX3hxcu+xCYFruci6yig+fA5PNRRZt9qp3EI=;
	b=VdgJVHgxpUb5RzU0utX/2nSQE0ysgYDDaFQVvih9glcnumhZb5g9oYmxFd1v+qZWxDd7DH
	/yHNcYc/OSISwDJjXbdC+j8t9GPXT9pr72q1oCeefISQrYyvmjeF2zB1X/zohLtT6loRW5
	ubrEQnLZ0lnes0EpoEH8eLccvcShq8c=
Date: Fri, 8 Nov 2024 11:00:58 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] docs/bpf: Document some special sdiv/smod
 operations
Content-Language: en-GB
To: Dave Thaler <dthaler1968@googlemail.com>,
 'Alexei Starovoitov' <alexei.starovoitov@gmail.com>
Cc: bpf@ietf.org, 'bpf' <bpf@vger.kernel.org>,
 'Alexei Starovoitov' <ast@kernel.org>, 'Andrii Nakryiko'
 <andrii@kernel.org>, 'Daniel Borkmann' <daniel@iogearbox.net>,
 'Martin KaFai Lau' <martin.lau@kernel.org>
References: <20240927033904.2702474-1-yonghong.song@linux.dev>
 <CAADnVQJZLRnT3J31CLB85by=SmC2UY1pmUZX0kkyePtVdTdy9A@mail.gmail.com>
 <e93729b5-199f-4809-84f5-7efdf7c8aaf3@linux.dev>
 <181301db143b$ba6fd9c0$2f4f8d40$@gmail.com>
 <CAADnVQKDwZ0+Fjiz21AFAbOgEonVojvpojU1ZyQDu8V4Jm0DYQ@mail.gmail.com>
 <000c01db3186$1dd30930$59791b90$@gmail.com>
 <CAADnVQKHHvrJjAMuXC5-wQHfMfxoSXnOBnqrZ5PC7p3C8ut3rQ@mail.gmail.com>
 <09ee01db320f$8d37bc60$a7a73520$@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <09ee01db320f$8d37bc60$a7a73520$@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT




On 11/8/24 10:53 AM, Dave Thaler wrote:
>> -----Original Message-----
>> From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
>> Sent: Friday, November 8, 2024 10:38 AM
>> To: Dave Thaler <dthaler1968@googlemail.com>
>> Cc: Yonghong Song <yonghong.song@linux.dev>; bpf@ietf.org; bpf
>> <bpf@vger.kernel.org>; Alexei Starovoitov <ast@kernel.org>; Andrii Nakryiko
>> <andrii@kernel.org>; Daniel Borkmann <daniel@iogearbox.net>; Martin KaFai Lau
>> <martin.lau@kernel.org>
>> Subject: Re: [PATCH bpf-next] docs/bpf: Document some special sdiv/smod
>> operations
>>
>> On Thu, Nov 7, 2024 at 6:30 PM Dave Thaler <dthaler1968@googlemail.com>
>> wrote:
>>>
>>> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>>>> On Tue, Oct 1, 2024 at 12:54 PM Dave Thaler
>>>> <dthaler1968@googlemail.com>
>>>> wrote:
>>> [...]
>>>>> I'm adding bpf@ietf.org to the To line since all changes in the
>>>>> standardization directory should include that mailing list.
>>>>>
>>>>> The WG should discuss whether any changes should be done via a new
>>>>> RFC that obsoletes the first one, or as RFCs that Update and just
>>>>> describe deltas (additions, etc.).
>>>>>
>>>>> There are precedents both ways and I don't have a strong
>>>>> preference, but I have a weak preference for delta-based ones
>>>>> since they're shorter and are less likely to re-open discussion on
>>>>> previously resolved issues, thus often saving the WG time.
>>>> Delta-based additions make sense to me.
>>>>
>>>>> Also FYI to Linux kernel folks:
>>>>> With WG and AD approval, it's also possible (but not ideal) to
>>>>> take changes at AUTH48.  That'd be up to the chairs and AD to
>>>>> decide though, and normally that's just for purely editorial
>>>>> clarifications, e.g., to confusion called out by the RFC editor pass.
>>>> Also agree. We should keep AUTH going its course as-is.
>>>> All ISA additions can be in the future delta RFC.
>>>>
>>>> As far as file logistics... my preference is to keep
>>>> Documentation/bpf/standardization/instruction-set.rst
>>>> up to date.
>>>> Right now it's effectively frozen while awaiting changes (if any) necessary for
>> AUTH.
>>>> After official RFC is issued we can start landing patches into
>>>> instruction-set.rst and git diff 04efaebd72d1..whatever_future_sha
>>>> instruction-set.rst will automatically generate the future delta RFC.
>>>> Once RFC number is issued we can add a git tag for the particular
>>>> sha that was the base for RFC as a documentation step and to simplify future 'git
>> diff'.
>>> My concern is that index.rst says:
>>>> This directory contains documents that are being iterated on as part
>>>> of the BPF standardization effort with the IETF. See the `IETF BPF
>>>> Working Group`_ page for the working group charter, documents, and more.
>>> So having a document that is NOT part of the IETF BPF Working Group
>>> would seem out of place and, in my view, better located up a level (outside
>> standardization).
>>
>> It's a part of bpf wg. It's not a new document.
> RFC 9669 is immutable.  Any additions require a new document, in
> IETF terminology, since would result in a new RFC number.
>
>>> Here’s some examples of delta-based RFCs which explain the gap and
>>> provide the addition or clarification, and formally Update (not
>>> replace/obsolete) the original
>>> RFC:
>>> * https://www.rfc-editor.org/rfc/rfc6585.html: Additional HTTP Status
>>> Codes
>>> * https://www.rfc-editor.org/rfc/rfc6840.html: Clarifications and Implementation
>> Notes
>>>     for DNS Security (DNSSEC)
>>> * https://www.rfc-editor.org/rfc/rfc9295.html: Clarifications for Ed25519, Ed448,
>>>     X25519, and X448 Algorithm Identifiers
>>> * https://www.rfc-editor.org/rfc/rfc5756.html: Updates for RSAES-OAEP and
>>>     RSASSA-PSS Algorithm Parameters
>>>
>>> Having a full document too is valuable but unless the IETF BPF WG
>>> decides to take on a -bis document, I'd suggest keeping it out of the
>> "standardization"
>>> (say up 1 level) to avoid confusion, and just have one or more
>>> delta-based rst files in the standardization directory.
>> This patch is effectively a fix to the standard.
> Two of the examples I provided above fit into that category.
> Two are examples of adding new codepoints.
>
>> It's a standard git development process when fixes are applied to the existing
>> document.
>> Forking the whole doc into a different file just to apply fixes makes no sense to me.
> Welcome to the IETF and immutable RFCs 😊
>
>> The formal delta-s for IETF can be created out of git.
> Not in the IETF per se, since a new document needs new boilerplate, with
> a new abstract, introduction, etc.  At most, part of the document could be created
> out of git, but I'm not convinced that git diffs alone (as opposed to some English
> prose too for each, as in the examples I cited) make for good content in an IETF document.
>
>> We only need to tag the current version and then git diff rfc9669_tag..HEAD will give
>> us that delta.
>> That will satisfy IETF process and won't mess up normal git style kernel
>> development.
> I am not convinced it is sufficient.  Can you point to any precedents in the IETF for
> such an approach?  I can't offhand... See the RFC 5756 reference above for what
> I mean by English prose for each diff.

I think we can add sufficient details in the commit message. What things we need to
put in the commit message to satisfy the rIETF equirement?

>> btw do we still need to do any minor edit/fixes to instruction-set.rst before tagging it
>> as RFC9669 ?
> Yes, we need to backport the formatting/nits from the RFC editor pass.
>
> Dave
>


