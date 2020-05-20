Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3E9F1DC1EA
	for <lists+bpf@lfdr.de>; Thu, 21 May 2020 00:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbgETWNB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 May 2020 18:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbgETWNA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 May 2020 18:13:00 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBAFC061A0E
        for <bpf@vger.kernel.org>; Wed, 20 May 2020 15:13:00 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x2so2262112pfx.7
        for <bpf@vger.kernel.org>; Wed, 20 May 2020 15:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XErmAxfkk3Y+wyR1/r9vGDck/MULwvoNu6L4T+bWwB8=;
        b=p25d0wMMu9Ivnvc9QM5hFo009ybgJCCis3tX2tcF/iyFyGIWyeeNIWpURCAOKOIBgD
         23gplry9xVsZHhMXH2zz798QYbhKQuyWbMREO3ma4kFg1nRqsQ3qpB96ibht2v2XPuFA
         836QctUy9QmyothByWvR2drELutgPQPGRvdY5zZqKfCbOn/pHpLlbU0VekSHBy5hrZRU
         uTo0c+mT2eFQlXKKXIjQuVjosC26E4OMcpeG4yD4/O6GCRlXnkwBHK7letR8xxqLv1vH
         m63Xj5H6D7AiL4GpALWByxLMrk83wGHOYgELse08EHuuTV6vAtOE3E/FNHEAuLcHKkDt
         jESA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XErmAxfkk3Y+wyR1/r9vGDck/MULwvoNu6L4T+bWwB8=;
        b=jQTdMLKjrB7WcqWtF19phJj0oINxhK/pr2S2jafNHJaHSlhiWwCxEQc3n4hMod9FkH
         iXoysy7XxMlfpzri3zUqTtz6DsQE6Hp26wz7etNXa+ScH0CUQx8EZYc+y8gFueE83tUU
         FHSx/MvOzlNEV6/7J5xqblRTd50rkuwo58+RTfAq4Y8piCWF/55XS48+CKycW4gl3Lno
         JMiFIOhyc/1UwyK/EH2V/LNlTglXr9gCVWY6C9IIq1WRVO1Ge7UEwfGd+6ec915+ZkDB
         oTP1MteFnWbdiyAagOUnPtEQf7OSQJdmHnQsgCIZ3Ok/CdXJXXoq22JKd9W3myNdWuY9
         Xu9Q==
X-Gm-Message-State: AOAM531qE62Hx/wnlZO5LhRklQCXJayQeYKcCQ2ia42LeFelB02lhSdF
        FV1UZhI9deWYv7j038R42+4=
X-Google-Smtp-Source: ABdhPJwtKE3/H6cEoLNr7R9vXvdgYq8VWxdeheSKabOuJZHBWvyItRelaxpFaDEPkdO+HsZVL/ozig==
X-Received: by 2002:a63:514:: with SMTP id 20mr5928674pgf.150.1590012780204;
        Wed, 20 May 2020 15:13:00 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:e680])
        by smtp.gmail.com with ESMTPSA id e1sm2792380pjv.54.2020.05.20.15.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 15:12:59 -0700 (PDT)
Date:   Wed, 20 May 2020 15:12:56 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        bpf@vger.kernel.org, daniel@iogearbox.net
Subject: Re: [Ksummit-discuss] [TECH TOPIC] seccomp feature development
Message-ID: <20200520221256.tzqkjpeswv3d6ne2@ast-mbp.dhcp.thefacebook.com>
References: <202005200917.71E6A5B20@keescook>
 <20200520163102.GZ23230@ZenIV.linux.org.uk>
 <202005201104.72FED15776@keescook>
 <CAHk-=wierGOJZhzrj1+R18id-WdfmK=eWT9YfWdCfMvEO+jLLg@mail.gmail.com>
 <202005201151.AFA3C9E@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202005201151.AFA3C9E@keescook>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 20, 2020 at 12:04:04PM -0700, Kees Cook wrote:
> On Wed, May 20, 2020 at 11:27:03AM -0700, Linus Torvalds wrote:
> > Don't make this some kind of abstract conceptual problem thing.
> > Because it's not.
> 
> I have no intention of making this abstract (the requests for expanding
> seccomp coverage have been for only a select class of syscalls, and
> specifically clone3 and openat2) nor more complicated than it needs to be
> (I regularly resist expanding the seccomp BPF dialect into eBPF).

Kees, since you've forked the thread I'm adding bpf mailing list back and
re-iterating my point:
** Nack to cBPF extensions **
How that is relevant?
You're proposing to add copy_from_user() to selected syscalls, like clone3,
and present large __u32 array to cBPF program.
In other words existing fixed sized 'struct seccomp_data' will become
either variable length or jumbo fixed size like one page.
In the fomer case it would mean that cBPF would need to be extended
with variable length logic. Which in turn means it will suffer from
spectre v1 issues.
We've spent a lot of time fixing spectre v1 issues with eBPF. Including
teaching the verifier to recognize speculative patterns inside the programs
so that malicious bpf progs trying to exploit spec v1 will be caught
at load time. There is no other tool (compiler or static analysis) that
can do similar analysis. I suggest that you look into what eBPF
is actually doing instead of trying to reinvent the wheel.
If you go with latter approach of presenting cBPF with giant
'struct seccomp_data + page' that extra page would need to be zeroed out
before invocation of bpf program which will make seccomp even less usable
that it is today. Currently it's slow and unusable in production datacenter.
People suggested for years to adopt eBPF in seccomp to accelerate it,
but, as you confessed, you resisted and sounds like now you want to
implement seccomp specific syscall bitmask?
Which means more kernel code, more bugs, more security issues.
imo that's another reinvented wheel when eBPF can do it already. I don't think
it's a good idea to add kernel code when eBPF-based solution exists and capable
of examining any level of nested args.

> Perhaps the question is "how deeply does seccomp need to inspect?"
> and maybe it does not get to see anything beyond just the "top level"
> struct (i.e. struct clone_args) and all pointers within THAT become
> opaque? That certainly simplifies the design.

clone3's 'struct clone_args' has set_tid pointer as a second level.
I don't think that sticking to first level of pointers for this particular
syscall will make seccomp filtering any more practical.
