Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9069C5B1C13
	for <lists+bpf@lfdr.de>; Thu,  8 Sep 2022 14:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbiIHMB0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Sep 2022 08:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbiIHMBZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Sep 2022 08:01:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B886CE228E
        for <bpf@vger.kernel.org>; Thu,  8 Sep 2022 05:01:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0D5FAB820D9
        for <bpf@vger.kernel.org>; Thu,  8 Sep 2022 12:01:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDBFBC433D7;
        Thu,  8 Sep 2022 12:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662638479;
        bh=D2LT2e16X5GDCi/Mlez6nDXPNY+zxqRL3B3gob5UpnQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gLMXQ2OOiI/f+ueuVAzeZ+wyBZQgEG/Lg6tlFE+Fev5n3PoVF7HagdkxEo/9VkMVj
         DL+wOhClVT1xS6AlqYRzXQMPs1WrkITVvVX79wXmG8sZOMeU1ppELiyZzTMWa1fHIy
         ARdKI3BB+pas8z+5MxEjcZHdqYRERAOp6ky3/2+FJRQH3bZYQb35q3vAQTejM11rqG
         S7xc4S39xO2Uxu4NLgjaFPbMK03DwfrNTJ6KCwdYrxrbbx8lBkPManLKTEALXO7eiJ
         3GF/CghYR0YVBGFlYig90qe04EdBGvbLgGtog6gtOtIveqGE4dRj5/E/sA5M3+qnzv
         X/9dhXPEhEsQg==
Date:   Thu, 8 Sep 2022 21:01:14 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Subject: Re: [PATCHv2 bpf-next 1/6] kprobes: Add new
 KPROBE_FLAG_ON_FUNC_ENTRY kprobe flag
Message-Id: <20220908210114.7cd73fb8e8afdde8f41d4aeb@kernel.org>
In-Reply-To: <20220811091526.172610-2-jolsa@kernel.org>
References: <20220811091526.172610-1-jolsa@kernel.org>
        <20220811091526.172610-2-jolsa@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Jiri,

On Thu, 11 Aug 2022 11:15:21 +0200
Jiri Olsa <jolsa@kernel.org> wrote:

> Adding KPROBE_FLAG_ON_FUNC_ENTRY kprobe flag to indicate that
> attach address is on function entry. This is used in following
> changes in get_func_ip helper to return correct function address.

Sorry about late reply.

> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  include/linux/kprobes.h | 1 +
>  kernel/kprobes.c        | 6 +++++-
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
> index 55041d2f884d..a0b92be98984 100644
> --- a/include/linux/kprobes.h
> +++ b/include/linux/kprobes.h
> @@ -103,6 +103,7 @@ struct kprobe {
>  				   * this flag is only for optimized_kprobe.
>  				   */
>  #define KPROBE_FLAG_FTRACE	8 /* probe is using ftrace */
> +#define KPROBE_FLAG_ON_FUNC_ENTRY	16 /* probe is on the function entry */
>  
>  /* Has this kprobe gone ? */
>  static inline bool kprobe_gone(struct kprobe *p)
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index f214f8c088ed..a6b1b5c49d92 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -1605,9 +1605,10 @@ int register_kprobe(struct kprobe *p)
>  	struct kprobe *old_p;
>  	struct module *probed_mod;
>  	kprobe_opcode_t *addr;
> +	bool on_func_entry;
>  
>  	/* Adjust probe address from symbol */
> -	addr = kprobe_addr(p);
> +	addr = _kprobe_addr(p->addr, p->symbol_name, p->offset, &on_func_entry);

Hmm, OK. And I think now we can remove kprobe_addr() itself. It is still
used in register_kretprobe() but that is redundant.

Anyway, this patch itself looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you!

>  	if (IS_ERR(addr))
>  		return PTR_ERR(addr);
>  	p->addr = addr;
> @@ -1627,6 +1628,9 @@ int register_kprobe(struct kprobe *p)
>  
>  	mutex_lock(&kprobe_mutex);
>  
> +	if (on_func_entry)
> +		p->flags |= KPROBE_FLAG_ON_FUNC_ENTRY;
> +
>  	old_p = get_kprobe(p->addr);
>  	if (old_p) {
>  		/* Since this may unoptimize 'old_p', locking 'text_mutex'. */
> -- 
> 2.37.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
