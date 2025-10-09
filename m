Return-Path: <bpf+bounces-70641-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 569D9BC771A
	for <lists+bpf@lfdr.de>; Thu, 09 Oct 2025 07:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 048824F1B3F
	for <lists+bpf@lfdr.de>; Thu,  9 Oct 2025 05:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0021A25FA2D;
	Thu,  9 Oct 2025 05:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ais/bKJ/"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F03E54279
	for <bpf@vger.kernel.org>; Thu,  9 Oct 2025 05:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759988154; cv=none; b=sm0h8GEXXoyA7rw5v3TjrV195x+Ph9ry7hCrVlu93uS/NVsFcAmRrraLpwkGVC89v3tA59QFeUYVkM1TVq4s5d5kV/JnjZ5IGx0/oFyINMnmoZutV6feDKOqMQK5Cxd0LQOmHWLbNZNSlGYDNkMvrZHxmphG5EaxFO8y5gEdWeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759988154; c=relaxed/simple;
	bh=dNzku9PPu7wJCqTGX0cbw0u9FQieicuwWq0y1C4C9Wo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qz4f28viwanFO4C8wDJc5Q+oHnExQdYDHqVy1LPGDCUgGyVdCR/ATZjx5SUgLI0MnF4gUT9dSdGco75DX3WhBSs6swvswuR9cwOcSEBKhFouRcGtym2Ez31jEtsv0yBjbU6UGY+9DovtnzaAlBENmFUWSj1yuMl1YFKdZq/QUqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ais/bKJ/; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <16e155c2-294a-48b6-9339-75aa4edf8048@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759988149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BOFwhOPizNQWqRYv527MztiFJ1SjgsZL/SRmNnmQphA=;
	b=ais/bKJ/03Kl6O/0QcDDcMdPhtY91nVcsTgz4EBZJCb/iU/y5nsMORHvs64F0bjNs/7ZkP
	6bQGOboJTyNbcEPAwLM0hT48WQE+BXx/xx6VYQ7rnalU/iy/M3UGxmtlazivQ0UsLAuGaT
	NCwflXbXetdRqM6Ymlt3ahd7nRZHLAM=
Date: Thu, 9 Oct 2025 13:35:36 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next v3 09/10] libbpf: Add common attr support for
 map_create
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net
References: <20251002154841.99348-1-leon.hwang@linux.dev>
 <20251002154841.99348-10-leon.hwang@linux.dev>
 <CAEf4Bzaw9cboFSf1OXmD84S7pKaeyj=bcQg_diUzGwAkFsjUgg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAEf4Bzaw9cboFSf1OXmD84S7pKaeyj=bcQg_diUzGwAkFsjUgg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 7/10/25 07:08, Andrii Nakryiko wrote:
> On Thu, Oct 2, 2025 at 8:49 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>> With the previous commit adding common attribute support for
>> BPF_MAP_CREATE, it is now possible to retrieve detailed error messages
>> when map creation fails by using the 'log_buf' field from the common
>> attributes.
>>
>> Extend 'bpf_map_create_opts' with these new fields, 'log_buf', 'log_size'
>> , 'log_level' and 'log_true_size', allowing users to capture and inspect
>
> comma
>

Ack.

>> those log messages.
>>
>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
>> ---
>>  tools/lib/bpf/bpf.c | 17 +++++++++++++++--
>>  tools/lib/bpf/bpf.h |  9 +++++++--
>>  2 files changed, 22 insertions(+), 4 deletions(-)
>>
>> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
>> index 9cd79beb13a2d..ca66fcdb3f49f 100644
>> --- a/tools/lib/bpf/bpf.c
>> +++ b/tools/lib/bpf/bpf.c
>> @@ -203,10 +203,13 @@ int bpf_map_create(enum bpf_map_type map_type,
>>                    __u32 key_size,
>>                    __u32 value_size,
>>                    __u32 max_entries,
>> -                  const struct bpf_map_create_opts *opts)
>> +                  struct bpf_map_create_opts *opts)
>
> this is a breaking change, see below
>
>>  {
>>         const size_t attr_sz = offsetofend(union bpf_attr, excl_prog_hash_size);
>> +       const size_t common_attrs_sz = sizeof(struct bpf_common_attr);
>> +       struct bpf_common_attr common_attrs;
>>         union bpf_attr attr;
>> +       const char *log_buf;
>>         int fd;
>>
>>         bump_rlimit_memlock();
>> @@ -239,7 +242,17 @@ int bpf_map_create(enum bpf_map_type map_type,
>>         attr.excl_prog_hash = ptr_to_u64(OPTS_GET(opts, excl_prog_hash, NULL));
>>         attr.excl_prog_hash_size = OPTS_GET(opts, excl_prog_hash_size, 0);
>>
>> -       fd = sys_bpf_fd(BPF_MAP_CREATE, &attr, attr_sz);
>> +       log_buf = OPTS_GET(opts, log_buf, NULL);
>> +       if (log_buf && feat_supported(NULL, FEAT_EXTENDED_SYSCALL)) {
>> +               memset(&common_attrs, 0, common_attrs_sz);
>> +               common_attrs.log_buf = ptr_to_u64(log_buf);
>> +               common_attrs.log_size = OPTS_GET(opts, log_size, 0);
>> +               common_attrs.log_level = OPTS_GET(opts, log_level, 0);
>> +               fd = sys_bpf_ext_fd(BPF_MAP_CREATE, &attr, attr_sz, &common_attrs, common_attrs_sz);
>> +               OPTS_SET(opts, log_true_size, common_attrs.log_true_size);
>> +       } else {
>> +               fd = sys_bpf_fd(BPF_MAP_CREATE, &attr, attr_sz);
>> +       }
>>         return libbpf_err_errno(fd);
>>  }
>>
>> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
>> index e983a3e40d612..77d475e7274a0 100644
>> --- a/tools/lib/bpf/bpf.h
>> +++ b/tools/lib/bpf/bpf.h
>> @@ -57,16 +57,21 @@ struct bpf_map_create_opts {
>>
>>         const void *excl_prog_hash;
>>         __u32 excl_prog_hash_size;
>> +
>> +       const char *log_buf;
>> +       __u32 log_size;
>> +       __u32 log_level;
>> +       __u32 log_true_size;
>
> I'm thinking that maybe we should have a separate struct that will
> have these 4 fields, and pass a pointer to it. That way
> bpf_map_create_opts can still be passed as const pointer, but libbpf
> will still be able to write out log_true_size without violating
> constness
>
> and then we can reuse the same type (struct bpf_log? struct
> bpf_log_buf? struct bpf_log_info? not sure, let's bikeshed) across
> different commands that support passing log info through
> bpf_common_attrs
>

Sure, that makes sense.

I add a new 'struct bpf_log_attr' to encapsulate these four fields, and
it works well in my local testing.

This also keeps bpf_map_create_opts const-safe while making it easier to
reuse the same structure for other commands using bpf_common_attrs.

Thanks,
Leon

[...]

