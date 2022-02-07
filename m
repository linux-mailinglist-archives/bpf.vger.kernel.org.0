Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 692314AC3F0
	for <lists+bpf@lfdr.de>; Mon,  7 Feb 2022 16:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242216AbiBGPhq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Feb 2022 10:37:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357145AbiBGPY6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Feb 2022 10:24:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF067C0401C9
        for <bpf@vger.kernel.org>; Mon,  7 Feb 2022 07:24:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C8AB6077B
        for <bpf@vger.kernel.org>; Mon,  7 Feb 2022 15:24:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E78B2C340F0;
        Mon,  7 Feb 2022 15:24:55 +0000 (UTC)
Date:   Mon, 7 Feb 2022 10:24:54 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>, <bpf@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Jordan Niethe <jniethe5@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>
Subject: Re: [RFC PATCH 2/3] powerpc/ftrace: Override
 ftrace_location_lookup() for MPROFILE_KERNEL
Message-ID: <20220207102454.41b1d6b5@gandalf.local.home>
In-Reply-To: <fadc5f2a295d6cb9f590bbbdd71fc2f78bf3a085.1644216043.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1644216043.git.naveen.n.rao@linux.vnet.ibm.com>
        <fadc5f2a295d6cb9f590bbbdd71fc2f78bf3a085.1644216043.git.naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon,  7 Feb 2022 12:37:21 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> --- a/arch/powerpc/kernel/trace/ftrace.c
> +++ b/arch/powerpc/kernel/trace/ftrace.c
> @@ -1137,3 +1137,14 @@ char *arch_ftrace_match_adjust(char *str, const char *search)
>  		return str;
>  }
>  #endif /* PPC64_ELF_ABI_v1 */
> +
> +#ifdef CONFIG_MPROFILE_KERNEL
> +unsigned long ftrace_location_lookup(unsigned long ip)
> +{
> +	/*
> +	 * Per livepatch.h, ftrace location is always within the first
> +	 * 16 bytes of a function on powerpc with -mprofile-kernel.
> +	 */
> +	return ftrace_location_range(ip, ip + 16);

I think this is the wrong approach for the implementation and error prone.

> +}
> +#endif
> -- 

What I believe is a safer approach is to use the record address and add the
range to it.

That is, you know that the ftrace modification site is a range (multiple
instructions), where in the ftrace infrastructure, only one ip represents
that range. What you want is if you pass in an ip, and that ip is within
that range, you return the ip that represents that range to ftrace.

It looks like we need to change the compare function in the bsearch.

Perhaps add a new macro to define the size of the range to be searched,
instead of just using MCOUNT_INSN_SIZE? Then we may not even need this new
lookup function?

static int ftrace_cmp_recs(const void *a, const void *b)
{
	const struct dyn_ftrace *key = a;
	const struct dyn_ftrace *rec = b;

	if (key->flags < rec->ip)
		return -1;
	if (key->ip >= rec->ip + ARCH_IP_SIZE)
		return 1;
	return 0;
}

Where ARCH_IP_SIZE is defined to MCOUNT_INSN_SIZE by default, but an arch
could define it to something else, like 16.

Would that work for you, or am I missing something?

-- Steve
