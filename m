Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A16F4425C0
	for <lists+bpf@lfdr.de>; Tue,  2 Nov 2021 03:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbhKBC4H (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Nov 2021 22:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbhKBC4H (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Nov 2021 22:56:07 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538EAC061714;
        Mon,  1 Nov 2021 19:53:33 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 75so18891620pga.3;
        Mon, 01 Nov 2021 19:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GW3N9pYi7csnm9MMTiOu12WSVm3tdN6Dpl31hs2hw4A=;
        b=AXIZ3wBU64rkACD+0vKNTxUt6TxNduLO0hVu50R2FcuV2jpnZHYh5KhzCgDlhkjQb5
         dCWW0LNpuJPiyHJuan+rvkFcj/eeB5Z13BkobpM3y7RpacngNDBF/fi2IexnR5GeIYLh
         WOVUVKhLPdu17EUA7icUzifF9rQjxPoVL7lEgwgvlo9HKrxUoW1xv0h+w3R6NbKxJsks
         57WRIx3+EoQzmwvCCuojhXfF18TsIU+zSlJ0Ao/905iV+O+jG5OHXeAJPTLA+23b8shl
         QaZuPeC7LC0FvmoKr2kVlWKE9p/IokkwbVLPzSQYJjD7a6/77aUXLfEwoHp2RZIa9czq
         oHQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GW3N9pYi7csnm9MMTiOu12WSVm3tdN6Dpl31hs2hw4A=;
        b=aG6nivsiN9VxEN62RXkoY+d5PipifUFMIwfcDib+5nEJjUBInA/qsbF93MQz+t/5D1
         MoyOHJbfM6siqset16pet1Drz5569FYM5sVoNgT2fWIOVdlR1waMRXjDfGxg1jsGAogM
         rgrJQzfCutyOprRtvW1mMAlJVu7WJ//UZg4OEcKXt9YgRsyEipv0hktRennEgSuqIw8S
         36k7L0fhsFSmrlFB3PpGrrZa9uYJn4jdUdEp8o3kJj8OEzn0FjqUSBqf7lsgdGJBGJmf
         /+nHTlyHiX3N0dOYUs5bTgVseaUUwQ9fdRPUYohP0yITaiijoBvfIlzkNXCCF4DRCqQj
         1efQ==
X-Gm-Message-State: AOAM532QsmgZz5m0AL8ibagfkITKqCayPHQfeXB4DWBJJ7VnAi9KPScE
        9lzlsOxG5RzLxV008oko1m4qGDkJ0RSRn1BBz88=
X-Google-Smtp-Source: ABdhPJy9xmkkT6qQjK9/KrkPoTc0xJZr32tGXGYORmtsQvzmKy/2olsNsuD3snUtfsz2DJpkHCa2lPoLQFVzn8k11Qg=
X-Received: by 2002:aa7:8b56:0:b0:44c:10a:4ee9 with SMTP id
 i22-20020aa78b56000000b0044c010a4ee9mr33684010pfd.46.1635821611842; Mon, 01
 Nov 2021 19:53:31 -0700 (PDT)
MIME-Version: 1.0
References: <20211028164357.1439102-1-revest@chromium.org> <20211028224653.qhuwkp75fridkzpw@kafai-mbp.dhcp.thefacebook.com>
 <CABRcYmLWAp6kYJBA2g+DvNQcg-5NaAz7u51ucBMPfW0dGykZAg@mail.gmail.com>
 <204584e8-7817-f445-1e73-b23552f54c2f@gmail.com> <CABRcYmJxp6-GSDRZfBQ-_7MbaJWTM_W4Ok=nSxLVEJ3+Sn7Fpw@mail.gmail.com>
 <dccc55b4-9f45-4b1c-2166-184a8979bdc6@fb.com>
In-Reply-To: <dccc55b4-9f45-4b1c-2166-184a8979bdc6@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 1 Nov 2021 19:53:20 -0700
Message-ID: <CAADnVQ+pwWWumw9_--jj7e_RL=n6Q3jhe6yawuSeMJzpFi_E2A@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Allow bpf_d_path in perf_event_mmap
To:     Yonghong Song <yhs@fb.com>
Cc:     Florent Revest <revest@chromium.org>,
        Hengqi Chen <hengqi.chen@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Brendan Jackman <jackmanb@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 1, 2021 at 10:32 AM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 11/1/21 8:01 AM, Florent Revest wrote:
> > On Mon, Nov 1, 2021 at 2:17 PM Hengqi Chen <hengqi.chen@gmail.com> wrote:
> >>
> >> Hi,
> >>
> >>
> >> On 2021/10/30 1:02 AM, Florent Revest wrote:
> >>> On Fri, Oct 29, 2021 at 12:47 AM Martin KaFai Lau <kafai@fb.com> wrote:
> >>>>
> >>>> On Thu, Oct 28, 2021 at 06:43:57PM +0200, Florent Revest wrote:
> >>>>> Allow the helper to be called from the perf_event_mmap hook. This is
> >>>>> convenient to lookup vma->vm_file and implement a similar logic as
> >>>>> perf_event_mmap_event in BPF.
> >>>>  From struct vm_area_struct:
> >>>>          struct file * vm_file;          /* File we map to (can be NULL). */
> >>>>
> >>>> Under perf_event_mmap, vm_file won't be NULL or bpf_d_path can handle it?
> >>>
> >>> Thanks Martin, this is a very good point. :) Yes, vm_file can be NULL
> >>> in perf_event_mmap.
> >>> I wonder what would happen (and what we could do about it? :|).
> >>> bpf_d_path is called on &vma->vm_file->f_path So without NULL checks
> >>> (of vm_file) in BPF, the helper wouldn't be called with a NULL pointer
> >>> but rather with an address that is offsetof(struct file, f_path).
> >>>
> >>
> >> I tested this patch with the following BCC script:
> >>
> >>      bpf_text = '''
> >>      #include <linux/mm_types.h>
> >>
> >>      KFUNC_PROBE(perf_event_mmap, struct vm_area_struct *vma)
> >>      {
> >>          char path[256] = {};
> >>
> >>          bpf_d_path(&vma->vm_file->f_path, path, sizeof(path));
> >>          bpf_trace_printk("perf_event_mmap %s", path);
> >>          return 0;
> >>      }
> >>      '''
> >>
> >>      b = BPF(text=bpf_text)
> >>      print("BPF program loaded")
> >>      b.trace_print()
> >>
> >> This change causes kernel panic. I think it's because of this NULL pointer.
> >
> > Thank you for the testing and repro Hengqi :)
> > Indeed, I was able to reproduce this panic. When vma->vm_file is NULL,
> > &vma->vm_file->f_path ends up being 0x18 so d_path causes a panic.
> > I suppose that this sort of issue must be relatively common in helpers
> > that take a PTR_TO_BTF_ID though ? I wonder if there is anything that
>
> Most non-tracing ARG_PTR_TO_BTF_ID argument has strict helper/prog_type
> protection and should be okay although I didn't check them 100%.
>
> For some tracing helpers with ARG_PTR_TO_BTF_ID argument, we have
> bpf_seq_printf/bpf_seq_write which has strict context as well and should
> not be NULL.
>
> For helper bpf_task_pt_regs() which can attach to ANY kernel function,
> we kind of assume "task" is not NULL which should be the case in "almost
> all* cases from kernel internal data structure.
>
> > the verifier could do about this ? For example if vma->vm_file could
> > be PTR_TO_BTF_ID_OR_NULL and therefore vma->vm_file->f_path somehow
> > considered invalid ?
>
> Verifier has no way to know whether vma->vm_file is NULL or not during
> verification time. So in your case, if we have to be conservative, that
> means verifier will reject the program.
>
> One possible way could be add a mode in verifier, we still *go through*
> the process for direct memory access but we require user explicit
> checking NULL pointers. This way, user will be forced to write code like
>
>     FILE *vm_file = vma->vm_file; /* no checking is needed, vma from
> parameter which is not NULL */
>     if (vm_file)
>       bpf_d_path(&vm_file->f_path, path, sizeof(path));

That should work.
The verifier can achieve that by marking certain fields as PTR_TO_BTF_ID_OR_NULL
instead of PTR_TO_BTF_ID while walking such pointers.
And then disallow pointer arithmetic on PTR_TO_BTF_ID_OR_NULL until it
goes through 'if (Rx == NULL)' check inside the program and gets converted to
PTR_TO_BTF_ID.
Initially we can hard code such fields via BTF_ID(struct, file) macro.'
So any pointer that results into a 'struct file' pointer will be
PTR_TO_BTF_ID_OR_NULL.
