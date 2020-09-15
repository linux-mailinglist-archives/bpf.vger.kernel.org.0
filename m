Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6AD126B39A
	for <lists+bpf@lfdr.de>; Wed, 16 Sep 2020 01:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbgIOXGD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Sep 2020 19:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727201AbgIOOsG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Sep 2020 10:48:06 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6997CC061225
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2020 06:54:39 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id u21so5228552eja.2
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2020 06:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8j+lblg1sV2zcZbQlE+z8kJXho9SmxIjdqx8+vh4bbk=;
        b=zs+wxazNDlzCncy6nDFpBVAZ1RQDAAaDIp4sgRNsL1wLq+A775Sonp1E73R0J25AVP
         wy+SnCoRFJgQhHKHZxHVMgMyOAfT7swYrS/2Rkpjo9PLimRa4BF4VyHBmitwaNFAfcbz
         PkB8vA6NoDvNsOx1u/zLDI1sXyOsnQ5gSnY6qSzqhMoaisXFVrFuMrFvjpWZULthxOZL
         yBYcG7YdLvAu7bvVsIqNSivaWKPF3tEQyn6nXD0JOghQw6y+WAMp7D/93G/lWsu9zjwy
         c9O1KIyEwffdY/suauSk9oektYPK33FRkuqorQX/7ozLl40NPRjHfLGr3LLDJQMrwpek
         Fhyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8j+lblg1sV2zcZbQlE+z8kJXho9SmxIjdqx8+vh4bbk=;
        b=aiNt0+UVYo9R0yEdnWxAt55blQVNvexR5RzGKA8dqjO/BlXhp/QdLv/36fUbJfrQEu
         p8ODAPiQntVsQ//6LkWhkPTKfas4b0suCtj4Kp6FmUerQ4r/BHO/2y8yNVfTjpPfGebk
         DDPmQoAnRNy/BnOb8yvxsAav513cCmGvNJcf/uMLvsFdrepIlrMfs7o4FdjlsQ+RN1Lm
         uEugiwzWy8F4GTJezXNWnVJvOfCF+HkzYslafbFFULVJ2ecCXsJ7VUcjrnrdAfHTHbjR
         D+oQqEwloiJZp+URkbn8Utso1eZe/QpJx4COcq4WR8dQ6KhbzpuiEiw6UccS0jsiMRuj
         +1nA==
X-Gm-Message-State: AOAM532sSlNge9Oj5y1bdX62BwnMMz4vW1yRoj4U71kHXKHSkJFqc92m
        Jt9OInLW+uLxJga8wf+BPwuagw==
X-Google-Smtp-Source: ABdhPJzqkOj32ZaO+3P5Qf1khy2XosqxXmtjomHSAQuuF7ae+SHvA1glksbWQzSbDtjFWs0zPPHdnw==
X-Received: by 2002:a17:907:417c:: with SMTP id oe20mr19627489ejb.322.1600178078059;
        Tue, 15 Sep 2020 06:54:38 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id ef3sm7912845ejb.114.2020.09.15.06.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 06:54:37 -0700 (PDT)
Date:   Tue, 15 Sep 2020 15:54:19 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Will Deacon <will@kernel.org>
Cc:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        bpf@vger.kernel.org, ardb@kernel.org, naresh.kamboju@linaro.org,
        Jiri Olsa <jolsa@kernel.org>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Zi Shen Lim <zlim.lnx@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: bpf: Fix branch offset in JIT
Message-ID: <20200915135419.GB1748187@myrica>
References: <20200914160355.19179-1-ilias.apalodimas@linaro.org>
 <20200915131102.GA26439@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915131102.GA26439@willie-the-truck>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 15, 2020 at 02:11:03PM +0100, Will Deacon wrote:
> >  		ret = build_insn(insn, ctx, extra_pass);
> >  		if (ret > 0) {
> >  			i++;
> >  			if (ctx->image == NULL)
> > -				ctx->offset[i] = ctx->idx;
> > +				ctx->offset[i] = ctx->offset[i - 1];
> 
> Does it matter that we set the offset for both halves of a 16-byte BPF
> instruction? I think that's a change in behaviour here.

After testing this patch a bit, I think setting only the first slot should
be sufficient, and we can drop these two lines. It does make a minor
difference, because although the BPF verifier normally rejects a program
that jumps into the middle of a 16-byte instruction, it can validate it in
some cases: 

        BPF_LD_IMM64(BPF_REG_0, 2)		// 16-byte immediate load
        BPF_JMP_IMM(BPF_JLE, BPF_REG_0, 1, -2)	// If r0 <= 1, branch to
        BPF_EXIT_INSN()				//  the middle of the insn

The verifier detects that the condition is always false and doesn't follow
the branch, hands the program to the JIT. So if we don't set the second
slot, then we generate an invalid branch offset. But that doesn't really
matter as the branch is never taken.

Thanks,
Jean
