Return-Path: <bpf+bounces-78633-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC57D16367
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 02:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 85CEC300DB1E
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 01:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E949E279DC8;
	Tue, 13 Jan 2026 01:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lSWEdAlb"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB5923314B
	for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 01:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768268976; cv=none; b=WvVnLvr/V1xs/VIeZVRcC03PaX0eGFrwxQuL1mgpyaZr21q3t3EuPWJf+UIgu0NbagNvLgSxo8HeV9oCmZxkrEvD533RK+8sUhmJa40DqKYLkW1K1fB/c8XlwHNlYrUzh7cJi7EMLLnMS0lyUl2kkHUVKty/WLBMmRAGshG2hEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768268976; c=relaxed/simple;
	bh=bSK4CcnScNRHMalMCjYSwEi6oFia9/n/YNRFraGXq/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FdhupWoll+KDeWOpYqTXZCeL6pv2fENCyBTthHgB6shiEBZkDBlSD9gXNBgbvt+QzQ1x1+AzHwhwvGr5EW5RfsJIMev4F4A01uWXC+H5AvacSqUIREvGxO+IXEiHt7rJNhRBfKqZ4ksXu0Tr7Rjj2tSZROFnQpriC3jDC0rK3GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lSWEdAlb; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5bcd3bb1-6ed0-4ad8-9de8-46385de908cb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768268972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YxMG4i3aLl1pLM38OkkjaumzApF3ephBc54bqt60bRs=;
	b=lSWEdAlb2ZVSXIpcS2cZyhiEazdQBF/83oz5ygbEmYo2duCR5qjPd0HK8rl1+v0TSZnl4s
	QuRyixMLPRo1mVSkf5lqlr7ZCu3AQd+v8pH44RDPdRH2EkOisqy9quC59TlCH83Wbw/8Ec
	sfxC7QJo96Ei/+GbXAyeg99DQwYf+fc=
Date: Mon, 12 Jan 2026 17:49:14 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1 04/10] resolve_btfids: Support for
 KF_IMPLICIT_ARGS
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Mykyta Yatsenko <yatsenko@meta.com>,
 Tejun Heo <tj@kernel.org>, Alan Maguire <alan.maguire@oracle.com>,
 Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org, sched-ext@lists.linux.dev
References: <20260109184852.1089786-1-ihor.solodrai@linux.dev>
 <20260109184852.1089786-5-ihor.solodrai@linux.dev>
 <CAEf4BzYcZ5pLCvfn8uWiKCjpBXBw9dxR_WZnKxVz1Bhf96xOGg@mail.gmail.com>
 <2ea17ba8-3248-4a01-8fed-183ce66aa39c@linux.dev>
 <CAEf4BzYuchyyw9M6eQo0Gou=09PcM-o_Ay7D8DM1gDitiG6Tbg@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <CAEf4BzYuchyyw9M6eQo0Gou=09PcM-o_Ay7D8DM1gDitiG6Tbg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 1/12/26 8:51 AM, Andrii Nakryiko wrote:
> On Fri, Jan 9, 2026 at 5:15 PM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>>
>> [...]
>>>>
>>>> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
>>>> index df39982f51df..b361e726fa36 100644
>>>> --- a/tools/bpf/resolve_btfids/main.c
>>>> +++ b/tools/bpf/resolve_btfids/main.c
>>>> @@ -152,6 +152,18 @@ struct object {
>>>>         int nr_typedefs;
>>>>  };
>>>>
>>>> +#define KF_IMPLICIT_ARGS (1 << 16)
>>>> +#define KF_IMPL_SUFFIX "_impl"
>>>> +#define MAX_BPF_FUNC_REG_ARGS 5
>>>> +#define MAX_KFUNCS 256
>>>> +#define MAX_DECL_TAGS (MAX_KFUNCS * 4)
>>>
>>> can't we get that from include/linux/bpf.h? seems like
>>> resolve_btfids's main.c include internal headers just fine, so why
>>> duplicate definitions?
>>
>> Hi Andrii, thank you for a quick review.
>>
>> Including internal include/linux/btf.h directly doesn't work, which is
>> probably expected.
>>
>> resolve_btfids is currently built with:
>>
>> HOSTCFLAGS_resolve_btfids += -g \
>>           -I$(srctree)/tools/include \
>>           -I$(srctree)/tools/include/uapi \
> 
> so I don't know if that will solve the issue, but I don't think it
> makes sense to build resolve_btfids using tools' version of includes.
> tools/include is mostly for perf's benefit (maybe so that they don't
> accidentally take some kernel-internal dependency, not sure). But
> resolve_btfids is built for the kernel during the kernel build, we
> should have access to full kernel headers. Try changing this and see
> if build errors go away?
> 
>>           -I$(LIBBPF_INCLUDE) \
>>           -I$(SUBCMD_INCLUDE) \
>>           $(LIBELF_FLAGS) \
>>           -Wall -Werror
>>
>> If I add -I$(srctree)/include option and then
>>
>>     #include <linux/btf.h>
>>
>> A bunch of build errors happen.
>>
>> AFAIU we'd have to create a stripped copy of relevant headers in
>> tools/include first.  Is that what you're suggesting?
> 
> see above, the opposite -- just use -I$(srctree)/include directly

Andrii,

I made a low-effort attempt to switch away from tools/include and it
looks like too much trouble. See a sample splat below.

I think the issue is that resolve_btfids uses a couple of inherently
user-space things (stdlib, libelf), which themselves may include
system headers. And there is actually a difference between the kernel
and tools/include headers. For example, check

  ./include/linux/rbtree.h
vs
  ./tools/include/linux/rbtree.h

Maybe we can make it work (with our own local tools/include?), but it
doesn't look worth it for just a couple of constant #define-s.

Let me know if I am missing something.


$ make
  INSTALL libsubcmd_headers
  HOSTCC  /home/isolodrai/workspace/prog-aux/linux/tools/bpf/resolve_btfids/main.o
In file included from /home/isolodrai/workspace/prog-aux/linux/include/uapi/linux/stat.h:5,
                 from /home/isolodrai/workspace/prog-aux/linux/include/linux/stat.h:7,
                 from main.c:70:
/home/isolodrai/workspace/prog-aux/linux/include/linux/types.h:20:33: error: conflicting types for ‘fd_set’; have ‘__kernel_fd_set’
   20 | typedef __kernel_fd_set         fd_set;
      |                                 ^~~~~~
In file included from /usr/include/sys/types.h:179,
                 from /usr/include/stdlib.h:394,
                 from main.c:67:
/usr/include/sys/select.h:70:5: note: previous declaration of ‘fd_set’ with type ‘fd_set’
   70 |   } fd_set;
      |     ^~~~~~
In file included from /home/isolodrai/workspace/prog-aux/linux/include/uapi/linux/stat.h:5,
                 from /home/isolodrai/workspace/prog-aux/linux/include/linux/stat.h:7,
                 from main.c:70:
/home/isolodrai/workspace/prog-aux/linux/include/linux/types.h:21:33: error: conflicting types for ‘dev_t’; have ‘__kernel_dev_t’ {aka ‘unsigned int’}
   21 | typedef __kernel_dev_t          dev_t;
      |                                 ^~~~~
In file included from /usr/include/stdlib.h:394,
                 from main.c:67:
/usr/include/sys/types.h:59:17: note: previous declaration of ‘dev_t’ with type ‘dev_t’ {aka ‘long unsigned int’}
   59 | typedef __dev_t dev_t;
      |                 ^~~~~
In file included from /home/isolodrai/workspace/prog-aux/linux/include/uapi/linux/stat.h:5,
                 from /home/isolodrai/workspace/prog-aux/linux/include/linux/stat.h:7,
                 from main.c:70:
/home/isolodrai/workspace/prog-aux/linux/include/linux/types.h:25:33: error: conflicting types for ‘nlink_t’; have ‘u32’ {aka ‘unsigned int’}
   25 | typedef u32                     nlink_t;
      |                                 ^~~~~~~
In file included from /usr/include/stdlib.h:394,
                 from main.c:67:
/usr/include/sys/types.h:74:19: note: previous declaration of ‘nlink_t’ with type ‘nlink_t’ {aka ‘long unsigned int’}
   74 | typedef __nlink_t nlink_t;
      |                   ^~~~~~~
In file included from /home/isolodrai/workspace/prog-aux/linux/include/uapi/linux/stat.h:5,
                 from /home/isolodrai/workspace/prog-aux/linux/include/linux/stat.h:7,
                 from main.c:70:
/home/isolodrai/workspace/prog-aux/linux/include/linux/types.h:31:33: error: conflicting types for ‘timer_t’; have ‘__kernel_timer_t’ {aka ‘int’}
   31 | typedef __kernel_timer_t        timer_t;
      |                                 ^~~~~~~
In file included from /usr/include/sys/types.h:130,
                 from /usr/include/stdlib.h:394,
                 from main.c:67:
/usr/include/bits/types/timer_t.h:7:19: note: previous declaration of ‘timer_t’ with type ‘timer_t’ {aka ‘void *’}
    7 | typedef __timer_t timer_t;
      |                   ^~~~~~~
In file included from /home/isolodrai/workspace/prog-aux/linux/include/uapi/linux/stat.h:5,
                 from /home/isolodrai/workspace/prog-aux/linux/include/linux/stat.h:7,
                 from main.c:70:
/home/isolodrai/workspace/prog-aux/linux/include/linux/types.h:52:33: error: conflicting types for ‘loff_t’; have ‘__kernel_loff_t’ {aka ‘long long int’}
   52 | typedef __kernel_loff_t         loff_t;
      |                                 ^~~~~~
In file included from /usr/include/stdlib.h:394,
                 from main.c:67:
/usr/include/sys/types.h:42:18: note: previous declaration of ‘loff_t’ with type ‘loff_t’ {aka ‘long int’}
   42 | typedef __loff_t loff_t;
      |                  ^~~~~~
In file included from /home/isolodrai/workspace/prog-aux/linux/include/uapi/linux/stat.h:5,
                 from /home/isolodrai/workspace/prog-aux/linux/include/linux/stat.h:7,
                 from main.c:70:
/home/isolodrai/workspace/prog-aux/linux/include/linux/types.h:53:9: error: unknown type name ‘__kernel_uoff_t’
   53 | typedef __kernel_uoff_t         uoff_t;
      |         ^~~~~~~~~~~~~~~
/home/isolodrai/workspace/prog-aux/linux/include/linux/types.h:115:33: error: conflicting types for ‘uint64_t’; have ‘u64’ {aka ‘long long unsigned int’}
  115 | typedef u64                     uint64_t;
      |                                 ^~~~~~~~
In file included from /usr/include/stdint.h:37,
                 from /usr/lib/gcc/x86_64-redhat-linux/11/include/stdint.h:9,
                 from /usr/include/libelf.h:32,
                 from main.c:68:
/usr/include/bits/stdint-uintn.h:27:20: note: previous declaration of ‘uint64_t’ with type ‘uint64_t’ {aka ‘long unsigned int’}
   27 | typedef __uint64_t uint64_t;
      |                    ^~~~~~~~
In file included from /home/isolodrai/workspace/prog-aux/linux/include/uapi/linux/stat.h:5,
                 from /home/isolodrai/workspace/prog-aux/linux/include/linux/stat.h:7,
                 from main.c:70:
/home/isolodrai/workspace/prog-aux/linux/include/linux/types.h:116:33: error: conflicting types for ‘u_int64_t’; have ‘u64’ {aka ‘long long unsigned int’}
  116 | typedef u64                     u_int64_t;
      |                                 ^~~~~~~~~
In file included from /usr/include/stdlib.h:394,
                 from main.c:67:
/usr/include/sys/types.h:161:20: note: previous declaration of ‘u_int64_t’ with type ‘u_int64_t’ {aka ‘long unsigned int’}
  161 | typedef __uint64_t u_int64_t;
      |                    ^~~~~~~~~
In file included from /home/isolodrai/workspace/prog-aux/linux/include/uapi/linux/stat.h:5,
                 from /home/isolodrai/workspace/prog-aux/linux/include/linux/stat.h:7,
                 from main.c:70:
/home/isolodrai/workspace/prog-aux/linux/include/linux/types.h:117:33: error: conflicting types for ‘int64_t’; have ‘s64’ {aka ‘long long int’}
  117 | typedef s64                     int64_t;
      |                                 ^~~~~~~
In file included from /usr/include/sys/types.h:155,
                 from /usr/include/stdlib.h:394,
                 from main.c:67:
/usr/include/bits/stdint-intn.h:27:19: note: previous declaration of ‘int64_t’ with type ‘int64_t’ {aka ‘long int’}
   27 | typedef __int64_t int64_t;
      |                   ^~~~~~~
In file included from /home/isolodrai/workspace/prog-aux/linux/include/uapi/linux/stat.h:5,
                 from /home/isolodrai/workspace/prog-aux/linux/include/linux/stat.h:7,
                 from main.c:70:
/home/isolodrai/workspace/prog-aux/linux/include/linux/types.h:138:13: error: conflicting types for ‘blkcnt_t’; have ‘u64’ {aka ‘long long unsigned int’}
  138 | typedef u64 blkcnt_t;
      |             ^~~~~~~~
In file included from /usr/include/stdlib.h:394,
                 from main.c:67:
/usr/include/sys/types.h:192:20: note: previous declaration of ‘blkcnt_t’ with type ‘blkcnt_t’ {aka ‘long int’}
  192 | typedef __blkcnt_t blkcnt_t;     /* Type to count number of disk blocks.  */
      |                    ^~~~~~~~
In file included from /home/isolodrai/workspace/prog-aux/linux/include/uapi/linux/stat.h:5,
                 from /home/isolodrai/workspace/prog-aux/linux/include/linux/stat.h:7,
                 from main.c:70:
/home/isolodrai/workspace/prog-aux/linux/include/linux/types.h:266:34: error: expected ‘:’, ‘,’, ‘;’, ‘}’ or ‘__attribute__’ before ‘*’ token
  266 |         struct task_struct __rcu *task;
      |                                  ^
In file included from /home/isolodrai/workspace/prog-aux/linux/include/linux/cache.h:6,
                 from /home/isolodrai/workspace/prog-aux/linux/include/linux/time.h:5,
                 from /home/isolodrai/workspace/prog-aux/linux/include/linux/stat.h:19,
                 from main.c:70:
/home/isolodrai/workspace/prog-aux/linux/include/vdso/cache.h:5:10: fatal error: asm/cache.h: No such file or directory
    5 | #include <asm/cache.h>
      |          ^~~~~~~~~~~~~
compilation terminated.
make[1]: *** [/home/isolodrai/workspace/prog-aux/linux/tools/build/Makefile.build:86: /home/isolodrai/workspace/prog-aux/linux/tools/bpf/resolve_btfids/main.o] Error 1
make: *** [Makefile:81: /home/isolodrai/workspace/prog-aux/linux/tools/bpf/resolve_btfids//resolve_btfids-in.o] Error 2


> 
> [...]
> 

