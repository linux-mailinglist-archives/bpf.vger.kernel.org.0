Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFF811D22E0
	for <lists+bpf@lfdr.de>; Thu, 14 May 2020 01:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732466AbgEMXUi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 May 2020 19:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732446AbgEMXUh (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 13 May 2020 19:20:37 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0974AC061A0E
        for <bpf@vger.kernel.org>; Wed, 13 May 2020 16:20:37 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id 8so989309lfp.4
        for <bpf@vger.kernel.org>; Wed, 13 May 2020 16:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=phWq6l4aTvr/C2K/X4+k/YrVnCjrPXRTWTh12+oYaOk=;
        b=cD3d6Z8Oy8/Dx9WXsRuTcoa6/5Rh9rx4ZXh8joWvH4poHn6SlmiaIW98FjAPsN6Nbh
         x66jaomRN8ZljFVlOmAhCKb3qMEmAXGGOLhPnCxRlO2Vc19b0KxaWqaBnUOu9g5IgaPv
         XmTXcJb6msXzq5HV1afcp377hyESwqrNggFac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=phWq6l4aTvr/C2K/X4+k/YrVnCjrPXRTWTh12+oYaOk=;
        b=PTeQHhVfHx3bJkDR5iR8X5ARZ2swfvud2wIt+CtYcaUOjnwIBPJM3H4lyyoFgOoR5B
         yaZUuRMfoBmZNz7cgyn1XABQaZ7D4hflNF5FTBAPcjVfFDLvPoyM7Q8FrfrXTMAH1G00
         cJXGCZyXY5UkD844gZL/Wmv/t4rATh/eOoLaWo49PP07VnzMZMTQi5sxDo0JTVx1fI29
         83L7vVZB+RF5aoe5ow2uYVJtU/Gf6YJr3n2bwpdB8Fhkq6eGT9uk875p0GAt8eg4qIR1
         61FuySVIB2bnHHQejvFIcHGw50zm4vRe4T6nr2sKF8ZA5b5w3MY0z8v542BRQK3HuB17
         qO0Q==
X-Gm-Message-State: AOAM533pLCzHhNYyE9+qzeTJnKINBMjRJjzqqKP1OHGmnbwNebHBV4E8
        cMAav3g5n612G98R/yztc7+pQ15PYtw=
X-Google-Smtp-Source: ABdhPJxivFOX+RY9VKH7gy2gsdyucbBpisy6R2FdIBHKn5p3bZYD8+eQ1RXUnOUEiX+ixe4HvDpqWg==
X-Received: by 2002:ac2:48a8:: with SMTP id u8mr1161241lfg.41.1589412035008;
        Wed, 13 May 2020 16:20:35 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id k1sm579820lfc.40.2020.05.13.16.20.33
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 16:20:34 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id x73so996042lfa.2
        for <bpf@vger.kernel.org>; Wed, 13 May 2020 16:20:33 -0700 (PDT)
X-Received: by 2002:a19:ed07:: with SMTP id y7mr1180765lfy.31.1589412033540;
 Wed, 13 May 2020 16:20:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200513160038.2482415-1-hch@lst.de> <10c58b09-5ece-e49f-a7c8-2aa6dfd22fb4@iogearbox.net>
In-Reply-To: <10c58b09-5ece-e49f-a7c8-2aa6dfd22fb4@iogearbox.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 13 May 2020 16:20:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjJKo0GVixYLmqPn-Q22WFu0xHaBSjKEo7e7Yw72y5SPQ@mail.gmail.com>
Message-ID: <CAHk-=wjJKo0GVixYLmqPn-Q22WFu0xHaBSjKEo7e7Yw72y5SPQ@mail.gmail.com>
Subject: Re: clean up and streamline probe_kernel_* and friends v2
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Christoph Hellwig <hch@lst.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-parisc@vger.kernel.org,
        linux-um <linux-um@lists.infradead.org>,
        Netdev <netdev@vger.kernel.org>, bpf@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 13, 2020 at 4:04 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> Aside from comments on list, the series looks reasonable to me. For BPF
> the bpf_probe_read() helper would be slightly penalized for probing user
> memory given we now test on copy_from_kernel_nofault() first and if that
> fails only then fall back to copy_from_user_nofault(),

Again, no.

If you can't tell that one or the other is always the right thing,
then that function is simply buggy and wrong.

On sparc and on s390, address X can be _both_ a kernel address and a
user address. You need to specify which it is (by using the proper
function). The whole "try one first, then the other" doesn't work.
They may both "work", and by virtue of that, unless you can state
"yes, we always want user space" or "yes, we always want kernel", that
"try one or the other" isn't valid.

And it can be a real security issue. If a user program can be made to
read kernel memory when BPF validated things as a user pointer, it's
an obvious security issue.

But it can be a security issue the other way around too: if the BPF
code expects to get a kernel string, but user space can fool it into
reading a user string instead by mapping something of its own into the
user space address that aliases the kernel space address, then you can
presumably fool the BPF program to do bad things too (eg mess up any
BPF packet switching routines?).

So BPF really really really needs to specify which one it is. Not
specifying it and saying "whichever" is a bug, and a security issue.

             Linus
