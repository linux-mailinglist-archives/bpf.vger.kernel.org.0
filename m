Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 151B42694D7
	for <lists+bpf@lfdr.de>; Mon, 14 Sep 2020 20:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbgINS3A (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Sep 2020 14:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbgINS2D (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Sep 2020 14:28:03 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56180C06178A
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2020 11:28:02 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id e11so9429343wme.0
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2020 11:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=W3YbmmsfMHlVdLS6jlOLoQAflYIsxSXUugWSN1kR+Rc=;
        b=Y6ZDna6IoIoMEvcCeX8HsYV6y5FPwgzJsnsokv96XLNqt3SNXxCM+Z79rfnLiyStCE
         Muo3JB7WJnyMkZuqp6Ix6dd90jr5V4xhLE1y0JKJmfLJjPTPdcMLxkt9+NCWR9ptZiD5
         8/LRFoeOAHM9vnqIEh/YpuIrpjmI6r0yYwHIAB/yxNDCtDTvHtzY/gRXZw0jzU8DJ6F0
         Js5DdlCtvhBfq1cIXuWba3rlUzKBodjzXdCdujyGzLUyxBTjIJl/1W9YKjT8LP6mVPle
         AcgJdV9z+XuJTJUnu4IuWaGWHm0qMdypbmU45KBUpE8awMEcAnapLRZ9bYP3yNoGG0DN
         5W5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=W3YbmmsfMHlVdLS6jlOLoQAflYIsxSXUugWSN1kR+Rc=;
        b=PIJjDGdkSOe4fYOG23vlYjvjyoYC8N2moXVSG/yr7P+bjHh3YrQAKfF3LbTrHox2+N
         DmyOm49Y95vWTV/jRAqWak8eXw1Yd2IRFRl4laMuZEU58QH1NTkF0O+t4j+J98KRedNl
         nUXIcRsibHuZcVOxYhyNqVCMWzqo+NHNpHAZWhpCm22ts38/NIgAnyvwKplzVU/EQ0tx
         /ACJVYpxp9RDSgqy1Ya65pYfxEKuouq/v7sdsJ4hxU3SaJu0IW8AHN3zv0Vtf7q2S9UT
         98G/tB11rq90XThErOu6M/5HplxTXLwyZNtEB1Qpg2LZnpBsPnze6PbCf8SMp6R28IVn
         qznw==
X-Gm-Message-State: AOAM530GV4RSQv95I1qG4344OJX9fbE2xBdSBxEf7kkDMXyFneOccsSm
        I9WdI3oiFSm2Y1wtl1c29N1DZg==
X-Google-Smtp-Source: ABdhPJwqlkc2zKOHr4CZKudC+z5XkhQYQppbD4OIiflpEBJodVcF2fyVWwwJjG35lxfxhFMJRptUqA==
X-Received: by 2002:a1c:e256:: with SMTP id z83mr683787wmg.137.1600108080849;
        Mon, 14 Sep 2020 11:28:00 -0700 (PDT)
Received: from apalos.home (athedsl-246545.home.otenet.gr. [85.73.10.175])
        by smtp.gmail.com with ESMTPSA id s26sm21264637wmh.44.2020.09.14.11.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 11:28:00 -0700 (PDT)
Date:   Mon, 14 Sep 2020 21:27:56 +0300
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
Message-ID: <20200914182756.GA22294@apalos.home>
References: <20200914083622.116554-1-ilias.apalodimas@linaro.org>
 <20200914122042.GA24441@willie-the-truck>
 <20200914123504.GA124316@apalos.home>
 <20200914132350.GA126552@apalos.home>
 <20200914140114.GG24441@willie-the-truck>
 <20200914181234.0f1df8ba@carbon>
 <20200914170205.GA20549@apalos.home>
 <CAKU6vyaxnzWVA=MPAuDwtu4UOTWS6s0cZOYQKVhQg5Mue7Wbww@mail.gmail.com>
 <20200914175516.GA21832@apalos.home>
 <CAKU6vybuEGYtqh9gL9bwFaJ6xD=diN-0w_Mgc2Xyu4tHMdWgAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKU6vybuEGYtqh9gL9bwFaJ6xD=diN-0w_Mgc2Xyu4tHMdWgAA@mail.gmail.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Xi, 

On Mon, Sep 14, 2020 at 11:08:13AM -0700, Xi Wang wrote:
> On Mon, Sep 14, 2020 at 10:55 AM Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> > We've briefly discussed this approach with Yauheni while coming up with the
> > posted patch.
> > I think that contructing the array correctly in the first place is better.
> > Right now it might only be used in bpf2a64_offset() and bpf_prog_fill_jited_linfo()
> > but if we fixup the values on the fly in there, everyone that intends to use the
> > offset for any reason will have to account for the missing instruction.
> 
> I don't understand what you mean by "correctly."  What's your correctness spec?

> 
> I don't think there's some consistent semantics of "offsets" across
> the JITs of different architectures (maybe it's good to clean that
> up).  RV64 and RV32 JITs are doing something similar to arm64 with
> respect to offsets.  CCing Bj�rn and Luke.

Even if that's true, is any reason at all why we should skip the first element 
of the array, that's now needed since 7c2e988f400 to jump back to the first
instruction?
Introducing 2 extra if conditions and hotfix the array on the fly (and for 
every future invocation of that), seems better to you?

Cheers
/Ilias
