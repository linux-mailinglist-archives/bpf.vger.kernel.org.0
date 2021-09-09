Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5787440451C
	for <lists+bpf@lfdr.de>; Thu,  9 Sep 2021 07:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350781AbhIIFkb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Sep 2021 01:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350756AbhIIFka (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Sep 2021 01:40:30 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E2EC061575
        for <bpf@vger.kernel.org>; Wed,  8 Sep 2021 22:39:21 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id r4so1570701ybp.4
        for <bpf@vger.kernel.org>; Wed, 08 Sep 2021 22:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LGO3OzjWgw10aDwHJASn+6v1Uy0qpSQPYcVa6diVxTo=;
        b=FD3KsCRFqIv8GHsfceb4PTKwl9Q8Xd73MrbHZfHlLRMe+Y9oKLKzEkUKq+LjOCE4Fj
         Q/f22e74UOlTe4Y1EkhP9ud7VdCwOLRU+kbB8XHzEIwg6hrtn0YFeYslW9lbPcY6ArMb
         73W4HeG1p6LXXXc4tDT5n2/IYl/SKVUYxon9Hn/omkVEKVtWCaW193GoMqBo4Lm8gqSY
         2xmDiCeehZfsfzBErDK4136Mohq4Ewf9rcwGSPfjpkfMgC3OJ1uvh8Qgag0/ZZp6mOs7
         asjX6c7PyvE0Mk6XaeWxgnnnN7ix+oPvpm46cK4tdN+e5xt2/CTwsGNN9eR/LuuQNjik
         m55A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LGO3OzjWgw10aDwHJASn+6v1Uy0qpSQPYcVa6diVxTo=;
        b=qHNlhbazpB7YiQGV7t237dNRL8uIk+9TKavm8ITgsFOh2KQxKczll98E5wzZWTrx8y
         eK1AKzH3p7mmM4lzbZ07m8YwWgWa/35Id9GWJipvgx5Grz1vWQprgX8TcOZBnAikTl3W
         K0VDI0VcOtx1mxNj6u48t6cGY8oTTW8l2j8LCAdq1IsGkt05On1lXSO48Ax22f7GY9Rh
         bkM6PANiax8vQuecG1qew5ATOKiVxE8Jf/KCZRMslwpI/t2EyusBUa6zmiW2pdIIkwMv
         jTtvC9NeDX6RmnidzOOfEsfqnp5fSJWX3EFtQjWHkQ7EQhaUDcVVTd0RGwn58Hd8Furb
         37bQ==
X-Gm-Message-State: AOAM5334pA8NVPuFVmUOtqWLYCAKnfMYpPqyWTbzQZMDMkV4q2EKyCBv
        Ymtg6LKgPglz/GjGRfIgq0figER6NlS1Zd1tWvI=
X-Google-Smtp-Source: ABdhPJyK6bOx6hVvwF1nF18UpC8GQtQeQoICaNJfMR6PXHTdKLco5V+mzU+4SaDBJBOUqM3ZnNt4pgA6ToMbXo09wFM=
X-Received: by 2002:a05:6902:725:: with SMTP id l5mr1745316ybt.178.1631165961017;
 Wed, 08 Sep 2021 22:39:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210907230050.1957493-1-yhs@fb.com> <20210907230132.1960689-1-yhs@fb.com>
In-Reply-To: <20210907230132.1960689-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 8 Sep 2021 22:39:09 -0700
Message-ID: <CAEf4BzayrFRw8cJD-SV7Xf=NyeCVnDdUwySD1=6eT7zBdWyYbg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 8/9] selftests/bpf: add a test with a bpf program
 with btf_tag attributes
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 7, 2021 at 4:01 PM Yonghong Song <yhs@fb.com> wrote:
>
> Add a bpf program with btf_tag attributes. The program is
> loaded successfully with the kernel. With the command
>   bpftool btf dump file ./tag.o
> the following dump shows that tags are properly encoded:
>   [8] STRUCT 'key_t' size=12 vlen=3
>           'a' type_id=2 bits_offset=0
>           'b' type_id=2 bits_offset=32
>           'c' type_id=2 bits_offset=64
>   [9] TAG 'tag1' type_id=8, comp_id=-1
>   [10] TAG 'tag2' type_id=8, comp_id=-1
>   [11] TAG 'tag1' type_id=8, comp_id=1
>   [12] TAG 'tag2' type_id=8, comp_id=1
>   ...
>   [21] FUNC_PROTO '(anon)' ret_type_id=2 vlen=1
>           'x' type_id=2
>   [22] FUNC 'foo' type_id=21 linkage=static
>   [23] TAG 'tag1' type_id=22, comp_id=0
>   [24] TAG 'tag2' type_id=22, comp_id=0
>   [25] TAG 'tag1' type_id=22, comp_id=-1
>   [26] TAG 'tag2' type_id=22, comp_id=-1
>   ...
>   [29] VAR 'total' type_id=27, linkage=global
>   [30] TAG 'tag1' type_id=29, comp_id=-1
>   [31] TAG 'tag2' type_id=29, comp_id=-1
>
> If an old clang compiler, which does not support btf_tag attribute,
> is used, these btf_tag attributes will be silently ignored.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---

LGTM.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  .../selftests/bpf/prog_tests/btf_tag.c        | 14 +++++++
>  tools/testing/selftests/bpf/progs/tag.c       | 39 +++++++++++++++++++
>  2 files changed, 53 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_tag.c
>  create mode 100644 tools/testing/selftests/bpf/progs/tag.c
>

[...]
