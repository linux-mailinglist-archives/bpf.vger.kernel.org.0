Return-Path: <bpf+bounces-52435-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54549A42E77
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 21:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EC923B28B1
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 20:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4061525C6E1;
	Mon, 24 Feb 2025 20:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OK5Vs1CC"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C29EEA9
	for <bpf@vger.kernel.org>; Mon, 24 Feb 2025 20:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740430791; cv=none; b=fiXDA7PQD89zdkbzi7yYqXQW2N7LCb3GGPFjOvx31oPs+qeCMQ858xe0Zr4OXMMVHnXhSEmw0RmqcKJg5qsvjCsgkBowA8wd4lhgQ+JnRnIWgs0muA0fPIJGlhtj3YFDN6rSeK6yDdJd1EoMt6IkoVTOpT/u3exjZFS6j6m2lPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740430791; c=relaxed/simple;
	bh=JmOFnQli1+t7Y5w4XAOvzeQhqk7JPapeRB8Nl9ukDsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UXbyGbe+RWHhgvIAQ5+C8OyVjRu/cqGCDHb/Z3on7xhOnGb0ASwbeG/dRJ1xTuCeLUG06JR7lKWLWgZDWs9zM4aa4UEKe/fgbRy1RR/EPsxwNf5ZUJHb6CZD8ErN8Q4bDMqmeatVqcxEL8OXMKnPrXB7AIgjLBZmNNh19oFLER8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OK5Vs1CC; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <aec4ff8a-1cdf-43ba-ba76-7ed7911d0367@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740430787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zGqFujWnpzKmhRe9+LQwBMTyo3n9fcOzu0IsQrPGaGo=;
	b=OK5Vs1CCs+nwSg9KBXumnSF2ZfuGoyo31o39zIdEYR67uJiiTbNDvdkLFFthrblj0azzHE
	H+aiqLQCMr04zH0L5ptW5MxdI4upehrB7Ewc/4KiB+gfVRuHntEmWu+vBCFljoi71akiAh
	Pe1TRP4zoJ2DIJfBeiWH04NtuD8WYsw=
Date: Mon, 24 Feb 2025 12:59:42 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Allow pre-ordering for bpf cgroup
 progs
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
References: <20250213164812.2668578-1-yonghong.song@linux.dev>
 <CAEf4Bza-Wz6Tsi=h9hwFg1TGbjsYMBi4BDGEnqtMjSj_GpOFNQ@mail.gmail.com>
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAEf4Bza-Wz6Tsi=h9hwFg1TGbjsYMBi4BDGEnqtMjSj_GpOFNQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2/24/25 10:41 AM, Andrii Nakryiko wrote:
> On Thu, Feb 13, 2025 at 8:48 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>> Currently for bpf progs in a cgroup hierarchy, the effective prog array
>> is computed from bottom cgroup to upper cgroups (post-ordering). For
>> example, the following cgroup hierarchy
>>      root cgroup: p1, p2
>>          subcgroup: p3, p4
>> have BPF_F_ALLOW_MULTI for both cgroup levels.
>> The effective cgroup array ordering looks like
>>      p3 p4 p1 p2
>> and at run time, progs will execute based on that order.
>>
>> But in some cases, it is desirable to have root prog executes earlier than
>> children progs (pre-ordering). For example,
>>    - prog p1 intends to collect original pkt dest addresses.
>>    - prog p3 will modify original pkt dest addresses to a proxy address for
>>      security reason.
>> The end result is that prog p1 gets proxy address which is not what it
>> wants. Putting p1 to every child cgroup is not desirable either as it
>> will duplicate itself in many child cgroups. And this is exactly a use case
>> we are encountering in Meta.
>>
>> To fix this issue, let us introduce a flag BPF_F_PREORDER. If the flag
>> is specified at attachment time, the prog has higher priority and the
>> ordering with that flag will be from top to bottom (pre-ordering).
>> For example, in the above example,
>>      root cgroup: p1, p2
>>          subcgroup: p3, p4
>> Let us say p2 and p4 are marked with BPF_F_PREORDER. The final
>> effective array ordering will be
>>      p2 p4 p3 p1
>>
>> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   include/linux/bpf-cgroup.h     |  1 +
>>   include/uapi/linux/bpf.h       |  1 +
>>   kernel/bpf/cgroup.c            | 33 +++++++++++++++++++++++++--------
>>   kernel/bpf/syscall.c           |  3 ++-
>>   tools/include/uapi/linux/bpf.h |  1 +
>>   5 files changed, 30 insertions(+), 9 deletions(-)
>>
> LGTM, see one suggestion below, but it doesn't change the essence
>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
>
>> diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
>> index 7fc69083e745..9de7adb68294 100644
>> --- a/include/linux/bpf-cgroup.h
>> +++ b/include/linux/bpf-cgroup.h
>> @@ -111,6 +111,7 @@ struct bpf_prog_list {
>>          struct bpf_prog *prog;
>>          struct bpf_cgroup_link *link;
>>          struct bpf_cgroup_storage *storage[MAX_BPF_CGROUP_STORAGE_TYPE];
>> +       u32 flags;
>>   };
>>
>>   int cgroup_bpf_inherit(struct cgroup *cgrp);
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index fff6cdb8d11a..beac5cdf2d2c 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -1207,6 +1207,7 @@ enum bpf_perf_event_type {
>>   #define BPF_F_BEFORE           (1U << 3)
>>   #define BPF_F_AFTER            (1U << 4)
>>   #define BPF_F_ID               (1U << 5)
>> +#define BPF_F_PREORDER         (1U << 6)
>>   #define BPF_F_LINK             BPF_F_LINK /* 1 << 13 */
>>
>>   /* If BPF_F_STRICT_ALIGNMENT is used in BPF_PROG_LOAD command, the
>> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
>> index 46e5db65dbc8..31d33058174c 100644
>> --- a/kernel/bpf/cgroup.c
>> +++ b/kernel/bpf/cgroup.c
>> @@ -369,7 +369,7 @@ static struct bpf_prog *prog_list_prog(struct bpf_prog_list *pl)
>>   /* count number of elements in the list.
>>    * it's slow but the list cannot be long
>>    */
>> -static u32 prog_list_length(struct hlist_head *head)
>> +static u32 prog_list_length(struct hlist_head *head, int *preorder_cnt)
>>   {
>>          struct bpf_prog_list *pl;
>>          u32 cnt = 0;
>> @@ -377,6 +377,8 @@ static u32 prog_list_length(struct hlist_head *head)
>>          hlist_for_each_entry(pl, head, node) {
>>                  if (!prog_list_prog(pl))
>>                          continue;
>> +               if (preorder_cnt && (pl->flags & BPF_F_PREORDER))
>> +                       (*preorder_cnt)++;
>>                  cnt++;
>>          }
>>          return cnt;
>> @@ -400,7 +402,7 @@ static bool hierarchy_allows_attach(struct cgroup *cgrp,
>>
>>                  if (flags & BPF_F_ALLOW_MULTI)
>>                          return true;
>> -               cnt = prog_list_length(&p->bpf.progs[atype]);
>> +               cnt = prog_list_length(&p->bpf.progs[atype], NULL);
>>                  WARN_ON_ONCE(cnt > 1);
>>                  if (cnt == 1)
>>                          return !!(flags & BPF_F_ALLOW_OVERRIDE);
>> @@ -423,12 +425,12 @@ static int compute_effective_progs(struct cgroup *cgrp,
>>          struct bpf_prog_array *progs;
>>          struct bpf_prog_list *pl;
>>          struct cgroup *p = cgrp;
>> -       int cnt = 0;
>> +       int i, cnt = 0, preorder_cnt = 0, fstart, bstart, init_bstart;
>>
>>          /* count number of effective programs by walking parents */
>>          do {
>>                  if (cnt == 0 || (p->bpf.flags[atype] & BPF_F_ALLOW_MULTI))
>> -                       cnt += prog_list_length(&p->bpf.progs[atype]);
>> +                       cnt += prog_list_length(&p->bpf.progs[atype], &preorder_cnt);
>>                  p = cgroup_parent(p);
>>          } while (p);
>>
>> @@ -439,20 +441,34 @@ static int compute_effective_progs(struct cgroup *cgrp,
>>          /* populate the array with effective progs */
>>          cnt = 0;
>>          p = cgrp;
>> +       fstart = preorder_cnt;
>> +       bstart = preorder_cnt - 1;
>>          do {
>>                  if (cnt > 0 && !(p->bpf.flags[atype] & BPF_F_ALLOW_MULTI))
>>                          continue;
>>
>> +               init_bstart = bstart;
>>                  hlist_for_each_entry(pl, &p->bpf.progs[atype], node) {
>>                          if (!prog_list_prog(pl))
>>                                  continue;
>>
>> -                       item = &progs->items[cnt];
>> +                       if (pl->flags & BPF_F_PREORDER) {
>> +                               item = &progs->items[bstart];
>> +                               bstart--;
>> +                       } else {
>> +                               item = &progs->items[fstart];
>> +                               fstart++;
>> +                       }
>>                          item->prog = prog_list_prog(pl);
>>                          bpf_cgroup_storages_assign(item->cgroup_storage,
>>                                                     pl->storage);
>>                          cnt++;
>>                  }
>> +
>> +               /* reverse pre-ordering progs at this cgroup level */
>> +               for (i = 0; i < (init_bstart - bstart)/2; i++)
>> +                       swap(progs->items[init_bstart - i], progs->items[bstart + 1 + i]);
> nit: this is a bit mind-bending to read and verify, let's do it a bit
> more bullet-proof way:
>
> for (i = bstart + 1, j = init_bstart; i < j; i++, j--)
>      swap(progs->items[i], progs->items[j]);
>
> ?

Sound good to me. Will send v4 soon.

>
>> +
>>          } while ((p = cgroup_parent(p)));
>>
>>          *array = progs;
>> @@ -663,7 +679,7 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
>>                   */
>>                  return -EPERM;
>>
>> -       if (prog_list_length(progs) >= BPF_CGROUP_MAX_PROGS)
>> +       if (prog_list_length(progs, NULL) >= BPF_CGROUP_MAX_PROGS)
>>                  return -E2BIG;
>>
>>          pl = find_attach_entry(progs, prog, link, replace_prog,

[...]


