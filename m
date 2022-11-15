Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44DE162998E
	for <lists+bpf@lfdr.de>; Tue, 15 Nov 2022 14:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbiKONEu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 08:04:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbiKONEt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 08:04:49 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E42962E8
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 05:04:48 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id o30so9620087wms.2
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 05:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1omGc4nP71X/++3HfzeQkSCYnTcd+Apx3yOP4xHTytU=;
        b=Rxw+LGv24IG2KDLDqzvRpjtZu7Qb3NjQp8JXoc2KUHbU1Jk3PK8k3YOBv146mIOTvP
         TaMYf5VvycjKDkow2MQ30IMiQggparXxREppIS0XCD/YdR//1TXpBZ66NQC0U9Ci5nnD
         95ivxt1oIbgrfM2WUPYGZiQLhdm80jYeh39ta+h+IyTAN8Th7r9ZwRmThWqBg58P1IE2
         GskuQC0sihvm3ivDdlL6svJMpv8TOctLX4glz8zZHkQOPu/Diwx7d/z9BUXA3pPXG72N
         QTCukwZX1hju+K8v5V87nxGq0RZhuGOIsDKnylE2hywe+yHrVb1ELtkEB2U0agAObz78
         9NWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1omGc4nP71X/++3HfzeQkSCYnTcd+Apx3yOP4xHTytU=;
        b=HnvyEHr4ARVvqSx+7P4nC5zEOoJKv7rtPb/fXum5WCxCQeyGzsoa0WCPYOYfpO8Ar5
         yQ829C4l8Ib4VZwZrCZZ8aapRtSEAdXL0aJbkYfvwaUcCui0mgRXVH0hsr5BTSwjNtic
         bIHk1OnUZi+xk7YhOJOFW1V91bAQ9nF+D9L4xpE0hX7ULMQLbXETxT60GTRFnQiNf6Ed
         +1ioDL4whor1ngHMQQCfD4Uskbex2EuOid3id9sYFA6EBVadjTv5x9mIkdpYQGaEghEg
         dMNLJNznEru16KoapLFBCLdsrvRTKCkuq8ou6kEe8fxUZTsAQwQvQGgce5ekdYp9n9jy
         XcRg==
X-Gm-Message-State: ANoB5pko4f7LGDBOwcLQswMQBrHixQrHrCHk9pLuVE0kiPTr6HAePoIv
        LgpOk53L8gb3Rxm6Y80kr/U=
X-Google-Smtp-Source: AA0mqf71MjhX7unhMiQvveIwf4J0x3rpjVtXsSiKXi0uJCZ2az3Ubca0g1BsQRSIcXYYpcuDjfbsDA==
X-Received: by 2002:a1c:4c13:0:b0:3cf:baa6:8ca5 with SMTP id z19-20020a1c4c13000000b003cfbaa68ca5mr244714wmf.178.1668517486672;
        Tue, 15 Nov 2022 05:04:46 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id h15-20020a05600c350f00b003cfcf9f9d62sm16098754wmq.12.2022.11.15.05.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 05:04:46 -0800 (PST)
Date:   Tue, 15 Nov 2022 16:04:43 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     memxor@gmail.com
Cc:     bpf@vger.kernel.org
Subject: [bug report] bpf: Refactor map->off_arr handling
Message-ID: <Y3OOa77Sn6GnyLvB@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello Kumar Kartikeya Dwivedi,

The patch f71b2f64177a: "bpf: Refactor map->off_arr handling" from
Nov 4, 2022, leads to the following Smatch static checker warning:

	kernel/bpf/btf.c:3597 btf_parse_field_offs()
	warn: potential pointer math issue ('off' is a 32 bit pointer)

kernel/bpf/btf.c
    3580 struct btf_field_offs *btf_parse_field_offs(struct btf_record *rec)
    3581 {
    3582         struct btf_field_offs *foffs;
    3583         u32 i, *off;
    3584         u8 *sz;
    3585 
    3586         BUILD_BUG_ON(ARRAY_SIZE(foffs->field_off) != ARRAY_SIZE(foffs->field_sz));
    3587         if (IS_ERR_OR_NULL(rec) || WARN_ON_ONCE(rec->cnt > sizeof(foffs->field_off)))
                                                                    ^^^^^^^^^^^^^^^^^^^^^^^^
s/sizeof/ARRAY_SIZE/

    3588                 return NULL;
    3589 
    3590         foffs = kzalloc(sizeof(*foffs), GFP_KERNEL | __GFP_NOWARN);
    3591         if (!foffs)
    3592                 return ERR_PTR(-ENOMEM);
    3593 
    3594         off = foffs->field_off;
    3595         sz = foffs->field_sz;
    3596         for (i = 0; i < rec->cnt; i++) {
--> 3597                 off[i] = rec->fields[i].offset;
    3598                 sz[i] = btf_field_type_size(rec->fields[i].type);
    3599         }
    3600         foffs->cnt = rec->cnt;
    3601 
    3602         if (foffs->cnt == 1)
    3603                 return foffs;
    3604         sort_r(foffs->field_off, foffs->cnt, sizeof(foffs->field_off[0]),
    3605                btf_field_offs_cmp, btf_field_offs_swap, foffs);
    3606         return foffs;
    3607 }

regards,
dan carpenter
