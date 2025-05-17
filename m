Return-Path: <bpf+bounces-58447-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9C0ABAAE5
	for <lists+bpf@lfdr.de>; Sat, 17 May 2025 17:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF3FD7A73DD
	for <lists+bpf@lfdr.de>; Sat, 17 May 2025 15:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356DE205ABB;
	Sat, 17 May 2025 15:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rtv8ZY7f"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD461EA90
	for <bpf@vger.kernel.org>; Sat, 17 May 2025 15:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747497003; cv=none; b=lJbetFpjTjlO/m7a6NC68KuEFX7pt4wrc1U6dUzK2omS/jYgc5wbeexSokwt7M/lTOqFD6WegG+SG/Zr3waVQVhZpFnoIJyxUws1cO1692yBgKX/6WDlfd2/SloYXGJPQPFlQq+RSNO264LSzi8BHJ5pRiHkjrQqNbR0I+s3x9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747497003; c=relaxed/simple;
	bh=q5CX4Hnq67oJGMeJObphXE+LYj1+iIcFQqTBk89c0io=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aUT3QU0zdN2tyL9PwsB/0PEnKWcv/7wopIgAKVI17WDbIRx4g3BYQHgdmupEhr59D4P+7EFrVA4+XtHyKO+zD1QhVF9pYWO6jPvnGQLljLu/EEVdbtbFP2W82k70Yb9aFY3I1c+wjxfEQal3WPuBUjXjcy08X3tcqqFs4fK4E2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rtv8ZY7f; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <769e672b-fcde-49d8-bd4b-58902569f17d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747496999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c8BxkEoyl54mgQ3QM66U3z0aec5GHz60CWK56GnsMs8=;
	b=rtv8ZY7fqM/qH+Mewgs61nHMR3owlK5WoDJYjsUBzAVMBypcB6mhkJezqLzDOY93IiVlVC
	j5Tk8d/R4utaVaARDaZWQKMvZCVKEhiSCIuZboYB02MlwN+YQmC3Im//ZcIc7l1qHKT4z5
	ksHI34EfndSBSaduo5sx3n45OICBjxs=
Date: Sat, 17 May 2025 08:49:48 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 2/4] bpf: Implement mprog API on top of
 existing cgroup progs
Content-Language: en-GB
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20250508223524.487875-1-yonghong.song@linux.dev>
 <20250508223534.488607-1-yonghong.song@linux.dev>
 <CAEf4BzZc4fqF2Ez3f1HuMt6xL6PYC6U3iOqgb53BQmkmH5rLWg@mail.gmail.com>
 <CAEf4BzaEKFJ08bJEvnEV-qbf-ZD7VnZuF35N7dp1646tYWrPtw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAEf4BzaEKFJ08bJEvnEV-qbf-ZD7VnZuF35N7dp1646tYWrPtw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 5/15/25 5:05 AM, Andrii Nakryiko wrote:
> On Thu, May 15, 2025 at 1:38 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
>> On Thu, May 8, 2025 at 3:35 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>> Current cgroup prog ordering is appending at attachment time. This is not
>>> ideal. In some cases, users want specific ordering at a particular cgroup
>>> level. To address this, the existing mprog API seems an ideal solution with
>>> supporting BPF_F_BEFORE and BPF_F_AFTER flags.
>>>
>>> But there are a few obstacles to directly use kernel mprog interface.
>>> Currently cgroup bpf progs already support prog attach/detach/replace
>>> and link-based attach/detach/replace. For example, in struct
>>> bpf_prog_array_item, the cgroup_storage field needs to be together
>>> with bpf prog. But the mprog API struct bpf_mprog_fp only has bpf_prog
>>> as the member, which makes it difficult to use kernel mprog interface.
>>>
>>> In another case, the current cgroup prog detach tries to use the
>>> same flag as in attach. This is different from mprog kernel interface
>>> which uses flags passed from user space.
>>>
>>> So to avoid modifying existing behavior, I made the following changes to
>>> support mprog API for cgroup progs:
>>>   - The support is for prog list at cgroup level. Cross-level prog list
>>>     (a.k.a. effective prog list) is not supported.
>>>   - Previously, BPF_F_PREORDER is supported only for prog attach, now
>>>     BPF_F_PREORDER is also supported by link-based attach.
>>>   - For attach, BPF_F_BEFORE/BPF_F_AFTER/BPF_F_ID is supported similar to
>>>     kernel mprog but with different implementation.
>>>   - For detach and replace, use the existing implementation.
>>>   - For attach, detach and replace, the revision for a particular prog
>>>     list, associated with a particular attach type, will be updated
>>>     by increasing count by 1.
>>>
>>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>>> ---
>>>   include/uapi/linux/bpf.h       |   7 ++
>>>   kernel/bpf/cgroup.c            | 144 ++++++++++++++++++++++++++++-----
>>>   kernel/bpf/syscall.c           |  44 ++++++----
>>>   tools/include/uapi/linux/bpf.h |   7 ++
>>>   4 files changed, 165 insertions(+), 37 deletions(-)
>>>
>> [...]
>>
>>> +       if (!anchor_prog) {
>>> +               hlist_for_each_entry(pltmp, progs, node) {
>>> +                       if ((flags & BPF_F_BEFORE) && *ppltmp)
>>> +                               break;
>>> +                       *ppltmp = pltmp;
>> This is be correct, but it's less obvious why because of all the
>> loops, breaks, and NULL anchor prog. The idea here is to find the very
>> first pl for BPF_F_BEFORE or the very last for BPF_F_AFTER, right? So
>> wouldn't this be more obviously correct:
>>
>> hlist_for_each_entry(pltmp, progs, node) {
>>      if (flags & BPF_F_BEFORE) {
>>          *ppltmp = pltmp;
>>          return NULL;
>>      }
>>      *ppltmp = pltmp;
>> }
>> return NULL;
>>
>>
>> I.e., once you know the result, just return as early as possible and
>> don't require tracing through the rest of code just to eventually
>> return all the same (but now somewhat disguised) values.
>>
>>
>> Though see my point about anchor_prog below, which will simplify this
>> to just `return pltmp;`
>>
>>
>> I'd also add a comment that if there is no anchor_prog, then
>> BPF_F_PREORDER doesn't matter because we either prepend or append to a
>> combined list of progs and end up with correct result
>>
>>> +               }
>>> +       }  else {
>>> +               hlist_for_each_entry(pltmp, progs, node) {
>>> +                       pltmp_prog = pltmp->link ? pltmp->link->link.prog : pltmp->prog;
>>> +                       if (pltmp_prog != anchor_prog)
>>> +                               continue;
>>> +                       if (!!(pltmp->flags & BPF_F_PREORDER) != preorder)
>>> +                               goto out;
>>> +                       *ppltmp = pltmp;
>>> +                       break;
>>> +               }
>>> +               if (!*ppltmp) {
>>> +                       ret = -ENOENT;
>>> +                       goto out;
>>> +               }
>>> +       }
>>> +
>>> +       return anchor_prog;
>>> +
>>> +out:
>>> +       bpf_prog_put(anchor_prog);
>>> +       return ERR_PTR(ret);
>>> +}
>>> +
>>> +static int insert_pl_to_hlist(struct bpf_prog_list *pl, struct hlist_head *progs,
>>> +                             struct bpf_prog *prog, u32 flags, u32 id_or_fd)
>>> +{
>>> +       struct bpf_prog_list *pltmp = NULL;
>>> +       struct bpf_prog *anchor_prog;
>>> +
>>> +       /* flags cannot have both BPF_F_BEFORE and BPF_F_AFTER */
>>> +       if ((flags & BPF_F_BEFORE) && (flags & BPF_F_AFTER))
>>> +               return -EINVAL;
>> I think this should be handled by get_anchor_prog(), both BPF_F_AFTER
>> and BPF_F_BEFORE will just result in no valid anchor program and we'll
>> error out below
> Oh, I just randomly realized that there is a special case that I think
> is allowed by Daniel's mprog implementation, and it might be important
> for some users. If both BPF_F_BEFORE and BPF_F_AFTER are specified and
> there is no ID/FD, then this combination would succeed if and only if
> the currently attached list of progs is empty. Check
> bpf_mprog_attach() and how it handles BPF_F_BEFORE and BPF_F_AFTER
> completely independently calculating tidx. If tidx ends up being
> consistent (which should be -1 for empty list), then that's where the
> prog/link is inserted (-1 result in prepending into an empty list).

I will add this support in the next revision.

>
>
> Daniel, can you please double check and generally take a look at this
> patch set, given you have the most detailed knowledge of mprog
> interface? Thanks!

Daniel, I will have another revision (v3) soon. Hopefully you can
review it as well. Thanks!

>
>>> +
>>> +       anchor_prog = get_anchor_prog(progs, prog, flags, id_or_fd, &pltmp);
>>> +       if (IS_ERR(anchor_prog))
>>> +               return PTR_ERR(anchor_prog);

[...]


