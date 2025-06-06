Return-Path: <bpf+bounces-59874-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12256AD0664
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 18:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1B53175A78
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 16:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93B71DF749;
	Fri,  6 Jun 2025 16:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HFwDH/Q0"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F23A257D
	for <bpf@vger.kernel.org>; Fri,  6 Jun 2025 16:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749225837; cv=none; b=lQMUJXjQwsZGpkJBVCxo/c6l0BSNBITtM/fdw3lWLCJnaFMU7EvlTsXYXYmJG/XiLhGwBOsMVsqqiNLiLYTkTC/rKj/PohZ2ikIDhkHedERNkZ5wkll7sLR7SNvX7uHD1Kie1HLS5C+bXf0bsPibQq/pa0JL1qwVwzdenkobLDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749225837; c=relaxed/simple;
	bh=4p2Ku47N+Ft9DeMfntDB6NGKuzYoG02gbI+FGPus+v8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OpEq+AzhClN0nvyxHl2BrUBqpFYyelGAZyaH4TTsQGMtmi5+x6HbUCILUEcHPcA/Fa1b+tzvNLuAevbQK7uZA/+sTcP/VH2cTsw/s7hcO0lMX/ltxCKA8NVts99N3NndHps6AQgFbBPqwmv8Xnn/604Y9/M5dEac0yDMMscxdwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HFwDH/Q0; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <585716a5-c0f6-4f48-8396-825949acac1a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749225831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+4lJan6pFVxjruZpFTrW73gc67ZGaXewg1rob+eqe7Y=;
	b=HFwDH/Q0ttqhKcp1JfWDS30BNKbfcjPTyoMZPT7cUpJkOXUXNk9YREyXWkbaXwYv0q5fZt
	DpV9T4uNsqIGw7RmoKbBv8Tyjd0aRYAikEYXDdxzlV/ERS8E/kACNdsoyPfrPGmdXvnilN
	79BcluEydPTNQqmb+iBN9RxrLhWpJIw=
Date: Fri, 6 Jun 2025 09:03:44 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 2/5] bpf: Implement mprog API on top of
 existing cgroup progs
Content-Language: en-GB
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
References: <20250530173812.1823479-1-yonghong.song@linux.dev>
 <20250530173822.1824144-1-yonghong.song@linux.dev>
 <CAEf4BzZnE4rU7OpW8a4HYAN3=kJBB6j_YysjRHL-77PGstWkDQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAEf4BzZnE4rU7OpW8a4HYAN3=kJBB6j_YysjRHL-77PGstWkDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 6/5/25 1:30 PM, Andrii Nakryiko wrote:
> On Fri, May 30, 2025 at 10:38 AM Yonghong Song <yonghong.song@linux.dev> wrote:
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
>>   kernel/bpf/cgroup.c            | 197 +++++++++++++++++++++++++++++----
>>   kernel/bpf/syscall.c           |  43 ++++---
>>   tools/include/uapi/linux/bpf.h |   7 ++
>>   4 files changed, 216 insertions(+), 38 deletions(-)
>>
> [...]
>
>> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
>> index 9122c39870bf..bab580df5908 100644
>> --- a/kernel/bpf/cgroup.c
>> +++ b/kernel/bpf/cgroup.c
>> @@ -658,6 +658,131 @@ static struct bpf_prog_list *find_attach_entry(struct hlist_head *progs,
>>          return NULL;
>>   }
>>
>> +static struct bpf_cgroup_link *bpf_get_anchor_link(u32 flags, u32 id_or_fd,
>> +                                                  enum bpf_prog_type type)
>> +{
>> +       struct bpf_link *link = ERR_PTR(-EINVAL);
>> +
>> +       if (flags & BPF_F_ID)
>> +               link = bpf_link_by_id(id_or_fd);
>> +       else if (id_or_fd)
>> +               link = bpf_link_get_from_fd(id_or_fd);
>> +       if (IS_ERR(link))
>> +               return ERR_PTR(PTR_ERR(link));
>> +       if (link->type != BPF_LINK_TYPE_CGROUP || link->prog->type != type) {
> This check is a bit redundant and incomplete at the same time, so I'm
> wondering if it's better to just drop this check?
>
> It's redundant because if link or program is of wrong type, we won't
> find it in cgroup's list of links/progs and return -ENOENT.
>
> It's incomplete, because attach_type should be checked together with
> prog_type. But again, this doesn't matter because correct prog_type
> and incorrect attach_type would result in not finding the anchor link.
>
> So I'm just thinking if it would be just better to not check type here
> and let anchor prog/link logic return -ENOENT? WDYT?

Make sense. Will remove this 'if' condition.

>
>> +               bpf_link_put(link);
>> +               return ERR_PTR(-EINVAL);
>> +       }
>> +
>> +       return container_of(link, struct bpf_cgroup_link, link);
>> +}
>> +
>> +static struct bpf_prog *bpf_get_anchor_prog(u32 flags, u32 id_or_fd, enum bpf_prog_type type)
>> +{
>> +       struct bpf_prog *prog = ERR_PTR(-EINVAL);
>> +
>> +       if (flags & BPF_F_ID)
>> +               prog = bpf_prog_by_id(id_or_fd);
>> +       else if (id_or_fd)
>> +               prog = bpf_prog_get(id_or_fd);
>> +       if (IS_ERR(prog))
>> +               return prog;
>> +       if (prog->type != type) {
> same as for links above, it would make sense to check attach_type as
> well, but it ultimately doesn't matter because user will get
> -ENOENT... It's just the inconsistency (-EINVAL if prog_type
> mismatches, -ENOENT if attach_type mismatches), that makes we want to
> not check this type info here at all...

The same as above, will remove this 'if' statement.

>
>> +               bpf_prog_put(prog);
>> +               return ERR_PTR(-EINVAL);
>> +       }
>> +
>> +       return prog;
>> +}
>> +
> [...]
>
>>   #define BPF_PROG_ATTACH_LAST_FIELD expected_revision
>>
>>   #define BPF_F_ATTACH_MASK_BASE \
>> @@ -4215,7 +4234,7 @@ static int bpf_prog_attach(const union bpf_attr *attr)
>>          if (bpf_mprog_supported(ptype)) {
>>                  if (attr->attach_flags & ~BPF_F_ATTACH_MASK_MPROG)
>>                          return -EINVAL;
>> -       } else {
>> +       } else if (!is_cgroup_prog_type(ptype, 0, false)) {
> wouldn't we skip checking flags altogether for cgroup program types?  maybe:
>
> if (is_cgroup_prog_type(...)) {
>     /* check flags for cgroups */
> } else {
>     ...
> }

Indeed, I missed flag checking for is_cgroup_prog_type(...) case. Will fix!

>
> would be a safer pattern?
>
> pw-bot: cr
>
>>                  if (attr->attach_flags & ~BPF_F_ATTACH_MASK_BASE)
>>                          return -EINVAL;
>>                  if (attr->relative_fd ||
>> @@ -4243,20 +4262,6 @@ static int bpf_prog_attach(const union bpf_attr *attr)
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
>> @@ -4265,7 +4270,10 @@ static int bpf_prog_attach(const union bpf_attr *attr)
>>                          ret = netkit_prog_attach(attr, prog);
>>                  break;
>>          default:
>> -               ret = -EINVAL;
>> +               if (!is_cgroup_prog_type(ptype, prog->expected_attach_type, true))
>> +                       ret = -EINVAL;
>> +               else
>> +                       ret = cgroup_bpf_prog_attach(attr, ptype, prog);
>>          }
>>
>>          if (ret)
>> @@ -4295,6 +4303,9 @@ static int bpf_prog_detach(const union bpf_attr *attr)
>>                          if (IS_ERR(prog))
>>                                  return PTR_ERR(prog);
>>                  }
>> +       } else if (is_cgroup_prog_type(ptype, 0, false)) {
>> +               if (attr->attach_flags || attr->relative_fd)
>> +                       return -EINVAL;
>>          } else if (attr->attach_flags ||
>>                     attr->relative_fd ||
>>                     attr->expected_revision) {
> [...]


