Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF125814E5
	for <lists+bpf@lfdr.de>; Tue, 26 Jul 2022 16:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232137AbiGZOOj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Jul 2022 10:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiGZOOi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Jul 2022 10:14:38 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E49EDF0E
        for <bpf@vger.kernel.org>; Tue, 26 Jul 2022 07:14:37 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id g2so12292522wru.3
        for <bpf@vger.kernel.org>; Tue, 26 Jul 2022 07:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc;
        bh=iNMCDjIMTRqm0j5z+RJbEjFHQRo0OAsHc5Q7/tWHZww=;
        b=TV7TLKucYFkZXzpPTU5kRmmyKPdHnxxH/g0fpzGjj5031UQBa9wWjsN18Ud36LFP/M
         NeV5bVje0he0TIGRbBDZaAvxV6yr1pD2kCNrq82wbkUO59CLWrDmamTwBKX9I7jM4dTd
         VNHdU71Noa381ZaFbUeG0c4SfOlB9Ivwmfex+PZm4oVkQ2xjEHSHTpktzuH8M4DIQa9d
         rawQAbV180GnMHTw4fMcQCAEWZZ6IUe7T05SHQ07EAoh9vdbeoGW5PajBp8fJzO4N4m6
         VfRjznAAaf9MhjZsGqHRVK1cK1dUs3ocrQ9StT58OEuIsZHoiHITPwWkLsIlVH7oxr1w
         ku7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc;
        bh=iNMCDjIMTRqm0j5z+RJbEjFHQRo0OAsHc5Q7/tWHZww=;
        b=x2IM4FRAxCua0j9i08BPxPj7Ig6198dV6QD24VtzCqeElta/yM89xdzK1OkBRrGCl1
         B8z1rWPkm6STIYZkn52RfN3CsNoy9NWVRJy7gwHj4KXFtvuYze9c76ZNuaHYys7Cc9HX
         C+L5vr+SBrj3xsNVhFzeL2/LuGpeN0Ocy84GxjfLk+Wa3fu01VvzXnab28MmBMd32Byi
         KRQ5uxe4ksmoXHyLR4y6kaiZXDefDd9Rg1nKgy+eKSzNDK/CPB5cCROoh51FCDuWroyh
         9OOD/92sZWGpS1nvo1EYbWr4CdUBSYBHrq0e+l46suLZ85lxtbfjSuuH8eqLu0v76MxV
         cf4g==
X-Gm-Message-State: AJIora+/Q7PgHz5iD6xqO1V9Jayfubr83cVcgBcUYcXYNFTAzRC1yNvt
        9/SG6mEBrxngSsyVLi3tAwTQ0SLeg4KZHg==
X-Google-Smtp-Source: AGRyM1s177OTTG+/MpFT+BLP5MQQCIgzOENq1ewcdoUtO/3AdpYU5q5M76DQvtuoQGcjQUEHi06hfA==
X-Received: by 2002:adf:f3c5:0:b0:21e:9908:80ac with SMTP id g5-20020adff3c5000000b0021e990880acmr3521724wrp.592.1658844875718;
        Tue, 26 Jul 2022 07:14:35 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id n5-20020adff085000000b0021eb5a1bb1csm905373wro.30.2022.07.26.07.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 07:14:35 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Tue, 26 Jul 2022 16:14:33 +0200
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH bpf-next v2 0/2] Fix test_probe_user on s390x
Message-ID: <Yt/2yTe3CSKApQui@krava>
References: <20220726134008.256968-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726134008.256968-1-iii@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 26, 2022 at 03:40:06PM +0200, Ilya Leoshkevich wrote:
> Hi,
> 
> This is a fix for [1]: test_probe_user fails on s390x, because it hooks
> only connect(), but not socketcall(SYS_CONNECT).
> 
> Patch 1 adds this quirk to BPF_KSYSCALL documentation.
> Patch 2 fixes the test by attaching a prog to socketcall().
> 
> Best regards,
> Ilya
> 
> [1] https://lore.kernel.org/bpf/06631b122b9bd6258139a36b971bba3e79543503.camel@linux.ibm.com/
> 
> v1: https://lore.kernel.org/bpf/20220723020344.21699-1-iii@linux.ibm.com/
> v1 -> v2: Add CONFIG_ prefix to CLONE_BACKWARDS* symbols (Jiri).
>           Change the type of prog_names to make checkpatch happy.
>           Use prog_count everywhere (Jiri).
>           #ifdef out handle_sys_socketcall() on non-s390x (Jiri).

LGTM 

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> 
> Ilya Leoshkevich (2):
>   libbpf: Extend BPF_KSYSCALL documentation
>   selftests/bpf: Attach to socketcall() in test_probe_user
> 
>  tools/lib/bpf/bpf_tracing.h                   | 15 +++++---
>  .../selftests/bpf/prog_tests/probe_user.c     | 35 +++++++++++++------
>  .../selftests/bpf/progs/test_probe_user.c     | 32 +++++++++++++++--
>  3 files changed, 65 insertions(+), 17 deletions(-)
> 
> -- 
> 2.35.3
> 
