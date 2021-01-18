Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9201A2FA66D
	for <lists+bpf@lfdr.de>; Mon, 18 Jan 2021 17:39:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392837AbhARQhS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 Jan 2021 11:37:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56519 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2393171AbhARQey (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 18 Jan 2021 11:34:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610987607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hEgtib86MHmA2mWh9rUrmxTWGEu7W8uAnYFAy5HaaRw=;
        b=Ui1KojccLbALse1J7uCIABabundfwopIYOyi1epTsknGYccSLx9Bxr7NdMDoe3hp/186PJ
        Yl1apQlrJWetndUyiM9LfuAg7o2t5wnsuvPcjG7fxJVCzjNWW3XfxNYuXgNZM1dXJ30p4S
        jtxQQHA9qFY1CKLV+qR6/03U3emaq1E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-115-Sj1TU5y0M1y12pET7Np9CA-1; Mon, 18 Jan 2021 11:33:25 -0500
X-MC-Unique: Sj1TU5y0M1y12pET7Np9CA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 436CD1005504;
        Mon, 18 Jan 2021 16:33:24 +0000 (UTC)
Received: from carbon (unknown [10.36.110.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1CD9B5D9CD;
        Mon, 18 Jan 2021 16:33:15 +0000 (UTC)
Date:   Mon, 18 Jan 2021 17:33:14 +0100
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     Brendan Jackman <jackmanb@google.com>
Cc:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        BPF-dev-list <bpf@vger.kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Veronika Kabatova <vkabatov@redhat.com>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Stanislav Kozina <skozina@redhat.com>, brouer@redhat.com
Subject: Re: Issues compiling selftests XADD - "Invalid usage of the XADD
 return value"
Message-ID: <20210118173314.063ab3af@carbon>
In-Reply-To: <CA+i-1C1f2UUc=iuhQzus9iVrftHWonyPRB8pZhz2HKfKg6uKuw@mail.gmail.com>
References: <20210118144101.01a5d410@carbon>
        <CA+i-1C1Te+c876s3JYSE6o7fw+TaTbC7TnMmyw8kx5Tg1jUxNw@mail.gmail.com>
        <20210118153745.21b9727e@carbon>
        <CA+i-1C1f2UUc=iuhQzus9iVrftHWonyPRB8pZhz2HKfKg6uKuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 18 Jan 2021 16:24:10 +0100
Brendan Jackman <jackmanb@google.com> wrote:

> On Mon, 18 Jan 2021 at 15:38, Jesper Dangaard Brouer <brouer@redhat.com> =
wrote:
> > I'm compiling from LLVM 'main' branch (commit e6d758de82b6) but it
> > unfortunately fails to compile (see error below).
> >
> > Any recommended LLVM commit id that works? =20
>=20
> :(
>=20
> I'm on 6f4ee6f87060 and things are working.

I got compiling to work on this commit.  But the error below, were
likely caused by my compile machine simply ran out of memory (it "only"
have 16GB RAM).

I reduced the number of parallel jobs (ninja -j6) and have now
successfully compiled devel branch of LLVM.

Now the compile of BPF-selftests is possible again.


> >
> > [...]
> > ../include/llvm/ExecutionEngine/Orc/Shared/RPCUtils.h:1513:27: note: re=
move =E2=80=98std::move=E2=80=99 call
> > ../include/llvm/ExecutionEngine/Orc/Shared/RPCUtils.h:1519:27: warning:=
 moving a local object in a return statement prevents copy elision [-Wpessi=
mizing-move]
> >  1519 |       return std::move(Err);
> >       |                           ^
> > ../include/llvm/ExecutionEngine/Orc/Shared/RPCUtils.h:1519:27: note: re=
move =E2=80=98std::move=E2=80=99 call
> > ../include/llvm/ExecutionEngine/Orc/Shared/RPCUtils.h:1526:29: warning:=
 moving a local object in a return statement prevents copy elision [-Wpessi=
mizing-move]
> >  1526 |         return std::move(Err);
> >       |                             ^
> > ../include/llvm/ExecutionEngine/Orc/Shared/RPCUtils.h:1526:29: note: re=
move =E2=80=98std::move=E2=80=99 call
> > [2237/3183] Building CXX object tools/clang/lib/ASTMatchers/Dynamic/CMa=
keFiles/obj.clangDynamicASTMatchers.dir/Registry.cpp.o
> > FAILED: tools/clang/lib/ASTMatchers/Dynamic/CMakeFiles/obj.clangDynamic=
ASTMatchers.dir/Registry.cpp.o
> > /usr/lib64/ccache/c++  -DGTEST_HAS_RTTI=3D0 -D_GNU_SOURCE -D__STDC_CONS=
TANT_MACROS -D__STDC_FORMAT_MACROS -D__STDC_LIMIT_MACROS -Itools/clang/lib/=
ASTMatchers/Dynamic -I/home/jbrouer/git/llvm-project/clang/lib/ASTMatchers/=
Dynamic -I/home/jbrouer/git/llvm-project/clang/include -Itools/clang/includ=
e -Iinclude -I/home/jbrouer/git/llvm-project/llvm/include -fPIC -fvisibilit=
y-inlines-hidden -Werror=3Ddate-time -Wall -Wextra -Wno-unused-parameter -W=
write-strings -Wcast-qual -Wno-missing-field-initializers -pedantic -Wno-lo=
ng-long -Wimplicit-fallthrough -Wno-maybe-uninitialized -Wno-class-memacces=
s -Wno-redundant-move -Wno-noexcept-type -Wdelete-non-virtual-dtor -Wsugges=
t-override -Wno-comment -fdiagnostics-color -ffunction-sections -fdata-sect=
ions -fno-common -Woverloaded-virtual -fno-strict-aliasing -O2 -DNDEBUG    =
-fno-exceptions -fno-rtti -std=3Dc++14 -MD -MT tools/clang/lib/ASTMatchers/=
Dynamic/CMakeFiles/obj.clangDynamicASTMatchers.dir/Registry.cpp.o -MF tools=
/clang/lib/ASTMatchers/Dynamic/CMakeFiles/obj.clangDynamicASTMatchers.dir/R=
egistry.cpp.o.d -o tools/clang/lib/ASTMatchers/Dynamic/CMakeFiles/obj.clang=
DynamicASTMatchers.dir/Registry.cpp.o -c /home/jbrouer/git/llvm-project/cla=
ng/lib/ASTMatchers/Dynamic/Registry.cpp
> > c++: fatal error: Killed signal terminated program cc1plus
> > compilation terminated.
> >
> > [2255/3183] Building CXX object tools/clang/lib/ASTMatchers/CMakeFiles/=
obj.clangASTMatchers.dir/ASTMatchFinder.cpp.o
> >
> > [2262/3183] Building CXX object tools/clang/lib/Sema/CMakeFiles/obj.cla=
ngSema.dir/SemaExpr.cpp.o
> > ninja: build stopped: subcommand failed. =20
>=20



--=20
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

