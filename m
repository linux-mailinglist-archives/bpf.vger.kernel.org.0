Return-Path: <bpf+bounces-21244-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C68E484A29E
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 19:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBB0E1C225A6
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 18:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D851A482F5;
	Mon,  5 Feb 2024 18:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hLsz1s1N"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4C8481B3
	for <bpf@vger.kernel.org>; Mon,  5 Feb 2024 18:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707158591; cv=none; b=rNQm00qtSpKMqkC6Yv4ferB5Gc3ObvoGOINtmnaY9VtWgalZ+42D69BGzWF6RTK3sCnaC3HYCF5vNN+yJqFukaoTql8sSoUVQGWSv87374Nhfm1cq9jhHhh35JUbE7Ydv6ZWwdX4K0N/kSmAzVv0pUQIxCa5QGfHwevr7BxBN9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707158591; c=relaxed/simple;
	bh=lxH2UkoXhtlULl/zvh0je1dal/ztpt8QeP0kl4G+Vbs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XaBSntFCYaMDibYVpGs7ce72oGCHG3nGfCaM1o5S/jnB9pad5Mod1hMDjfWhiQhW9EbHafzDkNMPHSyQ/NUYIAsdrCivOn4NQSCpXzWyB6RCdmDzxq3lzea5RPtj8hfEu7Rq4EpadnDijytVQ3Jhsh9OYIQtekSYeYiMvYCo/a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hLsz1s1N; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707158588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LNq6oubwXmqe6ItjQ33y0Ud8zzbj1+GnKVYTNf0QWt4=;
	b=hLsz1s1N/ZjVckhwaoxs6r2NyUAj4Y8MFFX/9W5cAHtAv5Cnq0WvxcF5/HQgxF129ppqNz
	F9QQi9h1P/Js9eTcY1sGsfmGnrAoLGegOWtGvHriBnx9XOKf5+Omy6NXtBxiHeO0R+pPnJ
	NeAu9u/u3d+6Mgdt7+bqubJWD1+E2g0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-AnRtmcueNMqtk0smfhcBpA-1; Mon, 05 Feb 2024 13:43:05 -0500
X-MC-Unique: AnRtmcueNMqtk0smfhcBpA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a31ffe314c5so231586166b.1
        for <bpf@vger.kernel.org>; Mon, 05 Feb 2024 10:43:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707158584; x=1707763384;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LNq6oubwXmqe6ItjQ33y0Ud8zzbj1+GnKVYTNf0QWt4=;
        b=it2zZG1y8aTfZN+WQcKbSZAowPqG0nucycY0zb4QhqaYdXOo/vTBlT/oLu3z0ZwOKf
         X99hSHhChFGN5F+sWDPB+3BPTtyhfckkbGZzieKPWfx4TWKCTSJtuEc0OFqtAT4aY6X0
         vyW5zs4a6FFLV5Ay/e+9BY47X9LmaL4UsIZoAb8qhz6mp6pIQB/gys8iO2wEbeyQhCpF
         kBIibbjrQ+JBkIVhHc3LHfZ0w3d4kEknaNEg/M0PZydnYYk0ROlDchTRiIV/XnZnLo9K
         a+UTZ64a5glSwRKF+XuHo+2d5vvSE8foWxENcMaaYk4c7TdjkpT/pg249cX6yjdkx8L6
         wosw==
X-Gm-Message-State: AOJu0Yznr9RBjk95uR8U/c8Vb9ZyWlcBzC84G5gmox5i087GQ0E2I4Zv
	goc3OkgzE6VPbW53DceTA5EjByzOUoW6DRb4eQ4R8gadDKjqYX24tZRAYccnGlDe+sw3Rat/hs5
	I/vlh48TdpqW+o0BojntgQkdZesxm1c4etFN0cqpC9PWD0yEh
X-Received: by 2002:a17:906:c291:b0:a32:b376:489d with SMTP id r17-20020a170906c29100b00a32b376489dmr228570ejz.21.1707158584052;
        Mon, 05 Feb 2024 10:43:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHBJJqi+E8gTHS8rAQpA+gl5qKoCPXD/0rXi7vARpqh0DWv7P2ivFSjS3co7lz7OUOuk2D9Nw==
X-Received: by 2002:a17:906:c291:b0:a32:b376:489d with SMTP id r17-20020a170906c29100b00a32b376489dmr228552ejz.21.1707158583686;
        Mon, 05 Feb 2024 10:43:03 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW/539QzZ3CsCBd/dh6u4+Lu0RJ/lNp9RpJ+QdlVC2XRNNKX6VqeLJj50ZJA+N90OsJClBVsg5JNJx2ats/acge24t52SP1Khtr1Zb4g78xgsfghwaFLj1f6AJtfVo6O317uL1HzzNqXxmpy7ECqBJEptEIkKBxTFpYeMwuFd+BML/Xrojv2jMMXM9fitkLsKBmdYff02rTHIy1/9RYeW9KdA+vBiMMFajtXpJ9V3LInGlCjYjlUDdXOvBtO5I7hA45drv3aKenosx8u4UyB41Mz1PLz7aLENeuLx+D1O2uqJitQ5WY2/MWQsxC4hRsJLrtQSEiVEO//auoefGKYicIZXYmMBpZyobmMO+U5/AI7JRZNB4SrfhxFR3pafp6m1NPrmYlSeKc08AuIyTHk9ANC0tpyeniQJ3jCv+QnMgmLtM/kn+0P+/bRaYeDZ6d8IRlYLtr+o3sXelQ5sLfNPgIJKCnYmIVFOljcVjx7+ZUhFi0fAaUSSYmOH5KO46artcSjNhj82irK/HCSLEyg8UvWscGqbKXPwX22XgIsaFBiaZQJE98IoKW/FK5HPxvcKxRAW/5/iKxgZhKCM8KtX0dQCkHll57HIUiJSjrmPsVcn0ucLRS3jgg9lsPvnuDItmph5A4CJHwTnHeAe/8NIIZ8VBicJlP78Sc2dSEOj28GuudM2rMQLEK9T4bEzynKCV2zDJ0K6FcH+gAF302k7BBiiWiEivB
Received: from [192.168.0.159] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id t26-20020a1709066bda00b00a353d1a19a9sm121768ejs.191.2024.02.05.10.43.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 10:43:03 -0800 (PST)
Message-ID: <afb2fc66-abb4-4010-8120-ada7a6881f89@redhat.com>
Date: Mon, 5 Feb 2024 19:43:02 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 0/3] Annotate kfuncs in .BTF_ids section
Content-Language: en-US
To: Manu Bretelle <chantr4@gmail.com>, Jiri Olsa <olsajiri@gmail.com>
Cc: Daniel Xu <dxu@dxuuu.xyz>, linux-trace-kernel@vger.kernel.org,
 coreteam@netfilter.org, bpf@vger.kernel.org, linux-input@vger.kernel.org,
 cgroups@vger.kernel.org, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-kselftest@vger.kernel.org,
 linux-doc@vger.kernel.org, fsverity@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 netfilter-devel@vger.kernel.org, alexei.starovoitov@gmail.com,
 quentin@isovalent.com, alan.maguire@oracle.com, memxor@gmail.com
References: <cover.1706491398.git.dxu@dxuuu.xyz> <Zb12EZt0BAKOPBk/@surya>
 <Zb5QWCw3Tg26_MDa@krava> <Zb6Jt30bNcNhM6zR@surya>
From: Viktor Malik <vmalik@redhat.com>
In-Reply-To: <Zb6Jt30bNcNhM6zR@surya>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/3/24 19:45, Manu Bretelle wrote:
> On Sat, Feb 03, 2024 at 03:40:24PM +0100, Jiri Olsa wrote:
>> On Fri, Feb 02, 2024 at 03:09:05PM -0800, Manu Bretelle wrote:
>>> On Sun, Jan 28, 2024 at 06:24:05PM -0700, Daniel Xu wrote:
>>>> === Description ===
>>>>
>>>> This is a bpf-treewide change that annotates all kfuncs as such inside
>>>> .BTF_ids. This annotation eventually allows us to automatically generate
>>>> kfunc prototypes from bpftool.
>>>>
>>>> We store this metadata inside a yet-unused flags field inside struct
>>>> btf_id_set8 (thanks Kumar!). pahole will be taught where to look.
>>>>
>>>> More details about the full chain of events are available in commit 3's
>>>> description.
>>>>
>>>> The accompanying pahole and bpftool changes can be viewed
>>>> here on these "frozen" branches [0][1].
>>>>
>>>> [0]: https://github.com/danobi/pahole/tree/kfunc_btf-v3-mailed
>>>> [1]: https://github.com/danobi/linux/tree/kfunc_bpftool-mailed
>>>
>>>
>>> I hit a similar issue to [0] on master
>>> 943b043aeecc ("selftests/bpf: Fix bench runner SIGSEGV")
>>>  when cross-compiling on x86_64 (LE) to s390x (BE).
>>> I do have CONFIG_DEBUG_INFO_BTF enable and the issue would not trigger if
>>> I disabled CONFIG_DEBUG_INFO_BTF (and with the fix mentioned in [0]).
>>>
>>> What seems to happen is that `tools/resolve_btfids` is ran in the context of the
>>> host endianess and if I printk before the WARN_ON:
>>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>>> index ef380e546952..a9ed7a1a4936 100644
>>>   --- a/kernel/bpf/btf.c
>>>   +++ b/kernel/bpf/btf.c
>>>   @@ -8128,6 +8128,7 @@ int register_btf_kfunc_id_set(enum bpf_prog_type prog_type,
>>>            * WARN() for initcall registrations that do not check errors.
>>>            */
>>>           if (!(kset->set->flags & BTF_SET8_KFUNCS)) {
>>>   +        printk("Flag 0x%08X, expected 0x%08X\n", kset->set->flags, BTF_SET8_KFUNCS);
>>>                   WARN_ON(!kset->owner);
>>>                   return -EINVAL;
>>>           }
>>>
>>> the boot logs would show:
>>>   Flag 0x01000000, expected 0x00000001
>>>
>>> The issue did not happen prior to
>>> 6f3189f38a3e ("bpf: treewide: Annotate BPF kfuncs in BTF")
>>> has only 0 was written before.
>>>
>>> It seems [1] will be addressing cross-compilation, but it did not fix it as is
>>> by just applying on top of master, so probably some of the changes will also need
>>> to be ported to `tools/include/linux/btf_ids.h`?
>>
>> the fix in [1] is fixing flags in set8's pairs, but not the global flags
>>
>> it looks like Viktor's fix should now also swap that as well? like in the
>> change below on top of Viktor's changes (untested)
>>
>> jirka
>>
>>
>> ---
>> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
>> index d01603ef6283..c44d57fec390 100644
>> --- a/tools/bpf/resolve_btfids/main.c
>> +++ b/tools/bpf/resolve_btfids/main.c
>> @@ -706,6 +706,8 @@ static int sets_patch(struct object *obj)
>>  			 * correctly translate everything.
>>  			 */
>>  			if (need_bswap) {
>> +				set8->flags = bswap_32(set8->flags);
>> +
>>  				for (i = 0; i < cnt; i++) {
>>  					set8->pairs[i].flags =
>>  						bswap_32(set8->pairs[i].flags);
>>
> 
> That should work. Here are a few tests I ran:
> 
> $ md5sum /tmp/kbuild-s390x/vmlinux.*
> eb658e51e089f3c5b2c8909a29dc9997  /tmp/kbuild-s390x/vmlinux.a
> # plain vmlinux before running resolv_btfids (all 0s)
> ea907cd46a1a73b8276b5f2a82af00ca  /tmp/kbuild-s390x/vmlinux.before_resolv
> # x86_64 resolv_btfids on master without Viktor's patch
> 980a40c3a3ff563d1c2d1ebdd5071a23  /tmp/kbuild-s390x/vmlinux.resolv_native
> # x86_64 resolv_btfids on master with Viktor's patch
> b986d19e242719ebea41c578235da662  /tmp/kbuild-s390x/vmlinux.resolv_native_patch_viktor
> # x86_64 resolv_btfids on master with Viktor's patch and your suggested patch
> 4edd8752ff01129945bd442689b1927b  /tmp/kbuild-s390x/vmlinux.resolv_native_patch_viktor_patched
> # s390x resolv_btfids run with qemu-s390x-static
> 4edd8752ff01129945bd442689b1927b  /tmp/kbuild-s390x/vmlinux.resolv_s390x
> 
> 
> and some hexdiff of those binaries:
> 
> 
> # difference between master's native build and s390x build.... has byte swapping for set8 and others
> diff -ruN <(xxd /tmp/kbuild-s390x/vmlinux.resolv_s390x) <(xxd /tmp/kbuild-s390x/vmlinux.resolv_native) > diff_s390x_native.diff
> https://gist.github.com/chantra/c3d58637a08a6f7340953dc155bb18cc
> 
> # difference betwee Viktor's version and  s390x build.... squinting my eyes I only see the global set8 is missing
> diff -ruN <(xxd /tmp/kbuild-s390x/vmlinux.resolv_s390x) <(xxd /tmp/kbuild-s390x/vmlinux.resolv_native_patch_viktor) > diff_s390x_native_viktor.diff
> https://gist.github.com/chantra/61cfff02b456ae72d3c0161ce1897097

Thanks for the testing Manu!

Jiri's suggested fix is now a part of [1].

Viktor

[1] https://lore.kernel.org/bpf/cover.1707157553.git.vmalik@redhat.com/

> 
> Have a good weekend all!
> 
> Manu
> 


