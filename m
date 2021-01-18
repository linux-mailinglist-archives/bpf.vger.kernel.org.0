Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B034A2FA34B
	for <lists+bpf@lfdr.de>; Mon, 18 Jan 2021 15:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393053AbhAROjh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 Jan 2021 09:39:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55131 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2393058AbhAROj1 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 18 Jan 2021 09:39:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610980680;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sDPhLJ2/D+0cwuPXylknSz9P6DswkEM2s3TDWgX1gtA=;
        b=UpAnPZeR5pqrCeb7dwUkWRycErZ0CupHzYc01ppTwzuUK8X0e9vaaTCqZMcGEYOsIHGIPr
        bK8Yhxblj6ZhOUjD1daseVBBrN+tbyyfxaSPFkulx0QDmvgYcBIw7Voepp1XosIG1YGexA
        cKznoOeG6BO2bOP6d5O3lJKbxLoOcTo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-454-u01AXsweMXq15dF2CYwCCQ-1; Mon, 18 Jan 2021 09:37:56 -0500
X-MC-Unique: u01AXsweMXq15dF2CYwCCQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B59A7800D55;
        Mon, 18 Jan 2021 14:37:55 +0000 (UTC)
Received: from carbon (unknown [10.36.110.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1FB889CA0;
        Mon, 18 Jan 2021 14:37:46 +0000 (UTC)
Date:   Mon, 18 Jan 2021 15:37:45 +0100
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
Message-ID: <20210118153745.21b9727e@carbon>
In-Reply-To: <CA+i-1C1Te+c876s3JYSE6o7fw+TaTbC7TnMmyw8kx5Tg1jUxNw@mail.gmail.com>
References: <20210118144101.01a5d410@carbon>
        <CA+i-1C1Te+c876s3JYSE6o7fw+TaTbC7TnMmyw8kx5Tg1jUxNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On Mon, 18 Jan 2021 14:47:36 +0100
Brendan Jackman <jackmanb@google.com> wrote:

> On Mon, 18 Jan 2021 at 14:41, Jesper Dangaard Brouer <brouer@redhat.com> =
wrote:
> >
> > Hi All,
> >
> > After rebasing (my MTU patchset) to bpf-next (232164e041e925a) I'm
> > getting this error when compiling selftests (full error below signature=
):
> >
> >   "CLNG-BPF [test_maps] atomics.o"
> >   "fatal error: error in backend: line 27: Invalid usage of the XADD re=
turn value"
> >   "PLEASE submit a bug report to https://bugs.llvm.org/ [...]"
> >
> > It looked like a LLVM bug, so I compiled llvm-11.1.0-rc1, but it still =
fails.
> >
> > I noticed Brendan Jackman changes... could this be related? =20
>=20
> Yes, since bpf-next commit 98d666d05a1d970 ("bpf: Add tests for new
> BPF atomic operations") you need llvm-project commit 286daafd6512 (was
> https://reviews.llvm.org/D72184) for the selftests, which will be in
> Clang 12. You'll need to build LLVM from master.
>=20

I'm compiling from LLVM 'main' branch (commit e6d758de82b6) but it
unfortunately fails to compile (see error below).

Any recommended LLVM commit id that works?


[...]
../include/llvm/ExecutionEngine/Orc/Shared/RPCUtils.h:1513:27: note: remove=
 =E2=80=98std::move=E2=80=99 call
../include/llvm/ExecutionEngine/Orc/Shared/RPCUtils.h:1519:27: warning: mov=
ing a local object in a return statement prevents copy elision [-Wpessimizi=
ng-move]
 1519 |       return std::move(Err);
      |                           ^
../include/llvm/ExecutionEngine/Orc/Shared/RPCUtils.h:1519:27: note: remove=
 =E2=80=98std::move=E2=80=99 call
../include/llvm/ExecutionEngine/Orc/Shared/RPCUtils.h:1526:29: warning: mov=
ing a local object in a return statement prevents copy elision [-Wpessimizi=
ng-move]
 1526 |         return std::move(Err);
      |                             ^
../include/llvm/ExecutionEngine/Orc/Shared/RPCUtils.h:1526:29: note: remove=
 =E2=80=98std::move=E2=80=99 call
[2237/3183] Building CXX object tools/clang/lib/ASTMatchers/Dynamic/CMakeFi=
les/obj.clangDynamicASTMatchers.dir/Registry.cpp.o
FAILED: tools/clang/lib/ASTMatchers/Dynamic/CMakeFiles/obj.clangDynamicASTM=
atchers.dir/Registry.cpp.o=20
/usr/lib64/ccache/c++  -DGTEST_HAS_RTTI=3D0 -D_GNU_SOURCE -D__STDC_CONSTANT=
_MACROS -D__STDC_FORMAT_MACROS -D__STDC_LIMIT_MACROS -Itools/clang/lib/ASTM=
atchers/Dynamic -I/home/jbrouer/git/llvm-project/clang/lib/ASTMatchers/Dyna=
mic -I/home/jbrouer/git/llvm-project/clang/include -Itools/clang/include -I=
include -I/home/jbrouer/git/llvm-project/llvm/include -fPIC -fvisibility-in=
lines-hidden -Werror=3Ddate-time -Wall -Wextra -Wno-unused-parameter -Wwrit=
e-strings -Wcast-qual -Wno-missing-field-initializers -pedantic -Wno-long-l=
ong -Wimplicit-fallthrough -Wno-maybe-uninitialized -Wno-class-memaccess -W=
no-redundant-move -Wno-noexcept-type -Wdelete-non-virtual-dtor -Wsuggest-ov=
erride -Wno-comment -fdiagnostics-color -ffunction-sections -fdata-sections=
 -fno-common -Woverloaded-virtual -fno-strict-aliasing -O2 -DNDEBUG    -fno=
-exceptions -fno-rtti -std=3Dc++14 -MD -MT tools/clang/lib/ASTMatchers/Dyna=
mic/CMakeFiles/obj.clangDynamicASTMatchers.dir/Registry.cpp.o -MF tools/cla=
ng/lib/ASTMatchers/Dynamic/CMakeFiles/obj.clangDynamicASTMatchers.dir/Regis=
try.cpp.o.d -o tools/clang/lib/ASTMatchers/Dynamic/CMakeFiles/obj.clangDyna=
micASTMatchers.dir/Registry.cpp.o -c /home/jbrouer/git/llvm-project/clang/l=
ib/ASTMatchers/Dynamic/Registry.cpp
c++: fatal error: Killed signal terminated program cc1plus
compilation terminated.

[2255/3183] Building CXX object tools/clang/lib/ASTMatchers/CMakeFiles/obj.=
clangASTMatchers.dir/ASTMatchFinder.cpp.o

[2262/3183] Building CXX object tools/clang/lib/Sema/CMakeFiles/obj.clangSe=
ma.dir/SemaExpr.cpp.o
ninja: build stopped: subcommand failed.


--=20
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

