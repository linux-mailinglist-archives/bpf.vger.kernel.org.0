Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F75164AE53
	for <lists+bpf@lfdr.de>; Tue, 13 Dec 2022 04:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234124AbiLMDkN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Dec 2022 22:40:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233011AbiLMDkL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Dec 2022 22:40:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2151165B0;
        Mon, 12 Dec 2022 19:40:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F73B60010;
        Tue, 13 Dec 2022 03:40:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12435C433EF;
        Tue, 13 Dec 2022 03:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670902809;
        bh=PuaMtd9Ko9oKGDiXgVRIj/a4xvUODdQ/B4oxxqDZ7c8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XYP8Megaky1qyd/xQdpdFApyCOwndCcbK+hx81uMA4QDknyfTelScxtjKXwLbMUmr
         tK0LYU7XlzPu2R6mtVIufEJKn+62gE5LlLhsA4M8RZDv7qwmV+Bh07a0cQAzF509/j
         XJHMKgxNPJ2RieeVdfjW1YdIm4F9GbRM6fcIlcbT621i0NzCto/hXekI6EDu7Gk/Z5
         iba2clS4rMJdF2wSxvU69Cokeh9dhn5PFNuz9MQjfXi22lWKtmxFlNVQo8oAej93J/
         6fK+EYD42JyikLEI71tYyaJmH58spZtnWFpO0FLrSDWXi4qBd1iqGsY4qi9ayjbOkG
         oMQq+GUoeUfvQ==
Date:   Tue, 13 Dec 2022 12:40:03 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, bpf@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        KP Singh <kpsingh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Florent Revest <revest@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Chris Mason <chris.mason@fusionio.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/2] error-injection: Remove EI_ETYPE_NONE
Message-Id: <20221213124003.0326455ee28b9cdae474bbae@kernel.org>
In-Reply-To: <202212121204.d4rb2G55-lkp@intel.com>
References: <167081320421.387937.4259807348852421112.stgit@devnote3>
        <202212121204.d4rb2G55-lkp@intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 12 Dec 2022 12:55:24 +0800
kernel test robot <lkp@intel.com> wrote:

> Hi Masami,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on arnd-asm-generic/master]
> [also build test ERROR on linus/master v6.1 next-20221208]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Masami-Hiramatsu-Google/error-injection-Clarify-the-requirements-of-error-injectable-functions/20221212-104859
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git master
> patch link:    https://lore.kernel.org/r/167081320421.387937.4259807348852421112.stgit%40devnote3
> patch subject: [PATCH 1/2] error-injection: Remove EI_ETYPE_NONE
> config: hexagon-randconfig-r045-20221211
> compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 6e4cea55f0d1104408b26ac574566a0e4de48036)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/ffd600c8d5c881bc0e58401c24c7457a566f6207
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Masami-Hiramatsu-Google/error-injection-Clarify-the-requirements-of-error-injectable-functions/20221212-104859
>         git checkout ffd600c8d5c881bc0e58401c24c7457a566f6207
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash fs/btrfs/
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from fs/btrfs/tree-checker.c:20:
> >> include/linux/error-injection.h:22:10: error: use of undeclared identifier 'EOPNOTSUPP'
>            return -EOPNOTSUPP;

Oops, I need to include linux/errno.h. Let me update it.

Thanks!

>                    ^
>    In file included from fs/btrfs/tree-checker.c:21:
>    In file included from fs/btrfs/ctree.h:9:
>    In file included from include/linux/mm.h:737:
>    In file included from include/linux/huge_mm.h:8:
>    In file included from include/linux/fs.h:33:
>    In file included from include/linux/percpu-rwsem.h:7:
>    In file included from include/linux/rcuwait.h:6:
>    In file included from include/linux/sched/signal.h:6:
>    include/linux/signal.h:97:11: warning: array index 3 is past the end of the array (that has type 'unsigned long[2]') [-Warray-bounds]
>                    return (set->sig[3] | set->sig[2] |
>                            ^        ~
>    include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
>            unsigned long sig[_NSIG_WORDS];
>            ^
>    In file included from fs/btrfs/tree-checker.c:21:
>    In file included from fs/btrfs/ctree.h:9:
>    In file included from include/linux/mm.h:737:
>    In file included from include/linux/huge_mm.h:8:
>    In file included from include/linux/fs.h:33:
>    In file included from include/linux/percpu-rwsem.h:7:
>    In file included from include/linux/rcuwait.h:6:
>    In file included from include/linux/sched/signal.h:6:
>    include/linux/signal.h:97:25: warning: array index 2 is past the end of the array (that has type 'unsigned long[2]') [-Warray-bounds]
>                    return (set->sig[3] | set->sig[2] |
>                                          ^        ~
>    include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
>            unsigned long sig[_NSIG_WORDS];
>            ^
>    In file included from fs/btrfs/tree-checker.c:21:
>    In file included from fs/btrfs/ctree.h:9:
>    In file included from include/linux/mm.h:737:
>    In file included from include/linux/huge_mm.h:8:
>    In file included from include/linux/fs.h:33:
>    In file included from include/linux/percpu-rwsem.h:7:
>    In file included from include/linux/rcuwait.h:6:
>    In file included from include/linux/sched/signal.h:6:
>    include/linux/signal.h:113:11: warning: array index 3 is past the end of the array (that has type 'const unsigned long[2]') [-Warray-bounds]
>                    return  (set1->sig[3] == set2->sig[3]) &&
>                             ^         ~
>    include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
>            unsigned long sig[_NSIG_WORDS];
>            ^
>    In file included from fs/btrfs/tree-checker.c:21:
>    In file included from fs/btrfs/ctree.h:9:
>    In file included from include/linux/mm.h:737:
>    In file included from include/linux/huge_mm.h:8:
>    In file included from include/linux/fs.h:33:
>    In file included from include/linux/percpu-rwsem.h:7:
>    In file included from include/linux/rcuwait.h:6:
>    In file included from include/linux/sched/signal.h:6:
>    include/linux/signal.h:113:27: warning: array index 3 is past the end of the array (that has type 'const unsigned long[2]') [-Warray-bounds]
>                    return  (set1->sig[3] == set2->sig[3]) &&
>                                             ^         ~
>    include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
>            unsigned long sig[_NSIG_WORDS];
>            ^
>    In file included from fs/btrfs/tree-checker.c:21:
>    In file included from fs/btrfs/ctree.h:9:
>    In file included from include/linux/mm.h:737:
>    In file included from include/linux/huge_mm.h:8:
>    In file included from include/linux/fs.h:33:
>    In file included from include/linux/percpu-rwsem.h:7:
>    In file included from include/linux/rcuwait.h:6:
>    In file included from include/linux/sched/signal.h:6:
>    include/linux/signal.h:114:5: warning: array index 2 is past the end of the array (that has type 'const unsigned long[2]') [-Warray-bounds]
>                            (set1->sig[2] == set2->sig[2]) &&
>                             ^         ~
>    include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
>            unsigned long sig[_NSIG_WORDS];
>            ^
>    In file included from fs/btrfs/tree-checker.c:21:
>    In file included from fs/btrfs/ctree.h:9:
>    In file included from include/linux/mm.h:737:
>    In file included from include/linux/huge_mm.h:8:
>    In file included from include/linux/fs.h:33:
>    In file included from include/linux/percpu-rwsem.h:7:
>    In file included from include/linux/rcuwait.h:6:
>    In file included from include/linux/sched/signal.h:6:
>    include/linux/signal.h:114:21: warning: array index 2 is past the end of the array (that has type 'const unsigned long[2]') [-Warray-bounds]
>                            (set1->sig[2] == set2->sig[2]) &&
>                                             ^         ~
>    include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
>            unsigned long sig[_NSIG_WORDS];
>            ^
>    In file included from fs/btrfs/tree-checker.c:21:
>    In file included from fs/btrfs/ctree.h:9:
>    In file included from include/linux/mm.h:737:
>    In file included from include/linux/huge_mm.h:8:
>    In file included from include/linux/fs.h:33:
>    In file included from include/linux/percpu-rwsem.h:7:
>    In file included from include/linux/rcuwait.h:6:
>    In file included from include/linux/sched/signal.h:6:
>    include/linux/signal.h:156:1: warning: array index 3 is past the end of the array (that has type 'const unsigned long[2]') [-Warray-bounds]
>    _SIG_SET_BINOP(sigorsets, _sig_or)
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/signal.h:137:8: note: expanded from macro '_SIG_SET_BINOP'
>                    a3 = a->sig[3]; a2 = a->sig[2];                         \
>                         ^      ~
> 
> 
> vim +/EOPNOTSUPP +22 include/linux/error-injection.h
> 
>     19	
>     20	static inline int get_injectable_error_type(unsigned long addr)
>     21	{
>   > 22		return -EOPNOTSUPP;
>     23	}
>     24	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://01.org/lkp


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
