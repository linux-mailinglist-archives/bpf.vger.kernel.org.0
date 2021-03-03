Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 033A732C1CC
	for <lists+bpf@lfdr.de>; Thu,  4 Mar 2021 01:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449638AbhCCWw7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Mar 2021 17:52:59 -0500
Received: from mail-qv1-f52.google.com ([209.85.219.52]:40397 "EHLO
        mail-qv1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386462AbhCCSPn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Mar 2021 13:15:43 -0500
Received: by mail-qv1-f52.google.com with SMTP id x13so6230620qvj.7
        for <bpf@vger.kernel.org>; Wed, 03 Mar 2021 10:15:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XVI0NGqfR5lyDqvEF13m6jGa+LE885aN8fbIxk0px7w=;
        b=BixcPMJrrk8yTSMsEL75fZzHhKtfmQROoqn4etNp6EzAh2H/50oieQbxCosl/xNN0V
         Rn0LldHubCiO93LYYlKRvKMFLVneKly281ih44aISruQ8H77FkeqNly7SC+DNtkOKhaR
         jfAA2o37henkRfo7W36WLD3+nVvwM2kJsLpzep4O0+GBBKiOKo8pzFPj7tPNhQORjTIT
         gEoyufCO7suA2QiLziiA/Z4ojCnVjd9TINKfDnh5WUqIki3nnnUcCBIKPN0iiQ8HNZuq
         CQDVhz0vzid5aclYbFkQdjY25bAhLsg8T0w7AsOCn0UvRtaYFpZUWIftvKzhd4W9n7wq
         m5DQ==
X-Gm-Message-State: AOAM533rQL8iWZ1dlCGHJV+M08I9mfQAtyhs12vwcjCXokVWUQ4MfUrh
        hDHoVJ0a2VJTY9B6/Z4OWO+i5vuhNX+ayoc=
X-Google-Smtp-Source: ABdhPJwgUh9PEvA9yn5sygKMruwkMx9Kyk8Ln8wm/hS4d2Of2RIMaU1vb88dhOi+Gg6iyUbrqEQTeg==
X-Received: by 2002:a05:6214:18e5:: with SMTP id ep5mr453362qvb.32.1614795301301;
        Wed, 03 Mar 2021 10:15:01 -0800 (PST)
Received: from fujitsu.celeiro.cu ([191.96.15.91])
        by smtp.gmail.com with ESMTPSA id z188sm14458424qke.85.2021.03.03.10.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 10:15:00 -0800 (PST)
From:   Rafael David Tinoco <rafaeldtinoco@ubuntu.com>
To:     vamsi@araalinetworks.com
Cc:     andrii.nakryiko@gmail.com, rafaeldtinoco@gmail.com,
        bpf@vger.kernel.org
Subject: Re: [BPF CO-RE clarification] Use CO-RE on older kernel versions.
Date:   Wed,  3 Mar 2021 15:14:57 -0300
Message-Id: <20210303181457.172434-1-rafaeldtinoco@ubuntu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <CADmGQ+0dDjfs6UL63m3vLAfu+GHgSFdMO+Rmz_jk+0R9Wva2Tw@mail.gmail.com>
References: <CADmGQ+0dDjfs6UL63m3vLAfu+GHgSFdMO+Rmz_jk+0R9Wva2Tw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> > From:   Vamsi Kodavanty <vamsi@araalinetworks.com>
> > Date:   Thu, 7 Jan 2021 17:31:11 -0800
> > To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > Cc:     bpf <bpf@vger.kernel.org>
> >
> >
> > Right. Libbpf only supports a newer and safer way to attach to
> > kprobes. For your experiments, try to stick to tracepoints and you'll
> > have a better time.
> >
> > But it's another thing I've been meaning to add to libbpf for
> > supporting older kernels. I even have code written to do legacy kprobe
> > attachment, just need to find time to send a patch to add it as a
> > fallback for kernels that don't support new kprobe interface.

Initially I'd like to thank you *a lot* for this thread, it helped me
creating:

https://github.com/rafaeldtinoco/portablebpf

showing up exactly what was discussed here AND I could run the same
binary in v4.15 and v.5.8 kernels as long as BTF was generated with:

https://github.com/rafaeldtinoco/portablebpf/blob/master/patches/link-vmlinux.sh.patch

Specially the attach_kprobe_legacy() function:

https://github.com/rafaeldtinoco/portablebpf/blob/master/mine.c#L31

I wanted to reply here in case others also face this.

Only bad thing was kernel v4.15 missed global data support as showed in:

https://github.com/iovisor/bcc/blob/master/docs/kernel-versions.md

But using perf event was good enough for an example.

- rafaeldtinoco
