Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B948943AAC7
	for <lists+bpf@lfdr.de>; Tue, 26 Oct 2021 05:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234652AbhJZDiy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Oct 2021 23:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234614AbhJZDiw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Oct 2021 23:38:52 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD355C061745
        for <bpf@vger.kernel.org>; Mon, 25 Oct 2021 20:36:29 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id m63so31226402ybf.7
        for <bpf@vger.kernel.org>; Mon, 25 Oct 2021 20:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=brymmFZAHPJ8/sGsKZE/xvKXjvSYFvqoIeCMrLTst3o=;
        b=e4/mM5Wgcqdz2VcHZtKBgmpDZ/mLmzhThRu7Kb1d5EC8ReZ/mfhV5BqX7euEn1Mayr
         xXb60IveesckzgZCqcbaJi3p++zMwqmRv0qilbsdZmw7X/gyuCfzfh0amkfug3Tan05N
         4AFxskfdB+qgms2TKjLaNZJihFxm76GJgKXbLv56tZPX23oP9277wsu0bLsoFvWwK93v
         69mc7YbLhuWyPpegVGuzdDnxPeuzw61g9ncr1/Q4q2sRUQNgtaTmO7j1qnMLxiU9zHD3
         m2kldrwMQvOPlT2UKpyDLReABVnye/DuOtPOyPqXKLCi6TfPTOfaOX+pB46KbyECtzj5
         uoGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=brymmFZAHPJ8/sGsKZE/xvKXjvSYFvqoIeCMrLTst3o=;
        b=RoWxUKqvgsPNJLypqSj8/c7jAlDKI1kRrcHJKgySBc4sgcst8Sg8NhMk6yo/kUDpQN
         nSvEp3sLFnwFTfNiWuA774IP0ng1QIEsSm39SDP8xVV4+pEqa3oni+ZID0go7vpoGVKD
         cgH0K84T0eieiVA9GifIjjVgFsQ9kbf1Boa3YA9NAZkjWIXCCgLpxGuynW7glHgVycwm
         sheDWSn2MfVmVYtjr0zjRJXMCtcC0yorNxUWXEmh9a4yp4G3ONi5t+wj98N9+OonPS8u
         1c8EOg7U79OsYHK9ybOV16DD+BLK21D3mBDWOnt0pUgFXUxYKORVvo2wvY9ZmbO7mCvS
         EdEg==
X-Gm-Message-State: AOAM533gCqDxyZ1NMiG/gk1RNIbnjkhyFk70gtv8gMYtkj4UQQI/S3TJ
        QN//aalS/Gy0wa0roOmQ25qf/ahdTVlKQ0Daru0=
X-Google-Smtp-Source: ABdhPJx7Dt2HtSUqz51v4sI8eiJiXoMGKXzOvP/FyxORoolUrfylINqeK35M5zp7VofkjF4dQfajEsQkpZhAndcX4Fg=
X-Received: by 2002:a25:8749:: with SMTP id e9mr20810942ybn.2.1635219388327;
 Mon, 25 Oct 2021 20:36:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAHap4ztxPO485-5u5bkncyf9n-EQBTfF-3tN28jdNa4w1E-vkQ@mail.gmail.com>
In-Reply-To: <CAHap4ztxPO485-5u5bkncyf9n-EQBTfF-3tN28jdNa4w1E-vkQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 25 Oct 2021 20:36:17 -0700
Message-ID: <CAEf4BzaRT_DX1yZwOLJXxojfQmfJdt6t97=4-+AdHmt1MnBSQA@mail.gmail.com>
Subject: Re: Question about duplicated types in BTF and btf__dedup()
To:     =?UTF-8?Q?Mauricio_V=C3=A1squez_Bernal?= <mauricio@kinvolk.io>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Rafael David Tinoco <rafaeldtinoco@gmail.com>,
        Lorenzo Fontana <lorenzo.fontana@elastic.co>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 25, 2021 at 6:42 PM Mauricio V=C3=A1squez Bernal
<mauricio@kinvolk.io> wrote:
>
> Hi. I found out that some of the BTF files provided by BTFHub contain
> a lot of duplicated types definitions:
>
> $ mkdir -p /tmp/foo
> $ cd /tmp/foo/
> $ wget https://github.com/aquasecurity/btfhub/raw/main/ubuntu/20.04/x86_6=
4/5.4.0-88-generic.btf.tar.xz
> $ tar -xf 5.4.0-88-generic.btf.tar.xz
>
> $ bpftool btf dump file 5.4.0-88-generic.btf | grep "STRUCT 'dentry'"
> [954] STRUCT 'dentry' size=3D192 vlen=3D16
> [28359] STRUCT 'dentry' size=3D192 vlen=3D16
>
> $ bpftool btf dump file 5.4.0-88-generic.btf | grep "STRUCT 'task_struct'=
"
> [146] STRUCT 'task_struct' size=3D9216 vlen=3D213
> [28317] STRUCT 'task_struct' size=3D9216 vlen=3D213
>
> $ bpftool btf dump file 5.4.0-88-generic.btf | grep "STRUCT 'file'"
> [640] STRUCT 'file' size=3D256 vlen=3D21
> [28416] STRUCT 'file' size=3D256 vlen=3D21
>
> I tried to use btf__dedup() but the result is just the same file. Is
> this expected to have duplicated types in the BTF files? Why aren't
> those types getting deduplicated by the algorithm?
>
> btw, I also noted that the /sys/kernel/btf/vmlinux file contains
> duplicated types in some kernels, so I don't think it's an issue
> related to BTFHub.

It's most probably due to different struct ring_buffer in different
files. Long story short, those struct task_struct types eventually
reference struct ring_buffer. Kernel used to have two very different
struct ring_buffer definitions. So depending on #includes, in some
files struct task_struct (through many other types, not directly)
reference either one or the other struct ring_buffer. From BTF dedup
algorithm point of view, those hierarchies of types that reference
those two different struct ring_buffers are different, so BTF dedup
keeps two copies.

struct ring_buffer is just one such case. There were more different
types with the same name, so this duplication of types can happen.

Basically, this is an unfortunate, but expected thing. Most common
cases of such conflicting types since got renamed, but if you try to
compile all drivers with allyesconfig, you'll inevitably have more
type collisions which will result in more type duplication.

Good news is that libbpf handles this just fine.

>
> Thanks
> Mauricio.
