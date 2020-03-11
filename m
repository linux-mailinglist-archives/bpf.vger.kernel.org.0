Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68AC11818D2
	for <lists+bpf@lfdr.de>; Wed, 11 Mar 2020 13:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729320AbgCKMxj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Mar 2020 08:53:39 -0400
Received: from sym2.noone.org ([178.63.92.236]:56636 "EHLO sym2.noone.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729283AbgCKMxj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Mar 2020 08:53:39 -0400
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 48csMj3KHKzvjdX; Wed, 11 Mar 2020 13:53:37 +0100 (CET)
Date:   Wed, 11 Mar 2020 13:53:37 +0100
From:   Tobias Klauser <tklauser@distanz.ch>
To:     Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        bpf@vger.kernel.org
Subject: Re: [PATCH] bpftool: fix iprofiler build on systems without
 /usr/include/asm symlink
Message-ID: <20200311125336.3gatuo6tr7l5unog@distanz.ch>
References: <20200311123421.3634-1-tklauser@distanz.ch>
 <87tv2voy32.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87tv2voy32.fsf@toke.dk>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2020-03-11 at 13:49:53 +0100, Toke H�iland-J�rgensen <toke@redhat.com> wrote:
> Tobias Klauser <tklauser@distanz.ch> writes:
> 
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
> > To fix this, add /usr/include/$(uname -m)-linux-gnu to the clang search
> > path so <asm/types.h> can be found.
> 
> Isn't the right thing here to just install gcc-multilib?

For a container build we would like to avoid installing gcc-multilib
which pulls in additional dependencies which are otherwise not needed to
build bpftool. This patch would allow that.

Tobias
