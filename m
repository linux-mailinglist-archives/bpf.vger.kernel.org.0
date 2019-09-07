Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33C3FAC49D
	for <lists+bpf@lfdr.de>; Sat,  7 Sep 2019 06:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390466AbfIGEai (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 7 Sep 2019 00:30:38 -0400
Received: from mail-io1-f45.google.com ([209.85.166.45]:39700 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389786AbfIGEai (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 7 Sep 2019 00:30:38 -0400
Received: by mail-io1-f45.google.com with SMTP id d25so17540713iob.6
        for <bpf@vger.kernel.org>; Fri, 06 Sep 2019 21:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=zBFixwfZ8JMpGPH6WMYBXlxC7qno3zHmyGKtGa4hxn8=;
        b=LMPO0SGXdDI22n31uqEqs0ksOl9aPPG6b2rQY7J97YdG9aTxVFiPZmMS8kSsmvA0HC
         HuvjXThm1k5XYvYjjIXitxEb0KIxSinkH0HVg5eWl1Yedfas8l/VnaNd28e6RI8+ocMP
         shMM+WahgEC6CAPKEAVa1dDhBs9YwWxKmbFQM5fONi9HcWQy3YkJKwCg3e/hnlsD2jFv
         mcnA4NSQ4mOSETgFqxny90VflKmjQFyZljuhdkiMY9IirtASLEOxJKddXtOQ15QiJB1p
         qA3mGWp3Lc5Avj/V7OqNtMCmz1UHwf2OJ2fwp63eu9sgW/BeWPsKu0vM8Mli0HmbLlau
         QSvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=zBFixwfZ8JMpGPH6WMYBXlxC7qno3zHmyGKtGa4hxn8=;
        b=CAZJOMRvNPIfoJodAurBusnHklkq3pc4dV2x2QZk6JsQVmkslWnS3/h3iR34g1XCBG
         OL09TZCk7McQHGLSUESMyPVbangY/kUMGdhR4iPy9TeloeUpSuyrC4jDOoOiXSIvPNai
         wITOe3/t389l+tIiqU0MWtzGMYdHCf0AwTIWELa75sWXoWZDvLM3vtQBjyaxS+dbTW3a
         +lgrGdZCeVwuUmTuDwkPOGr52NDIf0Xt2z59Pn98q36MmCY1FGAS+vwk+rDnVh68MMh3
         VleBmpMnQRtVvxZ+OnCduRO/w8yxezJmKJ6UnaZKgvQx415yj7ukycrfL+Wp2kht1fgC
         cxJQ==
X-Gm-Message-State: APjAAAXY+K8Nsy97tNRkhlS2peQSC/d7vNLQJmULbx8sKiuC7C63jjZ5
        pwPmXeIBWkcSTVaVHlCx2YNlRz1kwD9d23zXGSoBLUJq
X-Google-Smtp-Source: APXvYqx++mmvFrMolB43xlqD1Q1gRHfWE3ZdgytLA6o4QhUr/3YuXzDzEIVeKMJIusgDqm89LucBVSDZhKQrW1XD7Cw=
X-Received: by 2002:a05:6638:692:: with SMTP id i18mr13462502jab.108.1567830637122;
 Fri, 06 Sep 2019 21:30:37 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kulkarni@ucla.edu
From:   Gautam Kulkarni <thegautam@gmail.com>
Date:   Fri, 6 Sep 2019 21:30:26 -0700
Message-ID: <CANZ-dUobRee1NrntgZsnvZN7HmbAgszjX4t4bV5-27sR+fVHWA@mail.gmail.com>
Subject: Per cgroup accounting of context switches
To:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

We are evaluating eBPF as a means to account voluntary and
non-voluntary context switches against cgroups. Currently, this
information is only present in the task_struct for an individual
process and not in the cgroup data structure.

With this context, I was looking for recommendation on the following
possible approaches:

1. Use the existing tracepoint (trace_sched_switch) as it exists here
with BPF_PROG_TYPE_TRACEPOINT:
https://github.com/torvalds/linux/blob/master/kernel/sched/core.c#L3877
However, based on the trace format, the kernel does not expose
prev->nivcsw and prev->nvcsw. Due to this, I feel like this approach
may not be feasible. Is my understanding correct?

2. Attach a kprobe to __schedule() and use BPF_PROG_TYPE_KPROBE
This will allow us access to the prev pointer. From the prev
(task_struct), we can access the cgroup and use an eBPF map to
accumulate per cgroup counts of context switches.

3. Implement a kernel module that attaches a kprobe to __schedule()
and implement the map in the kprobe handler.

4. Modify the kernel to have context switch information in task_group.
Would this be something that would make sense to the community?

I would highly appreciate any feedback on this.

Regards,
Gautam
