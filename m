Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8607C573C31
	for <lists+bpf@lfdr.de>; Wed, 13 Jul 2022 19:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbiGMRxL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Jul 2022 13:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiGMRxK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Jul 2022 13:53:10 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0452D1C9
        for <bpf@vger.kernel.org>; Wed, 13 Jul 2022 10:53:09 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id os14so21196727ejb.4
        for <bpf@vger.kernel.org>; Wed, 13 Jul 2022 10:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qwKLWzG9XaDAuXDM0o1/jq4t3snTJ7GCEJNDxTCJaKM=;
        b=C3aWm5b+jd384mTDYLGHQyJdjexjoVGn6UuKWw8t/qaAduszkR4KlDEYbHQnvIcX/7
         Wtv7QPzzsSQ/JhFsDsGBkfv3xRXq0sqLogNuXb7eYCqS5AJZXzG016UrO1mDu5RfHCEz
         0tPgL2XhHbNjaV3GbqntE6JD13eflxcyAr8hc8NL0R9odqV4BiiT38Tcogn5IYu8XmtC
         jrGqIeX51FvPxmi3VaueA0jDVD9jS6tiGqwi3e0rcOKPmItzcpbu4zDIXI31y7dPU3/q
         xwAckCBnYxEqF3LFdVMWkuYPykzrWBeJonpH6w+p91G1XqqljcHaLnFiiNqHaP7yPYNL
         v+Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qwKLWzG9XaDAuXDM0o1/jq4t3snTJ7GCEJNDxTCJaKM=;
        b=3YApOIyU0Fo8n4KrG9oF5cag/qMB2T/qmRZwPgJx+X29JaM2djFD1WTGIbThxl5sJN
         Xu89I+CC2rSDz4/FaTcqO5fz/CNK+Hpl1VndyYwBnC42T0lw5RPtbOBPqZ5Q0okM+yfs
         EA9Y0v3ss6N9Bd4uaco4rSrNG6KNySl+TRLFCZ2JrtaJYU6wzaIBT0LrWAe4pKe0SZzR
         bstYLzhMaY5Me/ufk4a+/7ZpI+H5Q1aEhrHJKrVcmIg60wUxYzSAyySimF/hVGeFXWEO
         SCPVnfpttwOK/UOUsGRVltD8rWWIl47YcFH0a+ow+uXWlGZU9PSVvpZFQAPJ/QEhO1Nm
         P2ZQ==
X-Gm-Message-State: AJIora+WUYfVLbo3Mw3AVbSysPfwWJxAg/wnHAQqdUo30z6MYg7/0aIc
        SBmXBktoM/PCjMgB72XcYwARQAHOAY0uU/PtSrk=
X-Google-Smtp-Source: AGRyM1vwq48iMN+vfecEReMFbjACvnvukpeXpYi0qkfg9z2eQXuELA+lpZWynvahG9wDfxtZctml76/kuA5/oyAwfd8=
X-Received: by 2002:a17:907:6e05:b0:72a:a141:962 with SMTP id
 sd5-20020a1709076e0500b0072aa1410962mr4499062ejc.545.1657734788268; Wed, 13
 Jul 2022 10:53:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220707004118.298323-1-andrii@kernel.org> <50414987fbd393cde6d28ac9877e9f9b1527cb28.camel@linux.ibm.com>
 <CAEf4BzaocVmZrdSg4d5xiTeqK+n5ZNUuMso6BW-2x15Wj3rGmQ@mail.gmail.com>
 <cc50280e54d463d5da703e85770c87ede3f2655d.camel@linux.ibm.com>
 <CAEf4Bzb=oT5PzYjM+aDeAg76yB8KpROWcdanqLZ+G6qtdFsAqA@mail.gmail.com> <eb339ec7-9d7c-b96e-179e-b84751499808@oracle.com>
In-Reply-To: <eb339ec7-9d7c-b96e-179e-b84751499808@oracle.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 13 Jul 2022 10:52:56 -0700
Message-ID: <CAEf4BzYa1EjhzOvcpVLDgCtVo1Ntf3SGSOs2Hkm6amPF5Pg4TQ@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 0/3] libbpf: add better syscall kprobing support
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Kenta Tada <kenta.tada@sony.com>,
        Hengqi Chen <hengqi.chen@gmail.com>
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

On Wed, Jul 13, 2022 at 12:12 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> On 12/07/2022 05:24, Andrii Nakryiko wrote:
>
> > Sounds good! I'll add that to bpf_program__attach_ksyscall() doc
> > comment (and to commit message). I'll implement those new virtual
> > __kconfig variables that I mentioned in another thread and post it as
> > v1, hopefully some time this week.
> >
>
> This is really useful, thanks for doing it! I tested on arm64,
> only issue was the tracefs path issue that I think was already
> mentioned, i.e. for me it took
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 4749fb84e33d..a27f21619cfc 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -4685,7 +4685,7 @@ static int probe_kern_syscall_wrapper(void)
>          * kernel was built with CONFIG_ARCH_HAS_SYSCALL_WRAPPER and uses
>          * syscall wrappers
>          */
> -       static const char *kprobes_file = "/sys/kernel/tracing/available_filter_functions";
> +       static const char *kprobes_file = "/sys/kernel/debug/tracing/available_filter_functions";
>         char func_name[128], syscall_name[128];
>         const char *ksys_pfx;
>         FILE *f;
>
> ...to get the feature probing - and hence auto-attach to the
> right arch-specific probes - to work.
>

So I remember there were some patches generalizing this, but I can't
remember why it hasn't landed yet. I'll dig it up a bit later, but I
think this will be fixed separately and orthogonally. And also the
non-RFC v1 doesn't rely on available_filter_functions anymore anyways.

It would be nice if you can try v1 as well, and if it looks good give
your ack/tested-by. Thanks!

> Alan
