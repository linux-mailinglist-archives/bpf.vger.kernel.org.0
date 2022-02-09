Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4EFC4AE981
	for <lists+bpf@lfdr.de>; Wed,  9 Feb 2022 06:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235585AbiBIFqM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Feb 2022 00:46:12 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:58788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236669AbiBIFjv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Feb 2022 00:39:51 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB380C00438B
        for <bpf@vger.kernel.org>; Tue,  8 Feb 2022 21:39:49 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id m8so844530ilg.7
        for <bpf@vger.kernel.org>; Tue, 08 Feb 2022 21:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lxnioln6o+F7clc5D4CXpZgXwRHr0MI68/7pSnQ50Gs=;
        b=McwurSd7SQeof7Spy/1Q4edxuMql/ZWi/i08hUz+n0CrNpE298+HO+CmUEXblNTzoE
         ac87iCIbJXpZHgPAqHS5pxxXJmg4hSc9jaPDZeSRE8zk0mmAep4Djq2A5ic9lE05x+GW
         cCiev/9Y0ITOZoBhYgQpQBJ3w+a+vNCI0kq3/eXGneHWAmTo1kYYsPBsnbETlmlXKTik
         6fyXVV9+GxWuPMu0PEn3eekMOhC6ySiqerEcCbORoCLoCwxkQ81+Ll/6bReoenj6cJai
         uy282lIp/zEJ0zyuLWdf+SMR62blOCqxCGC6qdxekh3hHrWmrpGVDp9zKWljdbsX/za/
         WLmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lxnioln6o+F7clc5D4CXpZgXwRHr0MI68/7pSnQ50Gs=;
        b=oB4qmF5e7imveVy6D8jNOGWW4TI5017Ac3XpczZhwe6ZFjG91otRiU8FoAMkmFZ5xx
         qp37yR28zeOdW0mg+ZfIh1dK/PT/u3l7DkaxYyyqy7PRXjzTWtneBB1T2ij5AGhpal+C
         Dixlf/y9B1ouzBW6WoMY6GZTyRsEYVVLmJqew7WkbLXsyAPFK1KZ+dXZSwzUOzO6oAqP
         PeAopB8bUPTPsj9BLIDzPSiYFkM2vo6ZLvWyFLWH0CEwwlvrnzI+/DeM5O1QU+EJ7SX5
         uHU208GvlX7MFlmSdlkZ3F098F3zN4nWa/X/JcqbdGIjZCZ/3hg5wEqwYzquUuaw+zZq
         l2Tw==
X-Gm-Message-State: AOAM53278h5jQKgkVIwKfaiHZNxacOtIYxKVQWK5Cq6jzyrXupwKLWn1
        U+ZT9uuRQ5FUVwSwYji+PYIo6tNj/WeRFE1sbbg=
X-Google-Smtp-Source: ABdhPJzPp4K104g7x7PxGUctGaTDPSmviH1lWrKCIexnTj7V6X439Z1v4DQTGFHqC1Em4jYYJD6wYiQHllq9pCppRc0=
X-Received: by 2002:a05:6e02:1b81:: with SMTP id h1mr330005ili.239.1644385186634;
 Tue, 08 Feb 2022 21:39:46 -0800 (PST)
MIME-Version: 1.0
References: <20220209021745.2215452-1-iii@linux.ibm.com> <20220209021745.2215452-10-iii@linux.ibm.com>
In-Reply-To: <20220209021745.2215452-10-iii@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 8 Feb 2022 21:39:35 -0800
Message-ID: <CAEf4BzYunGCapVMZVFznh_qsRmOPdunvk2ZZfJOVVo29vrZwOw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 09/10] libbpf: Fix accessing the first syscall
 argument on arm64
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 8, 2022 at 6:18 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> On arm64, the first syscall argument should be accessed via orig_x0
> (see arch/arm64/include/asm/syscall.h). Currently regs[0] is used
> instead, leading to bpf_syscall_macro test failure.
>
> orig_x0 cannot be added to struct user_pt_regs, since its layout is a
> part of the ABI. Therefore provide access to it only through
> PT_REGS_PARM1_CORE_SYSCALL() by using a struct pt_regs flavor.
>
> Reported-by: Heiko Carstens <hca@linux.ibm.com>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  tools/lib/bpf/bpf_tracing.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
> index f364f1f4710e..928f85f7961c 100644
> --- a/tools/lib/bpf/bpf_tracing.h
> +++ b/tools/lib/bpf/bpf_tracing.h
> @@ -142,8 +142,18 @@
>
>  #elif defined(bpf_target_arm64)
>
> +struct pt_regs___arm64 {
> +       unsigned long orig_x0;
> +} __attribute__((preserve_access_index));
> +

I just realized that this will probably break anyone who's using old
Clang to compile a non-CORE BPF program because preserve_access_index
attribute will be unknown.

But we don't have to use __attribute__((preserve_access_index)) here,
because we use BPF_CORE_READ() in those macro, which will make
accesses CO-RE-relocatable anyways. So I dropped
__attribute__((preserve_access_index)) for better backwards
compatibility.

>  /* arm64 provides struct user_pt_regs instead of struct pt_regs to userspace */
>  #define __PT_REGS_CAST(x) ((const struct user_pt_regs *)(x))
> +#define PT_REGS_PARM1_SYSCALL(x) ({ \
> +       _Pragma("GCC error \"PT_REGS_PARM1_SYSCALL() is not supported on arm64, use PT_REGS_PARM1_CORE_SYSCALL() instead\""); \
> +       0l; \
> +})

I shortened message to just "use PT_REGS_PARM1_CORE_SYSCALL() instead"
and made it into a single-liner

> +#define PT_REGS_PARM1_CORE_SYSCALL(x) \
> +       BPF_CORE_READ((const struct pt_regs___arm64 *)(x), orig_x0)

also made this into a single-liner


>  #define __PT_PARM1_REG regs[0]
>  #define __PT_PARM2_REG regs[1]
>  #define __PT_PARM3_REG regs[2]
> --
> 2.34.1
>
