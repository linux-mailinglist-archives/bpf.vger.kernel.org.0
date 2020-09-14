Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1807269596
	for <lists+bpf@lfdr.de>; Mon, 14 Sep 2020 21:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbgINTYO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Sep 2020 15:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgINTYN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Sep 2020 15:24:13 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD831C06178A
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2020 12:24:12 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id d4so1093888wmd.5
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2020 12:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GGDNGPz53jgjUxkKKetTXhXWNvLgdULWZECcE+Svp2E=;
        b=NufJBOf/E8NSsdIG8e8b5H0IeV+0Slk/9hNZeoq5bbabzJZedrlt3VEn7pryX3kMkq
         +CH15314AzGYpQ6LrnFATXjZn5Pm6aVxlW7PkWhz4ImJs2nMciZs1JvFIyaQD29ggZJd
         I1RJ1DN+nAGX09eAWy0dLmqgoD60IGFQounoNTK0xpMvyv5iIz6MJuykjkPIhdWd0DcZ
         aw28WXewFpIMSzpAzy19jH1FgcSfiPvObOlqxIwaPBiF18gBIGwn+dOHURzao4zB7tkC
         I6NPDhfdUfoTDmBa7yNqzajtnMFw8yB50Nx6PkUrm3YqYnsD5WRFEEyYw6gBOGnLKscn
         haMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GGDNGPz53jgjUxkKKetTXhXWNvLgdULWZECcE+Svp2E=;
        b=fg5+cHq34HDdBFRA0RVV+hpitj3HVUCaUL+ya74dxr2HHYROjFscI84BuDibEv/Dpi
         dc/L1oRW9/UdH+Q/F8zuKak8NYLJeFfERiANT+Q25MZGRvBVwP4H3mhACEZaNKVL3z9S
         fQUdcizEUtkw8OzTm79j+AnISwTF5MaXchn4O43PUNrxpvvIszWk0qkvTm3coMOQZzdF
         CNlp0eknbKDNSwxNv4CHuYvDukCrRqZTQ7DNUPxicKEcceRVfJfo4pnU0AnPRNEDysXT
         y+3IMK4xkRC2xaz+Q+0jJ+7d1Io9Qj6ts67J5NfXoidQcGOGf9JgdXMbPFCv95klPCdy
         HFpQ==
X-Gm-Message-State: AOAM533IxCr7cd8dCAyebgZ+CM6ptw+JSPhDNbnvYgHvK/s0d6Gt7nXY
        4/i4Vzdm+LRcViBIuu+OqGcIRQ==
X-Google-Smtp-Source: ABdhPJwoKyKG7QEPLSdyBzQxXAayezkFW+nM2ot6KrfPzWSu+EEBDrVGIsCiLs7Rg1qzM5hkOewswA==
X-Received: by 2002:a1c:c90d:: with SMTP id f13mr881140wmb.25.1600111450968;
        Mon, 14 Sep 2020 12:24:10 -0700 (PDT)
Received: from apalos.home (athedsl-246545.home.otenet.gr. [85.73.10.175])
        by smtp.gmail.com with ESMTPSA id t15sm20771064wmj.15.2020.09.14.12.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 12:24:10 -0700 (PDT)
Date:   Mon, 14 Sep 2020 22:24:07 +0300
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
        Anders Roxell <anders.roxell@linaro.org>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn.topel@gmail.com>,
        Luke Nelson <luke.r.nels@gmail.com>
Subject: Re: [PATCH] arm64: bpf: Fix branch offset in JIT
Message-ID: <20200914192407.GB22481@apalos.home>
References: <20200914123504.GA124316@apalos.home>
 <20200914132350.GA126552@apalos.home>
 <20200914140114.GG24441@willie-the-truck>
 <20200914181234.0f1df8ba@carbon>
 <20200914170205.GA20549@apalos.home>
 <CAKU6vyaxnzWVA=MPAuDwtu4UOTWS6s0cZOYQKVhQg5Mue7Wbww@mail.gmail.com>
 <20200914175516.GA21832@apalos.home>
 <CAKU6vybuEGYtqh9gL9bwFaJ6xD=diN-0w_Mgc2Xyu4tHMdWgAA@mail.gmail.com>
 <20200914182756.GA22294@apalos.home>
 <CAKU6vyYhG20qaA1iKwD=-pZHWjZYEZvX6Qmjs=aA-uJ-uwCw7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKU6vyYhG20qaA1iKwD=-pZHWjZYEZvX6Qmjs=aA-uJ-uwCw7w@mail.gmail.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 14, 2020 at 11:52:16AM -0700, Xi Wang wrote:
> On Mon, Sep 14, 2020 at 11:28 AM Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> > Even if that's true, is any reason at all why we should skip the first element
> > of the array, that's now needed since 7c2e988f400 to jump back to the first
> > instruction?
> > Introducing 2 extra if conditions and hotfix the array on the fly (and for
> > every future invocation of that), seems better to you?
> 
> My point was that there's no inherently correct/wrong way to construct
> offsets.  As Luke explained in his email, 1) there are two different
> strategies used by the JITs and 2) there are likely similar bugs
> beyond arm64.
> 
> Each strategy has pros and cons, and I'm fine with either.  I like the
> strategy used in your patch because it's more intuitive (offset[i] is
> the start of the emitted instructions for BPF instruction i, rather
> than the end), though the changes to the construction process are
> trickier.
> 

Well the arm64 was literally a 'save the idx before building the instruction',
and add another element on the array.  So it's not that trickier, especially
if we document it properly.

I haven't checked the rest of the architectures tbh (apart from x86). 
I assumed the tracking used in arm64 at that point, was a result of how 
eBPF worked before bounded loops were introduced. Maybe I was wrong.
It felt a bit more natural to track the beginning of the emitted 
instructions rather than the end.

> If we decide to patch the arm64 JIT the way you proposed, we should
> consider whether to change other JITs consistently.

I think this is a good idea. Following the code is not exactly a stroll in the
park, so we can at least make it consistent across architectures.

Thanks
/Ilias
