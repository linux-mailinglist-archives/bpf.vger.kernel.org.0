Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 995E81EC1FD
	for <lists+bpf@lfdr.de>; Tue,  2 Jun 2020 20:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbgFBSjq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Jun 2020 14:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgFBSjq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Jun 2020 14:39:46 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B592EC08C5C0
        for <bpf@vger.kernel.org>; Tue,  2 Jun 2020 11:39:45 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id q24so1948215pjd.1
        for <bpf@vger.kernel.org>; Tue, 02 Jun 2020 11:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RtLS8+a88UB49gCeA48ay61o0FJ7r6NvEDuSLjJ15Ws=;
        b=BEYw1+YtCM8/jNfafOjZEiG/Sn4OmMKzw4L8wqdnZx8Rr7aqoQXrg9cgHYBCJWJRYe
         1g95M9p0Mb2LSzvbYAZt1HJ2esEh3EFk+NBAyMpxt7wq/iMEHjrLPUzcBgjhcshjQbPo
         vButaFp/zKOzl5MT8vC1Lflg8kRVpjxGSEXHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RtLS8+a88UB49gCeA48ay61o0FJ7r6NvEDuSLjJ15Ws=;
        b=uF7Ae06wpTQyLxjtDVusIDNsjJJQC/1VKO7FgNBDHiknsZdqMK9aCplOQ9NK+Q7VwQ
         zVLg72W+4LAuOGSf7ox06By6EkdV4gvIa1sKzQtntSPJFHer23eEgjmJh2lnPIqacrhr
         dryXhB9PZ55DO2imumW126D5ZPBiAdjowaoBbbW/OPQrq6nc3MuvFgthzUPHF4zX3+la
         c50lffI/dXo2rFlXqb13ySIyMgm8cujG56+ERJCkPm7VzflgKr3PMDHrket2OnbpEq16
         Iq6X7nIDnEp4ZgbXLDN4KynOSJcGi5RUACOixkQZC4dQqcVb/z8wWv96pi8FN61ZXnd7
         kf4Q==
X-Gm-Message-State: AOAM531ySW+6qHP/Fsh8c+ejTDTK3ezcLnFDE17kWyQ3/3RX4c/rI7Pd
        7DVRqbCuveGoSQQnB+Hgu4QvQA==
X-Google-Smtp-Source: ABdhPJxeJZrKbRy+KqMNDTnZc8TuNFqju+DN5fMoH6TrGPjUPtP8dDdJjqSOfuUssmzxaUde+9NEbQ==
X-Received: by 2002:a17:90b:3691:: with SMTP id mj17mr518962pjb.152.1591123185308;
        Tue, 02 Jun 2020 11:39:45 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j17sm3081062pjy.22.2020.06.02.11.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 11:39:44 -0700 (PDT)
Date:   Tue, 2 Jun 2020 11:39:43 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Lennart Poettering <lennart@poettering.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "zhujianwei (C)" <zhujianwei7@huawei.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        Hehuazhen <hehuazhen@huawei.com>,
        Christian Ehrhardt <christian.ehrhardt@canonical.com>,
        Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
        Tom Hromatka <tom.hromatka@oracle.com>
Subject: Re: new seccomp mode aims to improve performance
Message-ID: <202006021138.6E2073803@keescook>
References: <c22a6c3cefc2412cad00ae14c1371711@huawei.com>
 <CAADnVQLnFuOR+Xk1QXpLFGHx-8StPCye7j5UgKbBoLrmKtygQA@mail.gmail.com>
 <202005290903.11E67AB0FD@keescook>
 <202005291043.A63D910A8@keescook>
 <20200601101137.GA121847@gardel-login>
 <CAHC9VhTK1306C2+ghMWHC0X6XVHiG+vBKPC5=7QLjxXwX4Eu9Q@mail.gmail.com>
 <20200602125323.GB123838@gardel-login>
 <CAHC9VhShd2GLqei6MSREr_vzeVXNcObdVVgvhj1WP7_Ob2C3ag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhShd2GLqei6MSREr_vzeVXNcObdVVgvhj1WP7_Ob2C3ag@mail.gmail.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 02, 2020 at 11:03:31AM -0400, Paul Moore wrote:
> Perhaps others will clarify, but from my reading of this thread there
> is a performance advantage to be gained by limiting the number of
> seccomp filters installed for a given process.

Generally speaking, yes, though obviously the size and layout of a single
filter (i.e. is it a balanced tree?) will still impact the overhead.

-- 
Kees Cook
