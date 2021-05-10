Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 194283796D1
	for <lists+bpf@lfdr.de>; Mon, 10 May 2021 20:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbhEJSKG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 May 2021 14:10:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:45148 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230357AbhEJSKG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 May 2021 14:10:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5C4F9ADDC;
        Mon, 10 May 2021 18:09:00 +0000 (UTC)
Date:   Mon, 10 May 2021 20:08:58 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, dwarves@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v2 dwarves] btf: Remove ftrace filter
Message-ID: <20210510180858.GI12700@kitsune.suse.cz>
References: <20210506205622.3663956-1-kafai@fb.com>
 <YJSr7S7dRty3K8Wd@archlinux-ax161>
 <20210508050321.2qrmkzq7zjpphqo7@kafai-mbp.dhcp.thefacebook.com>
 <20210508105301.GD12700@kitsune.suse.cz>
 <20210510180059.tz527zrb6bcqjrl7@kafai-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210510180059.tz527zrb6bcqjrl7@kafai-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, May 10, 2021 at 11:00:59AM -0700, Martin KaFai Lau wrote:
> On Sat, May 08, 2021 at 12:53:01PM +0200, Michal Suchánek wrote:
> > On Fri, May 07, 2021 at 10:03:21PM -0700, Martin KaFai Lau wrote:
> > > On Thu, May 06, 2021 at 07:54:37PM -0700, Nathan Chancellor wrote:
> > > > On Thu, May 06, 2021 at 01:56:22PM -0700, Martin KaFai Lau wrote:
> > > > > BTF is currently generated for functions that are in ftrace list
> > > > > or extern.
> > > > > 
> > > > > A recent use case also needs BTF generated for functions included in
> > > > > allowlist.  In particular, the kernel
> > > > > commit e78aea8b2170 ("bpf: tcp: Put some tcp cong functions in allowlist for bpf-tcp-cc")
> > > > > allows bpf program to directly call a few tcp cc kernel functions. Those
> > > > > kernel functions are currently allowed only if CONFIG_DYNAMIC_FTRACE
> > > > > is set to ensure they are in the ftrace list but this kconfig dependency
> > > > > is unnecessary.
> > > > > 
> > > > > Those kernel functions are specified under an ELF section .BTF_ids.
> > > > > There was an earlier attempt [0] to add another filter for the functions in
> > > > > the .BTF_ids section.  That discussion concluded that the ftrace filter
> > > > > should be removed instead.
> > > > > 
> > > > > This patch is to remove the ftrace filter and its related functions.
> > > > > 
> > > > > Number of BTF FUNC with and without is_ftrace_func():
> > > > > My kconfig in x86: 40643 vs 46225
> > > > > Jiri reported on arm: 25022 vs 55812
> > > > > 
> > > > > [0]: https://lore.kernel.org/dwarves/20210423213728.3538141-1-kafai@fb.com/
> > > > > 
> > > > > Cc: Andrii Nakryiko <andrii@kernel.org>
> > > > > Cc: Jiri Olsa <jolsa@kernel.org>
> > > > > Signed-off-by: Martin KaFai Lau <kafai@fb.com>
> > > > 
> > > > This fixes an issue with Fedora's s390x config that CKI noticed:
> > > > 
> > > > https://groups.google.com/g/clang-built-linux/c/IzthpckBJvc/m/MPWGDmXiAwAJ  
> > > > 
> > > > Tested-by: Nathan Chancellor <nathan@kernel.org> # build
> > > Thanks all for reviewing and testing.
> > > 
> > > In my cross compile ppc64 test, it does not solve the issue.
> > > The problem is the tcp-cc functions (e.g. "cublictcp_*")
> > > are not STT_FUNC in ppc64, so they are not collected in collect_function().
> > > The ".cubictcp_*" is STT_FUNC though.
> > > 
> > > Since only the x86 (64 and 32) bpf jit can call these tcp-cc functions now
> > > and there is no usage for adding them to .BTF_ids for other ARCHs,
> > > I have post a patch to limit them to x86:
> > > https://lore.kernel.org/bpf/20210508005011.3863757-1-kafai@fb.com/
> > 
> > That's probably not the way to go. If function symbols start with a dot
> > in ppc64 elfv1 abi then pahole should learn to add a dot for ppc64 elfv1
> > abi.
> > 
> > Or we can build ppc64 BE using the elfv2 abi and depend on elfv2 abi for
> > BTF on ppc64. The patch for enabling elfv2 for BE is currently under
> > discussion and I have the patch that adds the dependency ready as well.
> ic.  I just learned the elfv2/LE vs elfv1/BE difference in ppc64.
> elfv2 BE ppc64 support is on its way, so it is better to have DEBUG_INFO_BTF
> depending on the ppc64-elfv2 related kconfig(s) instead of making an exception
> handling in pahole.
> 
> If you have the	BTF ppc64-elfv2 dependency patch ready, does it make
> sense to land this patch first independent of the ppc64 elfv2/BE
> effort?

It kind of depends on the result of the config option name bikeshedding
so it has to be merged after.

Thanks

Michal
