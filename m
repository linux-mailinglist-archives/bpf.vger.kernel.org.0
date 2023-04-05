Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A54756D84EB
	for <lists+bpf@lfdr.de>; Wed,  5 Apr 2023 19:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbjDER2s (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Apr 2023 13:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233513AbjDER2p (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Apr 2023 13:28:45 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE046A5A
        for <bpf@vger.kernel.org>; Wed,  5 Apr 2023 10:28:37 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-947abd74b10so71845566b.2
        for <bpf@vger.kernel.org>; Wed, 05 Apr 2023 10:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1680715715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pDKUsKUYjfYOoIc8O/wHcpOCzt3XdNEubRKo0HbBpFA=;
        b=AHLHLuunzTs8/08hfvNnrP6uafGAxr+xegGw6YanYYz9/h3IZ+Vlj4Nl+u9zC87Ngl
         0aNby7RMZO5lLkJ/suhxfVltBGRXq18ZXpEGCKpKojrM53Kq2SFmzmCH6vzD5yrp3jr0
         EgtCmW9OeHAk8V209gtgw17qGWLvk7GHhkx9b78Et/VvxK9+zL5c8Cay2mFi15hlwKYH
         Rr2sA7m3Mgo3ERDgEQlLeoIJW7pAU7SipBp2u6U4He3Csu3JQZzC3DiiJgIVnn8uaFgn
         5a73HQfeyI1Xgi3KOAwPLSeHWFvIRssyOdi9aEwXiBJChxedr6C+ySf18UKb7S+a9qki
         s1bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680715716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pDKUsKUYjfYOoIc8O/wHcpOCzt3XdNEubRKo0HbBpFA=;
        b=ZOmL2i4ao8QtyyJ1cNvE+Sh2NmbN7BNox+VuwRNprpDRnfM1HegRjA2ahp6cC150k4
         wpRJGhHiZSNZN+3N/Z8jkbAxKTl2pBn06NyEI9zGnUyrmwWzceHKUoBvLudMwlE0L2N7
         p62gdEC+nux0P22zr6IFxsxemyZ3/0wksdamUwFvgH+Muv9D/EOwfn06vrBuwtDXV4pI
         4gRm1bbZ8UhVuilK58ev3zYsPNCItIJDEwy3I85GVBvoG8AV4bxOlRgTTssHQMB0tyWt
         eTYrDQczfLpgcai2RorBFK/m9d0a+b/8NEfq/n/JEwkbooS2qSO0ngrp8DFjvf6jlwTn
         Wx3Q==
X-Gm-Message-State: AAQBX9eOMlsNkobEonaSOVg59scUxTxbD4euEHO6L/7d9hxbDPqSMh5a
        IKTFTlkBCtxjF9TrUuEYINPu3Q9WeCl+fj9tTBvS3w==
X-Google-Smtp-Source: AKy350aLXrOGq+bewuvndkswquGMYOiwwoT3OaYApBhlnPVcnktyNXK++2UGtfziEKH8tR86UABJgCW9o0q0UPEcfpw=
X-Received: by 2002:a50:8a91:0:b0:4fc:a484:c6ed with SMTP id
 j17-20020a508a91000000b004fca484c6edmr1606839edj.2.1680715715786; Wed, 05 Apr
 2023 10:28:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230404043659.2282536-1-andrii@kernel.org> <20230404043659.2282536-9-andrii@kernel.org>
In-Reply-To: <20230404043659.2282536-9-andrii@kernel.org>
From:   Lorenz Bauer <lmb@isovalent.com>
Date:   Wed, 5 Apr 2023 18:28:24 +0100
Message-ID: <CAN+4W8gme3i+0KKc4rug8E9NVOmggABCDVZF2VU2dYVpyLMm0Q@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 08/19] bpf: fix missing -EFAULT return on user
 log buf error in btf_parse()
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@kernel.org, timo@incline.eu, robin.goegge@isovalent.com,
        kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 4, 2023 at 5:37=E2=80=AFAM Andrii Nakryiko <andrii@kernel.org> =
wrote:
>
> btf_parse() is missing -EFAULT error return if log->ubuf was NULL-ed out
> due to error while copying data into user-provided buffer. Add it, but
> handle a special case of BPF_LOG_KERNEL in which log->ubuf is always NULL=
.
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Lorenz Bauer <lmb@isovalent.com>
