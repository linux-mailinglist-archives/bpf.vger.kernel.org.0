Return-Path: <bpf+bounces-18245-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F11817E54
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 01:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EB5A1F23CB1
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 00:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2EA18BFD;
	Tue, 19 Dec 2023 00:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rr8a9wCc"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7FE7472;
	Tue, 19 Dec 2023 00:01:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C79BC433C8;
	Tue, 19 Dec 2023 00:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702944079;
	bh=fMgl5f1cxsDp2Ro+Gy0GmSHDb4UdBfrTzpxZdw6xSOI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rr8a9wCcxzUWjy+33BEpF+Rz/shtCM1gzDwv6ucq4Mp+VdWWx+hVaiF+tmXKbzUQ7
	 wObo1de1uj0lA8td3opQu8p2rEAxvlh+inTqEEmqXhxdvD0qtAD6IhSfTs4NII0EIG
	 lw+Zey2sh4dFZYPEWd/NGIGXAmjGKubHZm5SgQzagOwYliWG5sFMICElNin3u4lOHE
	 f6rzfFg29C//Uw1vAdwPHRcW3a2mGwhnNKM0o95Z/7d3mbznhulW2VnALuxSiCMA34
	 aRbeIFGIE9JczjyLsDc+cmS8RyBopRKqHd967KNsrt6slkFwU68j+plOP3/yNrqDAf
	 r20wNTWUyx20g==
Date: Mon, 18 Dec 2023 17:01:16 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Boqun Feng <boqun.feng@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>, bpf@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org
Subject: Re: [PATCH net-next 20/24] net: intel: Use nested-BH locking for XDP
 redirect.
Message-ID: <20231219000116.GA3956476@dev-arch.thelio-3990X>
References: <20231215171020.687342-21-bigeasy@linutronix.de>
 <202312161212.D5tju5i6-lkp@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202312161212.D5tju5i6-lkp@intel.com>

On Sat, Dec 16, 2023 at 12:53:43PM +0800, kernel test robot wrote:
> Hi Sebastian,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on net-next/main]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Sebastian-Andrzej-Siewior/locking-local_lock-Introduce-guard-definition-for-local_lock/20231216-011911
> base:   net-next/main
> patch link:    https://lore.kernel.org/r/20231215171020.687342-21-bigeasy%40linutronix.de
> patch subject: [PATCH net-next 20/24] net: intel: Use nested-BH locking for XDP redirect.
> config: arm-defconfig (https://download.01.org/0day-ci/archive/20231216/202312161212.D5tju5i6-lkp@intel.com/config)
> compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231216/202312161212.D5tju5i6-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202312161212.D5tju5i6-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
> >> drivers/net/ethernet/intel/igb/igb_main.c:8620:3: error: cannot jump from this goto statement to its label
>                    goto xdp_out;
>                    ^
>    drivers/net/ethernet/intel/igb/igb_main.c:8624:2: note: jump bypasses initialization of variable with __attribute__((cleanup))
>            guard(local_lock_nested_bh)(&bpf_run_lock.redirect_lock);
>            ^
>    include/linux/cleanup.h:142:15: note: expanded from macro 'guard'
>            CLASS(_name, __UNIQUE_ID(guard))
>                         ^
>    include/linux/compiler.h:180:29: note: expanded from macro '__UNIQUE_ID'
>    #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
>                                ^
>    include/linux/compiler_types.h:84:22: note: expanded from macro '__PASTE'
>    #define __PASTE(a,b) ___PASTE(a,b)
>                         ^
>    include/linux/compiler_types.h:83:23: note: expanded from macro '___PASTE'
>    #define ___PASTE(a,b) a##b
>                          ^
>    <scratch space>:52:1: note: expanded from here
>    __UNIQUE_ID_guard753
>    ^
>    1 error generated.

I initially thought that this may have been
https://github.com/ClangBuiltLinux/linux/issues/1886 but asm goto is not
involved here.

This error occurs because jumping over the initialization of a variable
declared with __attribute__((__cleanup__(...))) does not prevent the
clean up function from running as one may expect it to, but could
instead result in the clean up function getting run on uninitialized
memory. A contrived example (see the bottom of the "Output" tabs for the
execution output):

https://godbolt.org/z/9bvGboxvc

While there is a warning from GCC in that example, I don't see one in
the kernel's case. I see there is an open GCC issue around this problem:

https://gcc.gnu.org/bugzilla/show_bug.cgi?id=91951

While it is possible that there may not actually be a problem with how
the kernel uses __attribute__((__cleanup__(...))) and gotos, I think
clang's behavior is reasonable given the potential footguns that this
construct has.

Cheers,
Nathan

