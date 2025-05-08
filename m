Return-Path: <bpf+bounces-57731-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F99EAAF227
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 06:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 463729C6C4E
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 04:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B68D20A5E5;
	Thu,  8 May 2025 04:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VkGVnSQJ"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B338C1E
	for <bpf@vger.kernel.org>; Thu,  8 May 2025 04:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746679374; cv=none; b=ANn2KUHh7VfXz/kF0S0xsBAziP3XRtEn878QDPamFjwilV7EkCE9TGiF+YEkiQvt5G0qCjE7Us4/38SNO39laI9OxDZdkEPvRpOkobdDssvXY5CH9QBzOUlZrRmVKnQ0H40AUlvVlOTgDHTyW2yHvD04U7+44ixuVRLRFNucxdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746679374; c=relaxed/simple;
	bh=LdpKIEayUECPg/zpxTyw4/8POzOA+ehpI1roFzTCkzw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i6JMGfy89pSndobx2o5Ksp7BL0cebPDiheSIQQrKoJ4kO1psRoZdeYrZOAfkOdsOpbq+Fo8pb4CTjIFl8LoNon2RsPGuWrfjOQg8b6PPoqASNIuCtmPEI7qGk+RnNVr/gIhzKc6Y1PC1yZR2lgmCU1DHyOdwkL9//6UJ/TFP/dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VkGVnSQJ; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <01f9b38e-d14d-4e35-93aa-d9722a565474@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746679369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GqbKz26Owt6XjYVd8551lfvho9O5vyigB31ECbUz8lw=;
	b=VkGVnSQJD+kPG3xvCzzbXKBTFKbyH4csqq+v5SyLae06pVvM+Vsh5HnT7rtIuR0zuVBUzr
	pho4mmHvZdi/W5M6Ju9lKYDEZZGu9+BQ7Qs/9FaSnQm0AWwbeHMerVL4X+on5HBkoiRiLC
	+GV9rf8zC5qX4WwYBdqbppwtTVo2fVk=
Date: Wed, 7 May 2025 21:42:40 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next 2/4] bpf: Implement mprog API on top of
 existing cgroup progs
Content-Language: en-GB
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
References: <20250411011523.1838771-1-yonghong.song@linux.dev>
 <20250411011533.1839631-1-yonghong.song@linux.dev>
 <CAEf4BzbY9nZk32hoA7UNjfPVeMWzLh8FyVhG2rChoje0wyxxKw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAEf4BzbY9nZk32hoA7UNjfPVeMWzLh8FyVhG2rChoje0wyxxKw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 4/23/25 7:19 AM, Andrii Nakryiko wrote:
> On Thu, Apr 10, 2025 at 6:15 PM Yonghong Song <yonghong.song@linux.dev> wrote:
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
>>   kernel/bpf/cgroup.c            | 151 ++++++++++++++++++++++++++++-----
>>   kernel/bpf/syscall.c           |  58 ++++++++-----
>>   tools/include/uapi/linux/bpf.h |   7 ++
>>   4 files changed, 181 insertions(+), 42 deletions(-)
>>
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index 71d5ac83cf5d..a5c7992e8f7c 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -1794,6 +1794,13 @@ union bpf_attr {
>>                                  };
>>                                  __u64           expected_revision;
>>                          } netkit;
>> +                       struct {
>> +                               union {
>> +                                       __u32   relative_fd;
>> +                                       __u32   relative_id;
>> +                               };
>> +                               __u64           expected_revision;
>> +                       } cgroup;
>>                  };
>>          } link_create;
>>
>> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
>> index 84f58f3d028a..ffd455051131 100644
>> --- a/kernel/bpf/cgroup.c
>> +++ b/kernel/bpf/cgroup.c
>> @@ -624,6 +624,90 @@ static struct bpf_prog_list *find_attach_entry(struct hlist_head *progs,
>>          return NULL;
>>   }
>>
>> +static struct bpf_prog *get_cmp_prog(struct hlist_head *progs, struct bpf_prog *prog,
>> +                                    u32 flags, u32 id_or_fd, struct bpf_prog_list **ppltmp)
>> +{
>> +       struct bpf_prog *cmp_prog = NULL, *pltmp_prog;
>> +       bool preorder = !!(flags & BPF_F_PREORDER);
> nit: !!() pattern is not necessary when assigning to bool and is just
> a visual and cognitive noise

Okay, will remove !! operators.

>
>> +       struct bpf_prog_list *pltmp;
>> +       bool id = flags & BPF_F_ID;
>> +       bool found;
>> +
>> +       if (id || id_or_fd) {
> let's invert the condition and exit early? also I find "id" as a bool
> very confusing, I think it's fine to just open-coded it in two places
> you actually check for BPF_F_ID flag.

Open-codedflags & BPF_F_ID is okay.

> But also, isn't this `if (id)` part redundant? Would just `if
> (id_or_fd)` be enough?

Yes, id_or_fd should be enough.

>
>
>> +               /* flags must have BPF_F_BEFORE or BPF_F_AFTER */
>> +               if (!(flags & (BPF_F_BEFORE | BPF_F_AFTER)))
>> +                       return ERR_PTR(-EINVAL);
>> +
>> +               if (id)
>> +                       cmp_prog = bpf_prog_by_id(id_or_fd);
>> +               else
>> +                       cmp_prog = bpf_prog_get(id_or_fd);
> how about we use "anchor" terminology here? So this would be "anchor
> program" or anchor_prog?

anchor_prog sounds good.

>
>> +               if (IS_ERR(cmp_prog))
>> +                       return cmp_prog;
>> +               if (cmp_prog->type != prog->type)
> bpf_prog_put?

Yes. Missed bpf_prog_put. Will fix.

>
> pw-bot: cr
>
>> +                       return ERR_PTR(-EINVAL);
>> +
>> +               found = false;
>> +               hlist_for_each_entry(pltmp, progs, node) {
>> +                       pltmp_prog = pltmp->link ? pltmp->link->link.prog : pltmp->prog;
>> +                       if (pltmp_prog == cmp_prog) {
> try keeping nesting minimal:
>
> if (pltmp_prog != cmp_prog)
>      continue;

Good point. Will do.

>
>> +                               if (!!(pltmp->flags & BPF_F_PREORDER) != preorder)
>> +                                       return ERR_PTR(-EINVAL);
>> +                               found = true;
>> +                               *ppltmp = pltmp;
> we don't need found flag if we set ppltmp to NULL before loop, and to
> non-NULL if we find the match

Ack.

>
>> +                               break;
>> +                       }
>> +               }
>> +               if (!found)
> bpf_prog_put(cmp_prog)

Again, will do bpf_prog_put before turn error.

>
>> +                       return ERR_PTR(-ENOENT);
>> +       }
>> +
>> +       return cmp_prog;
>> +}
>> +
>> +static int insert_pl_to_hlist(struct bpf_prog_list *pl, struct hlist_head *progs,
>> +                             struct bpf_prog *prog, u32 flags, u32 id_or_fd)
>> +{
>> +       struct hlist_node *last, *last_node = NULL;
>> +       struct bpf_prog_list *pltmp = NULL;
>> +       struct bpf_prog *cmp_prog;
>> +
>> +       /* flags cannot have both BPF_F_BEFORE and BPF_F_AFTER */
>> +       if ((flags & BPF_F_BEFORE) && (flags & BPF_F_AFTER))
>> +               return -EINVAL;
>> +
>> +       cmp_prog = get_cmp_prog(progs, prog, flags, id_or_fd, &pltmp);
> why get_cmp_prog can't return this last_node if we have BPF_F_AFTER
> with no id/fd specified? Then you wouldn't have to special-case
> appending (same for prepending, actually)?

We could do this. Let me try this.

>
>> +       if (IS_ERR(cmp_prog))
>> +               return PTR_ERR(cmp_prog);
>> +
>> +       if (hlist_empty(progs)) {
>> +               hlist_add_head(&pl->node, progs);
>> +       } else {
>> +               hlist_for_each(last, progs) {
>> +                       if (last->next)
>> +                               continue;
>> +                       last_node = last;
>> +                       break;
>> +               }
>> +
>> +               if (!cmp_prog) {
>> +                       if (flags & BPF_F_BEFORE)
>> +                               hlist_add_head(&pl->node, progs);
>> +                       else
>> +                               hlist_add_behind(&pl->node, last_node);
>> +               } else {
>> +                       if (flags & BPF_F_BEFORE)
>> +                               hlist_add_before(&pl->node, &pltmp->node);
>> +                       else if (flags & BPF_F_AFTER)
>> +                               hlist_add_behind(&pl->node, &pltmp->node);
>> +                       else
>> +                               hlist_add_behind(&pl->node, last_node);
>> +               }
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>>   /**
>>    * __cgroup_bpf_attach() - Attach the program or the link to a cgroup, and
>>    *                         propagate the change to descendants
>> @@ -633,6 +717,8 @@ static struct bpf_prog_list *find_attach_entry(struct hlist_head *progs,
>>    * @replace_prog: Previously attached program to replace if BPF_F_REPLACE is set
>>    * @type: Type of attach operation
>>    * @flags: Option flags
>> + * @id_or_fd: Relative prog id or fd
>> + * @revision: bpf_prog_list revision
>>    *
>>    * Exactly one of @prog or @link can be non-null.
>>    * Must be called with cgroup_mutex held.
>> @@ -640,7 +726,8 @@ static struct bpf_prog_list *find_attach_entry(struct hlist_head *progs,
>>   static int __cgroup_bpf_attach(struct cgroup *cgrp,
>>                                 struct bpf_prog *prog, struct bpf_prog *replace_prog,
>>                                 struct bpf_cgroup_link *link,
>> -                              enum bpf_attach_type type, u32 flags)
>> +                              enum bpf_attach_type type, u32 flags, u32 id_or_fd,
>> +                              u64 revision)
>>   {
>>          u32 saved_flags = (flags & (BPF_F_ALLOW_OVERRIDE | BPF_F_ALLOW_MULTI));
>>          struct bpf_prog *old_prog = NULL;
>> @@ -656,6 +743,9 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
>>              ((flags & BPF_F_REPLACE) && !(flags & BPF_F_ALLOW_MULTI)))
>>                  /* invalid combination */
>>                  return -EINVAL;
>> +       if ((flags & BPF_F_REPLACE) && (flags & (BPF_F_BEFORE | BPF_F_AFTER)))
>> +               /* only either replace or insertion with before/after */
>> +               return -EINVAL;
>>          if (link && (prog || replace_prog))
>>                  /* only either link or prog/replace_prog can be specified */
>>                  return -EINVAL;
>> @@ -663,9 +753,12 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
>>                  /* replace_prog implies BPF_F_REPLACE, and vice versa */
>>                  return -EINVAL;
>>
>> +
>>          atype = bpf_cgroup_atype_find(type, new_prog->aux->attach_btf_id);
>>          if (atype < 0)
>>                  return -EINVAL;
>> +       if (revision && revision != atomic64_read(&cgrp->bpf.revisions[atype]))
> this is happening under lock, no need for atomic operations

Ack

>
>> +               return -ESTALE;
>>
>>          progs = &cgrp->bpf.progs[atype];
>>
> [...]
>
>> @@ -1063,6 +1161,7 @@ static int __cgroup_bpf_query(struct cgroup *cgrp, const union bpf_attr *attr,
>>          struct bpf_prog_array *effective;
>>          int cnt, ret = 0, i;
>>          int total_cnt = 0;
>> +       u64 revision = 0;
>>          u32 flags;
>>
>>          if (effective_query && prog_attach_flags)
>> @@ -1100,6 +1199,10 @@ static int __cgroup_bpf_query(struct cgroup *cgrp, const union bpf_attr *attr,
>>                  return -EFAULT;
>>          if (copy_to_user(&uattr->query.prog_cnt, &total_cnt, sizeof(total_cnt)))
>>                  return -EFAULT;
>> +       if (!effective_query && from_atype == to_atype)
>> +               revision = atomic64_read(&cgrp->bpf.revisions[from_atype]);
> even here we hold cgroup_mutex

Ack

>
>> +       if (copy_to_user(&uattr->query.revision, &revision, sizeof(revision)))
>> +               return -EFAULT;
>>          if (attr->query.prog_cnt == 0 || !prog_ids || !total_cnt)
>>                  /* return early if user requested only program count + flags */
>>                  return 0;
> [...]
>
>> @@ -1336,7 +1441,9 @@ int cgroup_bpf_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
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
>> index 9794446bc8c6..48cf855f949f 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
>> @@ -4183,6 +4183,23 @@ static int bpf_prog_attach_check_attach_type(const struct bpf_prog *prog,
>>          }
>>   }
>>
>> +static bool bpf_cgroup_prog_attached(enum bpf_prog_type ptype)
> I find this "attached" naming misleading. I think the name should call
> out that we are just checking if program type is cgroup-attaching, so
> maybe something like "is_cgroup_prog_type", or something along those
> lines?
>
>
> But for LSM we need to look at expected_attach_type to be
> BPF_LSM_CGROUP, so maybe pass both prog type and expected attach type?

Yes, let us pass both prog type and expected attach type with
func name is_cgroup_prog_type().

>
>> +{
>> +       switch (ptype) {
>> +       case BPF_PROG_TYPE_CGROUP_DEVICE:
>> +       case BPF_PROG_TYPE_CGROUP_SKB:
>> +       case BPF_PROG_TYPE_CGROUP_SOCK:
>> +       case BPF_PROG_TYPE_CGROUP_SOCK_ADDR:
>> +       case BPF_PROG_TYPE_CGROUP_SOCKOPT:
>> +       case BPF_PROG_TYPE_CGROUP_SYSCTL:
>> +       case BPF_PROG_TYPE_SOCK_OPS:
>> +       case BPF_PROG_TYPE_LSM:
>> +               return true;
>> +       default:
>> +               return false;
>> +       }
>> +}
>> +
> [...]


