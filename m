Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B244EF888
	for <lists+bpf@lfdr.de>; Fri,  1 Apr 2022 18:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236099AbiDARBR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 1 Apr 2022 13:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348620AbiDARBO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Apr 2022 13:01:14 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945C8144B4F
        for <bpf@vger.kernel.org>; Fri,  1 Apr 2022 09:59:24 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id p22so3909467iod.2
        for <bpf@vger.kernel.org>; Fri, 01 Apr 2022 09:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C+YLNJurNOipkUrSvWX6V1z1dh1C/9niv398TCpdwAw=;
        b=mR+/P9NTle3J85jnpi5ucG9QSuT1saDhUKWvngVyNOyaubWj0SRn0TkZh/ivhnOrlZ
         RMHFw7Y+7OWwsmCMkkxGYVPPyijTexPie5E94NqEgaJrEsK7YLTYyQnY3MAxNbf/Ulro
         E3QXGHHkhK7nWE+dZW2ciULwgOBUKLN0YWgvZusnh79Fs/xpMUAkvQx8t8xojI/PmB57
         F7IUZ9u2MFEQJOfXepP8h+zoY56JEx33ZztdnqKhVhqOG5gg2Hc+4nOtHNK7hNATFOe4
         bfS2QKfWE4G5P1eVRckBLlRDEOJMvaInrYCj9gD2eykCPqRN3J8uQxR9rnpyG+5XeKI7
         PYOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C+YLNJurNOipkUrSvWX6V1z1dh1C/9niv398TCpdwAw=;
        b=nhhNq0r90KnG/4Ctz2VcDzjHqRPzLKySJy6rA+WAw2J8HD7HPQ+s/zCLyyoUxf44qf
         lEn6zt4iSlO40roYFLk0ROK33tyFh2SK5ZRF7jo6d4SBjryE2uatH3UG5cm+uvJj0xMN
         iYdsZkdPPf2wslI7ydjo/OWntHBIec8q9sr/ZyltbyQN213HpU8PziED8ri5Oj6L0Hwt
         rV1byeELl9Es1xcEwrVIHPb5ZxAIvXE8dp4gusyp+Cx55YTQ66GivzJ3QBTaaGUnsA6D
         AO5lDsyjnvbpViTtjfhSmryv3uePXeh0VZNF4cHjcdl/izO7L4TxRddhv/fWxXSCmP4G
         QWAQ==
X-Gm-Message-State: AOAM531TyhVHgVHamKQg/6zGSRkuGild9JRqaVru/WDIWxcq731JZfQs
        qbaF+CEcobtERMgG2siF1VkCmtaJ1pATgoYEcZRgwqTD
X-Google-Smtp-Source: ABdhPJyxXeOgr5fWx6p98uAkLyNRwK3g52wpqZoTY0EG3dgvywodRTBdf118OcZHzdUPu6m4QpavnkBsqN66H2eps5o=
X-Received: by 2002:a6b:8bd7:0:b0:646:2804:5c73 with SMTP id
 n206-20020a6b8bd7000000b0064628045c73mr308143iod.112.1648832363803; Fri, 01
 Apr 2022 09:59:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220325052941.3526715-1-andrii@kernel.org> <20220325052941.3526715-8-andrii@kernel.org>
 <alpine.LRH.2.23.451.2203312310230.18524@MyRouter>
In-Reply-To: <alpine.LRH.2.23.451.2203312310230.18524@MyRouter>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 1 Apr 2022 09:59:13 -0700
Message-ID: <CAEf4BzYzwmwcRNkUywz_JW0LMCSgDB=D7ee9i19q6xN2QkekMQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 7/7] selftests/bpf: add urandom_read shared lib
 and USDTs
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
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

On Thu, Mar 31, 2022 at 3:14 PM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> On Fri, 25 Mar 2022, Andrii Nakryiko wrote:
>
> > Extend urandom_read helper binary to include USDTs of 4 combinations:
> > semaphore/semaphoreless (refcounted and non-refcounted) and based in
> > executable or shared library. We also extend urandom_read with ability
> > to report it's own PID to parent process and wait for parent process to
> > ready itself up for tracing urandom_read. We utilize popen() and
> > underlying pipe properties for proper signaling.
> >
> > Once urandom_read is ready, we add few tests to validate that libbpf's
> > USDT attachment handles all the above combinations of semaphore (or lack
> > of it) and static or shared library USDTs. Also, we validate that libbpf
> > handles shared libraries both with PID filter and without one (i.e., -1
> > for PID argument).
> >
> > Having the shared library case tested with and without PID is important
> > because internal logic differs on kernels that don't support BPF
> > cookies. On such older kernels, attaching to USDTs in shared libraries
> > without specifying concrete PID doesn't work in principle, because it's
> > impossible to determine shared library's load address to derive absolute
> > IPs for uprobe attachments. Without absolute IPs, it's impossible to
> > perform correct look up of USDT spec based on uprobe's absolute IP (the
> > only kind available from BPF at runtime). This is not the problem on
> > newer kernels with BPF cookie as we don't need IP-to-ID lookup because
> > BPF cookie value *is* spec ID.
> >
> > So having those two situations as separate subtests is good because
> > libbpf CI is able to test latest selftests against old kernels (e.g.,
> > 4.9 and 5.5), so we'll be able to disable PID-less shared lib attachment
> > for old kernels, but will still leave PID-specific one enabled to validate
> > this legacy logic is working correctly.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>
>
> haven't looked at this in depth yet, but hit a compilation error on
> aarch64:
>
>   LIB      liburandom_read.so
> /usr/bin/ld: /tmp/ccNy8cuv.o: relocation R_AARCH64_ADR_PREL_PG_HI21
> against symbol `urandlib_read_with_sema_semaphore' which may bind
> externally can not be used when making a shared object; recompile with
> -fPIC
> /tmp/ccNy8cuv.o: In function `urandlib_read_with_sema':
> /home/opc/src/bpf-next/tools/testing/selftests/bpf/urandom_read_lib1.c:12:(.text+0x10):
> dangerous relocation: unsupported relocation
> collect2: error: ld returned 1 exit status
> make: *** [Makefile:173:
> /home/opc/src/bpf-next/tools/testing/selftests/bpf/liburandom_read.so]
> Error 1
>
> following did fix it:
>
> diff --git a/tools/testing/selftests/bpf/Makefile
> b/tools/testing/selftests/bpf/Makefile
> index 58da22c019a8..c89e2948276b 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -170,7 +170,7 @@ $(OUTPUT)/%:%.c
>
>  $(OUTPUT)/liburandom_read.so: urandom_read_lib1.c urandom_read_lib2.c
>         $(call msg,LIB,,$@)
> -       $(Q)$(CC) $(CFLAGS) $(LDFLAGS) $^ $(LDLIBS) --shared -o $@
> +       $(Q)$(CC) $(CFLAGS) -fPIC $(LDFLAGS) $^ $(LDLIBS) --shared -o $@
>

Yep, forgot about -fPIC, thanks. Curious that it still works on x86 just fine :)

BTW, if you are interested in arm architecture, it would be great to
get some help to setup CI for ARMs. We have s390x and x86_64, it's a
great way to prevent lots of bugs. We just don't have anyone actively
supporting this for ARMs.

>  $(OUTPUT)/urandom_read: urandom_read.c urandom_read_aux.c
> $(OUTPUT)/liburandom_read.so
>         $(call msg,BINARY,,$@)
>
