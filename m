Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49829389F26
	for <lists+bpf@lfdr.de>; Thu, 20 May 2021 09:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbhETHyw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 May 2021 03:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhETHyu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 May 2021 03:54:50 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73C0C061574
        for <bpf@vger.kernel.org>; Thu, 20 May 2021 00:53:28 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id j14so14837551wrq.5
        for <bpf@vger.kernel.org>; Thu, 20 May 2021 00:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ubique-spb-ru.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CQ67C6wCvhv4qqVS5QHyCWhSP9HxBopjqC+1soAMel8=;
        b=FCoqFMfzT/I8cnTA3Ddr82z1z+OMj5RtiPe+sXDg5aF4g7LcBRbYNFPseCOaan/va3
         hIimi0KCynqva4iIH7zAErqUfnGDNkMDlCEWRyqnBpYDlBouIdGYi4svDsN0cFymXcLK
         0ATdhaOfD7OQIr9PqHmFY7u73wyJTejGQs0Ox9UjCjCbRHcGwDrwE20qRSwCrvwGlSZO
         5s+wEfejm0x05yrmTL5JELMCxSyRZ8Emayq2z3udsrkVhgfOjxZ5sxp07723jQjw4f+u
         VD0E6Xeljk7Vy0FO04tWvfn70b0DRHKVFNjPhLbaigXxDjtwcv5J8rINpPdmrF4fkxDA
         IFXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CQ67C6wCvhv4qqVS5QHyCWhSP9HxBopjqC+1soAMel8=;
        b=fjyeQcG3eN0uS1tEHzRKhi5XTxS2veI9P03Gy23unFPbDwsCVsmjHU9vrfL1gNg571
         W+ZkzKgVv8oercrROG/iZ/HJTeKlcbq3fKlRY2MXiJsVFXBpAGfW+1EKQfY/HlvgBSpQ
         SoHR/x8qkd1hfC6GTr4KshyU0anmzj1ADzr+GROXmEMzRpP06UEzKaoe/jKsmAK68U1N
         7srd5FECquMnvGKpnYu1tjQYJAMiWP5bH3Lkx3fGNoxjTgBpgFi/DMjB57fAGfyyg4HR
         s0NO7p00fQkhZOs5FxOY8Hi0/NNz3bUkqS2suW+auYuv+4DlP01Yzj716SbETccISmWw
         utDA==
X-Gm-Message-State: AOAM530+mxTeU+3CvplWw1HR2OqRP4tqqNIfnhD8a7c7cU5Hb5kbpm3+
        9QLdqLaFEcsBUT2E82EsUgpwxw==
X-Google-Smtp-Source: ABdhPJwTD6G55yCGUWMDJr4ZLmmIaNIsM7cVGKKByVmlmGCYY3Cj3d1jVcvnQ2onCDAwf0MSf4trDw==
X-Received: by 2002:adf:cd0b:: with SMTP id w11mr2732687wrm.178.1621497207400;
        Thu, 20 May 2021 00:53:27 -0700 (PDT)
Received: from localhost ([154.21.15.43])
        by smtp.gmail.com with ESMTPSA id b81sm10148451wmd.18.2021.05.20.00.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 00:53:27 -0700 (PDT)
Date:   Thu, 20 May 2021 11:53:23 +0400
From:   Dmitrii Banshchikov <me@ubique.spb.ru>
To:     Song Liu <songliubraving@fb.com>
Cc:     "open list:BPF (Safe dynamic programs and tools)" 
        <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "andrii@kernel.org" <andrii@kernel.org>, Martin Lau <kafai@fb.com>,
        Yonghong Song <yhs@fb.com>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Andrey Ignatov <rdna@fb.com>
Subject: Re: [PATCH bpf-next 00/11] bpfilter
Message-ID: <20210520075323.ehagaokfbazlhhfj@amnesia>
References: <20210517225308.720677-1-me@ubique.spb.ru>
 <7312CC5D-510B-4BFD-8099-BB754FBE9CDF@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7312CC5D-510B-4BFD-8099-BB754FBE9CDF@fb.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 20, 2021 at 04:54:45AM +0000, Song Liu wrote:
> 
> 
> > On May 17, 2021, at 3:52 PM, Dmitrii Banshchikov <me@ubique.spb.ru> wrote:
> > 
> > The patchset is based on the patches from David S. Miller [1] and Daniel
> > Borkmann [2].
> > 
> > The main goal of the patchset is to prepare bpfilter for iptables'
> > configuration blob parsing and code generation.
> > 
> > The patchset introduces data structures and code for matches, targets, rules
> > and tables.
> > 
> > It seems inconvenient to continue to use the same blob internally in bpfilter
> > in parts other than the blob parsing. That is why a superstructure with native
> > types is introduced. It provides a more convenient way to iterate over the blob
> > and limit the crazy structs widespread in the bpfilter code.
> > 
> 
> [...]
> 
> > 
> > 
> > 1. https://lore.kernel.org/patchwork/patch/902785/
> 
> [1] used bpfilter_ prefix on struct definitions, like "struct bpfilter_target"
> I think we should do the same in this version. (Or were there discussions on
> removing the prefix?). 

There were no discussions about it.
As those structs are private to bpfilter I assumed that it is
safe to save some characters.
I will add the prefix to all internal structs in the next
iteration.


> 
> Thanks,
> Song
> 
> [...]
> 

-- 

Dmitrii Banshchikov
