Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEEFD4BD2E7
	for <lists+bpf@lfdr.de>; Mon, 21 Feb 2022 01:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239402AbiBUAQV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 20 Feb 2022 19:16:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiBUAQU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 20 Feb 2022 19:16:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B116E344D8;
        Sun, 20 Feb 2022 16:15:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6DD04B80DAA;
        Mon, 21 Feb 2022 00:15:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B509C340E8;
        Mon, 21 Feb 2022 00:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645402556;
        bh=FAHiQRsRhdAMMfAapmFl44a3/9FTSkSi6leb9aKOKcA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=A3W6zbWgqlygo5WCNFb0oHIBKSNtZ7Sf7inAorLorqvgrgfZL+ANqoYv8amuWMiKn
         q2W4LyWNsGMsjgm1Ck0rCalUkCvnUUPQYnr6NwGUpJPv/htT3YjRh5YeDyElHd3QnP
         9sLlyewF/dEEremdms2IETorBzO+YmpTRtdUfS3O/8p0gTZCGpDyhzXPW5TiMys0Vf
         r2/+BDfwL7+Izf0KZXhIztMCDyWbt+UgpGlhcMNJZa7Bu92+EdWbzZ8KAT8F0C+al9
         NggPSitm9tLMhvCeQPafFC/bJPy+YzwWSDdJX3y8EbI2zu6JwSar1ZZpL/Hqng2i5Z
         XqdBmQnWEAu9w==
Date:   Mon, 21 Feb 2022 09:15:52 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>, <bpf@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] kprobes: Allow probing on any address belonging to
 ftrace
Message-Id: <20220221091552.f2b24bde8142df1d3fd63b42@kernel.org>
In-Reply-To: <78480d05821d45e09fb234f61f9037e26d42f02d.1645096227.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1645096227.git.naveen.n.rao@linux.vnet.ibm.com>
        <78480d05821d45e09fb234f61f9037e26d42f02d.1645096227.git.naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 17 Feb 2022 17:06:25 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> On certain architectures, ftrace can reserve multiple instructions at
> function entry. Rather than rejecting kprobe on addresses other than the
> exact ftrace call instruction, use the address returned by ftrace to
> probe at the correct address when CONFIG_KPROBES_ON_FTRACE is enabled.
> 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>  kernel/kprobes.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 94cab8c9ce56cc..0a797ede3fdf37 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -1497,6 +1497,10 @@ bool within_kprobe_blacklist(unsigned long addr)
>  static kprobe_opcode_t *_kprobe_addr(kprobe_opcode_t *addr,
>  			const char *symbol_name, unsigned int offset)
>  {
> +#ifdef CONFIG_KPROBES_ON_FTRACE
> +	unsigned long ftrace_addr = 0;
> +#endif
> +
>  	if ((symbol_name && addr) || (!symbol_name && !addr))
>  		goto invalid;
>  
> @@ -1507,6 +1511,14 @@ static kprobe_opcode_t *_kprobe_addr(kprobe_opcode_t *addr,
>  	}
>  
>  	addr = (kprobe_opcode_t *)(((char *)addr) + offset);
> +
> +#ifdef CONFIG_KPROBES_ON_FTRACE
> +	if (addr)
> +		ftrace_addr = ftrace_location((unsigned long)addr);
> +	if (ftrace_addr)
> +		return (kprobe_opcode_t *)ftrace_addr;

As I said, this must be

if (ftrace_addr != addr)
	return -EILSEQ;

This will prevent users from being confused by the results of probing
that 'func' and 'func+4' are the same. (now only 'func' is allowed to
be probed.)

Thank you,

> +#endif
> +
>  	if (addr)
>  		return addr;
>  
> -- 
> 2.35.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
