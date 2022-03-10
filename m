Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C91814D4F4B
	for <lists+bpf@lfdr.de>; Thu, 10 Mar 2022 17:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236841AbiCJQat (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Mar 2022 11:30:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236422AbiCJQas (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Mar 2022 11:30:48 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079FD6949B;
        Thu, 10 Mar 2022 08:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ejZS1NaFt+D1u7JDe4Pf6ufoRNcAiKOWcsjiV2EAWPg=; b=GugiTkyVq8DEPtsode39T6/Gtg
        wtBOpWrt7qA4XOldDsR9DRystNxFPn/IVl3e53qMF1yeCwZIS1e03ZHUWURapHvgZJ8J+mGy9koIc
        3P0DL39qRqbqghrmDKQqmpSTaYP+d1gctihK6kr5dvP/8S+1Os3IwP7ezxsnbAY3Hf1AIoCadvRXr
        WSRic3Ce6Gpqoe7ZaljwvI4r96AhUS9q0yfCBDVIfBqg1CMtmBFc/PnirxDgpgWjcsiQ4+3p0zPC+
        EOLpzHwzD6gXk2YuinRAA3VOI67GjLCJ246AoEAVZ1Wz2Q5yiorPK45JN9WPBxwCP5yoMECDtbCUx
        tyJIlO4g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nSLf7-00H9mb-Qe; Thu, 10 Mar 2022 16:29:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8ED4B300242;
        Thu, 10 Mar 2022 17:29:11 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4ECA03023FD01; Thu, 10 Mar 2022 17:29:11 +0100 (CET)
Date:   Thu, 10 Mar 2022 17:29:11 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        keescook@chromium.org, samitolvanen@google.com,
        mark.rutland@arm.com, alyssa.milburn@intel.com, mbenes@suse.cz,
        rostedt@goodmis.org, mhiramat@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v4 00/45] x86: Kernel IBT
Message-ID: <YionV0+v/cUBiOh0@hirez.programming.kicks-ass.net>
References: <20220308153011.021123062@infradead.org>
 <20220308200052.rpr4vkxppnxguirg@ast-mbp.dhcp.thefacebook.com>
 <YifSIDAJ/ZBKJWrn@hirez.programming.kicks-ass.net>
 <YifZhUVoHLT/76fE@hirez.programming.kicks-ass.net>
 <Yif8nO2xg6QnVQfD@hirez.programming.kicks-ass.net>
 <20220309190917.w3tq72alughslanq@ast-mbp.dhcp.thefacebook.com>
 <YinGZObp37b27LjK@hirez.programming.kicks-ass.net>
 <YioBZmicMj7aAlLf@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YioBZmicMj7aAlLf@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 10, 2022 at 02:47:18PM +0100, Peter Zijlstra wrote:
> On Thu, Mar 10, 2022 at 10:35:32AM +0100, Peter Zijlstra wrote:
> 
> > > $ test_progs -t fentry
> > > test_fentry_fexit:PASS:fentry_skel_load 0 nsec
> > > test_fentry_fexit:PASS:fexit_skel_load 0 nsec
> > > test_fentry_fexit:PASS:fentry_attach 0 nsec
> > > test_fentry_fexit:FAIL:fexit_attach unexpected error: -1 (errno 19)
> > > #54 fentry_fexit:FAIL
> 
> This seems to cure the above. fexit_bpf2bpf is still failing, I'll dig
> into that after lunch.
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index acb50fb7ed2d..2d86d3c09d64 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -5354,6 +5381,11 @@ int modify_ftrace_direct(unsigned long ip,
>  	mutex_lock(&direct_mutex);
>  
>  	mutex_lock(&ftrace_lock);
> +
> +	ip = ftrace_location(ip);
> +	if (!ip)
> +		goto out_unlock;
> +
>  	entry = find_direct_entry(&ip, &rec);
>  	if (!entry)
>  		goto out_unlock;

This seems to cure most of the rest. I'm still seeing one failure:

libbpf: prog 'connect_v4_prog': BPF program load failed: Invalid argument
libbpf: failed to load program 'connect_v4_prog'
libbpf: failed to load object './connect4_prog.o'
test_fexit_bpf2bpf_common:FAIL:tgt_prog_load unexpected error: -22 (errno 22)
#48/4 fexit_bpf2bpf/func_replace_verify:FAIL

but the rest seems to be good again.

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 2b1e266ff95c..3fecfe8c4429 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -384,6 +395,13 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
 		/* BPF poking in modules is not supported */
 		return -EINVAL;
 
+	/*
+	 * See emit_prologue(), for IBT builds the trampoline hook is preceded
+	 * with an ENDBR instruction.
+	 */
+	if (is_endbr(*(u32 *)ip))
+		ip += ENDBR_INSN_SIZE;
+
 	return __bpf_arch_text_poke(ip, t, old_addr, new_addr, true);
 }
 
