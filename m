Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C37934C0C4D
	for <lists+bpf@lfdr.de>; Wed, 23 Feb 2022 06:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbiBWF7R (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Feb 2022 00:59:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237219AbiBWF7Q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Feb 2022 00:59:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C88F1D316;
        Tue, 22 Feb 2022 21:58:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 23B6AB81E80;
        Wed, 23 Feb 2022 05:58:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B07BC340E7;
        Wed, 23 Feb 2022 05:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645595925;
        bh=6zqjN+ejPis2B9ACr4wZd1FjHKnzjkEF3tE0bhMxNXE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=njIsi30tL6ufxOFei92QTBJMv47QqlchMWiZPjUpGK2CgUfQaNlqmMnecmUI4qoRx
         pr9W53ELevdeg1nUI/muGp/G+eVCD2g0vUmyTZc7e6YBSsXZoGk3bW5u5hsm+qWxiL
         PuF8Z1kfpr+OAqynSxNlsSVUPDOdWla5N+ujGuY+fHIf469JtqElTX1f+A/9MOzQyf
         13kVSMpfmbghCYJcfKD6MX/IcLs2H241PKTrli1Q3VPg2MBUcZOEC6uHOo96dljAMh
         +h58Rif4y+CxBab1ZMC5g3t8Zop72jV08RGDFU7Gg5N/IOph1yAncv6YeNFLzmaBtR
         eEjlvZ2cFmJTA==
Date:   Wed, 23 Feb 2022 14:58:40 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 02/10] bpf: Add multi kprobe link
Message-Id: <20220223145840.64f708ed2357c89039f55f07@kernel.org>
In-Reply-To: <20220222170600.611515-3-jolsa@kernel.org>
References: <20220222170600.611515-1-jolsa@kernel.org>
        <20220222170600.611515-3-jolsa@kernel.org>
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

Hi Jiri,

On Tue, 22 Feb 2022 18:05:52 +0100
Jiri Olsa <jolsa@kernel.org> wrote:

[snip]
> +
> +static void
> +kprobe_multi_link_handler(struct fprobe *fp, unsigned long entry_ip,
> +			  struct pt_regs *regs)
> +{
> +	unsigned long saved_ip = instruction_pointer(regs);
> +	struct bpf_kprobe_multi_link *link;
> +
> +	/*
> +	 * Because fprobe's regs->ip is set to the next instruction of
> +	 * dynamic-ftrace instruction, correct entry ip must be set, so
> +	 * that the bpf program can access entry address via regs as same
> +	 * as kprobes.
> +	 */
> +	instruction_pointer_set(regs, entry_ip);

This is true for the entry_handler, but false for the exit_handler,
because entry_ip points the probed function address, not the
return address. Thus, when this is done in the exit_handler,
the bpf prog seems to be called from the entry of the function,
not return.

If it is what you expected, please explictly comment it to
avoid confusion. Or, make another handler function for exit
probing.

> +
> +	link = container_of(fp, struct bpf_kprobe_multi_link, fp);
> +	kprobe_multi_link_prog_run(link, regs);
> +
> +	instruction_pointer_set(regs, saved_ip);
> +}
> +
> +static int
> +kprobe_multi_resolve_syms(const void *usyms, u32 cnt,
> +			  unsigned long *addrs)
> +{
> +	unsigned long addr, size;
> +	const char **syms;
> +	int err = -ENOMEM;
> +	unsigned int i;
> +	char *func;
> +
> +	size = cnt * sizeof(*syms);
> +	syms = kvzalloc(size, GFP_KERNEL);
> +	if (!syms)
> +		return -ENOMEM;
> +
> +	func = kmalloc(KSYM_NAME_LEN, GFP_KERNEL);
> +	if (!func)
> +		goto error;
> +
> +	if (copy_from_user(syms, usyms, size)) {
> +		err = -EFAULT;
> +		goto error;
> +	}
> +
> +	for (i = 0; i < cnt; i++) {
> +		err = strncpy_from_user(func, syms[i], KSYM_NAME_LEN);
> +		if (err == KSYM_NAME_LEN)
> +			err = -E2BIG;
> +		if (err < 0)
> +			goto error;
> +
> +		err = -EINVAL;
> +		if (func[0] == '\0')
> +			goto error;
> +		addr = kallsyms_lookup_name(func);
> +		if (!addr)
> +			goto error;
> +		if (!kallsyms_lookup_size_offset(addr, &size, NULL))
> +			size = MCOUNT_INSN_SIZE;

Note that this is good for x86, but may not be good for other arch
which use some preparation instructions before mcount call.
Maybe you can just reject it if kallsyms_lookup_size_offset() fails.

Thank you,



-- 
Masami Hiramatsu <mhiramat@kernel.org>
