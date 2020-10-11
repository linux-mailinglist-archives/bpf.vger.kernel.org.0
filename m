Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B939C28A4B7
	for <lists+bpf@lfdr.de>; Sun, 11 Oct 2020 02:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgJKAGb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 10 Oct 2020 20:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgJKAGb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 10 Oct 2020 20:06:31 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA40C0613D0
        for <bpf@vger.kernel.org>; Sat, 10 Oct 2020 17:06:29 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id n142so10351478ybf.7
        for <bpf@vger.kernel.org>; Sat, 10 Oct 2020 17:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=391Lv0AJydf0gkLPD3etSB8X3RCqMRHec7PSELtKEmk=;
        b=Sk77lB1qJdEbnTv/xbP9AK0BqvR65Bkl6DChhMcXIBy2tEbWfRehe3d9I3CrJ4XeaO
         c3O+1p3UIaRwK/IGLuhIbHvikw4kKRVkhJYc0tIf2XtcreGzhq6J8Xdw+Et6moA80AFf
         rEj15ashn0lsKRYsZP9tu5EX4MLIgDhYxx7rFFLZz7M5Eu41pFVbnCTxI3/QCm8dD/Ox
         9JC9XsMtVYrn3BMqgDJBUMPSLBvxe+sG2SG07vIy6sCREsPVhlENlIDGL/drT0X2O0hc
         jMskzu0vklWTbAQ33XEeUqpqtXAVutqATipWVTrvA13+T5g6HGJvtVDnCWFPzVS8kdN1
         nWBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=391Lv0AJydf0gkLPD3etSB8X3RCqMRHec7PSELtKEmk=;
        b=M/27hrOXlgTGSC1+b2mhVlQYuEEee2ITGLRITmNYLn9V0dtESop/hodgtpU+HwQiEY
         WmGlsJ7lhvwK8MR7jOMQeRClcKazUEe0ivtIWY4M3V3flibrBTiHhzPwJHwT+RNHZqt6
         KhoDOMBtMafOex2hGY7xc6bJyTk/Gv16HlipLyRNMeT67gLYA4X+8EOP7+5JxuTdQgII
         Psy3vtFlg54AnjOqkLZUsNbigpgQidgJRQ8KJAwyXh7hLDGDzyO+0E6ilzmTUkj/gtr1
         74eLsQemqQ9DAHvJP+8QzCRhUT/Isi2rhsSFsn24a2CNQhAdWxBqvHcb0UiOLRpDrKk5
         LQKA==
X-Gm-Message-State: AOAM530y5ZbNIX7fZgoD/pj8ZoHBoCf6vRMotUBcbbLH25bb/3TN87SH
        v/S5TtSwngSA58iFSQUN2c0cgXS6XyPiXPcJurg6K6CehcOKpA==
X-Google-Smtp-Source: ABdhPJxqjazTUVrLi8a8Cx8uoSDGEDe6rdf/NokZbpVl0P4wmgq/8nzTmtLs8tZ1ARge74APkEStoX9paT9MyiP8JHA=
X-Received: by 2002:a25:8541:: with SMTP id f1mr22865573ybn.230.1602374788375;
 Sat, 10 Oct 2020 17:06:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAEKGpzh70f06iMQdR3B1LF3hMwHnB=x92fvfV8+smQObvKBF_w@mail.gmail.com>
In-Reply-To: <CAEKGpzh70f06iMQdR3B1LF3hMwHnB=x92fvfV8+smQObvKBF_w@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Sat, 10 Oct 2020 17:06:17 -0700
Message-ID: <CAEf4BzYzhykW_VC8Q-Sa5x9u+MdEO0zfmrgbkShSQDH4F5AsMw@mail.gmail.com>
Subject: Re: Where can I find the map's BTF type key/value specification?
To:     "Daniel T. Lee" <danieltimlee@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>,
        Martin Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Oct 10, 2020 at 3:50 AM Daniel T. Lee <danieltimlee@gmail.com> wrote:
>
> I'm looking for how BTF type definition '__type(key, int)' is being changed
> to '__uint(key_size, sizeof(int))'. (Not exactly "changed" but wonder how
> it can be considered the same)

__type(key, int) captures both BTF ID of key and determines key_size
based on that type. You can specify both key and key_size, but that's
unnecessary (and resulting key size still has to match).

>
>     __uint(type, BPF_MAP_TYPE_ARRAY);
>     __type(key, int);          => __uint(key_size, sizeof(int))
>     __type(value, u32);    => __uint(value_size, sizeof(u32))
>     __uint(max_entries, 2);
>
> Whether the specific map type supports BTF or not can be inferred from
> the file in kernel/bpf/*map.c and by checking each MAP type's
> bpf_map_ops .map_check_btf pointer is initialized as map_check_no_btf.
>
> But how can I figure out that specific types of map support BTF types for
> key/value? And how can I determine how this BTF key/value type is
> converted?

I think you answered your own question, you just search whether each
map implements .map_check_btf that allows key/value BTF type ID. E.g.,
see array_map_check_btf, which allows key/value type ID. And compare
to how perf_event_array_map_ops use map_check_no_btf for its
.map_check_btf callback.

So you can search for all struct bpf_map_ops declarations to see
operations for all map types, and then see what's there for
.map_check_btf. Ideally we should extend all maps to support BTF type
ID for key/value, but no one signed up to do that. If you are
interested, that should be a good way to contribute to kernel itself.

>
> I am aware that BTF information is created in the form of a compact
> type by using pahole to deduplicate repeated types, strings information
> from DWARF information. However, looking at the *btf or pahole file
> in dwarves repository, it seemed that it was not responsible for the
> conversion of the BTF key/value.
>
> The remaining guess is that LLVM's BPF target compiler is responsible
> for this, or it's probably somewhere in the kernel, but I'm not sure
> where it is.

BTF for the BPF program is emitted by Clang itself when you specify
`-target bpf -g`. pahole is used to convert kernel's (vmlinux) DWARF
into BTF and embed it into vmlinux image.

As for key/value BTF type id for maps, that's libbpf parsing map
definition and recording type IDs. So there are a few things playing
together. See abd29c931459 ("libbpf: allow specifying map definitions
using BTF") that introduced this feature.

>
> --
> Best,
> Daniel T. Lee
