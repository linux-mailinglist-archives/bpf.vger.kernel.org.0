Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D155978A7
	for <lists+bpf@lfdr.de>; Wed, 17 Aug 2022 23:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242183AbiHQVEK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Aug 2022 17:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242153AbiHQVEI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Aug 2022 17:04:08 -0400
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF03CA1D49;
        Wed, 17 Aug 2022 14:04:06 -0700 (PDT)
Received: by mail-qv1-f43.google.com with SMTP id mn10so6230501qvb.10;
        Wed, 17 Aug 2022 14:04:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=kIlfxyqwO0rTrcxkh/EF7Gqy6pDlNX5yvWxQZRLIpHY=;
        b=D3QtODsgxGj1hya3LiYDo4K7AOe2pGQkCToZyqxVkMdCOaLhqWu1Q6jU7mBaChWro0
         MZOoieCovzQylv32d5H5DIo4jmPW6pWaK5F+yqY4OU24bvfUyOjw4hROGnmtLXaIeEau
         JjoJp8Ig7YggpNdQ3hAI4PMt3v/Ce8fARg+trtVEDT1NNwhPD49bEA8kq+wVtA7dxqw7
         rJTBAaMG/QQh6fPKUSoQYyIY1KrnBpfKxNyTpm9riXEGz4ksR+q9vkU9qPoYXlibQvUS
         CqlxWAdOOnnxYFoc1jfLCbMeLf2b+7kQjEh6FrIzi7o10PQiW/cCh0rc1sgEpR0Ak7do
         QCkw==
X-Gm-Message-State: ACgBeo1mdq9OVqURgOr34Fh61fPtbHgl9DLFnDg3IYdZnqBPMkUhP9LT
        X2rZVQO9PMsbQ/e3z4U0UpM=
X-Google-Smtp-Source: AA6agR6u5IP4+/+d/wECWVR6UmupsqqVAWFJ3gJEE5YMYiPTUeEczIZNL5Vv8cNtIYePsPAQeNUZQQ==
X-Received: by 2002:a0c:8084:0:b0:472:f26b:59f7 with SMTP id 4-20020a0c8084000000b00472f26b59f7mr24203490qvb.62.1660770245874;
        Wed, 17 Aug 2022 14:04:05 -0700 (PDT)
Received: from maniforge.dhcp.thefacebook.com ([2620:10d:c091:480::a5ed])
        by smtp.gmail.com with ESMTPSA id fp25-20020a05622a509900b0034454aff529sm9611345qtb.80.2022.08.17.14.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 14:04:05 -0700 (PDT)
Date:   Wed, 17 Aug 2022 16:03:28 -0500
From:   David Vernet <void@manifault.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, john.fastabend@gmail.com, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        joannelkoong@gmail.com, linux-kernel@vger.kernel.org,
        Kernel-team@fb.com
Subject: Re: [PATCH 3/5] bpf: Add bpf_user_ringbuf_drain() helper
Message-ID: <Yv1XoPoICceMkjH4@maniforge.dhcp.thefacebook.com>
References: <20220808155341.2479054-1-void@manifault.com>
 <20220808155341.2479054-3-void@manifault.com>
 <CAEf4BzZ-m-AUX+1+CGr7nMxMDnT=fjkn8DP9nP21Uts1y7fMyg@mail.gmail.com>
 <YvWi4f1hz/v72Fpc@maniforge.dhcp.thefacebook.com>
 <CAEf4BzZ6aaFqF0DvhEeKaMfSZiFdMjr3=YzX6oEmz8rCRuSFaA@mail.gmail.com>
 <YvwWvVDN11Wb6j2l@maniforge.DHCP.thefacebook.com>
 <CAEf4BzahEq=Ke7yzc8eMvp17avZ8Br-XQKRMe-WdkgoEcy9oVA@mail.gmail.com>
 <Yv1OiCYmQhkvRyWS@maniforge.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yv1OiCYmQhkvRyWS@maniforge.dhcp.thefacebook.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Aug 17, 2022 at 03:24:40PM -0500, David Vernet wrote:

> [...]
> > right, I think __atomic_store_n() can be used in libbpf for this with
> > seq_cst ordering
> 
> __atomic_store_n(__ATOMIC_SEQ_CST) will do the correct thing on x86, but it
> is not guaranteed to provide a full acq/rel barrier according to the C
> standard. __atomic_store_n(__ATOMIC_SEQ_CST) means "store-release, and also
> participates in the sequentially-consistent global ordering".
> 
> I believe we actually need an __atomic_store_n(__ATOMIC_ACQ_REL) here. I

Sorry, I meant __atomic_exchange_n() rather than __atomic_store_n().
