Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3101830A5
	for <lists+bpf@lfdr.de>; Thu, 12 Mar 2020 13:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgCLMyF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Mar 2020 08:54:05 -0400
Received: from sym2.noone.org ([178.63.92.236]:40598 "EHLO sym2.noone.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbgCLMyF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Mar 2020 08:54:05 -0400
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 48dTKk0SHJzvjdW; Thu, 12 Mar 2020 13:54:01 +0100 (CET)
Date:   Thu, 12 Mar 2020 13:54:01 +0100
From:   Tobias Klauser <tklauser@distanz.ch>
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        bpf@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: [PATCH] bpftool: use linux/types.h from source tree for profiler
 build
Message-ID: <20200312125401.aumdto3gkq73trgf@distanz.ch>
References: <20200312105335.10465-1-tklauser@distanz.ch>
 <e1193ce0-97c7-bc2a-984e-363afb2888e0@isovalent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1193ce0-97c7-bc2a-984e-363afb2888e0@isovalent.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2020-03-12 at 13:48:21 +0100, Quentin Monnet <quentin@isovalent.com> wrote:
> 2020-03-12 11:53 UTC+0100 ~ Tobias Klauser <tklauser@distanz.ch>
> > When compiling bpftool on a system where the /usr/include/asm symlink
> > doesn't exist (e.g. on an Ubuntu system without gcc-multilib installed),
> > the build fails with:
> > 
> >     CLANG    skeleton/profiler.bpf.o
> >   In file included from skeleton/profiler.bpf.c:4:
> >   In file included from /usr/include/linux/bpf.h:11:
> >   /usr/include/linux/types.h:5:10: fatal error: 'asm/types.h' file not found
> >   #include <asm/types.h>
> >            ^~~~~~~~~~~~~
> >   1 error generated.
> >   make: *** [Makefile:123: skeleton/profiler.bpf.o] Error 1
> > 
> > This indicates that the build is using linux/types.h from system headers
> > instead of source tree headers.
> > 
> > To fix this, adjust the clang search path to include the necessary
> > headers from tools/testing/selftests/bpf/include/uapi and
> > tools/include/uapi. Also undef __bitwise in skeleton/profiler.h avoid
> > clashing with the empty definition in
> > tools/testing/selftests/bpf/include/uapi/linux/types.h.
> > 
> > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > Cc: Song Liu <songliubraving@fb.com>
> > Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> > Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> 
> > diff --git a/tools/bpf/bpftool/skeleton/profiler.h b/tools/bpf/bpftool/skeleton/profiler.h
> > index e03b53eae767..95358c0df5ef 100644
> > --- a/tools/bpf/bpftool/skeleton/profiler.h
> > +++ b/tools/bpf/bpftool/skeleton/profiler.h
> > @@ -27,6 +27,7 @@ enum {
> >  	true = 1,
> >  };
> >  
> > +#undef __bitwise
> >  #ifdef __CHECKER__
> >  #define __bitwise__ __attribute__((bitwise))
> >  #else
> > 
> 
> Even with the #undef above, I get warnings on __bitwise being redefined
> in tools/testing/selftests/bpf/include/uapi/linux/types.h. Can we maybe
> just find another name (or number of underscores) for the macro in
> skeleton/profiler.h?

Good point. It seems I actually didn't test this properly. Will change
the typedefs to use the existing __bitwise__.

> Makefile change works well otherwise, thanks (tested on Ubuntu with and
> without gcc-multilib).

Thanks for testing.

- Tobias
