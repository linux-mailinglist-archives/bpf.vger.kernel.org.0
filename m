Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F40A412D68
	for <lists+bpf@lfdr.de>; Tue, 21 Sep 2021 05:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232378AbhIUD0o (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Sep 2021 23:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352137AbhIUClV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Sep 2021 22:41:21 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774E3C0613DE
        for <bpf@vger.kernel.org>; Mon, 20 Sep 2021 19:32:37 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id z14-20020a17090a8b8e00b0019cc29ceef1so906888pjn.1
        for <bpf@vger.kernel.org>; Mon, 20 Sep 2021 19:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Kh9m4MsiS5aI2YIIkSc7q5nTUFUakrir8LRIIqVUNec=;
        b=Wk0DGPRtV9aFleftAiyyoOdH1EdwsyP4fwPNPCzbT8Ucs/Tvmj379NjXAU7E6NGDJN
         H5CSmVObGptPI0ivz+G+pRMrWy06hhikY77FGYMpmOy+eQLbI4i0ut1w2guhUYRyhK1E
         CT3aRnkF20s9FDWigHhDtfssDZcCDIWjV2zgTJ3EnxqksCV6gbsqFGUW4rxhWdRExF62
         ++RdnTYZ+pglknIFbIsa3y+tO9VE9xHt31MjFE1qB1ofGZFOorDVR9mI8Z4VYY2ssrPs
         Y47/Nnd7BPE9uhtTP6wq43fUfs7zStFcdvRHg19+Cv9VfR+ml8AL5ojR2dXtj1eufRyT
         2V2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Kh9m4MsiS5aI2YIIkSc7q5nTUFUakrir8LRIIqVUNec=;
        b=rCJq1okTePtI25keIP11D5+HG/3HsxArDt9YoCbAPejkXjLkueMaIBJFdh+Dy3O++M
         CwNCT/GfB3cye55a6P9cR1E95b3QQoZnbWP9w32zBaxanXfZ3KIthgJLZtjsf311WTm6
         jbPMiIEAxSVrUwQTNktlCiGJ+tA2g0n4TJmBiuiRT0YbGQMuuDxuiSjrWQrFSDOT8HIW
         FB846UqaC5mMY1Sbf/xsdIyaRyLIe5rxooMwq4SNxTJ6BLpl1IUIi2k1yqYC0GT+gmkQ
         WN9yl+FBNbQ58YhxdO89xf1CwvRSpulGxXVm5fFIO6VyLpYeawl1zJ/uQT3grZ0c4qET
         rNfA==
X-Gm-Message-State: AOAM5319jhB1OACfYGgl+hsGwC9Vp+DJNtbaISfI0+2zS1RujbmW0QZ8
        3uO/P/7YErpofssNB7fSdUwDREyBTKs=
X-Google-Smtp-Source: ABdhPJwOQXMO44hgiyNrJoKo9lAr8TxDvL5PGwbadBLGgY6jPjZNaZfIm1mTAfCvMugKO6/hQCMeKQ==
X-Received: by 2002:a17:902:d202:b0:13a:709b:dfb0 with SMTP id t2-20020a170902d20200b0013a709bdfb0mr25550666ply.34.1632191556751;
        Mon, 20 Sep 2021 19:32:36 -0700 (PDT)
Received: from ast-mbp ([2620:10d:c090:400::5:e78f])
        by smtp.gmail.com with ESMTPSA id a4sm625683pjd.48.2021.09.20.19.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 19:32:36 -0700 (PDT)
Date:   Mon, 20 Sep 2021 19:32:34 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH bpf-next 3/4] bpf: selftest: A bpf prog that has a 32bit
 scalar spill
Message-ID: <20210921023234.pjnby3s4q4o4agwe@ast-mbp>
References: <20210921013102.1035356-1-kafai@fb.com>
 <20210921013122.1037548-1-kafai@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210921013122.1037548-1-kafai@fb.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 20, 2021 at 06:31:22PM -0700, Martin KaFai Lau wrote:
> It is a simplified example that can trigger a 32bit scalar spill.
> The const scalar is refilled and added to a skb->data later.
> Since the reg state of the 32bit scalar spill is not saved now,
> adding the refilled reg to skb->data and then comparing it with
> skb->data_end cannot verify the skb->data access.
> 
> With the earlier verifier patch and the llvm patch [1].  The verifier
> can correctly verify the bpf prog.

Let's land llvm patch and wait until CI picks up the new llvm build?
Please add a comment to selftests/bpf/README.rst that describes
the failing test when llvm is old.
I'm guessing there is no easier way to reliably skip the test
in such situation, since failure to load might be the result
of some future changes.
llvm version check won't work either.

the patch 2 looks correct to me. I couldn't spot any issue with the logic.
