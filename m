Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7340510CE2
	for <lists+bpf@lfdr.de>; Wed, 27 Apr 2022 01:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356220AbiDZX6m (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Apr 2022 19:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356224AbiDZX6i (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Apr 2022 19:58:38 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3260513D43;
        Tue, 26 Apr 2022 16:55:28 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id f4so761057iov.2;
        Tue, 26 Apr 2022 16:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qfwjPLjHy0b+oJYbdqU408UT5vznIVKG78yOHQHkEGc=;
        b=RNKx0HULjvM3tKDODOUDRyzTfZI3BekYtYdnI8r/uKPOQGni5wp+LnDXXynTOxk8DK
         OEWgAD31/oNFFZqkJQ1ZwGnoP/jnG+3UvBfuhkHMBRiI/euPg6tAR8Zx36xZEGo6Voi+
         DuLZddf3osnx2XiJeS/C3TLm8/48JOHs5xDZ7SjxyJtwVu2cPGuUpHZ0Jy47PkPT+qIf
         yOfOo6JjbwQYecuAl2MORPj9jGta/n9Nzqgp5pdrQL5FiQUvJ0u47gHvs0HQdEFRTav+
         J5jLJg4srAftX62Mjm7XjNIwALsozhT0GWA2jhtmppZ+HpHVBv8JQK4qr3Qd2nUz0qlx
         WozA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qfwjPLjHy0b+oJYbdqU408UT5vznIVKG78yOHQHkEGc=;
        b=5RpkEQ6xF4lJkBbE07EoIGD/K0TrBZnwb2awYl3VTMt6H6ohpFUAH8/xS2dVXvQY9F
         u6sGF4tACcD6lAPlRDx6YE5ili5777uqeUq/YndokX4nGefNJlvK8Q2lPkn728x14FRe
         aaSn5kA3OlVEINcOKRd43o6SFEzVpiToSmrf/D7uTzQqe11WDbkYRf3UdP8Bkmnzk3Od
         lWY5br8ICosY5q0pq05nhyJkOFdfJGkxWIbiMBXzKKSYkLfpfgwdO6BK4jIq3yYbslG2
         gmx/JN9Xv0fQco21FzoEqX7KSxBB0wyXDzJ0bScrGvEYfF/4ncSnhZkK4y9QWm+1YcHo
         M+zA==
X-Gm-Message-State: AOAM532YI8zVnTFnmomqKXvOtMUygV1bUaVqDkR/21/HMiaAKNv71Ynx
        YvKCPxutPQc0OiWgK+bgwIowCowlmSSLsJ3daRg=
X-Google-Smtp-Source: ABdhPJw4jaZ2UFHjp4+f2LkW1E50CEuPZDtkYFZtYWIlVerHsOnhyyP7yIoJmjSjZMnH33UWPwUcMultjAX9QiMenXs=
X-Received: by 2002:a05:6638:3393:b0:32a:93cd:7e48 with SMTP id
 h19-20020a056638339300b0032a93cd7e48mr11034554jav.93.1651017328145; Tue, 26
 Apr 2022 16:55:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220422150507.222488-1-namhyung@kernel.org> <20220422150507.222488-5-namhyung@kernel.org>
In-Reply-To: <20220422150507.222488-5-namhyung@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 26 Apr 2022 16:55:17 -0700
Message-ID: <CAEf4Bzbdh-wbQQLzoXGGKkqqE=+qz19C4tCq4Ynb-_PXzRYM1w@mail.gmail.com>
Subject: Re: [PATCH 4/4] perf record: Handle argument change in sched_switch
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Song Liu <songliubraving@fb.com>, Hao Luo <haoluo@google.com>,
        bpf <bpf@vger.kernel.org>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Blake Jones <blakejones@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 22, 2022 at 3:49 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Recently sched_switch tracepoint added a new argument for prev_state,
> but it's hard to handle the change in a BPF program.  Instead, we can
> check the function prototype in BTF before loading the program.
>
> Thus I make two copies of the tracepoint handler and select one based
> on the BTF info.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/bpf_off_cpu.c          | 32 +++++++++++++++
>  tools/perf/util/bpf_skel/off_cpu.bpf.c | 55 ++++++++++++++++++++------
>  2 files changed, 76 insertions(+), 11 deletions(-)
>

[...]

>
> +SEC("tp_btf/sched_switch")
> +int on_switch3(u64 *ctx)
> +{
> +       struct task_struct *prev, *next;
> +       int state;
> +
> +       if (!enabled)
> +               return 0;
> +
> +       /*
> +        * TP_PROTO(bool preempt, struct task_struct *prev,
> +        *          struct task_struct *next)
> +        */
> +       prev = (struct task_struct *)ctx[1];
> +       next = (struct task_struct *)ctx[2];


you don't have to have two BPF programs for this, you can use
read-only variable to make this choice.

On BPF side

const volatile bool has_prev_state = false;

...

if (has_prev_state) {
    prev = (struct task_struct *)ctx[2];
    next = (struct task_struct *)ctx[3];
} else {
    prev = (struct task_struct *)ctx[1];
    next = (struct task_struct *)ctx[2];
}


And from user-space side you do your detection and before skeleton is loaded:

skel->rodata->has_prev_state = <whatever you detected>

But I'm still hoping that this prev_state argument can be moved to the
end ([0]) to make all this unnecessary.

  [0] https://lore.kernel.org/lkml/93a20759600c05b6d9e4359a1517c88e06b44834.camel@fb.com/


> +
> +       state = get_task_state(prev);
> +
> +       return on_switch(ctx, prev, next, state);
> +}
> +

[...]
