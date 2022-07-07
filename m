Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5857E56A978
	for <lists+bpf@lfdr.de>; Thu,  7 Jul 2022 19:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235621AbiGGRX3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Jul 2022 13:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbiGGRX3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Jul 2022 13:23:29 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA664B84C
        for <bpf@vger.kernel.org>; Thu,  7 Jul 2022 10:23:25 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id dn9so28310306ejc.7
        for <bpf@vger.kernel.org>; Thu, 07 Jul 2022 10:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wty8G9WkwyIvTb5RAPtWrd8NyvjfSyzmM6P4NGQpdSw=;
        b=cDNXcjMBaPnuqNcSurTDJzsTFBJoEknxhxy9Hi4pn2W5mUm9BE4fS2cjjYk3aG+m13
         kmRu0yJANXD2+UEDrHcsy8P2CGOrBz0R2WWrCEga3vyPCl6ODONFAGWqrxC7+zZYp3Wo
         0hIhEOHe8el9pvMXXScDn7ol1FET3CnlMCytgZUsgunjxwWW8dQ6pIE8xj9R1fgFDIyG
         XfVkRrnHLAYVv1vDQ0SvAJRy6TQcDYd6abz1UsnC1tiy4lrrg3/t0dO2BbXyuuekv59o
         DhlHgYJZwPUAeS7cDor2nCX0yK7Sp/ZRbGUPRf5zmWbThnPGE5w0KnbAsma86vdE8mL9
         xESg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wty8G9WkwyIvTb5RAPtWrd8NyvjfSyzmM6P4NGQpdSw=;
        b=XCBnN5H8uUiU1jKFjx+OyPUtxtIlqjCmTVdRU3Bqgm44aubg2AplUuct4K5IQqTuvO
         YOHXVHM0Ns8PqBZgzlljuPtIp73vadDFGn4Xjp5x9+2m+O7FsJO0mMh6GZZtHokj0k7L
         C31L/zTWgzG4flT+3D1LfXeKo7PeYvFW1BEjXlJUJ4F++3jMp2H6y4stZDrluLNKJxj9
         WXUzdWKdXwj3CafYET7SQCSywqo6GFi+gUH3t9+0t7ZpsowPvms7F03p10m5HqI7qg3S
         C6NV5jMKrbzRA6OfIjIx+269AxHL5m7+ZHNf/bHpcH/ZA9Jl8/3gn9Q6CY3Fhwpq9Mg1
         tABw==
X-Gm-Message-State: AJIora8i22eY2Rb96/tnT6zMBW9mDaks+peZ659iPBhoRWPZ7vo86PMy
        SzsDb/h33QhOLDRe1VuYLSSi2fYU8kabeDMtcRU=
X-Google-Smtp-Source: AGRyM1tHCNCUdlwKq66QLKUTE+dTnvU/gFFN/kQxOL0g4ahvFUTduZiTaUtJBmIFxv8Rs2JuxL9cZ4p2FUpEF/S2LcM=
X-Received: by 2002:a17:907:6e03:b0:726:a6a3:7515 with SMTP id
 sd3-20020a1709076e0300b00726a6a37515mr46998017ejc.676.1657214604293; Thu, 07
 Jul 2022 10:23:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220707004118.298323-1-andrii@kernel.org> <20220707004118.298323-3-andrii@kernel.org>
In-Reply-To: <20220707004118.298323-3-andrii@kernel.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 7 Jul 2022 10:23:12 -0700
Message-ID: <CAADnVQLxWDD3AAp73BcXW4ArWMgJ-fSUzSjw=-gzq=azBrXdqA@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 2/3] libbpf: add ksyscall/kretsyscall
 sections support for syscall kprobes
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Kenta Tada <kenta.tada@sony.com>,
        Hengqi Chen <hengqi.chen@gmail.com>
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

On Wed, Jul 6, 2022 at 5:41 PM Andrii Nakryiko <andrii@kernel.org> wrote:
>
> Add SEC("ksyscall")/SEC("ksyscall/<syscall_name>") and corresponding
> kretsyscall variants (for return kprobes) to allow users to kprobe
> syscall functions in kernel. These special sections allow to ignore
> complexities and differences between kernel versions and host
> architectures when it comes to syscall wrapper and corresponding
> __<arch>_sys_<syscall> vs __se_sys_<syscall> differences, depending on
> CONFIG_ARCH_HAS_SYSCALL_WRAPPER.
>
> Combined with the use of BPF_KSYSCALL() macro, this allows to just
> specify intended syscall name and expected input arguments and leave
> dealing with all the variations to libbpf.
>
> In addition to SEC("ksyscall+") and SEC("kretsyscall+") add
> bpf_program__attach_ksyscall() API which allows to specify syscall name
> at runtime and provide associated BPF cookie value.
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  tools/lib/bpf/libbpf.c          | 109 ++++++++++++++++++++++++++++++++
>  tools/lib/bpf/libbpf.h          |  16 +++++
>  tools/lib/bpf/libbpf.map        |   1 +
>  tools/lib/bpf/libbpf_internal.h |   2 +
>  4 files changed, 128 insertions(+)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index cb49408eb298..4749fb84e33d 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -4654,6 +4654,65 @@ static int probe_kern_btf_enum64(void)
>                                              strs, sizeof(strs)));
>  }
>
> +static const char *arch_specific_syscall_pfx(void)
> +{
> +#if defined(__x86_64__)
> +       return "x64";
> +#elif defined(__i386__)
> +       return "ia32";
> +#elif defined(__s390x__)
> +       return "s390x";
> +#elif defined(__s390__)
> +       return "s390";
> +#elif defined(__arm__)
> +       return "arm";
> +#elif defined(__aarch64__)
> +       return "arm64";
> +#elif defined(__mips__)
> +       return "mips";
> +#elif defined(__riscv)
> +       return "riscv";
> +#else
> +       return NULL;
> +#endif
> +}
> +
> +static int probe_kern_syscall_wrapper(void)
> +{
> +       /* available_filter_functions is a few times smaller than
> +        * /proc/kallsyms and has simpler format, so we use it as a faster way
> +        * to check that __<arch>_sys_bpf symbol exists, which is a sign that
> +        * kernel was built with CONFIG_ARCH_HAS_SYSCALL_WRAPPER and uses
> +        * syscall wrappers
> +        */
> +       static const char *kprobes_file = "/sys/kernel/tracing/available_filter_functions";
> +       char func_name[128], syscall_name[128];
> +       const char *ksys_pfx;
> +       FILE *f;
> +       int cnt;
> +
> +       ksys_pfx = arch_specific_syscall_pfx();
> +       if (!ksys_pfx)
> +               return 0;
> +
> +       f = fopen(kprobes_file, "r");
> +       if (!f)
> +               return 0;
> +
> +       snprintf(syscall_name, sizeof(syscall_name), "__%s_sys_bpf", ksys_pfx);
> +
> +       /* check if bpf() syscall wrapper is listed as possible kprobe */
> +       while ((cnt = fscanf(f, "%127s%*[^\n]\n", func_name)) == 1) {
> +               if (strcmp(func_name, syscall_name) == 0) {
> +                       fclose(f);
> +                       return 1;
> +               }
> +       }

Maybe we should do the other way around ?
cat /proc/kallsyms |grep sys_bpf

and figure out the prefix from there?
Then we won't need to do giant
#if defined(__x86_64__)
...

/proc/kallsyms has world read permissions:
proc_create("kallsyms", 0444, NULL, &kallsyms_proc_ops);
unlike available_filter_functions.

Also tracefs might be mounted in a different dir than
/sys/kernel/tracing/
like
/sys/kernel/debug/tracing/
