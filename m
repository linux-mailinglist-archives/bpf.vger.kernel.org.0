Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2F34A934E
	for <lists+bpf@lfdr.de>; Fri,  4 Feb 2022 06:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbiBDFT5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Feb 2022 00:19:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235223AbiBDFTy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Feb 2022 00:19:54 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33031C061714
        for <bpf@vger.kernel.org>; Thu,  3 Feb 2022 21:19:54 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id c188so6047167iof.6
        for <bpf@vger.kernel.org>; Thu, 03 Feb 2022 21:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EXfFGFiXtFbWokNUMjEY/wfAaXT573uUic8MqdhhUAw=;
        b=Dm1gZ3FLTG0kW1zfrrLCgZUVr9PUJTdbi56s/1dFtF6f7PPxoMaN9JHjnmVh2YY8d0
         qpYLlirssXXJ6//+teloypHuxLCx4XJ9vRkH8UGq43O8Va4U8POs/2JnI0vpd2v5Gpvc
         oCT6Lz660PMX5g/4yjh1njIVPlMuOut9TKChDTQxBHGdIx5LcE6fbwbyNomfznLFCrQn
         76f8UPvALLUcra3NP/xJlvpRrXO2bU8A3wFOt7ensbmziNEE7+cNCZ5t4K6nhw0wAaaA
         lD6hbp6Tb0JRfqxt4avlbUhValOmG33ZVGVnMiDWBa5YYTAlyQw8r0yv+WmrRDf6UiJl
         qabg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EXfFGFiXtFbWokNUMjEY/wfAaXT573uUic8MqdhhUAw=;
        b=5dd6OMO+r6N+Q5eavtP+ldW1QIWNSVaBxEql2wE1J0gRGsX7jZhZRgJqCmbu6mVtSm
         JWlQhx6DGGlBhG0Sap64ZGPOislEMhT+GWFGkpyt2rT6hO2fDAuPNZDRmyfUA1BMqVdZ
         /CKc8tdpR6X5nUEPadBtLdKI9GtM4fVH63BJLl66Rp4/vRZniAxU/o65BD7vMKojIq1I
         i/vEfyD3kuoFPgUgh9T2cQhXIjJ84PGVfreRapTG+KqjNAo0TcD4dj5ytP6/9OQfYBHk
         CyXqHpd66LCTYbn6dJYHGT2zmSekiK2VxB4LYz4ffGzbxSQlySftNVIVUIm7c5+q2aD4
         J0oQ==
X-Gm-Message-State: AOAM5323U2XvgU2J1JeCkWqZWYYIEvksCVYf0LQFCXhgGRGz+UQCnbWU
        BOIoxoJlFohM3bEUohnGxZnmenCozju0giK0Z34=
X-Google-Smtp-Source: ABdhPJxdwPuJ60uSC3+fdsbllpOAalkPDNm0+xysQ+lRNMihETfTZwtaaYpFarHdFJFy6b4CrITQzgfP+x+jj+efwSA=
X-Received: by 2002:a02:2422:: with SMTP id f34mr593599jaa.237.1643951993555;
 Thu, 03 Feb 2022 21:19:53 -0800 (PST)
MIME-Version: 1.0
References: <20220204041955.1958263-1-iii@linux.ibm.com> <20220204041955.1958263-3-iii@linux.ibm.com>
In-Reply-To: <20220204041955.1958263-3-iii@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 3 Feb 2022 21:19:42 -0800
Message-ID: <CAEf4BzYPdqLE152BZo2twbd9FkpG2vahOFqNM6eYXzdWzDUPLQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 02/10] s390/bpf: Add orig_gpr2 to user_pt_regs
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 3, 2022 at 8:20 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> user_pt_regs is used by eBPF in order to access userspace registers -
> see commit 466698e654e8 ("s390/bpf: correct broken uapi for
> BPF_PROG_TYPE_PERF_EVENT program type"). In order to access the first
> syscall argument from eBPF programs, we need to export orig_gpr2.
>
> args member is not in use since commit 56e62a737028 ("s390: convert to
> generic entry"), so move orig_gpr2 in its place.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  arch/s390/include/asm/ptrace.h      | 3 +--
>  arch/s390/include/uapi/asm/ptrace.h | 2 +-
>  2 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/arch/s390/include/asm/ptrace.h b/arch/s390/include/asm/ptrace.h
> index 4ffa8e7f0ed3..0278bacd61be 100644
> --- a/arch/s390/include/asm/ptrace.h
> +++ b/arch/s390/include/asm/ptrace.h
> @@ -80,12 +80,11 @@ struct pt_regs {
>         union {
>                 user_pt_regs user_regs;
>                 struct {
> -                       unsigned long args[1];
> +                       unsigned long orig_gpr2;
>                         psw_t psw;
>                         unsigned long gprs[NUM_GPRS];
>                 };
>         };
> -       unsigned long orig_gpr2;

Please don't change the physical location of this field, it
effectively breaks libbpf's syscall tracing macro on all older
kernels. Let's do what you did in the previous revision and just
expose the field at its correct offset. That way with up to date UAPI
header or vmlinux.h all this will work even on old kernels (even
without CO-RE).

>         union {
>                 struct {
>                         unsigned int int_code;
> diff --git a/arch/s390/include/uapi/asm/ptrace.h b/arch/s390/include/uapi/asm/ptrace.h
> index ad64d673b5e6..d0cc737b8151 100644
> --- a/arch/s390/include/uapi/asm/ptrace.h
> +++ b/arch/s390/include/uapi/asm/ptrace.h
> @@ -292,7 +292,7 @@ typedef struct {
>   * the in-kernel pt_regs structure to user space.
>   */
>  typedef struct {
> -       unsigned long args[1];
> +       unsigned long orig_gpr2;
>         psw_t psw;
>         unsigned long gprs[NUM_GPRS];
>  } user_pt_regs;
> --
> 2.34.1
>
