Return-Path: <bpf+bounces-58446-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 002A8ABAAE1
	for <lists+bpf@lfdr.de>; Sat, 17 May 2025 17:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B259C3B103C
	for <lists+bpf@lfdr.de>; Sat, 17 May 2025 15:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921301F463A;
	Sat, 17 May 2025 15:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uvmfVcXx"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59663EA63
	for <bpf@vger.kernel.org>; Sat, 17 May 2025 15:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747496801; cv=none; b=LfGIKcsHA8q8iwupOma3WWqrx1xZWK/iBFt7DqZSd2b0JQyCZD1qFMIqgj8y/WuKILKoS87fXhfjWXeBk79rZrVqBTSQITjYqa/3Du+vI8fGVZ2c0N/ZWWfqTg6ztDMVawm8Pk+zKp6dsrrb839EoDe6MDfENd7wsIlcjhKgWqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747496801; c=relaxed/simple;
	bh=SsrPLfM8wthYD43S65xheBryIlvUKfHdOR+brJMbJKg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NFkYcjXOCsRAFra/jfVL2+pT1jxBEEE8erugnVpVz/3vRhdC5/OijRbT/XG+ab5X6z+Lvd7PuJOw5SFhm+e55rvJci+BvaeLQg56f+Kebw+4ze8UrIEo6GBHJoZvPCKQGT2VLfVfkfYtC9I4Yc9YcuoHsQS+qsH3Ohx0ExucO2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uvmfVcXx; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c35717eb-74d8-48b5-8ba3-c36e56e9eb0e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747496794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WI/79AbWQx3gG/Dmhht4xgAIYbS+IPsz7KSU3cLPE8w=;
	b=uvmfVcXxpawQ1bH2a98v6lZRoqJaiUfRg7QZOJRSG0jztjdLcTbZC9IoSR5tBnJ6W/2O6h
	9rQEzPaC6+UDK4NfiOhogTPTTIlTmytA9o4iwINsjXai5/cBeMn89RBhcG+qbtoX20eArV
	tRifJh7tf1vxI+q/CG0RpXsWeLxEV0w=
Date: Sat, 17 May 2025 08:46:23 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 2/4] bpf: Implement mprog API on top of
 existing cgroup progs
Content-Language: en-GB
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
References: <20250508223524.487875-1-yonghong.song@linux.dev>
 <20250508223534.488607-1-yonghong.song@linux.dev>
 <CAEf4BzZc4fqF2Ez3f1HuMt6xL6PYC6U3iOqgb53BQmkmH5rLWg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAEf4BzZc4fqF2Ez3f1HuMt6xL6PYC6U3iOqgb53BQmkmH5rLWg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 5/15/25 4:38 AM, Andrii Nakryiko wrote:
> On Thu, May 8, 2025 at 3:35 PM Yonghong Song <yonghong.song@linux.dev> wrote:
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
>>   - For attach, BPF_F_BEFORE/BPF_F_AFTER/BPF_F_ID is supported similar to
>>     kernel mprog but with different implementation.
>>   - For detach and replace, use the existing implementation.
>>   - For attach, detach and replace, the revision for a particular prog
>>     list, associated with a particular attach type, will be updated
>>     by increasing count by 1.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   include/uapi/linux/bpf.h       |   7 ++
>>   kernel/bpf/cgroup.c            | 144 ++++++++++++++++++++++++++++-----
>>   kernel/bpf/syscall.c           |  44 ++++++----
>>   tools/include/uapi/linux/bpf.h |   7 ++
>>   4 files changed, 165 insertions(+), 37 deletions(-)
>>
> [...]
>
>> +       if (!anchor_prog) {
>> +               hlist_for_each_entry(pltmp, progs, node) {
>> +                       if ((flags & BPF_F_BEFORE) && *ppltmp)
>> +                               break;
>> +                       *ppltmp = pltmp;
> This is be correct, but it's less obvious why because of all the
> loops, breaks, and NULL anchor prog. The idea here is to find the very
> first pl for BPF_F_BEFORE or the very last for BPF_F_AFTER, right? So
> wouldn't this be more obviously correct:
>
> hlist_for_each_entry(pltmp, progs, node) {
>      if (flags & BPF_F_BEFORE) {
>          *ppltmp = pltmp;
>          return NULL;
>      }
>      *ppltmp = pltmp;
> }
> return NULL;
>
>
> I.e., once you know the result, just return as early as possible and
> don't require tracing through the rest of code just to eventually
> return all the same (but now somewhat disguised) values.
>
>
> Though see my point about anchor_prog below, which will simplify this
> to just `return pltmp;`

Indeed, returning pltmp sounds a better idea. I will do that.

>
>
> I'd also add a comment that if there is no anchor_prog, then
> BPF_F_PREORDER doesn't matter because we either prepend or append to a
> combined list of progs and end up with correct result

Okay, will add such comments.


>
>> +               }
>> +       }  else {
>> +               hlist_for_each_entry(pltmp, progs, node) {
>> +                       pltmp_prog = pltmp->link ? pltmp->link->link.prog : pltmp->prog;
>> +                       if (pltmp_prog != anchor_prog)
>> +                               continue;
>> +                       if (!!(pltmp->flags & BPF_F_PREORDER) != preorder)
>> +                               goto out;
>> +                       *ppltmp = pltmp;
>> +                       break;
>> +               }
>> +               if (!*ppltmp) {
>> +                       ret = -ENOENT;
>> +                       goto out;
>> +               }
>> +       }
>> +
>> +       return anchor_prog;
>> +
>> +out:
>> +       bpf_prog_put(anchor_prog);
>> +       return ERR_PTR(ret);
>> +}
>> +
>> +static int insert_pl_to_hlist(struct bpf_prog_list *pl, struct hlist_head *progs,
>> +                             struct bpf_prog *prog, u32 flags, u32 id_or_fd)
>> +{
>> +       struct bpf_prog_list *pltmp = NULL;
>> +       struct bpf_prog *anchor_prog;
>> +
>> +       /* flags cannot have both BPF_F_BEFORE and BPF_F_AFTER */
>> +       if ((flags & BPF_F_BEFORE) && (flags & BPF_F_AFTER))
>> +               return -EINVAL;
> I think this should be handled by get_anchor_prog(), both BPF_F_AFTER
> and BPF_F_BEFORE will just result in no valid anchor program and we'll
> error out below

Yes. I will move the above flags checking to get_anchor_prog().

>
>> +
>> +       anchor_prog = get_anchor_prog(progs, prog, flags, id_or_fd, &pltmp);
>> +       if (IS_ERR(anchor_prog))
>> +               return PTR_ERR(anchor_prog);
> it's confusing that we return anchor_prog but actually never use it,
> no? wouldn't it make more sense to just return struct bpf_prog_list *
> for an anchor then?

Totally agree. Will return 'struct bpf_prog_list *'.

>
>> +
>> +       if (hlist_empty(progs))
>> +               hlist_add_head(&pl->node, progs);
>> +       else if (flags & BPF_F_BEFORE)
>> +               hlist_add_before(&pl->node, &pltmp->node);
>> +       else
>> +               hlist_add_behind(&pl->node, &pltmp->node);
>> +
>> +       return 0;
>> +}
>> +
>>   /**
>>    * __cgroup_bpf_attach() - Attach the program or the link to a cgroup, and
>>    *                         propagate the change to descendants
>> @@ -633,6 +710,8 @@ static struct bpf_prog_list *find_attach_entry(struct hlist_head *progs,
>>    * @replace_prog: Previously attached program to replace if BPF_F_REPLACE is set
>>    * @type: Type of attach operation
>>    * @flags: Option flags
>> + * @id_or_fd: Relative prog id or fd
>> + * @revision: bpf_prog_list revision
>>    *
>>    * Exactly one of @prog or @link can be non-null.
>>    * Must be called with cgroup_mutex held.
>> @@ -640,7 +719,8 @@ static struct bpf_prog_list *find_attach_entry(struct hlist_head *progs,
>>   static int __cgroup_bpf_attach(struct cgroup *cgrp,
>>                                 struct bpf_prog *prog, struct bpf_prog *replace_prog,
>>                                 struct bpf_cgroup_link *link,
>> -                              enum bpf_attach_type type, u32 flags)
>> +                              enum bpf_attach_type type, u32 flags, u32 id_or_fd,
>> +                              u64 revision)
>>   {
>>          u32 saved_flags = (flags & (BPF_F_ALLOW_OVERRIDE | BPF_F_ALLOW_MULTI));
>>          struct bpf_prog *old_prog = NULL;
>> @@ -656,6 +736,9 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
>>              ((flags & BPF_F_REPLACE) && !(flags & BPF_F_ALLOW_MULTI)))
>>                  /* invalid combination */
>>                  return -EINVAL;
>> +       if ((flags & BPF_F_REPLACE) && (flags & (BPF_F_BEFORE | BPF_F_AFTER)))
>> +               /* only either replace or insertion with before/after */
>> +               return -EINVAL;
>>          if (link && (prog || replace_prog))
>>                  /* only either link or prog/replace_prog can be specified */
>>                  return -EINVAL;
>> @@ -663,9 +746,12 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
>>                  /* replace_prog implies BPF_F_REPLACE, and vice versa */
>>                  return -EINVAL;
>>
>> +
> nit: unnecessary empty line?

Ack

>
>>          atype = bpf_cgroup_atype_find(type, new_prog->aux->attach_btf_id);
>>          if (atype < 0)
>>                  return -EINVAL;
>> +       if (revision && revision != cgrp->bpf.revisions[atype])
>> +               return -ESTALE;
>>
>>          progs = &cgrp->bpf.progs[atype];
>>
> [...]
>
>> @@ -1312,7 +1409,8 @@ int cgroup_bpf_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
>>          struct cgroup *cgrp;
>>          int err;
>>
>> -       if (attr->link_create.flags)
>> +       if (attr->link_create.flags &&
>> +           (attr->link_create.flags & (~(BPF_F_ID | BPF_F_BEFORE | BPF_F_AFTER | BPF_F_PREORDER))))
> why the `attr->link_create.flags &&` check, seems unnecessary
>
>
> also looking at BPF_F_ATTACH_MASK_MPROG, not allowing BPF_F_REPLACE
> makes sense, but BPF_F_LINK makes sense for ordering, no?

I didn't add BPF_F_LINK as my current implementation didn't support it.
But as you mentioned, mprog API does support it (to find anchor prog).
I will add support in the next revision.

>
>>                  return -EINVAL;
>>
>>          cgrp = cgroup_get_from_fd(attr->link_create.target_fd);
>> @@ -1336,7 +1434,9 @@ int cgroup_bpf_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
>>          }
>>
>>          err = cgroup_bpf_attach(cgrp, NULL, NULL, link,
>> -                               link->type, BPF_F_ALLOW_MULTI);
>> +                               link->type, BPF_F_ALLOW_MULTI | attr->link_create.flags,
>> +                               attr->link_create.cgroup.relative_fd,
>> +                               attr->link_create.cgroup.expected_revision);
>>          if (err) {
>>                  bpf_link_cleanup(&link_primer);
>>                  goto out_put_cgroup;
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> index df33d19c5c3b..58ea3c38eabb 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
>> @@ -4184,6 +4184,25 @@ static int bpf_prog_attach_check_attach_type(const struct bpf_prog *prog,
>>          }
>>   }
>>
>> +static bool is_cgroup_prog_type(enum bpf_prog_type ptype, enum bpf_attach_type atype,
>> +                               bool check_atype)
>> +{
>> +       switch (ptype) {
>> +       case BPF_PROG_TYPE_CGROUP_DEVICE:
>> +       case BPF_PROG_TYPE_CGROUP_SKB:
>> +       case BPF_PROG_TYPE_CGROUP_SOCK:
>> +       case BPF_PROG_TYPE_CGROUP_SOCK_ADDR:
>> +       case BPF_PROG_TYPE_CGROUP_SOCKOPT:
>> +       case BPF_PROG_TYPE_CGROUP_SYSCTL:
>> +       case BPF_PROG_TYPE_SOCK_OPS:
>> +               return true;
>> +       case BPF_PROG_TYPE_LSM:
>> +               return check_atype ? atype == BPF_LSM_CGROUP : true;
>> +       default:
>> +               return false;
>> +       }
>> +}
>> +
>>   #define BPF_PROG_ATTACH_LAST_FIELD expected_revision
>>
>>   #define BPF_F_ATTACH_MASK_BASE \
>> @@ -4214,6 +4233,9 @@ static int bpf_prog_attach(const union bpf_attr *attr)
>>          if (bpf_mprog_supported(ptype)) {
>>                  if (attr->attach_flags & ~BPF_F_ATTACH_MASK_MPROG)
>>                          return -EINVAL;
>> +       } else if (is_cgroup_prog_type(ptype, 0, false)) {
>> +               if (attr->attach_flags & BPF_F_LINK)
>> +                       return -EINVAL;
> Why disable BPF_F_LINK? It's just a matter of using FD/ID for link vs
> program to specify the place to attach. It doesn't mean that we need
> to attach through BPF link interface. Or am I misremembering?

Again, I didn't implement it. Will add support in the next revision.

>
>>          } else {
>>                  if (attr->attach_flags & ~BPF_F_ATTACH_MASK_BASE)
>>                          return -EINVAL;
>> @@ -4242,20 +4264,6 @@ static int bpf_prog_attach(const union bpf_attr *attr)
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
>> @@ -4264,7 +4272,10 @@ static int bpf_prog_attach(const union bpf_attr *attr)
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
> [...]


