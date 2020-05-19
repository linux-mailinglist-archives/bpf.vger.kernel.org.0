Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB96C1D8C37
	for <lists+bpf@lfdr.de>; Tue, 19 May 2020 02:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbgESAXr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 May 2020 20:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbgESAXr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 May 2020 20:23:47 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60FCC05BD0A
        for <bpf@vger.kernel.org>; Mon, 18 May 2020 17:23:46 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id x13so5708152qvr.2
        for <bpf@vger.kernel.org>; Mon, 18 May 2020 17:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=03vz/QmLPl+3emHsTpacwHCbrkenq9mwN0pkheC/Cek=;
        b=Z0ikE8knGIwFcne1woOR5S0ole1CrlR3Yb1mYm4J7Mhw5EPQa/F/KuFtp/4xLQWkoY
         Y4XjA8S0R7R1fiV72kSho4xUOWTaX+zgU8I4ceXOyKxrIIIfmThN2VHOb877R1bnmt++
         nGGvRw6zHwmFOsy0P6L9+CXrzBItbJt3ZD9KjzdIII5oQFnPYBM6bQAqLDabzZ566jRq
         McVuL2IBEo5gxBz4pPdNh9c8mGEGRvX0IuVEm0hKuxFjx41V8VS6Qg782G2ysfencPz6
         NyNeilOG2171m23Lg+XlXa5PiV8DTzvQWOLfHqqzQZtvNyZOqE5PWLkMoJ69LBUQrrl2
         FaNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=03vz/QmLPl+3emHsTpacwHCbrkenq9mwN0pkheC/Cek=;
        b=IeU7jbnwdl+QLmnRCT6i9NVpn+adMYVSzFAWCqrCkYJRbJEZo8BN4ZS9XmVbHA8wH+
         KK+HkCoLGhQJZwYcZbD5RiL5vUe5293PQqM/ePg5d8Hjqq075+xMQSmBUfL/CuZ2s1dP
         OH/hgN2yfzh4FPWe6+i+GkmGUSLu4W3hzRowsoaGD0WN1ChnJzLO10whkeMnd6htKJrl
         fHOpMQRaTe6xYgJj/b2dLSSXtETkhlCyyU3A3m1oh2SpHvI6Gs6Aayu2CynZfzYAhzW/
         FADk0iDYE2WvL9FbZ/Lew07hMpEQkkOpeWV73DJr+viLad1X1hKASD9XfvUcahscNtjs
         /XKg==
X-Gm-Message-State: AOAM532JIXYGbqz3WnGppWeQZh69NToPryn775Kz2CMyufyy5zrpdckv
        bFhz6SzXalSk+QJUV5Lt80ebgbpTyS6ysR9PrJg=
X-Google-Smtp-Source: ABdhPJxydcHusDxOLEznP1gKkjwjbbtDICnP1MV8sgZyPvVGSMx2Mnmi7WKN7M+6eRnsdA+gLAUV3fVraqHA70svRc0=
X-Received: by 2002:ad4:55ea:: with SMTP id bu10mr19413000qvb.163.1589847825937;
 Mon, 18 May 2020 17:23:45 -0700 (PDT)
MIME-Version: 1.0
References: <uoP8.1589216772739724336.Sdgx@lists.iovisor.org>
 <CAEf4Bzb8uc_L5MRgeNf=6p3TNdPWNnmLV0CYtYx=mXnaZYXR6Q@mail.gmail.com> <CAGgYrAjstp+=eJAwpA4jVQY-9Z-SmySUpim08gEqOv94cfhoUQ@mail.gmail.com>
In-Reply-To: <CAGgYrAjstp+=eJAwpA4jVQY-9Z-SmySUpim08gEqOv94cfhoUQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 18 May 2020 17:23:35 -0700
Message-ID: <CAEf4BzYxPMudnTA=ckB1rLSobBjpYZLJ=hKsDgUn8-hRrx6xZA@mail.gmail.com>
Subject: Re: [iovisor-dev] Building BPF programs and kernel persistence
To:     Tristan Mayfield <mayfieldtristan@gmail.com>
Cc:     iovisor-dev@lists.iovisor.org, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, May 18, 2020 at 9:23 AM Tristan Mayfield
<mayfieldtristan@gmail.com> wrote:
>
> Thanks for the reply Andrii.
>
> Managed to get a build working outside of the kernel tree for BPF programs.
> The two major things that I learned were that first, the order in which files are
> included in the build command is more important than I previously thought.
> The second thing was learning how clang deals with asm differently than gcc.
> I had to use samples/bpf/asm_goto_workaround.h to fix those errors.
> The meat of the makefile is as follows:
>
> CLANGINC := /usr/lib/llvm-10/lib/clang/10.0.0/include
> INC_FLAGS := -nostdinc -isystem $(CLANGINC)
> EXTRA_FLAGS := -O3 -emit-llvm

BTW, everyone seems to be using -O2 for compiling BPF programs. Not
sure how well-supported -O3 will be.

[...]

>
> I suspect that these warnings come from my aggressive warning flags during
> compilation rather than from actual issues in the kernel.
>
>> Right, pinning map or program doesn't ensure that program is still
>> attached to whatever BPF hook you attached to it. As you mentioned,
>> XDP, tc, cgroup-bpf programs are persistent. We are actually moving
>> towards the model of auto-detachment for those as well. See recent
>> activity around bpf_link. The solution with bpf_link to make such
>> attachments persistent is through pinning **link** itself, not program
>> or map. bpf_link is relatively recent addition, so on older kernels
>> you'd have to make sure you still have some process around that would
>> keep BPF attachment FD around.
>
>
> I have been looking at the commits surrounding the pinning of bpf_link. It looks like it's only
> working in kernel 5.7? I did actually go through and attempt to attach links for kprobes,
> tracepoints, and raw_tracepoints in kernel 5.4 but, as you suggested, it seems unsupported.
> I have yet to try on kernel 5.5-5.7 so I'll take a look this week or next.
>
> As I mentioned before, with basic functionality in place here, I'm interested in working on
> some sort of BPF tutorial similar to the XDP tutorial (https://github.com/xdp-project/xdp-tutorial)
> with perhaps a more in-depth look at the technology included as well.
>
> I'm still fuzzy on the relationship between bpf(2) and perf(1). Would it be correct to say that for
> tracepoints, kprobes, and uprobes BPF leverages perf "under the hood" while for XDP and tc,
> this is more like classic BPF in that it's implementation doesn't involve perf?

"classic BPF" is entirely different thing, don't use that term in this
context, it will just confuse people.

perf is used as a means to trigger BPF program execution for
tracepoint and kprobes. It is, essentially, a BPF hook provider, if
you will. For XDP, BPF hook is provided by networking layer and
drivers. For cgroup BPF programs, hooks are "provided", in a sense, by
cgroup subsystem. So perf is just one of many ways to specify where
and when BPF program is going to be executed, and with what context.

> If that's the case then is the bpf_link object the tool to bridge BPF and perf? I noticed that when
> checking for pinned BPF programs with bpftool in kernel 5.4 that unless a kprobe, tracepoint,
> or uprobe is listed in "bpftool perf list", the program doesn't seem to be running. Is the use of
> perf to load BPF programs potentially a way to make them "headless" instead of pinning the bpf_link objects?

no, bpf_link is a way to marry BPF hook with BPF program. It's not
specific to perf or XDP, or whatever. Actually, right now perf-based
BPF hooks (kprobe, tracepoint) actually do not create a bpf_link under
cover, so you won't be able to pin them.


>
> Regardless, I'm excited to have a more reliable build system than I have in the past. I think I'll start looking more into CO-RE and libbpf on kernels 5.5-5.7.
>

Awesome, have fun!

> Hope everyone is staying healthy out there,
> Tristan
>
