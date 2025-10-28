Return-Path: <bpf+bounces-72586-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEBAC15D31
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 17:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E173D354E7C
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 16:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D578293B5F;
	Tue, 28 Oct 2025 16:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UsFMAVyw"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D775223DFF
	for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 16:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761669110; cv=none; b=Gw61h44P7Jlp7oc9ueXzyEIPyH5oLfUuvZpGadhw7rAowxX5K3Z1yufPQYHfgBz4YOB/3Utsw7S4nkQIYsEyj+EBkVKlEyg+T93fCWNYkAX+mX3+cyWFvEJZ/nP/y0qPjUlBCE4u5csCNtYWg7ZIX/mhRAA4HxQDk4ft0OqkaXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761669110; c=relaxed/simple;
	bh=0PucAMAox93xgjGrD5pR5CZazcj6sVnwd0fqWCdhArI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SL7sa/JbTAhQcNSMtBlmEjgP+qpXb4doHzssBDzGpbsA/S6QgdHYBezD2Cn3nynji5qmC3aCu2f/TQuAIhpd1gf+ynajK5VYHrMkbMbv2viBEBmCbzH81tBYdmehBuHBABlrEVryrLtK9LsYpK/ZZU0yV5sakixkOFuO4ScvA4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UsFMAVyw; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761669105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HWSSRHmArf/3utDL/ehBcqRMhr+v6BRpRpOeVW9o8r8=;
	b=UsFMAVywaT8IpkoioAmt6vXomW1hLiGke5lnfdOFm6CT75B6FrTgPwndxR0Ld4UWB+GB6Z
	kNutJOjE/CXohXqu1fHCO5Wo3THXTOtts+MdPLoZN5i9dq8L67okdhsPKyc4EOyrIZ69wY
	ts6Gbva7I2Aaj5nD5s2hWpcBahe3SXQ=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: bot+bpf-ci@kernel.org
Cc: akpm@linux-foundation.org,  linux-kernel@vger.kernel.org,
 ast@kernel.org, surenb@google.com, mhocko@kernel.org,
 shakeel.butt@linux.dev, hannes@cmpxchg.org, andrii@kernel.org,
 inwardvessel@gmail.com, linux-mm@kvack.org, cgroups@vger.kernel.org,
 bpf@vger.kernel.org, martin.lau@kernel.org, song@kernel.org,
 memxor@gmail.com, tj@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com,
 yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH v2 17/23] bpf: selftests: introduce read_cgroup_file()
 helper
In-Reply-To: <58dd6b759499f212f626e6d7658dd558b3e6a334e0780898002cb2cb84dbcb85@mail.kernel.org>
	(bot's message of "Mon, 27 Oct 2025 23:48:24 +0000 (UTC)")
References: <20251027232206.473085-7-roman.gushchin@linux.dev>
	<58dd6b759499f212f626e6d7658dd558b3e6a334e0780898002cb2cb84dbcb85@mail.kernel.org>
Date: Tue, 28 Oct 2025 09:31:38 -0700
Message-ID: <87ms5b3s45.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

bot+bpf-ci@kernel.org writes:

> ```
> commit 712137918bba1b0a9c7c670bab9200b0f0d6a7e8
> Author: Roman Gushchin <roman.gushchin@linux.dev>
>
> bpf: selftests: introduce read_cgroup_file() helper
>
> This patch adds a new helper function read_cgroup_file() to read from
> cgroup control files in BPF selftests. The function opens a file,
> reads into a buffer, and returns the result.
>
>> diff --git a/tools/testing/selftests/bpf/cgroup_helpers.c b/tools/testing/selftests/bpf/cgroup_helpers.c
>> index 20cede4db..8fb02fe4c 100644
>> --- a/tools/testing/selftests/bpf/cgroup_helpers.c
>> +++ b/tools/testing/selftests/bpf/cgroup_helpers.c
>> @@ -126,6 +126,45 @@ int enable_controllers(const char *relative_path, const char *controllers)
>>  	return __enable_controllers(cgroup_path, controllers);
>>  }
>>
>> +static size_t __read_cgroup_file(const char *cgroup_path, const char *file,
>> +				 char *buf, size_t size)
>> +{
>> +	char file_path[PATH_MAX + 1];
>> +	size_t ret;
>> +	int fd;
>> +
>> +	snprintf(file_path, sizeof(file_path), "%s/%s", cgroup_path, file);
>> +	fd = open(file_path, O_RDONLY);
>> +	if (fd < 0) {
>> +		log_err("Opening %s", file_path);
>> +		return -1;
>
> Can __read_cgroup_file() return -1 when its return type is size_t?
>
> The function signature declares size_t (unsigned), but returns -1 here.
> When -1 is implicitly converted to size_t, it becomes SIZE_MAX
> (18446744073709551615 on 64-bit systems). Callers checking for errors
> with "if (ret < 0)" will fail because size_t is unsigned, and callers
> checking "if (ret == -1)" will also fail after the cast.
>
>> +	}
>> +
>> +	ret = read(fd, buf, size);
>> +	close(fd);
>> +	return ret;
>
> Does this handle read() errors correctly?
>
> The read() syscall returns ssize_t which can be negative on error.
> Assigning this to size_t (line 143) converts negative error codes into
> large positive numbers. For example, read() returning -1 becomes SIZE_MAX
> when stored in ret.
>
> Should the return type be ssize_t instead of size_t to properly propagate
> both success (byte count) and error (negative values) to callers?

Correct, fixed to ssize_t. Thanks!

