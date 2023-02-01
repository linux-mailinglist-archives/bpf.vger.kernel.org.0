Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C26A68719C
	for <lists+bpf@lfdr.de>; Thu,  2 Feb 2023 00:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjBAXIM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Feb 2023 18:08:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjBAXIL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Feb 2023 18:08:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2421F166DD
        for <bpf@vger.kernel.org>; Wed,  1 Feb 2023 15:08:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 797FCB82334
        for <bpf@vger.kernel.org>; Wed,  1 Feb 2023 23:08:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EC32C433D2
        for <bpf@vger.kernel.org>; Wed,  1 Feb 2023 23:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675292887;
        bh=SS3xg7WdqPMnbD+wUvyC3G99kf943ylxgn49okEqNe0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=e/yeLOxy18itLUtbBFvFeg/pKrBBdsvJLrO0MehL/3Z9oNelpqIsakXvHbPdeMlSK
         flFxwUPlvTeOkDq3nh4octEV0C1qxLX4ydwgcjyyRpB4NlIbFln08SVOo87jMrSsiN
         iVq1vGE4d/qLWSwTrqJNZVbz6qdrblKTg6LQ+5JBM+xYu1Cotb3afRFK9tRR4uuudW
         C2qT0bfr29bP+NZHxvJF7k34nXQiYH265gjvHE88tx2GTqKQOAh3859TVXdQQU4qck
         bHfVbkWCORd/OttIXPsxuzQzjTBJoFMRZl2fgLcp/QKZ+HDNfOpz8qEbe7spu3Nmzn
         QudaLXyCrHGBA==
Received: by mail-ej1-f41.google.com with SMTP id ud5so1107811ejc.4
        for <bpf@vger.kernel.org>; Wed, 01 Feb 2023 15:08:07 -0800 (PST)
X-Gm-Message-State: AO0yUKWMAYLNO6beUkLYL1yBnQV1HomAqtHfPwZmhjxI2X7HIM9CxGKF
        bkf/SPcH7KeOw1AjZgNAQmpAWDMp7UHZX830qTsm9A==
X-Google-Smtp-Source: AK7set9On5BkgvZz79A6J70b3bb+4aii+IzEeNFIFeovyPy+zB5ZNMx6K4vEuXb5iMsfqzsdgw19q8s1on3MrMzHVtg=
X-Received: by 2002:a17:906:6c86:b0:87c:c2eb:6dfa with SMTP id
 s6-20020a1709066c8600b0087cc2eb6dfamr1331940ejr.204.1675292885429; Wed, 01
 Feb 2023 15:08:05 -0800 (PST)
MIME-Version: 1.0
References: <DU2PR03MB8006D93D98BD58AFF9657F3F96D39@DU2PR03MB8006.eurprd03.prod.outlook.com>
 <23537684-afd1-e31d-741e-acaf8a201156@iogearbox.net> <CAADnVQLsXLGk5nOx75r-Os+S8wxKjboV3_SKqUm0QXTZXUeDSA@mail.gmail.com>
 <DU2PR03MB80069C24EAB81F7D72FD7EF196D39@DU2PR03MB8006.eurprd03.prod.outlook.com>
 <DU2PR03MB800662EF7057E230662B34B196D39@DU2PR03MB8006.eurprd03.prod.outlook.com>
 <20230130220409.ux33fhwvghqwtujw@macbook-pro-6.dhcp.thefacebook.com>
In-Reply-To: <20230130220409.ux33fhwvghqwtujw@macbook-pro-6.dhcp.thefacebook.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Thu, 2 Feb 2023 01:07:54 +0200
X-Gmail-Original-Message-ID: <CACYkzJ7ThF4wFdrM_-ZkMZooxCNXAHqKefizevL-jKUGUprB9A@mail.gmail.com>
Message-ID: <CACYkzJ7ThF4wFdrM_-ZkMZooxCNXAHqKefizevL-jKUGUprB9A@mail.gmail.com>
Subject: Re: Interruptable eBPF programs
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Ori Glassman <ori.glassman@aquasec.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 31, 2023 at 12:04 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Jan 30, 2023 at 06:47:54PM +0000, Ori Glassman wrote:
> >
> > > security@kernel alias is not the place to ask bpf related questions.
> > I apologise if it was confusing, I wasn't asking a question - rather ra=
ising a security concern of mine.
>
> That is a security concern with a design of your service.
> sec@kern is about kernel bugs:
> Documentation/admin-guide/security-bugs.rst
>
> > > Yaniv, from your team, already brought it up here:
> > > https://lore.kernel.org/bpf/CAADnVQ++LzKt9Q-GtGXknVBqyMqY=3DvLJ3tR3NN=
GG3P66gvVCFQ@mail.gmail.com/
> >
> > > You cannot assume that different bpf progs attached to various
> > > events like tracepoints and lsm hooks won't overlap.
> > > It's a bug in your program. Nothing else.
> > How can one use bpf_task_storage_get() without the risk of getting corr=
upted? Say there's a module that consists of 1 simple program, a single LSM=
 hook on bprm_creds_for_exec, that uses a local task storage pinned map.
> > An attacker at some point in the future loads his tracepoint program, a=
nd maliciously corrupts the local storage *while* the LSM hook is executing=
, not after or before. What's the bug in the program that consists of the s=
ingle LSM hook?

So, your MAC policy allows unprivileged users (i.e. the attacker) to
tamper with security blobs (i.e. task_local_storage). This is a bad
idea, your policy should prevent the helper being accessible to other
programs. Rather, it should ideally prevent loading of untrusted BPF
programs completely.

- KP

>
> The local storage map is also accessible via bpf syscall map_update_elem =
command.
> If user can get an FD to that map they can update it.
> It's your job to design the service such that bpf maps are not laying aro=
und for everyone to poke into.
> But if user has root access it can do anything.
>
> > > These two programs access some task local storage.
> > I'm talking specifically when the programs are executed by the same tas=
k and thus accessing the same local storage.
> > > This code racy regardless of preempt_disable vs migrate_disable.
> > > bpf_task_storage_get() of the same task can run on different cpus.
> > Not at the same time though, right? I'm not concerned about the cases w=
here the map is used in multiple programs - I'm concerned about the cases w=
here it's used locally in a single program, but gets corrupted in a timely =
manner from the outside by an attacker.
>
> At the same time.
> Two cpus can observe the same task local storage.
>
> > > Whether trace_sched_process_free and security_bprm_creds_for_exec
> > > can happen on different cpus is kernel implementation detail.
> >
> > > There looks to be another bug in the above:
> > > doing bpf_get_current_task_btf from raw_tracepoint/sched_process_free
> > > will return task_struct of the worker thread.
> > > I don't think it's the one you want.
> > That's not what I observed - this is the output of bpf_trace_printk whe=
re the execution of the LSM hook got interrupted mid-execution:
> > ----
> >  chrony-onofflin-12460   [000] d.s.1  2258.804195: bpf_trace_printk: EX=
ECUTION HIJACK(b=3D2257261931167) # this is from tp/sched_process_free
> >  chrony-onofflin-12460   [000] d...1  2258.804234: bpf_trace_printk: a=
=3D2257261896666. c=3D2257261971220 # from the lsm hook
>
> It's "working" by accident.
