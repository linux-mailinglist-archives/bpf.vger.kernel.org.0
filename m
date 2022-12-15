Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D7064E021
	for <lists+bpf@lfdr.de>; Thu, 15 Dec 2022 19:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbiLOSAR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Dec 2022 13:00:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiLOSAQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Dec 2022 13:00:16 -0500
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8F2419B8;
        Thu, 15 Dec 2022 10:00:15 -0800 (PST)
Received: by mail-qt1-f179.google.com with SMTP id jr11so169996qtb.7;
        Thu, 15 Dec 2022 10:00:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FGclQX0rtIzEBYUXE1ME/P3kEV9LEhtn6G8+RoxArp8=;
        b=rvWW6ZllxcmZgBoZRWpM3SnfcVckulVL1JXI+KhACvrkUpKVBFNBLnVoLt7I2jORM4
         KaMJ28+stOAwKtLNjpXR1aZonWUvA3YT3wZwICXrSqJxlVHB5oU2CicXMM9+3RSjqFqw
         6evYyqcpKTK9kZhr/zFC+UD1wBmGAM7cT91YxoYHXycD84yd2Ela8ygqpMcuTTY2SR34
         lacUVez4OxBYXdH9CwIZwNaoceURJ5iBTrDIJ5UtbDNAmLbQ9KpWawCat+hThnmS91/C
         oCDDQpeIK5wVqyPSURbi098fPtBZ9Sq2QOtBhA8OSobovF4IrTfD1kALv8HlkxfWwaC6
         PlVA==
X-Gm-Message-State: ANoB5pmTEo8BzD+038JS1GAXuzZpa7bxX9zfAxNpVDHuE4UI1h2bGLRZ
        iKQ8LDXeaMHxS21rzvkotL8=
X-Google-Smtp-Source: AA0mqf5WUFDNWf7uLwnUmGQDRfHoEBZeQJPxiz8QhHNWslKYDSx7Fwh2L2wD9GHD2Arw2ZwUA/7uag==
X-Received: by 2002:a05:622a:1f8d:b0:3a7:e2a1:331b with SMTP id cb13-20020a05622a1f8d00b003a7e2a1331bmr17989854qtb.4.1671127213333;
        Thu, 15 Dec 2022 10:00:13 -0800 (PST)
Received: from maniforge.lan ([2620:10d:c091:480::1:4e06])
        by smtp.gmail.com with ESMTPSA id a25-20020ac87219000000b003995f6513b9sm3756845qtp.95.2022.12.15.10.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 10:00:12 -0800 (PST)
Date:   Thu, 15 Dec 2022 12:00:09 -0600
From:   David Vernet <void@manifault.com>
To:     mtahhan@redhat.com
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org, jbrouer@redhat.com,
        thoiland@redhat.com, donhunte@redhat.com, john.fastabend@gmail.com
Subject: Re: [PATCH bpf-next v4 1/1] docs: BPF_MAP_TYPE_SOCK[MAP|HASH]
Message-ID: <Y5tgqZfRnnxqSWMz@maniforge.lan>
References: <20221215153939.6885-1-mtahhan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221215153939.6885-1-mtahhan@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 15, 2022 at 03:39:39PM +0000, mtahhan@redhat.com wrote:
> From: Maryam Tahhan <mtahhan@redhat.com>
> 
> Add documentation for BPF_MAP_TYPE_SOCK[MAP|HASH]
> including kernel versions introduced, usage
> and examples.
> 
> Signed-off-by: Maryam Tahhan <mtahhan@redhat.com>
> 
> ---

Thank you for making these changes, Maryam. This looks great. I had one
very small nit below, but overall this LGTM:

Acked-by: David Vernet <void@manifault.com>

[...]

> +.. note::
> +    Users are not allowed to attach ``stream_verdict`` and ``skb_verdict``
> +    programs to the same map.
> +
> +The attach types for the map programs are:
> +
> +- ``msg_parser`` program - ``BPF_SK_MSG_VERDICT``.
> +- ``stream_parser`` program - ``BPF_SK_SKB_STREAM_PARSER``.
> +- ``stream_verdict`` program - ``BPF_SK_SKB_STREAM_VERDICT``.
> +- ``skb_verdict`` program - ``BPF_SK_SKB_VERDICT``.
> +
> +There are additional helpers available to use with the parser and verdict
> +programs: ``bpf_msg_apply_bytes()`` and ``bpf_msg_cork_bytes()``. With
> +``bpf_msg_apply_bytes()`` BPF programs can tell the infrastructure how many
> +bytes the given verdict should apply to. The helper ``bpf_msg_cork_bytes()``
> +handles a different case where a BPF program can not reach a verdict on a msg

s/can not/cannot
