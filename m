Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 732C1603119
	for <lists+bpf@lfdr.de>; Tue, 18 Oct 2022 18:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbiJRQ4h (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Oct 2022 12:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiJRQ4g (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Oct 2022 12:56:36 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BBCC0693
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 09:56:35 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id o9-20020a17090a0a0900b0020ad4e758b3so14533340pjo.4
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 09:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aX+f1aKTWuCaRtpe8oYSPCaFSr1D16+zAAHvgYMM3Zo=;
        b=R6Gv+3IG1iLaOlVgLEbN8WjYPxZerEqODSTfzQyFFbWHEdFWJFjm8eUEgFnxiI4U0E
         p9HnxoiRwzbxGiNmlrZbpkmfHnTR3W2ShE4fQ7ddsGomhyxGT3zcNzhjsHGa+FkVEsbI
         B5VojHp0lIqcyWsOjBOCy1RWTAA+nyNXqcrmo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aX+f1aKTWuCaRtpe8oYSPCaFSr1D16+zAAHvgYMM3Zo=;
        b=7SL0fjCdBHwX/qSOy2KUURryjpMiTjuiaSsERrEXWKJ0IYFY/8PoEh6DZq1PTTEbtg
         gkKa7TcyPYaJy+eWHAMifItOB+haVEnM8CXDJKFPYn0/Ssa1XogyKwFADEE2QC/MR92w
         NLqXVjWhT+9BQkvgc57lJSQ/Kcr7o3wcuOE3r23revPQyntSQx464HGmemDKsWEGMA0u
         MT1/PcGIvZrtauX9/j478ciweIjZFjz6TzT/h0NO2ifzhpz+mR14cjNS/LKj2POPGurJ
         S2EBrF9svpCwpMSNRTN3MR+QgHCQ+LzfX/zbP954dEwx5UAnqGNU/WBRfnT8eVhKP+y3
         ZnqA==
X-Gm-Message-State: ACrzQf1BnuJbKOg65eFr8V+sypaGIVC+DMVsFX969acSff7ohG2s+sme
        um0RSuLNbu+XeO9s+SILQ8R0yQ==
X-Google-Smtp-Source: AMsMyM7EiDhq7ZjZ2Gd1Bxbo03ECXLOB8ZkjJ+Y7TCVR1Yhm0ucGTwlAWAUsfIX6Zkb1a/L9MHkXPA==
X-Received: by 2002:a17:903:246:b0:179:96b5:1ad2 with SMTP id j6-20020a170903024600b0017996b51ad2mr3949944plh.37.1666112194673;
        Tue, 18 Oct 2022 09:56:34 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f23-20020a63f757000000b00460c67afbd5sm8327716pgk.7.2022.10.18.09.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 09:56:33 -0700 (PDT)
Date:   Tue, 18 Oct 2022 09:56:32 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] bpf, test_run: Track allocation size of data
Message-ID: <202210180948.0A0D16844D@keescook>
References: <20221018090205.never.090-kees@kernel.org>
 <CAADnVQKBfPeDqHE8U6f79XKqrQsLWysRQMweBhwBd-qRP0FDpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQKBfPeDqHE8U6f79XKqrQsLWysRQMweBhwBd-qRP0FDpw@mail.gmail.com>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 18, 2022 at 09:29:07AM -0700, Alexei Starovoitov wrote:
> On Tue, Oct 18, 2022 at 2:02 AM Kees Cook <keescook@chromium.org> wrote:
> > +       alloc->len = kmalloc_size_roundup(size + headroom + tailroom);
> > +       alloc->data = kzalloc(alloc->len, GFP_USER);
> 
> Don't you need to do this generalically in many places in the kernel?

The size tracking or the rounding up?

The need for rounding up is surprisingly rare[1] -- very few things actually
used ksize(), and almost all of them are due to following some variation
of a realloc idiom. I've sent patches for all of them now, so that should
be a short road to solving the problems ksize() created.

The need for missed size tracking is also pretty uncommon (most
dynamically sized things already track their size in some form
or another). Finding a truly generalizable solution is an ongoing
experiment[2].

-Kees

[1] https://lore.kernel.org/lkml/20220923202822.2667581-1-keescook@chromium.org/
[2] https://lore.kernel.org/llvm/20220504014440.3697851-1-keescook@chromium.org/

-- 
Kees Cook
