Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82AD6D5954
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2019 03:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729544AbfJNBmd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 13 Oct 2019 21:42:33 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45464 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729444AbfJNBmd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 13 Oct 2019 21:42:33 -0400
Received: by mail-lj1-f195.google.com with SMTP id q64so14915223ljb.12
        for <bpf@vger.kernel.org>; Sun, 13 Oct 2019 18:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nHlyjzln2EXA6Rl4vH3JEUJo8C8cF0ODGqTOCDMVJpc=;
        b=DqVdQrUE1SsHfJHz7TWtg/NlgQIc1OTZOV4k1WybnGXSIzVXlatJ5g4ULB+dTSY4z4
         J+zlOHaKjbROhj/PlZCs068gF/0tGJf8WWj01slFudmYzBxNVEyuf2q2vxyluB+l5OlM
         klBERKRlfMStdywR/2bFIug6khPR8NNRYZWSL9wS59NUGFzszFM4qRflsEMX45LzaJGy
         gK/tb1RHeq1Z8DFzwC4o0wc7LowM3Pil4EGoNWxBz2i58bi8rJRFNCGjegLeZ+Ive4kW
         r08LenA08QlRH5hbRTMejeo4L625L464+U4WQydOUQ1vOm/RoRUgG+tX5kt1trjLRAyv
         MiKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nHlyjzln2EXA6Rl4vH3JEUJo8C8cF0ODGqTOCDMVJpc=;
        b=qSK1+Kvc0ec53rwYHHXSeOUfGZM+h62N6kC2MueO8hR18kqQZPRnDJeX+xddjSklQQ
         fpSzP5iRmePWjvv76KYJjAM+qGU2469ZZJuEGvzZhUxe6UEGdfAXg8QqCIG77L6ZqLEi
         b36vbCw/NKgcUpRG+2Bo9CDZ57jCzSns7JMQZVdmP0/BTve1bqZMTMDl6pQyqckersZp
         QpSC1EGNKeCqfS9EFNWAmxAuCbBWY/wjF16mRIRDWU+iQ/j8xCFkffLfzsMaIY/ar7uz
         nr4FP3vCOxGrD7g5/PTB+qaXMHD5ar9Q1O7r3cBjdR+dtjpm67R/OsAJQZAXmB02pXcT
         t2Bg==
X-Gm-Message-State: APjAAAXY3jtym0WyybA/E11/dVB0K4hR6A9ObDddxTZCCDJ05GbFkiIl
        ruYkB/JsV99TlR0bCQ2Ud6R4fpdACf0a0mR8bdk=
X-Google-Smtp-Source: APXvYqyh+CKJtOdqU6MPSWErugCA//+oH61ao8Y7VCAXoXZ+JxBK/WZeQEHD/91gpT+2UargE6/2NKL8XYd1rSWybDg=
X-Received: by 2002:a2e:b17b:: with SMTP id a27mr16784341ljm.243.1571017351559;
 Sun, 13 Oct 2019 18:42:31 -0700 (PDT)
MIME-Version: 1.0
References: <201910032202.OVnkgkNP%lkp@intel.com> <20191011200059.GA30072@ubuntu-m2-xlarge-x86>
In-Reply-To: <20191011200059.GA30072@ubuntu-m2-xlarge-x86>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sun, 13 Oct 2019 18:42:20 -0700
Message-ID: <CAADnVQJA7otF=us0usjZ9x0pqpX--9UVLZhwZe-+8pVf-PMkpQ@mail.gmail.com>
Subject: Re: [ast:btf_vmlinux 1/7] net/mac80211/./trace.h:253:1: warning:
 redefinition of typedef 'btf_trace_local_only_evt' is a C11 feature
To:     Nathan Chancellor <natechancellor@gmail.com>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andriin@fb.com>
Cc:     kbuild@01.org, Nick Desaulniers <ndesaulniers@google.com>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 11, 2019 at 1:01 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Thu, Oct 03, 2019 at 10:48:31PM +0800, kbuild test robot wrote:
> > CC: kbuild-all@01.org
> > TO: Alexei Starovoitov <ast@kernel.org>
> >
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/ast/bpf.git btf_vmlinux
> > head:   cc9b0a180111f856b93a805fdfc2fb288c41fab2
> > commit: 82b70116b6ba453e1dda06c7126e100d594b8e0a [1/7] bpf: add typecast to help vmlinux BTF generation
> > config: x86_64-rhel-7.6 (attached as .config)
> > compiler: clang version 10.0.0 (git://gitmirror/llvm_project 38ac6bdb83a9bb76c109901960c20d1714339891)
> > reproduce:
> >         git checkout 82b70116b6ba453e1dda06c7126e100d594b8e0a
> >         # save the attached .config to linux build tree
> >         make ARCH=x86_64
> >
> > If you fix the issue, kindly add following tag
> > Reported-by: kbuild test robot <lkp@intel.com>
> >
> > All warnings (new ones prefixed by >>):
> >
> >    In file included from net/mac80211/trace.c:11:
> >    In file included from net/mac80211/./trace.h:2717:
> >    In file included from include/trace/define_trace.h:104:
> >    In file included from include/trace/bpf_probe.h:110:
> > >> net/mac80211/./trace.h:253:1: warning: redefinition of typedef 'btf_trace_local_only_evt' is a C11 feature [-Wtypedef-redefinition]
> >    DEFINE_EVENT(local_only_evt, drv_start,
> >    ^
> >    include/trace/bpf_probe.h:104:2: note: expanded from macro 'DEFINE_EVENT'
> >            __DEFINE_EVENT(template, call, PARAMS(proto), PARAMS(args), 0)
> >            ^
> >    include/trace/bpf_probe.h:77:16: note: expanded from macro '__DEFINE_EVENT'
> >    typedef void (*btf_trace_##template)(void *__data, proto);              \
>
> Hi Alexei,
>
> The 0day team has been running clang builds for us for a little bit and
> this one popped up. It looks like there are certain tracepoints that use
> the same template so clang warns because there are two identical
> typedefs. Is there any way to improve this so we don't get noisey
> builds? This still occurs as of your latest btf_vmlinux branch even
> though this report is from a week ago.

Thanks for headsup. That was indeed a valid bug in my branch.
Interestingly gcc didn't complain.
I knew that 0day bot is testing my development tree, but
I didn't know it's doing it with clang.
And for some reason I didn't receive any reports
about this breakage.
More so I got 'build success' email from 0day for my branch.
Something to improve in the bot, I guess.

If you're curious the fix was:
-typedef void (*btf_trace_##template)(void *__data, proto);             \
+typedef void (*btf_trace_##call)(void *__data, proto);                 \

I forced pushed my btf_vmlinux branch.
Please let me know if you still see this issue.

Thanks!
