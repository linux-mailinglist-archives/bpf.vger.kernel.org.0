Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA53181D2C
	for <lists+bpf@lfdr.de>; Wed, 11 Mar 2020 17:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729989AbgCKQGv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Mar 2020 12:06:51 -0400
Received: from sym2.noone.org ([178.63.92.236]:32886 "EHLO sym2.noone.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729921AbgCKQGv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Mar 2020 12:06:51 -0400
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 48cxfc5lPBzvjdW; Wed, 11 Mar 2020 17:06:48 +0100 (CET)
Date:   Wed, 11 Mar 2020 17:06:48 +0100
From:   Tobias Klauser <tklauser@distanz.ch>
To:     Song Liu <songliubraving@fb.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH] bpftool: fix iprofiler build on systems without
 /usr/include/asm symlink
Message-ID: <20200311160647.bb57zyick37t5pck@distanz.ch>
References: <20200311123421.3634-1-tklauser@distanz.ch>
 <D8E0C5BC-E724-4788-86DA-EF8110237B6E@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D8E0C5BC-E724-4788-86DA-EF8110237B6E@fb.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2020-03-11 at 16:55:38 +0100, Song Liu <songliubraving@fb.com> wrote:
> 
> 
> > On Mar 11, 2020, at 5:34 AM, Tobias Klauser <tklauser@distanz.ch> wrote:
> > 
> > When compiling bpftool on a system where the /usr/include/asm symlink
> > doesn't exist (e.g. on an Ubuntu system without gcc-multilib installed),
> > the build fails with:
> > 
> >    CLANG    skeleton/profiler.bpf.o
> >  In file included from skeleton/profiler.bpf.c:4:
> >  In file included from /usr/include/linux/bpf.h:11:
> >  /usr/include/linux/types.h:5:10: fatal error: 'asm/types.h' file not found
> >  #include <asm/types.h>
> >           ^~~~~~~~~~~~~
> >  1 error generated.
> >  make: *** [Makefile:123: skeleton/profiler.bpf.o] Error 1
> > 
> > To fix this, add /usr/include/$(uname -m)-linux-gnu to the clang search
> > path so <asm/types.h> can be found.
> > 
> > Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> 
> Looks good, with a nit below. 
> 
> Acked-by: Song Liu <songliubraving@fb.com>
> 
> > ---
> > tools/bpf/bpftool/Makefile | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> > index 20a90d8450f8..3cc0644fd91e 100644
> > --- a/tools/bpf/bpftool/Makefile
> > +++ b/tools/bpf/bpftool/Makefile
> > @@ -120,7 +120,7 @@ $(OUTPUT)_bpftool: $(_OBJS) $(LIBBPF)
> > 	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $(_OBJS) $(LIBS)
> > 
> > skeleton/profiler.bpf.o: skeleton/profiler.bpf.c
> > -	$(QUIET_CLANG)$(CLANG) -I$(srctree)/tools/lib -g -O2 -target bpf -c $< -o $@
> > +	$(QUIET_CLANG)$(CLANG) -I/usr/include/$(shell uname -m)-linux-gnu -I$(srctree)/tools/lib -g -O2 -target bpf -c $< -o $@
> 
> Nit: this line is too long. It is better to break it into two lines. 

Thanks. Will send a v2, also with Toke's feedback regarding commit
message included.
