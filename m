Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A588417E70
	for <lists+bpf@lfdr.de>; Sat, 25 Sep 2021 01:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbhIXXyn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Sep 2021 19:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbhIXXyn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Sep 2021 19:54:43 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6DCC061571
        for <bpf@vger.kernel.org>; Fri, 24 Sep 2021 16:53:09 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id w19so6523943ybs.3
        for <bpf@vger.kernel.org>; Fri, 24 Sep 2021 16:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zMAxE/8yd0USx3mViJDvnysQxS8RIELoegjYzFsQxxo=;
        b=Ci5pjzvXajhkprSrgA4YIyVhmRIBQelYnvpdOiEEVp+9eMcrDmjaBSBZxqaqeGZSbo
         pM6ZwZtZR7X2DVzP168LU5gSwcC8AfBHO50gL8QaDU3mYlqcSj8EUpCBv9Fz1TbBePLE
         grgN8q94klleyleO8+0IMzRaFvYhcxgbIB10SZ1/oi3WEmUXPrwu4jv9uVbEjirlOi8v
         xSyz5Mlve/BFdSgN8vQYq/JXcnOqcwJfpxfqOOGApP082L0+VpOtJG65UKiNjH9nEuS1
         YN4UihlV1dKc3h0pXmb42dxiHiFtnrPO4drOhyk06jrXUjBE7LiuLeWQbCx5LpnqRvGp
         fYEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zMAxE/8yd0USx3mViJDvnysQxS8RIELoegjYzFsQxxo=;
        b=zFDSyg+wmkGygLn2l3223+LAK63gWZfzcc92BYPVjFMWA1evbQVovuOfvtyFP2GC2a
         rR8ZUrtFbY0C3k1m+5gqa9+tO7+UeIvQxC2o44eMwzc/hAigWtV9Xc6oSK6doBOrtiEA
         E1hje0mGkjaDhWN3xvtBeKS7N8/CQ2WCWtgT3bjLW9Q1szTEAaYtdZ4byIdREuKroLTt
         xCcs+7HbTLyjZdnTu/SDmmQCF0UsYK3wIjhV96h9oxse60sXzVBSoMaOP3oR//QmIyyo
         0PICt+qUj/n8+m2lH46wtxKVSe0Xh9d9EeXUctWRaH4BrV3VsLZZsANB1m1tP9+jc3DL
         MrrQ==
X-Gm-Message-State: AOAM532UPiso8RB+zS7PVetadem1x5H8wB9TFf5HYt4V8Ohxhid+gNfU
        KIlMvq1gbaCSmeW9skYuKF92Yn3NREQPRzbdeV/FsA9O
X-Google-Smtp-Source: ABdhPJzVz8QnubQ/cTLyjQ4Zhqfs5/IT7MPEE3n2tOlsOOw8u1E3q/BT2bfL56vt72LZY7C2h7IPhJe4Tr9nkFFquzs=
X-Received: by 2002:a25:1884:: with SMTP id 126mr15914510yby.114.1632527588733;
 Fri, 24 Sep 2021 16:53:08 -0700 (PDT)
MIME-Version: 1.0
References: <87wnn5yl4p.fsf@toke.dk>
In-Reply-To: <87wnn5yl4p.fsf@toke.dk>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 24 Sep 2021 16:52:57 -0700
Message-ID: <CAEf4BzZ5HXrhhpbZ573Hh2yjwxFf3Gu-WekafYZqCBhVgQ=zRg@mail.gmail.com>
Subject: Re: Reason for libbpf rejecting SECTION symbols in 'maps' section
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     bpf <bpf@vger.kernel.org>, Jiri Benc <jbenc@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 24, 2021 at 9:49 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redh=
at.com> wrote:
>
> Hi Andrii
>
> We ran into an issue with binutils[0] mangling BPF object files, which
> makes libbpf sad. Specifically, binutils will create SECTION symbols for
> every section in .symtab, which trips this check in
> bpf_object__init_user_maps():
>
> if (GELF_ST_TYPE(sym.st_info) =3D=3D STT_SECTION
>     || GELF_ST_BIND(sym.st_info) =3D=3D STB_LOCAL) {
>         pr_warn("map '%s' (legacy): static maps are not supported\n", map=
_name);
>         return -ENOTSUP;
> }
>
> Given the error message I can understand why it's checking for
> STB_LOCAL, but why is the check for STT_SECTION there? And is there any
> reason why libbpf couldn't just skip the SECTION symbols instead of
> bugging out?

Static functions are often referenced through STT_SECTION symbol +
some offset. I don't remember by now if I encountered cases where
static variables can be referenced through section symbol + offset, I
suspect I did, which is why I added this check.

But thinking about this now, we should just ignore the STT_SECTION
symbol. If Clang really referenced map through STT_SECTION symbol,
we'll later won't find a corresponding bpf_map instance for a
corresponding relocation.

So I think it's fine to drop the STT_SECTION.

>
> Hope you can help shed some light on the history here.
>
> -Toke
>
>
> [0] This happens because rpmbuild has a script that automatically that
> runs 'strip' on every object file in an rpm; and so when we package up
> the kernel selftests, we end up with mangled object files. Newer
> versions of binutils don't do this, but the one on RHEL does.
>
