Return-Path: <bpf+bounces-70444-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D84BBF31F
	for <lists+bpf@lfdr.de>; Mon, 06 Oct 2025 22:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8490518973BF
	for <lists+bpf@lfdr.de>; Mon,  6 Oct 2025 20:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9B32D8378;
	Mon,  6 Oct 2025 20:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJ8fwaM8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040E017DFE7
	for <bpf@vger.kernel.org>; Mon,  6 Oct 2025 20:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759782791; cv=none; b=ZG6Y4r6tQj1WmlrobkNAJw2R0QOMLHP3kc+I/Gcw690Ykn6RqCpYIHlL0rnBJYR9KVD5ZwDYV551Iq5NutX7ueyv3YDd72VRoSJYURKPBKBK9DRbqZ4DBvsZwWDp2eS2JHYhVf3gUr5Xl33nvtyL0llxJ52XZwkRs7yp32fFarg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759782791; c=relaxed/simple;
	bh=htMAYDLDpp4f3g3S9y2VdKjyj7MTOVFS9ubsd0Tq4l4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=PdfTeQrL+0IKNRAYFE8KDONwLyUY4oBfCQqFDxwaATTDChZOy7F2Md2iUpEcKRh7rEwGbx9drN/p4EYXzhRp0nvjXXDTOKvSG741gPQbW8opWi90NRZaOgb7hpeskDXOzq/NhEZBEgBv1XQZpWloec1nLuoXRIrG1leZi2jXb6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mJ8fwaM8; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-27d69771e3eso37441525ad.3
        for <bpf@vger.kernel.org>; Mon, 06 Oct 2025 13:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759782789; x=1760387589; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jTuvAWVj1xNY2RCe1+5+6DP2geal1bbUoeJ33CVd4DU=;
        b=mJ8fwaM8bVTN2OyuMmZuTQHd9x3wbNQn3m+uJz5jyFyeeT4ykOgoN6Og0lY4qUf2uj
         2RIQTAe84GiSIRNhvHnrO26LDHEXs9qdmY1FvDCv7CijrgmztT46oDKwfsljk2yaZHVN
         Y9NkQXmcPXpA0Jewptm0S6uTgpW48aNM9rEVjKeIJkstR/bjaYDd9iT3Lj0vAv8miazF
         L/OlH5VjOWpnF7vh6JAx4DFi+YYPaB9jh10fIWgROdtRNnIDL8fuFy31XeFgYJo4iFmb
         O/MlVfDABBWIWHm9nhM1pfp1Gp82bAqSP5Feh94tdlkZWZAdgnqWwA2yiK3HVITQbTgl
         wlVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759782789; x=1760387589;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jTuvAWVj1xNY2RCe1+5+6DP2geal1bbUoeJ33CVd4DU=;
        b=Gy1azh8jMD8CMumshEhxsfjlD5TnWtRbLNVRXNZVOJqqdbEUAdRB0hh1RNRMnDpDnS
         EY74zHlKn0izikFRrqwUOFqRbQx4sgX/DRYnmKO0aZ0Vf3/jg1Sp/NnpgQDYI8DHQDjc
         xfCeLOySzj+LRMdsZ39y9+ZtE+lmOpsJv3eItRGFmOGfr61LY/O0Z5dQOQurkO0XbASR
         EgRc/FfQYEWPII0DKfCefJi03zSU4W88nomHHqv/WxcCZrE7Qb5tB7T7iAh8bmaWPqWL
         NtZyYrsjEUdTRzUALj7RPY65PA2XoSYUyJ6JSYf5TzGoD9fGKG5cT4IrfBGHkuwAZa3Z
         FSHA==
X-Forwarded-Encrypted: i=1; AJvYcCVM+OvtSz+EDBT/ZN68u30hV+cVUT7XP3D+6J/lwG514CV1U79sOZDrMjmSgEc8hSHMc3c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH2cjxnREsfS3KxPgSlZtjFL3Vbe5pCvGKKuf7TJlxv1yijsJ1
	B80ibrQuZo5urdOl1Ge0Iv3U6q9uO3MUnuE10DUckO3hY8hD+ZE+gaFE
X-Gm-Gg: ASbGncvbn2+ZwemMpJLBN22LzMSqjmZRidlKh1c63b3txh//i6jyE0V6X40nOxA2OPd
	PzQAm7J9lBlMWhg7e7ywlVFdtTa//IkpCKL6mrHhFeNJDK4tpJqoJS8qm/pco3Rw7lW0rQsTW6a
	1qfVMeWXq+Y13epRKpUTew1J70iH/Yi9YKEltu4K7rNzh/tXtA82GUcjco0NLq+uNYE1AAHYNgt
	hnWe1VzatiN46eYxkUilnp1BZp1X9MzlKF+pxAB7Rr2hcg5bcN7DpubBQ1yg4OsJy9uOdhPoq+c
	MDCxh8YdbsDdkRy9ncVhnu7G9WIrYPyxrsl2fPNAaBld9/TYJ6R8sWeow9h4xqF8sLbD976zyFZ
	TbOBWLjfHq7GHHDlgIXzx/z1JE2eW7HvbnuaUJ9Yioesd2aunBilnE8enJle/ov+uFtda6vtrkf
	5pR8Sc
X-Google-Smtp-Source: AGHT+IE/MvX+CuLujIbF0sgN/kXRntG3wFGfdpL/t6ZHiDkab3quyg+ufA6rxyIuFBes0xT9d3Is4A==
X-Received: by 2002:a17:903:1b43:b0:267:a8d0:7ab3 with SMTP id d9443c01a7336-28e9a693f40mr159740215ad.61.1759782789065;
        Mon, 06 Oct 2025 13:33:09 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1151:15:6b87:8abb:5d27:d3d8? ([2620:10d:c090:500::6:c573])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1dc00esm140825475ad.117.2025.10.06.13.33.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 13:33:08 -0700 (PDT)
Message-ID: <82c392dc-e750-43d9-9394-1df00a366ae0@gmail.com>
Date: Mon, 6 Oct 2025 13:33:07 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: JP Kobryn <inwardvessel@gmail.com>
Subject: Re: [PATCH] memcg: introduce kfuncs for fetching memcg stats
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Yosry Ahmed <yosryahmed@google.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
 linux-mm <linux-mm@kvack.org>, bpf <bpf@vger.kernel.org>,
 Kernel Team <kernel-team@meta.com>
References: <20251001045456.313750-1-inwardvessel@gmail.com>
 <CAADnVQKQpEsgoR5xw0_32deMqT4Pc7ZOo8jwJWkarcOrZijPzw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAADnVQKQpEsgoR5xw0_32deMqT4Pc7ZOo8jwJWkarcOrZijPzw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/1/25 3:25 PM, Alexei Starovoitov wrote:
> On Tue, Sep 30, 2025 at 9:57 PM JP Kobryn <inwardvessel@gmail.com> wrote:
[..]
>>
>> There is a significant perf benefit when using this approach. In terms of
>> elapsed time, the kfuncs allow a bpf cgroup iterator program to outperform
>> the traditional file reading method, saving almost 80% of the time spent in
>> kernel.
>>
>> control: elapsed time
>> real    0m14.421s
>> user    0m0.183s
>> sys     0m14.184s
>>
>> experiment: elapsed time
>> real    0m3.250s
>> user    0m0.225s
>> sys     0m2.916s
> 
> Nice, but github repo somewhere doesn't guarantee that
> the work is equivalent.
> Please add it as a selftest/bpf instead.
> Like was done in commit
> https://lore.kernel.org/bpf/20200509175921.2477493-1-yhs@fb.com/
> to demonstrate equivalence of 'cat /proc' vs iterator approach.

Sure, I'll relocate the test code there.

[..]
>> ---
>>   mm/memcontrol.c | 67 +++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 67 insertions(+)
>>
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index 8dd7fbed5a94..aa8cbf883d71 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -870,6 +870,73 @@ unsigned long memcg_events_local(struct mem_cgroup *memcg, int event)
>>   }
>>   #endif
>>
>> +static inline struct mem_cgroup *memcg_from_cgroup(struct cgroup *cgrp)
>> +{
>> +       return cgrp ? mem_cgroup_from_css(cgrp->subsys[memory_cgrp_id]) : NULL;
>> +}
>> +
>> +__bpf_kfunc static void memcg_flush_stats(struct cgroup *cgrp)
>> +{
>> +       struct mem_cgroup *memcg = memcg_from_cgroup(cgrp);
>> +
>> +       if (!memcg)
>> +               return;
>> +
>> +       mem_cgroup_flush_stats(memcg);
>> +}
> 
> css_rstat_flush() is sleepable, so this kfunc must be sleepable too.
> Not sure about the rest.

Good catch. I'll add the sleepable flag where it's needed.

> 
>> +
>> +__bpf_kfunc static unsigned long memcg_node_stat_fetch(struct cgroup *cgrp,
>> +               enum node_stat_item item)
>> +{
>> +       struct mem_cgroup *memcg = memcg_from_cgroup(cgrp);
>> +
>> +       if (!memcg)
>> +               return 0;
>> +
>> +       return memcg_page_state_output(memcg, item);
>> +}
>> +
>> +__bpf_kfunc static unsigned long memcg_stat_fetch(struct cgroup *cgrp,
>> +               enum memcg_stat_item item)
>> +{
>> +       struct mem_cgroup *memcg = memcg_from_cgroup(cgrp);
>> +
>> +       if (!memcg)
>> +               return 0;
>> +
>> +       return memcg_page_state_output(memcg, item);
>> +}
>> +
>> +__bpf_kfunc static unsigned long memcg_vm_event_fetch(struct cgroup *cgrp,
>> +               enum vm_event_item item)
>> +{
>> +       struct mem_cgroup *memcg = memcg_from_cgroup(cgrp);
>> +
>> +       if (!memcg)
>> +               return 0;
>> +
>> +       return memcg_events(memcg, item);
>> +}
>> +
>> +BTF_KFUNCS_START(bpf_memcontrol_kfunc_ids)
>> +BTF_ID_FLAGS(func, memcg_flush_stats)
>> +BTF_ID_FLAGS(func, memcg_node_stat_fetch)
>> +BTF_ID_FLAGS(func, memcg_stat_fetch)
>> +BTF_ID_FLAGS(func, memcg_vm_event_fetch)
>> +BTF_KFUNCS_END(bpf_memcontrol_kfunc_ids)
> 
> At least one of them must be sleepable and the rest probably too?
> All of them must be KF_TRUSTED_ARGS too.

Thanks, I'll include the trusted args flag. As to which are sleepable,
only memcg_flush_stats can block.

> 
>> +
>> +static const struct btf_kfunc_id_set bpf_memcontrol_kfunc_set = {
>> +       .owner          = THIS_MODULE,
>> +       .set            = &bpf_memcontrol_kfunc_ids,
>> +};
>> +
>> +static int __init bpf_memcontrol_kfunc_init(void)
>> +{
>> +       return register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING,
>> +                                        &bpf_memcontrol_kfunc_set);
>> +}
> 
> Why tracing only?

Hmmm, initially I didn't think about use cases outside of the cgroup
iterator programs. After discussing with teammates though, some other
potential use cases could be within sched_ext or (future) bpf-oom. I'm
thinking I'll go with the "UNSPEC" type in v2.

