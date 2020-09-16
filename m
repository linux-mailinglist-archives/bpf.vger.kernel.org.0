Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8F3526C392
	for <lists+bpf@lfdr.de>; Wed, 16 Sep 2020 16:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbgIPOSy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Sep 2020 10:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbgIPNcn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Sep 2020 09:32:43 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920A2C014DBC
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2020 06:17:22 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id l15so2227613wmh.1
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2020 06:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HYDGktxm5Yk9Jc3ILH+B9gt66sMh0wgrn23SbZ7R4kg=;
        b=tjryK8s0CUqs3kovVGVx+IXeKZCQBuHIBzYbxKssEuOfWAmunncudTXIsNk0wVmDgD
         8ECYqhSLGrmhzcOJKGWqb3AvzQmVoXXr1oahpyMoDnSKeODjHmQBxSEDQa1FOpFoMNAw
         cReUomjwPtgNPST8bh1MGsbfkbjHkwysi85sreirEDS6ZoFBBb38GCNUg1hzinT0suhM
         AwgoUmns6X3G9id4xFydV8NyppVGeVZJdHvvUp7gw9hkWPK9umHBDNlxmszmTT+RimNd
         A+QxU8CeznkX3zKc0YUMU0HK4u3KGMCMEcSt3OffGjBHvlRLofDQUuKxPb3KDV7Tseaw
         pWQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HYDGktxm5Yk9Jc3ILH+B9gt66sMh0wgrn23SbZ7R4kg=;
        b=QYKdIEObpd+eiGMHxxEJoJQ4Df8VBWPcxlYtS75xyhK2jKEVX23K9rk3h0EwBa3WtM
         G6ijd6dPiOSp7ZjSfj9y6ZfGQo2RIVOryv45ksuDYglcQeKH+bGw48+8+FzMfZwyQRZz
         pEizLbetiMXblur9YJUjpa7a+ynk5kmq2MqxBMnvsKBvJlWtze60dC4gwBo0wZrDPrTG
         KCvY4fQWxpAgJSn9FxGXa8nv/xt5OJHmTIgzEI3mq2711ZMLB07M4GwoD1GcyejCZ/pH
         DZrW+J8sltgmOpdwbPVrSrXLIb0jOK7kBkBk9I9P4pETJ0+G6xj4C2UsneUiisMphZYd
         UN+A==
X-Gm-Message-State: AOAM530SBFPXM2Vk3OhovYqYPvT/GBU7N7SLw68+asUxiRMRwUt8HalW
        GXVK/DYpQWPpTZqbfvtX2QEtYQ==
X-Google-Smtp-Source: ABdhPJx8U4yEfYF7c9LM4YlgMc/Is2k63uF9wauRkwth16t0jTMXEnEugF/Na7HedGEh7Idj2lypcA==
X-Received: by 2002:a1c:c906:: with SMTP id f6mr4972209wmb.9.1600262241258;
        Wed, 16 Sep 2020 06:17:21 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id j14sm34538837wrr.66.2020.09.16.06.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 06:17:20 -0700 (PDT)
Date:   Wed, 16 Sep 2020 15:17:02 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Will Deacon <will@kernel.org>, bpf@vger.kernel.org,
        ardb@kernel.org, naresh.kamboju@linaro.org,
        Jiri Olsa <jolsa@kernel.org>,
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
Message-ID: <20200916131702.GB5316@myrica>
References: <20200914160355.19179-1-ilias.apalodimas@linaro.org>
 <20200915131102.GA26439@willie-the-truck>
 <20200915135344.GA113966@apalos.home>
 <20200915141707.GB26439@willie-the-truck>
 <20200915192311.GA124360@apalos.home>
 <xunyo8m5hp4m.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xunyo8m5hp4m.fsf@redhat.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 16, 2020 at 03:39:37PM +0300, Yauheni Kaliuta wrote:
> If you start to amend extables, could you consider a change like
> 
> 05a68e892e89 ("s390/kernel: expand exception table logic to allow new handling options")
> 
> and implementation of BPF_PROBE_MEM then?

Commit 800834285361 ("bpf, arm64: Add BPF exception tables") should have
taken care of that, no?

Thanks,
Jean
