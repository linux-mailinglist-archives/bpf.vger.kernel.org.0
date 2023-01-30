Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B55C681DA3
	for <lists+bpf@lfdr.de>; Mon, 30 Jan 2023 23:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjA3WEn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Jan 2023 17:04:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjA3WEm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Jan 2023 17:04:42 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E945E4997E
        for <bpf@vger.kernel.org>; Mon, 30 Jan 2023 14:04:14 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id m13so1235147plx.13
        for <bpf@vger.kernel.org>; Mon, 30 Jan 2023 14:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=R03ztAmIihn3Fz+0E5HaX1x1wBSZWWdNMT7FdbVJlIc=;
        b=k1ZfyB3pS4FVWbFofCTRoi3SxUB22P+NC2al0pXmuCE6uBAEI/PqhCiFzzp0kie3Xm
         MRG8mDY9c/ZsHsfkJmbEmOSXaQmlcmBbrptp6VVVmqGQpPVdVQn9YY5bTtgwyrCe2og7
         Uh1mJx/IbC0n2MOZyYwFn4vCHpWMsA/vvVRziTL6tC2tKCMwx9Ywf3a3NhQ6K6UZWLav
         Cprxxbwev5Go5Mxs3k+OY6jhp7Kaed7H/EfdUnC9ZzHBtZB2CY2h0JPnhcgXSOgitxnA
         psJA5wkBRUldcRuPETL4HLwIKpCBDLsT7hlYYQnHYXhbRtAuOa45lb6iJ5VedF6e3oBa
         3VmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R03ztAmIihn3Fz+0E5HaX1x1wBSZWWdNMT7FdbVJlIc=;
        b=faUM7KrHmGERi6Z/HC6f2xXnTwOWmkXOVRngXKJjHiQJtfNOD1coOOljjsBIL7FoHw
         Nzl8SGArzvZeg2KaIq6BvDbCWt7My8a1R7C7NuTqrMuTGmur9LzTYwo8h362VYwfWgkV
         9pVG4bwsM3aeNItcHkjbS3Wg+cMhwbiywJA/jl5v9rZz2P3M/Plim2RpDgGsuLCoBpHD
         0uVZsaoioeQ54Oz8lC/Ls+XbX8BJ2eKpIyoPclNLBGofXgYWM3PeatwklAkiqZHvxfls
         MqU49+FhSZb3N0d+RzLdZmFeBR92iQtfVN2TKxuFmCtI7k3TddEwTbF9OI8Cqjn4cA43
         GsEA==
X-Gm-Message-State: AO0yUKUVPb7ZeY5+5Y57sZzZd1nclsbgPOtKAE2f9//L3bMjHzt7ZKks
        VBPsHp8IwEaK9+iZgW6hWfM=
X-Google-Smtp-Source: AK7set/ITktxOFVKKJGvfLPIO/HxH+XfH4oMdBCZQW+7jyoofGaZHdwSuVYcv3WOpg+ZtDPJrwIGKQ==
X-Received: by 2002:a17:90b:2250:b0:22c:36a6:71a6 with SMTP id hk16-20020a17090b225000b0022c36a671a6mr17230849pjb.41.1675116252133;
        Mon, 30 Jan 2023 14:04:12 -0800 (PST)
Received: from macbook-pro-6.dhcp.thefacebook.com ([2620:10d:c090:400::5:a52d])
        by smtp.gmail.com with ESMTPSA id g10-20020a17090a67ca00b0022bf4d0f912sm9538287pjm.22.2023.01.30.14.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 14:04:11 -0800 (PST)
Date:   Mon, 30 Jan 2023 14:04:09 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Ori Glassman <ori.glassman@aquasec.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>,
        KP Singh <kpsingh@chromium.org>
Subject: Re: Interruptable eBPF programs
Message-ID: <20230130220409.ux33fhwvghqwtujw@macbook-pro-6.dhcp.thefacebook.com>
References: <DU2PR03MB8006D93D98BD58AFF9657F3F96D39@DU2PR03MB8006.eurprd03.prod.outlook.com>
 <23537684-afd1-e31d-741e-acaf8a201156@iogearbox.net>
 <CAADnVQLsXLGk5nOx75r-Os+S8wxKjboV3_SKqUm0QXTZXUeDSA@mail.gmail.com>
 <DU2PR03MB80069C24EAB81F7D72FD7EF196D39@DU2PR03MB8006.eurprd03.prod.outlook.com>
 <DU2PR03MB800662EF7057E230662B34B196D39@DU2PR03MB8006.eurprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DU2PR03MB800662EF7057E230662B34B196D39@DU2PR03MB8006.eurprd03.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 30, 2023 at 06:47:54PM +0000, Ori Glassman wrote:
> 
> > security@kernel alias is not the place to ask bpf related questions.
> I apologise if it was confusing, I wasn't asking a question - rather raising a security concern of mine.

That is a security concern with a design of your service.
sec@kern is about kernel bugs:
Documentation/admin-guide/security-bugs.rst

> > Yaniv, from your team, already brought it up here:
> > https://lore.kernel.org/bpf/CAADnVQ++LzKt9Q-GtGXknVBqyMqY=vLJ3tR3NNGG3P66gvVCFQ@mail.gmail.com/
> 
> > You cannot assume that different bpf progs attached to various
> > events like tracepoints and lsm hooks won't overlap.
> > It's a bug in your program. Nothing else.
> How can one use bpf_task_storage_get() without the risk of getting corrupted? Say there's a module that consists of 1 simple program, a single LSM hook on bprm_creds_for_exec, that uses a local task storage pinned map. 
> An attacker at some point in the future loads his tracepoint program, and maliciously corrupts the local storage *while* the LSM hook is executing, not after or before. What's the bug in the program that consists of the single LSM hook?

The local storage map is also accessible via bpf syscall map_update_elem command.
If user can get an FD to that map they can update it.
It's your job to design the service such that bpf maps are not laying around for everyone to poke into.
But if user has root access it can do anything.

> > These two programs access some task local storage.
> I'm talking specifically when the programs are executed by the same task and thus accessing the same local storage.
> > This code racy regardless of preempt_disable vs migrate_disable.
> > bpf_task_storage_get() of the same task can run on different cpus.
> Not at the same time though, right? I'm not concerned about the cases where the map is used in multiple programs - I'm concerned about the cases where it's used locally in a single program, but gets corrupted in a timely manner from the outside by an attacker.

At the same time.
Two cpus can observe the same task local storage.

> > Whether trace_sched_process_free and security_bprm_creds_for_exec
> > can happen on different cpus is kernel implementation detail.
> 
> > There looks to be another bug in the above:
> > doing bpf_get_current_task_btf from raw_tracepoint/sched_process_free
> > will return task_struct of the worker thread.
> > I don't think it's the one you want.
> That's not what I observed - this is the output of bpf_trace_printk where the execution of the LSM hook got interrupted mid-execution:
> ----
>  chrony-onofflin-12460   [000] d.s.1  2258.804195: bpf_trace_printk: EXECUTION HIJACK(b=2257261931167) # this is from tp/sched_process_free
>  chrony-onofflin-12460   [000] d...1  2258.804234: bpf_trace_printk: a=2257261896666. c=2257261971220 # from the lsm hook

It's "working" by accident.
