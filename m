Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E040B34CD15
	for <lists+bpf@lfdr.de>; Mon, 29 Mar 2021 11:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbhC2Jap (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Mar 2021 05:30:45 -0400
Received: from elvis.franken.de ([193.175.24.41]:33835 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231853AbhC2JaX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Mar 2021 05:30:23 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1lQoE1-0003qb-01; Mon, 29 Mar 2021 11:30:21 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 9A93BC1D90; Mon, 29 Mar 2021 11:24:49 +0200 (CEST)
Date:   Mon, 29 Mar 2021 11:24:49 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     linux-mips@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>
Subject: Re: [PATCH v3] MIPS/bpf: Enable bpf_probe_read{, str}() on MIPS again
Message-ID: <20210329092449.GA8484@alpha.franken.de>
References: <1616676601-14478-1-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1616676601-14478-1-git-send-email-yangtiezhu@loongson.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 25, 2021 at 08:50:01PM +0800, Tiezhu Yang wrote:
> After commit 0ebeea8ca8a4 ("bpf: Restrict bpf_probe_read{, str}() only to
> archs where they work"), bpf_probe_read{, str}() functions were no longer
> available on MIPS, so there exist some errors when running bpf program:
> 
> root@linux:/home/loongson/bcc# python examples/tracing/task_switch.py
> bpf: Failed to load program: Invalid argument
> [...]
> 11: (85) call bpf_probe_read#4
> unknown func bpf_probe_read#4
> [...]
> Exception: Failed to load BPF program count_sched: Invalid argument
> 
> ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE should be restricted to archs
> with non-overlapping address ranges, but they can overlap in EVA mode
> on MIPS, so select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE if !EVA in
> arch/mips/Kconfig, otherwise the bpf old helper bpf_probe_read() will
> not be available.
> 
> This is similar with the commit d195b1d1d119 ("powerpc/bpf: Enable
> bpf_probe_read{, str}() on powerpc again").
> 
> Fixes: 0ebeea8ca8a4 ("bpf: Restrict bpf_probe_read{, str}() only to archs where they work")
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
> 
> v3: Select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE if !EVA
>     on MIPS.
> 
> v2: update the commit message to fix typos found by
>     Sergei Shtylyov, thank you!
> 
>     not longer --> no longer
>     there exists --> there exist
> 
>  arch/mips/Kconfig | 1 +
>  1 file changed, 1 insertion(+)

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
