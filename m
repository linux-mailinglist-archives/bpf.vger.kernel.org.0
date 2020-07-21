Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0BA6227815
	for <lists+bpf@lfdr.de>; Tue, 21 Jul 2020 07:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgGUFYX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Jul 2020 01:24:23 -0400
Received: from verein.lst.de ([213.95.11.211]:50579 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725294AbgGUFYX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Jul 2020 01:24:23 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id DE2DB6736F; Tue, 21 Jul 2020 07:24:20 +0200 (CEST)
Date:   Tue, 21 Jul 2020 07:24:20 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
Subject: Re: BPF selftests build failures
Message-ID: <20200721052420.GA10123@lst.de>
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

That's not a very useful error message then.  Can you fix it to
tell people what is wrong?
