Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B28319362B
	for <lists+bpf@lfdr.de>; Thu, 26 Mar 2020 03:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbgCZCut (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Mar 2020 22:50:49 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:35929 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727576AbgCZCut (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Mar 2020 22:50:49 -0400
Received: by mail-ua1-f66.google.com with SMTP id o15so1609362ual.3
        for <bpf@vger.kernel.org>; Wed, 25 Mar 2020 19:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6pj4LIb4BI2+M547X/060pj9bTLHeqBSCEy3f1N+Yfs=;
        b=LlCJyMRPQeqqckswf09OQSZLRmidq0OGbmTtz0Ygvx4grlMaB8oxDazknHQkOwbKC9
         O5Dx7fbNsXQ7j5T2NPIaPWEb5Gz7PdV4u30BbDbHBiiBEprgpVAZEtPU+MHI6ZU6CGf2
         RI3x1fM8GYjZfVDXwNZNOynLgqIBiMF+1tDVPhdU0yqLHI9juSWX8Y10S0OwfFB/inz0
         LnZsY6IIEXBILHCkO7/CLsCLh5tp2CaDGXFJy/1ZF923lePISmouCkRC0J34PyvkXClk
         YQsN9cX47lGeBivnbJxq5ZIkBcjRbWYYej5DMxb8S+A6W4jTst6p7XHIE/hCAeDjx1go
         CQfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6pj4LIb4BI2+M547X/060pj9bTLHeqBSCEy3f1N+Yfs=;
        b=laDyz7VWi/fUszcGSy09I4WMLksz7LxqE3tMjDDYR7fJ91BHq+sHg3rqeTwclE0TN4
         yFDwBp2KlWYzMDtPfiNs4FlCStAzKQLeLSAL1nmMdvw+inmbpJM/xfox7ED39625QBFT
         v0iUfSBUWDq9UeQSRL8Y+6BU3qHCgwaS9wHq42WN2OXQodqcvDfqr/wFkvBnOQO71dKz
         4rUMaCdG58oFXGg6+IIwC3dOylOVcTK9SgCZfYlccXcuO4gZEPLRluk/UW3bT4+l3Ivh
         RHH4Aupl4iE2+xZl+GLQC5ug2FHG0vg2zBQVjwikrqBFXGfshR+uOOfxLnN+XPZKqD9R
         3L9w==
X-Gm-Message-State: ANhLgQ1RPY9V9nDBZD0+0EuwyCLLSgd6oicR0KlYGrVhBLcRA3xsOdfU
        HSEcfSKiT30heXhKOsvfJ2GWTBoyzrGQaK5AmJU=
X-Google-Smtp-Source: ADFU+vt/dLBwAK0d/b6Z1K0KLIluIjAb50oQCJiyjuWsKXkw1B8cexdtUBk7SzaYm9Q6kOVypL7I2XkftQ5n1eR+Uxc=
X-Received: by 2002:ab0:596d:: with SMTP id o42mr4933689uad.69.1585191046680;
 Wed, 25 Mar 2020 19:50:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAGyo_hqRCs6hp7w6zWEf5RzEZF6zyXj_Bb_AgXVKgab7tg06NQ@mail.gmail.com>
 <CAEf4BzbN0rdiLvSe3_669FMKcV99RXrnKAKDtr8GnRP+4omQsw@mail.gmail.com>
In-Reply-To: <CAEf4BzbN0rdiLvSe3_669FMKcV99RXrnKAKDtr8GnRP+4omQsw@mail.gmail.com>
From:   Matt Cover <werekraken@gmail.com>
Date:   Wed, 25 Mar 2020 19:50:35 -0700
Message-ID: <CAGyo_hpM82LmdijTqpTz2DbmjvYi+F17xXHtQQ2QN9a9iJCA7A@mail.gmail.com>
Subject: Re: libbpf/BTF loading issue with fentry/fexit selftests
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 25, 2020 at 6:31 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Mar 25, 2020 at 3:16 PM Matt Cover <werekraken@gmail.com> wrote:
> >
> > I'm looking to explore the bpf trampoline Alexei introduced for
> > tracing progs, but am encountering a libbpf/BTF issue with loading
> > the selftests. Hoping you guys might have a pointer or two.
> >
> > The kernel build used pahole 1.15. All llvm-project components used
> > in compiling the selftests were 10.0.0-rc6.
> >
> > I believe the following confirms that BTF is indeed present in this kernel.
>
> BTF is, but that BTF doesn't have information about FUNCs (only
> FUNC_PROTOs). You need pahole 1.16 for fentry/fexit.

Thanks Andrii! pahole 1.16 fixed things up.

[vagrant@localhost bpf]$ uname -r
5.5.9-1.btf.2.el7.x86_64
[vagrant@localhost bpf]$ ~/bpftool btf dump file
/sys/kernel/btf/vmlinux | grep -i 'fentry\|fexit'
    'BPF_TRAMP_FENTRY' val=0
    'BPF_TRAMP_FEXIT' val=1
    'BPF_TRACE_FENTRY' val=24
    'BPF_TRACE_FEXIT' val=25
    'fentry_progs' type_id=1950
    'fentry_cnt' type_id=18
    'fexit_progs' type_id=1950
    'fexit_cnt' type_id=18
[59594] FUNC 'bpf_fentry_test1' type_id=59593
[59596] FUNC 'bpf_fentry_test2' type_id=59595
[59598] FUNC 'bpf_fentry_test3' type_id=59597
[59600] FUNC 'bpf_fentry_test4' type_id=59599
[59602] FUNC 'bpf_fentry_test5' type_id=59601
[59604] FUNC 'bpf_fentry_test6' type_id=59603
[vagrant@localhost bpf]$ sudo ./test_progs -t fexit_test
#10 fexit_test:OK
Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED

>
> >
> >
> > [vagrant@localhost bpf]$ uname -r
> > 5.5.9-1.btf.el7.x86_64
> > [vagrant@localhost bpf]$ grep CONFIG_DEBUG_INFO_BTF /boot/config-`uname -r`
> > CONFIG_DEBUG_INFO_BTF=y
> > [vagrant@localhost bpf]$ ~/bpftool btf dump file ~/vmlinux-`uname -r`
> > | grep -i fexit
> >     'BPF_TRAMP_FEXIT' val=1
> >     'BPF_TRACE_FEXIT' val=25
> > [vagrant@localhost bpf]$ ~/bpftool btf dump file
> > /sys/kernel/btf/vmlinux | grep -i fexit
> >     'BPF_TRAMP_FEXIT' val=1
> >     'BPF_TRACE_FEXIT' val=25
> >
> >
> > The fexit_test.o file also has BTF information.
> >
> >
> > [vagrant@localhost bpf]$ ~/bpftool btf dump file fexit_test.o | grep FUNC_PROTO
> > [4] FUNC_PROTO '(anon)' ret_type_id=5 vlen=1
> > [7] FUNC_PROTO '(anon)' ret_type_id=5 vlen=1
> > [9] FUNC_PROTO '(anon)' ret_type_id=5 vlen=1
> > [11] FUNC_PROTO '(anon)' ret_type_id=5 vlen=1
> > [13] FUNC_PROTO '(anon)' ret_type_id=5 vlen=1
> > [15] FUNC_PROTO '(anon)' ret_type_id=5 vlen=1
> >
> >
> > However, I get libbpf/BTF load errors when trying to run any
> > fentry/fexit tests.
> >
> >
> > [vagrant@localhost bpf]$ sudo ./test_progs -t fexit_test | grep '^libbpf\|FAIL'
> > libbpf: Error loading BTF: Invalid argument(22)
> > libbpf: magic: 0xeb9f
> > libbpf: Error loading .BTF into kernel: -22.
> > libbpf: Error loading BTF: Invalid argument(22)
> > libbpf: magic: 0xeb9f
> > libbpf: Error loading .BTF into kernel: -22.
> > libbpf: fexit/bpf_fentry_test1 is not found in vmlinux BTF
> > test_fexit_test:FAIL:prog_load fail err -2 errno 22
> > #10 fexit_test:FAIL
> > Summary: 0/0 PASSED, 0 SKIPPED, 1 FAILED
> >
> >
> > I saw in a similar thread that -vvv output was requested. Figured the
> > same applies here.
>
> Yeah, for tricky issues that good. In this case it was pretty obvious,
> but generally it's a good idea for sure, thanks!
> >
> >
> > [vagrant@localhost bpf]$ sudo ./test_progs -vvv -t fexit_test | grep
> > '^libbpf\|FAIL'
>
> [...]
>
> >
> >
> > Any hints on the issue?
> >
> > -Matt C.
