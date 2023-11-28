Return-Path: <bpf+bounces-16044-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1537FBA17
	for <lists+bpf@lfdr.de>; Tue, 28 Nov 2023 13:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D56B1C21403
	for <lists+bpf@lfdr.de>; Tue, 28 Nov 2023 12:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8870056454;
	Tue, 28 Nov 2023 12:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bYIpG9V/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10AA4F88F;
	Tue, 28 Nov 2023 12:29:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED0C7C433C8;
	Tue, 28 Nov 2023 12:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701174560;
	bh=v96cDEV9MbfByYb9NPNlCmqYfiufZsErCbYgMwu2BUQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bYIpG9V/nf16+T5XBA728TfpOgEY1YAkYZ5VUPY0UvOjZgEP1I1LSurFgUEOq+uNf
	 TSw1sGxFTlz5qx5gDhX04GcZYad2N+h50lL+nJDgWSxo74WFVsV1D+gI4UjPh9+8Dc
	 V6hWK+c2zLUEj+PbtFCu8M1AFHhF8G+3fexrvWHW8AWj0U++JyQipVEail4tbp9fRY
	 i75kHG9Qc1KhG9z1PVSFw0pxST3jPz5cHqRi+QA5JWmdcsov6YkVJmwhtZCjjkC1Uh
	 7nQpVHVLfSzTnyY8VNa1qESRGpLHdFTG5sN9NLhXEd9y5n6o3MgpKbDGdUXEdsfpxY
	 sbhHZAbdFH2VA==
Date: Tue, 28 Nov 2023 21:29:15 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: kernel test robot <lkp@intel.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, oe-kbuild-all@lists.linux.dev, JP Kobryn
 <inwardvessel@gmail.com>, bpf@vger.kernel.org, kernel-team@meta.com,
 rostedt@goodmis.org, peterz@infradead.org
Subject: Re: [PATCH] rethook: Use __rcu pointer for rethook::handler
Message-Id: <20231128212915.75a0b550c34d5094894d8cb2@kernel.org>
In-Reply-To: <20231128080223.2c0bfdbe0738983b38250333@kernel.org>
References: <170078778632.209874.7893551840863388753.stgit@devnote2>
	<202311241808.rv9ceuAh-lkp@intel.com>
	<20231128080223.2c0bfdbe0738983b38250333@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Nov 2023 08:02:23 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Fri, 24 Nov 2023 23:40:57 +0800
> kernel test robot <lkp@intel.com> wrote:
> 
> > Hi Masami,
> > 
> > kernel test robot noticed the following build warnings:
> > 
> > [auto build test WARNING on linus/master]
> > [also build test WARNING on v6.7-rc2 next-20231124]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > 
> > url:    https://github.com/intel-lab-lkp/linux/commits/Masami-Hiramatsu-Google/rethook-Use-__rcu-pointer-for-rethook-handler/20231124-090634
> > base:   linus/master
> > patch link:    https://lore.kernel.org/r/170078778632.209874.7893551840863388753.stgit%40devnote2
> > patch subject: [PATCH] rethook: Use __rcu pointer for rethook::handler
> > config: x86_64-randconfig-r113-20231124 (https://download.01.org/0day-ci/archive/20231124/202311241808.rv9ceuAh-lkp@intel.com/config)
> > compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231124/202311241808.rv9ceuAh-lkp@intel.com/reproduce)
> 
> Let me fix this issue. It seems that sparse with function pointer
> needs a special care.

Hmm, I think we need to ignore some warnings from sparse for function pointer.

struct rethook {
	rethook_handler_t __rcu handler;
};

This doesn't work because the handler is not a pointer but a value type from
the sparse point of view(?)

So if we change the rethook_handler_t as below, most of the sparse warnings
are gone.

typedef void (__rcu *rethook_handler_t) (struct rethook_node *, void *, unsigned long, struct pt_regs *);
                  ^^^^^^

However, I found that this causes another warnings on the init function call
which requires rethook_handler_t as a parameter.

kernel/trace/fprobe.c:209:49: warning: incorrect type in argument 2 (different address spaces)
kernel/trace/fprobe.c:209:49:    expected void ( [noderef] __rcu *[usertype] handler )( ... )
kernel/trace/fprobe.c:209:49:    got void ( * )( ... )

        fp->rethook = rethook_alloc((void *)fp, fprobe_exit_handler,
							      ^^^^^^^^^^^^^^^^^^^^^^^^^
                                sizeof(struct fprobe_rethook_node), size);

Why? because fprobe_exit_handler() has no "__rcu"! Of course we can fix this
warning with force casting, e.g.

        fp->rethook = rethook_alloc((void *)fp, (rethook_handler_t)fprobe_exit_handler,

But this is totally wrong because it disables the compiler's type check!

One possible solution is to use a raw function pointer type for the
rethook_alloc() but that will be redundant or, just ignore
the sparse warnings as Documentation/RCU/rcu_dereference.rst said.

(Another tricky hack is to use a union just for rcu_assign_pointer/rcu_derefernce)

Thank you,


> 
> Thank you,
> 
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202311241808.rv9ceuAh-lkp@intel.com/
> > 
> > sparse warnings: (new ones prefixed by >>)
> > >> kernel/trace/rethook.c:51:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
> > >> kernel/trace/rethook.c:51:9: sparse:    void ( [noderef] __rcu * )( ... )
> > >> kernel/trace/rethook.c:51:9: sparse:    void ( * )( ... )
> >    kernel/trace/rethook.c:66:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
> >    kernel/trace/rethook.c:66:9: sparse:    void ( [noderef] __rcu * )( ... )
> >    kernel/trace/rethook.c:66:9: sparse:    void ( * )( ... )
> >    kernel/trace/rethook.c:110:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
> >    kernel/trace/rethook.c:110:9: sparse:    void ( [noderef] __rcu * )( ... )
> >    kernel/trace/rethook.c:110:9: sparse:    void ( * )( ... )
> >    kernel/trace/rethook.c:140:19: sparse: sparse: incompatible types in comparison expression (different address spaces):
> >    kernel/trace/rethook.c:140:19: sparse:    void ( [noderef] __rcu * )( ... )
> >    kernel/trace/rethook.c:140:19: sparse:    void ( * )( ... )
> >    kernel/trace/rethook.c:161:19: sparse: sparse: incompatible types in comparison expression (different address spaces):
> >    kernel/trace/rethook.c:161:19: sparse:    void ( [noderef] __rcu * )( ... )
> >    kernel/trace/rethook.c:161:19: sparse:    void ( * )( ... )
> >    kernel/trace/rethook.c:305:27: sparse: sparse: incompatible types in comparison expression (different address spaces):
> >    kernel/trace/rethook.c:305:27: sparse:    void ( [noderef] __rcu * )( ... )
> >    kernel/trace/rethook.c:305:27: sparse:    void ( * )( ... )
> > 
> > vim +51 kernel/trace/rethook.c
> > 
> >     40	
> >     41	/**
> >     42	 * rethook_stop() - Stop using a rethook.
> >     43	 * @rh: the struct rethook to stop.
> >     44	 *
> >     45	 * Stop using a rethook to prepare for freeing it. If you want to wait for
> >     46	 * all running rethook handler before calling rethook_free(), you need to
> >     47	 * call this first and wait RCU, and call rethook_free().
> >     48	 */
> >     49	void rethook_stop(struct rethook *rh)
> >     50	{
> >   > 51		rcu_assign_pointer(rh->handler, NULL);
> >     52	}
> >     53	
> > 
> > -- 
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

