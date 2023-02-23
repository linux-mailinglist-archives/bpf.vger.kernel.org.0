Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 124E86A129A
	for <lists+bpf@lfdr.de>; Thu, 23 Feb 2023 23:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjBWWKN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Feb 2023 17:10:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBWWKN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Feb 2023 17:10:13 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062DA1A978
        for <bpf@vger.kernel.org>; Thu, 23 Feb 2023 14:10:12 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id x10so46884675edd.13
        for <bpf@vger.kernel.org>; Thu, 23 Feb 2023 14:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q55m7iVQIlNDy9qn5FEsP6EXq9dX22jGRLXIOTB0JSc=;
        b=SA9wRLy7g+gMifh4VFWibFCBmYgFvQDjf/6uBLb0nzTpnMzKBntn47pFmQeuPLBDWv
         iep/9jmIfVtloOLCn3pqV35oZfhtSeCJkZS/G1eKTjAKxgG8blhGf6lkhgDhuksYeuW3
         LP8ZMnMjG2Tqbk48rd9uq/AgwMD1Pl4kY07psrcUARDNi+FmhJlmqbsGOwpryWtWK3Uq
         wNHOIeRQXXGOPXb/wTs1U5VtilyXwMUN3Qael+hIpYan9tCowWOuBfsPTNvQ0aAyCjTE
         RK8b48mu3FVSTQXnsro0sBPSuELLSBw8x2vn++MFdYG0YJghfFdju+1T0W3ksDF1i9Rp
         TCCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q55m7iVQIlNDy9qn5FEsP6EXq9dX22jGRLXIOTB0JSc=;
        b=vA6CtlG0vI/DJlG9NAJ80144g8L/t9xdvZCJh0WY2fcBAqtVF9BPPwOlm8XbOMCedw
         7hi7I3hR3QzxZEAHFBULeStWKMSLBUA+mhAnCqeyPJuHHocGokhecAmuetbdVmlNtr6D
         l13gDuRFrMSxWY/K6/qaah2yeSwxyQJ8Xd5GRL9sDl46keSUV/Cr6I9Dmh2wlwkjobjm
         BOW5GD8M8rX2zMU8x5aoSsRITMETXaC66csjFTRbMMni4JTgadCiJAkzBJxmq4Im15ou
         q804jcsX1RjuD4alu/UjCTq/N3jcNW+GqXFeqrtyEBgFaMOpDxtOl74GVCN2AfBU8ZSr
         oU9g==
X-Gm-Message-State: AO0yUKUyIBOgcUi0e8NyVoSa4tHumMYD7InMbe10eeszYmo0kubWKWB3
        Pht9rLsWigC6KQ/m3IFBiDwqvzW43FOcXA==
X-Google-Smtp-Source: AK7set+bhzDgzP/W29uk0lsbBS6moWXJ9AJc5Dd6GTq99vCuc4K361GHhpqzUTg1YOHz03FXI7+Qeg==
X-Received: by 2002:a05:6402:1503:b0:4ad:7bd3:bb43 with SMTP id f3-20020a056402150300b004ad7bd3bb43mr12151794edw.21.1677190210332;
        Thu, 23 Feb 2023 14:10:10 -0800 (PST)
Received: from krava ([83.240.62.52])
        by smtp.gmail.com with ESMTPSA id 19-20020a508e13000000b004aef609f747sm6331911edw.3.2023.02.23.14.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 14:10:10 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Thu, 23 Feb 2023 23:10:07 +0100
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     acme@kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com,
        john.fastabend@gmail.com, kpsingh@chromium.org,
        sinquersw@gmail.com, martin.lau@kernel.org, songliubraving@fb.com,
        sdf@google.com, timo@incline.eu, yhs@fb.com, bpf@vger.kernel.org
Subject: Re: [RFC dwarves 0/3] dwarves: improvements/fixes to BTF function
 skip logic
Message-ID: <Y/fj28OdEdKJBLcy@krava>
References: <1676994522-1557-1-git-send-email-alan.maguire@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1676994522-1557-1-git-send-email-alan.maguire@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 21, 2023 at 03:48:39PM +0000, Alan Maguire wrote:
> As discussed in [1], there are a few issues with how we determine
> whether to skip functions for BTF encoding:
> 
> - when detecting unexpected registers, functions which have
>   struct parameters need to be skipped as they can use
>   multiple registers to pass the struct, and as a result
>   later parameters use unexpected registers.  However,
>   struct detection does not always work; it needs to be fixed for
>   const struct parameters and cases where a parameter references
>   the original parameter (which has the type info) via abstract
>   origin (patch 1)
> - when looking for unexpected registers, location lists are not
>   supported.  Fix that by using dwarf_getlocations() (patch 2).
> - when marking parameters as using unexpected registers, we should
>   stick to the case where we expect register x and register y is
>   used; other cases such as optimized-out parameters are no
>   guarantee that we were not _passed_ the correct parameters
>   (patch 3).
> 
> This series can be applied on top of the dwarves "next" branch,
> as a follow-on to [2]
> 
> [1] https://lore.kernel.org/bpf/20230220190335.bk6jzayfqivsh7rv@macbook-pro-6.dhcp.thefacebook.com/
> [2] https://lore.kernel.org/bpf/1676675433-10583-1-git-send-email-alan.maguire@oracle.com/
> 
> Alan Maguire (3):
>   dwarf_loader: fix detection of struct parameters
>   dwarf_loader: fix parameter location retrieval for location lists
>   dwarf_loader: only mark parameter as using an unexpected register when
>     it does

I'm getting more functions in with this patchset

  1666 for gcc   (with 61678, without 60012)
  9390 for clang (with 62128, without 52738)

but no duplicates and selftests are passing

Tested-by: Jiri Olsa <jolsa@kernel.org>

jirka

> 
>  dwarf_loader.c | 30 ++++++++++++++++++------------
>  1 file changed, 18 insertions(+), 12 deletions(-)
> 
> -- 
> 2.31.1
> 
