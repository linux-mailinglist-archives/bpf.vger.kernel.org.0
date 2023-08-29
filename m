Return-Path: <bpf+bounces-8934-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A08FB78CD4B
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 22:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2E4A1C20A55
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 20:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4290B182A5;
	Tue, 29 Aug 2023 20:04:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0E717751
	for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 20:04:18 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2514AD2;
	Tue, 29 Aug 2023 13:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=fPHDVcWNaWx0HeDVBWD703V2C8n2avpnAKsXnIrmI3w=; b=jOiy1WzR3DhWtU6Z8ahNFxjER7
	/lz8kGgoeatTZ7DvubUXdUahynyIm9FpPoeK26VuvfeyjNoxJMeJbJ0z5JhLfSfdK5w4rrfrg8nEd
	DLd8pXVR1wm7a91GBnPFCxtKBCola+MzJM/YNxFWB1x86Pnrp6nbfIDfmUzASOuAN9c2tTL4H8NF8
	cAVSTpeXD++8xr1yqenUret/hLHJl/uxCfwLrRqHgutkgOvV2CBYxAvhtqHen8fO4s41JPNG7CqIj
	hvXcrbGqZ1Fe/ZJuR/5fjJRRfztXGgmsr55fYtSEd2Z72QYUFyEzFyfnyfkz4lyR9OIH3qh5JDBem
	vBSDBo6w==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qb4wV-000DCD-Cp; Tue, 29 Aug 2023 22:04:04 +0200
Received: from [178.197.249.48] (helo=linux.home)
	by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qb4wV-000RXC-1g; Tue, 29 Aug 2023 22:04:03 +0200
Subject: Re: [syzbot] [bpf?] KCSAN: data-race in bpf_percpu_array_update /
 bpf_percpu_array_update (2)
To: Marco Elver <elver@google.com>, yonghong.song@linux.dev
Cc: syzbot <syzbot+97522333291430dd277f@syzkaller.appspotmail.com>,
 andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, haoluo@google.com,
 john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
 linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@google.com,
 song@kernel.org, syzkaller-bugs@googlegroups.com, yhs@fb.com,
 "Paul E. McKenney" <paulmck@kernel.org>
References: <000000000000d87a7f06040c970c@google.com>
 <2e260b7c-2a89-2d0c-afb5-708c34230db2@linux.dev>
 <CANpmjNOG4f-NnGX6rpA-X8JtRtTkUH8PiLvMj_WJsp+sbq6PNg@mail.gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <f09d1d92-3e32-46a6-d20d-41bf74268d0c@iogearbox.net>
Date: Tue, 29 Aug 2023 22:04:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CANpmjNOG4f-NnGX6rpA-X8JtRtTkUH8PiLvMj_WJsp+sbq6PNg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/27015/Tue Aug 29 09:39:45 2023)
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/29/23 8:53 PM, Marco Elver wrote:
> On Tue, 29 Aug 2023 at 20:30, Yonghong Song <yonghong.song@linux.dev> wrote:
>> On 8/29/23 5:39 AM, syzbot wrote:
>>> Hello,
>>>
>>> syzbot found the following issue on:
>>>
>>> HEAD commit:    727dbda16b83 Merge tag 'hardening-v6.6-rc1' of git://git.k..
>>> git tree:       upstream
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=136f39dfa80000
>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=dea9c2ce3f646a25
>>> dashboard link: https://syzkaller.appspot.com/bug?extid=97522333291430dd277f
>>> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
>>>
>>> Unfortunately, I don't have any reproducer for this issue yet.
>>>
>>> Downloadable assets:
>>> disk image: https://storage.googleapis.com/syzbot-assets/9923a023ab11/disk-727dbda1.raw.xz
>>> vmlinux: https://storage.googleapis.com/syzbot-assets/650dbc695d77/vmlinux-727dbda1.xz
>>> kernel image: https://storage.googleapis.com/syzbot-assets/361da71276bf/bzImage-727dbda1.xz
>>>
>>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>>> Reported-by: syzbot+97522333291430dd277f@syzkaller.appspotmail.com
>>>
>>> ==================================================================
>>> BUG: KCSAN: data-race in bpf_percpu_array_update / bpf_percpu_array_update
>>>
>>> write to 0xffffe8fffe7425d8 of 8 bytes by task 8257 on cpu 1:
>>>    bpf_long_memcpy include/linux/bpf.h:428 [inline]
>>>    bpf_obj_memcpy include/linux/bpf.h:441 [inline]
>>>    copy_map_value_long include/linux/bpf.h:464 [inline]
>>>    bpf_percpu_array_update+0x3bb/0x500 kernel/bpf/arraymap.c:380
>>>    bpf_map_update_value+0x190/0x370 kernel/bpf/syscall.c:175
>>>    generic_map_update_batch+0x3ae/0x4f0 kernel/bpf/syscall.c:1749
>>>    bpf_map_do_batch+0x2df/0x3d0 kernel/bpf/syscall.c:4648
>>>    __sys_bpf+0x28a/0x780
>>>    __do_sys_bpf kernel/bpf/syscall.c:5241 [inline]
>>>    __se_sys_bpf kernel/bpf/syscall.c:5239 [inline]
>>>    __x64_sys_bpf+0x43/0x50 kernel/bpf/syscall.c:5239
>>>    do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>>>    do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>>>    entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>>
>>> write to 0xffffe8fffe7425d8 of 8 bytes by task 8268 on cpu 0:
>>>    bpf_long_memcpy include/linux/bpf.h:428 [inline]
>>>    bpf_obj_memcpy include/linux/bpf.h:441 [inline]
>>>    copy_map_value_long include/linux/bpf.h:464 [inline]
>>>    bpf_percpu_array_update+0x3bb/0x500 kernel/bpf/arraymap.c:380
>>>    bpf_map_update_value+0x190/0x370 kernel/bpf/syscall.c:175
>>>    generic_map_update_batch+0x3ae/0x4f0 kernel/bpf/syscall.c:1749
>>>    bpf_map_do_batch+0x2df/0x3d0 kernel/bpf/syscall.c:4648
>>>    __sys_bpf+0x28a/0x780
>>>    __do_sys_bpf kernel/bpf/syscall.c:5241 [inline]
>>>    __se_sys_bpf kernel/bpf/syscall.c:5239 [inline]
>>>    __x64_sys_bpf+0x43/0x50 kernel/bpf/syscall.c:5239
>>>    do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>>>    do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>>>    entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>>
>>> value changed: 0x0000000000000000 -> 0xfffffff000002788
>>>
>>> Reported by Kernel Concurrency Sanitizer on:
>>> CPU: 0 PID: 8268 Comm: syz-executor.4 Not tainted 6.5.0-syzkaller-00453-g727dbda16b83 #0
>>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
>>> ==================================================================
>>
>> This case is with two tasks doing bpf_map batch update together for the
>> same map and key.
>>     > write to 0xffffe8fffe7425d8 of 8 bytes by task 8257 on cpu 1:
>>     > write to 0xffffe8fffe7425d8 of 8 bytes by task 8268 on cpu 0:
>>
>> So concurrency is introduced by user applications.
>> In my opinion, this probably not an issue from kernel perspective.
> 
> Perhaps not, but I recall there being a discussion about making KCSAN
> aware of memory accesses done by BPF programs (memcpy being a tiny
> subset of those). Not sure if the above data race qualifies as
> something we might want to still detect, i.e. a kernel dev testing
> their kernel might be interested in such a report.
> 
> Regardless, in this case we should teach syzkaller to ignore KCSAN
> data races that originate from bpf user operations whatever the
> origin.

I presume KCSAN could be silenced here via READ_ONCE/WRITE_ONCE conversion?

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index f58895830ada..32c4a37045f2 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -424,8 +424,11 @@ static inline void bpf_long_memcpy(void *dst, const void *src, u32 size)
  	long *ldst = dst;

  	size /= sizeof(long);
-	while (size--)
-		*ldst++ = *lsrc++;
+	while (size--) {
+		WRITE_ONCE(*ldst, READ_ONCE(*lsrc));
+		ldst++;
+		lsrc++;
+	}
  }

  /* copy everything but bpf_spin_lock, bpf_timer, and kptrs. There could be one of each. */

