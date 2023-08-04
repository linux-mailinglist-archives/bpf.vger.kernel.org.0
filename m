Return-Path: <bpf+bounces-7005-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5037700F9
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 15:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39D791C21595
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 13:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46DC6BE6E;
	Fri,  4 Aug 2023 13:15:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14662A940;
	Fri,  4 Aug 2023 13:15:24 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C530C59DC;
	Fri,  4 Aug 2023 06:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=ZIWNRqUXtdxc5C7JbAkVcb7wzdaYAWEjNKOjfCdnzSk=; b=iddJO9lzxrXkApiWYbYftMsPxZ
	bX8BnDhdbyz2rXaNkSklpEpKA6iqvLTAhbk68F9EvyuDCBAfNEwJP3oelkEDia0tWgjmYurkYa7eF
	8aypHG7KpPQQeS6UBIUEf/CpQmPQLXTXAZeB39dtuHKHe/2uzo6ddqmxXz3vDt6ga8/ByMPwGKSPs
	hm/HdZNXYAgGQEn1n+lu3k7CO3Ha3RBxUh5uLL5l/3TBe8ckkuQsntmff0xplmwwmDJzz7OmOppLS
	QUQIyLHpMfH/69WnwJ5docy1bBgdvl79puzcbPKLd4BqUbg+YIu7TWJSls9YltW7vfqeGRF8gHQqH
	1RyVA5XQ==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qRueD-000JBi-Rv; Fri, 04 Aug 2023 15:15:17 +0200
Received: from [180.200.247.117] (helo=localhost.localdomain)
	by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qRueD-000EIz-0b; Fri, 04 Aug 2023 15:15:17 +0200
Subject: Re: [syzbot] [bpf?] UBSAN: array-index-out-of-bounds in
 bpf_mprog_detach
To: Martin KaFai Lau <martin.lau@linux.dev>,
 syzbot <syzbot+0c06ba0f831fe07a8f27@syzkaller.appspotmail.com>,
 syzkaller-bugs@googlegroups.com, bpf@vger.kernel.org
Cc: andrii@kernel.org, ast@kernel.org, haoluo@google.com,
 john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, sdf@google.com,
 song@kernel.org, yhs@fb.com
References: <0000000000007095cd0601a9ad91@google.com>
 <5c9c4b8c-9f9a-7677-3c3f-6c0faf77397d@linux.dev>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <2bea40de-81e5-10a8-8422-efd79a2fa3a5@iogearbox.net>
Date: Fri, 4 Aug 2023 15:15:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <5c9c4b8c-9f9a-7677-3c3f-6c0faf77397d@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26990/Fri Aug  4 09:32:00 2023)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/4/23 1:39 AM, Martin KaFai Lau wrote:
> On 7/29/23 5:48 PM, syzbot wrote:
>> syzbot found the following issue on:
>>
>> HEAD commit:    ec87f05402f5 octeontx2-af: Install TC filter rules in hard..
>> git tree:       net-next
>> console output:https://syzkaller.appspot.com/x/log.txt?x=12a76df1a80000
>> kernel config:https://syzkaller.appspot.com/x/.config?x=8acaeb93ad7c6aaa
>> dashboard link:https://syzkaller.appspot.com/bug?extid=0c06ba0f831fe07a8f27
>> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
>>
>> Unfortunately, I don't have any reproducer for this issue yet.
>>
>> Downloadable assets:
>> disk image:https://storage.googleapis.com/syzbot-assets/0fc53904fc08/disk-ec87f054.raw.xz
>> vmlinux:https://storage.googleapis.com/syzbot-assets/aee64718ea5c/vmlinux-ec87f054.xz
>> kernel image:https://storage.googleapis.com/syzbot-assets/d3b6d3f4cfbc/bzImage-ec87f054.xz
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by:syzbot+0c06ba0f831fe07a8f27@syzkaller.appspotmail.com
>>
>> ================================================================================
>> UBSAN: array-index-out-of-bounds in ./include/linux/bpf_mprog.h:292:24
>> index 4294967295 is out of range for type 'bpf_mprog_fp [64]'
>> CPU: 1 PID: 13232 Comm: syz-executor.1 Not tainted 6.5.0-rc2-syzkaller-00573-gec87f05402f5 #0
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2023
>> Call Trace:
>>   <TASK>
>>   __dump_stack lib/dump_stack.c:88 [inline]
>>   dump_stack_lvl+0x125/0x1b0 lib/dump_stack.c:106
>>   ubsan_epilogue lib/ubsan.c:217 [inline]
>>   __ubsan_handle_out_of_bounds+0x111/0x150 lib/ubsan.c:348
>>   bpf_mprog_read include/linux/bpf_mprog.h:292 [inline]
>>   bpf_mprog_fetch kernel/bpf/mprog.c:307 [inline]
>>   bpf_mprog_detach+0xcd7/0xd50 kernel/bpf/mprog.c:381
>>   tcx_prog_detach+0x258/0x950 kernel/bpf/tcx.c:78
>>   bpf_prog_detach kernel/bpf/syscall.c:3877 [inline]
>>   __sys_bpf+0x36ee/0x4ec0 kernel/bpf/syscall.c:5357

Was able to repro, fix + selftest is here:
https://lore.kernel.org/bpf/20230804131112.11012-1-daniel@iogearbox.net/

Thanks,
Daniel

