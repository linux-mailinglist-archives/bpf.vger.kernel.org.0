Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC24A5FCE46
	for <lists+bpf@lfdr.de>; Thu, 13 Oct 2022 00:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiJLWSH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Oct 2022 18:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbiJLWSF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Oct 2022 18:18:05 -0400
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D74A8CCE
        for <bpf@vger.kernel.org>; Wed, 12 Oct 2022 15:18:04 -0700 (PDT)
Received: by mail-qt1-f171.google.com with SMTP id a24so3561959qto.10
        for <bpf@vger.kernel.org>; Wed, 12 Oct 2022 15:18:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FqEcSyc0aqLZr1e7KMT/nlCPBcC9AB+uTTRINhXt5nk=;
        b=6uBuc/wqn06AAsdTv/+A5WzQ2+OkXQ97Ojye9bjVBEty8FaRe4Nh9Vagm8ETPlM4fP
         LWgZaTsmKaClBJpj4nXA1uy50PQI63TvCYAqJL15so+BAZ0idlNJEnd23kaPqa+5rkoP
         pX415y6igZVRj/KkbBlsGxaFZNeOg1ABxT3VouqtQpF1WHcXJu5scIYPO/r0cfSmmUpt
         I6C52AwXNAOLzvanwqPKOIJMKNdSVW7iE0Od5JK6vWsTTZk83Gg8wrKC1IxJgpgFV8vp
         UhmTni0mg6GexaQeTkX00e2GBTgIxRPpvK0zosWNMEPhBhVDz0h4NblWiV1EvHO/SaZX
         RlZw==
X-Gm-Message-State: ACrzQf0jArLWEHpwD9bnl4HTJzxpJtN+ZleJ+CUlN0wkBQ1RrSeOIuF6
        NQl2WJJO82dk3XsYo6BV+30=
X-Google-Smtp-Source: AMsMyM4yoIHFGX3oZMcICCGZbJmJ+M7avpkMbI0lridgFVAOfzgeSNO6h/9aYq3Em4F4D147xKYXSw==
X-Received: by 2002:a05:622a:1904:b0:35c:c657:14e4 with SMTP id w4-20020a05622a190400b0035cc65714e4mr25579929qtc.65.1665613083677;
        Wed, 12 Oct 2022 15:18:03 -0700 (PDT)
Received: from maniforge.dhcp.thefacebook.com ([2620:10d:c091:480::1a0b])
        by smtp.gmail.com with ESMTPSA id w22-20020a05620a425600b006cbc00db595sm16732323qko.23.2022.10.12.15.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 15:18:03 -0700 (PDT)
Date:   Wed, 12 Oct 2022 17:18:01 -0500
From:   David Vernet <void@manifault.com>
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     bpf@vger.kernel.org, 'Alexei Starovoitov ' <ast@kernel.org>,
        'Andrii Nakryiko ' <andrii@kernel.org>,
        'Daniel Borkmann ' <daniel@iogearbox.net>,
        kernel-team@fb.com, Manu Bretelle <chantra@meta.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: s/iptables/iptables-legacy/ in
 the bpf_nf and xdp_synproxy test
Message-ID: <Y0c9GeIeF0+AErO2@maniforge.dhcp.thefacebook.com>
References: <20221012221235.3529719-1-martin.lau@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221012221235.3529719-1-martin.lau@linux.dev>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 12, 2022 at 03:12:35PM -0700, Martin KaFai Lau wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
> 
> The recent vm image in CI has reported error in selftests that use
> the iptables command.  Manu Bretelle has pointed out the difference
> in the recent vm image that the iptables is sym-linked to the iptables-nft.
> With this knowledge,  I can also reproduce the CI error by manually running
> with the 'iptables-nft'.
> 
> This patch is to replace the iptables command with iptables-legacy
> to unblock the CI tests.
> 
> Cc: Manu Bretelle <chantra@meta.com>
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>

LGTM, thanks for fixing this.

Acked-by: David Vernet <void@manifault.com>
