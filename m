Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C03294C805A
	for <lists+bpf@lfdr.de>; Tue,  1 Mar 2022 02:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbiCABcG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Feb 2022 20:32:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiCABcG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Feb 2022 20:32:06 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EAC8F06
        for <bpf@vger.kernel.org>; Mon, 28 Feb 2022 17:31:26 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id c14so11477564ilm.4
        for <bpf@vger.kernel.org>; Mon, 28 Feb 2022 17:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nfMGmIM5IGKijbqJ0tS1UtYJj2PiFYUavVKp3kozVyk=;
        b=S7XsyhrGMOW8Mwrj15giRJ2JSWrUK1/vXBExyCAYqZ34t9gOCEFP34jFQ8qhPRwULz
         nDWhp1WaBFmvonaBLUesT9+bfGWaPpRiT4bBTPSBhkkMv3B31el1AOhYznAESua9puMo
         LAE/bXE3t1sluak1BzQnFXlY4iMr6sgwXDj+0ReMP10Q1panQ8Tzy5UQQ10yousT6yCQ
         J7UiUE4N+4GEojYVa8+qaRqzZ+El2Ba3BMJR5ahOGHsfRu3g1MEdmSmuHy41VZ67FLPp
         o8hqW6JPpONM8I8trtEm8hAp6pfA/krhzoEjuLz1QnzdHRFOQrpEVpIpcuYm958DmGi7
         /hGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nfMGmIM5IGKijbqJ0tS1UtYJj2PiFYUavVKp3kozVyk=;
        b=Yr+XEnUfWHlb5PtG4/ovz+R3lwxljVy4/FsfuzpwOjHKPiLqoL78qhvF3YM5hreOAz
         4B7ucQaIVqnlkV7Wi2N2RowMct+jAFzgq7yoiSfWMNcksF14mNVZafbg9HowwAGHpVjT
         gdAMKnJwFLisgrKoMQxqtdOjLjV9dJ1g/DWWu9Js5vhXQ/X62lx8y3jvwOPq/b5ZDFNl
         5t2NpYsAgqSNOA6B2R3uYzifE8PHacH9zXXensc3hcySdiPjGJMmyaLD+wY9s8LkbmGA
         NuoZbq1W7lx7HvCElN0hqi8m86LbVaL3d1GTtXT7rJXq0HjUljMHArqNQ5z7ESHv3qVm
         JeFg==
X-Gm-Message-State: AOAM5319ZYEzLuywLr7nurQrcyZzzmm2q3JahUWLg2yrm1Rlq9bOYg9Z
        UQswTj+1MsaOUhfczIFlhi2krVAEsAGQuj5ns8M=
X-Google-Smtp-Source: ABdhPJylTXyJ8R20110SPOVqRCA6454p5fAE5jZyOpTmwaJKI175L0TJ8z3jbOFhp9/rGoh2scXFxNzZiwWAya1KWIE=
X-Received: by 2002:a92:ca0d:0:b0:2c2:a846:b05a with SMTP id
 j13-20020a92ca0d000000b002c2a846b05amr16759584ils.252.1646098285766; Mon, 28
 Feb 2022 17:31:25 -0800 (PST)
MIME-Version: 1.0
References: <20220224120943.1169985-1-xukuohai@huawei.com>
In-Reply-To: <20220224120943.1169985-1-xukuohai@huawei.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 28 Feb 2022 17:31:14 -0800
Message-ID: <CAEf4Bzaw3hDqrJ=sQVVjY-Gpjf90tWRpo-s2a_vFYTKWEe9qqw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/2] Fix btf dump error caused by declaration
To:     Xu Kuohai <xukuohai@huawei.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>, Shuah Khan <shuah@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>
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

On Thu, Feb 24, 2022 at 3:59 AM Xu Kuohai <xukuohai@huawei.com> wrote:
>
> This series fixes a btf dump error caused by forward declaration.
>
> Currently if a declaration appears in the BTF before the definition,
> the definition is dumped as a conflicting name, eg:
>
>     $ bpftool btf dump file vmlinux format raw | grep "'unix_sock'"
>     [81287] FWD 'unix_sock' fwd_kind=struct
>     [89336] STRUCT 'unix_sock' size=1024 vlen=14
>
>     $ bpftool btf dump file vmlinux format c | grep "struct unix_sock"
>     struct unix_sock;
>     struct unix_sock___2 {      <--- conflict, the "___2" is unexpected
>                     struct unix_sock___2 *unix_sk;
>
> This causes a "definition not found" compilation error if the dump output
> is used as a header file.
>

seems like I replied about test failures on v2 instead of v3 (there
are test failures for v3, though), please check the link in that
reply. But I wanted to also mention that it would be great to keep a
succinct version log in the cover letter with what was changed or
fixed between versions (see other submissions on the mailing list).

> Xu Kuohai (2):
>   libbpf: Skip forward declaration when counting duplicated type names
>   selftests/bpf: Update btf_dump case for conflicting names
>
>  tools/lib/bpf/btf_dump.c                      |  5 ++
>  .../selftests/bpf/prog_tests/btf_dump.c       | 54 ++++++++++++++-----
>  2 files changed, 46 insertions(+), 13 deletions(-)
>
> --
> 2.30.2
>
