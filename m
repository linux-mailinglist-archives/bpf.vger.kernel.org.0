Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91A8252382A
	for <lists+bpf@lfdr.de>; Wed, 11 May 2022 18:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiEKQJ7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 May 2022 12:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344358AbiEKQJA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 May 2022 12:09:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938CF210B9A;
        Wed, 11 May 2022 09:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CkAu99ZLp/81iZgCJ+Qly9iNgOBxGjfNw8JLejG9Uco=; b=fIkbkITC5Dn6bIUOH6mSIgsIic
        yboQ50w87z104kAZoRCvo4uNflQyNGnwzfqRmOC5psOxWs/1x4LKOsIlhUoV/j6YEBU5hTRLQ54xA
        L01x7O/xD3J0J0q8g+4dfZ6Gh0K0KpY4AaseBx5+CZVSWGQnFmhcfYAhnMyI/JyhmeFmICmlQk3sp
        9s0cfrahmbB5am7aWsfDl0AMu/kNXVdQy2XCQmXKvn+d/V4A6APdD5XIVT5Nx+HVVVKr+0oBdeidK
        kfu5F+iQB0IVHojMlLBWlz2mDpqbonGSGkdY+0fcSMNdIczWlYMOruXyzsy1SvcSWbVCS2L98gpZ3
        1rAieTRw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nootS-007iNX-Rh; Wed, 11 May 2022 16:08:54 +0000
Date:   Wed, 11 May 2022 09:08:54 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>, bpf <bpf@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] bpf.h: fix clang compiler warning with
 unpriv_ebpf_notify()
Message-ID: <YnvflsM1t5vL/ViP@bombadil.infradead.org>
References: <20220509203623.3856965-1-mcgrof@kernel.org>
 <YnvdOAaYmhNiA5WN@bombadil.infradead.org>
 <CAADnVQLCvjqphpJDkz-5bpJLs3k_PRH1JcwehCRLrWYvsA9ENw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQLCvjqphpJDkz-5bpJLs3k_PRH1JcwehCRLrWYvsA9ENw@mail.gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 11, 2022 at 09:03:13AM -0700, Alexei Starovoitov wrote:
> On Wed, May 11, 2022 at 8:58 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > On Mon, May 09, 2022 at 01:36:23PM -0700, Luis Chamberlain wrote:
> > > The recent commit "bpf: Move BPF sysctls from kernel/sysctl.c to BPF core"
> > > triggered 0-day to issue an email for what seems to have been an old
> > > clang warning. So this issue should have existed before as well, from
> > > what I can tell. The issue is that clang expects a forward declaration
> > > for routines declared as weak while gcc does not.
> > >
> > > This can be reproduced with 0-day's x86_64-randconfig-c007
> > > https://download.01.org/0day-ci/archive/20220424/202204240008.JDntM9cU-lkp@intel.com/config
> > >
> > > And using:
> > >
> > > COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=x86_64 SHELL=/bin/bash kernel/bpf/syscall.o
> > > Compiler will be installed in /home/mcgrof/0day
> > > make --keep-going HOSTCC=/home/mcgrof/0day/clang/bin/clang CC=/home/mcgrof/0day/clang/bin/clang LD=/home/mcgrof/0day/clang/bin/ld.lld HOSTLD=/home/mcgrof/0day/clang/bin/ld.lld AR=llvm-ar NM=llvm-nm STRIP=llvm-strip OBJCOPY=llvm-objcopy OBJDUMP=llvm-objdump OBJSIZE=llvm-size READELF=llvm-readelf HOSTCXX=clang++ HOSTAR=llvm-ar CROSS_COMPILE=x86_64-linux-gnu- --jobs=24 W=1 ARCH=x86_64 SHELL=/bin/bash kernel/bpf/syscall.o
> > >   DESCEND objtool
> > >   CALL    scripts/atomic/check-atomics.sh
> > >   CALL    scripts/checksyscalls.sh
> > >   CC      kernel/bpf/syscall.o
> > > kernel/bpf/syscall.c:4944:13: warning: no previous prototype for function 'unpriv_ebpf_notify' [-Wmissing-prototypes]
> > > void __weak unpriv_ebpf_notify(int new_state)
> > >             ^
> > > kernel/bpf/syscall.c:4944:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
> > > void __weak unpriv_ebpf_notify(int new_state)
> > > ^
> > > static
> > >
> > > Fixes: 2900005ea287 ("bpf: Move BPF sysctls from kernel/sysctl.c to BPF core")
> > > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> > > ---
> > >
> > > Daniel,
> > >
> > > Given what we did fore 2900005ea287 ("bpf: Move BPF sysctls from
> > > kernel/sysctl.c to BPF core") where I had pulled pr/bpf-sysctl a
> > > while ago into sysctl-next and then merged the patch in question,
> > > should I just safely carry this patch onto sysctl-next? Let me know
> > > how you'd like to proceed.
> > >
> > > Also, it wasn't clear if putting this forward declaration on
> > > bpf.h was your ideal preference.
> >
> > After testing this on sysctl-testing without issues going to move this
> > to sysctl-next now.
> 
> Hmm. No.
> A similar patch should be in tip already. You have to wait
> for it to go through Linus's tree and back to whatever tree you use.

I'm a bit confused, the patch in question which my patch fixes should only
be in my sysctl-next tree at this point, not in Linus's tree.

  Luis
