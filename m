Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFC7D6453FA
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 07:27:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiLGG14 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 01:27:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiLGG14 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 01:27:56 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83AC72ED4D
        for <bpf@vger.kernel.org>; Tue,  6 Dec 2022 22:27:55 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id q71so15413583pgq.8
        for <bpf@vger.kernel.org>; Tue, 06 Dec 2022 22:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZsOXsiABg4+OdUMfbGY52C38DXEkNBLeytYYSkBc9to=;
        b=lxJ8b5MYIaHijGNA76aOZh63DUG8k/WO/J/al8+Q/MMct2/2A5EvIaAdH+hMRS561I
         uZDXfPE3x1vvyH6U1LnfjjQKGRAgLmNJ2LOgpEDoe/10KsFo2/Q9PsZxfJnu3uXM/dye
         g1wgbsZVI3hoSsyPc7PmKWTPvQJHvl5tm90GLHHBJRsKZfwCxLDhv8SUHcRqp+BxrC9/
         p0aVss2tAs6WnEaszLNZWA99xt4UggnFVl3UbblCcpZhCDmhbuqLFBeiXFXmkSGPl0Hf
         fbYdOl4o3qh3Tdcb1/hsVDpGcie+lsxL3sszVidxKpPpWJ4ztFT39OmWrYXY3mfy5N+R
         2n9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZsOXsiABg4+OdUMfbGY52C38DXEkNBLeytYYSkBc9to=;
        b=o6VbdyESARbdbc0S9HkUtlptJ9meLjLQnIeFHVrA/HNGP4oqeSKLnh/z2RpjyOuesU
         TgOwfMaB9SwRjE7SV+ajPFL7vlsrgzOcbbS7CpEctXspiwxhEFRTET/Oqczdd5ghUrKa
         QD3hrwYVdftPwjYRPRLLPyJF7eFqscD9jOVkDCr8Pc2YEhl5mvXg3njjg4SLtVApY7Kr
         w9FK65OvzNIwb7orlg3pkDR1IAfpN7/kaAvENTjUIo5zvCJeEfq4mMD68DgbRe9FxEJ7
         7KWNKt6ip/Cun+8W/WaKH9M9ejcorF3ZuxnpfgkPOWJfCdpq0iWdgsd7DE5jyuMfsyHH
         0gJA==
X-Gm-Message-State: ANoB5pmgzy98HjxrPhnuHofhzwycC2Jnj/JQxqeKQB5PHgMiSXztuO2Q
        3sm18xcprKKym0tk5dw8esU=
X-Google-Smtp-Source: AA0mqf6EkGG20DW9Iyx8F9mYIdRtGdq+Lcgyqu/TrFoCCR7Oj3i64ZcQLHHTIzDJY3DcGZpBAG3wUw==
X-Received: by 2002:aa7:9150:0:b0:574:a3dd:d47f with SMTP id 16-20020aa79150000000b00574a3ddd47fmr58599020pfi.33.1670394475050;
        Tue, 06 Dec 2022 22:27:55 -0800 (PST)
Received: from localhost ([98.97.38.190])
        by smtp.gmail.com with ESMTPSA id w63-20020a626242000000b005624e2e0508sm12662469pfb.207.2022.12.06.22.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 22:27:54 -0800 (PST)
Date:   Tue, 06 Dec 2022 22:27:52 -0800
From:   John Fastabend <john.fastabend@gmail.com>
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net
Cc:     andrii@kernel.org, kernel-team@fb.com
Message-ID: <63903268f0b37_bb3620873@john.notmuch>
In-Reply-To: <20221206011159.1208452-2-andrii@kernel.org>
References: <20221206011159.1208452-1-andrii@kernel.org>
 <20221206011159.1208452-2-andrii@kernel.org>
Subject: RE: [PATCH bpf-next 2/2] selftests/bpf: convert dynptr_fail and
 map_kptr_fail subtests to generic tester
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

Andrii Nakryiko wrote:
> Convert big chunks of dynptr and map_kptr subtests to use generic
> verification_tester. They are switched from using manually maintained
> tables of test cases, specifying program name and expected error
> verifier message, to btf_decl_tag-based annotations directly on
> corresponding BPF programs: __failure to specify that BPF program is
> expected to fail verification, and __msg() to specify expected log
> message.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

Nice.

Acked-by: John Fastabend <john.fastabend@gmail.com>
