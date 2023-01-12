Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7AE667CB9
	for <lists+bpf@lfdr.de>; Thu, 12 Jan 2023 18:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbjALRig (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Jan 2023 12:38:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbjALRhd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Jan 2023 12:37:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD5C6B5EB
        for <bpf@vger.kernel.org>; Thu, 12 Jan 2023 08:58:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 08DE3B81EE8
        for <bpf@vger.kernel.org>; Thu, 12 Jan 2023 16:48:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D1CAC433EF;
        Thu, 12 Jan 2023 16:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1673542098;
        bh=KFwT22c53rIZY8g9pc/A0DYZY/YJ9euFTtTdJbFcepA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=01A2odVJQe5R/xrks/3fsqBbgr5h7/i1Grt2DKY6NO/jYAebVXLcbCsAKhNA5z23b
         /tR+M4z2TKZ23JnMl+QrIINlM4vum6pWWlqTd31qwpaoca7KWVzCR5P5x9Lqo8lFKe
         9pasNn/3RONlcZ76XjNy52FuWwFtc6ftiahZWEMw=
Date:   Thu, 12 Jan 2023 17:48:16 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     rainkin <rainkin1993@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Subject: Re: Kernel Panic in 4.19 ARM machines
Message-ID: <Y8A50JKE65eohBCY@kroah.com>
References: <CAHb-xauaGvVZrtRzCNNV370oc8swk2z3WYnLSMb3xy=rpLgOQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHb-xauaGvVZrtRzCNNV370oc8swk2z3WYnLSMb3xy=rpLgOQw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 13, 2023 at 12:11:18AM +0800, rainkin wrote:
> Hi,
> 
> My ebpf program based on libbpf(v0.7) causes the kernel 4.19 (ARM
> machine) panic:
> 
> Kernel panic - not syncing: softlockup: hung tasks
> CPU: 3 PID: 2524351 Comm: sshd Kdump: loaded Tainted: G
> Call trace:
> dump_backtrace
> show_stack
> dump_stack
> panic
> lockup_detector_update_enable
> __hrtimer_run_queues
> hrtimer_interrupt
> arch_timer_handler_virt
> handle_percpu_devid_irq
> generic_handle_irq
> __handle_domain_irq
> gic_handle_irq
> el1_irq
> smp_call_function_many
> kick_all_cpus_sync
> bpf_int_jit_compile
> bpf_prog_select_runtime
> bpf_prepare_filter
> bpf_prog_create_from_user
> seccomp_set_mode_filter
> do_seccomp
> prctl_set_seccomp
> __se_sys_prctl
> __arm64_sys_prctl
> el0_svc_common
> el0_svc_handler
> el0_svc
> 
> Then I test the same ebpf program on kernel 4.19 (x86 machine), the
> kernel DOES NOT panic.
> I test it on kernel 5.10 (ARM machine), the kernel DOES NOT panic.
> 
> Thus I guess this is a kernel bug related to ARM arch and has been
> fixed in 5.10.
> 
> Does anyone know any kernel bug or patch related to this issue?

Can you use 'git bisect' to track down the commit that resolves this?

thanks,

greg k-h
