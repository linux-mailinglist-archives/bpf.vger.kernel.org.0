Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01FC42B6D98
	for <lists+bpf@lfdr.de>; Tue, 17 Nov 2020 19:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbgKQSlL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Nov 2020 13:41:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbgKQSlK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Nov 2020 13:41:10 -0500
X-Greylist: delayed 1127 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 17 Nov 2020 10:41:10 PST
Received: from mail.rc.ru (mail.rc.ru [IPv6:2a01:7e00:e000:1bf::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7113C0613CF;
        Tue, 17 Nov 2020 10:41:10 -0800 (PST)
Received: from mail.rc.ru ([2a01:7e00:e000:1bf::1]:57724)
        by mail.rc.ru with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ink@jurassic.park.msu.ru>)
        id 1kf5cO-0004JI-KT; Tue, 17 Nov 2020 18:22:16 +0000
Date:   Tue, 17 Nov 2020 18:22:15 +0000
From:   Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Daniel Xu <dxu@dxuuu.xyz>, Matt Turner <mattst88@gmail.com>,
        Richard Henderson <rth@twiddle.net>, bpf <bpf@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>, andrii.nakryiko@gmail.com,
        kernel-team@fb.com
Subject: Re: [PATCH bpf v6 1/2] lib/strncpy_from_user.c: Don't overcopy bytes
 after NUL terminator
Message-ID: <20201117182215.GA15956@mail.rc.ru>
References: <cover.1605560917.git.dxu@dxuuu.xyz>
 <470ffc3c76414443fc359b884080a5394dcccec3.1605560917.git.dxu@dxuuu.xyz>
 <CAHk-=wggUw3XYffJ-od8Dbfh-JkXkEuCPjSRR2Z+8HrNUNxJ=g@mail.gmail.com>
 <CAHk-=wiEgTXYgLXg8YxRHnH+eZno800pEp8caskKgDCgq55s+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiEgTXYgLXg8YxRHnH+eZno800pEp8caskKgDCgq55s+g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 16, 2020 at 02:44:56PM -0800, Linus Torvalds wrote:
> On Mon, Nov 16, 2020 at 2:15 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > So I've verified that at least on x86-64, this doesn't really make
> > code generation any worse, and I'm ok with the patch from that
> > standpoint.
> 
> .. looking closer, it will generate extra code on big-endian
> architectures and on alpha, because of the added "zero_bytemask()".
> But on the usual LE machines, zero_bytemask() will already be the same
> as "mask", so all it adds is that "and" operation with values it
> already had access to.
> 
> I don't think anybody cares about alpha and BE - traditional BE
> architectures have moved to LE anyway. And looking at the alpha
> word-at-a-time code, I don't even understand how it works at all.
> 
> Adding matt/rth/ivan to the cc, just so that maybe one of them can
> educate me on how that odd alpha zero_bytemask() could possibly work.
> The "2ul << .." part confuses me, I think it should be "1ul << ...".
> 
> I get the feeling that the alpha "2ul" constant might have come from
> the tile version, but in the tile version, the " __builtin_ctzl()"
> counts the leading zeroes to the top bit of any bytes in 'mask'. But
> the alpha version actually uses "find_zero(mask) * 8", so rather than
> have values of 7/15/23/... (for zero byte in byte 0/1/2/..
> respectively), it has values 0/8/16/....
> 
> But it's entirely possible that I'm completely confused, and alpha
> does it right, and I'm just not understanding the code.

No, you are right, it should be "1ul". Indeed, seems like it came from
the tile version which looks incorrect either, BTW. The tile-gx ISA
(https://studylib.net/doc/18755547/tile-gx-instruction-set-architecture)
says that clz/ctz instructions count up to the first "1", not to the
last "0", so the shift values in tile's zero_bytemask() are 0/8/16/...
as well.

> It's also possible that the "2ul" vs "1ul" case doesn't matter.
> because the extra bit is always going to mask the byte that is
> actually zero, so being one bit off in the result is a non-event. I
> think that is what may actually be going on.

Yes, looks like that.

Ivan.
