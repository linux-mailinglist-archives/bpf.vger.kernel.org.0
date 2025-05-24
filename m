Return-Path: <bpf+bounces-58874-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE580AC2CCD
	for <lists+bpf@lfdr.de>; Sat, 24 May 2025 03:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C11517A6EC4
	for <lists+bpf@lfdr.de>; Sat, 24 May 2025 01:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8301819CD01;
	Sat, 24 May 2025 01:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hzpcGUb0"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B90128EB
	for <bpf@vger.kernel.org>; Sat, 24 May 2025 01:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748048659; cv=none; b=Q1Gz0Nb/Pnmqzg1oAbf0vDLJKJt15+fX4qtSjnVkvspzGveX8a9ONhgoHXkQVsIyvts0TbCzV7RvRZTydHOKaVCUbQeY49/ABJHWrbh8kzzHKBoAn/QYQEieqMD+wt6nbya5nkUtn4f9i1PyPWxESzHxi0nakTYtOQTk5ZegvDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748048659; c=relaxed/simple;
	bh=xxKxC4sD5XRCoDpTDXIuV0MGaQrCNzDp39ie8XbZKBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MzTBej2Z1ewG/Z701RjVZzQpHEtiuGNL5I3PUHeqeuy+Lzy5rZ7WHke/z+srZDoYaHnWVwAEfRLmj/ELXmsBGQuyxrJa24uDxrwigbqxoBhHmdtT+doolIwcA8Jv0ysLcCw6eiB5GcpOS7ciC+vwxeygDy3EWJcW9//SWZL62pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hzpcGUb0; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <067aec4f-6847-4c86-9e93-1be8145b252a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748048651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XOEc+pTmwyRTGEW5PQbj34T8ED8M4OKOsHN5V2CPkCc=;
	b=hzpcGUb0rvKlDWnaQR37lyXkCM9Or4FNnOfuodsfxlo+3UNNK6fDmmJ6OBwQzs/v984Wxk
	Kc1Xj0tb2YCti0jM5P+UpqJXEC5bzIbexluPVHRiF5DGlCrf16u+89nuceo5Fo5K9EXo/w
	gotBjYi2rkwp8CMEkhxJXdko9IVu0/k=
Date: Fri, 23 May 2025 18:03:11 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 2/5] bpf: Implement mprog API on top of
 existing cgroup progs
Content-Language: en-GB
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
References: <20250517162720.4077882-1-yonghong.song@linux.dev>
 <20250517162731.4078451-1-yonghong.song@linux.dev>
 <CAEf4BzbnSKr9JrdO266cN1tdPDpQKOGRrxn+ZbSX7cM5jVQh2g@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAEf4BzbnSKr9JrdO266cN1tdPDpQKOGRrxn+ZbSX7cM5jVQh2g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 5/22/25 1:45 PM, Andrii Nakryiko wrote:
> On Sat, May 17, 2025 at 9:27 AM Yonghong Song <yonghong.song@linux.dev> wrote:
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
>>   kernel/bpf/cgroup.c            | 195 +++++++++++++++++++++++++++++----
>>   kernel/bpf/syscall.c           |  43 +++++---
>>   tools/include/uapi/linux/bpf.h |   7 ++
>>   4 files changed, 214 insertions(+), 38 deletions(-)
>>
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index 16e95398c91c..356cd2b185fb 100644
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
>> index 62a1d8deb3dc..78e6fc70b8f9 100644
>> --- a/kernel/bpf/cgroup.c
>> +++ b/kernel/bpf/cgroup.c
>> @@ -624,6 +624,129 @@ static struct bpf_prog_list *find_attach_entry(struct hlist_head *progs,
>>          return NULL;
>>   }
>>
>> +static struct bpf_link *bpf_get_anchor_link(u32 flags, u32 id_or_fd, enum bpf_prog_type type)
>> +{
>> +       struct bpf_link *link = ERR_PTR(-EINVAL);
>> +
>> +       if (flags & BPF_F_ID)
>> +               link = bpf_link_by_id(id_or_fd);
>> +       else if (id_or_fd)
>> +               link = bpf_link_get_from_fd(id_or_fd);
>> +       if (IS_ERR(link))
>> +               return link;
>> +       if (type && link->prog->type != type) {
>> +               bpf_link_put(link);
>> +               return ERR_PTR(-EINVAL);
>> +       }
>> +
>> +       return link;
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
>> +       if (type && prog->type != type) {
>> +               bpf_prog_put(prog);
>> +               return ERR_PTR(-EINVAL);
>> +       }
>> +
>> +       return prog;
>> +}
>> +
>> +static struct bpf_prog_list *get_prog_list(struct hlist_head *progs, struct bpf_prog *prog,
>> +                                          u32 flags, u32 id_or_fd)
>> +{
>> +       bool link = flags & BPF_F_LINK, id = flags & BPF_F_ID;
>> +       struct bpf_prog *anchor_prog = NULL, *pltmp_prog;
>> +       bool preorder = flags & BPF_F_PREORDER;
>> +       struct bpf_link *anchor_link = NULL;
>> +       struct bpf_prog_list *pltmp;
>> +       int ret = -EINVAL;
>> +
>> +       if (link || id || id_or_fd) {
> please, use "is_id" to make it obvious that this is bool, it's very
> confusing to see "id || id_or_fd"
>
> same for is_link, please

Okay, I am following mprog.c code like below:

====
static int bpf_mprog_link(struct bpf_tuple *tuple,
                           u32 id_or_fd, u32 flags,
                           enum bpf_prog_type type)
{
         struct bpf_link *link = ERR_PTR(-EINVAL);
         bool id = flags & BPF_F_ID;

         if (id)
                 link = bpf_link_by_id(id_or_fd);
         else if (id_or_fd)
                 link = bpf_link_get_from_fd(id_or_fd);
====

But agree is_id/is_link is more clear.

>
>> +               /* flags must have either BPF_F_BEFORE or BPF_F_AFTER */
>> +               if (!(flags & BPF_F_BEFORE) != !!(flags & BPF_F_AFTER))
> either/or here means exclusive or inclusive?
>
> if it's inclusive: if (flags & (BPF_F_BEFORE | BPF_F_AFTER)) should be
> enough to check that at least one of them is set
>
> if exclusive, below you use a different style of checking (which
> arguably is easier to follow), so let's stay consistent
>
>
> I got to say that my brain broke trying to reason about this pattern:
>
>     if (!(...) != !!(...))
>
> Way too many exclamations/negations, IMO... I'm not sure what sort of
> condition we are expressing here?

Sorry for confusion. What I mean is 'exclusive'. I guess I can do

bool is_before = flags & BPF_F_BEFORE;
bool is_after = flags & BPF_F_AFTER;
if (is_link || is_id || id_or_fd) {
     if (is_before == is_after)
         return ERR_PTR(-EINVAL);
} else if (!hist_empty(progs)) {
     if (is_before && is_after)
         return ERR_PTR(-EINVAL);
     ...
}

>
> pw-bot: cr
>
>> +                       return ERR_PTR(-EINVAL);
>> +       } else if (!hlist_empty(progs)) {
>> +               /* flags cannot have both BPF_F_BEFORE and BPF_F_AFTER */
>> +               if ((flags & BPF_F_BEFORE) && (flags & BPF_F_AFTER))
>> +                       return ERR_PTR(-EINVAL);
> do I understand correctly that neither BEFORE or AFTER might be set,
> in which case it must be BPF_F_REPLACE, is that right? Can it happen
> that we have neither REPLACE nor BEFORE/AFTER? Asked that below as
> well...

I think 'neither REPLACE nor BEFORE/AFTER' is possible. In that case,
the prog is appended to the prog list.

The code path here should not have REPLACE. See the code

         if (pl) {
                 old_prog = pl->prog;
         } else {
                 pl = kmalloc(sizeof(*pl), GFP_KERNEL);
                 if (!pl) {
                         bpf_cgroup_storages_free(new_storage);
                         return -ENOMEM;
                 }

                 err = insert_pl_to_hlist(pl, progs, prog ? : link->link.prog, flags, id_or_fd);
                 if (err) {
                         kfree(pl);
                         bpf_cgroup_storages_free(new_storage);
                         return err;
                 }
         }

If REPLACE is in the flag and prog replacement is successful, 'pl'
will not be null.

>
>> +       }
>> +
>> +       if (link) {
>> +               anchor_link = bpf_get_anchor_link(flags, id_or_fd, prog->type);
>> +               if (IS_ERR(anchor_link))
>> +                       return ERR_PTR(PTR_ERR(anchor_link));
>> +               anchor_prog = anchor_link->prog;
>> +       } else if (id || id_or_fd) {
>> +               anchor_prog = bpf_get_anchor_prog(flags, id_or_fd, prog->type);
>> +               if (IS_ERR(anchor_prog))
>> +                       return ERR_PTR(PTR_ERR(anchor_prog));
>> +       }
>> +
>> +       if (!anchor_prog) {
>> +               /* if there is no anchor_prog, then BPF_F_PREORDER doesn't matter
>> +                * since either prepend or append to a combined list of progs will
>> +                * end up with correct result.
>> +                */
>> +               hlist_for_each_entry(pltmp, progs, node) {
>> +                       if (flags & BPF_F_BEFORE)
>> +                               return pltmp;
>> +                       if (pltmp->node.next)
>> +                               continue;
>> +                       return pltmp;
>> +               }
>> +               return NULL;
>> +       }
>> +
>> +       hlist_for_each_entry(pltmp, progs, node) {
>> +               pltmp_prog = pltmp->link ? pltmp->link->link.prog : pltmp->prog;
>> +               if (pltmp_prog != anchor_prog)
>> +                       continue;
>> +               if (!!(pltmp->flags & BPF_F_PREORDER) != preorder)
>> +                       goto out;
> hm... thinking about this a bit more, is it illegal to have the same
> BPF program attached as PREORDER and POSTORDER? That seems legit to
> me, do we artificially disallow this?

Good question, in find_attach_entry(), we have

         hlist_for_each_entry(pl, progs, node) {
                 if (prog && pl->prog == prog && prog != replace_prog)
                         /* disallow attaching the same prog twice */
                         return ERR_PTR(-EINVAL);
                 if (link && pl->link == link)
                         /* disallow attaching the same link twice */
                         return ERR_PTR(-EINVAL);
         }

Basically, two same progs are not allowed. Here we didn't check PREORDER flag.
Should we relax this for this patch set?

>
> And so my proposal is instead of `goto out;` do `continue;` and write
> this loop as searching for an item and then checking whether that item
> was found after the loop.
>
>> +               if (anchor_link)
>> +                       bpf_link_put(anchor_link);
>> +               else
>> +                       bpf_prog_put(anchor_prog);
> and this duplicated cleanup would be best to avoid, given it's not
> just a singular bpf_prog_put()...

Will do.

>
>> +               return pltmp;
>> +       }
>> +
>> +       ret = -ENOENT;
>> +out:
>> +       if (anchor_link)
>> +               bpf_link_put(anchor_link);
>> +       else
>> +               bpf_prog_put(anchor_prog);
>> +       return ERR_PTR(ret);
>> +}
>> +
>> +static int insert_pl_to_hlist(struct bpf_prog_list *pl, struct hlist_head *progs,
>> +                             struct bpf_prog *prog, u32 flags, u32 id_or_fd)
>> +{
>> +       struct bpf_prog_list *pltmp;
>> +
>> +       pltmp = get_prog_list(progs, prog, flags, id_or_fd);
>> +       if (IS_ERR(pltmp))
>> +               return PTR_ERR(pltmp);
>> +
>> +       if (!pltmp)
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
>> @@ -633,6 +756,8 @@ static struct bpf_prog_list *find_attach_entry(struct hlist_head *progs,
>>    * @replace_prog: Previously attached program to replace if BPF_F_REPLACE is set
>>    * @type: Type of attach operation
>>    * @flags: Option flags
>> + * @id_or_fd: Relative prog id or fd
>> + * @revision: bpf_prog_list revision
>>    *
>>    * Exactly one of @prog or @link can be non-null.
>>    * Must be called with cgroup_mutex held.
>> @@ -640,7 +765,8 @@ static struct bpf_prog_list *find_attach_entry(struct hlist_head *progs,
>>   static int __cgroup_bpf_attach(struct cgroup *cgrp,
>>                                 struct bpf_prog *prog, struct bpf_prog *replace_prog,
>>                                 struct bpf_cgroup_link *link,
>> -                              enum bpf_attach_type type, u32 flags)
>> +                              enum bpf_attach_type type, u32 flags, u32 id_or_fd,
>> +                              u64 revision)
>>   {
>>          u32 saved_flags = (flags & (BPF_F_ALLOW_OVERRIDE | BPF_F_ALLOW_MULTI));
>>          struct bpf_prog *old_prog = NULL;
>> @@ -656,6 +782,9 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
>>              ((flags & BPF_F_REPLACE) && !(flags & BPF_F_ALLOW_MULTI)))
>>                  /* invalid combination */
>>                  return -EINVAL;
>> +       if ((flags & BPF_F_REPLACE) && (flags & (BPF_F_BEFORE | BPF_F_AFTER)))
> but can it be that neither is set?

I would say it is possible. In that case, the new prog is appended to
the end of prog list.

>
>> +               /* only either replace or insertion with before/after */
>> +               return -EINVAL;
>>          if (link && (prog || replace_prog))
>>                  /* only either link or prog/replace_prog can be specified */
>>                  return -EINVAL;
> [...]


