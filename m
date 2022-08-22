Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEC259B744
	for <lists+bpf@lfdr.de>; Mon, 22 Aug 2022 03:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbiHVBdy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 21 Aug 2022 21:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231851AbiHVBdx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 21 Aug 2022 21:33:53 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 168B2DF09
        for <bpf@vger.kernel.org>; Sun, 21 Aug 2022 18:33:48 -0700 (PDT)
Received: from [10.130.0.135] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Dxvmvh3AJjfh4HAA--.19589S3;
        Mon, 22 Aug 2022 09:33:21 +0800 (CST)
Subject: Re: [PATCH bpf-next v1 3/4] LoongArch: Add BPF JIT support
To:     kernel test robot <lkp@intel.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
References: <1660996260-11337-4-git-send-email-yangtiezhu@loongson.cn>
 <202208202131.KsF0Aoos-lkp@intel.com>
Cc:     kbuild-all@lists.01.org, bpf@vger.kernel.org,
        loongarch@lists.linux.dev
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <ba90f6e6-2c82-62f4-84c0-6ff1a6c15254@loongson.cn>
Date:   Mon, 22 Aug 2022 09:33:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <202208202131.KsF0Aoos-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8Dxvmvh3AJjfh4HAA--.19589S3
X-Coremail-Antispam: 1UD129KBjvJXoW7CF48tF48GFyxtw18Wr4DArb_yoW8KFW5pa
        18ZrsrKrs5Xr18WayxKay7Wa1jgws5X347X3yUZw48CFZrZFy2qr1IkrW5WF9rKw1vkFyj
        vrZaq3sag3Z8Za7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv2b7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwV
        C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
        Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJV
        W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG
        8wCY02Avz4vE14v_KwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s
        026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_
        Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20x
        vEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa
        7IU5s6pJUUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 08/20/2022 09:41 PM, kernel test robot wrote:
> Hi Tiezhu,
>
> Thank you for the patch! Perhaps something to improve:
>
> [auto build test WARNING on linus/master]
> [also build test WARNING on v6.0-rc1 next-20220819]
> [cannot apply to bpf-next/master bpf/master]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Tiezhu-Yang/Add-BPF-JIT-support-for-LoongArch/20220820-195351
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 50cd95ac46548429e5bba7ca75cc97d11a697947
> config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20220820/202208202131.KsF0Aoos-lkp@intel.com/config)
> compiler: loongarch64-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/ebe9a0ace4f1fb110c43c347808c81cb07dfeb9b
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Tiezhu-Yang/Add-BPF-JIT-support-for-LoongArch/20220820-195351
>         git checkout ebe9a0ace4f1fb110c43c347808c81cb07dfeb9b
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=loongarch SHELL=/bin/bash arch/loongarch/net/
>
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
>>> arch/loongarch/net/bpf_jit.c:194:6: warning: no previous prototype for 'build_epilogue' [-Wmissing-prototypes]
>      194 | void build_epilogue(struct jit_ctx *ctx)
>          |      ^~~~~~~~~~~~~~
>
>
> vim +/build_epilogue +194 arch/loongarch/net/bpf_jit.c
>
>    193	
>  > 194	void build_epilogue(struct jit_ctx *ctx)
>    195	{
>    196		__build_epilogue(ctx, false);
>    197	}
>    198	
>

Hi robot,

Thank you, build_epilogue() should be static,
I will send v2 after waiting for other feedback.

Thanks,
Tiezhu

