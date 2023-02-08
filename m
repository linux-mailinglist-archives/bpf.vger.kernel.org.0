Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D7268EFDC
	for <lists+bpf@lfdr.de>; Wed,  8 Feb 2023 14:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjBHNfZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Feb 2023 08:35:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjBHNfY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Feb 2023 08:35:24 -0500
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0255697
        for <bpf@vger.kernel.org>; Wed,  8 Feb 2023 05:35:23 -0800 (PST)
Received: by mail-qt1-f182.google.com with SMTP id cr22so20586613qtb.10
        for <bpf@vger.kernel.org>; Wed, 08 Feb 2023 05:35:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OBc1Lox0aWoOjwFZm57JMbFa1MMSCV9TsclFGex0TtM=;
        b=I0NK2fWnZXnEEWRXT7cHL0d2iGZ4ZEL3w1fL0JwLzSR9MvqAJ2sNQ+CeJYqakFj/ma
         8XqzcrNcaYCIQ9igsQnLaTSUzDEFLpUiqrjd67h5pOIFPmktvXUWHdSqlQXzT1liIj6G
         AWl0wduPRs0WobbTNGrAAqzyGUZ5fUOU90LbV85wttWDrAncz2Dg8YcNn5hGfIo7AIRx
         Rcw9VxNMme2N5Ho9XfDvO1xxVBpLZRI9vaGFisYplmVBBA0WM8CgXeaxcY1otUqUJ+7N
         gkbAQgv3htOiUwDnFulEpT7giYr4FH0aaG+8XOR7J+hcYV9uudSrwQCq7Qmv+DCRW4Gn
         MRSg==
X-Gm-Message-State: AO0yUKVpkrC4rd3cv0kGx/z2Zwx1KNV7ebcpAYA+9WrANVwiRG+c/n5a
        En0G7QU0T+UDY6yq9ppllOG/u+mOwvQGkLts
X-Google-Smtp-Source: AK7set+vIQeq+EZQLoR9FMCmXVa5rC6cq3kQn27mLoPYRKqcgqOb8Pr50vDXTuFGtJsrbZKnrWF0Mg==
X-Received: by 2002:ac8:5acb:0:b0:3b8:6b6b:28c2 with SMTP id d11-20020ac85acb000000b003b86b6b28c2mr12946170qtd.68.1675863321839;
        Wed, 08 Feb 2023 05:35:21 -0800 (PST)
Received: from maniforge.lan ([24.1.27.177])
        by smtp.gmail.com with ESMTPSA id b3-20020a05620a0cc300b0071f97a571e7sm11519551qkj.65.2023.02.08.05.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 05:35:21 -0800 (PST)
Date:   Wed, 8 Feb 2023 07:35:26 -0600
From:   David Vernet <void@manifault.com>
To:     Dave Thaler <dthaler1968@googlemail.com>
Cc:     bpf@vger.kernel.org, bpf@ietf.org,
        Dave Thaler <dthaler@microsoft.com>
Subject: Re: [PATCH bpf-next] bpf, docs: Add explanation of endianness
Message-ID: <Y+OlHox9xU2MTTeb@maniforge.lan>
References: <20230206195532.2436-1-dthaler1968@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230206195532.2436-1-dthaler1968@googlemail.com>
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

On Mon, Feb 06, 2023 at 07:55:32PM +0000, Dave Thaler wrote:
> From: Dave Thaler <dthaler@microsoft.com>
> 
> Document the discussion from the email thread on the IETF bpf list,
> where it was explained that the raw format varies by endianness
> of the processor.
> 
> Signed-off-by: Dave Thaler <dthaler@microsoft.com>

Thanks for documenting this as well. This LGTM, but you're going to have
to rebase onto [0] and submit a v2 in order for it to be merged.

[0]: https://lore.kernel.org/all/20230127224555.916-1-dthaler1968@googlemail.com/

You can include my Ack on that revision:

Acked-by: David Vernet <void@manifault.com>

> ---
>  Documentation/bpf/instruction-set.rst | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
> index 2d3fe59bd26..3358769dc1f 100644
> --- a/Documentation/bpf/instruction-set.rst
> +++ b/Documentation/bpf/instruction-set.rst
> @@ -33,7 +33,7 @@ eBPF has two instruction encodings:
>  * the wide instruction encoding, which appends a second 64-bit immediate value
>    (imm64) after the basic instruction for a total of 128 bits.
>  
> -The basic instruction encoding looks as follows:
> +The basic instruction encoding looks as follows for a little-endian processor:
>  
>  =============  =======  ===============  ====================  ============
>  32 bits (MSB)  16 bits  4 bits           4 bits                8 bits (LSB)
> @@ -41,6 +41,17 @@ The basic instruction encoding looks as follows:
>  immediate      offset   source register  destination register  opcode
>  =============  =======  ===============  ====================  ============
>  
> +and as follows for a big-endian processor:
> +
> +=============  =======  ====================  ===============  ============
> +32 bits (MSB)  16 bits  4 bits                4 bits           8 bits (LSB)
> +=============  =======  ====================  ===============  ============
> +immediate      offset   destination register  source register  opcode
> +=============  =======  ====================  ===============  ============
> +
> +Multi-byte fields ('immediate' and 'offset') are similarly stored in
> +the byte order of the processor.
> +
>  Note that most instructions do not use all of the fields.
>  Unused fields shall be cleared to zero.
>  
> -- 
> 2.33.4
> 
