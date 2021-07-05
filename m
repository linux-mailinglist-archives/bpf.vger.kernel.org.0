Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B17F43BB76D
	for <lists+bpf@lfdr.de>; Mon,  5 Jul 2021 09:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbhGEHGC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 5 Jul 2021 03:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbhGEHGB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 5 Jul 2021 03:06:01 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A08BC061574;
        Mon,  5 Jul 2021 00:03:24 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id a8so9023107wrp.5;
        Mon, 05 Jul 2021 00:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mlwWEARxhvB9v498o+gz4FHu2tW7KE99FvhfhbdwvnQ=;
        b=gPWBWCjl/AEs1navJIBirtWyllhhvX6sQNVCaIZMeYwBEfs7GLC9+GM1Y2Yk/bNvr6
         G+dsQWPYkcB0d1U7kqpDV8pCkUn2T4+oPCYD+f5BL8mUkb3BPu7YX+V15yw+sL1J/skw
         Rmwx16kpELiC5lmh8PZYAriC4OyK7al65qySoXrdztmzWBuuUk+2IBUX9unRqEdFt3Tx
         18/u1MUe/hcHESv99soOmXhvNxTeJa40UVOO9lexlOg7/Wi8ss8oEgFOjGSIksj6R5Hi
         zcDpEr1fRMZ/29jtAhscbuIzRDflZ/lbAnm0vNdH71ZYVugPR3ZGq7UdaB5TjYYP91pj
         7ccQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=mlwWEARxhvB9v498o+gz4FHu2tW7KE99FvhfhbdwvnQ=;
        b=rCwLcQV77Y8xU33/Osa8zzvGB8PFGgTsXo9rcVaWVVRVqrsOPgogsUJk5uZ3xiPDou
         /CNFfFkQNknzc8R1EJSonY3FcPZgp6AzWm7G3/G2uZhPJz1g0KqQSp5S11X1J65Zm3xF
         /Bpyde1f76OJdD53jE+u8ApBigaYjzhmIZfDd4VPzfkYFFxZdbPQqBEdXoJmjD9vO1lN
         u+eiRg6eSt9LkN6pIrBYUqnEQ65JXDlHqU61sCOjafx6xXZTWgqW0A0g7V0cKmfTmfdc
         UrO/kgynpakCfWHuoEtn5+tJvydgf0Q5DrobyLYcccmwCLs4OD97h4//cRyX0J3di+XI
         NpSg==
X-Gm-Message-State: AOAM530Yvuhc3aVxUU+/BkLc4fM9lG1L6KdmwlJqW22wv+tA/7D6D3/7
        /i+tcmeyk6cZNKQM2sCasFY=
X-Google-Smtp-Source: ABdhPJwhWsUcQrxxaoQq5hi9fv0k0FmIYS9xrc4FMBnYq/L31XsG+Lqhd74lVl2YNvCjWhHIzXmfvg==
X-Received: by 2002:adf:eb0c:: with SMTP id s12mr10826924wrn.383.1625468602269;
        Mon, 05 Jul 2021 00:03:22 -0700 (PDT)
Received: from gmail.com (178-164-188-14.pool.digikabel.hu. [178.164.188.14])
        by smtp.gmail.com with ESMTPSA id w4sm11861169wrp.15.2021.07.05.00.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 00:03:21 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 5 Jul 2021 09:03:19 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, X86 ML <x86@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>, kernel-team@fb.com,
        yhs@fb.com, linux-ia64@vger.kernel.org,
        Abhishek Sagar <sagar.abhishek@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: Re: [PATCH -tip v8 03/13] kprobes: treewide: Remove
 trampoline_address from kretprobe_trampoline_handler()
Message-ID: <YOKut2jZ4f+oSKAI@gmail.com>
References: <162399992186.506599.8457763707951687195.stgit@devnote2>
 <162399994996.506599.17672270294950096639.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162399994996.506599.17672270294950096639.stgit@devnote2>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


* Masami Hiramatsu <mhiramat@kernel.org> wrote:

> --- a/include/linux/kprobes.h
> +++ b/include/linux/kprobes.h
> @@ -197,15 +197,23 @@ extern void arch_prepare_kretprobe(struct kretprobe_instance *ri,
>  				   struct pt_regs *regs);
>  extern int arch_trampoline_kprobe(struct kprobe *p);
>  
> +void kretprobe_trampoline(void);
> +/*
> + * Since some architecture uses structured function pointer,
> + * use dereference_function_descriptor() to get real function address.
> + */
> +static nokprobe_inline void *kretprobe_trampoline_addr(void)
> +{
> +	return dereference_kernel_function_descriptor(kretprobe_trampoline);
> +}

Could we please also make 'kretprobe_trampoline' harder to use 
accidentally, such by naming it appropriately?

__kretprobe_trampoline would be a good first step I guess.

Thanks,

	Ingo
