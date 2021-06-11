Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFCE3A385E
	for <lists+bpf@lfdr.de>; Fri, 11 Jun 2021 02:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbhFKAPk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Jun 2021 20:15:40 -0400
Received: from mail-oi1-f179.google.com ([209.85.167.179]:37615 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbhFKAPj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Jun 2021 20:15:39 -0400
Received: by mail-oi1-f179.google.com with SMTP id h9so4051907oih.4
        for <bpf@vger.kernel.org>; Thu, 10 Jun 2021 17:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kz2n5b2v/MrR2aG6nyGBznVusGFd//R5WAxR4m5f4UY=;
        b=kSlJUqApqgq9y7kLhxREybqwpjdGkuC2+/2KKCLpGoDQqCgi5yYIoOotp610xolNj3
         VxcAxrJhKUN1jxbQONuSSJ4rbmlFLwflyCQ6Rui0s1jcZ0jq+VTmSPbcoBuHNm8530ua
         mIlUhfnwRd5QjlgigXp/UB0Mh3VslJcrGNwjBAsbZZkxpine9K27MG34V1oRhukYKpPj
         IBx4kCDuOF51WogxVZsEXov2vSxnK+1yzwlBXwe5MB7I2EU1WPrrTVuPneczk2/sJhWr
         dU5Ddcx5V2uiNQqGg0PVrWiWLM7vbgjrYNAKGvkMkdM4vRSdS1gluYobPK/FXhAD/0v4
         IEiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kz2n5b2v/MrR2aG6nyGBznVusGFd//R5WAxR4m5f4UY=;
        b=qzcqBgdpNKNMLCrjYWFI8AEC0CNOZEHSX2v1EF7MoVCeUy27LJ7NzAvH9ogOSPXL46
         U9z1ZED6BD58vxGVa/tbF2Gv34+6l/eLxKaqOfcl5jHzs3WDDmrHf8ZRS6zlbCFXOyuW
         JYJludbozvJF0AprqWoSSwaYmejYOO7YwR7oy4+YkXAMcQESQ4syls7whtUgGFzA7dNI
         jRloR/ggQpJXfkK2g+MfrXDzoUCuUxGgTckpOkwSZpNF5rgHqmeyRskifLs0mxv6DEy/
         8cs/aymcUwQhXG2JlT6+SPx2pq/wi/KktyHR62uYkUOhdTssXks0ruXbttVuyCCgwOKx
         7jtw==
X-Gm-Message-State: AOAM532F9zUFIo4OhK8E8yO/ioSbgUUViMeOx2XYinSimEhJeIroqInv
        MVBg1T5F/oS7U+w1RkFdf6pgcnqVbtHEwD+UF6c=
X-Google-Smtp-Source: ABdhPJy95zmdr37I+E23j/jbW+Ync4xEjf8dLqox3v1R4ePF/fYI+Bh74kauRsmyEeHgfbnlMplZiEqv/osBuyqYUZI=
X-Received: by 2002:aca:53ca:: with SMTP id h193mr11535748oib.69.1623370345862;
 Thu, 10 Jun 2021 17:12:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200728152122.1292756-1-jean-philippe@linaro.org> <daba29d3-46bb-8246-74a7-83184c92435c@linux.ibm.com>
In-Reply-To: <daba29d3-46bb-8246-74a7-83184c92435c@linux.ibm.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 10 Jun 2021 17:12:14 -0700
Message-ID: <CAADnVQJsCkSdqCaQt2hretdqamWJmWRQvh+=RvwHmHAOW2kL6g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/1] arm64: Add BPF exception tables
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Zi Shen Lim <zlim.lnx@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        bpf <bpf@vger.kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jun 9, 2021 at 5:05 AM Ravi Bangoria
<ravi.bangoria@linux.ibm.com> wrote:
>
> Hi Alexei,
>
> On 7/28/20 8:51 PM, Jean-Philippe Brucker wrote:
> > The following patch adds support for BPF_PROBE_MEM on arm64. The
> > implementation is simple but I wanted to give a bit of background first.
> > If you're familiar with recent BPF development you can skip to the patch
> > (or fact-check the following blurb).
> >
> > BPF programs used for tracing can inspect any of the traced function's
> > arguments and follow pointers in struct members. Traditionally the BPF
> > program would get a struct pt_regs as argument and cast the register
> > values to the appropriate struct pointer. The BPF verifier would mandate
> > that any memory access uses the bpf_probe_read() helper, to suppress
> > page faults (see samples/bpf/tracex1_kern.c).
> >
> > With BPF Type Format embedded into the kernel (CONFIG_DEBUG_INFO_BTF),
> > the verifier can now check the type of any access performed by a BPF
> > program. It rejects for example programs that cast to a different
> > structure and perform out-of-bounds accesses, or programs that attempt
> > to dereference something that isn't a pointer, or that hasn't gone
> > through a NULL check.
> >
> > As this makes tracing programs safer, the verifier now allows loading
> > programs that access struct members without bpf_probe_read(). It is
> > however still possible to trigger page faults. For example in the
> > following example with which I've tested this patch, the verifier does
> > not mandate a NULL check for the second-level pointer:
> >
> > /*
> >   * From tools/testing/selftests/bpf/progs/bpf_iter_task.c
> >   * dump_task() is called for each task.
> >   */
> > SEC("iter/task")
> > int dump_task(struct bpf_iter__task *ctx)
> > {
> >       struct seq_file *seq = ctx->meta->seq;
> >       struct task_struct *task = ctx->task;
> >
> >       /* Program would be rejected without this check */
> >       if (task == NULL)
> >               return 0;
> >
> >       /*
> >        * However the verifier does not currently mandate
> >        * checking task->mm, and the following faults for kernel
> >        * threads.
> >        */
> >       BPF_SEQ_PRINTF(seq, "pid=%d vm=%d", task->pid, task->mm->total_vm);
> >       return 0;
> > }
> >
> > Even if it checked this case, the verifier couldn't guarantee that all
> > accesses are safe since kernel structures could in theory contain
> > garbage or error pointers. So to allow fast access without
> > bpf_probe_read(), a JIT implementation must support BPF exception
> > tables. For each access to a BTF pointer, the JIT generates an entry
> > into an exception table appended to the BPF program. If the access
> > faults at runtime, the handler skips the faulting instruction. The
> > example above will display vm=0 for kernel threads.
>
> I'm trying with the example above (task->mm->total_vm) on x86 machine
> with bpf/master (11fc79fc9f2e3) plus commit 4c5de127598e1 ("bpf: Emit
> explicit NULL pointer checks for PROBE_LDX instructions.") *reverted*,
> I'm seeing the app getting killed with error in dmesg.
>
>    $ sudo bpftool iter pin bpf_iter_task.o /sys/fs/bpf/task
>    $ sudo cat /sys/fs/bpf/task
>    Killed
>
>    $ dmesg
>    [  188.810020] BUG: kernel NULL pointer dereference, address: 00000000000000c8
>    [  188.810030] #PF: supervisor read access in kernel mode
>    [  188.810034] #PF: error_code(0x0000) - not-present page
>
> IIUC, this should be handled by bpf exception table rather than killing
> the app. Am I missing anything?

For PROBE_LDX the verifier guarantees that the address is either
a very likely valid kernel address or NULL. On x86 the user and kernel
address spaces are shared and NULL is a user address, so there cannot be
an exception table for NULL. Hence x86-64 JIT inserts NULL check when
it converts PROBE_LDX into load insn.
