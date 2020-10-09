Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 435C8289143
	for <lists+bpf@lfdr.de>; Fri,  9 Oct 2020 20:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732362AbgJISiS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Oct 2020 14:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729285AbgJIShj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Oct 2020 14:37:39 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D823C0613D2
        for <bpf@vger.kernel.org>; Fri,  9 Oct 2020 11:37:39 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 184so11703314lfd.6
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2020 11:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=JEAJS2w+4KuBNp3zCUiqRhXzeXnyyIkU5Lrtk2hhL8s=;
        b=rAN4+pUDguYwVGD0xde+OgKdmSRkmO/htBp+qFlVZW3Nn0auvMpveHDuc1coD8cF5f
         trVkM6ScSiDXxVNbe3QXOhS/BSrMMNtdk9k9FJjrJPo9HqwiTOClnWKZU/AvI/RthBkX
         6lEXIquaQex/+pidvo9m4AVQzmdtIpwKW/qpM1S3kMQFzl1y1Sq98pHnZvourdJvgsAJ
         WLBLSCkWdjYA5lZxE9Nx8hDON3eza+ifYvPnpQAhDpoSSOAVOrUKeaGdkBNwjolkzJUr
         lzwprZu6Zsax/f+YNUbWyJ1QRdtT3TyfdSSvTzn46mW1BoTwSqhlfvxM/RmblDFNv3W2
         nTGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=JEAJS2w+4KuBNp3zCUiqRhXzeXnyyIkU5Lrtk2hhL8s=;
        b=PPd3vMrpPD04GZzdn/B94EsexKWHwtg8uCjKD2xDPFHHP4+fKpW1CpkiV1LXa29MMe
         rZIUM/foIrCuhMWWFN1P86pX67z3x7oug/5R5OSUCUjLVaB1NPCt7r5kF5WuurGZH4x3
         8nthoTesAAHIMh7GKQjri1Qx5lXBy9hcv54jkDOaG+hoIoM4PhB6ehAT4ojcL5Vp+FvU
         QAgpn+UtWo1ifM8f85+OIQCcay2/7rmhNbeY3XmWZXjKXWG3DYZEo3+sGyNLgA3M+K0P
         nKqPyAhXzHe/k783JBtt8aDqCPdFBMOepp2HQFhmMfsObCH7GQ2I1r1vFGeQ9FcO6SPy
         4ZTw==
X-Gm-Message-State: AOAM532QN4i9R5bvtaFQl1kxgx+CUm+nUCtGHbPcEPKVDOPx5cIyprsc
        vm1UAGVYmFxjwnCjT1gVsIAb+rt9gn/JTEtQAEgF9JP26OHVLIBa
X-Google-Smtp-Source: ABdhPJxefqCebjxbBMPNf9zSpnn3mzdoiZs3jvGjP1wg2kyyrvaFSsQE3k5FQIdNPqvh7AVQr6Iy3f9PaGcTllzp9OY=
X-Received: by 2002:a05:6512:31d2:: with SMTP id j18mr5079204lfe.316.1602268657337;
 Fri, 09 Oct 2020 11:37:37 -0700 (PDT)
MIME-Version: 1.0
From:   Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>
Date:   Fri, 9 Oct 2020 20:40:01 +0200
Message-ID: <CAOjtDRXzkwG84UCUVw0J_WmRt585OhOSjuWbdenYFNFinsSG0Q@mail.gmail.com>
Subject: Running JITed and interpreted programs simultaneously
To:     bpf <bpf@vger.kernel.org>
Cc:     Luka Perkov <luka.perkov@sartura.hr>,
        David Marcinkovic <david.marcinkovic@sartura.hr>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

It would be great to hear if anyone has any thoughts on running a set
of BPF programs JITed while other programs are run by the interpreter.

Something like that would be useful on 32-bit architectures, as the
JIT compiler there doesn't support some instructions, primarily
instructions that work with 64-bit data. As far as I can tell, it is
unlikely that support will be coming soon as it is a general issue for
all 32-bit architectures. Atomic operations like BPF_XADD look
especially problematic regarding support on 32 bit platforms. From
what I managed to see such a conclusion appeared in a few patches
where support for 32-bit JITs was added, for example [0].
That results in some programs being runnable with BPF JIT enabled, and
some failing during load time, but running successfully without JIT on
32-bit platforms.

The only way to run some programs with JIT and some without, that
seems possible right now, is to manually change
/proc/sys/net/core/bpf_jit_enable every time a program is loaded.
Although I've managed to do that and it seems to be working, it seems
pretty hacky and looks like it could cause race conditions if multiple
programs were loaded, especially by independent loaders.

At first glance it seems that if something like this was to be added
to a loader, it would have to either somehow be aware of other BPF
programs being loaded or possibly implement some sort of locking
mechanism which also seems hacky. From what I understand, doing it in
the kernel looks even less promising as bpf_jit_enable is a system
wide setting, and I imagine that changing it to work on a per program
basis would pretty much require a rework of the current design, so
that looks even less promising.

It looks like the best option right now is to just run everything in
interpreted mode, but I want to make sure that I am not missing
something. If someone has tried doing something similar, it would be
great to know about that.

Thanks,
Juraj Vijtiuk

[0] https://lore.kernel.org/netdev/20200305050207.4159-3-luke.r.nels@gmail.com/
