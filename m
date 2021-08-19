Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77E933F218F
	for <lists+bpf@lfdr.de>; Thu, 19 Aug 2021 22:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233208AbhHSU2F (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Aug 2021 16:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbhHSU2F (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Aug 2021 16:28:05 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D75C061575;
        Thu, 19 Aug 2021 13:27:28 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id k65so14526976yba.13;
        Thu, 19 Aug 2021 13:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=884BopcU1imGRLaO4LpBuPSgpizZ7oFMWzxWzJMwG0I=;
        b=BveuDT2+V98CcHsRXUk0c2JCBIgR1W5DQC5OuCzAmae/fxFVJ8ycBr0I6lGvDCESLb
         aOgEk5bmsViKDIQ4Dkx6gjBFfzEWvOyJnCs8CveRgDQq5sPTpeLAqF4lTpB/Da4IRu0/
         qzn41qSrJK76D/x4XuUGNBitDNIIkCA8nBfLPYwHgBnw4N461iHOke8+DSKcs7/Ohytg
         d2APNGVrGRqDub01PjipZTBnuQPATr/FVPkU+hCmLyZhePHTaBQu+H9pzF4Jpe9E3+xg
         nzqNch28Fp1t1NPwbFU5peTIspRtNh7TgI/l2nTjbdkQAFe+kR67c2S+MNu7qyFBSBXC
         av3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=884BopcU1imGRLaO4LpBuPSgpizZ7oFMWzxWzJMwG0I=;
        b=kEL15LqJnv715MaYsuocVtxlT+wkOhCYP66msIhaOiaFaPzu6spPpNxGHiY+B7Qggi
         YPOwVOPcbFWqp0/M/08GtxdB9rBlhOcP7OFcigZSQOEYb72BFbXt88Mso83xO/0LQVoE
         8D6rk36rtCbsxJjj+u25Ek4w23DQu2TuCX+95RaQNeQMkOeHU2GQsUu7zT4N2Oz22ico
         a0NbpJOnFSQnRsd7bh4grKghmH/IP6ZnddIarNsPBtj5Wo9+ZIvgnzsTQARVh0QjSClZ
         qRPspQSe5buYETfCAOIAV4HYzvUrnRG6qafGnb1PTLByjYN2UPM+Q5Ra11YJ1aV1aaeR
         wPFw==
X-Gm-Message-State: AOAM532g4a/zxxOCoIT1pdDU36Chp3OtQWqvkOOp5Aow2aVptcO1n25j
        AoXRiWUPqXz4wbfYX/RsDdGvHWICEM+IS880h9s=
X-Google-Smtp-Source: ABdhPJxtEilqTUBcQ5vo4G6oVYDl6Y4TIaWXPxI/BRsYLYkvlMl797meZHQeIPsvTHJ+xhuhWfEAu/KvBHSGreoh2FY=
X-Received: by 2002:a25:b21f:: with SMTP id i31mr20033958ybj.403.1629404847960;
 Thu, 19 Aug 2021 13:27:27 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1629329560.git.dxu@dxuuu.xyz> <6d269f13f2ff742e319a8c19112ef40f0b4c2f46.1629329560.git.dxu@dxuuu.xyz>
In-Reply-To: <6d269f13f2ff742e319a8c19112ef40f0b4c2f46.1629329560.git.dxu@dxuuu.xyz>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 19 Aug 2021 13:27:16 -0700
Message-ID: <CAEf4BzZAs5P4m0Ct5OpV0FZJ7nosYo5QDraEScphUmprta_77w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Add bpf_task_pt_regs() helper
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     bpf <bpf@vger.kernel.org>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Kernel Team <kernel-team@fb.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Aug 18, 2021 at 4:42 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> The motivation behind this helper is to access userspace pt_regs in a
> kprobe handler.
>
> uprobe's ctx is the userspace pt_regs. kprobe's ctx is the kernelspace
> pt_regs. bpf_task_pt_regs() allows accessing userspace pt_regs in a
> kprobe handler. The final case (kernelspace pt_regs in uprobe) is
> pretty rare (usermode helper) so I think that can be solved later if
> necessary.
>
> More concretely, this helper is useful in doing BPF-based DWARF stack
> unwinding. Currently the kernel can only do framepointer based stack
> unwinds for userspace code. This is because the DWARF state machines are
> too fragile to be computed in kernelspace [0]. The idea behind
> DWARF-based stack unwinds w/ BPF is to copy a chunk of the userspace
> stack (while in prog context) and send it up to userspace for unwinding
> (probably with libunwind) [1]. This would effectively enable profiling
> applications with -fomit-frame-pointer using kprobes and uprobes.
>
> [0]: https://lkml.org/lkml/2012/2/10/356
> [1]: https://github.com/danobi/bpf-dwarf-walk
>
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---

Seems like a really useful thing. Few notes:

1. Given this is user pt_regs, should we call it bpf_get_user_pt_regs()?
2. Would it be safe to enable it for all types of programs, not just
kprobe/tp/raw_tp/perf? Why limit the list?
3. It seems like it's the sixth declaration of BTF_ID for task_struct,
maybe it's time to consolidate them?

>  include/uapi/linux/bpf.h       |  7 +++++++
>  kernel/trace/bpf_trace.c       | 20 ++++++++++++++++++++
>  tools/include/uapi/linux/bpf.h |  7 +++++++
>  3 files changed, 34 insertions(+)

[...]
