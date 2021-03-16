Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E388733CCD5
	for <lists+bpf@lfdr.de>; Tue, 16 Mar 2021 06:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234188AbhCPFCa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Mar 2021 01:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234119AbhCPFCI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Mar 2021 01:02:08 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194AEC06174A
        for <bpf@vger.kernel.org>; Mon, 15 Mar 2021 22:02:08 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id p186so35576099ybg.2
        for <bpf@vger.kernel.org>; Mon, 15 Mar 2021 22:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xmk8G674Tvz1ywom1Bf/Rk/GM7DtFhEi5Hpsi1JmMG8=;
        b=bqI/vmNauSUOABJFyPNlJAm7KDDelKvb6sG7GDwyWg3aCHb4nnyTdWq32PQGfY/iyP
         V8LQ+rzgifQi2PBBfuqtooX1yApI4/U3u9dYVFO1+uZmYS8PKq7mCIDaSmVkHVfuhgVI
         OjnsyWV+tR6WHGwvJotrNLAig4RCgUTWoeqxmNYH6h5g4f4pVpbh57B/PblzadXAkvtt
         xVfh20HfJ/52wZ5nGGQ75fCj5rHgrLcu4mdiDWppfl0VDBeXFY/XymmduFkAasICkjYL
         6N/eiP/WbzvN8gOQMm7d3JKYD73/a2gGD3oaqt9qMG3xyKumStOhcIIfcsR1+WfmxK3P
         qL9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xmk8G674Tvz1ywom1Bf/Rk/GM7DtFhEi5Hpsi1JmMG8=;
        b=J49FUnHIB2/5oRMtUWXc3Sslja5sDJL1fl977/ebKc4RMkM9L1WibruF3q4bNpihbh
         pGcIh5Sj4egDZZmQh6DdAorT/6S7zorXah8A7kJs9VjNbxryLfcWD6zVL3S9hUZsBki7
         w6yljwsfI0aLgTnNhS+2n8c1TzVVLH7pdP3APHt7AlNFDvmFt/D7lbvfDVS4adn80vWs
         2HQpTZn32MHGSdfUvrfrUEsV2Ot10SnGyzcWwA4T4fTneLMzGXlLlJdID4WaKGAA3ryO
         QzYr96PD6IMhurcu+e83RbRH2Ej7F8n7DQ13PyUPPRiNjtUqMepfXlPtHsexC4UX3SXD
         u3tA==
X-Gm-Message-State: AOAM533CGPPgboHK92aXeHeDvnbccF1BMutEx1XZPQTjBIu4c6J9KaFH
        XgP2k5o+Uyiu8f+HWvzOKGu5uEdRbVcww63QANU=
X-Google-Smtp-Source: ABdhPJzaeh+FApGViDnLcHcQoPk71NWhd6HakPH6N+tISMfU5+aTVaLQyXuzAcxRNPPj7VHZLnVbBevdSIpIZ9Td3Cc=
X-Received: by 2002:a25:874c:: with SMTP id e12mr4304682ybn.403.1615870927313;
 Mon, 15 Mar 2021 22:02:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210314035812.1958641-1-yhs@fb.com>
In-Reply-To: <20210314035812.1958641-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 15 Mar 2021 22:01:56 -0700
Message-ID: <CAEf4BzZcFGmvmXS18CBq5obxAtJSeqJyHmMgL2r5g4iZpE3-Tw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: net: emit anonymous enum with BPF_TCP_CLOSE
 value explicitly
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Mar 13, 2021 at 8:15 PM Yonghong Song <yhs@fb.com> wrote:
>
> The selftest failed to compile with clang-built bpf-next.
> Adding LLVM=1 to your vmlinux and selftest build will use clang.
> The error message is:
>   progs/test_sk_storage_tracing.c:38:18: error: use of undeclared identifier 'BPF_TCP_CLOSE'
>           if (newstate == BPF_TCP_CLOSE)
>                           ^
>   1 error generated.
>   make: *** [Makefile:423: /bpf-next/tools/testing/selftests/bpf/test_sk_storage_tracing.o] Error 1
>
> The reason for the failure is that BPF_TCP_CLOSE, a value of
> an anonymous enum defined in uapi bpf.h, is not defined in
> vmlinux.h. gcc does not have this problem. Since vmlinux.h
> is derived from BTF which is derived from vmlinux dwarf,
> that means gcc-produced vmlinux dwarf has BPF_TCP_CLOSE
> while llvm-produced vmlinux dwarf does not have.
>
> BPF_TCP_CLOSE is referenced in net/ipv4/tcp.c as
>   BUILD_BUG_ON((int)BPF_TCP_CLOSE != (int)TCP_CLOSE);
> The following test mimics the above BUILD_BUG_ON, preprocessed
> with clang compiler, and shows gcc dwarf contains BPF_TCP_CLOSE while
> llvm dwarf does not.
>
>   $ cat t.c
>   enum {
>     BPF_TCP_ESTABLISHED = 1,
>     BPF_TCP_CLOSE = 7,
>   };
>   enum {
>     TCP_ESTABLISHED = 1,
>     TCP_CLOSE = 7,
>   };
>
>   int test() {
>     do {
>       extern void __compiletime_assert_767(void) ;
>       if ((int)BPF_TCP_CLOSE != (int)TCP_CLOSE) __compiletime_assert_767();
>     } while (0);
>     return 0;
>   }
>   $ clang t.c -O2 -c -g && llvm-dwarfdump t.o | grep BPF_TCP_CLOSE
>   $ gcc t.c -O2 -c -g && llvm-dwarfdump t.o | grep BPF_TCP_CLOSE
>                     DW_AT_name    ("BPF_TCP_CLOSE")
>
> Further checking clang code find clang actually tried to
> evaluate condition at compile time. If it is definitely
> true/false, it will perform optimization and the whole if condition
> will be removed before generating IR/debuginfo.
>
> This patch explicited add an expression like
>   (void)BPF_TCP_ESTABLISHED
> to enable generation of debuginfo for the anonymous
> enum which also includes BPF_TCP_CLOSE. I put
> this explicit type generation in kernel/bpf/core.c
> to (1) avoid polute net/ipv4/tcp.c and more importantly
> (2) provide a central place to add other types (e.g. in
> bpf/btf uapi header) if they are not referenced in the kernel
> or generated in vmlinux dwarf.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---

Acked-by: Andrii Nakryiko <andrii@kernel.org>

But given

$ rg '\sdwarf\s' | wc -l
33
$ rg '\sDWARF\s' | wc -l
151

we should probably stick to using "DWARF", not "dwarf", everywhere.


>  include/linux/btf.h |  1 +
>  kernel/bpf/core.c   | 19 +++++++++++++++++++
>  2 files changed, 20 insertions(+)
>
> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index 7fabf1428093..9c1b52738bbe 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -9,6 +9,7 @@
>  #include <uapi/linux/bpf.h>
>
>  #define BTF_TYPE_EMIT(type) ((void)(type *)0)
> +#define BTF_TYPE_EMIT_ENUM(enum_val) ((void)enum_val)
>
>  struct btf;
>  struct btf_member;
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 3a283bf97f2f..60551bf68ece 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -2378,3 +2378,22 @@ EXPORT_SYMBOL(bpf_stats_enabled_key);
>
>  EXPORT_TRACEPOINT_SYMBOL_GPL(xdp_exception);
>  EXPORT_TRACEPOINT_SYMBOL_GPL(xdp_bulk_tx);
> +
> +static int __init bpf_emit_btf_type(void)
> +{
> +       /* bpf uapi header bpf.h defines an anonymous enum with values
> +        * BPF_TCP_* used by bpf programs. Currently gcc built vmlinux
> +        * is able to emit this enum in dwarf due to the following
> +        * BUILD_BUG_ON test in net/ipv4/tcp.c:
> +        *   BUILD_BUG_ON((int)BPF_TCP_ESTABLISHED != (int)TCP_ESTABLISHED);
> +        * clang built vmlinux does not have this enum in dwarf
> +        * since clang removes the above code before generating IR/debuginfo.
> +        * Let us explicitly emit the type debuginfo to ensure the
> +        * above-mentioned anonymous enum in the vmlinux dwarf and hence BTF
> +        * regardless of which compiler is used.
> +        */
> +       BTF_TYPE_EMIT_ENUM(BPF_TCP_ESTABLISHED);
> +
> +       return 0;
> +}
> +late_initcall(bpf_emit_btf_type);
> --
> 2.24.1
>
