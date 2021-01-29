Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E89B3082AB
	for <lists+bpf@lfdr.de>; Fri, 29 Jan 2021 01:49:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbhA2Ask (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Jan 2021 19:48:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:39154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231186AbhA2Aqf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Jan 2021 19:46:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5720264E03
        for <bpf@vger.kernel.org>; Fri, 29 Jan 2021 00:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611881154;
        bh=kMJDVAcAiv2npynGzgjQ5Q1GhRev+kg5DVv60WPxNXU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lPB6NdgvLvt5XzHLtW8u8s6aowLhsNbYk68aXwpdpYWofiCKfYQmDFqFFpg7J1DMr
         tQ+MRaYJsGs1bemV6LXp0EiLahcqpnhp/3WHMJKqONeA3IRwZplD7NSQ8gjOmIlmdT
         fmt5YvjFHFeMZCb+Jm3DIN1vDf6QhlRRpD/xQNIHBI8mqAApUaFf4P5H+DG9FezV0U
         tYlBPjkBOYl0+DvLMaL7eby2FUSbuQxGmAJkfzLDthDRbIJGmYhHpRAJHARaXvU2kA
         e8PAQUDY5w58TQBNRNhA9tnWI8vAiApr8/nvB8YctgJ80rZXrPAyyy5Rmz43FS0FMq
         8ejfl4eA9TIEA==
Received: by mail-ed1-f43.google.com with SMTP id j13so8749853edp.2
        for <bpf@vger.kernel.org>; Thu, 28 Jan 2021 16:45:54 -0800 (PST)
X-Gm-Message-State: AOAM530XgSMIb0KcauIm/EPLYXwSnqMXiYLKagQnjNZky0L8HvDNylMa
        BsTmE9HpZ4vcUeXPvRCUTadP7b8ivexnyxp1hjGaQQ==
X-Google-Smtp-Source: ABdhPJx05PMq0Zfq+uFts/0UCpIqOa8QMrkAe65aWBHwe6pJkRINwKrX6QMdVtV4q71W6ZDfmzPZX/qTkMlX6oGw2kY=
X-Received: by 2002:aa7:c60a:: with SMTP id h10mr2431739edq.263.1611881152817;
 Thu, 28 Jan 2021 16:45:52 -0800 (PST)
MIME-Version: 1.0
References: <20210126001219.845816-1-yhs@fb.com> <CALCETrX157htkCF81zb+5BBo9C_V39YNdt7yXRcFGGw_SRs02Q@mail.gmail.com>
 <92a66173-6512-f1bc-0f9a-530c6c9a1ef0@fb.com> <CALCETrVZRiG+qQFrf_7NaCZ9o9f2-aUTgLNJgCzBfsswpG7kTA@mail.gmail.com>
 <20210129001130.3mayw2e44achrnbt@ast-mbp.dhcp.thefacebook.com>
 <CALCETrVXdbXUMA_CJj1knMNxsHR2ao67apwk_BTTMPaQGxusag@mail.gmail.com>
 <20210129002642.iqlbssmp267zv7f2@ast-mbp.dhcp.thefacebook.com>
 <CALCETrUQuf6FX9EmuZur7vRwbeZBmoKeSYb9Rvx2ETp76SukOg@mail.gmail.com> <20210129004131.wzwnvdwjlio4traw@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20210129004131.wzwnvdwjlio4traw@ast-mbp.dhcp.thefacebook.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 28 Jan 2021 16:45:41 -0800
X-Gmail-Original-Message-ID: <CALCETrXdmdG2o20VY16vBMJ0p5nSuKOv7sTQtboKFDfuQr1nZA@mail.gmail.com>
Message-ID: <CALCETrXdmdG2o20VY16vBMJ0p5nSuKOv7sTQtboKFDfuQr1nZA@mail.gmail.com>
Subject: Re: [PATCH bpf] x86/bpf: handle bpf-program-triggered exceptions properly
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andy Lutomirski <luto@kernel.org>, Yonghong Song <yhs@fb.com>,
        Jann Horn <jannh@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        Martin KaFai Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        kernel-team <kernel-team@fb.com>, X86 ML <x86@kernel.org>,
        KP Singh <kpsingh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 28, 2021 at 4:41 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Jan 28, 2021 at 04:29:51PM -0800, Andy Lutomirski wrote:
> > BPF generated a NULL pointer dereference (where NULL is a user
> > pointer) and expected it to recover cleanly. What exactly am I
> > supposed to debug?  IMO the only thing wrong with the x86 code is that
> > it doesn't complain more loudly.  I will fix that, too.
>
> are you saying that NULL is a _user_ pointer?!
> It's NULL. All zeros.
> probe_read_kernel(NULL) was returning EFAULT on it and should continue doing so.

probe_read_kernel() does not exist.  get_kernel_nofault() returns -ERANGE.

And yes, NULL is a user pointer.  I can write you a little Linux
program that maps some real valid data at user address 0.  As I noted
when I first analyzed this bug, because NULL is a user address, bpf is
incorrectly triggering the *user* fault handling code, and that code
is objecting.

I propose the following fix to the x86 code.  I'll send it as a real
patch tomorrow.

https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/commit/?h=x86/fixes&id=f61282777772f375bba7130ae39ccbd7e83878b2

--Andy
