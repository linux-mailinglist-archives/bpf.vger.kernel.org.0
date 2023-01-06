Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFADB6608FA
	for <lists+bpf@lfdr.de>; Fri,  6 Jan 2023 22:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjAFVyj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 6 Jan 2023 16:54:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjAFVyi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 Jan 2023 16:54:38 -0500
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504C52ACC;
        Fri,  6 Jan 2023 13:54:37 -0800 (PST)
Received: from sslproxy04.your-server.de ([78.46.152.42])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1pDufZ-0006V4-LP; Fri, 06 Jan 2023 22:54:33 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy04.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1pDufZ-000XXS-46; Fri, 06 Jan 2023 22:54:33 +0100
Subject: Re: [PATCH] bpf: skip task with pid=1 in send_signal_common()
To:     Stanislav Fomichev <sdf@google.com>, Hao Sun <sunhao.th@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, haoluo@google.com,
        jolsa@kernel.org, davem@davemloft.net, linux-kernel@vger.kernel.org
References: <20230106084838.12690-1-sunhao.th@gmail.com>
 <CAKH8qBtAubqGg42+QgNv5nTHeHke=OWskfR1bxX0TG4yGb-FAg@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <f262fb2a-a173-a979-f34f-d8a7eba49441@iogearbox.net>
Date:   Fri, 6 Jan 2023 22:54:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAKH8qBtAubqGg42+QgNv5nTHeHke=OWskfR1bxX0TG4yGb-FAg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.7/26773/Fri Jan  6 09:48:44 2023)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/6/23 8:44 PM, Stanislav Fomichev wrote:
> On Fri, Jan 6, 2023 at 12:48 AM Hao Sun <sunhao.th@gmail.com> wrote:
>>
>> The following kernel panic can be triggered when a task with pid=1
>> attach a prog that attempts to send killing signal to itself, also
>> see [1] for more details:
>>
>> Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
>> CPU: 3 PID: 1 Comm: systemd Not tainted 6.1.0-09652-g59fe41b5255f #148
>> Call Trace:
>> <TASK>
>> __dump_stack lib/dump_stack.c:88 [inline]
>> dump_stack_lvl+0x100/0x178 lib/dump_stack.c:106
>> panic+0x2c4/0x60f kernel/panic.c:275
>> do_exit.cold+0x63/0xe4 kernel/exit.c:789
>> do_group_exit+0xd4/0x2a0 kernel/exit.c:950
>> get_signal+0x2460/0x2600 kernel/signal.c:2858
>> arch_do_signal_or_restart+0x78/0x5d0 arch/x86/kernel/signal.c:306
>> exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
>> exit_to_user_mode_prepare+0x15f/0x250 kernel/entry/common.c:203
>> __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
>> syscall_exit_to_user_mode+0x1d/0x50 kernel/entry/common.c:296
>> do_syscall_64+0x44/0xb0 arch/x86/entry/common.c:86
>> entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>
>> So skip task with pid=1 in bpf_send_signal_common() to avoid the panic.
>>
>> [1] https://lore.kernel.org/bpf/20221222043507.33037-1-sunhao.th@gmail.com
>>
>> Signed-off-by: Hao Sun <sunhao.th@gmail.com>
> 
> Acked-by: Stanislav Fomichev <sdf@google.com>

Looks good, agree & applied. These three tests could actually be refactored and also
reused in bpf_probe_write_user() given also the latter should have no business to
mess with pid 1.

>>   kernel/trace/bpf_trace.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
>> index 23ce498bca97..ed21ab9fe846 100644
>> --- a/kernel/trace/bpf_trace.c
>> +++ b/kernel/trace/bpf_trace.c
>> @@ -844,6 +844,9 @@ static int bpf_send_signal_common(u32 sig, enum pid_type type)
>>           */
>>          if (unlikely(current->flags & (PF_KTHREAD | PF_EXITING)))
>>                  return -EPERM;
>> +       /* Task should not be pid=1 to avoid kernel panic. */
>> +       if (unlikely(is_global_init(current)))
>> +               return -EPERM;
>>          if (unlikely(!nmi_uaccess_okay()))
>>                  return -EPERM;
>>
>>
>> base-commit: 4aea86b4033f92f01547e6d4388d4451ae9b0980
>> --
>> 2.39.0
>>

