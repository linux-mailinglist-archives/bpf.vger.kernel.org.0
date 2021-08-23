Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FEB43F4DC3
	for <lists+bpf@lfdr.de>; Mon, 23 Aug 2021 17:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbhHWPwf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Aug 2021 11:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbhHWPwf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Aug 2021 11:52:35 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E0CC061575
        for <bpf@vger.kernel.org>; Mon, 23 Aug 2021 08:51:52 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id oa17so12270213pjb.1
        for <bpf@vger.kernel.org>; Mon, 23 Aug 2021 08:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eQACu/hwwHjdKf3BvfBNntckyXeGPydw0NB/8Jhtwik=;
        b=T69l+Al2dQuLamsFncrBh9qk/usPIFQz1+BBd35sB96Y0EcPXZRC45usfa/m1pW5Ux
         D+v+hiCqjCaV/cEFjGhfHy4/C+OzAzF7Yf7XAptFRV2mZZqBRegqQATxp9FYrb0YpsUn
         lqTPOJ4eMRUTuMCn8cSc3ldNg/ZVm4vRuxBNGnYyO2whC+W1Y/yitECbLTbjN5KoMosP
         0zCouSSQUJxbsvllzyq2mNfaX8QWFWHfcWsIhEjYku6xDYju/5ur6AbKF38iNa9905Gp
         77h5x3yAGjtpD8O9ZT9KOaVh0ZmT3cmgsgdsi/exCJSZcQLGNzmDJ2lt5VsJ8UV4Bo6I
         tyAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eQACu/hwwHjdKf3BvfBNntckyXeGPydw0NB/8Jhtwik=;
        b=VQvB29LRXeK1eOD/sW2QIf1+tfvNZdBKkqhIdbWN1WtjsRYk34YOA3Sph/I6+17AfJ
         kYolmWY8QF+vuhHCyUH7AVXPy57Mfhi+zkFzmxMDxFyWV7rLYX5EMhCfOTNdxoSI4vb/
         CkH/yOgUPPMxYR9pLZBVIZ4zXwt3K4Ry5FAizxHR01PmkDfKsTjA2qxcjWTvH0PeYd72
         +AYofSwTFg6NOniX6fA6OpV45Kr22+TcuXFWkzUktWBuvrBXb4YKR55o/W8f/NtU/dDf
         B+F1WvIughm45hdhnKCcNafQgDZrdRftUcXSbAMuwoHR9Fo7fV/hnUG5NacRKxqCn8Wk
         sPlg==
X-Gm-Message-State: AOAM530j8nKqPSKXxQ4Bq4Zwv39j9pcrvKAYnWXngkLza670A7rmjTbg
        0My81L5Sr78n6djwU6pZ0fk=
X-Google-Smtp-Source: ABdhPJybzoUroa6XjAeH5Zt2ntikVuvkJQjKPL32cOaIlQj2fFFLJx27JeYgAdIw0qkV+awN+knGXA==
X-Received: by 2002:a17:90b:4c8e:: with SMTP id my14mr20843705pjb.234.1629733912140;
        Mon, 23 Aug 2021 08:51:52 -0700 (PDT)
Received: from localhost ([2405:201:6014:d820:9cc6:d37f:c2fd:dc6])
        by smtp.gmail.com with ESMTPSA id x69sm16716317pfc.59.2021.08.23.08.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 08:51:51 -0700 (PDT)
Date:   Mon, 23 Aug 2021 21:21:49 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Yaniv Agman <yanivagman@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Subject: Re: libbpf: Kernel error message: Exclusivity flag on, cannot modify
Message-ID: <20210823155149.3jg7nizcxgxf4tfv@apollo.localdomain>
References: <CAMy7=ZXTiaX9xzNi5aOavwsf+mziJ=w-EcHH2f=cJmCGr3EPQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMy7=ZXTiaX9xzNi5aOavwsf+mziJ=w-EcHH2f=cJmCGr3EPQA@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 23, 2021 at 04:35:51PM IST, Yaniv Agman wrote:
> Using the recently added libbpf tc API worked fine for us in v0.4.0.
> After updating libbpf and syncing with master branch, we get the
> following error:
>
> libbpf: Kernel error message: Exclusivity flag on, cannot modify
>

This message is harmless. The commit that adds NLM_F_EXCL is a bug fix. Without
it, the kernel returns 0 when it should return -EEXIST. It's just that the
kernel complains loudly for the latter case through extack.

User needs EEXIST to detect whether it installed the qdisc or not. To see how
this affects the system, run ./test_progs -t tc_bpf after installing clsact
using:
	tc qdisc add dev lo clsact

Before this fix is added, it will remove the system qdisc as bpf_tc_hook_create
returns 0, after the fix it detects the presence of the existing qdisc using
-EEXIST and disables the bpf_tc_hook_destroy call before exit.

I would suggest handling the error explicitly, and using libbpf_set_print to
filter it out. See the example in tools/testing/selftests/bpf/test_progs.c.

> I found that commit a1bd8104a9f1c1a5b9cd0f698c886296749a0ce9 is

You probably meant bbf29d3a2e49e482d5267311798aec42f00e88f3? I cannot find this
commit.

> causing this problem, and removing the NLM_F_EXCL resolves the issue.
> Is this the expected behavior and I'm doing something wrong?

--
Kartikeya
