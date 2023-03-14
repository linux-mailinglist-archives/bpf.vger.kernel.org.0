Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B7A6B89F6
	for <lists+bpf@lfdr.de>; Tue, 14 Mar 2023 06:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjCNFAN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Mar 2023 01:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjCNFAM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Mar 2023 01:00:12 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2386A1C0
        for <bpf@vger.kernel.org>; Mon, 13 Mar 2023 22:00:11 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id u5so15346306plq.7
        for <bpf@vger.kernel.org>; Mon, 13 Mar 2023 22:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678770011;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tloXDBl7k75WuQq7yfQrJCU2yd+JTXPD0JChCZ+l33U=;
        b=nnnWSD9tsA7DoQC8PA3iwFntXj84aeKU7STNz1f7sGgQY/CyV6l6Rj+ukWMQZT4GyJ
         10P5a0t3BvMMc/szeqUyRwAfRiArkXy4KohHU4Fj2oogfK/RprZiC3MkZ4MqzqcXURr/
         nNL3T8DD8HS54TkVqkVQtsnSpA1nVi1NpgCiZvQg25I8vbjQ8ChgPFKv2MVrCO4W7dmM
         9mMRcZx6fXQRuCf0r89S3XXDuRI0xsqpRvmVnvP6H+2sxVJCHKb+DLMT//susj7wEstb
         mAl6HxCEep9oZDk4/MyYNli+eSo8Q5GNGguPbgsNS4050Z1Kt1E6WvDBY/tZIbDYmDyS
         gWqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678770011;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tloXDBl7k75WuQq7yfQrJCU2yd+JTXPD0JChCZ+l33U=;
        b=Ufw6J1PEDGDEZ1u3vWW6P4K2TMc8B+KAAHw0jr+KG/uB/zAPsslJ/ToAQi+bnnWPjc
         ssUuGvSBgvox1K1dkusXF/w1yVgv4awNaBuMV16aTgxMAndIGBVTE5lmwP0eYkyhOVhF
         Nl3SQvruXo30PdjatlnUR7HwHtjFTOHfKUC4k1Jh9z0XGM1+7N8Svo77I2i1xQ+13YIh
         iBLxzpoxqvAUzflfJuCpLTnt3ihzV05OkbgAEkTb1vq8/pr4/efd1n5lY1xxMiJcJ9sm
         IsWgdM1YTIubrQhlM1Nx59+vkIVjqCdrr/GORzGvhzKVdABNbAlDiWJ0Ja0GlpKmXGai
         ShGw==
X-Gm-Message-State: AO0yUKXoeJLy1BwCwxh0s5DvRnifhM/z9Hi67/xNU2gklHAj8n5R/Jat
        BPY+vao5xZmy9QVC9p0LyAdhGMeUvdg=
X-Google-Smtp-Source: AK7set+PE496RBMh5Qj7eQVNeM0rHHP2XnKqzy44alCrCVVksPZHNqldmxLkdAgfgQ1iG5/dSvARJA==
X-Received: by 2002:a17:90a:5aa2:b0:23b:4151:223d with SMTP id n31-20020a17090a5aa200b0023b4151223dmr9357337pji.17.1678770011023;
        Mon, 13 Mar 2023 22:00:11 -0700 (PDT)
Received: from localhost ([98.97.116.12])
        by smtp.gmail.com with ESMTPSA id z35-20020a17090a6d2600b00230ffcb2e24sm716785pjj.13.2023.03.13.22.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 22:00:07 -0700 (PDT)
Date:   Mon, 13 Mar 2023 22:00:06 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Dave Thaler <dthaler1968@googlemail.com>, bpf@vger.kernel.org
Cc:     bpf@ietf.org, Dave Thaler <dthaler@microsoft.com>
Message-ID: <640fff561de49_42581208cf@john.notmuch>
In-Reply-To: <20230310233814.4641-1-dthaler1968@googlemail.com>
References: <20230310233814.4641-1-dthaler1968@googlemail.com>
Subject: RE: [PATCH bpf-next] bpf, docs: Add signed comparison example
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Dave Thaler wrote:
> From: Dave Thaler <dthaler@microsoft.com>
> 
> Improve clarity by adding an example of a signed comparison instruction
> 
> Signed-off-by: Dave Thaler <dthaler@microsoft.com>
> ---
>  Documentation/bpf/instruction-set.rst | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
> index 5e43e14abe8..b4464058905 100644
> --- a/Documentation/bpf/instruction-set.rst
> +++ b/Documentation/bpf/instruction-set.rst
> @@ -11,7 +11,8 @@ Documentation conventions
>  =========================
>  
>  For brevity, this document uses the type notion "u64", "u32", etc.
> -to mean an unsigned integer whose width is the specified number of bits.
> +to mean an unsigned integer whose width is the specified number of bits,
> +and "s32", etc. to mean a signed integer of the specified number of bits.
>  
>  Registers and calling convention
>  ================================
> @@ -264,6 +265,14 @@ BPF_JSLE  0xd0   PC += off if dst <= src    signed
>  The eBPF program needs to store the return value into register R0 before doing a
>  BPF_EXIT.
>  
> +Example:
> +
> +``BPF_JSGE | BPF_X | BPF_JMP32`` (0x7e) means::
> +
> +  if (s32)dst s>= (s32)src goto +offset
> +
> +where 's>=' indicates a signed '>=' comparison.
> +
>  Helper functions
>  ~~~~~~~~~~~~~~~~
>  
 

Acked-by: John Fastabend <john.fastabend@gmail.com>
