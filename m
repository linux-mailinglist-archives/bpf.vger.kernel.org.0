Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5DF25B552
	for <lists+bpf@lfdr.de>; Wed,  2 Sep 2020 22:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgIBUcM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Sep 2020 16:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbgIBUcL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Sep 2020 16:32:11 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17ADBC061244
        for <bpf@vger.kernel.org>; Wed,  2 Sep 2020 13:32:09 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id c142so301639pfb.7
        for <bpf@vger.kernel.org>; Wed, 02 Sep 2020 13:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xP3dxRGD8+RWbCHDyfNB47bCTyXi43FjdogvuvOHjmE=;
        b=neIF/gk2oo4oGMb3ARECwwtGZrU2sltoDkQKLKOTtjdAnCGWqOGMrmuOKc3qPVWyIy
         DDzm4YjF4TR54tUpL7sqYIUfASUjbNHWFgpu0JvK+BA+xtGNJI6AdHiAj732O7J0snrt
         dmzR4tg0joMRFIU2sGAASxqjlIDBSVl2GD8Xaa+8VRfblyztqq++BQm9XAfL+0G3mcmc
         oEbcebCtd90TU//jV6Tl1yvReKyw/aLDgHCgQDSk3Ilj4I1cLdzL6WzPxLhU0Of6jQF4
         JLw50V+ydyjnDtnphPh1219GvuliC97PTR0TdpnlL6TcI6uPnLeIysuv3cOYfEnqNEvu
         mczg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xP3dxRGD8+RWbCHDyfNB47bCTyXi43FjdogvuvOHjmE=;
        b=JjlXYay35NgEN/d5TaoNxAYPE7iocsK8C0fcO6xfCZoC9OuIaX9AEHSh+7iA6dZrh0
         nl16ATdmmO2T5a4cHfK72+97zLN9o8LqydR4VrT3+bB5TKYr14y1HdeZ8TDpGKG9av7l
         kmtYgIsM0JlT8MpleKKhc356VnQQmyjag3LrEORUXKyH2Uv6BeK0uISoQ2IcKRd7yVXK
         rFz8EzzA1MyoZgmls9w7Sxw6KHsjSNzzC957ixyMWhPyrqVn8pCz104JwTYD3JINBjyH
         EE6KYJysOOGUYIIuR8uyiw+coa12HWXzQv0W8+kdmmzisUwA1m5NjNxjN84sXV3y+D1u
         Ypdg==
X-Gm-Message-State: AOAM531iWqdp9T6juqnlmIjcLh29Bi9CXOPrO6B8QHI+HLSGefN3S1U2
        OKyHSPtt7nHxaRnIDSSD/ohGe8mqimI=
X-Google-Smtp-Source: ABdhPJxnFK+32MEQHHdAXWA5qCCZ/EIA4aRxLWnkPgRI2FRckUpneFu6cUi31vX19r7qliDIXFGblw==
X-Received: by 2002:a62:1984:: with SMTP id 126mr191686pfz.17.1599078729031;
        Wed, 02 Sep 2020 13:32:09 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:b65c])
        by smtp.gmail.com with ESMTPSA id q18sm386198pfn.106.2020.09.02.13.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 13:32:07 -0700 (PDT)
Date:   Wed, 2 Sep 2020 13:32:06 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc:     bpf <bpf@vger.kernel.org>
Subject: Re: EF_BPF_GNU_XBPF
Message-ID: <20200902203206.nx6ws4ixuo2bcic6@ast-mbp.dhcp.thefacebook.com>
References: <87mu282gay.fsf@oracle.com>
 <CAADnVQ+AZvXTSitF+Fj5ohYiKWERN2yrPtOLR9udKcBTHSZzxA@mail.gmail.com>
 <87y2ls0w41.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y2ls0w41.fsf@oracle.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 02, 2020 at 10:19:58PM +0200, Jose E. Marchesi wrote:
> 
> As such, the property of being verifiable is irrelevant.

No. It's a fundamental property of BPF.
If it's not verifiable it's not BPF. It's not xBPF either.
Please call it something else and don't confuse people that your ISA
has any overlap with BPF. It doesn't. It's not verifiable.
