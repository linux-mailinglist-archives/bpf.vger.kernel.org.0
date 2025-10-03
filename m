Return-Path: <bpf+bounces-70272-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E704BB5CE4
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 04:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 267E119C3B05
	for <lists+bpf@lfdr.de>; Fri,  3 Oct 2025 02:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A1A2D542A;
	Fri,  3 Oct 2025 02:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MNXw1AfP"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CA82D4801
	for <bpf@vger.kernel.org>; Fri,  3 Oct 2025 02:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759458714; cv=none; b=natwsD97vvcki/f2JFo1TaAhUEX5PV8f7Xou0ryvp/YaagcftHRbDjkgEx+BRliCe5Ar5o5c0ILg6G2s8uLhCurt63ywyfL0ebJXT2BZ/hkCxvTDPiWtboh1vNlVgJMLlY/Tw+OQd3t0UwfcYbx+Kf1wbmIx++Zey0GrwdK/a8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759458714; c=relaxed/simple;
	bh=6dJMEOCCgMmH8g8R1irPLYYPEZlag4USxqKFV96aVFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oo4dtkxU4FFAghA36qc09DCuIT/c3P80OJDwSn4cXRTqfZTmJdkTkyPZSytvozBSh6GoTVErUX2gmTZiCbVsU9WMS+3idvZAn6oSifZygEUWMXEh1EnUsM1yJHK7FWha5RST31o8YmCcFALmMKgGfnH7uJOqfN9cfQL6WNj3rUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MNXw1AfP; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <acf937cd-63ec-48db-8b63-daed7f2ac578@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759458706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rs8VFonMq5mL+hZtkVBGRIDJdUD5fhEnvq3mSspHKdM=;
	b=MNXw1AfPFo1kEVIicTJhoH7aZ/wOjiA/Vqync9ZMbBeApdGOjtk6th7cg2YveuXj2ktyFF
	XYKnXd4ueXuMwTW1s8JPZ3AMEG0rUHfv9hm3KrDOV7ecdJscdvARvLDobZDeXX0Hv/s+YT
	wdLCnRrpJHZZIfwexy+nsZh7KCKpLis=
Date: Fri, 3 Oct 2025 10:31:39 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next v3 07/10] bpf: Add warnings for internal bugs
 in map_create
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
References: <20251002154841.99348-1-leon.hwang@linux.dev>
 <20251002154841.99348-8-leon.hwang@linux.dev>
 <CAADnVQLY9iEkWXKqS+DLn7jNU5weoqOsoSVRPiuS2pv8MgbRJg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAADnVQLY9iEkWXKqS+DLn7jNU5weoqOsoSVRPiuS2pv8MgbRJg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 3/10/25 08:06, Alexei Starovoitov wrote:
> On Thu, Oct 2, 2025 at 8:49 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>> In next commit, it will report users the reason of -EINVAL in
>> map_create.
>>
>> However, as for the check of '!ops' and '!ops->map_mem_usage', it
>> shouldn't report the reason as they would be internal bugs.
>>
>> Instead, add WARN_ON_ONCE to them. Then, it is able to check dmesg to get
>> the error details.
>>
>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
>> ---
>>  kernel/bpf/syscall.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> index fc1b5c8c5e82f..49db250a2f5da 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
>> @@ -1406,7 +1406,7 @@ static int map_create(union bpf_attr *attr, bpfptr_t uattr)
>>                 return -EINVAL;
>>         map_type = array_index_nospec(map_type, ARRAY_SIZE(bpf_map_types));
>>         ops = bpf_map_types[map_type];
>> -       if (!ops)
>> +       if (WARN_ON_ONCE(!ops))
>>                 return -EINVAL;
> 
> It was a strong recommendation for a long time to avoid WARN*() at all cost.
> In the verifier we removed majority of them and replaced with verifier_bug()
> which WARNS only when DEBUG_KERNEL.
> 
> Here there is no reason to warn at all. Keep it as-is.

Got it, thanks for clarifying.

I understand now that WARN*() should generally be avoided, since they
add noise and aren't justified here. The existing 'return -EINVAL;' is
sufficient.

I'll keep it as-is in the next revision.

Thanks,
Leon

