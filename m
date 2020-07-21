Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0D8622792B
	for <lists+bpf@lfdr.de>; Tue, 21 Jul 2020 09:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgGUHEl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Jul 2020 03:04:41 -0400
Received: from verein.lst.de ([213.95.11.211]:50836 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726474AbgGUHEk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Jul 2020 03:04:40 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id D9F6468AFE; Tue, 21 Jul 2020 09:04:37 +0200 (CEST)
Date:   Tue, 21 Jul 2020 09:04:37 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
Subject: Re: BPF selftests build failures
Message-ID: <20200721070437.GA11432@lst.de>
References: <20200720080943.GA12596@lst.de> <20200720204152.w7h3zmwtbjsuwgie@ast-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720204152.w7h3zmwtbjsuwgie@ast-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jul 20, 2020 at 01:41:52PM -0700, Alexei Starovoitov wrote:
> On Mon, Jul 20, 2020 at 10:09:43AM +0200, Christoph Hellwig wrote:
> > Hi BPF and selftest maintainers.  I get a very strange failure
> > when trying to build the bpf selftests on current net-next master:
> > 
> > hch@brick:~/work/linux/tools/testing/selftests/bpf$ make
> >   GEN      vmlinux.h
> > Error: failed to load BTF from /home/hch/work/linux/vmlinux: No such file or directory
> 
> That's bpftool complaining that BTF is not present in vmlinux.
> You need CONFIG_DEBUG_INFO_BTF=y and pahole >= v1.16
> You also need llvm 10 to build bpf progs.

Oh well, after the non-obvious enabling of CONFIG_DEBUG_INFO_BTF
I did run into the too old clang (clang 9) as well, which just
creates random errors instead of warning about a too old compiler,
sight.

Then I installed clang-10, but there still seem to be various
failures in the net-next baseline, and the setsockopt code I'm
trying to test doesn't even get exercised from sticking a printk
in there.

That is not a great testcase experience..
