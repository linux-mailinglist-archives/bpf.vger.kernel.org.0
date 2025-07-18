Return-Path: <bpf+bounces-63736-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56405B0A7C3
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 17:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 219893BC5AA
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 15:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990CF2DEA67;
	Fri, 18 Jul 2025 15:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="IHK8cY5/"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DBC1865EE;
	Fri, 18 Jul 2025 15:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752852907; cv=none; b=I/VPbFjMhc9AuFX4NngDgrE76tuXYuA/+8EMpsLZuJzY/af2GgSKafh28UJMgeXE+Rq43MJRHRO9vUtP+Dt3ju5drCwv8lW5KM7M15PkhwNequUrqFfG8OPNr7bYrQSEpNoE1Rv92klEPda8QGIfoQ3Dmc3UK6YF+n7/cU6/sGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752852907; c=relaxed/simple;
	bh=FxcvYdQRY3DcBanF32X4QBOp7OCa18HAxUo7EjU1yqk=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T26W0m1bc+NH04suj5cGXbnU5eRRKKMS+hzV+XcGGckLitOSwtXxpskQhzDfZ1NqNenBj3/i/j0/W/peO9xAIsBxDNJuEJjR0qSGs5ihGqXWSfJSyu10PI8G29RzMapb98Z3pYh0BQTrLuTIn7aWuXRUOOaZlmrEq772aoz/mrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=IHK8cY5/; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia (unknown [40.78.13.147])
	by linux.microsoft.com (Postfix) with ESMTPSA id 04C33211FEB6;
	Fri, 18 Jul 2025 08:35:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 04C33211FEB6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1752852905;
	bh=laEB97ogdr442ty4J3QQO87ShWSCdclOdA+Q3Ik/eFw=;
	h=From:To:Subject:In-Reply-To:References:Date:From;
	b=IHK8cY5/lSxxbodzOTpipcidTjQMMy8rPm8E6SOR/VtgYTbdq9p+VnU2shW4cq/I/
	 /J+K1bw0suszJuKinQS4P9SfgkKHSGTkpMiZ9VPvrk3cFAAl73qeavYt63B5GGTpOJ
	 67vIjk6zBJxDgSvijyMM9PZ2EwNOtuwT7WljerpE=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley
 <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>,
 Casey Schaufler <casey@schaufler-ca.com>, John Johansen
 <john.johansen@canonical.com>, Christian =?utf-8?Q?G=C3=B6ttsche?=
 <cgzones@googlemail.com>, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, selinux@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] lsm,selinux: Add LSM blob support for BPF objects
In-Reply-To: <941986e9f4f295f247e5982002e16fe9@paul-moore.com>
References: <20250715222655.705241-1-bboscaccy@linux.microsoft.com>
 <941986e9f4f295f247e5982002e16fe9@paul-moore.com>
Date: Fri, 18 Jul 2025 08:35:02 -0700
Message-ID: <875xfp4imx.fsf@microsoft.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Paul Moore <paul@paul-moore.com> writes:

> On Jul 15, 2025 Blaise Boscaccy <bboscaccy@linux.microsoft.com> wrote:
>> 
>> This patch introduces LSM blob support for BPF maps, programs, and
>> tokens to enable LSM stacking and multiplexing of LSM modules that
>> govern BPF objects. Additionally, the existing BPF hooks used by
>> SELinux have been updated to utilize the new blob infrastructure,
>> removing the assumption of exclusive ownership of the security
>> pointer.
>> 
>> Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
>> ---
>>  include/linux/lsm_hooks.h         |   3 +
>>  security/security.c               | 120 +++++++++++++++++++++++++++++-
>>  security/selinux/hooks.c          |  56 +++-----------
>>  security/selinux/include/objsec.h |  17 +++++
>>  4 files changed, 147 insertions(+), 49 deletions(-)
>
> ...
>
>> @@ -835,6 +841,72 @@ static int lsm_bdev_alloc(struct block_device *bdev)
>>  	return 0;
>>  }
>>  
>> +/**
>> + * lsm_bpf_map_alloc - allocate a composite bpf_map blob
>> + * @map: the bpf_map that needs a blob
>> + *
>> + * Allocate the bpf_map blob for all the modules
>> + *
>> + * Returns 0, or -ENOMEM if memory can't be allocated.
>> + */
>> +static int lsm_bpf_map_alloc(struct bpf_map *map)
>> +{
>> +	if (blob_sizes.lbs_bpf_map == 0) {
>> +		map->security = NULL;
>> +		return 0;
>> +	}
>> +
>> +	map->security = kzalloc(blob_sizes.lbs_bpf_map, GFP_KERNEL);
>> +	if (!map->security)
>> +		return -ENOMEM;
>> +
>> +	return 0;
>> +}
>
> Casey suggested considering kmem_cache for the different BPF objects,
> but my gut feeling is that none ofthe BPF objects are going to be
> allocated with either enough frequency, or enough quantity, where a
> simple kzalloc() wouldn't be sufficient, at least for now.  Thoughts
> on this Blaise?

Yeah, I agree, the number of allocations should be very low in
comparision to something like inodes. We are probably okay using kzalloc
forf the time being. 

>
> Assuming we stick with kazlloc() based allocation, please look at using
> the lsm_blob_alloc() helper function as Song mentioned  As I'm writing
> this I'm realizing there are a few allocatiors that aren't using the
> helper, I need to fix those up ...

Will do.

>
> It's worth mentioning that the allocation scheme is an internal LSM
> implementation detail, something we can change at any time with a small
> patch, so I wouldn't stress too much about "Getting it Right" at this
> point in time.
>
>> @@ -5763,7 +5862,12 @@ int security_bpf_token_capable(const struct bpf_token *token, int cap)
>>   */
>>  void security_bpf_map_free(struct bpf_map *map)
>>  {
>> +	if (!map->security)
>> +		return;
>> +
>
> We don't currently check if map->security is NULL in the current hook,
> or the SELinux callback (it's not a common pattern for the LSM blobs),
> did you run into a problem where the blob pointer was NULL?
>
> The same comment applies to all three blob types.

No real issues that I ran into. I was cribbing off the pattern used in
block devices. After taking a second look, it looks safe to remove that
check. I'll get that fixed in v2.

-blaise

>
>>  	call_void_hook(bpf_map_free, map);
>> +	kfree(map->security);
>> +	map->security = NULL;
>>  }
>>  
>>  /**
>
> --
> paul-moore.com

