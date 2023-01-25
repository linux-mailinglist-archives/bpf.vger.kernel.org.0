Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF21B67BC77
	for <lists+bpf@lfdr.de>; Wed, 25 Jan 2023 21:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235528AbjAYUXT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 15:23:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234138AbjAYUXT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 15:23:19 -0500
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD5D1CAE4
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 12:23:18 -0800 (PST)
Received: by mail-vs1-f48.google.com with SMTP id p1so20975639vsr.5
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 12:23:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VbOPczesFObVngQyDFvvGUy8H+9SZ1YJ7EL1k4zPF0c=;
        b=aj4byexHXYjH0ZrSEmNiPvjk2AzhWKjcqSHWvdaLHcZZUbDMqBbULjbmGWYYODme0C
         m4NwZEJ8ZB94ArhMu387zlRQeoJFAlN0nm+oqWSFVX6A1UKCHYkiuByDGUUQtsp32HWm
         VSby27qX2pFbM+oZvZ4E17lygzybPkIzbOnx68OBUeratXJX4+hldtiZk8Bkgw0d52Tk
         eYAyAyI2eh6B/I26hBvYoK7eUzsieYbtaXuKlzk2zXxIznYn8e9ZOJPuvn7SfLb0v0GX
         KmDdrlOxMW/DcDip8hN7KUzGQTp+auMCGaJJwhe4aCpYb97l/6iG7COf4lldCUo+GJUB
         znnA==
X-Gm-Message-State: AFqh2koOC1JyAnSre18bwPai8LdPPmEU1D2HVrNm9nD3oMEfGCXzRnDK
        RM2vmYyzGC+9H5X7PZqBBXs=
X-Google-Smtp-Source: AMrXdXvoFgIp0LmHWj78MH/VmNozxmtTATIt5aA6xp4S5lwISWHil++OQykf7+XxJpeySmYP57fONg==
X-Received: by 2002:a05:6102:22ca:b0:3d0:d434:f0ce with SMTP id a10-20020a05610222ca00b003d0d434f0cemr19626474vsh.27.1674678197108;
        Wed, 25 Jan 2023 12:23:17 -0800 (PST)
Received: from maniforge ([2620:10d:c091:480::1:113e])
        by smtp.gmail.com with ESMTPSA id o24-20020a05620a229800b006eeb3165565sm4022847qkh.80.2023.01.25.12.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 12:23:16 -0800 (PST)
Date:   Wed, 25 Jan 2023 14:23:14 -0600
From:   David Vernet <void@manifault.com>
To:     dthaler1968@googlemail.com
Cc:     bpf@vger.kernel.org, bpf@ietf.org,
        Dave Thaler <dthaler@microsoft.com>
Subject: Re: [PATCH] bpf, docs: Add note about type convention
Message-ID: <Y9GPssH+6Yo5/MY9@maniforge>
References: <20230125184827.6120-1-dthaler1968@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125184827.6120-1-dthaler1968@googlemail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 25, 2023 at 06:48:27PM +0000, dthaler1968@googlemail.com wrote:
> From: Dave Thaler <dthaler@microsoft.com>
> 
> Add note about type convention

Could you please provide a slightly more descriptive commit summary?

> 
> Signed-off-by: Dave Thaler <dthaler@microsoft.com>
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

Can you use single quotes here to match the convention in the rest of
the file?

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
