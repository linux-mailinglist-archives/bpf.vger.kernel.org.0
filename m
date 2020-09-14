Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A60A22698C1
	for <lists+bpf@lfdr.de>; Tue, 15 Sep 2020 00:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbgINW0r (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Sep 2020 18:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbgINW0r (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Sep 2020 18:26:47 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C2AC06174A
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2020 15:26:45 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id v60so998312ybi.10
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2020 15:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sgXlMkvGS2uu79Bu/cAoPvNPYBIlXDtQ9rTO0QOZuWE=;
        b=HncWkbLFBxMXpgkNfWg1FMbgkU0jR+rK4wKFxSbWAJzcgYurJLEuVdne8hS69l3xf+
         EOvrtxYLoIyDZKn2oASL6XJCRY8oLyxiiQxCFYJlKjSVJ9JFMEJMBJ7N+z8swVccufpc
         0Pz8ryC/oKgHE5gD/QuwNAet3IEu7nA/Qnpue9eYDY8BjK+7FSowSjHU16xqtbFZmfPh
         JNOvrJOS3y8XAzAuo4OMNUizU+tP/at3oublgokt+hMuVjPxHqZBJafMrnYWGu+aAoig
         mZ3ArTUMjG36DR4tE4VLUJ8eVrWnlwDssiXeZqbjcGxdtxIAFUd4c99WYWfFhVmpmO5I
         WQ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sgXlMkvGS2uu79Bu/cAoPvNPYBIlXDtQ9rTO0QOZuWE=;
        b=B8OLfmf4EHYanZ/1HuaDAUMv5cAQaf1ZV2ua01qmcLTEMncDJLDzowC8Cd8Q00PkQt
         npo5hgxZLEXJ84ziyrCNzM44nSwIOUqq71nJ65/khmulrq6QgqP0cUPRg2Z5vO2d+UoP
         kri3rLjWa72TgLYzE0LBKLW4q4qrz3Ebh2LuhfXrwam20wCD0ZC1VWbwEUEyPCezcqhq
         JMmXj9/Adnz/IdxDUBta+bpMfBgW9NYdAmSTLzcOSodQYRK0UPh8MmV9ajP+p6xrwBdw
         PT0nPpYg38FDfLDaQsXnYDxit7NilWr8Jt9jWUxRTDw35eSesghX6oeUaRrQBJPcyeMB
         66ew==
X-Gm-Message-State: AOAM533j1Hotb4nK3Be8B7pbiEU9w5Nv7ojKt2/hXt/tbch/jvT/evXx
        XM2B6PUhOAQCVDYt3kdbCTokJCYPILONSx3m53w=
X-Google-Smtp-Source: ABdhPJydbkNsmuFYe8ktlWv2Sa/y7CaOD5/Y2RIdSvp0TsqkKStiMgzpsf7TVA+fTOi4sChgXNvF8S9o253BqRq5JQ4=
X-Received: by 2002:a25:e655:: with SMTP id d82mr24967175ybh.347.1600122404246;
 Mon, 14 Sep 2020 15:26:44 -0700 (PDT)
MIME-Version: 1.0
References: <1723352278.11013122.1600093319730.JavaMail.zimbra@redhat.com>
 <748495289.11017858.1600094916732.JavaMail.zimbra@redhat.com> <20200914182513.GK1714160@krava>
In-Reply-To: <20200914182513.GK1714160@krava>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 14 Sep 2020 15:26:33 -0700
Message-ID: <CAEf4Bzb7B+_s0Y2oN5TZARTmJby3npTVKDuDKDKfgmbBkAdpPQ@mail.gmail.com>
Subject: Re: Build failures: unresolved symbol vfs_getattr
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Veronika Kabatova <vkabatov@redhat.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 14, 2020 at 11:25 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Mon, Sep 14, 2020 at 10:48:36AM -0400, Veronika Kabatova wrote:
> >
> > Hello,
> >
> > we tested the bpf-next tree with CKI and ran across build failures. The
> > important part of the build log is:
> >
> > 00:18:05   GEN     .version
> > 00:18:05   CHK     include/generated/compile.h
> > 00:18:05   LD      vmlinux.o
> > 00:18:27   MODPOST vmlinux.symvers
> > 00:18:27   MODINFO modules.builtin.modinfo
> > 00:18:27   GEN     modules.builtin
> > 00:18:27   LD      .tmp_vmlinux.btf
> > 00:18:42   BTF     .btf.vmlinux.bin.o
> > 00:19:13   LD      .tmp_vmlinux.kallsyms1
> > 00:19:19   KSYM    .tmp_vmlinux.kallsyms1.o
> > 00:19:22   LD      .tmp_vmlinux.kallsyms2
> > 00:19:25   KSYM    .tmp_vmlinux.kallsyms2.o
> > 00:19:28   LD      vmlinux
> > 00:19:40   BTFIDS  vmlinux
> > 00:19:40 FAILED unresolved symbol vfs_getattr
> > 00:19:40 make[2]: *** [Makefile:1167: vmlinux] Error 255
> > 00:19:40 make[1]: *** [scripts/Makefile.package:109: targz-pkg] Error 2
> > 00:19:40 make: *** [Makefile:1528: targz-pkg] Error 2
>
> hi,
> it looks like broken BTF data to me, I checked that build
> and found we have multiple records for functions, like
> for filp_close:
>
>         [23381] FUNC_PROTO '(anon)' ret_type_id=19 vlen=2
>                 '(anon)' type_id=464
>                 'id' type_id=960
>         [23382] FUNC 'filp_close' type_id=23381 linkage=static
>
>
>         [33073] FUNC_PROTO '(anon)' ret_type_id=19 vlen=2
>                 'filp' type_id=464
>                 'id' type_id=960
>         [33074] FUNC 'filp_close' type_id=33073 linkage=static
>
>
> or vfs_getattr:
>
>         [33513] FUNC_PROTO '(anon)' ret_type_id=19 vlen=4
>                 'path' type_id=741
>                 'stat' type_id=1095
>                 'request_mask' type_id=29
>                 'query_flags' type_id=8
>
>         [33514] FUNC 'vfs_getattr' type_id=33513 linkage=static
>
>         [1094] FUNC_PROTO '(anon)' ret_type_id=19 vlen=4
>                 '(anon)' type_id=741
>                 '(anon)' type_id=1095
>                 '(anon)' type_id=29
>                 '(anon)' type_id=8
>
>         [35099] FUNC 'vfs_getattr' type_id=1094 linkage=static
>
>
> and because we go through all BTF data until we resolve all we have,
> the doubled funcs will screw our internal counter and we skip a function
>
> the change below will workaround that, but I think we should fail in
> this case.. if I'm not missing something 2 FUNC records for one function
> in BTF data
>
> $ pahole --version
> v1.17
>
> HEAD is 2bab48c5b Merge branch 'improve-bpf-tcp-cc-init'
>
> thoughts? thanks

Can't repro this locally. It must be some bad compiler +  DWARF +
pahole interaction. Can you try building pahole from latest sources
and try again? Also, what compiler did you use? What Kconfig?

> jirka
>
>
> ---
> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
> index dfa540d8a02d..a33e56553e52 100644
> --- a/tools/bpf/resolve_btfids/main.c
> +++ b/tools/bpf/resolve_btfids/main.c
> @@ -525,7 +525,7 @@ static int symbols_resolve(struct object *obj)
>                 }
>
>                 id = btf_id__find(root, str);
> -               if (id) {
> +               if (id && !id->id) {
>                         id->id = type_id;
>                         (*nr)--;
>                 }
>
