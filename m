Return-Path: <bpf+bounces-60127-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35764AD2B2B
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 03:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF548170960
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 01:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7680B19E7D1;
	Tue, 10 Jun 2025 01:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Io//o+xi"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECF029D19
	for <bpf@vger.kernel.org>; Tue, 10 Jun 2025 01:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749518421; cv=none; b=OLoL3dHUBWD1MdSs89uJfA3tURvKfmQ3WRYTPb8qsgBmTmvJw14B2XllnxHGWFm59nXGA6Dg0mEFrzPto8/lgaNLfMs7SQvhFUIaxmSUpHtBQxAH3LCPKONe2N4V+fQ24VXU/PEmZf0KhS53GU04OOJn6hxB0SMAPC7zPdTzN+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749518421; c=relaxed/simple;
	bh=Bv4qo+zZXm0ESy/BHn3jw90EqUNjBvXV+rAHvUTWn3Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iD3DltaeVg6oMi/UGwxRcPTJFpXz8FaIRCiJf+W4irXDoId3Yx9OAVJHKJW8Y0w79Lh6Q3PglDeCw/Ynv7DIlbTETdVie/TaZUpMsWI6TWshMqAoMTFetpo4yEj7aLs9GaiD2UrCj1P8YrMyAOVn+MBp96nZLURNf/W4qrormZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Io//o+xi; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5ed5f8ad-4493-4dba-aa24-ad314d527c2e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749518412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4ohEPA2zTB5N9t8wvUKb+VmpT6FUDrTQuQVc390yvPM=;
	b=Io//o+xiX68w9NPPTxt+qCdjAw9U+QEvfODH0G+9PKw8GoJZSqe+GL+xtXQdeNnKaNOOh1
	EKtL1nK7kpec4s3vSTJvv0bq26miQQwwxna1y8c6b/0DPxVmfEdg9i8h7N9tF4S1DzMxXX
	nzYNZKE8R3nmkZdMk3sfHBhjKdRZxXk=
Date: Mon, 9 Jun 2025 18:20:00 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 2/5] bpf: Implement mprog API on top of
 existing cgroup progs
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
References: <20250606163131.2428225-1-yonghong.song@linux.dev>
 <20250606163141.2428937-1-yonghong.song@linux.dev>
 <CAEf4BzZjbJBpHE0eguipWgh8KWHG4Jh1jOORjMwsr7pVZ=qa6A@mail.gmail.com>
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAEf4BzZjbJBpHE0eguipWgh8KWHG4Jh1jOORjMwsr7pVZ=qa6A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 6/9/25 4:35 PM, Andrii Nakryiko wrote:
> On Fri, Jun 6, 2025 at 9:31 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>> Current cgroup prog ordering is appending at attachment time. This is not
>> ideal. In some cases, users want specific ordering at a particular cgroup
>> level. To address this, the existing mprog API seems an ideal solution with
>> supporting BPF_F_BEFORE and BPF_F_AFTER flags.
>>
>> But there are a few obstacles to directly use kernel mprog interface.
>> Currently cgroup bpf progs already support prog attach/detach/replace
>> and link-based attach/detach/replace. For example, in struct
>> bpf_prog_array_item, the cgroup_storage field needs to be together
>> with bpf prog. But the mprog API struct bpf_mprog_fp only has bpf_prog
>> as the member, which makes it difficult to use kernel mprog interface.
>>
>> In another case, the current cgroup prog detach tries to use the
>> same flag as in attach. This is different from mprog kernel interface
>> which uses flags passed from user space.
>>
>> So to avoid modifying existing behavior, I made the following changes to
>> support mprog API for cgroup progs:
>>   - The support is for prog list at cgroup level. Cross-level prog list
>>     (a.k.a. effective prog list) is not supported.
>>   - Previously, BPF_F_PREORDER is supported only for prog attach, now
>>     BPF_F_PREORDER is also supported by link-based attach.
>>   - For attach, BPF_F_BEFORE/BPF_F_AFTER/BPF_F_ID/BPF_F_LINK is supported
>>     similar to kernel mprog but with different implementation.
>>   - For detach and replace, use the existing implementation.
>>   - For attach, detach and replace, the revision for a particular prog
>>     list, associated with a particular attach type, will be updated
>>     by increasing count by 1.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   include/uapi/linux/bpf.h       |   7 ++
>>   kernel/bpf/cgroup.c            | 188 +++++++++++++++++++++++++++++----
>>   kernel/bpf/syscall.c           |  44 +++++---
>>   tools/include/uapi/linux/bpf.h |   7 ++
>>   4 files changed, 209 insertions(+), 37 deletions(-)
>>
> [...]
>
>> +static struct bpf_link *bpf_get_anchor_link(u32 flags, u32 id_or_fd)
>> +{
>> +       struct bpf_link *link = ERR_PTR(-EINVAL);
>> +
>> +       if (flags & BPF_F_ID)
>> +               link = bpf_link_by_id(id_or_fd);
>> +       else if (id_or_fd)
>> +               link = bpf_link_get_from_fd(id_or_fd);
>> +       if (IS_ERR(link))
>> +               return ERR_PTR(PTR_ERR(link));
> this can be just `return link;` (same below for prog)
>
> simplified while applying

In v4, the function returns a bpf_cgroup_link hence ERR_PTR(PTR_ERR(link)).
In v5, the return value is a link ptr, so it does make sense
to just 'return link'.

>
>> +
>> +       return link;
>> +}
>> +
> [...]
>
>> +       if (is_link) {
>> +               anchor_link = bpf_get_anchor_link(flags, id_or_fd);
>> +               if (IS_ERR(anchor_link))
>> +                       return ERR_PTR(PTR_ERR(anchor_link));
>> +       } else if (is_id || id_or_fd) {
> this can be just `else {` with no conditions, no? Basically, if
> BPF_F_LINK -- fetch link, otherwise assume program. Or am I missing
> something? I didn't touch this part, but maybe we can simplify this a
> bit in the follow up?

I followed the function bpf_mprog_tuple_relative() in mprog.c.
It has

	if (link)
		return bpf_mprog_link(tuple, id_or_fd, flags, type);
	/* If no relevant flag is set and no id_or_fd was passed, then
	 * tuple link/prog is just NULLed. This is the case when before/
	 * after selects first/last position without passing fd.
	 */
	if (!id && !id_or_fd)
		return 0;
	return bpf_mprog_prog(tuple, id_or_fd, flags, type);

So check anchor_prog only if 'id || id_or_fd'.

>
>> +               anchor_prog = bpf_get_anchor_prog(flags, id_or_fd);
>> +               if (IS_ERR(anchor_prog))
>> +                       return ERR_PTR(PTR_ERR(anchor_prog));
>> +       }
>> +
> [...]
>
>> @@ -4244,20 +4266,6 @@ static int bpf_prog_attach(const union bpf_attr *attr)
>>          case BPF_PROG_TYPE_FLOW_DISSECTOR:
>>                  ret = netns_bpf_prog_attach(attr, prog);
>>                  break;
>> -       case BPF_PROG_TYPE_CGROUP_DEVICE:
>> -       case BPF_PROG_TYPE_CGROUP_SKB:
>> -       case BPF_PROG_TYPE_CGROUP_SOCK:
>> -       case BPF_PROG_TYPE_CGROUP_SOCK_ADDR:
>> -       case BPF_PROG_TYPE_CGROUP_SOCKOPT:
>> -       case BPF_PROG_TYPE_CGROUP_SYSCTL:
>> -       case BPF_PROG_TYPE_SOCK_OPS:
>> -       case BPF_PROG_TYPE_LSM:
>> -               if (ptype == BPF_PROG_TYPE_LSM &&
>> -                   prog->expected_attach_type != BPF_LSM_CGROUP)
>> -                       ret = -EINVAL;
>> -               else
>> -                       ret = cgroup_bpf_prog_attach(attr, ptype, prog);
>> -               break;
>>          case BPF_PROG_TYPE_SCHED_CLS:
>>                  if (attr->attach_type == BPF_TCX_INGRESS ||
>>                      attr->attach_type == BPF_TCX_EGRESS)
>> @@ -4266,7 +4274,10 @@ static int bpf_prog_attach(const union bpf_attr *attr)
>>                          ret = netkit_prog_attach(attr, prog);
>>                  break;
>>          default:
>> -               ret = -EINVAL;
>> +               if (!is_cgroup_prog_type(ptype, prog->expected_attach_type, true))
>> +                       ret = -EINVAL;
>> +               else
>> +                       ret = cgroup_bpf_prog_attach(attr, ptype, prog);
> I tried to get used to this is_cgroup_prog_type() check inside
> switch's default, but it feels too surprising and ugly. I moved it to
> before the switch to be more explicit. I hope you don't mind.
>
> I ended up with this diff on top of your patches:
>
> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index c3ac5661da27..ffbafbef5010 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -666,9 +666,6 @@ static struct bpf_link *bpf_get_anchor_link(u32
> flags, u32 id_or_fd)
>                  link = bpf_link_by_id(id_or_fd);
>          else if (id_or_fd)
>                  link = bpf_link_get_from_fd(id_or_fd);
> -       if (IS_ERR(link))
> -               return ERR_PTR(PTR_ERR(link));
> -
>          return link;
>   }
>
> @@ -680,9 +677,6 @@ static struct bpf_prog *bpf_get_anchor_prog(u32
> flags, u32 id_or_fd)
>                  prog = bpf_prog_by_id(id_or_fd);
>          else if (id_or_fd)
>                  prog = bpf_prog_get(id_or_fd);
> -       if (IS_ERR(prog))
> -               return prog;
> -

This make senses as well (due to my previous v4 change).

>          return prog;
>   }
>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 2035093eeeb3..97ad57ffc404 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -4255,6 +4255,11 @@ static int bpf_prog_attach(const union bpf_attr *attr)
>                  return -EINVAL;
>          }
>
> +       if (is_cgroup_prog_type(ptype, prog->expected_attach_type, true)) {
> +               ret = cgroup_bpf_prog_attach(attr, ptype, prog);
> +               goto out;
> +       }

This makes logic easier to understand. thanks!

> +
>          switch (ptype) {
>          case BPF_PROG_TYPE_SK_SKB:
>          case BPF_PROG_TYPE_SK_MSG:
> @@ -4274,12 +4279,9 @@ static int bpf_prog_attach(const union bpf_attr *attr)
>                          ret = netkit_prog_attach(attr, prog);
>                  break;
>          default:
> -               if (!is_cgroup_prog_type(ptype,
> prog->expected_attach_type, true))
> -                       ret = -EINVAL;
> -               else
> -                       ret = cgroup_bpf_prog_attach(attr, ptype, prog);
> +               ret = -EINVAL;
>          }
> -
> +out:
>          if (ret)
>                  bpf_prog_put(prog);
>          return ret;


