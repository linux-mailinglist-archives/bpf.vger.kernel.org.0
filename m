Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F29B033FBAC
	for <lists+bpf@lfdr.de>; Thu, 18 Mar 2021 00:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbhCQXJA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Mar 2021 19:09:00 -0400
Received: from elvis.franken.de ([193.175.24.41]:38983 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229472AbhCQXI3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Mar 2021 19:08:29 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1lMfHA-0002xB-00; Thu, 18 Mar 2021 00:08:28 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 491F7C0CF7; Thu, 18 Mar 2021 00:08:08 +0100 (CET)
Date:   Thu, 18 Mar 2021 00:08:08 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Tiezhu Yang <yangtiezhu@loongson.cn>, linux-mips@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>
Subject: Re: [PATCH] MIPS/bpf: Enable bpf_probe_read{, str}() on MIPS again
Message-ID: <20210317230808.GA22680@alpha.franken.de>
References: <1615965307-6926-1-git-send-email-yangtiezhu@loongson.cn>
 <6b239565-8fbb-d183-6a4d-13fc90af3e27@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b239565-8fbb-d183-6a4d-13fc90af3e27@iogearbox.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 17, 2021 at 11:18:48PM +0100, Daniel Borkmann wrote:
> On 3/17/21 8:15 AM, Tiezhu Yang wrote:
> > After commit 0ebeea8ca8a4 ("bpf: Restrict bpf_probe_read{, str}() only to
> > archs where they work"), bpf_probe_read{, str}() functions were not longer
> > available on MIPS, so there exists some errors when running bpf program:
> > 
> > root@linux:/home/loongson/bcc# python examples/tracing/task_switch.py
> > bpf: Failed to load program: Invalid argument
> > [...]
> > 11: (85) call bpf_probe_read#4
> > unknown func bpf_probe_read#4
> > [...]
> > Exception: Failed to load BPF program count_sched: Invalid argument
> > 
> > So select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE in arch/mips/Kconfig,
> > otherwise the bpf old helper bpf_probe_read() will not be available.
> > 
> > This is similar with the commit d195b1d1d1196 ("powerpc/bpf: Enable
> > bpf_probe_read{, str}() on powerpc again").
> > 
> > Fixes: 0ebeea8ca8a4 ("bpf: Restrict bpf_probe_read{, str}() only to archs where they work")
> > Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> 
> Thomas, I presume you pick this up via mips tree (with typos fixed)? Or do you
> want us to route the fix via bpf with your ACK? (I'm fine either way.)

I'll take it via mips tree.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
