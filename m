Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3B44DBE0B
	for <lists+bpf@lfdr.de>; Thu, 17 Mar 2022 06:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiCQFRj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Mar 2022 01:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiCQFRg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Mar 2022 01:17:36 -0400
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9731965F2;
        Wed, 16 Mar 2022 22:02:23 -0700 (PDT)
Received: by mail-io1-f50.google.com with SMTP id c23so4749921ioi.4;
        Wed, 16 Mar 2022 22:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=mRFTBxOIFW33ZtPG6y2XY2NAl8iMh7CqfapUitnicL4=;
        b=FnHjHgPOZl/wY/z34OHqyxGcYGBMPiVHGkrHl22pUcMEQC3anB/iYobf+B/3rmQ3Xl
         IHrRP1NWpd8YqY3TlZAxe1BObTKe24wiKD5yNSROF2LeYxfX0bd/FxQ3sl4L1af2of/8
         96OkeYfoerBZN5tAHaZvQYENZRuG0ROW8HxkbhU8CDl1W/H/pCZ7yEEhxqLEZ8lPlDlr
         kZMhM2Xao/z0wNRwO3gzHquI0+hODTTKuc6n3wcNyvehhcFmQOtANT2ML6RbQvy2PBjw
         iAb49tOsndwXdlQZ/8Sv5CvDlcBCvLyrKNL9b9nJjZAsxQMc4GY+UcpTa1fFkAm7vyfv
         9vyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=mRFTBxOIFW33ZtPG6y2XY2NAl8iMh7CqfapUitnicL4=;
        b=ufbS3OYwMP5/u5jhdhEztF+aO+FqGJSms637tg2Fi6Z0Sbz9u+CoEQ/3CVgLYGd6Fm
         Cyw3QRQtvnw3KZcfE/lqq1PyWPyKDsTLmk5pj45O9cPKs1A8YG1ALejc4qHxeiImV/hd
         jXpcCnKj89pQl51NbvI+7EatFedbEk5HL4g33tNzItIz40ZxD7+OkyMV77PRWc2fpmUV
         nTjot9F3TWki6Ng30hyaHUuXhFuaNNgWCxCeJtDsdgGNkDOBEOfRYdqvmh5SfpQLNV2p
         1pv8o7KWk6YqsppuEp5wlMKsLq+ZVzip6gevl57lPYb1do2kJUxzVbPafN1iXkpKfCxo
         IxSA==
X-Gm-Message-State: AOAM531wTpbPiFfNJG0orEx824rxs9+D/LyKvwPloGCZTDtevMV6cm9A
        D18PfyJf2e3c78ZXa42pt+w=
X-Google-Smtp-Source: ABdhPJyF6iXPkgdTMW9NQ/ygaG/HrsR+B393GuoHUwAi+WOCzttxjVmJFKs+7dlPQC9jZBIQ0A59oA==
X-Received: by 2002:a05:6638:16d6:b0:31a:2592:a5cf with SMTP id g22-20020a05663816d600b0031a2592a5cfmr1261074jat.232.1647493266740;
        Wed, 16 Mar 2022 22:01:06 -0700 (PDT)
Received: from localhost ([99.197.200.79])
        by smtp.gmail.com with ESMTPSA id f1-20020a056e020b4100b002c68e176293sm2334226ilu.87.2022.03.16.22.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 22:01:06 -0700 (PDT)
Date:   Wed, 16 Mar 2022 22:00:57 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     kkourt@kkourt.io, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     dwarves@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kornilios Kourtis <kornilios@isovalent.com>
Message-ID: <6232c089bbaf2_487f208db@john.notmuch>
In-Reply-To: <20220316132354.3226908-1-kkourt@kkourt.io>
References: <YjHjLkYBk/XfXSK0@tinh>
 <20220316132354.3226908-1-kkourt@kkourt.io>
Subject: RE: [PATCH 2/2] dwarves: cus__load_files: set errno if load fails
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

kkourt@ wrote:
> From: Kornilios Kourtis <kornilios@isovalent.com>
> 
> This patch improves the error seen by the user by setting errno in
> cus__load_files(). Otherwise, we get a "No such file or directory" error
> which might be confusing.
> 
> Before the patch, using a bogus file:
> $ ./pahole -J ./vmlinux-5.3.18-24.102-default.debug
> pahole: ./vmlinux-5.3.18-24.102-default.debug: No such file or directory
> $ ls ./vmlinux-5.3.18-24.102-default.debug
> /home/kkourt/src/hubble-fgs/vmlinux-5.3.18-24.102-default.debug
> 
> After the patch:
> $ ./pahole -J ./vmlinux-5.3.18-24.102-default.debug
> pahole: ./vmlinux-5.3.18-24.102-default.debug: Unknown error -22
> 
> Which is not very helpful, but less confusing.
> 
> Signed-off-by: Kornilios Kourtis <kornilios@isovalent.com>
> ---

With the err to -err fix Arnaldo proposed.

Acked-by: John Fastabend <john.fastabend@gmail.com>
