Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13DBE6B6031
	for <lists+bpf@lfdr.de>; Sat, 11 Mar 2023 20:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjCKT1L (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 11 Mar 2023 14:27:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjCKT1L (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 11 Mar 2023 14:27:11 -0500
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992E661537
        for <bpf@vger.kernel.org>; Sat, 11 Mar 2023 11:27:09 -0800 (PST)
Received: by mail-qv1-f49.google.com with SMTP id ks17so5823129qvb.6
        for <bpf@vger.kernel.org>; Sat, 11 Mar 2023 11:27:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678562828;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JwcGopBL8EZcU3Cbo3lpR8La57Z1TtPSsp+u+gQkJ9Y=;
        b=YjqpG4D7y372a4uIi8ZX8/zSXDcuOUCSNn/WuZAa272uIAuOVTYOG1OsJYyFd6z/p/
         3meoaRxvYnxMoEVJqUlt0C/2UqKLcVYxpA+jaw+SuGuhJfsddMohv6Yqiouz+psAJRm3
         3qvZEI7TgpuJd0gyxiULX2M9uMHIPbtiu13M8u6RQGEwffzsUmpVfBdbfjkG8Omb6vvG
         du+IqHw9xqB76Vd2d3GUA228cZbdJviXWT+g+7ADiB4gQhGjSwcEHU7Oo9C8nXIO2PEp
         QZtH8NGO/v5G7AM77tyGa/OhE7uyplMeTCIdsvh4TtzqDIUUeyF4prAyuD03oitqWj57
         DSzQ==
X-Gm-Message-State: AO0yUKWRV0G3WXRX8OVmGP2f1eRbWj4rqGf9EAmgwk30HyDiEowIA/Ve
        yEGX9WhUD8d0MWolpAg46Us=
X-Google-Smtp-Source: AK7set9Cf068XD4scDNgTWVpJyLzR5b5FaTXpwdQKFiZvR6mgDt8LK6O/AVExBXxZM74uw3LF5NOHQ==
X-Received: by 2002:a05:6214:f06:b0:5a1:6212:93be with SMTP id gw6-20020a0562140f0600b005a1621293bemr5818740qvb.29.1678562828520;
        Sat, 11 Mar 2023 11:27:08 -0800 (PST)
Received: from maniforge ([2620:10d:c091:400::5:8f9c])
        by smtp.gmail.com with ESMTPSA id t81-20020a37aa54000000b007456b2759efsm924452qke.28.2023.03.11.11.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 11:27:08 -0800 (PST)
Date:   Sat, 11 Mar 2023 13:27:06 -0600
From:   David Vernet <void@manifault.com>
To:     Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>
Cc:     bpf@vger.kernel.org, bpf@ietf.org,
        Dave Thaler <dthaler@microsoft.com>
Subject: Re: [Bpf] [PATCH bpf-next] bpf, docs: Add signed comparison example
Message-ID: <20230311192706.GB332677@maniforge>
References: <20230310233814.4641-1-dthaler1968@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310233814.4641-1-dthaler1968@googlemail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 10, 2023 at 11:38:14PM +0000, Dave Thaler wrote:
> From: Dave Thaler <dthaler@microsoft.com>
> 
> Improve clarity by adding an example of a signed comparison instruction
> 
> Signed-off-by: Dave Thaler <dthaler@microsoft.com>

Acked-by: David Vernet <void@manifault.com>

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
> -- 
> 2.33.4
> 
> -- 
> Bpf mailing list
> Bpf@ietf.org
> https://www.ietf.org/mailman/listinfo/bpf
