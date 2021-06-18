Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94FF53AD083
	for <lists+bpf@lfdr.de>; Fri, 18 Jun 2021 18:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235534AbhFRQge (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Jun 2021 12:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235935AbhFRQgd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Jun 2021 12:36:33 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900B7C061574
        for <bpf@vger.kernel.org>; Fri, 18 Jun 2021 09:34:23 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id d13so14772586ljg.12
        for <bpf@vger.kernel.org>; Fri, 18 Jun 2021 09:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lkx42xvDJRPSSnKdE8DLKotr/K3bpuE6WK8sAqlkMFA=;
        b=kqJZynKRAB1GJSoqQ8pKRtKMM9MKibVCAbqQgExwErxnzyoc3eMU+kNItLgXShxPAz
         ACNpJA0irAaJWzgXrrJQohoa8/c0o2I6Pkffffv1xo/GOW1RDYMhppf295+ZvCaQlavU
         nU7isK9YGn7LZeYzfqhuU1I4OIy9Z9vtMenHRc/Wnvqeo4TJ7aFbEpPV4+USdEbSdRee
         3LTqXParE3sHX7bEi1AcetYqKRWQaMgWATIxGzJV+fowM8rFVJrgGhz/7DQ5tGjjspzN
         9YV2XvUY9QbpXpq9BzUg5Ue0kcmOtzawtjxoXqRwrl/jiqUu2wiEIavXeJpDtNMcrs2T
         pqdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lkx42xvDJRPSSnKdE8DLKotr/K3bpuE6WK8sAqlkMFA=;
        b=KJBpD+IrTjw9SmFfhwjoBbxyMEolSYY+GBqHMhcqkt5QosB5uACP16AunoGbFqX8oq
         PCozdZukrQTFGWWB9GL65weRNMbWXkQC+IwC0o0AHqZgxHjCwCsGusdTcG+qstHVNvlU
         jRBKuscT64Olx80k9U5asQ1hKMFvifB4ZEKkHw0RjFjexDZHEOzkubolN/qD4hPm7Vuu
         s8J7Iex90cuyUcvPimpqht4RAHzJ/aGfjiJBfsDXnpOGeAtlZH8OlW+IegoouKDnIaU4
         R+Ov9odLYcrlakaentQpBDU3Tua9qwphMlFq4UuuvQ6XqaUtx9badxqOfyIVAbjB+sR2
         A0hw==
X-Gm-Message-State: AOAM533x2qfZgUH3kWA/1bJJIps4z0QBQiXfVfAXod9c31qZIk+wMMEH
        Z5hW3QChdqaZfItymPkW9/UqJQ5YkAMQOSnbp/A=
X-Google-Smtp-Source: ABdhPJxsgzCMHGRE3Ma/2pyFgGPrqFfc7/nFHMvYmphpGnBcbM7SVnyZ1TYWqgKxfPO4vS308VQ+CehePK4cD9PiP1s=
X-Received: by 2002:a05:651c:102a:: with SMTP id w10mr9874798ljm.486.1624034061960;
 Fri, 18 Jun 2021 09:34:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200728152122.1292756-1-jean-philippe@linaro.org>
 <daba29d3-46bb-8246-74a7-83184c92435c@linux.ibm.com> <CAADnVQJsCkSdqCaQt2hretdqamWJmWRQvh+=RvwHmHAOW2kL6g@mail.gmail.com>
 <fedff32f-e511-a191-22b0-bf421bdcce2a@linux.ibm.com>
In-Reply-To: <fedff32f-e511-a191-22b0-bf421bdcce2a@linux.ibm.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 18 Jun 2021 09:34:10 -0700
Message-ID: <CAADnVQJux+8n-vpuK9FqTLuj4cXrp04pGkpvKaUdAPXLQ4c-PQ@mail.gmail.com>
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

On Wed, Jun 16, 2021 at 11:58 PM Ravi Bangoria
<ravi.bangoria@linux.ibm.com> wrote:
>
>    $ dmesg
>    [  166.864325] BUG: unable to handle page fault for address: 0000000000d12345
>    [  166.864336] #PF: supervisor read access in kernel mode
>    [  166.864338] #PF: error_code(0x0000) - not-present page
>
> 0xd12345 is unallocated userspace address. Similarly, I also tried with

that's unfortunately expected, since this is a user address.

> p->dte = (void *)0xffffffffc1234567 after confirming it's not allocated
> to kernel or any module address. I see the same failure with it too.

This one is surprising though. Sounds like a bug in exception table
construction. Can you debug it to see what's causing it?
First check that do_kern_addr_fault() is invoked in this case.
And then fixup_exception() and why search_bpf_extables()
cannot find it.
Separately we probably need to replace the NULL check
with addr >= TASK_SIZE_MAX to close this issue though it's a bit artificial.
