Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4019C633382
	for <lists+bpf@lfdr.de>; Tue, 22 Nov 2022 03:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbiKVCpb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Nov 2022 21:45:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbiKVCpa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Nov 2022 21:45:30 -0500
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE71769DF;
        Mon, 21 Nov 2022 18:45:30 -0800 (PST)
Received: by mail-qt1-f172.google.com with SMTP id c15so8534634qtw.8;
        Mon, 21 Nov 2022 18:45:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ULVPlv0CTw8E3LpEMKKjgM3CLUwyZvnmug0wU3B6zTc=;
        b=Bse0tzk2GoiE9bg2c7qPCpaJA2arYUU+u4hsRCttexZWQVG+TXV4Fuun7fqXSFQUZ1
         tNajP/kD0ij39kn0tOqdRBHBRW4bZPku8M4eg5E2PLk69yony1t5w/VL+qktajYCLC+3
         8GwB2viztVXCBbLf5uGkWGm6j55UBFxwlIQuWO4EDdkewzEt4abRcGXycJxAZyNY7dJ0
         0tHk4S2O6kO9cwWGmGFPQd1A6l3ay1sg1qdndWMjZleXyPOxbUlt4qOppdTwPDKhenEo
         l2dJi8luegzTtyhvBYxbhx/DnmyAPXWLTBdO6JnLElUZ5GwwEE9oicQ1+bn08mwtigHs
         jP+A==
X-Gm-Message-State: ANoB5plrn3RtKbZu+JV8kzif3tkJSLxpmQIMcdo4hnHmA6En/RnybUfW
        bCI4rUv5/2/Hqk/a5ciR7ok=
X-Google-Smtp-Source: AA0mqf7eZBixtQcY/BT1SEAfhS0Y4+ZC4G4x5cvX3r9EKtcNN0Ue0013HKSElxmz6MWQ4iVJB3PrkA==
X-Received: by 2002:ac8:47cd:0:b0:3a5:467c:dae2 with SMTP id d13-20020ac847cd000000b003a5467cdae2mr20017005qtr.121.1669085128368;
        Mon, 21 Nov 2022 18:45:28 -0800 (PST)
Received: from maniforge.lan ([2620:10d:c091:480::1:3170])
        by smtp.gmail.com with ESMTPSA id f14-20020a05622a114e00b003434d3b5938sm7659058qty.2.2022.11.21.18.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 18:45:27 -0800 (PST)
Date:   Mon, 21 Nov 2022 20:45:33 -0600
From:   David Vernet <void@manifault.com>
To:     Rong Tao <rtoax@foxmail.com>
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        corbet@lwn.net, daniel@iogearbox.net, haoluo@google.com,
        john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        martin.lau@linux.dev, rongtao@cestc.cn, sdf@google.com,
        song@kernel.org, yhs@fb.com
Subject: Re: [PATCH bpf-next v4] docs/bpf: Update btf selftests program and
 add link
Message-ID: <Y3w3ze8lvnJveQNc@maniforge.lan>
References: <tencent_1FA6904156E8E599CAE4ABDBE80F22830106@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_1FA6904156E8E599CAE4ABDBE80F22830106@qq.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 22, 2022 at 08:50:42AM +0800, Rong Tao wrote:
> From: Rong Tao <rongtao@cestc.cn>
> 
> commit c64779e24e88("selftests/bpf: Merge most of test_btf into
> test_progs") rename selftests/bpf btf test from 'test_btf.c' to
> 'prog_tests/btf.c'.
> 
> Signed-off-by: Rong Tao <rongtao@cestc.cn>
> ---

Looks great, thanks Rong.

Acked-by: David Vernet <void@manifault.com>
