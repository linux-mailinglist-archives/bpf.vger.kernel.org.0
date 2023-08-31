Return-Path: <bpf+bounces-9092-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E8378F423
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 22:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7B6D2815F9
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 20:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC12719BD7;
	Thu, 31 Aug 2023 20:35:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE76E18C26
	for <bpf@vger.kernel.org>; Thu, 31 Aug 2023 20:35:31 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0291B1
	for <bpf@vger.kernel.org>; Thu, 31 Aug 2023 13:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=hHL+QFVgt8F74TRIVrHQN7hSOGjEjIuF8B8+hHKOvPw=; b=SAx3BOv5jRNLn/4OTaFih8sOn8
	C1BgYp8cT8oXdJ24lhLzBY0KNWJPQum4rpRS6dpPrjJuVs7kuEu1H1qZyHHUQFHOGqPlp2nznwUgy
	bXhNhHJenXVSrm7l3/kjJFfDS/Gnj3yiN3QWFQC7CeejF14HdFcNTEOx84k7PDI4NVkwAVaAyN9rl
	84KNHFuH7neq/+efGQ02rIN7Z66avL9+Kz3JP7XQ6YH+b4mjoVc5ArKrnyNJ+GRdB377esYm816V7
	Oeo4zpOa1DH+QwPkDCu5voZBaoLZqpGKsZ6TGlgr5EVb/ywmoPSauSItLXRBzGZJnu0/Em7glcqbC
	0lp/k+6A==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qboO0-0006dr-5J; Thu, 31 Aug 2023 22:35:28 +0200
Received: from [178.197.249.54] (helo=linux.home)
	by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qboO0-000N5z-5F; Thu, 31 Aug 2023 22:35:28 +0200
Subject: Re: [PATCH bpf] bpf: Annotate bpf_long_memcpy with data_race
To: Marco Elver <elver@google.com>
Cc: bpf@vger.kernel.org,
 syzbot+97522333291430dd277f@syzkaller.appspotmail.com,
 Yonghong Song <yonghong.song@linux.dev>
References: <57628f7a15e20d502247c3b55fceb1cb2b31f266.1693342186.git.daniel@iogearbox.net>
 <CANpmjNP4qKMTEsSKZH_zQLnOOXA-9tWpFx_4w3E3swPQ5aJT8Q@mail.gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <ac5a146d-fe04-6e57-6703-ba1e73d81a8e@iogearbox.net>
Date: Thu, 31 Aug 2023 22:35:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CANpmjNP4qKMTEsSKZH_zQLnOOXA-9tWpFx_4w3E3swPQ5aJT8Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/27017/Thu Aug 31 09:40:48 2023)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/29/23 11:07 PM, Marco Elver wrote:
> On Tue, 29 Aug 2023 at 22:53, Daniel Borkmann <daniel@iogearbox.net> wrote:
>>
>> syzbot reported a data race splat between two processes trying to
>> update the same BPF map value via syscall on different CPUs:
>>
>>    BUG: KCSAN: data-race in bpf_percpu_array_update / bpf_percpu_array_update
>>
>>    write to 0xffffe8fffe7425d8 of 8 bytes by task 8257 on cpu 1:
>>     bpf_long_memcpy include/linux/bpf.h:428 [inline]
>>     bpf_obj_memcpy include/linux/bpf.h:441 [inline]
>>     copy_map_value_long include/linux/bpf.h:464 [inline]
>>     bpf_percpu_array_update+0x3bb/0x500 kernel/bpf/arraymap.c:380
>>     bpf_map_update_value+0x190/0x370 kernel/bpf/syscall.c:175
>>     generic_map_update_batch+0x3ae/0x4f0 kernel/bpf/syscall.c:1749
>>     bpf_map_do_batch+0x2df/0x3d0 kernel/bpf/syscall.c:4648
>>     __sys_bpf+0x28a/0x780
>>     __do_sys_bpf kernel/bpf/syscall.c:5241 [inline]
>>     __se_sys_bpf kernel/bpf/syscall.c:5239 [inline]
>>     __x64_sys_bpf+0x43/0x50 kernel/bpf/syscall.c:5239
>>     do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>>     do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>>     entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>
>>    write to 0xffffe8fffe7425d8 of 8 bytes by task 8268 on cpu 0:
>>     bpf_long_memcpy include/linux/bpf.h:428 [inline]
>>     bpf_obj_memcpy include/linux/bpf.h:441 [inline]
>>     copy_map_value_long include/linux/bpf.h:464 [inline]
>>     bpf_percpu_array_update+0x3bb/0x500 kernel/bpf/arraymap.c:380
>>     bpf_map_update_value+0x190/0x370 kernel/bpf/syscall.c:175
>>     generic_map_update_batch+0x3ae/0x4f0 kernel/bpf/syscall.c:1749
>>     bpf_map_do_batch+0x2df/0x3d0 kernel/bpf/syscall.c:4648
>>     __sys_bpf+0x28a/0x780
>>     __do_sys_bpf kernel/bpf/syscall.c:5241 [inline]
>>     __se_sys_bpf kernel/bpf/syscall.c:5239 [inline]
>>     __x64_sys_bpf+0x43/0x50 kernel/bpf/syscall.c:5239
>>     do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>>     do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>>     entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>
>>    value changed: 0x0000000000000000 -> 0xfffffff000002788
>>
>> The bpf_long_memcpy is used with 8-byte aligned pointers, power-of-8 size
>> and forced to use long read/writes to try to atomically copy long counters.
>> It is best-effort only and no barriers are here since it _will_ race with
>> concurrent updates from BPF programs. The bpf_long_memcpy() is called from
>> bpf(2) syscall. Marco suggested that the best way to make this known to
>> KCSAN would be to use data_race() annotation.
>>
>> Reported-by: syzbot+97522333291430dd277f@syzkaller.appspotmail.com
>> Suggested-by: Marco Elver <elver@google.com>
>> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
>> Cc: Yonghong Song <yonghong.song@linux.dev>
>> Link: https://lore.kernel.org/bpf/000000000000d87a7f06040c970c@google.com
> 
> Given the "best-effort" nature of this, I do think data_race() is the
> right approach:
> 
> Acked-by: Marco Elver <elver@google.com>

Thanks!

> But, tangentially related, reading the comment it looks like the
> intent is that this should always be plain long loads. Loops like this
> tend to make the compiler recognize it's a memcpy-like operation and
> replace them with builtin memcpy, which in turn may turn into calls to
> real memcpy(). Are such compiler optimizations ok?
> If it's not ok, and you'd like to prevent the compiler from turning
> into memcpy() calls, then there are several options:
> 
>    1. Do the READ_ONCE()/WRITE_ONCE() as you already suggested.
>    2. barrier() within the loop.
> 
> If defending against the compiler turning it into memcpy() is a
> side-goal, option #1 may be better after all.

I've taken the data_race() for now given it doesn't change the code itself
and is trivial. I'm kind of leaning towards barrier() perhaps as well, as
READ_ONCE() / WRITE_ONCE() feels somewhat mispurposed in this setting, but
I need to play around some more with it first and see the code gen.

Thanks,
Daniel

