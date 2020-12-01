Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F113C2CA2D6
	for <lists+bpf@lfdr.de>; Tue,  1 Dec 2020 13:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbgLAMir (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Dec 2020 07:38:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728757AbgLAMiq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Dec 2020 07:38:46 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87865C0617A6
        for <bpf@vger.kernel.org>; Tue,  1 Dec 2020 04:38:06 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id a6so2503186wmc.2
        for <bpf@vger.kernel.org>; Tue, 01 Dec 2020 04:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CFJoCo9pGKzz38Qf5U4Ymk7qbp28hoCq6Dpp7bT0lkg=;
        b=TQ3ioOF4E5jkFmiHOU+QgPeu+/1fYg78yG8i36jSZUeHyCoJUbr2wGb9P+/oWD3KrI
         0pOze1JyAKUZkega+AuiYUlyqGEun3kJKY4yo8pPwJ0nOf2ydd6VfkCcy3VJYAntV2EM
         CNkdQjAzFx1T71gak+UBnoUKp6VgoWpwsiZS7HMh7QtqEMNRWoLfbU//Iw1CxzPJS+EB
         Lk/g8KuHuRAjJZcFjGAjLCxQLZWPLbYf5FJ+560fkGex2a2wrZDbluFNXHg9w5FY89rg
         i4RyvJlTbmkFbiTm4aAtdKySLwlc+F23Zgrm3CLR3W0Dai1z2jxGPD/Yfb5CHI1nEGgF
         tj/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CFJoCo9pGKzz38Qf5U4Ymk7qbp28hoCq6Dpp7bT0lkg=;
        b=jIIYYkd9zl85UcdxHvAJauDX/A4g1g5UBvHB3Ir3SS9ZGCHdI/F3vYgxjxQ9MBTnmF
         Zcwx5fyIqXbV7+HRf8m1jOXQ1Vh4Ch3qDCxOKbl4J8C/ZDNBcgIO9AB2xEj5hSdHteS4
         bRGq4dSfzajQeELzAjK71JQwQiDsv06YN1JPCvi4z42y1dlflVq5Ppr9iw5tiGJ+GWLG
         doUlDC1zwYVTaoojT1PMp6QVfQLiNa4dLZ45xZKjbSki9yZA31OrkAV4vWrzc+2PXGOe
         2lto+LMQE/4Tm3moUF2OPrLTfCuf0Uc6dBo1sgRa6BVOkrd0UE1WdQgL/cRquACyQ0v6
         Q+Kw==
X-Gm-Message-State: AOAM533WacvCbWx3M2X16vZRu4E6f/6q8zfBe587XWroDARCnsLblpMh
        q0tCr3698UBkl5GEyJrKb3cJXQ==
X-Google-Smtp-Source: ABdhPJzCBtX7sfsffGEcm/750hR+tpjSI8VFLs8CRGMT0oo8WSg6lUVUCSCaOM8lz+rgd66K4V4lhA==
X-Received: by 2002:a05:600c:2209:: with SMTP id z9mr2520138wml.72.1606826284613;
        Tue, 01 Dec 2020 04:38:04 -0800 (PST)
Received: from google.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id l3sm3015166wrr.89.2020.12.01.04.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 04:38:03 -0800 (PST)
Date:   Tue, 1 Dec 2020 12:38:00 +0000
From:   Brendan Jackman <jackmanb@google.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: Re: [PATCH v2 bpf-next 10/13] bpf: Add instructions for
 atomic[64]_[fetch_]sub
Message-ID: <20201201123800.GG2114905@google.com>
References: <20201127175738.1085417-1-jackmanb@google.com>
 <20201127175738.1085417-11-jackmanb@google.com>
 <0fd52966-24b2-c50c-4f23-93428d8993c4@fb.com>
 <20201129013420.yi7ehnseawm5hsb7@ast-mbp>
 <1dfd2e5e-f8d2-eac2-d6b2-7428ceb00c36@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1dfd2e5e-f8d2-eac2-d6b2-7428ceb00c36@fb.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 30, 2020 at 09:18:09AM -0800, Yonghong Song wrote:
> On 11/28/20 5:34 PM, Alexei Starovoitov wrote:
> > On Fri, Nov 27, 2020 at 09:35:07PM -0800, Yonghong Song wrote:
> > > On 11/27/20 9:57 AM, Brendan Jackman wrote:
[...]
> > > > +#define BPF_ATOMIC_SUB(SIZE, DST, SRC, OFF)			\
> > > > +	((struct bpf_insn) {					\
> > > > +		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
> > > > +		.dst_reg = DST,					\
> > > > +		.src_reg = SRC,					\
> > > > +		.off   = OFF,					\
> > > > +		.imm   = BPF_SUB })
> > > 
> > > Currently, llvm does not support XSUB, should we support it in llvm?
> > > At source code, as implemented in JIT, user can just do a negate
> > > followed by xadd.
> > 
> > I forgot we have BPF_NEG insn :)
> > Indeed it's probably easier to handle atomic_fetch_sub() builtin
> > completely on llvm side. It can generate bpf_neg followed by atomic_fetch_add.
> 
> Just tried. llvm selectiondag won't be able to automatically
> convert atomic_fetch_sub to neg + atomic_fetch_add. So there
> will be a need in BPFInstrInfo.td to match atomic_fetch_sub IR
> pattern. I will experiment this together with xsub.
> 
> > No need to burden verifier, interpreter and JITs with it.
> > 

I guess it's also worth remembering other archs might have an atomic
subtract.
