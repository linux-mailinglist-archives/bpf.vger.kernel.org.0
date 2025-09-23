Return-Path: <bpf+bounces-69440-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8AE9B969CC
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 17:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DDFC1893563
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 15:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5572C1FF7C7;
	Tue, 23 Sep 2025 15:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YhpybtPc"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EFC14EC73
	for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 15:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758641800; cv=none; b=GaoMK45eDXun9u31i+JcjnGW7Kum5jkWHkUMLcbF3bA1xTXgDcb0mQtJutfM3KT9Ny9/45HtqAfBU2gFzwdn/yIoWrt7YgzAuifI9uoD+S/kwR4aDAtDBw+WqbKPiI+OzZlbh+V+ebi8IJ6roYNVWCxNukeK3LfPjIKENiFOnPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758641800; c=relaxed/simple;
	bh=LD43Jm0E1UrKNu5upIgXwOPFv9uWHrsgn7ffTd0YxLg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CoXb39P0RX3A86Tr9DzwirSzfTMiC6ZXN92YcX6Y20oxzA/FJEvyotnp7g09KHY+L+H/9Ve5x9VFDfpdq4xc5vCaXLtYYFi2Ho7B3JA2hlc73YQkYm3Kh+qML7qfF1hnYpcktioyTMZ/IxPYgGERUnj8jpdqKly9dAcrg+T0Pi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YhpybtPc; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d535ef7e-a7fb-41be-8550-bb0c0af045f9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758641796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l8+SaV47JRldF2oSXhhGk6noqWW9afWurBdLeVHVzIQ=;
	b=YhpybtPcm12p94V+S23qZ/c0bxpd3p6qTzIqK2vaZdbAEYPLsY0JWiim2GF69GxSU1xE67
	QLy+sR79Y1laV5gcr+TERYTkrzfCy5kIvkcNDNyDyi+ExW5pYYKfQK+6UHC0ff6khUStlq
	OUgd93qUctE2YrWElKcrRPRVHo0VVls=
Date: Tue, 23 Sep 2025 23:36:29 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next v2 2/6] libbpf: Add support for extended bpf
 syscall
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, menglong8.dong@gmail.com
References: <20250911163328.93490-1-leon.hwang@linux.dev>
 <20250911163328.93490-3-leon.hwang@linux.dev>
 <CAEf4BzZp8vb3EYwvSCbewdZi0eKZjW5sJkDnm6YfPqaRbjf2NA@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAEf4BzZp8vb3EYwvSCbewdZi0eKZjW5sJkDnm6YfPqaRbjf2NA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/9/17 08:06, Andrii Nakryiko wrote:
> On Thu, Sep 11, 2025 at 9:33 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>> To support the extended 'bpf()' syscall introduced in the previous commit,
>> this patch adds the following APIs:
>>
>> 1. *Internal:*
>>
>>    * 'sys_bpf_extended()'
>>    * 'sys_bpf_fd_extended()'
>>      These wrap the raw 'syscall()' interface to support passing extended
>>      attributes.
>>
>> 2. *Exported:*
>>
>>    * 'probe_sys_bpf_extended()'
>>      This function checks whether the running kernel supports the extended
>>      'bpf()' syscall with common attributes.
>>
>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
>> ---
>>  tools/lib/bpf/bpf.c             | 45 +++++++++++++++++++++++++++++++++
>>  tools/lib/bpf/bpf.h             |  1 +
>>  tools/lib/bpf/features.c        |  8 ++++++
>>  tools/lib/bpf/libbpf.map        |  2 ++
>>  tools/lib/bpf/libbpf_internal.h |  2 ++
>>  5 files changed, 58 insertions(+)
>>
>
> (ran out of time, will continue reviewing the rest of patches
> tomorrow, so please don't yet send new revision)
>
>> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
>> index ab40dbf9f020f..27845e287dd5c 100644
>> --- a/tools/lib/bpf/bpf.c
>> +++ b/tools/lib/bpf/bpf.c
>> @@ -69,6 +69,51 @@ static inline __u64 ptr_to_u64(const void *ptr)
>>         return (__u64) (unsigned long) ptr;
>>  }
>>
>> +static inline int sys_bpf_extended(enum bpf_cmd cmd, union bpf_attr *attr,
>> +                                  unsigned int size,
>> +                                  struct bpf_common_attr *common_attrs,
>> +                                  unsigned int size_common)
>> +{
>> +       cmd = common_attrs ? cmd | BPF_COMMON_ATTRS : cmd & ~BPF_COMMON_ATTRS;
>> +       return syscall(__NR_bpf, cmd, attr, size, common_attrs, size_common);
>> +}
>> +
>> +static inline int sys_bpf_fd_extended(enum bpf_cmd cmd, union bpf_attr *attr,
>
> please shorten to sys_bpf_ext() and sys_bpf_ext_fd() (also note ext before fd)
>

The short ones look good to me.

>
>> +                                     unsigned int size,
>> +                                     struct bpf_common_attr *common_attrs,
>> +                                     unsigned int size_common)
>> +{
>> +       int fd;
>> +
>> +       fd = sys_bpf_extended(cmd, attr, size, common_attrs, size_common);
>> +       return ensure_good_fd(fd);
>> +}
>> +
>> +int probe_sys_bpf_extended(int token_fd)
>> +{
>> +       const size_t attr_sz = offsetofend(union bpf_attr, prog_token_fd);
>> +       struct bpf_common_attr common_attrs;
>> +       struct bpf_insn insns[] = {
>> +               BPF_MOV64_IMM(BPF_REG_0, 0),
>> +               BPF_EXIT_INSN(),
>> +       };
>> +       union bpf_attr attr;
>> +
>> +       memset(&attr, 0, attr_sz);
>> +       attr.prog_type = BPF_PROG_TYPE_SOCKET_FILTER;
>> +       attr.license = ptr_to_u64("GPL");
>> +       attr.insns = ptr_to_u64(insns);
>> +       attr.insn_cnt = (__u32)ARRAY_SIZE(insns);
>> +       attr.prog_token_fd = token_fd;
>> +       if (token_fd)
>> +               attr.prog_flags |= BPF_F_TOKEN_FD;
>> +       libbpf_strlcpy(attr.prog_name, "libbpf_sysbpftest", sizeof(attr.prog_name));
>> +       memset(&common_attrs, 0, sizeof(common_attrs));
>> +
>> +       return sys_bpf_fd_extended(BPF_PROG_LOAD, &attr, attr_sz, &common_attrs,
>> +                                  sizeof(common_attrs));
>
> I think we can set up this feature detector such that we get -EINVAL
> due to BPF_COMMON_ATTRS not supported on old kernels, while -EFAULT on
> newer kernels due to NULL passed in common_attrs. This would be cheap
> and simple. Try it.
>

Let me give that a try.

>> +}
>> +
>>  static inline int sys_bpf(enum bpf_cmd cmd, union bpf_attr *attr,
>>                           unsigned int size)
>>  {
>> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
>> index 7252150e7ad35..38819071ecbe7 100644
>> --- a/tools/lib/bpf/bpf.h
>> +++ b/tools/lib/bpf/bpf.h
>> @@ -35,6 +35,7 @@
>>  extern "C" {
>>  #endif
>>
>> +LIBBPF_API int probe_sys_bpf_extended(int token_fd);
>
> why adding this as a public UAPI?
>

If we don’t mark it with LIBBPF_API, the build fails when compiling libbpf.

My intention here wasn’t to introduce a new public UAPI, but simply to
provide a way for 'features.c' to probe whether the kernel supports the
extended BPF syscall, without directly exposing 'sys_bpf_fd_extended()'.

Do you have a suggestion on how we can perform this probe without
introducing a new LIBBPF_API symbol?

Thanks,
Leon

