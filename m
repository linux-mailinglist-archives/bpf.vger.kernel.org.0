Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D830F182DA4
	for <lists+bpf@lfdr.de>; Thu, 12 Mar 2020 11:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgCLKaW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Mar 2020 06:30:22 -0400
Received: from sym2.noone.org ([178.63.92.236]:45274 "EHLO sym2.noone.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726023AbgCLKaV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Mar 2020 06:30:21 -0400
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 48dQ7v5fxtzvjdW; Thu, 12 Mar 2020 11:30:19 +0100 (CET)
Date:   Thu, 12 Mar 2020 11:30:19 +0100
From:   Tobias Klauser <tklauser@distanz.ch>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v2] bpftool: fix profiler build on systems
 without /usr/include/asm symlink
Message-ID: <20200312103018.z6spkkn7oijijt7h@distanz.ch>
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

Sorry, my earlier reply was wrong. Adding
tools/testing/selftests/bpf/include/uapi/ to the search path (and
tools/include/uapi/ in addition) makes this work. Will send a v3.
