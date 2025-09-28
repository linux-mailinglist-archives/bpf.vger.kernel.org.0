Return-Path: <bpf+bounces-69925-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2A7BA73AC
	for <lists+bpf@lfdr.de>; Sun, 28 Sep 2025 17:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D531C3B2539
	for <lists+bpf@lfdr.de>; Sun, 28 Sep 2025 15:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA5C223DE7;
	Sun, 28 Sep 2025 15:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ap3dlcPG"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596E5221544
	for <bpf@vger.kernel.org>; Sun, 28 Sep 2025 15:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759072010; cv=none; b=Vt9QA65uZnvtx+NZfV/13hw7LIGQTdeJrpINS5EZE5XzAsBtZL9OhVOdH3BH1Ekl0anUDPqD9Psoc0V6QSt8jCVXpZUxfAx28A205VGl55xjFQL8naTSfRkxFiPhpw5NX4bXAHoUIfZXve7kKmJQgW7LW0PILkUrj7I25KscjR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759072010; c=relaxed/simple;
	bh=HIqKirF0ZwnepU7Xbxb2gTEwyZ1T7IUG9JNg6in/sxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RMtmgbAHqPB36kQTQJgALG0zOEjq14hqtAz3R4XbsffsUeYIi9gz+3si/tv7vSqi6ZHH1s/cVuBs66OKUE2MZXzwB9RoNTLrQ3BlGs7maohGtr+idPVBpwPA9QEfL/97O7tjpqw/GAnRheVXQDYYgJe9zi+Gmi4dR0jwT886Luc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ap3dlcPG; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b3eb97bb-ba9e-4f1c-96e6-8fab12efab2d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759072004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HN3a1jxFC6VG8UfigI9JAxCTsadqpPUjaufYPYeCeDo=;
	b=ap3dlcPGUyAV2wK5pBQ4MOd84b8rjoOKQQT3Zy3ADqGnRZkPwWphuyg0xsDdm4BSLQtrfU
	tzSM952oRqqM3EgHeB97odfFuo8JrLC9Ys83fXhMXrKS/4xHW2J68/EwwWyqUgdFvNUbc1
	WkpgkhPmDqVbbeintkGgClK8C1MwSww=
Date: Sun, 28 Sep 2025 23:06:34 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v8 5/7] bpf: Add BPF_F_CPU and BPF_F_ALL_CPUS
 flags support for percpu_cgroup_storage maps
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, jolsa@kernel.org, yonghong.song@linux.dev,
 song@kernel.org, eddyz87@gmail.com, dxu@dxuuu.xyz, deso@posteo.net,
 kernel-patches-bot@fb.com
References: <20250925153746.96154-1-leon.hwang@linux.dev>
 <20250925153746.96154-6-leon.hwang@linux.dev>
 <CAEf4Bzacd768RGKyujM7TTWa-JeNnZntJbJoZr2FetCR4X-soQ@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAEf4Bzacd768RGKyujM7TTWa-JeNnZntJbJoZr2FetCR4X-soQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/9/28 10:42, Andrii Nakryiko wrote:
> On Thu, Sep 25, 2025 at 8:38 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>> Introduce BPF_F_ALL_CPUS flag support for percpu_cgroup_storage maps to
>> allow updating values for all CPUs with a single value for update_elem
>> API.
>>
>> Introduce BPF_F_CPU flag support for percpu_cgroup_storage maps to
>> allow:
>>
>> * update value for specified CPU for update_elem API.
>> * lookup value for specified CPU for lookup_elem API.
>>
>> The BPF_F_CPU flag is passed via map_flags along with embedded cpu info.
>>
>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
>> ---
>>  include/linux/bpf-cgroup.h |  4 ++--
>>  include/linux/bpf.h        |  1 +
>>  kernel/bpf/local_storage.c | 22 +++++++++++++++++++---
>>  kernel/bpf/syscall.c       |  2 +-
>>  4 files changed, 23 insertions(+), 6 deletions(-)
>>
>
> [...]
>
>>  int bpf_percpu_cgroup_storage_copy(struct bpf_map *_map, void *key,
>> -                                  void *value)
>> +                                  void *value, u64 map_flags)
>>  {
>>         struct bpf_cgroup_storage_map *map = map_to_storage(_map);
>>         struct bpf_cgroup_storage *storage;
>> @@ -199,11 +199,17 @@ int bpf_percpu_cgroup_storage_copy(struct bpf_map *_map, void *key,
>>          * will not leak any kernel data
>>          */
>>         size = round_up(_map->value_size, 8);
>
> um... same issue with rounding up value_size when BPF_F_CPU is set, no?
>
>> +       if (map_flags & BPF_F_CPU) {
>> +               cpu = map_flags >> 32;
>> +               bpf_long_memcpy(value, per_cpu_ptr(storage->percpu_buf, cpu), size);
>> +               goto unlock;
>> +       }
>>         for_each_possible_cpu(cpu) {
>>                 bpf_long_memcpy(value + off,
>>                                 per_cpu_ptr(storage->percpu_buf, cpu), size);
>>                 off += size;
>>         }
>> +unlock:
>>         rcu_read_unlock();
>>         return 0;
>>  }
>> @@ -216,7 +222,7 @@ int bpf_percpu_cgroup_storage_update(struct bpf_map *_map, void *key,
>>         int cpu, off = 0;
>>         u32 size;
>>
>> -       if (map_flags != BPF_ANY && map_flags != BPF_EXIST)
>> +       if ((u32)map_flags & ~(BPF_ANY | BPF_EXIST | BPF_F_CPU | BPF_F_ALL_CPUS))
>>                 return -EINVAL;
>>
>>         rcu_read_lock();
>> @@ -233,11 +239,21 @@ int bpf_percpu_cgroup_storage_update(struct bpf_map *_map, void *key,
>>          * so no kernel data leaks possible
>>          */
>>         size = round_up(_map->value_size, 8);
>> +       if (map_flags & BPF_F_CPU) {
>> +               cpu = map_flags >> 32;
>> +               bpf_long_memcpy(per_cpu_ptr(storage->percpu_buf, cpu), value, size);
>
> ditto
>
>> +               goto unlock;
>> +       }
>>         for_each_possible_cpu(cpu) {
>>                 bpf_long_memcpy(per_cpu_ptr(storage->percpu_buf, cpu),
>>                                 value + off, size);
>> -               off += size;
>> +               /* same user-provided value is used if BPF_F_ALL_CPUS is
>> +                * specified, otherwise value is an array of per-CPU values.
>> +                */
>> +               if (!(map_flags & BPF_F_ALL_CPUS))
>> +                       off += size;
>
> btw, given we'll need another revision to fix up all those round_up()
> issues, what do you think about make this offset logic completely
> stateless (and, in my opinion, more obvious):
>
> for_each_possible_cpu(cpu) {
>     p = (map_flags & BPF_F_ALL_CPUS) ? value : value + size * cpu;
>     memcpy(per_cpu_ptr(storage->percpu_buf, cpu), p, size);
> }
>
> seems more straightforward to me

lgtm.

But I think the correct memcpy() should look like this:

memcpy(per_cpu_ptr(storage->percpu_buf, cpu), p,
       (map_flags & BPF_F_ALL_CPUS) ? _map->value_size : size);

because 'size' is 8-byte aligned and can’t be used directly when
'map_flags & BPF_F_ALL_CPUS' is set.

So the more accurate version would be:

for_each_possible_cpu(cpu) {
    p = (map_flags & BPF_F_ALL_CPUS) ? value : value + size * cpu;
    s = (map_flags & BPF_F_ALL_CPUS) ? _map->value_size : size;
    memcpy(per_cpu_ptr(storage->percpu_buf, cpu), p, s);
}

Isn’t this the correct approach?

Thanks,
Leon

[...]

