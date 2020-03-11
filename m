Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2C641822B0
	for <lists+bpf@lfdr.de>; Wed, 11 Mar 2020 20:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731048AbgCKTmq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Mar 2020 15:42:46 -0400
Received: from sym2.noone.org ([178.63.92.236]:40088 "EHLO sym2.noone.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730913AbgCKTmq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Mar 2020 15:42:46 -0400
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 48d2Rl5sF8zvjdW; Wed, 11 Mar 2020 20:42:43 +0100 (CET)
Date:   Wed, 11 Mar 2020 20:42:43 +0100
From:   Tobias Klauser <tklauser@distanz.ch>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v2] bpftool: fix profiler build on systems
 without /usr/include/asm symlink
Message-ID: <20200311194242.htdih4w4ld4tgk5x@distanz.ch>
References: <20200311123421.3634-1-tklauser@distanz.ch>
 <20200311161459.6310-1-tklauser@distanz.ch>
 <20200311172650.r3gfkqbyftc32iax@ast-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311172650.r3gfkqbyftc32iax@ast-mbp.dhcp.thefacebook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2020-03-11 at 18:26:50 +0100, Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> On Wed, Mar 11, 2020 at 05:14:59PM +0100, Tobias Klauser wrote:
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
> 
> I think the issue is different.
> profiler.bpf.c should have picked up
> tools/include/uapi/linux/bpf.h (instead of global from /usr/inclde)
> which should have included
> tools/include/linux/types.h (instead of /usr/include/linux/types.h)
> 
> we also have a workaround for some cases:
> ./tools/testing/selftests/bpf/include/uapi/linux/types.h

I just tried that. Unfortunately, this will pull in stdbool.h, stddef.h
and stdint.h libc header (via either linux/types.h header). This will
again require the libc6-dev-i386 package when building for the bpf
target. This is exactly the dependency that we'd like to avoid in
Cilium, also see https://github.com/cilium/cilium/pull/10204

I agree that we ideally shouldn't pull in the headers from the system,
but currently I don't see a way of doing that without still depending on
libc headers. Suggestions welcome...

> >   make: *** [Makefile:123: skeleton/profiler.bpf.o] Error 1
> > 
> > In certain cases (e.g. for container builds), installing gcc-multilib
> > and all its dependencies - which are otherwise not needed to build
> > bpftool - unnecessarily increases the image size.
> > 
> > Thus, fix this by adding /usr/include/$(uname -m)-linux-gnu to the
> > clang search path so <asm/types.h> can be found.
> 
> In general perf builds fine on all sorts of distros and configs.
> I think bpftool should use the same includes from tools/
> and skeleton too.

I'll check how perf builds do it but I suspect they will also depend on
libc headers. This is fine for userspace tools, but we'd like to avoid
it for bpf programs.

- Tobias
