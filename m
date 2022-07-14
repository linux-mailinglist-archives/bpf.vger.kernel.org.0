Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B62F575508
	for <lists+bpf@lfdr.de>; Thu, 14 Jul 2022 20:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbiGNSb4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jul 2022 14:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236398AbiGNSbz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jul 2022 14:31:55 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3707E6B251
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 11:31:55 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id f9-20020a636a09000000b00401b6bc63beso1587117pgc.23
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 11:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=YuEHgJRegsAyHrPIvB+gL2ryFRD2sbKf8M5LMEWXcXo=;
        b=cNcg3MiG48AkRQ2kDyrWS6idmc7DZ1ywga69psUUkB9nqWCW/88l+WeT4bfkQpp1li
         2hj148uAox+bLt7jXlcWzN7MWEy3ctClh8SoGGqwjugwS9BsXwuIdE8yn1MnQj+2fILI
         loW/ch3C60EDRx52JWNK3BvRnCDDlpMkVaPb2RvZN2InP20hat/4rfE7tvlII8RXk8rR
         MfKbzQQGN34PDQZ+oWDYbrn+l1xckvhE4pLe+qnqD+lXvlJ0Yp9MnG8E+fymOWYclyJ0
         OBi270kd1AjWOqmmdCxaocbuolE6Oy8EMXEmzE7q/cmSpSJynMYBWEAhd8qLN6Ny66z8
         y9Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YuEHgJRegsAyHrPIvB+gL2ryFRD2sbKf8M5LMEWXcXo=;
        b=LGkY5wMK001/V3DJEGrY8fa1hiFyiWda4F5ja1JHTFXqdzRtH6TQH9tfx2YkCGzrIc
         ecpKJQEMZgWaqLySExfOHu3qdBhWowGuZZEzLWbP5xvQ/vvCZ++bRG4MbCMBLuYivbYQ
         TG1WMjaxwBg+PSN33Fzi9SuMR9rk33ZjReh0cDQHHa+3RVyr49o383iqIOPpXMugqstk
         v+3q2GakhrWslKBPy18LBhexfuW+/oDPk/nkV0etXPuFKNApS37D2Wz4f+5yu3woODof
         Fqj/xpiant2fbiY4k7KYlSzBm/Fz57ojsu1JqfKlM47vEaxhf7tIaGxf9bEJd+88Q9D4
         6fQQ==
X-Gm-Message-State: AJIora90IYhmVejDQKPBthTG7qNkIpOhuiPhIL7DRmQKpLLdhdbYdNb+
        UoRqo6WoKO9sf8+3hFggUslSQqo=
X-Google-Smtp-Source: AGRyM1vUxYz7stW0nfxbUs+ZLUDV4mzAGisWBT0DQx6j8Ob8+DoAx/7n3D8TdMQ+sb0PY2KkjZRrThA=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:902:a413:b0:156:15b:524a with SMTP id
 p19-20020a170902a41300b00156015b524amr9817976plq.106.1657823514732; Thu, 14
 Jul 2022 11:31:54 -0700 (PDT)
Date:   Thu, 14 Jul 2022 11:31:53 -0700
In-Reply-To: <20220714070755.3235561-1-andrii@kernel.org>
Message-Id: <YtBhGSRqFckLewHQ@google.com>
Mime-Version: 1.0
References: <20220714070755.3235561-1-andrii@kernel.org>
Subject: Re: [PATCH v2 bpf-next 0/5] Add SEC("ksyscall") support
From:   sdf@google.com
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 07/14, Andrii Nakryiko wrote:
> Add SEC("ksyscall")/SEC("kretsyscall") sections and corresponding
> bpf_program__attach_ksyscall() API that simplifies tracing kernel syscalls
> through kprobe mechanism. Kprobing syscalls isn't trivial due to varying
> syscall handler names in the kernel and various ways syscall argument are
> passed, depending on kernel architecture and configuration.  
> SEC("ksyscall")
> allows user to not care about such details and just get access to syscall
> input arguments, while libbpf takes care of necessary feature detection  
> logic.

> There are still more quirks that are not straightforward to hide  
> completely
> (see comments about mmap(), clone() and compat syscalls), so in such more
> advanced scenarios user might need to fall back to plain SEC("kprobe")
> approach, but for absolute majority of users SEC("ksyscall") is a big
> improvement.

> As part of this patch set libbpf adds two more virtual __kconfig externs,  
> in
> addition to existing LINUX_KERNEL_VERSION: LINUX_HAS_BPF_COOKIE and
> LINUX_HAS_SYSCALL_WRAPPER, which let's libbpf-provided BPF-side code  
> minimize
> external dependencies and assumptions and let's user-space part of libbpf  
> to
> perform all the feature detection logic. This benefits USDT support code,
> which now doesn't depend on BPF CO-RE for its functionality.

> v1->v2:
>    - normalize extern variable-related warn and debug message formats  
> (Alan);

For the series:

Reviewed-by: Stanislav Fomichev <sdf@google.com>

> rfc->v1:
>    - drop dependency on kallsyms and speed up SYSCALL_WRAPPER detection  
> (Alexei);
>    - drop dependency on /proc/config.gz in bpf_tracing.h (Yaniv);
>    - add doc comment and ephasize mmap(), clone() and compat quirks that  
> are
>      not supported (Ilya);
>    - use mechanism similar to LINUX_KERNEL_VERSION to also improve USDT  
> code.

> Andrii Nakryiko (5):
>    libbpf: generalize virtual __kconfig externs and use it for USDT
>    selftests/bpf: add test of __weak unknown virtual __kconfig extern
>    libbpf: improve BPF_KPROBE_SYSCALL macro and rename it to BPF_KSYSCALL
>    libbpf: add ksyscall/kretsyscall sections support for syscall kprobes
>    selftests/bpf: use BPF_KSYSCALL and SEC("ksyscall") in selftests

>   tools/lib/bpf/bpf_tracing.h                   |  51 +++--
>   tools/lib/bpf/libbpf.c                        | 214 ++++++++++++++----
>   tools/lib/bpf/libbpf.h                        |  46 ++++
>   tools/lib/bpf/libbpf.map                      |   1 +
>   tools/lib/bpf/libbpf_internal.h               |   2 +
>   tools/lib/bpf/usdt.bpf.h                      |  16 +-
>   .../selftests/bpf/prog_tests/core_extern.c    |  17 +-
>   .../selftests/bpf/progs/bpf_syscall_macro.c   |   6 +-
>   .../selftests/bpf/progs/test_attach_probe.c   |  15 +-
>   .../selftests/bpf/progs/test_core_extern.c    |   3 +
>   .../selftests/bpf/progs/test_probe_user.c     |  27 +--
>   11 files changed, 289 insertions(+), 109 deletions(-)

> --
> 2.30.2

