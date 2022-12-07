Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC1A646292
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 21:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiLGUno (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 15:43:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiLGUnm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 15:43:42 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1975425E9F
        for <bpf@vger.kernel.org>; Wed,  7 Dec 2022 12:43:40 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso2591965pjt.0
        for <bpf@vger.kernel.org>; Wed, 07 Dec 2022 12:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DgTbxmQDFOJwkOndal0/WUQA6B9EgCaWhc05EPyISb8=;
        b=k7kR05lFcejaF3dXyI6BIE2JQduvdP7QxVDK9Fu0HIloeZmlNqD7eeQpTwUky05uX8
         1LtTu/Eiz6m1cgsCAsZOBSlogISr0r6MGPD6jAEyjJ/Bxn650qd8K6imqOvza76Vz9Y2
         j/q/Z8uvR9FpULNreOrmA6zL+JNaRtiRxFM2yEaKCOiWaHPj+/qKPQEWq54Ch8wOpeUQ
         BdABdXV12SfxOKEtd5lrIhU1eCh9Bows/2E5GNxwf7iEg16TARQynzOUrD6QSqayeNqs
         DWQNrNscF3Fhfb0cLejQfb/16zt1d9mBeypFCfSFqRytEpdyPldxD/k6HVk0CMLY6omy
         Oe9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DgTbxmQDFOJwkOndal0/WUQA6B9EgCaWhc05EPyISb8=;
        b=7lnEIJuuxkrJtv9ktDjhq4Sh0RZpHVSy7/bqFEimU5g7317FihWgKCdHtH3QHM1GHw
         83UhaMr4MGdpN+eNoMW9kuXGIUKxo+7m19S+Y4Cv2VZg30NH/TzYTFbjdk2KozKjIzC5
         rYxV+bltJctrSh3zUpExQXA1sK3Sll4ynzYVcopkuVBZku55b/bq0o+J3x/+7QtcA0Sg
         flGf4NLHycwNT7x9SRjVXCdO5jbblczPkTvaB64KZRCukHFVebvwrBwyzGgEYihoRBtm
         ro2tnQ4WuiLzg2Ze8FxZKZEmqc6HF89OkWD19qb8KXCG3aK6zcrsenz9kJda5ynuXlBi
         GF1A==
X-Gm-Message-State: ANoB5pnBHLNYjYv6E+3TcTTriFO4g1/eoceeoLNLaH8UBhmEZ5VRSEcv
        sEJ0FSkFaMM4H6Hq/tlyT0g=
X-Google-Smtp-Source: AA0mqf4h2VIVIXTnm77JtL+wE/SgC7SwLVqJ6aRWjYsEuewAwd6q7IQJQaJ5gZ4Z8XCfBOgxHctPsQ==
X-Received: by 2002:a17:90a:e50e:b0:219:41d0:8fc1 with SMTP id t14-20020a17090ae50e00b0021941d08fc1mr48223825pjy.173.1670445819561;
        Wed, 07 Dec 2022 12:43:39 -0800 (PST)
Received: from localhost ([2405:201:6014:d8bc:6259:1a87:ebdd:30a7])
        by smtp.gmail.com with ESMTPSA id b15-20020a170902d50f00b00174f61a7d09sm15052566plg.247.2022.12.07.12.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 12:43:39 -0800 (PST)
Date:   Thu, 8 Dec 2022 02:13:35 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/2] selftests/bpf: convert dynptr_fail and
 map_kptr_fail subtests to generic tester
Message-ID: <20221207204335.v7syscfb75gckifc@apollo>
References: <20221207201648.2990661-1-andrii@kernel.org>
 <20221207201648.2990661-2-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207201648.2990661-2-andrii@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 08, 2022 at 01:46:48AM IST, Andrii Nakryiko wrote:
> Convert big chunks of dynptr and map_kptr subtests to use generic
> verification_tester. They are switched from using manually maintained
> tables of test cases, specifying program name and expected error
> verifier message, to btf_decl_tag-based annotations directly on
> corresponding BPF programs: __failure to specify that BPF program is
> expected to fail verification, and __msg() to specify expected log
> message.
>
> Acked-by: John Fastabend <john.fastabend@gmail.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

BTW, I think you can also cover linked_list_fail.c in this change.
