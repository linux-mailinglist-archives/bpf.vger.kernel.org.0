Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE9252FE70
	for <lists+bpf@lfdr.de>; Sat, 21 May 2022 18:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244426AbiEUQxA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 21 May 2022 12:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242650AbiEUQxA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 21 May 2022 12:53:00 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E7E5133B
        for <bpf@vger.kernel.org>; Sat, 21 May 2022 09:52:59 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id z16so1134142ilp.5
        for <bpf@vger.kernel.org>; Sat, 21 May 2022 09:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UUfaOp7aQ4gPM2l71hyON1F1XMOBNEyA8O0QsJaxDlQ=;
        b=ghCOVYzkHhNkCEyEBPBKawmO4Qmb1vD5j0XgKh4CLpobHZwdrvpceg7dzrW7AHiqMO
         TCCUboCoLF+Hd+K97rqvqTxSbSeHXl9jK0XvMzqRO+mIBcdBKvfTYXhZyjdkEFldMMU6
         Wehv7g1Bqho4FjydET7nggA9L9qaLs+P68VfE/U1VDH1Ho1hyTk+LZf4rDb9zljQ6yqL
         UfNXb0dHZIeT1P48xZteQAOqYQ8snf8xkSL5ju8q4IQ70AuGzs1UBk2i7y8JjHy9pZx1
         VRTqZOS7LXdjJ/iAnOJHCgbXEgJaH/Kqzf31+w+Aq0zsxEjS+AtASEdzRBz22XUMdc0m
         rGRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UUfaOp7aQ4gPM2l71hyON1F1XMOBNEyA8O0QsJaxDlQ=;
        b=45xtGeEHDVdq785o6FH7ZY16XZgDEEuaCHxhXLU0+icsJI4Pl7qeE/Cjvwb0jn+TE3
         KdL/WTH/hxyw0vH5WTUezvlOePIEwTHChseDx35/no/9nyr87jVzFk/blcbpTM07092B
         W8qtI96Xg3CtCp1P9sAFv8DeOFT7CEu1QaJYjVcyL9EQzPVA/sD1pGVlJWv5j9F9MZaT
         2GdM7BJ7a9C+E/Fps5IbEZHmV6gaB4lpoljYWS1sr4h5BCjaO5KRLZ/G7p0tUIAY+/S4
         pN7lOGviSIMFRP99ds8oC9swCAB38QjPOCHuJ+2RCnb+balXOhtoIFptSbdL3FfSyB7g
         mAzQ==
X-Gm-Message-State: AOAM531AaBLYKwcGz1XjVAW25AgS920Ul2onHr2a7N2luKO73Lz07qGk
        vpbsvw8ZTM6TO+gWdAp/69Aa7xCWqF1tl1ZU8sA=
X-Google-Smtp-Source: ABdhPJzeEfsBVIhKyrdjTNSWcRyObOpwyviXFHNjg6OobQMaI6CVrq+7rz7IQTTccU8s2wLV48JOUHEU8DScElznoHI=
X-Received: by 2002:a05:6e02:1b8a:b0:2d1:22b1:f78b with SMTP id
 h10-20020a056e021b8a00b002d122b1f78bmr8073772ili.82.1653151978881; Sat, 21
 May 2022 09:52:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAPxVHdL-dT2GQh-HEkNjNoTEzA9DRL4W4ZfmUzc1+Bdz89fftQ@mail.gmail.com>
 <CAEf4BzZg0r4YptYPu8Y_-qp=rY__W6dmb9kLwMV5MAH6C-2PSg@mail.gmail.com>
In-Reply-To: <CAEf4BzZg0r4YptYPu8Y_-qp=rY__W6dmb9kLwMV5MAH6C-2PSg@mail.gmail.com>
From:   John Mazzie <john.p.mazzie@gmail.com>
Date:   Sat, 21 May 2022 11:52:48 -0500
Message-ID: <CAPxVHdJbnu5fk5btxATWM5NTd0NofeJREuX_8R_2i3GX_ho87g@mail.gmail.com>
Subject: Re: Tracing NVMe Driver with BPF missing events
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>,
        "John Mazzie (jmazzie)" <jmazzie@micron.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In this case is a BPF program the individual handler of a tracepoint,
or in my context, a BPF program my compiled program that traces both
tracepoints? We aren't running any other BPF tracing during these
tests besides my program counting these 2 tracepoints.

In my program I have 2 handlers, one for
tracepoint:nvme:nvme_setup_cmd and another for
tracepoint:nvme:nvme_complete_rq. I've created a PERCPU_HASH map for
each handler (unique map for each) to use that keeps track of each
time the handler is invoked. The only thing that handler is doing in
each case is incrementing the count value in the map. Though I do
filter by device on each tracepoint. If I comment out the
nvme_setup_cmd code the nvme_complete_rq does get the correct count.

The user side of my program just prints the values for each of these
maps on a 10 second increment.

I can share my code to make this easier, is it preferred that I upload
my code to github and share the link in this thread?

I agree that your suggestion could be my issue, but I just want to
make sure we're on the same page since I'm less familiar with the
internals of BPF.

Thanks,
John

On Fri, May 20, 2022 at 7:10 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, May 18, 2022 at 2:35 PM John Mazzie <john.p.mazzie@gmail.com> wrote:
> >
> > My group at Micron is using BPF and love the tracing capabilities it
> > provides. We are mainly focused on the storage subsystem and BPF has
> > been really helpful in understanding how the storage subsystem
> > interacts with our drives while running applications.
> >
> > In the process of developing a tool using BPF to trace the nvme
> > driver, we ran into an issue with some missing events. I wanted to
> > check to see if this is possibly a bug/limitation that I'm hitting or
> > if it's expected behavior with heavy tracing. We are trying to trace 2
> > trace points (nvme_setup_cmd and nvme_complete_rq) around 1M times a
> > second.
> > We noticed if we just trace one of the two, we see all the expected
> > events, but if we trace both at the same time, the nvme_complete_rq
>
> kprobe programs have per-CPU reentrancy protection. That is, if some
> BPF kprobe/tracepoint program is running and something happens (e.g.,
> BPF program calls some kernel function that has another BPF program
> attached to it, or preemption happens and another BPF program is
> supposed to run) that would trigger another BPF program, then that
> nested BPF program invocation will be skipped.
>
> This might be what happens in your case.
>
> > misses events. I am using two different percpu_hash maps to count both
> > events. One for setup and another for complete. My expectation was
> > that tracing these events would affect performance, somewhat, but not
> > miss events. Ultimately the tool would be used to trace nvme latencies
> > at the driver level by device and process.
> >
> > My tool was developed using libbpf v0.7, and I've tested on Rocky
> > Linux 8.5 (Kernel 4.18.0), Ubuntu 20.04 (Kernel 5.4) and Fedora 36
> > (Kernel 5.17.6) with the same results.
> >
> > Thanks,
> > John Mazzie
> > Principal Storage Solutions Engineer
> > Micron Technology, Inc.
