Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 236EA526E79
	for <lists+bpf@lfdr.de>; Sat, 14 May 2022 09:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiENCrb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 May 2022 22:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiENCra (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 May 2022 22:47:30 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924AE339FC3
        for <bpf@vger.kernel.org>; Fri, 13 May 2022 17:48:41 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id l11so8906332pgt.13
        for <bpf@vger.kernel.org>; Fri, 13 May 2022 17:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=S5kAabe3jQc/rg2G2zhNO+SrDfjd7vAHWRvryQcJDoQ=;
        b=VgahW1yi9Bwzen40YXD9GrfJ3kGXWOM06AouLED8LZsSBF5ClLtfenao/trfrkA+C+
         v4laY6crVlWF3zL+4gQhA0v4GOmSmZjFXZQNFKF5BBvtHPiZU8hRtYuI8h5h9pWlbjGd
         N69Z6eVUlPVjaQktNWzZtGDkY+afkH1jIdhavBJaBQFWs6aaXjxHsVdOmtMLZOG9epu/
         /5TG5mgwpB6UjcpPLJsT/pxoCBLgTYuhqIElJdDKOtC8LI4Z2LvCixXr/Bad9wFbqNs5
         cBor8uDMcfK1GRSxMigeKr3Oda4nybmRiFPOuvadry20mryDL2+BpzQPR/yGrPpjt4lZ
         hzBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S5kAabe3jQc/rg2G2zhNO+SrDfjd7vAHWRvryQcJDoQ=;
        b=6NorfFoJ6iP8bFjbuXCjYmW1jDcjbOaDrUxNuOXhCICLKCzHYbS7mEHBCemQOGyisf
         Lf8DaUF3rfE467+GGv7goZKyppa3wes6t9XcCqW3r3dcysGh7iA5rt9kblmquVoMh2e+
         Kgz2nS1DY5XHpsduzW1fiPePFwGEvTcRuOfjKeO3Wnie4zPc3Kk4hW3wGl0tsQJZJYXC
         e0YXJ99vC6DtMfu9qmqGK9xWjQljkUKPTe1K2YRkfHBpwl4t3qW6yg0BHr8oiLwCZP4Q
         k5oskr0A1RVv7h2azgSz6Vg2+q22LOCeajSOkPol2h/VxbxGkHVqK9dHYkFo5tO/mB5/
         WVEA==
X-Gm-Message-State: AOAM531PKDdVevQHiJGFvGZHu41n8GYmbz2bkOjFZY1YSh96wCsFQHcI
        Mq7C1aroaGX42WyivnZ462U=
X-Google-Smtp-Source: ABdhPJyy3tPvJUPlXGtJgE2lXiBEk+g+P5rUG/reV8z8dpRxJrKQ+w3GzZhB/h8TtKDcePpcE96kOA==
X-Received: by 2002:a63:2c01:0:b0:3db:5e24:67f8 with SMTP id s1-20020a632c01000000b003db5e2467f8mr6083027pgs.372.1652489052242;
        Fri, 13 May 2022 17:44:12 -0700 (PDT)
Received: from MBP-98dd607d3435.dhcp.thefacebook.com ([2620:10d:c090:400::4:7ccc])
        by smtp.gmail.com with ESMTPSA id k13-20020a63f00d000000b003c14af50606sm2231449pgh.30.2022.05.13.17.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 17:44:11 -0700 (PDT)
Date:   Fri, 13 May 2022 17:44:10 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Rik van Riel <riel@surriel.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Yonghong Song <yhs@fb.com>, kernel-team@fb.com
Subject: Re: [RFC PATCH bpf-next 1/5] x86/fpu: Move context.h to include/asm
Message-ID: <20220514004410.hm5by7pmaa2sk6is@MBP-98dd607d3435.dhcp.thefacebook.com>
References: <20220512074321.2090073-1-davemarchevsky@fb.com>
 <20220512074321.2090073-2-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512074321.2090073-2-davemarchevsky@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 12, 2022 at 12:43:17AM -0700, Dave Marchevsky wrote:
> The file's fpregs_state_valid function is useful outside of
> arch/x86/kernel/fpu dir. Further commits in this series use
> fpregs_state_valid to determine whether a BPF helper should fetch
> fpu reg value from xsave'd memory or register.
> 
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> ---
>  arch/x86/{kernel => include/asm}/fpu/context.h | 2 ++
>  arch/x86/kernel/fpu/core.c                     | 2 +-
>  arch/x86/kernel/fpu/regset.c                   | 2 +-
>  arch/x86/kernel/fpu/signal.c                   | 2 +-
>  arch/x86/kernel/fpu/xstate.c                   | 2 +-
>  5 files changed, 6 insertions(+), 4 deletions(-)
>  rename arch/x86/{kernel => include/asm}/fpu/context.h (96%)

Why rename and cause all this churn?
