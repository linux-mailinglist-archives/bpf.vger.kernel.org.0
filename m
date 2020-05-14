Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CDB91D2465
	for <lists+bpf@lfdr.de>; Thu, 14 May 2020 03:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbgENBAP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 May 2020 21:00:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:59754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbgENBAP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 May 2020 21:00:15 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5F482054F;
        Thu, 14 May 2020 01:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589418014;
        bh=iL3qRo6PKMlX7MXjMuhMdIo6UsuawSg8IZnaTVQPWcw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eMXyaK/bX8VY/yTLe5XB8JtMJrtcjjev1fGQABBIMNzXe1l1nVaonllA6Js7jUFE/
         roA4DNirFqPNV8zYvxpE5SZpnZrPScPhYauQnT6eTn3ErV59izLzTc8zoDjhqVpUBV
         xIAKU4KFe9w7hOY+jhok+DYEHeqUtAEj9JByg/IQ=
Date:   Thu, 14 May 2020 10:00:09 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Christoph Hellwig <hch@lst.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-parisc@vger.kernel.org,
        linux-um <linux-um@lists.infradead.org>,
        Netdev <netdev@vger.kernel.org>, bpf@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 11/18] maccess: remove strncpy_from_unsafe
Message-Id: <20200514100009.a8e6aa001f0ace5553c7904f@kernel.org>
In-Reply-To: <CAHk-=wjBKGLyf1d53GwfUTZiK_XPdujwh+u2XSpD2HWRV01Afw@mail.gmail.com>
References: <20200513160038.2482415-1-hch@lst.de>
        <20200513160038.2482415-12-hch@lst.de>
        <CAHk-=wj=u+nttmd1huNES2U=9nePtmk7WgR8cMLCYS8wc=rhdA@mail.gmail.com>
        <20200513192804.GA30751@lst.de>
        <0c1a7066-b269-9695-b94a-bb5f4f20ebd8@iogearbox.net>
        <20200514082054.f817721ce196f134e6820644@kernel.org>
        <CAHk-=wjBKGLyf1d53GwfUTZiK_XPdujwh+u2XSpD2HWRV01Afw@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 13 May 2020 16:59:40 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Wed, May 13, 2020 at 4:21 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> >
> > For trace_kprobe.c current order (kernel -> user fallback) is preferred
> > because it has another function dedicated for user memory.
> 
> Well, then it should just use the "strict" kernel-only one for the
> non-user memory.
> 
> But yes, if there are legacy interfaces, then we might want to say
> "these continue to work for the legacy case on platforms where we can
> tell which kind of pointer it is from the bit pattern".

Yes, that was why I changed my mind and send reviewed-by last time.

https://lore.kernel.org/bpf/20200511142716.f1ff6fc55220012982c47fec@kernel.org/

> But we should likely at least disallow it entirely on platforms where
> we really can't - or pick one hardcoded choice. On sparc, you really
> _have_ to specify one or the other.

OK. BTW, is there any way to detect the kernel/user space overlap on
memory layout statically? If there, I can do it. (I don't like
"if (CONFIG_X86)" thing....)
Or, maybe we need CONFIG_ARCH_OVERLAP_ADDRESS_SPACE?

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
