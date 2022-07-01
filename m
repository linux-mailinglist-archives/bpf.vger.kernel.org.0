Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A21B8563A25
	for <lists+bpf@lfdr.de>; Fri,  1 Jul 2022 21:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbiGAT4w (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 1 Jul 2022 15:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiGAT4v (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Jul 2022 15:56:51 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9CF44A0A
        for <bpf@vger.kernel.org>; Fri,  1 Jul 2022 12:56:50 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id be14-20020a05600c1e8e00b003a04a458c54so2138031wmb.3
        for <bpf@vger.kernel.org>; Fri, 01 Jul 2022 12:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6Q66BpC/Bfw6KE9I0Ok3dyI9GpbNAKGGiuPxmBCNXl8=;
        b=pH0Y2702b37wK3d0ETrivAg5zFbiQMTrzveJ/TumUiniz1hTe2Nhs2v9iS3GqRn+68
         Bl6UX/nFMarhNTMNOLNo1jibbqLQWIdVMcLr8W4/W70d4nuu7Z6B34qXYHYAIbnOhh+W
         3pTrADRA/hrj5RtHqQwc96pXtyTiMNdEuNJtuXC2WCGBH4V6kvNUj6l5vFijyegv+0nr
         6gx2NqwOLWUPCaERB9joG4rmoqmzqHJSslygnVD/rl6Ybdjylzr28n1pv5yE6iNgBT/l
         pmp1WQv13Gqc4FXSjPYrN+zkhSUUUcRGdoI4zOQenYCTWl0UhnYD5EX0packijAWZloN
         CRjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6Q66BpC/Bfw6KE9I0Ok3dyI9GpbNAKGGiuPxmBCNXl8=;
        b=YCvJovpNm0ZNF9gppABxyLoMFKfOTIP+VhKLmqiUAFqtcQdBNESu7s0AOY40iuvJLX
         1u8psm8rZxNphP8prtIQk6ueLI4DjLHhlA/6SL1Osb+jdfX8l7jtpfFBfrmFcbtBGQvh
         g2kVDtUWjsdvEGMBFnCxvL/PeB5BiR/LTfman5aPkmY5MUTqdObvtcka+ww2Ksq1yH8V
         YtA9NbHYFWDXeeMkiwJM44E8t8WL90zzvUNmc6QkhHDgKZBmIvcdwEIMDkIGcpkNH0T3
         c9JseBJHeRLcxq7CCjKrROeV0GhuvEIkTMEB/7YxzeZugx1kB/ySwApYkK7OJR3P5Tio
         1o8A==
X-Gm-Message-State: AJIora8jNyTbFRKf2mlKohM1vAbTWTGMCUJ2/BvKSqV5Wz6KeBf8eQic
        BegrusVQHsub529bxO6KI6WEmZdqcIJTmcw=
X-Google-Smtp-Source: AGRyM1tqkzzbpsKDInMBkTIt0UL0VTxJk4U8qztKg0wJj6/XD/Y8zbNTmdnwDN2jHtIvgz5dJuUzKg==
X-Received: by 2002:a1c:2703:0:b0:3a0:2ffb:1781 with SMTP id n3-20020a1c2703000000b003a02ffb1781mr19480563wmn.146.1656705408962;
        Fri, 01 Jul 2022 12:56:48 -0700 (PDT)
Received: from playground (host-78-146-72-11.as13285.net. [78.146.72.11])
        by smtp.gmail.com with ESMTPSA id ay30-20020a05600c1e1e00b003a033177655sm7802340wmb.29.2022.07.01.12.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 12:56:48 -0700 (PDT)
Date:   Fri, 1 Jul 2022 20:56:44 +0100
From:   Jules Irenge <jbi.octave@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH 1/2] btf: Fix required space error
Message-ID: <Yr9RfDIdgl+lwzmJ@playground>
References: <YryIdu0jdTF+fIiW@playground>
 <CAADnVQ+8dqkrp_tH4PfeY9wOA60QAHS2xo4xt5F09Q-UUBHeQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQ+8dqkrp_tH4PfeY9wOA60QAHS2xo4xt5F09Q-UUBHeQA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jun 29, 2022 at 12:21:44PM -0700, Alexei Starovoitov wrote:
> On Wed, Jun 29, 2022 at 10:14 AM Jules Irenge <jbi.octave@gmail.com> wrote:
> >
> > This patch fixes error reported ny Checkpatch at bpf_log()
> 
> Please do not send patches suggested by checkpatch.
> checkpatch is not an authoritative tool.
> It's merely suggesting things.

Thanks, I take good note. I will try with better tools with less false
positive.

