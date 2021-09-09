Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC7F64044A3
	for <lists+bpf@lfdr.de>; Thu,  9 Sep 2021 06:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350437AbhIIE7H (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Sep 2021 00:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbhIIE7G (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Sep 2021 00:59:06 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BEAFC061575;
        Wed,  8 Sep 2021 21:57:58 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id k65so1358987yba.13;
        Wed, 08 Sep 2021 21:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pDztYpdMgz+EivXrgs8mgs/VRszb49SOrCgwxm22Cv8=;
        b=LML7pCD9Lmu+9xugohKKvI07uWANHAP6eRlisyGc8SmJj7iX+LM/KlxVbe59IeiH/i
         0MI+q82Zum/ngTDfoL7nV3W9mi/8u6fcXLWHYjGuD+Mblz32xZlvP+PTPVa7XRXqqtXV
         Na9fwnSHowMJZpAj/iAUMJdi+8h9qzmBC0DqEKRZH3GX5oJZCszW5JSLv/ktByFq1XZW
         98v8OhY7G7OJydtxV3QnBcNIA+Dl2thSycb/89P7uVU/Ks/bokOpTI0ApbhxM3iadlP+
         X9tUzHbOKq0bGUO16gf2uFP5bFSx6hzjtiq1KU9dnQNObBU4beOesIoFvMqXpDDUQNxp
         aaTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pDztYpdMgz+EivXrgs8mgs/VRszb49SOrCgwxm22Cv8=;
        b=U0gcnIuIrWhiMIcUPt4JqSWIc1tKwxpFqVyZS6jpSf0WyqD+bR7FeU3QwTXbqcCmRt
         Cng5yoU/2/1t0aeC0+zEhzG4GCSl21/+Gpoa2eKnNh4KEeBeAY7g43wOBqfu59yW4IzD
         dNEBXCW5R2XWwIXzCVVWTXbGQpDGjHO+0/p3P1nBocfYxrvxictGex4rqMsyvsWNNo+B
         qftZrP22qquJpYDc1M0Ou47jjXuZgtk4TZFzwYmxUkH9Lahd4JBlfBtSNfreTJ7pcZ7+
         0Pm3ZmCQ38DhjBYpnDyTsgby8Kq0NkZKz1GXM8UTve5ukOsAqkYY2vPqbInoCVIj9kXt
         VPsg==
X-Gm-Message-State: AOAM5310F59FfF8CU0+lfgkXY2i0WrXkobl9khRJ/01Fhb2U6HUrIC8E
        ilR4VchzAScoY96yZegPNaVvYMTIVzjdMwhRfwz1BM2x
X-Google-Smtp-Source: ABdhPJxMWUDMhDNrAgn9HgXkFBdLwntqSrpPQylsdSx0AouaW+gFSZUXvFY/k9vQ7JYs7UL769LqEKATyFqHptroy4A=
X-Received: by 2002:a25:ef46:: with SMTP id w6mr1441432ybm.546.1631163477355;
 Wed, 08 Sep 2021 21:57:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210907060040.36222-1-cuibixuan@huawei.com>
In-Reply-To: <20210907060040.36222-1-cuibixuan@huawei.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 8 Sep 2021 21:57:46 -0700
Message-ID: <CAEf4BzbEOpShbC1+iGo5DafFJc6U1gS9ytB2X_X0rqpWUfjbeg@mail.gmail.com>
Subject: Re: [PATCH -next] bpf: Add oversize check before call kvcalloc()
To:     Bixuan Cui <cuibixuan@huawei.com>
Cc:     bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 6, 2021 at 11:04 PM Bixuan Cui <cuibixuan@huawei.com> wrote:
>
> Commit 7661809d493b ("mm: don't allow oversized kvmalloc() calls") add the
> oversize check. When the allocation is larger than what kmalloc() supports,
> the following warning triggered:
>
> WARNING: CPU: 0 PID: 8408 at mm/util.c:597 kvmalloc_node+0x108/0x110 mm/util.c:597
> Modules linked in:
> CPU: 0 PID: 8408 Comm: syz-executor221 Not tainted 5.14.0-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:kvmalloc_node+0x108/0x110 mm/util.c:597
> Call Trace:
>  kvmalloc include/linux/mm.h:806 [inline]
>  kvmalloc_array include/linux/mm.h:824 [inline]
>  kvcalloc include/linux/mm.h:829 [inline]
>  check_btf_line kernel/bpf/verifier.c:9925 [inline]
>  check_btf_info kernel/bpf/verifier.c:10049 [inline]
>  bpf_check+0xd634/0x150d0 kernel/bpf/verifier.c:13759
>  bpf_prog_load kernel/bpf/syscall.c:2301 [inline]
>  __sys_bpf+0x11181/0x126e0 kernel/bpf/syscall.c:4587
>  __do_sys_bpf kernel/bpf/syscall.c:4691 [inline]
>  __se_sys_bpf kernel/bpf/syscall.c:4689 [inline]
>  __x64_sys_bpf+0x78/0x90 kernel/bpf/syscall.c:4689
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
>
> Reported-by: syzbot+f3e749d4c662818ae439@syzkaller.appspotmail.com
> Signed-off-by: Bixuan Cui <cuibixuan@huawei.com>
> ---
>  kernel/bpf/verifier.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 047ac4b4703b..2a3955359156 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -9912,6 +9912,8 @@ static int check_btf_line(struct bpf_verifier_env *env,
>         nr_linfo = attr->line_info_cnt;
>         if (!nr_linfo)
>                 return 0;
> +       if (nr_linfo * sizeof(struct bpf_line_info) > INT_MAX)
> +               return -EINVAL;

I might be missing something, but on 64-bit architecture this can't
overflow (because u32 is multiplied by fixed small sizeof()). And on
32-bit architecture if it overflows you won't catch it... So did you
mean to do:

if (nr_lifo > INT_MAX / sizeof(struct bpf_line_info))
    return -EINVAL;

?

>
>         rec_size = attr->line_info_rec_size;
>         if (rec_size < MIN_BPF_LINEINFO_SIZE ||
> --
> 2.17.1
>
