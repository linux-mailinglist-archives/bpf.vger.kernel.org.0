Return-Path: <bpf+bounces-59188-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6B8AC6F43
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 19:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A9581652F1
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 17:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC65E28BA8B;
	Wed, 28 May 2025 17:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EvxN6vTa"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B09D1E5B6D
	for <bpf@vger.kernel.org>; Wed, 28 May 2025 17:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748453037; cv=none; b=HZ8QGTPUlhLEsHmpq4h6xywOXbqpjNJ8bicEHg1PfAbDnrK1BmS2nbvCtJtplQtVvNobEHLwIm2nK8o3T6RQZZX3tjuLEgDUZYFA6fGSfnBXYKVJbraPqXNlLHU4Ii2TTDEPS/ndLdgThoEBKEiFFUbQcS2IvL5l0KqJpGbWz1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748453037; c=relaxed/simple;
	bh=alXO9rRWMFzWnCVyWIsJ/ytdMT4PMZTdITLAW6S0gvE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u83W3PIy1/X7tSMjRGzJ6g1BWN9Z6h6J/uqd7FqPWChLrEYB5Ek9Hx960h0omLaH1UFIZcVnIitt8ZNi0pwzEHe7b9lfgvqQ7fy+nZYpm63r787MWgFJKrFWZ8qxDRF04xyRczf8tAgcbi7nN94sV1DhZ3pNntDGpDHgbyI3RGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EvxN6vTa; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5bfb5b19-40bd-4b37-a4a4-00e2a3473447@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748453032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=24Y5RQIoZksBEzEODLeAdhoOqGJGFsWHL6wbconqKnA=;
	b=EvxN6vTaY4BrxnRFoxAEIAF1b4q/f/MXrBrkXeqG1IfnPh9PHksspEK2Aaug8myvKD4Pfm
	t7QMV6JdsApRugOBbQqFaQIABGDZvK4mlPWDoBUGqvduggkt6F9ye9E1SdaxPBv0dxdOLj
	59Fmmoh9skBszpnMK1ok8Aa69hjfZRI=
Date: Wed, 28 May 2025 10:23:45 -0700
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
 <067aec4f-6847-4c86-9e93-1be8145b252a@linux.dev>
 <CAEf4BzZi7frCiq_vWfXb=QtNvpv91kf=9CymXNJUxRiPW7fxFQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAEf4BzZi7frCiq_vWfXb=QtNvpv91kf=9CymXNJUxRiPW7fxFQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 5/27/25 2:36 PM, Andrii Nakryiko wrote:
> On Fri, May 23, 2025 at 6:04 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>>
>> On 5/22/25 1:45 PM, Andrii Nakryiko wrote:
>>> On Sat, May 17, 2025 at 9:27 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>>>> Current cgroup prog ordering is appending at attachment time. This is not
>>>> ideal. In some cases, users want specific ordering at a particular cgroup
>>>> level. To address this, the existing mprog API seems an ideal solution with
>>>> supporting BPF_F_BEFORE and BPF_F_AFTER flags.
>>>>
>>>> But there are a few obstacles to directly use kernel mprog interface.
>>>> Currently cgroup bpf progs already support prog attach/detach/replace
>>>> and link-based attach/detach/replace. For example, in struct
>>>> bpf_prog_array_item, the cgroup_storage field needs to be together
>>>> with bpf prog. But the mprog API struct bpf_mprog_fp only has bpf_prog
>>>> as the member, which makes it difficult to use kernel mprog interface.
>>>>
>>>> In another case, the current cgroup prog detach tries to use the
>>>> same flag as in attach. This is different from mprog kernel interface
>>>> which uses flags passed from user space.
>>>>
>>>> So to avoid modifying existing behavior, I made the following changes to
>>>> support mprog API for cgroup progs:
>>>>    - The support is for prog list at cgroup level. Cross-level prog list
>>>>      (a.k.a. effective prog list) is not supported.
>>>>    - Previously, BPF_F_PREORDER is supported only for prog attach, now
>>>>      BPF_F_PREORDER is also supported by link-based attach.
>>>>    - For attach, BPF_F_BEFORE/BPF_F_AFTER/BPF_F_ID/BPF_F_LINK is supported
>>>>      similar to kernel mprog but with different implementation.
>>>>    - For detach and replace, use the existing implementation.
>>>>    - For attach, detach and replace, the revision for a particular prog
>>>>      list, associated with a particular attach type, will be updated
>>>>      by increasing count by 1.
>>>>
>>>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>>>> ---
>>>>    include/uapi/linux/bpf.h       |   7 ++
>>>>    kernel/bpf/cgroup.c            | 195 +++++++++++++++++++++++++++++----
>>>>    kernel/bpf/syscall.c           |  43 +++++---
>>>>    tools/include/uapi/linux/bpf.h |   7 ++
>>>>    4 files changed, 214 insertions(+), 38 deletions(-)
>>>>
[...]

>>>> +       }
>>>> +
>>>> +       if (link) {
>>>> +               anchor_link = bpf_get_anchor_link(flags, id_or_fd, prog->type);
>>>> +               if (IS_ERR(anchor_link))
>>>> +                       return ERR_PTR(PTR_ERR(anchor_link));
>>>> +               anchor_prog = anchor_link->prog;
>>>> +       } else if (id || id_or_fd) {
>>>> +               anchor_prog = bpf_get_anchor_prog(flags, id_or_fd, prog->type);
>>>> +               if (IS_ERR(anchor_prog))
>>>> +                       return ERR_PTR(PTR_ERR(anchor_prog));
>>>> +       }
>>>> +
>>>> +       if (!anchor_prog) {
>>>> +               /* if there is no anchor_prog, then BPF_F_PREORDER doesn't matter
>>>> +                * since either prepend or append to a combined list of progs will
>>>> +                * end up with correct result.
>>>> +                */
>>>> +               hlist_for_each_entry(pltmp, progs, node) {
>>>> +                       if (flags & BPF_F_BEFORE)
>>>> +                               return pltmp;
>>>> +                       if (pltmp->node.next)
>>>> +                               continue;
>>>> +                       return pltmp;
>>>> +               }
>>>> +               return NULL;
>>>> +       }
>>>> +
>>>> +       hlist_for_each_entry(pltmp, progs, node) {
>>>> +               pltmp_prog = pltmp->link ? pltmp->link->link.prog : pltmp->prog;
>>>> +               if (pltmp_prog != anchor_prog)
>>>> +                       continue;
>>>> +               if (!!(pltmp->flags & BPF_F_PREORDER) != preorder)
>>>> +                       goto out;
>>> hm... thinking about this a bit more, is it illegal to have the same
>>> BPF program attached as PREORDER and POSTORDER? That seems legit to
>>> me, do we artificially disallow this?
>> Good question, in find_attach_entry(), we have
>>
>>           hlist_for_each_entry(pl, progs, node) {
>>                   if (prog && pl->prog == prog && prog != replace_prog)
>>                           /* disallow attaching the same prog twice */
>>                           return ERR_PTR(-EINVAL);
>>                   if (link && pl->link == link)
>>                           /* disallow attaching the same link twice */
>>                           return ERR_PTR(-EINVAL);
>>           }
>>
>> Basically, two same progs are not allowed. Here we didn't check PREORDER flag.
>> Should we relax this for this patch set?
> So with BPF link-based attachment we already allow multiple same BPF
> programs to be attached, regardless of PREORDER. I don't think we need
> to make any relaxations for old-style program attachment. But your
> mprog API is, effectively ignoring link stuff and checking for
> uniqueness of the program (regardless of whether it came from link or
> not), which is problematic, I think, no?

You are correct. I should check link instead of prog for link-based
attachment in mprog. Will fix.

>
> [...]
>
>>>> @@ -640,7 +765,8 @@ static struct bpf_prog_list *find_attach_entry(struct hlist_head *progs,
>>>>    static int __cgroup_bpf_attach(struct cgroup *cgrp,
>>>>                                  struct bpf_prog *prog, struct bpf_prog *replace_prog,
>>>>                                  struct bpf_cgroup_link *link,
>>>> -                              enum bpf_attach_type type, u32 flags)
>>>> +                              enum bpf_attach_type type, u32 flags, u32 id_or_fd,
>>>> +                              u64 revision)
>>>>    {
>>>>           u32 saved_flags = (flags & (BPF_F_ALLOW_OVERRIDE | BPF_F_ALLOW_MULTI));
>>>>           struct bpf_prog *old_prog = NULL;
>>>> @@ -656,6 +782,9 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
>>>>               ((flags & BPF_F_REPLACE) && !(flags & BPF_F_ALLOW_MULTI)))
>>>>                   /* invalid combination */
>>>>                   return -EINVAL;
>>>> +       if ((flags & BPF_F_REPLACE) && (flags & (BPF_F_BEFORE | BPF_F_AFTER)))
>>> but can it be that neither is set?
>> I would say it is possible. In that case, the new prog is appended to
>> the end of prog list.
> ok, makes sense
>
>>>> +               /* only either replace or insertion with before/after */
>>>> +               return -EINVAL;
>>>>           if (link && (prog || replace_prog))
>>>>                   /* only either link or prog/replace_prog can be specified */
>>>>                   return -EINVAL;
>>> [...]


