Return-Path: <bpf+bounces-62703-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24AC7AFD7A8
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 21:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AF29176BE0
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 19:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1DB239E70;
	Tue,  8 Jul 2025 19:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qXznxuwy"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322142192FC
	for <bpf@vger.kernel.org>; Tue,  8 Jul 2025 19:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752004405; cv=none; b=W+UL3YKx0nNbDTdsVrij/UtPFSoTBcc2a4A9yVaOTXipLlViFWUFzwCaVbQSDsyVRN0yqxDTTFjUIqKxW8Ku3/709Kn+ghzBClm9AEyitN0V3LiRE2qzVpZpz3HvUgODhBFCVMlZHNiJl3dQzZ0RHaCc0qhoWyLrYCoN9NsHLo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752004405; c=relaxed/simple;
	bh=mSQ/Ni4fcj7/F3qfKzUHOgQQwwytlPeKEwZ6qXRz+ZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZVBEN1G8XVs/uLUPsR0noyUh5b0pNHQY6obHRDgTFQOP9N+8tpIWJ7PhL0ArWr+tIrmBv2TY3Uiqze09u/lUcnWu/vJFCIrpmwl0mskUx9Yun44+yBJ5YuR6GCxRSiE91kgdJUkAAjA/R2/y/GzI11W9+evXVYzEH7ydOEdn8Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qXznxuwy; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d243e84a-8ca6-4f32-854f-8d4e709277f5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752004400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jb0+aVir9jcmWG2wTOVR08P1huBO3MZRan5P4q8+1gc=;
	b=qXznxuwykgDwLstogxhtYex8nXpMNFto6bFT9OayN2EcizYJzqGQhTyPJrSrApqJfoeKG0
	A+LaEzsWLNFM1wJGfrMQATdlN+1gu0xdFv2qOqnrw3Z3bAHmLE11I/79TXW1nCiRoac7+o
	J2ZA52EMMayPcue4KXoQONAksH0A1Hk=
Date: Tue, 8 Jul 2025 12:53:14 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [External] : Re: Potential BPF Arena Security Vulnerability,
 Possible Memory Access and Overflow Issues
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Yifei Liu <yifei.l.liu@oracle.com>
Cc: "ast@kernel.org" <ast@kernel.org>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "daniel@iogearbox.net" <daniel@iogearbox.net>
References: <1A9DA34D-7AC9-4A77-A07D-46B4DD0E3136@oracle.com>
 <CAADnVQKDeKmz95rHT4sRX9JhrRiBR06wngVck_cVzmGtDMiK7w@mail.gmail.com>
 <5B89E759-2B80-433F-92AD-9B0CB16C2308@oracle.com>
 <CAADnVQ+NOs9hJW=hFeAtOmtNdQ_CT6zdMu1FnhM3xKD-oYiKZA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQ+NOs9hJW=hFeAtOmtNdQ_CT6zdMu1FnhM3xKD-oYiKZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 7/7/25 4:06 PM, Alexei Starovoitov wrote:
> On Mon, Jul 7, 2025 at 2:43 PM Yifei Liu <yifei.l.liu@oracle.com> wrote:
>>
>>
>>> On Jul 7, 2025, at 2:19 PM, Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>>>
>>> On Mon, Jul 7, 2025 at 1:44 PM Yifei Liu <yifei.l.liu@oracle.com> wrote:
>>>> Hi Alexei,
>>>>
>>>> I recently noticed that the verifier_arena_large selftest would fail on the overflow and underflow section for 64k page size kernels. After a deeper investigation, the similar issue is also reproducible on 4k page size over both x86 and aarch64 platforms.
>>>>
>>>> The root reason of this failure looks to be a failed or missing check of the pointer upper 32-bit from the user space. User space could access the arena space value even the pointer is not in the assigned user space pointer range. For example, if the user_vm_start is 7f7d26200000 and arena size is 4G (end upper bound is 7f7e26200000), when I set *(7f7e26200000 - 65536) = 20, I could also get the value of (7f7d26200000 - 65536) as 20. It should be 0 if that is out of the range.
>>>>
>>>> Could you please take a look at this issue? Or could you please point me where is the place doing the address translation and I could try to provide a patch for this?
>>>>
>>>> Thank you very much.
>>>> Yifei
>>>>
>>>> Methods on reproduce:
>>>> 1. Use a 64k page size arm based kernel and run verifier_arena_large selftest, it would failed on return 12 and 13. Or
>>> Are you sure you're running the latest kernel ?
>>> This sounds like issue fixed in commit 517e8a7835e8 ("bpf: Fix
>>> softlockup in arena_map_free on 64k page kernel”)
>> Thanks for the reply. I do check this fix and it is not related to the one I mentioned above. It just fix the guard
>> range so that it would not set the start address without page alignment.
>>
>>> In general this is not a security vulnerability in any way.
>>> 32-bit wraparound is there by design.
>> If we do not check the upper 32-bit value, it would be wide open for user-space to access the arena space.
>> And maybe even the user-space process cannot access the memory outside the 4G area because it would
>> try to translate all the pointers to that area.
> No idea what you're trying to say.
>
>> Plus, it would consistently fail the verifier_arena_large selftest for 64k page size kernels. Maybe we want to
>> skip some of the overflow/underflow tests if the page size is 64k?

I tried on my aarch64 machine which has 64K page size. The verifier_arena_large works fine for
me with either gcc11 or clang21. Could you give more details (traces) about the failure you observed?

> Skip without full understanding is not a good idea.
> This test does:
>          if (*(page1 + PAGE_SIZE) != 0)
>                  return 11;
>          if (*(page1 - PAGE_SIZE) != 0)
>                  return 12;
>          if (*(page2 + PAGE_SIZE) != 0)
>                  return 13;
>          if (*(page2 - PAGE_SIZE) != 0)
>
> which gets compiled into bpf insns with positive and negative 16-bit offsets.
> When PAGE_SIZE is 64k the code is compiled into some other form,
> since constant doesn't fit into 'off' field.
> So the code is not checking what it is supposed to.
> One way is to use inline asm. Another is to replace PAGE_SIZE
> with an actual 4k constant in big_alloc1() test.

We are fine here. The selection dag knows the imm range and can
generate correct registers. Below is the actually generated code:

;       if (*(page1 + PAGE_SIZE) != 0)
       75:       bf 81 00 00 00 00 00 00 r1 = r8
       76:       07 01 00 00 00 00 01 00 r1 += 0x10000
       77:       71 11 00 00 00 00 00 00 w1 = *(u8 *)(r1 + 0x0)
       78:       56 01 0e 00 00 00 00 00 if w1 != 0x0 goto +0xe <big_alloc1+0x2e8>
       79:       b4 07 00 00 0c 00 00 00 w7 = 0xc
;       if (*(page1 - PAGE_SIZE) != 0)
       80:       07 08 00 00 00 00 ff ff r8 += -0x10000
       81:       71 81 00 00 00 00 00 00 w1 = *(u8 *)(r8 + 0x0)
       82:       56 01 0a 00 00 00 00 00 if w1 != 0x0 goto +0xa <big_alloc1+0x2e8>
       83:       b4 07 00 00 0d 00 00 00 w7 = 0xd
;       if (*(page2 + PAGE_SIZE) != 0)
       84:       bf 91 00 00 00 00 00 00 r1 = r9
       85:       07 01 00 00 00 00 01 00 r1 += 0x10000
       86:       71 11 00 00 00 00 00 00 w1 = *(u8 *)(r1 + 0x0)
       87:       56 01 05 00 00 00 00 00 if w1 != 0x0 goto +0x5 <big_alloc1+0x2e8>
;       if (*(page2 - PAGE_SIZE) != 0)
       88:       07 09 00 00 00 00 ff ff r9 += -0x10000
       89:       71 91 00 00 00 00 00 00 w1 = *(u8 *)(r9 + 0x0)
       90:       b4 07 00 00 00 00 00 00 w7 = 0x0
       91:       16 01 01 00 00 00 00 00 if w1 == 0x0 goto +0x1 <big_alloc1+0x2e8>
       92:       b4 07 00 00 0e 00 00 00 w7 = 0xe


