Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25A2E609136
	for <lists+bpf@lfdr.de>; Sun, 23 Oct 2022 07:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiJWFA0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 23 Oct 2022 01:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJWFAZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 23 Oct 2022 01:00:25 -0400
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE2B5FF66
        for <bpf@vger.kernel.org>; Sat, 22 Oct 2022 22:00:24 -0700 (PDT)
Received: by mail-qt1-f182.google.com with SMTP id z8so4047556qtv.5
        for <bpf@vger.kernel.org>; Sat, 22 Oct 2022 22:00:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QEOWaY5ougKmvdpcdNTDLRySthvG+G3QKIQP+m5VkVg=;
        b=7EbmcnbbxEuxq3hVQNu5eF0l5mMwMpsYRTkokBUWkQJOFQjHCuJ3cG4p6kOp2L28Cd
         gTxuHo5KzguHc73W0+YbxlRYmnE2z/bVrMaeNPlZ8Nlr4akT9hNeqTdv+0qIt06ODx1A
         dEPo7xoo4651qwm7vpa9sZuAsSt7R0n72nDiZ5jk1YJx576LFeMBlyWFtymAoLVXvbzT
         hH/qh7Q7t7FUxB6kbCFejmYlSE6bhBYq4dr3aiiFlIXrC1ocHt+sMGdLt27OKZKoePBP
         JmIwTJtbvkPIPpYKyDvT8yYTTCsP9l/l7iaGV7cC+5kB7sw5tONEG1s8nSz0Gxz2bt1o
         DZYA==
X-Gm-Message-State: ACrzQf2boseGwONIq2iykW4K4StsEkZlRYsTdoR7AgB4GBJsxplYcL0Y
        HG6ncmQMR87zehOXQVYbXko=
X-Google-Smtp-Source: AMsMyM62ybp9eHkB7K0J2Iq9q/VrnTY8z9ENpdDoX5onravemtrnNVAneQPPXTZZk/KzuEzZ5/NJ6g==
X-Received: by 2002:a05:622a:1110:b0:39c:d568:8b26 with SMTP id e16-20020a05622a111000b0039cd5688b26mr21975022qty.280.1666501222962;
        Sat, 22 Oct 2022 22:00:22 -0700 (PDT)
Received: from maniforge.dhcp.thefacebook.com ([2620:10d:c091:480::484b])
        by smtp.gmail.com with ESMTPSA id cj24-20020a05622a259800b00399fe4aac3esm10810227qtb.50.2022.10.22.22.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Oct 2022 22:00:21 -0700 (PDT)
Date:   Sun, 23 Oct 2022 00:00:26 -0500
From:   David Vernet <void@manifault.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH bpf-next v3 2/7] bpf: Refactor inode/task/sk storage
 map_{alloc,free}() for reuse
Message-ID: <Y1TKanTWvemre4va@maniforge.dhcp.thefacebook.com>
References: <20221021234416.2328241-1-yhs@fb.com>
 <20221021234427.2330039-1-yhs@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221021234427.2330039-1-yhs@fb.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 21, 2022 at 04:44:27PM -0700, Yonghong Song wrote:
> Refactor codes so that inode/task/sk storage map_{alloc,free}
> can maximumly share the same code. There is no functionality change.

nit: s/maximumly/maximally

> 
> Signed-off-by: Yonghong Song <yhs@fb.com>

Thanks, looks like a great cleanup.

Acked-by: David Vernet <void@manifault.com>
