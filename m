Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 673A128002E
	for <lists+bpf@lfdr.de>; Thu,  1 Oct 2020 15:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732107AbgJANar (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Oct 2020 09:30:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35794 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731993AbgJANar (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Oct 2020 09:30:47 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601559045;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=jy07RVIIzkN80NqzGSqpiv3KKe434lq/SramsDIUsEA=;
        b=OYBR9cCSSEtH8Opt4cY8XrTU2qiXmAHkcdrtdud5C7L/McKDQOSYRHJNfeYk1o22xHdj6j
        sWlZg6yXyqo3R9TqmKThT4nkgheruiiJvcffrVDepRCJZrORf6a/GYvzDn8NB8eiz823qK
        XWi6SeEDwEt07Fy6AjYiq8F7CYPsEMt3TAtWieog9AIBJGq0VpG24LGQLn1F1nfdl5i+wn
        XkzSqB/4DrTHBwY6W3/EilblrRHz70h19X983dEZpe1WLVmEupCxXCp0Lm9OX4QZmNaCZe
        DCnImOmdaDwrTD1H19YIG3oQ9fGnuRVh1TCGLQ2zLx+kAVlW6kVjzgBEjOvyaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601559045;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=jy07RVIIzkN80NqzGSqpiv3KKe434lq/SramsDIUsEA=;
        b=u3S4S/wYW2p90qulUUuhcPkaj78LJ48UHJ6qCmUh6v/SeUSRhBKUfB7Hlxi6KHmy9TQcp9
        NKP/7R40ZLOQs2AQ==
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: mb2q experience and couple issues
In-Reply-To: <87sgayfgwz.fsf@nanos.tec.linutronix.de>
Date:   Thu, 01 Oct 2020 15:30:45 +0200
Message-ID: <87mu16f4ze.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 01 2020 at 11:13, Thomas Gleixner wrote:
> Yes, it's ugly and I haven't figured out a proper way to deal with
> that. There are quite some mbox formats out there and they all are
> incompatible with each other and all of them have different horrors.
>
> Let me think about it.

I've pushed out an update to

     git://git.kernel.org/pub/scm/linux/kernel/git/tglx/quilttools.git

which contains a few other things I was sitting on for a while.

The mailbox parser is now manual and tries for work around that
formatting nonsense with some sloppy heuristics which should be good
enough for kernel development. Having a valid unixfrom line in the
mail body of a patch is very unlikely :)

Thanks,

        tglx
