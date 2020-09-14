Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B68BE26943A
	for <lists+bpf@lfdr.de>; Mon, 14 Sep 2020 19:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbgINRzx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Sep 2020 13:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbgINRzW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Sep 2020 13:55:22 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1288FC06178A
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2020 10:55:22 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id a17so584248wrn.6
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2020 10:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ElTPUcJchCYTclnWFUBApUOoz+YOl4EkZJsBh9Oqm7M=;
        b=cuUAU+84+bcCRcYFw24CLpKHuNITQXf7p1urQVL6RK2/oJ82K5sGJ7v8hFQl8OLRzW
         BpJ5DH1ife5I/JNXJXeJag5YfpeHRzta3aRoyoWgrxYpHfo3Bxh9Q1RdHFp767MxpMiN
         kBgTYshqVFgh5dLQzQo00R9KpldmpYXljcrUx9bF5marV5dhEmtXDOdP06ailrdgGxN7
         cCH3A+LIVosl9ceKMEf97poi7u4ALax9x1gN3UaYI5CxPpruirn0WDgdZduFgslniK0V
         Y1ajWQwkeV9DWZLtvtizhbT7e2v3GsHQhj+HAOTjqB664Ibm4Hy2TcNd0c6hSFpigaDL
         juvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ElTPUcJchCYTclnWFUBApUOoz+YOl4EkZJsBh9Oqm7M=;
        b=C8RVJj0FLO78GWFtJb9UZMEgdZ+dpoMAaPPOkWwR7R3TitIVl0GQXGofNBGseza4zi
         Jsa4stffSmuMMy9rr564FTJAhmkk5s/RabT9/9vaoXOYU10Avlawt/YnLqkXmmR3jM7g
         IVgZcdRAOCHDcdoOKE7ZwaWaNsh8r6hb32jwJMRysOKQhrQPF7hZwO4c0IZB9mXU+ay4
         gZxZSDdMg/HHJVOm+jXQZdzjFpsy8VyIbLNRjRx2PCGy9sPVRjOh1uJw7z453gOvWSmY
         vle8r8q3WCrFJm1DQ5qGSMCIuOLnQjIkSJz2Noo3NzolvBduAT3BWzQR7+Ewui9GC0QB
         rFvA==
X-Gm-Message-State: AOAM53177AACN3pjJtnBIZ74g5fostsCZX/jf1cKe82LX5oqBb3zVFnM
        32iBCsHRhd68kmzOz0/Ikkdf3Q==
X-Google-Smtp-Source: ABdhPJz9ziJomH7g1dR+TzMKnxXTi2GW1hQ4O1t+pe18I3Wwg19+Ume2JlE/+x+dZr59Qo76NAwTfA==
X-Received: by 2002:adf:e989:: with SMTP id h9mr18323596wrm.38.1600106120650;
        Mon, 14 Sep 2020 10:55:20 -0700 (PDT)
Received: from apalos.home (athedsl-246545.home.otenet.gr. [85.73.10.175])
        by smtp.gmail.com with ESMTPSA id 189sm20952801wmb.3.2020.09.14.10.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 10:55:20 -0700 (PDT)
Date:   Mon, 14 Sep 2020 20:55:16 +0300
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     Xi Wang <xi.wang@gmail.com>
Cc:     Jesper Dangaard Brouer <brouer@redhat.com>,
        Will Deacon <will@kernel.org>, bpf@vger.kernel.org,
        ardb@kernel.org, naresh.kamboju@linaro.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>
Subject: Re: [PATCH] arm64: bpf: Fix branch offset in JIT
Message-ID: <20200914175516.GA21832@apalos.home>
References: <20200914083622.116554-1-ilias.apalodimas@linaro.org>
 <20200914122042.GA24441@willie-the-truck>
 <20200914123504.GA124316@apalos.home>
 <20200914132350.GA126552@apalos.home>
 <20200914140114.GG24441@willie-the-truck>
 <20200914181234.0f1df8ba@carbon>
 <20200914170205.GA20549@apalos.home>
 <CAKU6vyaxnzWVA=MPAuDwtu4UOTWS6s0cZOYQKVhQg5Mue7Wbww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKU6vyaxnzWVA=MPAuDwtu4UOTWS6s0cZOYQKVhQg5Mue7Wbww@mail.gmail.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 14, 2020 at 10:47:33AM -0700, Xi Wang wrote:
> On Mon, Sep 14, 2020 at 10:03 AM Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> > Naresh from Linaro reported it during his tests on 5.8-rc1 as well [1].
> > I've included both Jiri and him on the v2 as reporters.
> >
> > [1] https://lkml.org/lkml/2020/8/11/58
> 
> I'm curious what you think of Luke's earlier patch to this bug:

We've briefly discussed this approach with Yauheni while coming up with the 
posted patch.
I think that contructing the array correctly in the first place is better. 
Right now it might only be used in bpf2a64_offset() and bpf_prog_fill_jited_linfo()
but if we fixup the values on the fly in there, everyone that intends to use the
offset for any reason will have to account for the missing instruction.

Cheers
/Ilias
> 
> https://lore.kernel.org/bpf/CANoWswkaj1HysW3BxBMG9_nd48fm0MxM5egdtmHU6YsEc_GUtQ@mail.gmail.com/T/#m4335b4005da0d60059ba96920fcaaecf2637042a
