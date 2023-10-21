Return-Path: <bpf+bounces-12892-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0737D1AAB
	for <lists+bpf@lfdr.de>; Sat, 21 Oct 2023 05:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47AB11C21063
	for <lists+bpf@lfdr.de>; Sat, 21 Oct 2023 03:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BAE6EC4;
	Sat, 21 Oct 2023 03:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ex1dqEKM"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23483A4C
	for <bpf@vger.kernel.org>; Sat, 21 Oct 2023 03:45:46 +0000 (UTC)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3794AD76
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 20:45:42 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c9b7c234a7so12194895ad.3
        for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 20:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697859942; x=1698464742; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U9uxYMKTxKvAZ2PVIZvEz2M4dTYUC9IaNrlDNTSDoYg=;
        b=ex1dqEKMLN36xWxNpX9ZptBr9UAwkDSyicEz7Ay8j6TIooDUx7yX6BlHICwcvd0TUT
         b7DbyXuNr5pLIXeb+0fVOWLRtgkMQ3hEfWmyHzDAvST5h3c+nEjfNy2CCpJVobczXg26
         WXNhLkRgWwn4ylYU5WNuXh0x07gkbUNvBICZR0IIGAP3Qnp/BfBLTln98wh8GVpqv2fO
         IgAtILmt6Can+N8QDIvmzl52ssD9D65W7IGFjRPgT7+wP2VHqVWwA2IEswjfBI+pwmn5
         rdqESWgsMUgWdkBUG+d649VqXMEt6uJ2LhQkUdf5oaPZcoAT0NcxIismPDcziYXQijX0
         0qFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697859942; x=1698464742;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=U9uxYMKTxKvAZ2PVIZvEz2M4dTYUC9IaNrlDNTSDoYg=;
        b=brZwbr/kPEj4vmc+OT+4GUUmp2IXbgCZ3ewHLurTL09Niru25WA7d8BGse3rnNkPXE
         A5lVtkn0PB6LQi6AR/bJcSt216Nt6pCg1OIQgts0/rpkvYw2FEr8pDx1Y9+xB6i/sfbC
         eEO30h53trOV7/L/iAM0susDsqLn+G9vGlOOulOQB08yHU/B4NU1UsMtr9UFu4pSxp4u
         7fyhTj86qZdgRNZkc7iyO1kwO9hrZUMtY5xNY74LUC8m4uilTCNNN9u2tj2ssLZs3izV
         /Fv7avG9j4Vv5jCsTjoGTmnWqoq+sq+NYbkFWJ0J95U4KQKtZ+5IQmQQFzqwRGJL25GK
         vztQ==
X-Gm-Message-State: AOJu0YycVSePUR3EvwiP9wz9/LKVCzMlpbfNraQEO2YWUOQ7NYnx/svR
	J8QNuLeUnleNXDhy24zVHT5kQw==
X-Google-Smtp-Source: AGHT+IEPgEKf+VqSvbRUu6NXhy4ExhwWjrYgcSEAMq3SQF7IDoHIGoRip7xhILwNMXJ2sXDTO86uWg==
X-Received: by 2002:a17:902:d0c2:b0:1ca:b26a:9729 with SMTP id n2-20020a170902d0c200b001cab26a9729mr3692531pln.38.1697859941685;
        Fri, 20 Oct 2023 20:45:41 -0700 (PDT)
Received: from [10.254.107.145] ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id h14-20020a170902f54e00b001c62e3e1286sm2245528plf.166.2023.10.20.20.45.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Oct 2023 20:45:41 -0700 (PDT)
Message-ID: <b13dc48f-11ab-451b-812f-17b5e8faf521@bytedance.com>
Date: Sat, 21 Oct 2023 11:45:32 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpf: hide cgroup functions for configs without cgroups
To: Arnd Bergmann <arnd@arndb.de>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Arnd Bergmann <arnd@kernel.org>
Cc: Yonghong Song <yonghong.song@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Tejun Heo <tj@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
 bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <20231020132749.1398012-1-arnd@kernel.org>
 <CAADnVQL-zoFPPOVu3nM981gKxRu7Q3G3LTRsKstJEeahpoR1RQ@mail.gmail.com>
 <5e45b11b-853d-49e6-a355-251dc1362676@app.fastmail.com>
From: Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <5e45b11b-853d-49e6-a355-251dc1362676@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

在 2023/10/21 04:06, Arnd Bergmann 写道:
> On Fri, Oct 20, 2023, at 19:26, Alexei Starovoitov wrote:
>> On Fri, Oct 20, 2023 at 6:27 AM Arnd Bergmann <arnd@kernel.org> wrote:
>>> @@ -904,6 +904,7 @@ __diag_push();
>>>   __diag_ignore_all("-Wmissing-prototypes",
>>>                    "Global functions as their definitions will be in vmlinux BTF");
>>>
>>> +#ifdef CONFIG_CGROUPS
>>>   __bpf_kfunc int bpf_iter_css_task_new(struct bpf_iter_css_task *it,
>>>                  struct cgroup_subsys_state *css, unsigned int flags)
>>>   {
>>> @@ -947,6 +948,7 @@ __bpf_kfunc void bpf_iter_css_task_destroy(struct bpf_iter_css_task *it)
>>>          css_task_iter_end(kit->css_it);
>>>          bpf_mem_free(&bpf_global_ma, kit->css_it);
>>>   }
>>> +#endif
>>
>> Did you actually test build it without cgroups and with bpf+btf?
>> I suspect the resolve_btfid step should be failing the build.
>> It needs
>> #ifdef CONFIG_CGROUPS
>> around BTF_ID_FLAGS(func, bpf_iter_css_task*
> 
> No, I did test with a few hundred random configurations, but it
> looks like CONFIG_DEBUG_INFO_BTF is always disabled
> in my builds because I force-disable CONFIG_DEBUG_INFO
> to speed up my builds.
> 
> I tried reproducing it with CONFIG_DEBUG_INFO_BTF enabled
> and it didn't immediately fail but it clearly makes sense that
> we'd need another #ifdef.
> 
>        Arnd

seems the same problem also reported by kernel-robot:

tree: 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
head:   2030579113a1b1b5bfd7ff24c0852847836d8fd1
commit: 9c66dc94b62aef23300f05f63404afb8990920b4 [13777/13906] bpf: 
Introduce css_task open-coded iterator kfuncs
config: hexagon-randconfig-r003-20230725 
(https://download.01.org/0day-ci/archive/20231021/202310211011.pTzXR2o9-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git 
ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): 
(https://download.01.org/0day-ci/archive/20231021/202310211011.pTzXR2o9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new 
version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: 
https://lore.kernel.org/oe-kbuild-all/202310211011.pTzXR2o9-lkp@intel.com/

All errors (new ones prefixed by >>):

    In file included from kernel/bpf/task_iter.c:9:
    In file included from include/linux/filter.h:9:
    In file included from include/linux/bpf.h:31:
    In file included from include/linux/memcontrol.h:13:
    In file included from include/linux/cgroup.h:26:
    In file included from include/linux/kernel_stat.h:9:
    In file included from include/linux/interrupt.h:11:
    In file included from include/linux/hardirq.h:11:
    In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
    In file included from include/asm-generic/hardirq.h:17:
    In file included from include/linux/irq.h:20:
    In file included from include/linux/io.h:13:
    In file included from arch/hexagon/include/asm/io.h:337:
    include/asm-generic/io.h:547:31: warning: performing pointer 
arithmetic on a null pointer has undefined behavior 
[-Wnull-pointer-arithmetic]
            val = __raw_readb(PCI_IOBASE + addr);
                              ~~~~~~~~~~ ^
    include/asm-generic/io.h:560:61: warning: performing pointer 
arithmetic on a null pointer has undefined behavior 
[-Wnull-pointer-arithmetic]
            val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + 
addr));
                                                            ~~~~~~~~~~ ^
    include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded 
from macro '__le16_to_cpu'
    #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
                                                      ^
    In file included from kernel/bpf/task_iter.c:9:
    In file included from include/linux/filter.h:9:
    In file included from include/linux/bpf.h:31:
    In file included from include/linux/memcontrol.h:13:
    In file included from include/linux/cgroup.h:26:
    In file included from include/linux/kernel_stat.h:9:
    In file included from include/linux/interrupt.h:11:
    In file included from include/linux/hardirq.h:11:
    In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
    In file included from include/asm-generic/hardirq.h:17:
    In file included from include/linux/irq.h:20:
    In file included from include/linux/io.h:13:
    In file included from arch/hexagon/include/asm/io.h:337:
    include/asm-generic/io.h:573:61: warning: performing pointer 
arithmetic on a null pointer has undefined behavior 
[-Wnull-pointer-arithmetic]
            val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + 
addr));
                                                            ~~~~~~~~~~ ^
    include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded 
from macro '__le32_to_cpu'
    #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
                                                      ^
    In file included from kernel/bpf/task_iter.c:9:
    In file included from include/linux/filter.h:9:
    In file included from include/linux/bpf.h:31:
    In file included from include/linux/memcontrol.h:13:
    In file included from include/linux/cgroup.h:26:
    In file included from include/linux/kernel_stat.h:9:
    In file included from include/linux/interrupt.h:11:
    In file included from include/linux/hardirq.h:11:
    In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
    In file included from include/asm-generic/hardirq.h:17:
    In file included from include/linux/irq.h:20:
    In file included from include/linux/io.h:13:
    In file included from arch/hexagon/include/asm/io.h:337:
    include/asm-generic/io.h:584:33: warning: performing pointer 
arithmetic on a null pointer has undefined behavior 
[-Wnull-pointer-arithmetic]
            __raw_writeb(value, PCI_IOBASE + addr);
                                ~~~~~~~~~~ ^
    include/asm-generic/io.h:594:59: warning: performing pointer 
arithmetic on a null pointer has undefined behavior 
[-Wnull-pointer-arithmetic]
            __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + 
addr);
                                                          ~~~~~~~~~~ ^
    include/asm-generic/io.h:604:59: warning: performing pointer 
arithmetic on a null pointer has undefined behavior 
[-Wnull-pointer-arithmetic]
            __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + 
addr);
                                                          ~~~~~~~~~~ ^
 >> kernel/bpf/task_iter.c:919:7: error: use of undeclared identifier 
'CSS_TASK_ITER_PROCS'
            case CSS_TASK_ITER_PROCS | CSS_TASK_ITER_THREADED:
                 ^
 >> kernel/bpf/task_iter.c:919:29: error: use of undeclared identifier 
'CSS_TASK_ITER_THREADED'
            case CSS_TASK_ITER_PROCS | CSS_TASK_ITER_THREADED:
                                       ^
    kernel/bpf/task_iter.c:920:7: error: use of undeclared identifier 
'CSS_TASK_ITER_PROCS'
            case CSS_TASK_ITER_PROCS:
                 ^
 >> kernel/bpf/task_iter.c:927:46: error: invalid application of 
'sizeof' to an incomplete type 'struct css_task_iter'
            kit->css_it = bpf_mem_alloc(&bpf_global_ma, sizeof(struct 
css_task_iter));
                                                        ^ 
~~~~~~~~~~~~~~~~~~~~~~
    kernel/bpf/task_iter.c:902:9: note: forward declaration of 'struct 
css_task_iter'
            struct css_task_iter *css_it;
                   ^
 >> kernel/bpf/task_iter.c:930:2: error: call to undeclared function 
'css_task_iter_start'; ISO C99 and later do not support implicit 
function declarations [-Wimplicit-function-declaration]
            css_task_iter_start(css, flags, kit->css_it);
            ^
    kernel/bpf/task_iter.c:930:2: note: did you mean '__sg_page_iter_start'?
    include/linux/scatterlist.h:573:6: note: '__sg_page_iter_start' 
declared here
    void __sg_page_iter_start(struct sg_page_iter *piter,
         ^
 >> kernel/bpf/task_iter.c:940:9: error: call to undeclared function 
'css_task_iter_next'; ISO C99 and later do not support implicit function 
declarations [-Wimplicit-function-declaration]
            return css_task_iter_next(kit->css_it);
                   ^
 >> kernel/bpf/task_iter.c:940:9: error: incompatible integer to pointer 
conversion returning 'int' from a function with result type 'struct 
task_struct *' [-Wint-conversion]
            return css_task_iter_next(kit->css_it);
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 >> kernel/bpf/task_iter.c:949:2: error: call to undeclared function 
'css_task_iter_end'; ISO C99 and later do not support implicit function 
declarations [-Wimplicit-function-declaration]
            css_task_iter_end(kit->css_it);
            ^
    6 warnings and 8 errors generated.


vim +/CSS_TASK_ITER_PROCS +919 kernel/bpf/task_iter.c

    904	
    905	__diag_push();
    906	__diag_ignore_all("-Wmissing-prototypes",
    907			  "Global functions as their definitions will be in vmlinux BTF");
    908	
    909	__bpf_kfunc int bpf_iter_css_task_new(struct bpf_iter_css_task *it,
    910			struct cgroup_subsys_state *css, unsigned int flags)
    911	{
    912		struct bpf_iter_css_task_kern *kit = (void *)it;
    913	
    914		BUILD_BUG_ON(sizeof(struct bpf_iter_css_task_kern) != 
sizeof(struct bpf_iter_css_task));
    915		BUILD_BUG_ON(__alignof__(struct bpf_iter_css_task_kern) !=
    916						__alignof__(struct bpf_iter_css_task));
    917		kit->css_it = NULL;
    918		switch (flags) {
  > 919		case CSS_TASK_ITER_PROCS | CSS_TASK_ITER_THREADED:
  > 920		case CSS_TASK_ITER_PROCS:
    921		case 0:
    922			break;
    923		default:
    924			return -EINVAL;
    925		}
    926	
  > 927		kit->css_it = bpf_mem_alloc(&bpf_global_ma, sizeof(struct 
css_task_iter));
    928		if (!kit->css_it)
    929			return -ENOMEM;
  > 930		css_task_iter_start(css, flags, kit->css_it);
    931		return 0;
    932	}
    933	
    934	__bpf_kfunc struct task_struct *bpf_iter_css_task_next(struct 
bpf_iter_css_task *it)
    935	{
    936		struct bpf_iter_css_task_kern *kit = (void *)it;
    937	
    938		if (!kit->css_it)
    939			return NULL;
  > 940		return css_task_iter_next(kit->css_it);
    941	}
    942	
    943	__bpf_kfunc void bpf_iter_css_task_destroy(struct 
bpf_iter_css_task *it)
    944	{
    945		struct bpf_iter_css_task_kern *kit = (void *)it;
    946	
    947		if (!kit->css_it)
    948			return;
  > 949		css_task_iter_end(kit->css_it);
    950		bpf_mem_free(&bpf_global_ma, kit->css_it);
    951	}
    952	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


