Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC4768C324
	for <lists+bpf@lfdr.de>; Mon,  6 Feb 2023 17:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjBFQZl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Feb 2023 11:25:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjBFQZl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Feb 2023 11:25:41 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE71612060
        for <bpf@vger.kernel.org>; Mon,  6 Feb 2023 08:25:39 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id ay1so8780989pfb.7
        for <bpf@vger.kernel.org>; Mon, 06 Feb 2023 08:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kFQxaP144S9AVJ5XJTXyEhWUpy1ufPfXJtGU2agH1J0=;
        b=ipHxCMjhGQl12luICsGCj+oY1Y6BRiVxfo1c4DBrKjyhbmY1Z5sGl55irNZjIBh3la
         Eu4qQV1MSbXUarEwlGjFdzb7oLKQu4hzSXyPjWwkhX0Y1MjTPj3inOBxUvXsfVgwFDJw
         tEvFLoIleDZ2ScYG8AxEMgzse7itQDeEAIl4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kFQxaP144S9AVJ5XJTXyEhWUpy1ufPfXJtGU2agH1J0=;
        b=AJA5K8WyzlRQcxPbL29nEOnFjYlhokgrePtLcv2PiQRIFiDTPeoWNDhfwrbE38nKQQ
         YqW3xCbY1DtSwY09NC2/FWtw2YNelSbX92/th+E44Jkv1aJ4BnChyRBfB28o6AvJ0/VI
         17CuG2DEz+6HOcNWw50kp/m9XULit0s9GiUvNcMvEXc3lwMtocnWO4wtNjr2mb85wx8x
         gx/C2TDmoQMa/gDR3KasUujcRoaNIl7blUP6YCOdqk5U/B4qG934bNK0Ajcvw7KGZ8q4
         c6Go/F6WsmR8DGS30h4pbdeQgw9w8gAD1+COub19NtgYerBqjZHu0/g29VGS2TSnIRhz
         gWqA==
X-Gm-Message-State: AO0yUKWx6kZbplqqDc1Xt3KH2yxsMyifh72jL8MzbLoKDXl8TPSDqUdz
        ZWbYxfUTp2oMM1yeepu/Q3pDq7/St1hdX/x6qeceQg==
X-Google-Smtp-Source: AK7set+coOXre5Bf+rKkNBx/EUFNbeN32jSTpfQbb6BUdHV0Na+yutvq8fVnnBYQ3nokoBmkHBrR+Obe+cEnNzLdptM=
X-Received: by 2002:a62:3808:0:b0:5a6:5841:6570 with SMTP id
 f8-20020a623808000000b005a658416570mr270391pfa.51.1675700739133; Mon, 06 Feb
 2023 08:25:39 -0800 (PST)
MIME-Version: 1.0
References: <20230201163420.1579014-1-revest@chromium.org> <20230201163420.1579014-7-revest@chromium.org>
 <Y9wI93m2frDFGFez@FVFF77S0Q05N.cambridge.arm.com> <CABRcYmKRoDeFecvj7e+0SUaoinUa7FdtG1fmYqkRS3YPXVw4-w@mail.gmail.com>
 <Y90qS5jTog2m6YhQ@FVFF77S0Q05N>
In-Reply-To: <Y90qS5jTog2m6YhQ@FVFF77S0Q05N>
From:   Florent Revest <revest@chromium.org>
Date:   Mon, 6 Feb 2023 17:25:28 +0100
Message-ID: <CABRcYm+3U+Pb=fNt38_MsCS+vVGcN4cHhEv415yGJ4QHac6KFA@mail.gmail.com>
Subject: Re: [PATCH 6/8] ftrace: Fix dead loop caused by direct call in ftrace selftest
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kpsingh@kernel.org, jolsa@kernel.org,
        xukuohai@huaweicloud.com, Xu Kuohai <xukuohai@huawei.com>,
        Li Huafei <lihuafei1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 3, 2023 at 4:37 PM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Fri, Feb 03, 2023 at 01:35:00PM +0100, Florent Revest wrote:
> > On Thu, Feb 2, 2023 at 8:03 PM Mark Rutland <mark.rutland@arm.com> wrote:
> > > I think it'd be much better to do something like the below as a preparatory
> > > cleanup (tested on s390 under QEMU).
> >
> > Thanks, that looks great to me. I'll make it a part of the series in v2 then.
> > Unless it's preferred that this gets merged separately?
>
> I reckon put it in the series for v2, and if Steve or Masami want to pick it up
> beforehand, they can choose to do so from there?
>
> Since it's not currently exploding, I suspect it's not urgent.
>
> Mark.

Ack
