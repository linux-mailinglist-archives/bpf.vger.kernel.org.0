Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40617131638
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2020 17:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbgAFQkA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Jan 2020 11:40:00 -0500
Received: from mail-ot1-f44.google.com ([209.85.210.44]:38724 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgAFQkA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Jan 2020 11:40:00 -0500
Received: by mail-ot1-f44.google.com with SMTP id d7so67963529otf.5
        for <bpf@vger.kernel.org>; Mon, 06 Jan 2020 08:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=BYX+ysDLixguPL9U7dTnnMHsyuHIKDFw1NJsrezq400=;
        b=HYACJWe7iC1JO54rLjWk/PavmoaeeOJJuzQRDOcsQWfJO67/UJxQhZOj7/OHKg/L8x
         0ysV6fkDOhztER0XKzJ1PwzCjL7zapiZoZqwysTAVMsry+duaYK1I/j8cVw89/qWN1r6
         UKsTgFexVIq0TbVZLxEB3tkuHabjQfhsLR3ofgyqxSs7IUCTmAzkXf6nOd3RPT2IK3L9
         JGZolBaGH0slMOBbYeUGag+MGi9wLIYV0cPaFGRfYnXb89/8N/O6iDI2kvoC3HOJI1Eb
         b2V4RqWKPrfLMpvyjWnsj8D+l+sTzgtEBRw9PsQ0WjFYkjT20hVMrzI9S9bm+pGII2yf
         EvYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=BYX+ysDLixguPL9U7dTnnMHsyuHIKDFw1NJsrezq400=;
        b=tQ0Zd8jkzsOXIRMIhvtM0almEU79Rsikh24ITR6ELlgzmYmVa2QIWYv+R75oujwonC
         xmCVSF56OYoH2YlYKAS1jxMDuCqtGi8W8bTA4aaVt+epzPrwWZ6zo3uWxdjaswLt5zFZ
         6JdnVgC7AXdWPtYAERYzk9bK02sKMuyeqOQCd/zOuAvv4G3/X43gR3Pms4NPFCUBtbfV
         Y9X/aZWfCitWFVAnSnDX8viGVGUw7LxYu7MAZRwQR5brMO1XWcu8kYqXF8GN8Ej2cjtD
         HxJJ5c5xQ29LCNj+ms1gzSG8BSxYOyFVH8PI0xO294HNyUpu0g/p7KTasGG5w1+RmptR
         PCqw==
X-Gm-Message-State: APjAAAVsW2uV0vhLE1srB2LqvNtrAbVuIxXm2W6lP07Qp3NeEiWngAlO
        PgGCSD7Hr7AOYfeKhQgFt5UIAavk8pVHfvAwrckOShs21+4=
X-Google-Smtp-Source: APXvYqyzJZgS9aC7Sd3hjVODNTRsj55lXa5LHChcNvYlVMoVjaqF3LKL0u3oYBiod7r1Yv6oUpSmScmSEqnX9/uI01k=
X-Received: by 2002:a9d:c02:: with SMTP id 2mr119359452otr.183.1578328797486;
 Mon, 06 Jan 2020 08:39:57 -0800 (PST)
MIME-Version: 1.0
From:   Jann Horn <jannh@google.com>
Date:   Mon, 6 Jan 2020 17:39:30 +0100
Message-ID: <CAG48ez2gDDRtKaOcGdKLREd7RGtVzCypXiBMHBguOGSpxQFk3w@mail.gmail.com>
Subject: BPF tracing trampoline synchronization between update/freeing and execution?
To:     bpf@vger.kernel.org, live-patching@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     KP Singh <kpsingh@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        kernel list <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi!

I was chatting with kpsingh about BPF trampolines, and I noticed that
it looks like BPF trampolines (as of current bpf-next/master) seem to
be missing synchronization between trampoline code updates and
trampoline execution. Or maybe I'm missing something?

If I understand correctly, trampolines are executed directly from the
fentry placeholders at the start of arbitrary kernel functions, so
they can run without any locks held. So for example, if task A starts
executing a trampoline on entry to sys_open(), then gets preempted in
the middle of the trampoline, and then task B quickly calls
BPF_RAW_TRACEPOINT_OPEN twice, and then task A continues execution,
task A will end up executing the middle of newly-written machine code,
which can probably end up crashing the kernel somehow?

I think that at least to synchronize trampoline text freeing with
concurrent trampoline execution, it is necessary to do something
similar to what the livepatching code does with klp_check_stack(), and
then either use a callback from the scheduler to periodically re-check
tasks that were in the trampoline or let the trampoline tail-call into
a cleanup helper that is part of normal kernel text. And you'd
probably have to gate BPF trampolines on
CONFIG_HAVE_RELIABLE_STACKTRACE.

[Trampoline *updates* could probably be handled more easily if a
trampoline consisted of an immutable header that increments something
like a percpu refcount followed by a mutable body, but given that that
doesn't solve freeing trampolines, I'm not sure if it'd be worth the
effort. Unless you just never free trampoline memory, but that's
probably not a great idea.]
