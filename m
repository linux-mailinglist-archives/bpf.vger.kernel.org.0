Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09096B50C9
	for <lists+bpf@lfdr.de>; Fri, 10 Mar 2023 20:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjCJTQW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Mar 2023 14:16:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjCJTQU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Mar 2023 14:16:20 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391EC12DDF3;
        Fri, 10 Mar 2023 11:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LHHbjScou7+C6E6wHBUk/ygGHeDh8h+eFwprnuKb46I=; b=M4Lgts/FsW4hhTDyN3qMaj2lQR
        DExVzAT+/3cC2Hgb4JruiB5WyNqFOwA8vXLHfYCLxpVt6UVKpqp6dc4IKTU/ARJ7w2XyyseKrzToz
        nwR893BYe5G28IyCAf96eKdkdLYYuJr/BUuZaxsF19EvsbTssANba8dJ5SZxZ1NvdTCfGKL+D12cO
        XwfjGcFZQ/nRgFEIOuoUCWF1zYVh0InTFIgxXrmaR0+upPn/HPWtm2Ht3Cl7teR6vGTpqQHzqrS7A
        PeickofgSAydEooMpcx3Pb94M3zDDYmnAZXSkHnzeBbvSegQI7LdbfbVK/fXwfIb3XwEl22SCrs2N
        St64Popw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1paiDt-00FtEc-6c; Fri, 10 Mar 2023 19:16:13 +0000
Date:   Fri, 10 Mar 2023 11:16:13 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Viktor Malik <vmalik@redhat.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        linux-modules@vger.kernel.org,
        Nick Alcock <nick.alcock@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH bpf-next v10 1/2] bpf: Fix attaching
 fentry/fexit/fmod_ret/lsm to modules
Message-ID: <ZAuB/cnEsPt0f0vb@bombadil.infradead.org>
References: <cover.1678432753.git.vmalik@redhat.com>
 <3f6a9d8ae850532b5ef864ef16327b0f7a669063.1678432753.git.vmalik@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f6a9d8ae850532b5ef864ef16327b0f7a669063.1678432753.git.vmalik@redhat.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Please add linux-modules in the future. My review below.

On Fri, Mar 10, 2023 at 08:40:59AM +0100, Viktor Malik wrote:
> This resolves two problems with attachment of fentry/fexit/fmod_ret/lsm
> to functions located in modules:
> 
> 1. The verifier tries to find the address to attach to in kallsyms. This
>    is always done by searching the entire kallsyms, not respecting the
>    module in which the function is located. Such approach causes an
>    incorrect attachment address to be computed if the function to attach
>    to is shadowed by a function of the same name located earlier in
>    kallsyms.

Just a heads up, I realize you have tried to fix the issue here using
semantics to get the module in other ways, but Nick's future work
expands kallsyms to allow symbols for modules to be looked for, even
if there are duplicates in kallsysms. He is working on that to help
with tooling for tracing, but here seems to be an example use case
which may be in-kernel. But you seem to indicate you've found an alternative
solution anyway.

Jiri, does live patching hunt for symbols in such opaque way too?
Or does it resolve it using something similar as the technique here
with a module notifier / its own linked list?

> 2. If the address to attach to is located in a module, the module
>    reference is only acquired in register_fentry. If the module is
>    unloaded between the place where the address is found
>    (bpf_check_attach_target in the verifier) and register_fentry, it is
>    possible that another module is loaded to the same address which may
>    lead to potential errors.
> 
> Since the attachment must contain the BTF of the program to attach to,
> we extract the module from it and search for the function address in the
> correct module (resolving problem no. 1). Then, the module reference is
> taken directly in bpf_check_attach_target and stored in the bpf program
> (in bpf_prog_aux). The reference is only released when the program is
> unloaded (resolving problem no. 2).
> 
> Signed-off-by: Viktor Malik <vmalik@redhat.com>
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> ---

My review of the critical part below.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 45a082284464..3905bb20b9a1 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -18432,8 +18434,17 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
>  			else
>  				addr = (long) tgt_prog->aux->func[subprog]->bpf_func;
>  		} else {
> -			addr = kallsyms_lookup_name(tname);
> +			if (btf_is_module(btf)) {
> +				mod = btf_try_get_module(btf);
> +				if (mod)
> +					addr = find_kallsyms_symbol_value(mod, tname);
> +				else
> +					addr = 0;
> +			} else {
> +				addr = kallsyms_lookup_name(tname);
> +			}
>  			if (!addr) {
> +				module_put(mod);
>  				bpf_log(log,
>  					"The address of function %s cannot be found\n",
>  					tname);

If btf_modules linked list is ensured to not remove the btf module
during this operation, sure this is safe, as per the new guidelines I've
posted for try_module_get() this seems to be using try_module_get()
using the implied protection.

Please review the docs. *If* it respects that usage then feel free to
add:

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
