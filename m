Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1BBC59F259
	for <lists+bpf@lfdr.de>; Wed, 24 Aug 2022 06:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbiHXEHI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 00:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233314AbiHXEHH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 00:07:07 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4D760D5
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 21:07:06 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id d5so8135059wms.5
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 21:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metanetworks.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc;
        bh=WJ7vKcs3/wdjlfxpRnl2VwfFv+S4fy781n9uOZT4ido=;
        b=elgblWp0/dE+76KFBZ4KlDRl2FoN0oBeUYk+WMq6IrHDd5JDnEirt8E2mR7uESQB+S
         VAxkDwr/fGm2Nv+njlU6w1RDEWLbt7xd0mQXbaRVI8/BkBuTSsd03D+OGK4GCIJeYjyW
         VQk7O01L8oVbkLRdYoEgrgU1ZvhYhRwjNlrgw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=WJ7vKcs3/wdjlfxpRnl2VwfFv+S4fy781n9uOZT4ido=;
        b=h7sKykaEwTQJNpaP5l8SZzMz6unFE7AW5Mb1Hw+z7sk7yxv5GvXPikvMqmNK4T+3rI
         0F5/92jY5z2CMB1MCagg4/2PXNwK976fflbYG0EiB+b3zCBDK0DCtr6CLbKf/rURgaAu
         cxgBL6D4SHkZWWstvBSAEVU8GaZB43vkVd5FJ9QRfrwNCTDi5S9zOGxjK3i47/qnXAf+
         ETyymwzmGgRKXl/yuKRyGoB8IU+Yirn/1xDeql3LyBaftmVwIVQ7dJH4hNtwm0EfKM0f
         +Z+WN1r1kaUbyduereyhV7vLRdxCNVnganH58eEyA8pPdA3C2M+W82rtHtSMOl64mYAN
         jkZA==
X-Gm-Message-State: ACgBeo04oZ/+rOF3Qek+YF5qVMmWkxuDGj/4vbZyxVWvld8E0WeZ6kq1
        hdHEqPaUkdttXVqp+QbOr8N9lA==
X-Google-Smtp-Source: AA6agR4qmqOBw88HHWjhUaSHrQ3Rtuir2jxNIvBkEb8rW5hfUb9rSXd1YklBnC22BC8pghxkhis8SQ==
X-Received: by 2002:a1c:a383:0:b0:3a5:af21:1ef0 with SMTP id m125-20020a1ca383000000b003a5af211ef0mr3766249wme.123.1661314024616;
        Tue, 23 Aug 2022 21:07:04 -0700 (PDT)
Received: from blondie ([94.230.83.151])
        by smtp.gmail.com with ESMTPSA id r187-20020a1c44c4000000b003a62bc1735asm392510wma.9.2022.08.23.21.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 21:07:03 -0700 (PDT)
Date:   Wed, 24 Aug 2022 07:07:01 +0300
From:   Shmulik Ladkani <shmulik@metanetworks.com>
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Paul Chaignon <paul@isovalent.com>,
        Shmulik Ladkani <shmulik.ladkani@gmail.com>
Subject: Re: [PATCH v4 bpf-next 1/4] bpf: Add 'bpf_dynptr_get_data' helper
Message-ID: <20220824070701.40120145@blondie>
In-Reply-To: <CAJnrk1bYX5iZXGBOfPD43fgGvnKqynD2qgioS9PnEEDMzoYmgw@mail.gmail.com>
References: <20220823133020.73872-1-shmulik.ladkani@gmail.com>
        <20220823133020.73872-2-shmulik.ladkani@gmail.com>
        <CAJnrk1bYX5iZXGBOfPD43fgGvnKqynD2qgioS9PnEEDMzoYmgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 23 Aug 2022 12:11:38 -0700
Joanne Koong <joannelkoong@gmail.com> wrote:

> The "ptr->offset > size" check isn't quite correct because size is the
> number of usable bytes (more on this below :))
> 
> > +               return NULL;
> > +       *avail_bytes = size - ptr->offset;  
> 
> dynptr->size is already the number of usable bytes; this is noted in
> include/linux/bpf.h
> 
> /* the implementation of the opaque uapi struct bpf_dynptr */
> struct bpf_dynptr_kern {
>         void *data;
>         /* Size represents the number of usable bytes of dynptr data.

Thanks.

BTW, despite the comment I was under the impression the 'size' is the
*fixed* allocation size associated with 'data' (and not the usable bytes
left at data+offset), since (1) havn't encounterd 'size' adjustments in
the helpers code, and (2) 'size' arithmetic isn't trivial (due to
the flags stored into size's upper bits). Therefore, assumed it is
probably the fixed size.

Anyway will fix the new 'bpf_dynptr_get_data'.

Best,
Shmulik
