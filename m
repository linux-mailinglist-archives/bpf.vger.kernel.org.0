Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C580D6D8D5A
	for <lists+bpf@lfdr.de>; Thu,  6 Apr 2023 04:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbjDFCQ2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Apr 2023 22:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjDFCQ1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Apr 2023 22:16:27 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC566EB2
        for <bpf@vger.kernel.org>; Wed,  5 Apr 2023 19:16:25 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id mp3-20020a17090b190300b0023fcc8ce113so41461733pjb.4
        for <bpf@vger.kernel.org>; Wed, 05 Apr 2023 19:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680747385; x=1683339385;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ixjhqJgLxMLVUAvMHFtpxzJmGQ0GktK1XVJEIRT6YMA=;
        b=IhS2HCIe4UGjoxO5cKpCb1JtMUy95/TbFE0kVXp2hryNrnnpFAorRDEhfWiwr4oRih
         rav93uust0jmVAgqc5Y1reyGxoC8iaUH3XXrwrUXqESIMIcRALc7dw6Sd4683JBX4Li9
         DSutNkJS40M3nyNSdM/V+OX5V5NBsVn7kA68CjZgAJ9dXxR1wGruyxR9KYv8FX62dUBb
         +E2N4sPjO4R4MzpqB/eyEDeAxtxyVTEPowlGvD/aUHJDLk0XTulxuvXokXmeydP7mBxH
         PfkdWq3i2SSrTpHii2hMQbBiQ+Pyx36zSgkteTlgmaAegVDWRrYeCjRJUwbenVONfLqv
         Nrlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680747385; x=1683339385;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ixjhqJgLxMLVUAvMHFtpxzJmGQ0GktK1XVJEIRT6YMA=;
        b=KejognKXJ9X11CjtVwDb8EwJ/W262XK/1xyxtzomHKsGkqROi+SnGySNsvFBSjcFFa
         UxlzbSR1xavMH9rzfO2kMw/WvWkbXTQZGBjUDZpZEOoxVqNMzEpkRpG2E8oD6FZMphAu
         lQWosVJHe9dMI+9kyV0WsrHoVTyABdJiTweeiD+xkfnIBAPBadAiOVZyvqsMPDjYTt7q
         p4w+b772KsAcwanPwPkjnS1dsyi2gb4L5g8dfVs9+S3D3AcDMffk27okcJLs157nqw09
         DT7Wcz4VEnZnN05SzTA0FJF/Rz6E/0EvxS/flwk+LFLDwEzojvjRMtdpVNng9l70oenl
         H+8g==
X-Gm-Message-State: AAQBX9dyT8euDqPXRpSrZhgH53o4u9grmol/6eZ3mBhPvA/+WlqiHr/M
        K3xbLc+EwkU8857jPhj6ZI0=
X-Google-Smtp-Source: AKy350Ydzqtr7iai6hf57y77yWO6Mvfhk+Pm0Olo9hfRKMJ6kbiu/DtkVLOFDlenwaUrVmswSbe/sA==
X-Received: by 2002:a17:90b:4b01:b0:23f:e165:3452 with SMTP id lx1-20020a17090b4b0100b0023fe1653452mr9413172pjb.0.1680747385295;
        Wed, 05 Apr 2023 19:16:25 -0700 (PDT)
Received: from dhcp-172-26-102-232.dhcp.thefacebook.com ([2620:10d:c090:400::5:f79f])
        by smtp.gmail.com with ESMTPSA id gz11-20020a17090b0ecb00b00230ffcb2e24sm2042330pjb.13.2023.04.05.19.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 19:16:24 -0700 (PDT)
Date:   Wed, 5 Apr 2023 19:16:22 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        David Vernet <void@manifault.com>
Subject: Re: [PATCH RFC bpf-next v1 3/9] bpf: Implement bpf_throw kfunc
Message-ID: <20230406021622.xbgzrmfjxli6dkpt@dhcp-172-26-102-232.dhcp.thefacebook.com>
References: <20230405004239.1375399-1-memxor@gmail.com>
 <20230405004239.1375399-4-memxor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405004239.1375399-4-memxor@gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 05, 2023 at 02:42:33AM +0200, Kumar Kartikeya Dwivedi wrote:
> 
> - The exception state is represented using four booleans in the
>   task_struct of current task. Each boolean corresponds to the exception
>   state for each kernel context. This allows BPF programs to be
>   interrupted and still not clobber the other's exception state.

that doesn't work for sleepable bpf progs and in RT for regular progs too.

> - The other vexing case is of recursion. If a program calls into another
>   program (e.g. call into helper which invokes tracing program
>   eventually), it may throw and clobber the current exception state. To
>   avoid this, an invariant is maintained across the implementation:
> 	Exception state is always cleared on entry and exit of the main
> 	BPF program.
>   This implies that if recursion occurs, the BPF program will clear the
>   current exception state on entry and exit. However, callbacks do not
>   do the same, because they are subprograms. The case for propagating
>   exceptions of callbacks invoked by the kernel back to the BPF program
>   is handled in the next commit. This is also the main reason to clear
>   exception state on entry, asynchronous callbacks can clobber exception
>   state even though we make sure it's always set to be 0 within the
>   kernel.
>   Anyhow, the only other thing to be kept in mind is to never allow a
>   BPF program to execute when the program is being unwinded. This
>   implies that every function involved in this path must be notrace,
>   which is the case for bpf_throw, bpf_get_exception and
>   bpf_reset_exception.

...

> +			struct bpf_insn entry_insns[] = {
> +				BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
> +				BPF_EMIT_CALL(bpf_reset_exception),
> +				BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
> +				insn[i],
> +			};

Is not correct in global bpf progs that take more than 1 argument.

How about using a scratch space in prog->aux->exception[] instead of current task?

> +notrace u64 bpf_get_exception(void)
> +{
> +	int i = interrupt_context_level();
> +
> +	return current->bpf_exception_thrown[i];
> +}

this is too slow to be acceptable.
it needs to be single load plus branch.
with prog->aux->exception approach we can achieve that.
Instead of inserting a call to bpf_get_exception() we can do load+cmp.
We probably should pass prog->aux into exception callback, so it
can know where throw came from.

> - Rewrites happen for bpf_throw and call instructions to subprogs.
>   The instructions which are executed in the main frame of the main
>   program (thus, not global functions and extension programs, which end
>   up executing in frame > 0) need to be rewritten differently. This is
>   tracked using BPF_THROW_OUTER vs BPF_THROW_INNER. If not done, a

how about BPF_THROW_OUTER vs BPF_THROW_ANY_INNER ?
would it be more precise ?

> +__bpf_kfunc notrace void bpf_throw(void)
> +{
> +	int i = interrupt_context_level();
> +
> +	current->bpf_exception_thrown[i] = true;
> +}

I think this needs to take u64 or couple u64 args and store them
in the scratch area.
bpf_assert* macros also need a way for bpf prog to specify
the reason for the assertion.
Otherwise there won't be any way to debug what happened.
