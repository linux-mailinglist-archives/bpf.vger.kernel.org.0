Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC69322085
	for <lists+bpf@lfdr.de>; Mon, 22 Feb 2021 20:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbhBVTy2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Feb 2021 14:54:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbhBVTyU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Feb 2021 14:54:20 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16DD2C061574
        for <bpf@vger.kernel.org>; Mon, 22 Feb 2021 11:53:39 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id l30so4656191wrb.12
        for <bpf@vger.kernel.org>; Mon, 22 Feb 2021 11:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ubique-spb-ru.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8O+Xp65yAhHRtZpm53SIjwc94fKjocM5mTj2V2duR8s=;
        b=BbHU844tEZSufq5i5KevWbwXlE0lfWSXEqWBJaeNGPWu1Z/k/dQuOcj2vtK2RtM352
         bNu33Mby63gOTM9RcNuTMTIVYycr8tLLp8Yf0mmJOkTema9hDYwDvhExvdeyepHGWkvl
         TkveaYahFJk4VtkOqCtIKyVr91iM96jmOzIVbwhrvlf2KnYj5J0Lb7kCxkovf/53ve4F
         5SplDo7o6ioQohIHOzD5s1zZ3NMlDuN2KHrZQr/uY0Yd30lxUECkBgyAEk6EwHuvCdUZ
         1WKJKE7YL8DLFp0o63UU8PSb0vIjgOLfV4O25bQnzzAYRf28Cb6MkH0yLmuYXXEGdvH/
         MyNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8O+Xp65yAhHRtZpm53SIjwc94fKjocM5mTj2V2duR8s=;
        b=U5BKIaXMQ0Tehx3bqdnN3OmWPlZvDEGVM7y0vVRucrTAGPdv6tlqKWhOwJ3RGYdXkI
         6ky0Ya9V80MzE50HfEXr9ihFUarPmedayGoOfj0kPtqTugB2wEuSaiIcRmJzi94//UFH
         p90lscof2si2jA8SkuJohHpc3GSA/nIRvhR16D6V/s7upF97eH5cJZLURZ8qeSQSzsbS
         N4pQXcKcud6zQHEN+cys/etR93FIJnaQJwYGDO0EVhQ3c1YJzsGW1WWdcVZmYngvPj7R
         iVd0A/zfjHTba7mOi+sbupSgyAEDyiH3bXbknov2ayGvtZPOXDE307V0uTFtghWh5wZm
         GK7w==
X-Gm-Message-State: AOAM532IqfkjigG9ogSM+6YMfFyMg0QgshQC8dcIcPJAuPkcgDbXOXTo
        3W48us+6MDp1g+C9a8zzBFz8QQ==
X-Google-Smtp-Source: ABdhPJwmKg40hbCnXPmoV4/8WlYz9JTGjLr5HFE8gpdIliCgDPPYA3Tvj96s4RTFoXQY1hQZ+dsVWA==
X-Received: by 2002:a5d:4903:: with SMTP id x3mr22701337wrq.95.1614023617810;
        Mon, 22 Feb 2021 11:53:37 -0800 (PST)
Received: from localhost ([154.21.15.43])
        by smtp.gmail.com with ESMTPSA id v9sm3422446wrt.76.2021.02.22.11.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 11:53:37 -0800 (PST)
Date:   Mon, 22 Feb 2021 23:53:35 +0400
From:   Dmitrii Banshchikov <me@ubique.spb.ru>
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@chromium.org, rdna@fb.com
Subject: Re: [PATCH v1 bpf-next] bpf: Drop imprecise log message
Message-ID: <20210222195335.bap6t5qwgvdu5rqm@amnesia>
References: <20210221195729.92278-1-me@ubique.spb.ru>
 <20210222091050.160161-1-me@ubique.spb.ru>
 <20210222193111.3koc5bo3czetwltx@kafai-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210222193111.3koc5bo3czetwltx@kafai-mbp.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 22, 2021 at 11:31:11AM -0800, Martin KaFai Lau wrote:
> On Mon, Feb 22, 2021 at 01:10:50PM +0400, Dmitrii Banshchikov wrote:
> > Now it is possible for global function to have a pointer argument that
> > points to something different than struct. Drop the irrelevant log
> > message and keep the logic same.
> Acked-by: Martin KaFai Lau <kafai@fb.com>
> 
> > Fixes: 4ddb74165ae5 ("bpf: Extract nullable reg type conversion into a helper function")
> Should be this: e5069b9c23b3 ("bpf: Support pointers in global func args")?

Yeah, sorry for it.


-- 

Dmitrii Banshchikov
