Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7A34568DC
	for <lists+bpf@lfdr.de>; Fri, 19 Nov 2021 05:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhKSEDp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Nov 2021 23:03:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbhKSEDp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Nov 2021 23:03:45 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126F0C061574
        for <bpf@vger.kernel.org>; Thu, 18 Nov 2021 20:00:44 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id gb13-20020a17090b060d00b001a674e2c4a8so7717070pjb.4
        for <bpf@vger.kernel.org>; Thu, 18 Nov 2021 20:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pSIDgpAt1z6IuTD6l6+LX1moqWSVPUJKOzqBGTn2Oqg=;
        b=PdMqldsT+2HAt5ZWD3PuARqnZNTNRAuoS7xnvtqbhhh7bGos+9+v0fXrRHT6PES0TL
         6A+O9d7BjkdkjUHUNw76qkaITd9izJow7fya0Lfjhr9BjqZ9FzctxPikW6FMna18eD4g
         zfNZbgAy32fPNo4JShQzdhxz+18dG9DmAIbt1LPKAUoroW8SdHgzeA45uRIEy2HDLJ1Z
         hhvjMBPHt2nnpbTreYYCB86QPFbZvzqKke9moaXyOMDV4jezC8Ra/roDq5inzCSemKoJ
         PfU7uyOGBOzobPXNLtJhPW8uq40FCwCUKou815gWv34bD0Sb0tvS5JbdS6oIQxIRivk5
         sw+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pSIDgpAt1z6IuTD6l6+LX1moqWSVPUJKOzqBGTn2Oqg=;
        b=aq1MU2k63pYeaDkFTAM05VQ9pAN7uGy0yUVc8L1+a95usolF3OWVMkq1vZ7kiJE6C8
         TL1sBtHN8nA4hCKAtoecKw1RvILOWFr2jtjU/qEdhjqazy1Zcn9MbERIOMGHZ2JK9mdX
         xiF7VSjndt1l5rkYyqza6RikGCH3Xck2jXDVHanqmKiLbTyvA1SXPckPGIqm6vX6Qmip
         +2LseNjfuJ+3xpFgiCjGRJK9T8JzSNbsa26YHOn+t5cl406dEd+08x4U6o0KecA+6oU8
         8+WAjpBhvb+ynYQEa04nOzcSaxohtR7vsy7gCVfdglmp3opZ4DINwkRQapCgSLnFdm2Q
         b2pQ==
X-Gm-Message-State: AOAM530YMjk+zcztx9DWYDbuIqYcgChEsoyvrGhNGAe9ZOeGGmaEnmWa
        K9wmGerDc8VociK6r/lmfUw=
X-Google-Smtp-Source: ABdhPJwgl5AI4LR2i++JR3Oslus3lPKl8GFNHU8kchmQ4t2HVjc9oD7WpVa3HRKYO1HNwy33tFtoLQ==
X-Received: by 2002:a17:902:c7d5:b0:143:72b7:2ca5 with SMTP id r21-20020a170902c7d500b0014372b72ca5mr72661907pla.20.1637294443579;
        Thu, 18 Nov 2021 20:00:43 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:4e33])
        by smtp.gmail.com with ESMTPSA id x18sm1068292pfh.210.2021.11.18.20.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 20:00:43 -0800 (PST)
Date:   Thu, 18 Nov 2021 20:00:41 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH v2 bpf-next 12/12] selftests/bpf: Additional test for
 CO-RE in the kernel.
Message-ID: <20211119040041.uy7e5vk6wohcyd6b@ast-mbp.dhcp.thefacebook.com>
References: <20211112050230.85640-1-alexei.starovoitov@gmail.com>
 <20211112050230.85640-13-alexei.starovoitov@gmail.com>
 <CAEf4BzZXFvSn=h3ZgP4U-ydQyrRQXQRQgk0gGPyhjg3vvhRY4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZXFvSn=h3ZgP4U-ydQyrRQXQRQgk0gGPyhjg3vvhRY4A@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 16, 2021 at 08:18:44PM -0800, Andrii Nakryiko wrote:
> > +
> > +       skel = core_kern_lskel__open_and_load();
> > +       if (!ASSERT_OK_PTR(skel, "open_and_load"))
> > +               goto cleanup;
> > +
> > +       err = core_kern_lskel__attach(skel);
> 
> Why attaching if you are never triggering it? This test is about
> testing load, right? Let's drop the attach then.

Good point. Indeed!
