Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56E5568F0AD
	for <lists+bpf@lfdr.de>; Wed,  8 Feb 2023 15:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbjBHOZc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Feb 2023 09:25:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbjBHOZY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Feb 2023 09:25:24 -0500
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB5546D49
        for <bpf@vger.kernel.org>; Wed,  8 Feb 2023 06:25:15 -0800 (PST)
Received: by mail-qt1-f177.google.com with SMTP id w3so20823664qts.7
        for <bpf@vger.kernel.org>; Wed, 08 Feb 2023 06:25:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5RejkMD8T9ZkXyT9zhnrzWJ3HvCPQxyQ/kx9OwSLTuc=;
        b=jXohf14WXVRmaMtk3kEiZfgwRzbYA4Ls4cQ772jupKEJmLiq6WjjJyM4vV2h93/yPT
         wieAReA1UP1poa9UkqvI/bHCynblcTbSrgckgH904B5K4dDRWOJbRRAM8i9PvLgGa78G
         jwhNtZEDCVfAKbFeMh8EqrokItubLsK93GK1LGLkjod8XgPClJgL4Ym/3FdsXF38gFsK
         xoS7gosjdqpDrZjVNloR/G+60GxEW/IWYYPXv194tRHesIp7dUnTHbaj5He4T8cMmwP2
         uBouzdgNl/+24tKU7Y4DGc2mbsySPckbmnn/JMLGFU9eYStWAYp74UxIk9VCZ3x/LL7s
         s6AQ==
X-Gm-Message-State: AO0yUKVbd7daXtKF8Vi3Adl70NtYjUyp9UX9VvmOGoQLNi59dDZ7bZKo
        BPxnM/tNxNAzvmhVmhx6Fvc=
X-Google-Smtp-Source: AK7set+J5rnAFcyutwza8nWHTPTu4b9WwAjZCnC52fngmP7QV9wSzasC1koKFZ2Th8iIoIcQQIT32g==
X-Received: by 2002:ac8:5bd6:0:b0:3b8:2eca:e6a5 with SMTP id b22-20020ac85bd6000000b003b82ecae6a5mr12610920qtb.29.1675866314510;
        Wed, 08 Feb 2023 06:25:14 -0800 (PST)
Received: from maniforge.lan ([24.1.27.177])
        by smtp.gmail.com with ESMTPSA id e21-20020ac80115000000b003b62e9c82ebsm11719550qtg.48.2023.02.08.06.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 06:25:13 -0800 (PST)
Date:   Wed, 8 Feb 2023 08:25:18 -0600
From:   David Vernet <void@manifault.com>
To:     dthaler1968@googlemail.com
Cc:     bpf@vger.kernel.org, bpf@ietf.org,
        Dave Thaler <dthaler@microsoft.com>
Subject: Re: [PATCH] bpf, docs: Add note about type convention
Message-ID: <Y+OwzhVglY4Bpy54@maniforge.lan>
References: <Y9GPssH+6Yo5/MY9@maniforge>
 <20230127014706.1005-1-dthaler1968@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127014706.1005-1-dthaler1968@googlemail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 27, 2023 at 01:47:06AM +0000, dthaler1968@googlemail.com wrote:
> From: Dave Thaler <dthaler@microsoft.com>
> 
> Add explanation about use of "u64", "u32", etc. as
> the type convention used in BPF documentation.
> 
> Signed-off-by: Dave Thaler <dthaler@microsoft.com>

Acked-by: David Vernet <void@manifault.com>

> ---
> V2 -> V3: updated commit message to respond to David Vernet
> 
> V1 -> V2: addressed comments from Alexei and Stanislav
> by using u64 instead of uint64_t
> ---
>  Documentation/bpf/instruction-set.rst | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
> index 2d3fe59bd26..77990c97b5e 100644
> --- a/Documentation/bpf/instruction-set.rst
> +++ b/Documentation/bpf/instruction-set.rst
> @@ -7,6 +7,11 @@ eBPF Instruction Set Specification, v1.0
>  
>  This document specifies version 1.0 of the eBPF instruction set.
>  
> +Documentation conventions
> +=========================
> +
> +For brevity, this document uses the type notion "u64", "u32", etc.
> +to mean an unsigned integer whose width is the specified number of bits.
>  
>  Registers and calling convention
>  ================================
> @@ -123,6 +128,8 @@ the destination register is unchanged whereas for ``BPF_ALU`` the upper
>  
>    dst_reg = (u32) dst_reg + (u32) src_reg;
>  
> +where '(u32)' indicates that the upper 32 bits are zeroed.
> +
>  ``BPF_ADD | BPF_X | BPF_ALU64`` means::
>  
>    dst_reg = dst_reg + src_reg
> -- 
> 2.33.4
> 
