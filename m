Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71548669D29
	for <lists+bpf@lfdr.de>; Fri, 13 Jan 2023 17:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjAMQFp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Jan 2023 11:05:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjAMQFP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Jan 2023 11:05:15 -0500
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D8ABE11
        for <bpf@vger.kernel.org>; Fri, 13 Jan 2023 07:57:12 -0800 (PST)
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1pGMQY-0004cG-Hh; Fri, 13 Jan 2023 16:57:10 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1pGMQY-000AxQ-B5; Fri, 13 Jan 2023 16:57:10 +0100
Subject: Re: Kernel Panic in 4.19 ARM machines
To:     Greg KH <gregkh@linuxfoundation.org>,
        rainkin <rainkin1993@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
References: <CAHb-xauaGvVZrtRzCNNV370oc8swk2z3WYnLSMb3xy=rpLgOQw@mail.gmail.com>
 <Y8A50JKE65eohBCY@kroah.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <906d5e67-9cf2-f36b-c62b-6c10d26ccfdd@iogearbox.net>
Date:   Fri, 13 Jan 2023 16:57:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <Y8A50JKE65eohBCY@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.7/26780/Fri Jan 13 09:37:02 2023)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/12/23 5:48 PM, Greg KH wrote:
> On Fri, Jan 13, 2023 at 12:11:18AM +0800, rainkin wrote:
>> Hi,
>>
>> My ebpf program based on libbpf(v0.7) causes the kernel 4.19 (ARM
>> machine) panic:
>>
>> Kernel panic - not syncing: softlockup: hung tasks
>> CPU: 3 PID: 2524351 Comm: sshd Kdump: loaded Tainted: G
>> Call trace:
>> dump_backtrace
>> show_stack
>> dump_stack
>> panic
>> lockup_detector_update_enable
>> __hrtimer_run_queues
>> hrtimer_interrupt
>> arch_timer_handler_virt
>> handle_percpu_devid_irq
>> generic_handle_irq
>> __handle_domain_irq
>> gic_handle_irq
>> el1_irq
>> smp_call_function_many
>> kick_all_cpus_sync
>> bpf_int_jit_compile
>> bpf_prog_select_runtime
>> bpf_prepare_filter
>> bpf_prog_create_from_user
>> seccomp_set_mode_filter
>> do_seccomp
>> prctl_set_seccomp
>> __se_sys_prctl
>> __arm64_sys_prctl
>> el0_svc_common
>> el0_svc_handler
>> el0_svc
>>
>> Then I test the same ebpf program on kernel 4.19 (x86 machine), the
>> kernel DOES NOT panic.
>> I test it on kernel 5.10 (ARM machine), the kernel DOES NOT panic.
>>
>> Thus I guess this is a kernel bug related to ARM arch and has been
>> fixed in 5.10.
>>
>> Does anyone know any kernel bug or patch related to this issue?
> 
> Can you use 'git bisect' to track down the commit that resolves this?

+1, @rainkin location wrt fixes is here:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/arch/arm/net

Thanks,
Daniel
