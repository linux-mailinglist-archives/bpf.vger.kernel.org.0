Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0F7172494
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2020 18:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729730AbgB0RH5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Feb 2020 12:07:57 -0500
Received: from mail-yw1-f43.google.com ([209.85.161.43]:36874 "EHLO
        mail-yw1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729274AbgB0RH5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Feb 2020 12:07:57 -0500
Received: by mail-yw1-f43.google.com with SMTP id l5so257864ywd.4
        for <bpf@vger.kernel.org>; Thu, 27 Feb 2020 09:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=of3L5sjGHRnOZtN7ffQJFUycpOJRz8nWOIfMGkRHY+0=;
        b=So0WLV3mubJ5HbnQZxVDO5CDjqMNJwBe7VhBf1TeVbfVd8NVjT2gPF0rOZCI762ieU
         5I5N3xSTo0/EDumMnz8SdWa6j5RLhTZei2mG2aBlcHaugISzbDr5TpmgM0jap2I5ppcS
         VWvAFOXwwv4/Hu2rcX2535uyg6SBIYyLYQTmQLKLp7addroYkkEdtq1cEGd/C5yuDtAC
         0DnEnj0oXXiSJ8GgPbo+2gjAf5XZdRCtI/T9JpsHIsYafF0nEf4PvRzP+X0A05g/7Omj
         u3VnDRA5L1VqRvmQaln4Mkj7eu0swZfQFgUkAu1i4iVbq5h/bzu2wO4u+PDbVE1ia8Hf
         mGEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=of3L5sjGHRnOZtN7ffQJFUycpOJRz8nWOIfMGkRHY+0=;
        b=Tnz17DANj+EPKwpmanxib70FpykNkkCGlrivz7YVhGpAR/K4SdeBW1P2utVPEPnZLM
         wLxVsffV6Z9TJrmofl07FtsY6DpVvgqAtHS4HzaUovaVbb3BcBTnP9nTwVfmgy1F2Owv
         Q8rDeP3SpvPauPmuK3otdPYL1fPcDNBXGNItTNY48+BFZEs9sONTtQUJ6BfJTsOGmJCl
         04F6lqJZzAVB+uETp9oeJKjCWMaOf22uVpcjJS7T7tfzrnqymmNKkVFIT1163G7I5rZ9
         6rqzkpxPElXLfuROMxHrc6y4B+ketsyenpVas0wIgD9g7XyHna0PkQWSaE+3sBbH/NCB
         ndYA==
X-Gm-Message-State: APjAAAXchaes7kCLUn00pyavpKjmsU4AKdD6NRW3JyXIGRibyImTPnAs
        GZN0N1nEIDdJG/gou5s26XkI/bYVZygBHkr5H+IbAmKV
X-Google-Smtp-Source: APXvYqz2bHNJ1sg4FkptAQ2t/GE3FlZ7oFFCJXr/tMShdBjbwmsUHh/+/RQQ3iW2kQJwoN01AGpM/L129OVR+y3cwbM=
X-Received: by 2002:a25:b8cc:: with SMTP id g12mr707763ybm.485.1582823276097;
 Thu, 27 Feb 2020 09:07:56 -0800 (PST)
MIME-Version: 1.0
From:   Bogdan Harjoc <harjoc@gmail.com>
Date:   Thu, 27 Feb 2020 19:07:30 +0200
Message-ID: <CAF4+tmr3gfjj+k5L-7BNSrVZEdgPH=KAvCpi57XxDCS2z2Vm0w@mail.gmail.com>
Subject: Alignment check in tnum_is_aligned()
To:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

bpf programs that call lock_xadd() on pointers obtained from bpf
helpers fail to load because tnum_is_aligned() returns false during
bpf validation. Should tnum_is_aligned() evaluate a.value & a.mask
instead of a.value | a.mask ?

An example bpf tracing snippet that fails validation is:

    struct task_struct *t = (struct task_struct *)bpf_get_current_task();
    lock_xadd(&t->usage.refs.counter, 1);

I noticed using a kprobe (listed below) that tnum_is_aligned()
receives value=0, mask=0xffffffffffffffff and returns 0 for the
lock_xadd() call above.

=====
b = BPF(text=R"""
#include <uapi/linux/ptrace.h>
int in_tnum_is_aligned(struct pt_regs *regs) {
    bpf_trace_printk("in value=%llx mask=%llx\n", regs->di, regs->si);
    return 0;
}
int out_tnum_is_aligned(struct pt_regs *regs) {
    bpf_trace_printk("out aligned=%llx\n", regs->ax);
    return 0;
}
""")

b.attach_kprobe(event="tnum_is_aligned", fn_name="in_fn")
b.attach_kretprobe(event="tnum_is_aligned", fn_name="out_fn")
b.trace_print(fmt="{1} {5}")
=====

Cheers!
