Return-Path: <bpf+bounces-69460-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41392B96DB5
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 18:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D77E87A70D9
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 16:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD10A328591;
	Tue, 23 Sep 2025 16:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eH6+wENt"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C383D31B104
	for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 16:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758645616; cv=none; b=CZ1BIhK9GFdqcDeCvcXOl7k6u8cR33cLbniH7bzd42EEdLWDUYNLDzZ1jKrVuJ0ODiiP68eIjmOsGf/eZcGqHJkuBG9PrhX2PwHT9R3LjtsQqwxSroOCxI0HJm1NgwxiWxkL+pfYOjNf71uWOc7bvteQ+vkmf3twWx1QBATUPIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758645616; c=relaxed/simple;
	bh=B5R10vSzW7QvOSW0pH4EUOrDCm+O+lC98oFAcdBJECU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J50AUJ0qqrI6/ZD2uqqqxiZM6j9+utu+MRNMBibaqSEfLkmaFOVMRSJnnKVhGNkD+Rs+zghPWkhjUVzzBpS1EvnoonS8bKLaRg3GeJMwkiB3frDGy8imhJYRuKJ5HF2LuOPNd91xCQGviNxxm4mAWrzlWGJnAKvaty5glYEPF5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eH6+wENt; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2e8a73a9-67b9-4d87-844a-c43571055605@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758645611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tgdmwUFP1TxgY5YVNxX2Bwzs9UbKZtDazUizAj9xwwI=;
	b=eH6+wENtuLzK4+QkYovTId+JplvAdu9t+dGuSmN8BUpGS5geCDBSpZCJ+cOQeYT9NevJVE
	gkXFZPfmzMtv4QyjP0QVbzS5mvgAOVqqyVXPV+8X/4B84n8pz4gzNX8EKBrtZWAl8t1E1h
	8xqlgOZx9qcE5YfwDgyQorH+7LOA8/c=
Date: Wed, 24 Sep 2025 00:40:01 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next v2 5/6] libbpf: Add common attr support for
 map_create
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, menglong8.dong@gmail.com
References: <20250911163328.93490-1-leon.hwang@linux.dev>
 <20250911163328.93490-6-leon.hwang@linux.dev>
 <CAEf4BzZ5R-H+XL6TPftv6KGFnowA1yeCXii7OZ9uq_A-zFrjJg@mail.gmail.com>
 <CAEf4BzY233bt3NdVu8tp7VVmyNWVk-DQB+wQ-uchBJA4Ya3p-g@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAEf4BzY233bt3NdVu8tp7VVmyNWVk-DQB+wQ-uchBJA4Ya3p-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/9/18 05:46, Andrii Nakryiko wrote:
> On Wed, Sep 17, 2025 at 2:45 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
>>
>> On Thu, Sep 11, 2025 at 9:33 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>>
>>> With the previous patch adding common attribute support for
>>> BPF_MAP_CREATE, it is now possible to retrieve detailed error messages
>>> when map creation fails by using the 'log_buf' field from the common
>>> attributes.
>>>
>>> This patch extends 'bpf_map_create_opts' with two new fields, 'log_buf'
>>> and 'log_size', allowing users to capture and inspect these log messages.
>>>
>>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
>>> ---
>>>  tools/lib/bpf/bpf.c | 16 +++++++++++++++-
>>>  tools/lib/bpf/bpf.h |  5 ++++-
>>>  2 files changed, 19 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
>>> index 27845e287dd5c..5b58e981a7669 100644
>>> --- a/tools/lib/bpf/bpf.c
>>> +++ b/tools/lib/bpf/bpf.c
>>> @@ -218,7 +218,9 @@ int bpf_map_create(enum bpf_map_type map_type,
>>>                    const struct bpf_map_create_opts *opts)
>>>  {
>>>         const size_t attr_sz = offsetofend(union bpf_attr, map_token_fd);
>>> +       struct bpf_common_attr common_attrs;
>>>         union bpf_attr attr;
>>> +       __u64 log_buf;
>>
>>
>> const char *
>>

Ack.

>>>         int fd;
>>>
>>>         bump_rlimit_memlock();
>>> @@ -249,7 +251,19 @@ int bpf_map_create(enum bpf_map_type map_type,
>>>
>>>         attr.map_token_fd = OPTS_GET(opts, token_fd, 0);
>>>
>>> -       fd = sys_bpf_fd(BPF_MAP_CREATE, &attr, attr_sz);
>>> +       log_buf = (__u64) OPTS_GET(opts, log_buf, NULL);
>>
>> no u64 casting just yet
>>

Ack.

>>> +       if (log_buf) {
>>> +               if (!feat_supported(NULL, FEAT_EXTENDED_SYSCALL))
>>> +                       return libbpf_err(-EOPNOTSUPP);
>>
>> um.. I'm thinking that it would be better usability for libbpf to
>> ignore provided log if kernel doesn't support this feature just yet.
>> Then users don't have to care, they will just opportunistically
>> provide buffer and get extra error log, if kernel supports this
>> feature. Otherwise, log won't be touched, instead of failing an API
>> call.
>>

Agreed.

These two 'if's will be merged into one:

if (log_buf && feat_supported(NULL, FEAT_EXTENDED_SYSCALL)) {
    ...
}

>>> +
>>> +               memset(&common_attrs, 0, sizeof(common_attrs));
>>> +               common_attrs.log_buf = log_buf;
>>
>> ptr_to_u64(log_buf) here
>>

Ack.

>>> +               common_attrs.log_size = OPTS_GET(opts, log_size, 0);
>>> +               fd = sys_bpf_extended(BPF_MAP_CREATE, &attr, attr_sz, &common_attrs,
>>> +                                     sizeof(common_attrs));
>>> +       } else {
>>> +               fd = sys_bpf_fd(BPF_MAP_CREATE, &attr, attr_sz);
>>> +       }
>>>         return libbpf_err_errno(fd);
>>>  }
>>>
>>> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
>>> index 38819071ecbe7..3b54d6feb5842 100644
>>> --- a/tools/lib/bpf/bpf.h
>>> +++ b/tools/lib/bpf/bpf.h
>>> @@ -55,9 +55,12 @@ struct bpf_map_create_opts {
>>>         __s32 value_type_btf_obj_fd;
>>>
>>>         __u32 token_fd;
>>> +
>>> +       const char *log_buf;
>>> +       __u32 log_size;
>
> also, what about that log_level ?
>

Should we really introduce log_level here?

I don’t think it makes sense, because logging in map_create is too
simple for different log levels on the kernel side to have any
meaningful effect.

Thanks,
Leon

