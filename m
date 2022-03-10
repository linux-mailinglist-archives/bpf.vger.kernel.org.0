Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D614D430E
	for <lists+bpf@lfdr.de>; Thu, 10 Mar 2022 10:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240603AbiCJJGg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Mar 2022 04:06:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233760AbiCJJGf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Mar 2022 04:06:35 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F069137768;
        Thu, 10 Mar 2022 01:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=asZaKof/Ycf9Yl/IenjXZLrN7xJYPH+zuWKph/YnaGE=; b=mPNMJ1Y4nU566VAWE+/NYgv08b
        fnoUNB++Yh/YKvbCQYGfC8U772Xr6Xf6cRnvIb/1RPGfBQ+7ctL/m6ntNGPUbgCz+7y8MEzVM8vTX
        AadX+R+AmeKWwfoeS+z2TK2R7SJ7VcVvWpIuf42dJ69D2Ws1aeq3t4asGj4pZv0Aj3/YjpMFFSPD3
        i/rW8D4rdjYC9pHvANvFG0HJJTAzLZR6cb8sOdvF+OJPZh/OoMwUu8tYjcPF5WT6Ys/vHywQDhZKc
        5tFCASSZpCD/LLA1tyKH5+S7oUWSmBwbGmLjiu5EPiCx2HFyXRO/vnxoFuEAe7SHVJioEAx4hxOgs
        bFD5LLxw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nSEjK-000Mm2-EX; Thu, 10 Mar 2022 09:05:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1367430041D;
        Thu, 10 Mar 2022 10:05:05 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E86EC264E62B6; Thu, 10 Mar 2022 10:05:04 +0100 (CET)
Date:   Thu, 10 Mar 2022 10:05:04 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>, x86@kernel.org,
        joao@overdrivepizza.com, hjl.tools@gmail.com, jpoimboe@redhat.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        keescook@chromium.org, samitolvanen@google.com,
        mark.rutland@arm.com, alyssa.milburn@intel.com, mbenes@suse.cz,
        rostedt@goodmis.org, mhiramat@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, bpf@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v4 00/45] x86: Kernel IBT
Message-ID: <Yim/QJhNBCDfuxsc@hirez.programming.kicks-ass.net>
References: <20220308153011.021123062@infradead.org>
 <20220308200052.rpr4vkxppnxguirg@ast-mbp.dhcp.thefacebook.com>
 <YifSIDAJ/ZBKJWrn@hirez.programming.kicks-ass.net>
 <YifZhUVoHLT/76fE@hirez.programming.kicks-ass.net>
 <CAKwvOdk0ROSOSDKHcyH0kP+5MFH5QnasD6kbAu8gG8CCXO7OmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdk0ROSOSDKHcyH0kP+5MFH5QnasD6kbAu8gG8CCXO7OmQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 09, 2022 at 04:30:28PM -0800, Nick Desaulniers wrote:

> I observed the following error when building with
> CONFIG_LTO_CLANG_FULL=y enabled:
> 
> ld.lld: error: ld-temp.o <inline asm>:7:2: symbol 'ibt_selftest_ip' is
> already defined
>         ibt_selftest_ip:
>         ^
> 
> Seems to come from
> commit a802350ba65a ("x86/ibt: Add IBT feature, MSR and #CP handling")
> 
> Commenting out the label in the inline asm, I then observed:
> vmlinux.o: warning: objtool: identify_cpu()+0x6d0: sibling call from
> callable instruction with modified stack frame
> vmlinux.o: warning: objtool: identify_cpu()+0x6e0: stack state
> mismatch: cfa1=4+64 cfa2=4+8
> These seemed to disappear when I kept CONFIG_LTO_CLANG_FULL=y but then
> disabled CONFIG_X86_KERNEL_IBT. (perhaps due to the way I hacked out
> the ibt_selftest_ip label).

Urgh.. I'm thikning this is a clang bug :/

The code in question is:


void ibt_selftest_ip(void); /* code label defined in asm below */

DEFINE_IDTENTRY_ERRORCODE(exc_control_protection)
{
	/* ... */

	if (unlikely(regs->ip == (unsigned long)ibt_selftest_ip)) {
		regs->ax = 0;
		return;
	}

	/* ... */
}

bool ibt_selftest(void)
{
	unsigned long ret;

	asm ("	lea ibt_selftest_ip(%%rip), %%rax\n\t"
	     ANNOTATE_RETPOLINE_SAFE
	     "	jmp *%%rax\n\t"
	     "ibt_selftest_ip:\n\t"
	     UNWIND_HINT_FUNC
	     ANNOTATE_NOENDBR
	     "	nop\n\t"

	     : "=a" (ret) : : "memory");

	return !ret;
}

There is only a single definition of that symbol, the one in the asm.
The other is a declaration, which is used in the exception handler to
compare against regs->ip.

So what this code does is trigger an explicit #CP and special case that
in the handler. For that the handler needs to know the special IP that
will trigger the failure, this is cummunicated with that symbol.

> Otherwise defconfig and CONFIG_LTO_CLANG_THIN=y both built and booted
> in a vm WITHOUT IBT support.
> 
> Any idea what's the status of IBT emulation in QEMU, and if it exists,
> what's the necessary `-cpu` flag to enable it?

I have a very ugly kvm patch that goes with a very ugly qemu patch to
make it work. I would very much not recommend those getting merged.

Someone with some actual kvm/qemu foo should do one. The complicating
factor is that IA32_S_CET also contains SHSTK enable bits, so a straight
passthrough like I use relies on the guest never setting those bits or
keeping the pieces. It either needs to filter the MSR or implement the
full CET mess.
