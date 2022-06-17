Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC3954F605
	for <lists+bpf@lfdr.de>; Fri, 17 Jun 2022 12:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381836AbiFQK5l (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Jun 2022 06:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234702AbiFQK5k (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Jun 2022 06:57:40 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C8FC19035
        for <bpf@vger.kernel.org>; Fri, 17 Jun 2022 03:57:38 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id ej4so1738507edb.7
        for <bpf@vger.kernel.org>; Fri, 17 Jun 2022 03:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b/Dy8Jnr8/LXglvk2vgtZpW47clC5IdLNRi23nJJpmc=;
        b=jwaf7LG7Gxk14lQBdxMAaZ4YRzwCsIDpFELTXDxdtLlMEsay8HZmMsk7rXapbmKqUy
         gxXJ7zv8Etu9AUf9rtmy6aUb9QTae7dPi0vNwkAV89/S2U/QhGpRlnQP118OSSi7Fl/R
         CJaaTknBKOVDoFel+JGX2xLRdQ0o9+PG2OJfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b/Dy8Jnr8/LXglvk2vgtZpW47clC5IdLNRi23nJJpmc=;
        b=cDw3b/N10WB1wie79ePwjclWxAh25OfKCRuaSgfcTPV7QyvDYNLQhbQ78I7KQBHdYl
         +I3QreB66djVWq47EF7+Xw8d4uMhdHI63fiE2AK6bvn2hBxKBfNKYtRr7OGFxNfOprZq
         AmbGMrwyPIO3qBr5Nw6XR67QnMTMgLRs0UuQRf0gyR08N/jw72609QtCAG1GfKgBBXHv
         KoOb05IEZYsCjN36bwHYG40Yqh7Vh9j04kXWxsiTwST6MG7CeGCn5lHQRAZi5cTPbKh5
         cpgp5I2y93X1gEJV1M/fAVu9qoQ4WMA3Lq6gvqamsudJKxroCDJQpIG7h2FqZukVv5kt
         0SvQ==
X-Gm-Message-State: AJIora9kT9GYB1uUjMjXwK6n3BaN7wk+7JsWdDkiw6Mh0Y7LGwzs1oFX
        vGY2sPfnFokjq3E3CwzC8R/LMlJGZ63/ug==
X-Google-Smtp-Source: AGRyM1vf4vb47rYEVaDJpGq7ncwYv3Mpbgq2EzGwOMrzp4BfySt6eR1zFn7o1IVsRrO2bxNKpi3LdA==
X-Received: by 2002:aa7:c9d2:0:b0:42e:1776:63e0 with SMTP id i18-20020aa7c9d2000000b0042e177663e0mr11298996edt.185.1655463456592;
        Fri, 17 Jun 2022 03:57:36 -0700 (PDT)
Received: from cloudflare.com (79.184.138.130.ipv4.supernova.orange.pl. [79.184.138.130])
        by smtp.gmail.com with ESMTPSA id x16-20020aa7cd90000000b0042fb3badd48sm3485937edv.9.2022.06.17.03.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 03:57:36 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        kernel-team@cloudflare.com, Tony Ambardar <tony.ambardar@gmail.com>
Subject: [PATCH bpf-next 0/2] Allow mixing bpf2bpf calls with tail calls on arm64
Date:   Fri, 17 Jun 2022 12:57:33 +0200
Message-Id: <20220617105735.733938-1-jakub@cloudflare.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch set enables using bpf2bpf calls together with tail calls on arm64.
Patch 1 was borrowed from an RFC series for MIPS JIT [1].
Patch 2 gives an explanation of tweaks needed to arm64 BPF JIT.

[1] https://lore.kernel.org/bpf/77dfea2d224e7545e5e4d3f350721d27e5a77b0d.1633392335.git.Tony.Ambardar@gmail.com/#r

Jakub Sitnicki (1):
  bpf: arm64: Keep tail call count across bpf2bpf calls

Tony Ambardar (1):
  bpf: x64: Add predicate for bpf2bpf with tailcalls support in JIT

 arch/arm64/net/bpf_jit_comp.c | 9 ++++++++-
 arch/x86/net/bpf_jit_comp.c   | 6 ++++++
 include/linux/filter.h        | 1 +
 kernel/bpf/core.c             | 6 ++++++
 kernel/bpf/verifier.c         | 3 ++-
 5 files changed, 23 insertions(+), 2 deletions(-)

-- 
2.35.3

