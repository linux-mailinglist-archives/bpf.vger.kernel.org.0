Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B25F45955A2
	for <lists+bpf@lfdr.de>; Tue, 16 Aug 2022 10:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbiHPIyP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Aug 2022 04:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbiHPIxr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Aug 2022 04:53:47 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F6712CDEE
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 00:01:44 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id k26so17239695ejx.5
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 00:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc;
        bh=m6ZHyK+/Iux+/YsDxRibeREkrEtoT0lj4fXrnKXJwvg=;
        b=h37oCKJknx4V/Rcus00RBYx0oJS45ySnEuOUT/Umxl8SHG4ZGFSqZFa3Ulq/lG7e0p
         u7JSi3aScIxnj+J4c2Pc3pR1+qCdxNTLdQsyOjlH8DDdqtddhq8epxBe9xUfS8I8LrII
         Zd4bB3dURrphJuZOz9942xXuBqkqMGYTCZkWhfxvRxDCJ37vMsbJIPLJVzS1jaSy9XmU
         5q4NSKbfFg92d7Wn6k32guTiiBeKhaZwplnRt2qz9GY35NIi0x0dKHdDbapUB3F8g+Qu
         25hl2bS5POz8GeEpHXoYmwBYEizOBRPmv62BsWehtCIutHHpPX0fGanurYasi8pz1J7f
         vY2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc;
        bh=m6ZHyK+/Iux+/YsDxRibeREkrEtoT0lj4fXrnKXJwvg=;
        b=TjiZx7Bpp8/AOI4nAFWBow8zfoQWK7Hzfw6wWWMM0fJf1egEHo70+EgfGQoBG+AgAN
         fAwsNBg/dE+m1favuxPCI9COeXgAFctnhyc5Bi/pRhgTqqAq9iIHqmDA8iFpkfeDjPPC
         47xRedvJlESx5lgNM/v1Dc928swySWG+szScwStr06o9fD4/JXO5o8Dd75436+OI29m7
         dLziUGKFJifHgXQu1mYQcA/eV8j1ZNsno5axhWw2Efs0uGSgo9iYgjCUpSWq6HTk8KKH
         B8cKeb9IIJhgU6jsT+sJQ6qEFMbsOQ/2GEwIKAIch/YTSzDpnjPYfBhGXxjDId75SDp3
         neoA==
X-Gm-Message-State: ACgBeo3dIyGvqjVNgmmtc5tB8R1gvf7jT3FpPQGiIHXTGcUFCFtTXWlw
        OWu1mdqAK3zF/6LbcrhYM+Bbz7pJgheFVw==
X-Google-Smtp-Source: AA6agR7o8nw1CDFkBFN6hiepBpoaRFG0zwt459Eg5+kX1n5KDhN5sviqh3msW61fl7Kdjoo065mmgw==
X-Received: by 2002:a17:907:a044:b0:730:a18b:5b89 with SMTP id gz4-20020a170907a04400b00730a18b5b89mr12460080ejc.489.1660633303078;
        Tue, 16 Aug 2022 00:01:43 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id i21-20020a17090685d500b0073073ce488asm4961750ejy.45.2022.08.16.00.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 00:01:42 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Tue, 16 Aug 2022 09:01:40 +0200
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
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
Message-ID: <YvtA1EHgQi3XQXG/@krava>
References: <20220811091526.172610-1-jolsa@kernel.org>
 <20220811091526.172610-2-jolsa@kernel.org>
 <YvoYlCz0Ej7t9yDV@worktop.programming.kicks-ass.net>
 <YvobjEIHV3XPSeez@krava>
 <Yvo+vQ+egjJBOmP+@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yvo+vQ+egjJBOmP+@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 15, 2022 at 02:40:29PM +0200, Peter Zijlstra wrote:
> On Mon, Aug 15, 2022 at 12:10:20PM +0200, Jiri Olsa wrote:
> > On Mon, Aug 15, 2022 at 11:57:40AM +0200, Peter Zijlstra wrote:
> > > On Thu, Aug 11, 2022 at 11:15:21AM +0200, Jiri Olsa wrote:
> > > > Adding KPROBE_FLAG_ON_FUNC_ENTRY kprobe flag to indicate that
> > > > attach address is on function entry. This is used in following
> > > > changes in get_func_ip helper to return correct function address.
> > > 
> > > IIRC (and I've not digested patch) the intent was to have func+0 mean
> > > this. x86-IBT is not the only case where this applies, there are
> > > multiple architectures where function entry is not +0.
> > 
> > we can have kprobe created by user passing just the address
> > 
> > in this case _kprobe_addr still computes the address's offset
> > from the symbol but does not store it back to 'struct kprobe'
> 
> Ah, this is an internal thing to record, in the struct kprobe if the
> thing is on the function entry or not?

yes, exactly.. it's flag saying the kprobe is on function entry

jirka
