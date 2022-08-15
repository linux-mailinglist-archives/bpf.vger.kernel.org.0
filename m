Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1587592B9A
	for <lists+bpf@lfdr.de>; Mon, 15 Aug 2022 12:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbiHOKKk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Aug 2022 06:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbiHOKKb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Aug 2022 06:10:31 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B432641D
        for <bpf@vger.kernel.org>; Mon, 15 Aug 2022 03:10:29 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id uj29so12786004ejc.0
        for <bpf@vger.kernel.org>; Mon, 15 Aug 2022 03:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc;
        bh=cz2eO//TLIVg0NJt3OHL07IYde0LaBhw7JgmRHAe3OU=;
        b=Q8V4e9C8Zv1vsVM/zwA2wrlM8Frn3k7C+wD0zcRo33ooNVAvfSd6R+yuzvlvFLF86L
         XjxYb+NQ8qET9Vc5mWFv+05lcGfZPHSAd4v3nwpurcbKG9c5VmIp07Fkg5Csp3Qpk+On
         MdVx4H0EuOeqtIuDMJBXHN7SlMlI+KTmdZttJT31asIgQrReOa0DNpAQYecHbw7IPBEp
         jQq6Lo0rZvo4TEnaN+XYhcPTDRRRXHKMWjjD126IzwoFRO3jmJzomLWR+ySLYdWqNinx
         3mFoQVkHt9ALfnN/FFKedPgVnSiig88a46QkmUpwkYMOWGGz1MPgSbFFc2HcJp+rd+DY
         dzEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc;
        bh=cz2eO//TLIVg0NJt3OHL07IYde0LaBhw7JgmRHAe3OU=;
        b=Ii8PrqCaj2SihhPyeQRvb00VIb+XWRjlQDBQ6Vf7bkiTgr3S4czek6X5ECVKbKk3m+
         L7AdKv5A3AXbdtofO30F+AVQ0rg1eGU6eVWngOzlHRMgEUAb/CPwQ+ZGUWu0klRq9RwD
         pIybCsndaDvdU79zUXBCXB8vxObdk3Hght6OO2WeJyCTmejuQUUqa3pAvPukrt+5G4G3
         A0UJiAVII23XeW1BSHTgFGvkwVo7ZF/bk/meG5WQeBIsO/N7ZdVL3XCQSNnxcizRMt9n
         XNZSit4ezLntYpZotjlgB0cHpx5vs4bpvdXkRgy8sRopa/BjQl8M9LM8+sbj4NsyRfbx
         AVKA==
X-Gm-Message-State: ACgBeo1TT4/Hs7yeXPS27QKRzSvCLHliV6Ed4+p8D7mO8OkWEAM1paQC
        eTcK+FkU3v2flHACR2xM/uA=
X-Google-Smtp-Source: AA6agR7toEg7R6P5Jt3gSDJzpax+/xhwlJcoEFO1Gh/4wV3R9VzMoZ5mf2xCxm3Zert/oQ1k53xzbg==
X-Received: by 2002:a17:907:60c7:b0:731:14e2:af10 with SMTP id hv7-20020a17090760c700b0073114e2af10mr9921169ejc.92.1660558227935;
        Mon, 15 Aug 2022 03:10:27 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id b3-20020a17090630c300b0072b616ade26sm3860604ejb.216.2022.08.15.03.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 03:10:27 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Mon, 15 Aug 2022 12:10:20 +0200
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Subject: Re: [PATCHv2 bpf-next 1/6] kprobes: Add new
 KPROBE_FLAG_ON_FUNC_ENTRY kprobe flag
Message-ID: <YvobjEIHV3XPSeez@krava>
References: <20220811091526.172610-1-jolsa@kernel.org>
 <20220811091526.172610-2-jolsa@kernel.org>
 <YvoYlCz0Ej7t9yDV@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvoYlCz0Ej7t9yDV@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 15, 2022 at 11:57:40AM +0200, Peter Zijlstra wrote:
> On Thu, Aug 11, 2022 at 11:15:21AM +0200, Jiri Olsa wrote:
> > Adding KPROBE_FLAG_ON_FUNC_ENTRY kprobe flag to indicate that
> > attach address is on function entry. This is used in following
> > changes in get_func_ip helper to return correct function address.
> 
> IIRC (and I've not digested patch) the intent was to have func+0 mean
> this. x86-IBT is not the only case where this applies, there are
> multiple architectures where function entry is not +0.

we can have kprobe created by user passing just the address

in this case _kprobe_addr still computes the address's offset
from the symbol but does not store it back to 'struct kprobe'

jirka
