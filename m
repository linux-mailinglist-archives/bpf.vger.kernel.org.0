Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 127C419BAE0
	for <lists+bpf@lfdr.de>; Thu,  2 Apr 2020 06:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728455AbgDBEEB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Apr 2020 00:04:01 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51823 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbgDBEEB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Apr 2020 00:04:01 -0400
Received: by mail-wm1-f66.google.com with SMTP id z7so1907616wmk.1
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2020 21:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=g3IEtO7ErFuz58cL6xVhJ/guUj+thhCktSq9wBBOYcg=;
        b=C544YK6neiofvM2DHHQ7bhdR83wuKDgdJDiNjeB/akh8kPgWgXDavV9OvJOK2DaHdj
         SzBufrPzb3hwXqziJhKRX6Ngh72wA/0hQgxCqA0XyMWAunPbu8yMLC2V5NmGJyjnS63j
         7ox+BbT20UMB6L3DFoKNK0GgKe6cs/aeARbjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g3IEtO7ErFuz58cL6xVhJ/guUj+thhCktSq9wBBOYcg=;
        b=WLJinFsU5PwXmXoELxf5ZYnpme2rbCG8tvUf7g8oPhNvqF7c+EeHxU6Ooqu8AQgo7t
         C38e/wnSon7fn8UZWSvyKpdLhSxylpUGIk8F946+iA31KOA0fEsYd1ZipG57RMnaN5+l
         lQN5/nTa1MIPg36KCXCHde/IdtaS0r96TymKYS1J3ad/JN1jtUHH58gVssFM2JxSYDsB
         uxNc+qgxBQ2nw+VPuN4wrAmiziO8948Fji/vgsJD5F+CWBxw3/4u5VRmJh4FLX0OMmWr
         wf7iZeionsIA7Gq5WS3O4LrzeiCjhw9gBIkVAg3ezNnv1Et8PamDRhe0t/ZxlAew49gZ
         CK4w==
X-Gm-Message-State: AGi0PuZvjfLr3pSX1aoMIoAaLtHvlSwBVSodwAK0lqMgru7+9MFHHcP2
        aqWwOZVCi4nSfj/i2C/+nsFjdQ==
X-Google-Smtp-Source: APiQypJUVjhN48DEmNElLnc3XuQUiROcjSHi7/4KBh8+WunYlHXwvS5l8MLyVTFYb3bNtLAI65FHfw==
X-Received: by 2002:a1c:a553:: with SMTP id o80mr1207425wme.159.1585800239422;
        Wed, 01 Apr 2020 21:03:59 -0700 (PDT)
Received: from google.com ([2a00:79e0:42:204:8a21:ba0c:bb42:75ec])
        by smtp.gmail.com with ESMTPSA id n124sm5484582wma.11.2020.04.01.21.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 21:03:58 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Thu, 2 Apr 2020 06:03:57 +0200
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     KP Singh <kpsingh@chromium.org>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Thomas Garnier <thgarnie@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Subject: Re: [PATCH bpf-next v9 7/8] bpf: lsm: Add selftests for
 BPF_PROG_TYPE_LSM
Message-ID: <20200402040357.GA217889@google.com>
References: <20200329004356.27286-1-kpsingh@chromium.org>
 <20200329004356.27286-8-kpsingh@chromium.org>
 <CAADnVQKP3mOTUkkzjWM6Qii+v-dCDwV9Ms_-4ptsbdwyDW1MCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQKP3mOTUkkzjWM6Qii+v-dCDwV9Ms_-4ptsbdwyDW1MCA@mail.gmail.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 01-Apr 17:09, Alexei Starovoitov wrote:
> On Sat, Mar 28, 2020 at 5:44 PM KP Singh <kpsingh@chromium.org> wrote:
> > +int BPF_PROG(test_int_hook, struct vm_area_struct *vma,
> > +            unsigned long reqprot, unsigned long prot, int ret)
> > +{
> > +       if (ret != 0)
> > +               return ret;
> > +
> > +       __u32 pid = bpf_get_current_pid_tgid() >> 32;
> > +       int is_heap = 0;
> > +
> > +       is_heap = (vma->vm_start >= vma->vm_mm->start_brk &&
> > +                  vma->vm_end <= vma->vm_mm->brk);
> 
> This test fails for me.

Trying this from bpf/master:

  b9258a2cece4 ("slcan: Don't transmit uninitialized stack data in padding")

also from bpf-next/master:

 1a323ea5356e ("x86: get rid of 'errret' argument to __get_user_xyz() macross")

and I am unable to reproduce the failure (the output when using bpf/master):

 ./test_progs -t test_lsm
#70 test_lsm:OK
Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED

cat /sys/kernel/debug/tracing/trace
# tracer: nop
#
# entries-in-buffer/entries-written: 10/10   #P:4
#
#                              _-----=> irqs-off
#                             / _----=> need-resched
#                            | / _---=> hardirq/softirq
#                            || / _--=> preempt-depth
#                            ||| /     delay
#           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
#              | |       |   ||||       |         |
            true-322   [001] ...2   187.127231: 0: start 7fc7ffccc000 556a623be000
            true-322   [001] ...2   187.127238: 0: end 7fc7ffe8c000 556a623be000
            true-322   [001] ...2   187.128233: 0: start 7fc7ffe82000 556a623be000
            true-322   [001] ...2   187.128237: 0: end 7fc7ffe88000 556a623be000
            true-322   [001] ...2   187.128306: 0: start 556a604f7000 556a623be000
            true-322   [001] ...2   187.128309: 0: end 556a604f9000 556a623be000
            true-322   [001] ...2   187.128372: 0: start 7fc7ffebf000 556a623be000
            true-322   [001] ...2   187.128375: 0: end 7fc7ffec1000 556a623be000
      test_progs-321   [000] ...2   187.129952: 0: start 55dc6e8df000 55dc6e8df000
      test_progs-321   [000] ...2   187.129955: 0: end 55dc6e906000 55dc6e906000

The full run also works for me:

./test_progs

[...]

#70 test_lsm:OK
#71 test_overhead:OK
#72 tp_attach_query:OK

My config is:

  https://gist.githubusercontent.com/sinkap/cb24b955e1b6e6c1dc736054a774fb41/raw/

and the kernel commandline is (on a QEMU VM):

cat /proc/cmdline
console=ttyS0,115200 root=/dev/sda rw nokaslr

Could you share your config and cmdline?

Also, I am wondering if this happens just in the BPF program or also
in the kernel as the other variable I can think of is the compiled
bpf program itself which might be reading a different value thinking
it's vm->vma_start, possible something to do with BTF / CO RE due to a
compiler bug:

Here's the version of clang I am using:

  clang version 10.0.0 (https://github.com/llvm/llvm-project.git 2026d7b80a1a5534b5e263683c85aa95e7593b98)

- KP

> I've added:
>         bpf_printk("start %llx %llx\n", vma->vm_start, vma->vm_mm->start_brk);
>         bpf_printk("end %llx %llx\n", vma->vm_end, vma->vm_mm->brk);
> and see
> cat /sys/kernel/debug/tracing/trace_pipe
>             true-2285  [001] ...2   858.717432: 0: start 7f66470a2000 607000
>             true-2285  [001] ...2   858.717440: 0: end 7f6647443000 607000
>             true-2285  [001] ...2   858.717658: 0: start 7f6647439000 607000
>             true-2285  [001] ...2   858.717659: 0: end 7f664743f000 607000
>             true-2285  [001] ...2   858.717691: 0: start 605000 607000
>             true-2285  [001] ...2   858.717692: 0: end 607000 607000
>             true-2285  [001] ...2   858.717700: 0: start 7f6647666000 607000
>             true-2285  [001] ...2   858.717701: 0: end 7f6647668000 607000
>       test_progs-2283  [000] ...2   858.718030: 0: start 523000 39b9000
>       test_progs-2283  [000] ...2   858.718033: 0: end 39e0000 39e0000
> 
> 523000 is not >= 39b9000.
> 523000 is higher than vm_mm->end_data, but lower than vm_mm->start_brk.
> No idea why this addr is passed into security_file_mprotect().
> The address user space is passing to mprotect() is 0x39c0000 which is correct.
> Could you please help debug?
