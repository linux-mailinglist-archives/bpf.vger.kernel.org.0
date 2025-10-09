Return-Path: <bpf+bounces-70640-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A4ABC7696
	for <lists+bpf@lfdr.de>; Thu, 09 Oct 2025 07:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BBC319E4BC3
	for <lists+bpf@lfdr.de>; Thu,  9 Oct 2025 05:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E896425522B;
	Thu,  9 Oct 2025 05:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hdYwunMd"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726271863E
	for <bpf@vger.kernel.org>; Thu,  9 Oct 2025 05:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759986915; cv=none; b=VW6PaX3Z0+ZGejzhQQTC2kv67hfb1MxVOA0+SWCRfVo/ENfHAfLPBVNmwLhcVRtPUU4gKpUTEfuegvF1vWZQMZqv7nSNxvJGWzfyvYrQZ4YxcjMnpjweLUZaoiWkDbQhhelXW3opiqRSa3zzOCKOZyc8FTweveRZI4S+AVhOJNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759986915; c=relaxed/simple;
	bh=hqBXsWPKReLz9LZ8krUyi3BUZW+u8N/A7yVKpo4D2yY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hjzWaukTly1VB+D6Amn5EO1dLu9/EG0BOTdWMsLFc8JXAv3AEQ1zHpcHdFR4DH7rF+wLt28k2d8XFoCu50ovICQeezRIZFZNHGaNLYCWPDXq4PJ31xxD0fnofga/V1UcVGCrtYoJsLYC94rs1MUeilomSNHrYXyJLiveTKtzzzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hdYwunMd; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e8580e7e-05f5-4b28-9709-1b46712469a2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759986910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=665d1WN3x3XS/tIXF12imEW+cMGaatMKQ0vVnsRKUS0=;
	b=hdYwunMdJ/hZun4s2xa7aKlFvvwT4/d5hlH5xa1WV2/oBpGBIX4i3Yu5VpJxDgcdHn3KDf
	xAGcOrPut7GnmPTTqInDor6DjGCT/C4ZbKE62Bjpo7/s2JOsMv7SYD1HkydXCaA/xQ+3jj
	06iQl2r84VZwNgBeEcPLb7GnLxzbONk=
Date: Thu, 9 Oct 2025 13:15:01 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next v3 02/10] libbpf: Add support for extended
 bpf syscall
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net
References: <20251002154841.99348-1-leon.hwang@linux.dev>
 <20251002154841.99348-3-leon.hwang@linux.dev>
 <CAEf4BzZm+51H6hRq1UOTyXi7UtRX9o3Y8Fr_GS_UkaqJJX4d1g@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAEf4BzZm+51H6hRq1UOTyXi7UtRX9o3Y8Fr_GS_UkaqJJX4d1g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 7/10/25 07:08, Andrii Nakryiko wrote:
> On Thu, Oct 2, 2025 at 8:49 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>> To support the extended 'bpf()' syscall introduced in the previous commit,
>> introduce the following internal APIs:
>>
>> * 'sys_bpf_ext()'
>> * 'sys_bpf_ext_fd()'
>>   They wrap the raw 'syscall()' interface to support passing extended
>>   attributes.
>> * 'probe_sys_bpf_ext()'
>>   Check whether current kernel supports the extended attributes.
>>
>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
>> ---
>>  tools/lib/bpf/bpf.c             | 33 +++++++++++++++++++++++++++++++++
>>  tools/lib/bpf/features.c        |  8 ++++++++
>>  tools/lib/bpf/libbpf_internal.h |  3 +++
>>  3 files changed, 44 insertions(+)
>>
>> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
>> index 339b197972374..9cd79beb13a2d 100644
>> --- a/tools/lib/bpf/bpf.c
>> +++ b/tools/lib/bpf/bpf.c
>> @@ -69,6 +69,39 @@ static inline __u64 ptr_to_u64(const void *ptr)
>>         return (__u64) (unsigned long) ptr;
>>  }
>>
>> +static inline int sys_bpf_ext(enum bpf_cmd cmd, union bpf_attr *attr,
>> +                             unsigned int size,
>> +                             struct bpf_common_attr *common_attrs,
>> +                             unsigned int size_common)
>> +{
>> +       cmd = common_attrs ? cmd | BPF_COMMON_ATTRS : cmd & ~BPF_COMMON_ATTRS;
>
> nit: put those () two branches of ternary operator, there is no need
> to rely on obscure C operator precedence order here
>

Ack.

>> +       return syscall(__NR_bpf, cmd, attr, size, common_attrs, size_common);
>> +}
>> +
>> +static inline int sys_bpf_ext_fd(enum bpf_cmd cmd, union bpf_attr *attr,
>> +                                unsigned int size,
>> +                                struct bpf_common_attr *common_attrs,
>> +                                unsigned int size_common)
>> +{
>> +       int fd;
>> +
>> +       fd = sys_bpf_ext(cmd, attr, size, common_attrs, size_common);
>> +       return ensure_good_fd(fd);
>> +}
>> +
>> +int probe_sys_bpf_ext(void)
>> +{
>> +       const size_t attr_sz = offsetofend(union bpf_attr, prog_token_fd);
>> +       union bpf_attr attr;
>> +       int fd;
>> +
>> +       memset(&attr, 0, attr_sz);
>> +       fd = syscall(__NR_bpf, BPF_PROG_LOAD | BPF_COMMON_ATTRS, &attr, attr_sz, NULL,
>> +                    sizeof(struct bpf_common_attr));
>> +       fd = errno == EFAULT ? syscall(__NR_memfd_create, "fd", 0) : fd;
>> +       return ensure_good_fd(fd);
>
> why do we need to create FD?..
>
>> +}
>> +
>>  static inline int sys_bpf(enum bpf_cmd cmd, union bpf_attr *attr,
>>                           unsigned int size)
>>  {
>> diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
>> index 760657f5224c2..d01df62394f89 100644
>> --- a/tools/lib/bpf/features.c
>> +++ b/tools/lib/bpf/features.c
>> @@ -507,6 +507,11 @@ static int probe_kern_arg_ctx_tag(int token_fd)
>>         return probe_fd(prog_fd);
>>  }
>>
>> +static int probe_kern_extended_syscall(int token_fd)
>> +{
>> +       return probe_fd(probe_sys_bpf_ext());
>> +}
>> +
>
> just do that feature detection right here without creating any new
> FDs... make sys_bpf_ext() exposed just like we do that with sys_bpf()
> and use this here
>

Ack.

Then I'll expose sys_bpf_ext() directly without creating any new FDs.

Thanks,
Leon

[...]

