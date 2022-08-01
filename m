Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63B13587264
	for <lists+bpf@lfdr.de>; Mon,  1 Aug 2022 22:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232936AbiHAUl3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Aug 2022 16:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbiHAUl1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Aug 2022 16:41:27 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C369013F99;
        Mon,  1 Aug 2022 13:41:23 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id m4so670555ejr.3;
        Mon, 01 Aug 2022 13:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc;
        bh=VICbJqTA7Gsy++ODC7DXtU58D84eyPqwBWnbSfvcRPE=;
        b=bMlVt0yY1v4of4NbdhbwF2Xi0To5mGndYpZw6xlEymr2AtDhdreVT+qJmo3pMDHLaQ
         eXraoGEq5RIQBgQSbB/1W4RMiloM3D1wkxEYSujJMXZ+bbb+0fHkBerl/jkLbhEUfOpk
         5QyeN9QT4PB1wf/vEdxs/xLE4cFCnR5hzHw8OibaHJsr5epe4jQua+BnTB7qmkb4ZLEi
         ooaS/cqD3EKr1PXjssIkZM02pWhvDcOEADTorIFtP88hV9dtSbhP3QGiEb/DlQQnttuU
         iitMoPTEjaS0nUVP3YmRUdzpH9SKttuGWgr0+751TGp1OrML6di31+Ew8RKCCMWbIjA4
         Cqsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc;
        bh=VICbJqTA7Gsy++ODC7DXtU58D84eyPqwBWnbSfvcRPE=;
        b=RXN5SL96RaQ3S2IOl2Wl+RU6YaeBPgpDm1muzYdtHpbgKA2+AXfe+9PBtGjP3RhDI2
         CYF4PPH/SggL2sDvgnkgOGM+4UtKeCUE4UxjEWGvcDMeslAoFYypKaJjZcrVsL5d77JU
         gpf75T7avVQJYiLWnhQVkjhB90i99UXTS7x+1qgg023ba1oJbbNQMDLbI125P6grjybF
         sE4C3kzkcNlA0eQpKUdwZJWruZyLQ253MY9cJvHA8RZ7aopqdi8+EoAt6u7fHsz1gccS
         kmaiHr5d+XV49Zfh//K+kCWCu3iDU2ytm00PSLIOQuXk67y74PrstY605yNBdZSmIA9b
         ZbFg==
X-Gm-Message-State: AJIora9PYuRe6MWV++P6mmZaGmNBqRgYHiKRc9M2UizGK/ejF0rd7Z/z
        rDnvbgpJO5fl+UUUCbcZTsg=
X-Google-Smtp-Source: AGRyM1tT3Ku9zybdd1Js8ZNNMZZP1xqaG40sJycdZi71xI2Fyyx5Tcc1lngszvPPLyGICCaH+bB5Qw==
X-Received: by 2002:a17:907:8a0e:b0:72b:9d03:fbdb with SMTP id sc14-20020a1709078a0e00b0072b9d03fbdbmr13491983ejc.447.1659386482278;
        Mon, 01 Aug 2022 13:41:22 -0700 (PDT)
Received: from krava ([83.240.62.89])
        by smtp.gmail.com with ESMTPSA id r9-20020a1709061ba900b0071cef8bafc3sm5486494ejg.1.2022.08.01.13.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 13:41:21 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Mon, 1 Aug 2022 22:41:19 +0200
To:     Chen Zhongjin <chenzhongjin@huawei.com>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, mhiramat@kernel.org, peterz@infradead.org,
        mingo@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v3] kprobes: Forbid probing on trampoline and bpf prog
Message-ID: <Yug6bx7T4GzqUf2a@krava>
References: <20220801033719.228248-1-chenzhongjin@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801033719.228248-1-chenzhongjin@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 01, 2022 at 11:37:19AM +0800, Chen Zhongjin wrote:
> kernel_text_address returns ftrace_trampoline, kprobe_insn_slot
> and bpf_text_address as kprobe legal address.
> 
> These text are removable and changeable without any notifier to
> kprobes. Probing on them can trigger some unexpected behavior[1].
> 
> Considering that jump_label and static_call text are already be
> forbiden to probe, kernel_text_address should be replaced with
> core_kernel_text and is_module_text_address to check other text
> which is unsafe to kprobe.
> 
> [1] https://lkml.org/lkml/2022/7/26/1148
> 
> Fixes: 5b485629ba0d ("kprobes, extable: Identify kprobes trampolines as kernel text area")
> Fixes: 74451e66d516 ("bpf: make jited programs visible in traces")
> Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
> ---
> v2 -> v3:
> Remove '-next' carelessly added in title.

LGTM cc-ing Steven because it affects ftrace as well

jirka

> 
> v1 -> v2:
> Check core_kernel_text and is_module_text_address rather than
> only kprobe_insn.
> Also fix title and commit message for this. See old patch at [1].
> ---
>  kernel/kprobes.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index f214f8c088ed..80697e5e03e4 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -1560,7 +1560,8 @@ static int check_kprobe_address_safe(struct kprobe *p,
>  	preempt_disable();
>  
>  	/* Ensure it is not in reserved area nor out of text */
> -	if (!kernel_text_address((unsigned long) p->addr) ||
> +	if (!(core_kernel_text((unsigned long) p->addr) ||
> +	    is_module_text_address((unsigned long) p->addr)) ||
>  	    within_kprobe_blacklist((unsigned long) p->addr) ||
>  	    jump_label_text_reserved(p->addr, p->addr) ||
>  	    static_call_text_reserved(p->addr, p->addr) ||
> -- 
> 2.17.1
> 
