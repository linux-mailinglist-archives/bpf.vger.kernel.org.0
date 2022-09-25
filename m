Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDC9A5E946F
	for <lists+bpf@lfdr.de>; Sun, 25 Sep 2022 18:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiIYQox (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 25 Sep 2022 12:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbiIYQow (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 25 Sep 2022 12:44:52 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C46B10FFF;
        Sun, 25 Sep 2022 09:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664124288; x=1695660288;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=KY8IHaxepFaMwRh+/xVos1AWOk1yXT54Oq8rCUg0kG4=;
  b=YVOX87VjfoiCBpY/UJ+1RcnzLoZTQWTMnCRiXkL8gcVGYf8Ue+C36Gly
   dwxEyUPUE7cBtWdgYUD1iFzjjFSdZo02IydHllrb/b6xTXzLStNmAz9IW
   /lgaEumtwiCMmkOudKhpg2TARrK+El7LL9YZb1dJUfL3Uf0jBq37jFwcE
   YdZ9l22A/cN65xdlLoz4amdSu5gN3PXN4qtMhpgfgQt/09o5w4lRTZOyc
   KuHoSjKuXJvGGLypFShghNYtC12i16ZhrE7v9Eh+RDxNGZ4e++PUuXVk1
   xwST1Kb8pHNJC4MNvHRRjRCBVgKZBFSfZSVYx2mKncpWf0OJDZ3PwX4Is
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10481"; a="362706373"
X-IronPort-AV: E=Sophos;i="5.93,344,1654585200"; 
   d="scan'208";a="362706373"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2022 09:44:47 -0700
X-IronPort-AV: E=Sophos;i="5.93,344,1654585200"; 
   d="scan'208";a="689294159"
Received: from obyrd-mobl2.amr.corp.intel.com (HELO [10.212.210.57]) ([10.212.210.57])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2022 09:44:46 -0700
Message-ID: <a68d118d-ee03-399c-df02-82848e2197a2@intel.com>
Date:   Sun, 25 Sep 2022 09:44:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [syzbot] WARNING in __change_page_attr_set_clr
Content-Language: en-US
To:     syzbot <syzbot+cdcd5043ce8155d92ab1@syzkaller.appspotmail.com>,
        bp@alien8.de, brijesh.singh@amd.com, dan.j.williams@intel.com,
        dave.hansen@linux.intel.com, hpa@zytor.com, jane.chu@oracle.com,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        luto@kernel.org, mingo@redhat.com, peterz@infradead.org,
        seanjc@google.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, thomas.lendacky@amd.com, x86@kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        "open list:BPF (Safe dynamic programs and tools)" 
        <bpf@vger.kernel.org>
References: <00000000000076f3a305e97e9229@google.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <00000000000076f3a305e97e9229@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 9/25/22 04:18, syzbot wrote:
> ------------[ cut here ]------------
> CPA refuse W^X violation: 8000000000000163 -> 0000000000000163 range: 0xffffffffa0401000 - 0xffffffffa0401fff PFN 7d8d5
> WARNING: CPU: 0 PID: 3607 at arch/x86/mm/pat/set_memory.c:600 verify_rwx arch/x86/mm/pat/set_memory.c:600 [inline]
> WARNING: CPU: 0 PID: 3607 at arch/x86/mm/pat/set_memory.c:600 __change_page_attr arch/x86/mm/pat/set_memory.c:1569 [inline]
> WARNING: CPU: 0 PID: 3607 at arch/x86/mm/pat/set_memory.c:600 __change_page_attr_set_clr+0x1f40/0x2020 arch/x86/mm/pat/set_memory.c:1691
> Modules linked in:

Yay, one of these that isn't due to wonky 32-bit kernels!

This one looks to be naughty intentionally:

> void *bpf_jit_alloc_exec_page(void)
> {
...
>         /* Keep image as writeable. The alternative is to keep flipping ro/rw
>          * every time new program is attached or detached.
>          */
>         set_memory_x((long)image, 1);
>         return image;
> }

For STRICT_KERNEL_RWX kernels, I think we would really rather that this
code *did* flip ro/rw every time a new BPF program is attached or detached.
