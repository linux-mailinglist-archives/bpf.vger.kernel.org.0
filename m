Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D321867A6C5
	for <lists+bpf@lfdr.de>; Wed, 25 Jan 2023 00:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjAXXST (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Jan 2023 18:18:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjAXXST (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Jan 2023 18:18:19 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D647303DA
        for <bpf@vger.kernel.org>; Tue, 24 Jan 2023 15:18:18 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id t16so16294830ybk.2
        for <bpf@vger.kernel.org>; Tue, 24 Jan 2023 15:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TjUuPxJorTm0S1nPSw7d6DNUWqTJizpz/YvXGGYX3vc=;
        b=KF4tcIK0gbw+vY2lR8xRj+5d+XAJoS0vaSZzxt+m+1JprNDoqVwchWg9BQzpwQvD6Y
         hL2F1Fe3+sZJiUD1PpfdC8xtZCwmhwEln0QXjALlLyRkDmqEb+7+nzBs8YHQjRyQpR8b
         NREFUAmVQrZw969/ZAuLt12MctkHKUFnMJUa0O0A1ia/3O3iDvlyy03w4kd5quuoSaV0
         sb9EsYmvgNzAFU8jLl7Hw9JjbuAUUt3bGLsq86K1sdVMK3bhfCEDk7XFeIXoQpZK4947
         vwkcFQx+wzMLMtwJQmjMqDILy3BCSs6AGM8KLKDXxeuUEjOfefwWmsSjJ26lILpZ2tnj
         nDeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TjUuPxJorTm0S1nPSw7d6DNUWqTJizpz/YvXGGYX3vc=;
        b=Q1wRKfJ9ppYqCPb2cluR8B2FfQ843azQxog/Y7oUSylO8UCu6YvegNN/bXcTmmIPl2
         BwNXziHR0OqLu7drqT6JF+iohc9ngQ8lm+QD+boJ8kovM/8bZis1/3OJnv1uCVaDdotC
         K1zTPeuqe3q3QV2fVqTKX5K2fw4pNWN0XwPB0v2voa5MXUHe1ksZIFfYs0L3h5v2tKXi
         4zqjahM9gDQVytcFlLBBs4pqTH328Px6+3d36jfmO/hqjZ/NxsYzH4j8ODR1+WHkmtky
         V/5nZGHR6Fvx93DWEm9FwLRYqr3VNVFGTBHUJXgr1xHaZmGt+SMpZgHTMlymqPsqky+8
         uDEg==
X-Gm-Message-State: AO0yUKVJKvIFBUMM1dWzpjcR0myjA3W//mF1Nsbz1xUuJK4//DHVeCMM
        Cc29xS3hYOujAI9bFl1ujKo+B77bcvAm9mYww/xzbA==
X-Google-Smtp-Source: AK7set/XvOUtuc3O6j/Z9MgQksHGSCV2XTyLVVrv1BztmRO6RuoPUE/8oEMDJ9CGLPktm/vmyCE/abzPN4XgK0R7XNc=
X-Received: by 2002:a25:320c:0:b0:80b:5988:203e with SMTP id
 y12-20020a25320c000000b0080b5988203emr483335yby.52.1674602297335; Tue, 24 Jan
 2023 15:18:17 -0800 (PST)
MIME-Version: 1.0
References: <CAHBbfcUkr6fTm2X9GNsFNqV75fTG=aBQXFx_8Ayk+4hk7heB-g@mail.gmail.com>
 <296fcfac-9acd-9462-871c-b450fd140fa3@gmail.com> <7f2372c1-73c9-cd8a-c0e8-30d3fef8c23e@oracle.com>
In-Reply-To: <7f2372c1-73c9-cd8a-c0e8-30d3fef8c23e@oracle.com>
From:   Jason Ling <jasonling@google.com>
Date:   Tue, 24 Jan 2023 15:17:41 -0800
Message-ID: <CAHBbfcVwOQQsARw7qTTJ_xjnH_H7fs0a2nP0_rhn3ixtBYZtdA@mail.gmail.com>
Subject: Re: Is fentry/fexit support possible with an external BTF?
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Kui-Feng Lee <sinquersw@gmail.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

>Would it help in this environment if vmlinux BTF was in a module?

Yes, that would fix our issues as we place our modules on a separate partition.
