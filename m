Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D41E634EE7
	for <lists+bpf@lfdr.de>; Wed, 23 Nov 2022 05:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235373AbiKWEWb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 22 Nov 2022 23:22:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235743AbiKWEVh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Nov 2022 23:21:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70973F4190;
        Tue, 22 Nov 2022 20:17:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A3ACDB81E51;
        Wed, 23 Nov 2022 04:17:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0D5FC433D6;
        Wed, 23 Nov 2022 04:17:11 +0000 (UTC)
Date:   Tue, 22 Nov 2022 23:17:10 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Zheng Yejian <zhengyejian1@huawei.com>
Cc:     <mhiramat@kernel.org>, <yujie.liu@intel.com>,
        <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tracing: Optimize event type allocation with IDA
Message-ID: <20221122231710.4315f890@rorschach.local.home>
In-Reply-To: <20221122223258.10faaf4e@rorschach.local.home>
References: <20221111234137.90d9ec624497a7e1f5cb5003@kernel.org>
        <20221123031806.735511-1-zhengyejian1@huawei.com>
        <20221122223258.10faaf4e@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 22 Nov 2022 22:32:58 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> To explain this better, let's look at the following scenario:
> 
>  echo 'p:foo val=$arg1:u64' > kprobe_events
>  echo 1 > events/kprobes/foo/enable
>  sleep 1
>  echo 0 > events/kprobes/foo/enable
> 
>  echo 'p:bar val=+0($arg1):string' > kprobe_events
> 
>  # foo kprobe is deleted and bar is created and
>  # with IDA, bar has the same number for type as foo
> 
>  cat trace
> 
> When you read the trace, it will see a binary blob representing an
> event and marked with a type. Although the event was foo, it will now
> map it to bar. And it will read foo's $arg1:u64 as bar's
> +0($arg1):string, and will crash.

I just tested my theory, and it proved it:

 # cd /sys/kernel/tracing
 # echo 'p:kprobes/foo do_sys_openat2 $arg1:u32' > kprobe_events
 # echo 1 > events/kprobes/foo/enable
 # cat /etc/passwd
 # echo 0 > events/kprobes/foo/enable
 # echo 'p:kprobes/foo do_sys_openat2 +0($arg2):string' > kprobe_events
 # cat trace
# tracer: nop
#
# entries-in-buffer/entries-written: 14/14   #P:8
#
#                                _-----=> irqs-off/BH-disabled
#                               / _----=> need-resched
#                              | / _---=> hardirq/softirq
#                              || / _--=> preempt-depth
#                              ||| / _-=> migrate-disable
#                              |||| /     delay
#           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
#              | |         |   |||||     |         |
        sendmail-1942    [002] .....   530.136320: foo: (do_sys_openat2+0x0/0x240) arg1=             cat-2046    [004] .....   530.930817: foo: (do_sys_openat2+0x0/0x240) arg1="������������������������������������������������������������������������������������������������"
             cat-2046    [004] .....   530.930961: foo: (do_sys_openat2+0x0/0x240) arg1="������������������������������������������������������������������������������������������������"
             cat-2046    [004] .....   530.934278: foo: (do_sys_openat2+0x0/0x240) arg1="������������������������������������������������������������������������������������������������"
             cat-2046    [004] .....   530.934563: foo: (do_sys_openat2+0x0/0x240) arg1="������������������������������������������������������������������������������������������������"
            bash-1515    [007] .....   534.299093: foo: (do_sys_openat2+0x0/0x240) arg1="kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk���������@��4Z����;Y�����U

And dmesg has:

[  558.504698] ==================================================================
[  558.511925] BUG: KASAN: use-after-free in string+0xd4/0x1c0
[  558.517501] Read of size 1 at addr ffff88805fdbbfa0 by task cat/2049

[  558.525348] CPU: 0 PID: 2049 Comm: cat Not tainted 6.1.0-rc6-test+ #641
[  558.531959] Hardware name: Hewlett-Packard HP Compaq Pro 6300 SFF/339A, BIOS K01 v03.03 07/14/2016
[  558.540909] Call Trace:
[  558.543360]  <TASK>
[  558.545465]  dump_stack_lvl+0x5b/0x77
[  558.549132]  print_report+0x17f/0x47b
[  558.552805]  ? __virt_addr_valid+0xd9/0x160
[  558.556998]  ? string+0xd4/0x1c0
[  558.560229]  ? string+0xd4/0x1c0
[  558.563462]  kasan_report+0xad/0x130
[  558.567042]  ? string+0xd4/0x1c0
[  558.570274]  string+0xd4/0x1c0
[  558.573332]  ? ip6_addr_string_sa+0x3e0/0x3e0
[  558.577690]  ? format_decode+0xa2/0x690
[  558.581531]  ? simple_strtoul+0x10/0x10
[  558.585378]  vsnprintf+0x500/0x840
[  558.588785]  ? pointer+0x740/0x740
[  558.592190]  ? pointer+0x740/0x740
[  558.595594]  seq_buf_vprintf+0x62/0xc0
[  558.599346]  trace_seq_printf+0x10e/0x1e0
[  558.603359]  ? trace_seq_bitmask+0x130/0x130
[  558.607632]  ? memcpy+0x38/0x60
[  558.610774]  ? seq_buf_putmem+0x6e/0xa0
[  558.614616]  print_type_string+0x90/0xa0
[  558.618539]  ? print_type_symbol+0x80/0x80
[  558.622640]  print_kprobe_event+0x16b/0x290
[  558.626830]  print_trace_line+0x451/0x8e0
[  558.630847]  ? tracing_buffers_read+0x3f0/0x3f0
[  558.635380]  ? preempt_count_sub+0xb7/0x100
[  558.639566]  ? _raw_spin_unlock_irqrestore+0x28/0x50
[  558.644532]  ? trace_find_next_entry_inc+0xa7/0xe0
[  558.649325]  s_show+0x72/0x1f0
[  558.652386]  seq_read_iter+0x58e/0x750
[  558.656147]  seq_read+0x115/0x160
[  558.659475]  ? seq_read_iter+0x750/0x750
[  558.663401]  ? __mod_lruvec_page_state+0x123/0x280
[  558.668199]  ? tracer_preempt_on+0x74/0x1d0
[  558.672386]  ? preempt_count_sub+0xb7/0x100
[  558.676573]  ? fsnotify_perm.part.0+0xa0/0x250
[  558.681025]  vfs_read+0x11d/0x460
[  558.684344]  ? kernel_read+0xc0/0xc0
[  558.687922]  ? __fget_light+0x1b0/0x200
[  558.691763]  ksys_read+0xa9/0x130
[  558.695082]  ? __ia32_sys_pwrite64+0x120/0x120
[  558.699528]  ? trace_hardirqs_on+0x2c/0x110
[  558.703715]  do_syscall_64+0x3a/0x90
[  558.707304]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[  558.712356] RIP: 0033:0x7fc2e972ade2
[  558.715934] Code: c0 e9 b2 fe ff ff 50 48 8d 3d b2 3f 0a 00 e8 05 f0 01 00 0f 1f 44 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 0f 05 <48> 3d 00 f0 ff ff 77 56 c3 0f 1f 44 00 00 48 83 ec 28 48 89 54 24
[  558.734684] RSP: 002b:00007ffc64e687c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
[  558.742257] RAX: ffffffffffffffda RBX: 0000000000020000 RCX: 00007fc2e972ade2
[  558.749388] RDX: 0000000000020000 RSI: 00007fc2e980d000 RDI: 0000000000000003
[  558.756520] RBP: 00007fc2e980d000 R08: 00007fc2e980c010 R09: 0000000000000000
[  558.763652] R10: 0000000000000022 R11: 0000000000000246 R12: 0000000000020f00
[  558.770785] R13: 0000000000000003 R14: 0000000000020000 R15: 0000000000020000
[  558.777920]  </TASK>

[  558.781609] The buggy address belongs to the physical page:
[  558.787182] page:ffffea00017f6ec0 refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x5fdbb
[  558.796483] flags: 0xfffffc0000000(node=0|zone=1|lastcpupid=0x1fffff)
[  558.802925] raw: 000fffffc0000000 0000000000000000 ffffea00017f6ec8 0000000000000000
[  558.810663] raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
[  558.818400] page dumped because: kasan: bad access detected

[  558.825465] Memory state around the buggy address:
[  558.830258]  ffff88805fdbbe80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[  558.837479]  ffff88805fdbbf00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[  558.844699] >ffff88805fdbbf80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[  558.851917]                                ^
[  558.856190]  ffff88805fdbc000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[  558.863409]  ffff88805fdbc080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[  558.870628] ==================================================================

Look familiar?

-- Steve

