Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 257AF3E965E
	for <lists+bpf@lfdr.de>; Wed, 11 Aug 2021 18:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbhHKQzO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Aug 2021 12:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbhHKQzN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Aug 2021 12:55:13 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F4EC061765
        for <bpf@vger.kernel.org>; Wed, 11 Aug 2021 09:54:49 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id q11-20020a7bce8b0000b02902e6880d0accso4943998wmj.0
        for <bpf@vger.kernel.org>; Wed, 11 Aug 2021 09:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cilium-io.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1DeZa53WmN8kOBvVfNnGpXloM2d6gi9HhD+sBzEvNxA=;
        b=vNYTGRgDWXmGsR+aa5ST0GoWmgA6BXwhdY6/FK/C+HB+MymAPMSgQLXOhWWnfOVlbv
         jNIfrJKO0CmwNap/stiHQgZQ8Y3tlV83vji+gXBmark4gYG8nHBhpwcD6eeavB8+UY6X
         VOCsh35+5XYc6+go7sZLYjx2wnqQY4NazNYUVFLHdbdVcPmc6YuYRoewqfSvz/7k/CgL
         1jYiq9H0JzmyhJVcOKZ4uWoGNpW9uGklu80BtMSluA+HJf9d3u95SgUdTe0KDGpZZ4hI
         2J4uYyHC7WHMjV9vLh7fBr8WijTX0Phc6Fx1Yeo0SMwinsMjyUQJtrYXSiwX352EDFW/
         HJ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1DeZa53WmN8kOBvVfNnGpXloM2d6gi9HhD+sBzEvNxA=;
        b=EV1Xw4YLAfgsyZzaHEqJm4HzddBZbh8xUn7pNH3pZJB1LjVbPDfmh4FvNTOg/7codd
         Kg6nw2fu+DeS6i6vRAnK87iGM8Tum1zoBE6G0/G29/LthYwW6RRqp7AUl905tN3D+VRq
         WL71EORRc4kdl1yRC/AfmrB3eoYJ1sMJf3rGkbSVKDQJIYpHgWjVyW4lnOvnPVgjBkIm
         pRD0GfnZekvt0W4LTy8lC11WNHX9lEELIQiKd93zV6GbY8fd8wUnU1G9QuP5fMpWQCa0
         kv/gDAm0Fhm5mpoHq0PrVGERrJ5sIeqG4mh4njuWxSxWpNHV0o4JjZ/NT5jGSdRDYuvz
         tWLg==
X-Gm-Message-State: AOAM533hozM8sBAa6tIA4NkPiulagKeZAErQppqkqxO6+N6NpdfbgadB
        V3T5ULqXwNg0x0/CMzNXEzvC
X-Google-Smtp-Source: ABdhPJwywoLjt2Q6fkJ67Cp1K8Q47GTpmfIVu6ESR7lKKZrqZxgzZfRsEvOrDFv3h9xRtpSrsi8sBg==
X-Received: by 2002:a1c:4b18:: with SMTP id y24mr11387531wma.49.1628700888514;
        Wed, 11 Aug 2021 09:54:48 -0700 (PDT)
Received: from Mem (2a01cb088160fc00a97e79e946129d17.ipv6.abo.wanadoo.fr. [2a01:cb08:8160:fc00:a97e:79e9:4612:9d17])
        by smtp.gmail.com with ESMTPSA id e25sm15801666wra.90.2021.08.11.09.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 09:54:48 -0700 (PDT)
Date:   Wed, 11 Aug 2021 18:54:46 +0200
From:   Paul Chaignon <paul@cilium.io>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Martynas Pumputis <m@lambda.lt>
Subject: Re: R11 is invalid with LLVM 12 and later
Message-ID: <20210811165446.GA30403@Mem>
References: <20210809151202.GB1012999@Mem>
 <a40405b0-3856-9d15-f973-ffae2e853384@fb.com>
 <d1054971-0cd5-5698-c895-f412d1b47bb2@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1054971-0cd5-5698-c895-f412d1b47bb2@fb.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 09, 2021 at 11:31:48PM -0700, Yonghong Song wrote:
> On 8/9/21 3:53 PM, Yonghong Song wrote:
> > On 8/9/21 8:12 AM, Paul Chaignon wrote:

[...]

> > > LLVM 12.0.1 and latest LLVM sources (e.g., commit 2b4a1d4b from today)
> > > have the same issue. We've bisected it to LLVM commit 552c6c23
> > > ("PR44406: Follow behavior of array bound constant folding in more
> > > recent versions of GCC."), but that could just be the commit where
> > > the regression was exposed in Cilium's case.
> 
> The above commit is indeed responsible. With the above commit,
> the variable length array compile time evaluation becomes conservative.
> For cilium function dsr_reply_icmp4 in nodeport.h
>   const __u32 l3_max = MAX_IPOPTLEN + sizeof(*ip4) + orig_dgram;
>   __u8 tmp[l3_max];
> 
> I didn't try to compile with/without the above commit, the following
> is the thesis.
> 
> Before the above commit, llvm evaluates the expression
>   MAX_IPOPTLEN + sizeof(*ip4) + orig_dgram
> and concludes that l3_max is a constant so tmp can be allocated
> on stack with fixed size.
> 
> With the above commit, llvm becomes conservative to evaluate
> the expression at compile time. So above l3_max becomes a
> non-constant variable and tmp becomes a variable length
> array. Since it becomes a variable length array, the
> hidden stack pointer "r11" is used and this caused a problem
> in verifier.
> 
> To workaround the issue, simply define "tmp" with
>    __u8 tmp[68];

Thanks Yonghong!  I've tested this workaround on the Cilium codebase
with all of our tested configurations.  I'm not seeing this R11 issue in
this BPF program or anywhere else anymore.

> But that is not for from user experience. I guess we can do:
>   1. for BPF target, let us still do aggressive constant folding
>      in compile time in clang, basically restores to pre-commit-552c6c23
>      level for BPF programs.
>   2. provide an error message if r11 is generated in final code.
> 
> Will come back to this thread once I got concrete patches. Thanks!

I'm happy to run any patch you have through the Cilium CI if that helps.

> 
> > > 
> > > -- 
> > > Paul
> > > 
