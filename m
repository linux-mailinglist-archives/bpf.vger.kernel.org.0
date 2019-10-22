Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC6FDFC19
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2019 05:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387519AbfJVDBR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Oct 2019 23:01:17 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42758 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387518AbfJVDBR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Oct 2019 23:01:17 -0400
Received: by mail-qk1-f193.google.com with SMTP id f16so14905971qkl.9
        for <bpf@vger.kernel.org>; Mon, 21 Oct 2019 20:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4GE70+v1P6CWOfTk389RWmopYvsuja0B6KUbvqkVYOI=;
        b=QeTrgyQj5Dv30vB3OiUu+u+FjwWqCuQJJfxH/OYVKekNipafh5ANJsD/4QGyhL4oBW
         1/nz/m/KyK2RbhYAlS+L0PcmCnaWXZmtrlwzrAjs16Xe9YCgGqyMJMcdBrIFDo0z9Yju
         Z781f+Muu3I5fAvEIHoCsKpCkErh/0nyNV1mlbNlujqhkZ55X69yWKQvRe7/8pG6/4Q9
         D7NMztrrKktWfLYNcDlawbnLe0v3N27NNLQQQefGAcRvp2Kf2MUUxvWxlTdd3o8VU0o1
         UV9CAcyMkr8f1YNNexlbx0+kATH55CzEWQ4nvYFkX/4kYsvxoUu5uEkkyXKEgKeQ+Bpx
         wlZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4GE70+v1P6CWOfTk389RWmopYvsuja0B6KUbvqkVYOI=;
        b=hm2aSoJUys7LNbXeawF4gDf+5Ww+qA0N80zQ/6E3a7JHlMH5wPzvvuxe8OtgYb5F4L
         wghQXXAAImPxFC0YDqgeZxXHOHSuazAsGKcaukyN2aghzvdt8Co1I+ngHzeoX6qUi2A6
         XUbzXILlUOvIXwSrkWK1GrAkGgjlVY1eH9GxilK/kSbZ2YWBwomsYlgyCNJDz5PuMLWT
         dfupngQxdZPiReU5sYOXY6rk2e+KoBNcZXqmLc2r4A7vZ5bQCabCR3Uv/u1cUgmBYz8V
         AfmdUV7o3QyyJjAwZS2I0tdTozwwm3DsCg17AGp+RZmHHLpsxK7r7UvIXX2EtPrnG3ZQ
         URqA==
X-Gm-Message-State: APjAAAUrs5feVNf36Xvva8NvaM+MKM98Y6ZButHCf0hbkcHEOyK4yISK
        NchFoV7XDyu7grKldmFJ0iQTpqZetj6BJk/RgqA=
X-Google-Smtp-Source: APXvYqybUAHEuh5obxu7NmMrUfbTjdPYyK2NdRl5a5GgjG8CxHz7cVWgUPMPdYGu2V9HKxgpueQsLTW166dg/WCK/W0=
X-Received: by 2002:a37:520a:: with SMTP id g10mr1000500qkb.39.1571713275454;
 Mon, 21 Oct 2019 20:01:15 -0700 (PDT)
MIME-Version: 1.0
References: <20191022023226.2255076-1-yhs@fb.com>
In-Reply-To: <20191022023226.2255076-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 21 Oct 2019 20:01:04 -0700
Message-ID: <CAEf4BzaugaCBgUFnavTtAzezY-Tz55bbfPcQFHOv9Z5VbMh-TQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] tools/bpf: turn on llvm alu32 attribute by default
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Jiong Wang <jiong.wang@netronome.com>,
        Andrii Nakryiko <andriin@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 21, 2019 at 7:32 PM Yonghong Song <yhs@fb.com> wrote:
>
> llvm alu32 was introduced in llvm7:
>   https://reviews.llvm.org/rL325987
>   https://reviews.llvm.org/rL325989
> Experiments showed that in general performance
> is better with alu32 enabled:
>   https://lwn.net/Articles/775316/
>
> This patch turned on alu32 with no-flavor test_progs
> which is tested most often. The flavor test at
> no_alu32/test_progs can be used to test without
> alu32 enabled. The Makefile check for whether
> llvm supports '-mattr=+alu32 -mcpu=v3' is
> removed as llvm7 should be available for recent
> distributions and also latest llvm is preferred
> to run bpf selftests.
>
> Note that jmp32 is checked by -mcpu=probe and
> will be enabled if the host kernel supports it.
>
> Cc: Jiong Wang <jiong.wang@netronome.com>
> Cc: Andrii Nakryiko <andriin@fb.com>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---

Sounds good to me, see minor nit below.

Acked-by: Andrii Nakryiko <andriin@fb.com>

>  tools/testing/selftests/bpf/Makefile | 26 ++++++++------------------
>  1 file changed, 8 insertions(+), 18 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 4ff5f4aada08..5a0bca2802fe 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -32,15 +32,7 @@ TEST_GEN_PROGS = test_verifier test_tag test_maps test_lru_map test_lpm_map test
>         test_netcnt test_tcpnotify_user test_sock_fields test_sysctl test_hashmap \
>         test_cgroup_attach xdping
>
> -# Also test sub-register code-gen if LLVM has eBPF v3 processor support which
> -# contains both ALU32 and JMP32 instructions.
> -SUBREG_CODEGEN := $(shell echo "int cal(int a) { return a > 0; }" | \
> -                       $(CLANG) -target bpf -O2 -emit-llvm -S -x c - -o - | \
> -                       $(LLC) -mattr=+alu32 -mcpu=v3 2>&1 | \
> -                       grep 'if w')
> -ifneq ($(SUBREG_CODEGEN),)
> -TEST_GEN_PROGS += test_progs-alu32
> -endif
> +TEST_GEN_PROGS += test_progs-no_alu32

combine this with TEST_GEN_PROGS list above, it's not conditional anymore?

>
>  # Also test bpf-gcc, if present
>  ifneq ($(BPF_GCC),)
> @@ -179,7 +171,7 @@ endef
>  # $eval()) and pass control to DEFINE_TEST_RUNNER_RULES.
>  # Parameters:

[...]
