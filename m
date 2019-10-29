Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD1EE7F3E
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2019 05:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbfJ2EhJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Oct 2019 00:37:09 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44033 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbfJ2EhJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Oct 2019 00:37:09 -0400
Received: by mail-qk1-f193.google.com with SMTP id g21so10969133qkm.11
        for <bpf@vger.kernel.org>; Mon, 28 Oct 2019 21:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dt3qYaO62X+ZEbQxXB68r8QffCjmTxoLCDw7qi1cczk=;
        b=T7ytgYiYahPBuLoIYg3E2sTBOHkc//eAscTMLlTthp4t5p0tW6yk/grnDEGkXV2Y3e
         4wRImBlMM0t+Kz6c3drjFe03PPzgW3SkjoOD+pUja6UfFrIkupRhroSOvRmacCWUwl8W
         1j6EQzCJqbDXmJXbtgt1CwKjyWkQHebWrAo7a/SZJcTUZGVcY8ZWbtD6IKpQKXZ4FtmR
         Nl4qXCg4+B+jasj8zVUvOEF7oFCRjkvmYm3v4LQM68ZATIDilIG8FXiP3SlENI2/LITR
         7c4sNAmu1DA/CtCdXvKbzNHvIXc8R4syoCU6NLBpTQzzAlQxov9ta62xBxj79BExgATD
         kQ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dt3qYaO62X+ZEbQxXB68r8QffCjmTxoLCDw7qi1cczk=;
        b=ohqqVDJ5Zgvhbr65fNQq7Dt88s0pjtTJGji4mK5hV3w/kJNrl+RySHXRj5p3ab2fWc
         DsN8sfrjemFw3FTJ54/QwAv1Zjlkj/BsJnnDxUbUqMm5qIBLh5tyahMNbsGNgGLKJ1Zz
         SFTk5yfIF51GYi5jecDoOD0xppIo+T+6g+LXxqAxxfvHB9eUq/SAr5d2Mekb14GeXF7o
         Bq92w6F8dJFsf7Jl+knPFbrzOAtfthW63S/uI9iwzk4vvN7SpCiqxDWCKOy6nze1tPyN
         sadDqxk91PBcHfV9WKifwl/G7DqIbQig4el4iPCcmOwXXuyjz/jD6oOddPHVRcssFZg2
         +x+Q==
X-Gm-Message-State: APjAAAWZHyJrkOeL3TLmE5tlQ2nGyk0iWpyp0QYYYuZQHi6JFxsCYTUw
        zO1myraJVBBZ+nGUTzgkGUejy64/yxet1p327aw=
X-Google-Smtp-Source: APXvYqyF3IDCvr5ttHLwMb+nxnfGEYiOGnd4g4WexzuzClHXH2q68JEt2V25KOHCxq+Fvpw5oKJ95NrcvBies0R7NJ0=
X-Received: by 2002:a37:4c13:: with SMTP id z19mr20217882qka.449.1572323827951;
 Mon, 28 Oct 2019 21:37:07 -0700 (PDT)
MIME-Version: 1.0
References: <20191028122902.9763-1-iii@linux.ibm.com>
In-Reply-To: <20191028122902.9763-1-iii@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 28 Oct 2019 21:36:56 -0700
Message-ID: <CAEf4BzajQL463pCogVAnX1H5Tg-+kj9p_-mAJs=n1r6OfZ2mXg@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: allow narrow loads of bpf_sysctl fields with
 offset > 0
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Andrey Ignatov <rdna@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 28, 2019 at 1:09 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> "ctx:file_pos sysctl:read read ok narrow" works on s390 by accident: it
> reads the wrong byte, which happens to have the expected value of 0.
> Improve the test by seeking to the 4th byte and expecting 4 instead of
> 0.
>
> This makes the latent problem apparent: the test attempts to read the
> first byte of bpf_sysctl.file_pos, assuming this is the least-significant
> byte, which is not the case on big-endian machines: a non-zero offset is
> needed.
>
> The point of the test is to verify narrow loads, so we cannot cheat our
> way out by simply using BPF_W. The existence of the test means that such
> loads have to be supported, most likely because llvm can generate them.
> Fix the test by adding a big-endian variant, which uses an offset to
> access the least-significant byte of bpf_sysctl.file_pos.
>
> This reveals the final problem: verifier rejects accesses to bpf_sysctl
> fields with offset > 0. Such accesses are already allowed for a wide
> range of structs: __sk_buff, bpf_sock_addr and sk_msg_md to name a few.
> Extend this support to bpf_sysctl by using bpf_ctx_range instead of
> offsetof when matching field offsets.
>
> Fixes: 7b146cebe30c ("bpf: Sysctl hook")
> Fixes: e1550bfe0de4 ("bpf: Add file_pos field to bpf_sysctl ctx")
> Fixes: 9a1027e52535 ("selftests/bpf: Test file_pos field in bpf_sysctl ctx")
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  kernel/bpf/cgroup.c                       | 4 ++--
>  tools/testing/selftests/bpf/test_sysctl.c | 8 +++++++-
>  2 files changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index ddd8addcdb5c..a3eaf08e7dd3 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -1311,12 +1311,12 @@ static bool sysctl_is_valid_access(int off, int size, enum bpf_access_type type,
>                 return false;
>
>         switch (off) {
> -       case offsetof(struct bpf_sysctl, write):
> +       case bpf_ctx_range(struct bpf_sysctl, write):


this will actually allow reads pas t write field (e.g., offset = 2, size = 4).

>                 if (type != BPF_READ)
>                         return false;
>                 bpf_ctx_record_field_size(info, size_default);
>                 return bpf_ctx_narrow_access_ok(off, size, size_default);
> -       case offsetof(struct bpf_sysctl, file_pos):
> +       case bpf_ctx_range(struct bpf_sysctl, file_pos)

this will allow read past context struct altogether. When we allow
ranges, we will have to adjust allowed read size.

>                 if (type == BPF_READ) {
>                         bpf_ctx_record_field_size(info, size_default);
>                         return bpf_ctx_narrow_access_ok(off, size, size_default);
> diff --git a/tools/testing/selftests/bpf/test_sysctl.c b/tools/testing/selftests/bpf/test_sysctl.c
> index a320e3844b17..7c6e5b173f33 100644
> --- a/tools/testing/selftests/bpf/test_sysctl.c
> +++ b/tools/testing/selftests/bpf/test_sysctl.c
> @@ -161,9 +161,14 @@ static struct sysctl_test tests[] = {
>                 .descr = "ctx:file_pos sysctl:read read ok narrow",
>                 .insns = {
>                         /* If (file_pos == X) */
> +#if __BYTE_ORDER == __LITTLE_ENDIAN
>                         BPF_LDX_MEM(BPF_B, BPF_REG_7, BPF_REG_1,
>                                     offsetof(struct bpf_sysctl, file_pos)),
> -                       BPF_JMP_IMM(BPF_JNE, BPF_REG_7, 0, 2),
> +#else
> +                       BPF_LDX_MEM(BPF_B, BPF_REG_7, BPF_REG_1,
> +                                   offsetof(struct bpf_sysctl, file_pos) + 3),
> +#endif
> +                       BPF_JMP_IMM(BPF_JNE, BPF_REG_7, 4, 2),
>
>                         /* return ALLOW; */
>                         BPF_MOV64_IMM(BPF_REG_0, 1),
> @@ -176,6 +181,7 @@ static struct sysctl_test tests[] = {
>                 .attach_type = BPF_CGROUP_SYSCTL,
>                 .sysctl = "kernel/ostype",
>                 .open_flags = O_RDONLY,
> +               .seek = 4,
>                 .result = SUCCESS,
>         },
>         {
> --
> 2.23.0
>
