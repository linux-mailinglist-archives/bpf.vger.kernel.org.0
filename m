Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1902719CEBD
	for <lists+bpf@lfdr.de>; Fri,  3 Apr 2020 04:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388951AbgDCCqf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Apr 2020 22:46:35 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43104 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731842AbgDCCqf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Apr 2020 22:46:35 -0400
Received: by mail-lf1-f66.google.com with SMTP id n20so4478112lfl.10;
        Thu, 02 Apr 2020 19:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p088pgCUdKjtLYg5BgMR/YxL/Sl3wyR6P8BkYTOme4c=;
        b=WvwwWahsQhmESiS/BHvk2CBk1kKcMy2IrWCquC2M6NNLCcgxEuNvQ+4R48Nuz1gvyW
         TVvzVqgnjl0odF3LEBGHhHh9tAaeBYd0MmB7jfIOaTZhUAreE2sLg7lFiLCfqCVJNP4+
         /tXc1JGCzO5syojfJtr9+Rm9YM3rWxqdgFU3qFrluJ4qUpOqOmWFfWOthWub0Ko+Gj9B
         0uMKnuCXXSJKiAnkUnKxZt5cXkz5+XNegAwVkvLL6aZJtmpFj51XReUS+26ehHrQtsPx
         YCa6q5mPnqo8L6cI5gFD6r/wAHYptNop27wrgmnpE6VxOsoO0n4wZXD4GdlebLOMSshb
         +EqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p088pgCUdKjtLYg5BgMR/YxL/Sl3wyR6P8BkYTOme4c=;
        b=n+ZKcZ6Xg494R7O/HuiUJ2mH5BVmy6j4S8FkoqB1LzQrksK1U/gFRiX28gmJoSh58e
         8/o7pA9IPT2MDGg1mX1gXpPX9S4OXuj2MvYqotvdptJlrXiFuOsCStLMEotDy2veGwsi
         Q88gb8x8vMHHvXe/yw1FWGbzdbkXVOQqqjCK8ScRRA/6VabkMZR5q5qn2gDa7jdrINmc
         1NsIwZ7ztnmawe0KqLwTH8DGIIYlKIvyPjGfQOko5QbqsZklVy5ZqFz+8PGI0hD1gwwM
         k697QxbpNc4NymGTclmV30Y2Tl0BGr5m0CuDU3l2zxIS9A+FdwYnCaXzWIpI2whAQwSl
         yw0A==
X-Gm-Message-State: AGi0PuYoXkoUKup+YBXQI4eLp/jFX69yoYqFvqCHVanGejOaQjVQ2Oqn
        /7Mtz/BUf68T2hFqrX8FDV0XyRJW7LSpgiebRiQ=
X-Google-Smtp-Source: APiQypIpx2i4EsjjI58+/0E6/sJncBfO2eiMGZaC5B6E4RIOWpMYFNpE8CvAzT4q7H8oOJEdGzdj5SpK5oGnjtFrX1I=
X-Received: by 2002:a19:40ca:: with SMTP id n193mr3885979lfa.196.1585881992590;
 Thu, 02 Apr 2020 19:46:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200402200751.26372-1-kpsingh@chromium.org>
In-Reply-To: <20200402200751.26372-1-kpsingh@chromium.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 2 Apr 2020 19:46:19 -0700
Message-ID: <CAADnVQJO+LYbUmOc71jzxpHsmUXoOw0kU7393m74J2iy1u2hCA@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf, lsm: Fix the file_mprotect LSM test.
To:     KP Singh <kpsingh@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 2, 2020 at 1:07 PM KP Singh <kpsingh@chromium.org> wrote:
>
> From: KP Singh <kpsingh@google.com>
>
> The test was previously using an mprotect on the heap memory allocated
> using malloc and was expecting the allocation to be always using
> sbrk(2). This is, however, not always true and in certain conditions
> malloc may end up using anonymous mmaps for heap alloctions. This means
> that the following condition that is used in the "lsm/file_mprotect"
> program is not sufficent to detect all mprotect calls done on heap
> memory:
>
>         is_heap = (vma->vm_start >= vma->vm_mm->start_brk &&
>                    vma->vm_end <= vma->vm_mm->brk);
>
> The test is updated to use an mprotect on memory allocated on the stack.
> While this would result in the splitting of the vma, this happens only
> after the security_file_mprotect hook. So, the condition used in the BPF
> program holds true.
>
> Signed-off-by: KP Singh <kpsingh@google.com>
> Reported-by: Alexei Starovoitov <ast@kernel.org>
> Fixes: 03e54f100d57 ("bpf: lsm: Add selftests for BPF_PROG_TYPE_LSM")

Applied. Thanks
