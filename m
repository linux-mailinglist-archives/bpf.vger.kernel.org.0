Return-Path: <bpf+bounces-76213-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF11CAA5E5
	for <lists+bpf@lfdr.de>; Sat, 06 Dec 2025 13:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00EFD30671F0
	for <lists+bpf@lfdr.de>; Sat,  6 Dec 2025 12:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45592E0901;
	Sat,  6 Dec 2025 12:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="GzSZi/4a"
X-Original-To: bpf@vger.kernel.org
Received: from pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.1.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD7D26F2B6;
	Sat,  6 Dec 2025 12:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.1.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765022495; cv=none; b=LzCrTSc1e52Y5P0b1cD1QbnfJ5u+bLzblk4J9rFSqSIHdSRHEI2XmZfOgi7FZJ5q5pPTf/2C8Emo7y3z7fd02kseMQDnoLQrIX0C7g+lEDiVL1ygV4x6sDX2B0KXJjQdB9qNCeuJKKs/47tr8GZ61iHiePzVvEDrZbUb27ZVa9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765022495; c=relaxed/simple;
	bh=I2eBsN+jY746tca5bty0KE2p+uTbS9w/whWDxwZ+KuM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E+IkZi3aZaojF9xAeULIIJDu0NRCnVXhpUDCROm1ipaR85AJqtapIMUyhF+LeyENt/9eQzHgGkIa1CzF7ZAF/OiJ1G4evry9m3q/9+ROKuo8CfGfpbEzFc9nd0BOiJeu0ehzu+ZuszXtMrz3ykh77tVnDai3AVDF0L8KpbVoO2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=GzSZi/4a; arc=none smtp.client-ip=44.246.1.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1765022493; x=1796558493;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7wdyfOlhxHVAJQOuQaS8BZyR/RiEcQMVl+kCXLzPmXs=;
  b=GzSZi/4aBxUImjjoHUJ7/a8Td5ZTdahUErfJQMeEAtKijApW2xplLxPK
   Ix2iLJrNDSMsVw/uXHcIDlA7/fMZvqdR8Uz+RHMtviCwMnkEPxp2BfwgJ
   yzw81LKvHTZU2Rz9YuYjzaMEXE2dRbJuDukpUJCd+9nwArI/c7HDDsuA6
   tut2MJ/M9QLWRuWGywDcEqePfbrVJxW5WVEzOPFNfj1o+Y/muwlFWvCMK
   w7G8K75GaxqMG1VBxqGqOev5za3+8KFY3G9chWBu3Z7DxBnKvtZtAbH/v
   ws3dLFXDTV2Tz+9Ur+VQZGnWR1w152HZ9autZV3QLFbVmRIuoVnly1h8h
   w==;
X-CSE-ConnectionGUID: a4+b6cLhSRKizsE43CDfzA==
X-CSE-MsgGUID: YpgVSN0LTf2GZfZwRPlKDg==
X-IronPort-AV: E=Sophos;i="6.20,254,1758585600"; 
   d="scan'208";a="8564701"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2025 12:01:29 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.51:17686]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.51.201:2525] with esmtp (Farcaster)
 id 3ff8c8a7-9d4b-41dd-8366-5ae970463765; Sat, 6 Dec 2025 12:01:29 +0000 (UTC)
X-Farcaster-Flow-ID: 3ff8c8a7-9d4b-41dd-8366-5ae970463765
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Sat, 6 Dec 2025 12:01:29 +0000
Received: from b0be8375a521.amazon.com (10.37.244.7) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Sat, 6 Dec 2025 12:01:25 +0000
From: Kohei Enju <enjuk@amazon.com>
To: <enjuk@amazon.com>
CC: <alexei.starovoitov@gmail.com>, <andrii@kernel.org>, <ast@kernel.org>,
	<bpf@vger.kernel.org>, <daniel@iogearbox.net>, <davem@davemloft.net>,
	<eddyz87@gmail.com>, <haoluo@google.com>, <hawk@kernel.org>,
	<john.fastabend@gmail.com>, <jolsa@kernel.org>, <kernel-team@cloudflare.com>,
	<kohei.enju@gmail.com>, <kpsingh@kernel.org>, <kuba@kernel.org>,
	<lorenzo@kernel.org>, <martin.lau@linux.dev>, <netdev@vger.kernel.org>,
	<sdf@fomichev.me>, <shuah@kernel.org>, <song@kernel.org>, <toke@kernel.org>,
	<yonghong.song@linux.dev>
Subject: Re: [PATCH bpf v1 1/2] bpf: cpumap: propagate underlying error in cpu_map_update_elem()
Date: Sat, 6 Dec 2025 21:00:46 +0900
Message-ID: <20251206120115.50257-1-enjuk@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251206072946.22695-1-enjuk@amazon.com>
References: <20251206072946.22695-1-enjuk@amazon.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D033UWA003.ant.amazon.com (10.13.139.42) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On Sat, 6 Dec 2025 16:29:44 +0900, Kohei Enju wrote:

>On Wed, 03 Dec 2025 13:31:29 +0100, Toke H�iland-J�rgensen wrote:
>
>>Jesper Dangaard Brouer <hawk@kernel.org> writes:
>>
>>> On 03/12/2025 11.40, Kohei Enju wrote:
>>>> On Tue, 2 Dec 2025 17:08:32 -0800, Alexei Starovoitov wrote:
>>>> 
>>>>> On Fri, Nov 28, 2025 at 8:05\u202fAM Kohei Enju <enjuk@amazon.com> wrote:
>>>>>>
>>>>>> After commit 9216477449f3 ("bpf: cpumap: Add the possibility to attach
>>>>>> an eBPF program to cpumap"), __cpu_map_entry_alloc() may fail with
>>>>>> errors other than -ENOMEM, such as -EBADF or -EINVAL.
>>>>>>
>>>>>> However, __cpu_map_entry_alloc() returns NULL on all failures, and
>>>>>> cpu_map_update_elem() unconditionally converts this NULL into -ENOMEM.
>>>>>> As a result, user space always receives -ENOMEM regardless of the actual
>>>>>> underlying error.
>>>>>>
>>>>>> Examples of unexpected behavior:
>>>>>>    - Nonexistent fd  : -ENOMEM (should be -EBADF)
>>>>>>    - Non-BPF fd      : -ENOMEM (should be -EINVAL)
>>>>>>    - Bad attach type : -ENOMEM (should be -EINVAL)
>>>>>>
>>>>>> Change __cpu_map_entry_alloc() to return ERR_PTR(err) instead of NULL
>>>>>> and have cpu_map_update_elem() propagate this error.
>>>>>>
>>>>>> Fixes: 9216477449f3 ("bpf: cpumap: Add the possibility to attach an eBPF program to cpumap")
>>>>>
>>>>> The current behavior is what it is. It's not a bug and
>>>>> this patch is not a fix. It's probably an ok improvement,
>>>>> but since it changes user visible behavior we have to be careful.
>>>> 
>>>> Oops, got it.
>>>> When I resend, I'll remove the tag and send to bpf-next, not to bpf.
>>>> 
>>>> Thank you for taking a look.
>>>> 
>>>>>
>>>>> I'd like Jesper and/or other cpumap experts to confirm that it's ok.
>>>>>
>>>> 
>>>> Sure, I'd like to wait for reactions from cpumap experts.
>>>
>>> Skimmed the code changes[1] and they look good to me :-)
>>
>>We have one example of a use of the cpumap programs in xdp-tools, and
>>there we just report the error message to the user. I would guess other
>>apps would follow the same pattern rather than react to a specific error
>>code; especially since there's only one error code being used here.
>>
>>So I agree, this should be OK to change.
>>
>>-Toke
>
>Thank you for the clarification, Toke and Jesper.
>Since I see no objections so far, I'll work on v2 and resend next week.

Ah, I forgot that bpf-next is closed until Jan 2nd due to the merge window.
I'll resend v2 after Jan 2nd :)

