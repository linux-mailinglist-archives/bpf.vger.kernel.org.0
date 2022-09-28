Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E17DA5ED959
	for <lists+bpf@lfdr.de>; Wed, 28 Sep 2022 11:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232932AbiI1JnG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Sep 2022 05:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbiI1JnF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Sep 2022 05:43:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A60482623
        for <bpf@vger.kernel.org>; Wed, 28 Sep 2022 02:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664358182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e896d3p2GV00M1qPWHa/GVdZCvllUrpZmXvQcwWgt3E=;
        b=BWXb6jvC140MJUi7ScXhSsI6fmDmnxYPnTgrmAYOtddlClHkfo0Do11pLKEiWdUseOCc2f
        0IUd86jK4fr6uTx4s6V78EMfWbUl5fZj9mg9QYrnYtKcrj9LSs5LVhPrZsXIjSULHYQayp
        ecksllKs3kTGqJqJmrcPRNSs81cM2rQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-280-LbO8cnw0MVGsOyu2Z_faQA-1; Wed, 28 Sep 2022 05:43:01 -0400
X-MC-Unique: LbO8cnw0MVGsOyu2Z_faQA-1
Received: by mail-ed1-f71.google.com with SMTP id y14-20020a056402440e00b0044301c7ccd9so9816220eda.19
        for <bpf@vger.kernel.org>; Wed, 28 Sep 2022 02:43:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=e896d3p2GV00M1qPWHa/GVdZCvllUrpZmXvQcwWgt3E=;
        b=0s3TvhY1HIYQWGaNEMmuqW4bCVBTL5lON4CPcSlEZ00KaMbFEWg4r4d2divdP8+4lM
         8/WHHkygCUwbfXunmroTZ+AiuY7zeFrsPJp8UadQA/h5FKck1V07xK3ZkgWtOipO24tp
         mCPphnRi1XpDPPENqYuyS7CkP5en5ebf6vzBGhkM1zXQDT3NTuEcbDZZ8HXsQW0ER1Yn
         39QABVI7oiUhSxPWxLWAqxha3g4Fc0W+9Gw9ta4DEroIvNnlM4ox2owykAYaDCWCF8Ko
         dJreouxZLCRejYCSqcun36aM7bj1VdMicvCD8YV8PJm+vJIcYogc4qajNdYchXRX2+Ah
         sUsg==
X-Gm-Message-State: ACrzQf1jxm6pFuaV+msQSgpzPhGpnK8Wz0EnmT02BSGVPNsH24SKwSfO
        SxIE3caIl0/MtB7ru21bMOjwGdwtyCfj20A8a4X0gu9Zl1drsbZtuHwT8vwwbgN/mdwkrFu8eWS
        S6Uj1WFXDWLOP
X-Received: by 2002:a17:906:478d:b0:783:2270:e85a with SMTP id cw13-20020a170906478d00b007832270e85amr16115178ejc.371.1664358179913;
        Wed, 28 Sep 2022 02:42:59 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7S8dt3b5d5cEWrRWEWAa1fgGCgEtYriooBRab/9F0zzWFUSuf4CLxvKzom7H85rA1s+owv5A==
X-Received: by 2002:a17:906:478d:b0:783:2270:e85a with SMTP id cw13-20020a170906478d00b007832270e85amr16115152ejc.371.1664358179650;
        Wed, 28 Sep 2022 02:42:59 -0700 (PDT)
Received: from [192.168.41.81] (83-90-141-187-cable.dk.customer.tdc.net. [83.90.141.187])
        by smtp.gmail.com with ESMTPSA id 26-20020a170906309a00b00781b589a1afsm2095858ejv.159.2022.09.28.02.42.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 02:42:59 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <91bbd6dd-04d4-51a0-8a7d-cf124cefca29@redhat.com>
Date:   Wed, 28 Sep 2022 11:42:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Cc:     brouer@redhat.com, ast@kernel.org, daniel@iogearbox.net,
        john.fastabend@gmail.com, kpsingh@chromium.org, kernel-team@fb.com,
        haoluo@google.com, jlayton@kernel.org, bjorn@kernel.org,
        Toke Hoiland Jorgensen <toke@redhat.com>,
        Clark Williams <clark@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH v2 bpf-next 0/2] enforce W^X for trampoline and dispatcher
Content-Language: en-US
To:     Song Liu <song@kernel.org>, bpf@vger.kernel.org
References: <20220926184739.3512547-1-song@kernel.org>
In-Reply-To: <20220926184739.3512547-1-song@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 26/09/2022 20.47, Song Liu wrote:
> Changes v1 => v2:
> 1. Update arch_prepare_bpf_dispatcher to use a RO image and a RW buffer.
>     (Alexei) Note: I haven't found an existing test to cover this part, so
>     this part was tested manually (comparing the generated dispatcher is
>     the same).
> 
> Jeff Layton reported CPA W^X warning linux-next [1]. It turns out to be
> W^X issue with bpf trampoline and bpf dispatcher. Fix these by:
> 
> 1. Use bpf_prog_pack for bpf_dispatcher;
> 2. Set memory permission properly with bpf trampoline.

Indirectly related to your patchset[0].
  - TL;DR calling set_memory_x() have side-effects

We are getting reports that loading BPF-progs (jit stage) cause issues 
for RT in the form of triggering work on isolated CPUs.  It looks like 
BTF JIT stage cause a TLB flush on all CPUs, including isolated CPUs.

The triggering function is set_memory_x() (see call-stack[2]).

We have noticed (and appreciate) you have previously improved the 
situation in this patchset[3]:
  [3] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=80123f0ac4a6

Is this patchset also part of improving the situation, or does it 
introduce more calls to set_memory_x() ?


> [1] https://lore.kernel.org/lkml/c84cc27c1a5031a003039748c3c099732a718aec.camel@kernel.org/


[2] Call stack triggering issue:

         smp_call_function_many_cond+0x1
         smp_call_function+0x39
         on_each_cpu+0x2a
         cpa_flush+0x11a
         change_page_attr_set_clr+0x129
         set_memory_x+0x37
         bpf_int_jit_compile+0x36f
         bpf_prog_select_runtime+0xc6
         bpf_prepare_filter+0x523
         sk_attach_filter+0x13
         sock_setsockopt+0x920
         __sys_setsockopt+0x16a
         __x64_sys_setsockopt+0x20
         do_syscall_64+0x87
         entry_SYSCALL_64_after_hwframe+0x65


[0] https://lore.kernel.org/all/20220926184739.3512547-1-song@kernel.org/#r

--Jesper

