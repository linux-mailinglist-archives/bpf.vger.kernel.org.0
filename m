Return-Path: <bpf+bounces-69459-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 511B0B96D5E
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 18:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BA1719C1AE6
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 16:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4AD6327A3A;
	Tue, 23 Sep 2025 16:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="b4NVKQcL"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863E223B0
	for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 16:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758645098; cv=none; b=NWv2WSVryUZqHKNspIJoh2kFhjMTAN3/gSjMKHBRkos/lYLHPL47/EpsaDqEr9W85CQeMrhNK8ZuxFm8nPBQ6VSprPk7PH2ELChVKQt4u19MWa/M/O/+D9F0PTQ9foaYr9sGGmxT93giQIrz/Tdf1mAItPiGmD3VlTgT4DLzhe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758645098; c=relaxed/simple;
	bh=6QmjeE3ImyyNo5GRe7QkUGK/LaDg6Z84fteOioZkN+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G5Pn16nC3+ieL1a24Bn+7MrxOeDJF9OBIf8WUHedzPf+GpiecVQbGff40RN24ohOB76lHRjDtnFWNz/s3VZwKIWADEXGcTMHShoBP5I0fNDwRPSdbFHpDoSxG6hwxcmCtVToxr8EGWBl6X6ZNxtsgmYnFmlx1aiQm3OFpruihG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=b4NVKQcL; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9d155b1c-aa37-40c8-ac58-797f67b8d07c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758645094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XzjKKQg34vn++UCLaDDVRrC+gO6+UAy1FAbqtU3R7Vs=;
	b=b4NVKQcLQLyhz8NcTZVN1T/p95lil/+lrTmQmQ88Mx2UXNsaFwyYnmjYvo+5/xgQaC/4mF
	4AhfQvPBPNX57tteiPO/6ngtwwKJHZ8E4zB6Zrz8dSTn6hfitGIXprC0dAmdVVHp1eYM9s
	M/UKEdJ5KnREy3lzOJErHVDmcruSW0g=
Date: Wed, 24 Sep 2025 00:31:29 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next v2 4/6] bpf: Add common attr support for
 map_create
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 menglong8.dong@gmail.com
References: <20250911163328.93490-1-leon.hwang@linux.dev>
 <20250911163328.93490-5-leon.hwang@linux.dev>
 <5d1f41605348e45e60c95a75bdbb286efa3ef3ac.camel@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <5d1f41605348e45e60c95a75bdbb286efa3ef3ac.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/9/19 07:29, Eduard Zingerman wrote:
> On Fri, 2025-09-12 at 00:33 +0800, Leon Hwang wrote:
>
> [...]
>
>> @@ -1355,6 +1356,18 @@ static int map_create(union bpf_attr *attr, bool kernel)
>>  	if (err)
>>  		return -EINVAL;
>>
>> +	if (common_attrs->log_buf) {
>> +		log = kvzalloc(sizeof(*log), GFP_KERNEL);
>> +		if (!log)
>> +			return -ENOMEM;
>> +		err = bpf_vlog_init(log, BPF_LOG_FIXED, u64_to_user_ptr(common_attrs->log_buf),
>> +				    common_attrs->log_size, NULL);
>
> Maybe use common_attrs->log_level instead of BPF_LOG_FIXED?
> Just for consistent behavior with program and btf load operations.
>

It doesn’t really make sense to let users set log_level in this case,
because logging in map_create is too simple for different log levels to
have any meaningful effect.

>> +		if (err) {
>> +			kvfree(log);
>> +			return err;
>> +		}
>> +	}
>> +
>>  	/* check BPF_F_TOKEN_FD flag, remember if it's set, and then clear it
>>  	 * to avoid per-map type checks tripping on unknown flag
>>  	 */
>
> [...]
>
>> @@ -1565,6 +1605,10 @@ static int map_create(union bpf_attr *attr, bool kernel)
>>  	bpf_map_free(map);
>>  put_token:
>>  	bpf_token_put(token);
>> +	if (err && log)
>> +		(void) bpf_vlog_finalize(log, &log_true_size);
>> +	if (log)
>> +		kvfree(log);
>>  	return err;
>>  }
>
> +1 to Andrii's suggestion to report log size back,
> just for consistency reasons.

Right.

The log_true_size will be reported back to users.

Thanks,
Leon

