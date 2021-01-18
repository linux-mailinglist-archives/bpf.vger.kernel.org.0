Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30ED32FA4A2
	for <lists+bpf@lfdr.de>; Mon, 18 Jan 2021 16:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405021AbhARP0y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 Jan 2021 10:26:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393470AbhARPZC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Jan 2021 10:25:02 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBDE2C061574
        for <bpf@vger.kernel.org>; Mon, 18 Jan 2021 07:24:21 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id h11so4429808ioh.11
        for <bpf@vger.kernel.org>; Mon, 18 Jan 2021 07:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kl7BZu/lbfG/R7qwSgFy/xiRJpEwm0ukP4E7k/6e3JA=;
        b=oEnQ9LbYzxgy3Qkul3X03Z1WSt6C3z0fEgM98aZ+Xn/O34zwbFxJZ1b1yD4aMGIOEq
         cDOK8fl4ccMiOwzDKEbRGzhvocCutwU4ueb+tYZCkrqiNAyrS2AlgwAoNDZC0SgFxZLi
         v+y1eysRn+JqoZcx9CG/USjB7tqh4Zbv+N4Xz5Pq8b4+1fz6VhcM/4e0f3Hxme7j0hKS
         XehWSn5GSft/AB0IIsnnetbdk4xJtfIrp55T70Qj+zCHba0UI8SWftin8Xh+8x77qg7R
         bkwiHJhPg6bgPfPiTbSnEIpaTnwbFMthfZJuhXi2D2ORHJSIqBWlvMz80DSIk/ROW3qW
         iKZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kl7BZu/lbfG/R7qwSgFy/xiRJpEwm0ukP4E7k/6e3JA=;
        b=MtT6Dl1KkraOnKrThPprFeEXjHQ1zjblEBIhcbpaSfaBzS47ws2tudVcwVvxn/Mxc6
         hblAMucoP9GI5aMk1F6ZGrepG1qke+a5JhU9VXu/l7wUhat2Y5hD1qCLhyjPwkFcDVgT
         dV7A2WK9enD653Z0c77rbyTwF2BHytaxr2JQHvJ4ijZLmF7cM2tlrW76dsb8YVg1cU8m
         VT/GRk5XwMeAiLpAy3qvvC+rE0A8XDCRuh28wxud/QJ1b5UGreUCXkrXWPw9e/GsCRDi
         BalWnjVh2XoipHISbAuu60E5v2rNUEelxax9Ap3U7dMZ4dGwIkKr/pA+9fgGYv0KrQSV
         PJbw==
X-Gm-Message-State: AOAM53016LLzRg9e2aJGsIutT+z0kXe7moI1SVixQr9sOdtIF6Ly/Pl5
        lHvfy7V3teYZ0B6BDJxDK0m9rN2M5TVNHaipvPd01w==
X-Google-Smtp-Source: ABdhPJxV58bfAmS/jY41Uns2ceyjKGDaJPgMXl52CZfjrtFkgtZde98+ncyez8PJdyto/CRVIbTHSSfodRetoOs/u+0=
X-Received: by 2002:a05:6e02:c0f:: with SMTP id d15mr21389627ile.263.1610983461039;
 Mon, 18 Jan 2021 07:24:21 -0800 (PST)
MIME-Version: 1.0
References: <20210118144101.01a5d410@carbon> <CA+i-1C1Te+c876s3JYSE6o7fw+TaTbC7TnMmyw8kx5Tg1jUxNw@mail.gmail.com>
 <20210118153745.21b9727e@carbon>
In-Reply-To: <20210118153745.21b9727e@carbon>
From:   Brendan Jackman <jackmanb@google.com>
Date:   Mon, 18 Jan 2021 16:24:10 +0100
Message-ID: <CA+i-1C1f2UUc=iuhQzus9iVrftHWonyPRB8pZhz2HKfKg6uKuw@mail.gmail.com>
Subject: Re: Issues compiling selftests XADD - "Invalid usage of the XADD
 return value"
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        BPF-dev-list <bpf@vger.kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Veronika Kabatova <vkabatov@redhat.com>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Stanislav Kozina <skozina@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 18 Jan 2021 at 15:38, Jesper Dangaard Brouer <brouer@redhat.com> wr=
ote:
> I'm compiling from LLVM 'main' branch (commit e6d758de82b6) but it
> unfortunately fails to compile (see error below).
>
> Any recommended LLVM commit id that works?

:(

I'm on 6f4ee6f87060 and things are working.

>
> [...]
> ../include/llvm/ExecutionEngine/Orc/Shared/RPCUtils.h:1513:27: note: remo=
ve =E2=80=98std::move=E2=80=99 call
> ../include/llvm/ExecutionEngine/Orc/Shared/RPCUtils.h:1519:27: warning: m=
oving a local object in a return statement prevents copy elision [-Wpessimi=
zing-move]
>  1519 |       return std::move(Err);
>       |                           ^
> ../include/llvm/ExecutionEngine/Orc/Shared/RPCUtils.h:1519:27: note: remo=
ve =E2=80=98std::move=E2=80=99 call
> ../include/llvm/ExecutionEngine/Orc/Shared/RPCUtils.h:1526:29: warning: m=
oving a local object in a return statement prevents copy elision [-Wpessimi=
zing-move]
>  1526 |         return std::move(Err);
>       |                             ^
> ../include/llvm/ExecutionEngine/Orc/Shared/RPCUtils.h:1526:29: note: remo=
ve =E2=80=98std::move=E2=80=99 call
> [2237/3183] Building CXX object tools/clang/lib/ASTMatchers/Dynamic/CMake=
Files/obj.clangDynamicASTMatchers.dir/Registry.cpp.o
> FAILED: tools/clang/lib/ASTMatchers/Dynamic/CMakeFiles/obj.clangDynamicAS=
TMatchers.dir/Registry.cpp.o
> /usr/lib64/ccache/c++  -DGTEST_HAS_RTTI=3D0 -D_GNU_SOURCE -D__STDC_CONSTA=
NT_MACROS -D__STDC_FORMAT_MACROS -D__STDC_LIMIT_MACROS -Itools/clang/lib/AS=
TMatchers/Dynamic -I/home/jbrouer/git/llvm-project/clang/lib/ASTMatchers/Dy=
namic -I/home/jbrouer/git/llvm-project/clang/include -Itools/clang/include =
-Iinclude -I/home/jbrouer/git/llvm-project/llvm/include -fPIC -fvisibility-=
inlines-hidden -Werror=3Ddate-time -Wall -Wextra -Wno-unused-parameter -Wwr=
ite-strings -Wcast-qual -Wno-missing-field-initializers -pedantic -Wno-long=
-long -Wimplicit-fallthrough -Wno-maybe-uninitialized -Wno-class-memaccess =
-Wno-redundant-move -Wno-noexcept-type -Wdelete-non-virtual-dtor -Wsuggest-=
override -Wno-comment -fdiagnostics-color -ffunction-sections -fdata-sectio=
ns -fno-common -Woverloaded-virtual -fno-strict-aliasing -O2 -DNDEBUG    -f=
no-exceptions -fno-rtti -std=3Dc++14 -MD -MT tools/clang/lib/ASTMatchers/Dy=
namic/CMakeFiles/obj.clangDynamicASTMatchers.dir/Registry.cpp.o -MF tools/c=
lang/lib/ASTMatchers/Dynamic/CMakeFiles/obj.clangDynamicASTMatchers.dir/Reg=
istry.cpp.o.d -o tools/clang/lib/ASTMatchers/Dynamic/CMakeFiles/obj.clangDy=
namicASTMatchers.dir/Registry.cpp.o -c /home/jbrouer/git/llvm-project/clang=
/lib/ASTMatchers/Dynamic/Registry.cpp
> c++: fatal error: Killed signal terminated program cc1plus
> compilation terminated.
>
> [2255/3183] Building CXX object tools/clang/lib/ASTMatchers/CMakeFiles/ob=
j.clangASTMatchers.dir/ASTMatchFinder.cpp.o
>
> [2262/3183] Building CXX object tools/clang/lib/Sema/CMakeFiles/obj.clang=
Sema.dir/SemaExpr.cpp.o
> ninja: build stopped: subcommand failed.
