Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5DF5326677
	for <lists+bpf@lfdr.de>; Fri, 26 Feb 2021 18:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbhBZRs1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Feb 2021 12:48:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbhBZRsX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Feb 2021 12:48:23 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18286C06174A
        for <bpf@vger.kernel.org>; Fri, 26 Feb 2021 09:47:37 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 18so6477785lff.6
        for <bpf@vger.kernel.org>; Fri, 26 Feb 2021 09:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=MjLYFMT9SJ1Ure/Ap2P1w2aw8y8ygjJYOTchDCJsALA=;
        b=JHNkElPtk44romBt7B6rLouPQ/coLZyHulYMB0jExwejpsPyMDfl7CgpmYrse/iEqS
         q7PMTA/265QSfGUAL8hcUqxm4Cse/4l0TPxGRe4l9HEfJgZu2SXq2Zg+udquX6O9PMzz
         ilGrMjnFirzfE4oboJhyQAgRpVlABewM64sUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=MjLYFMT9SJ1Ure/Ap2P1w2aw8y8ygjJYOTchDCJsALA=;
        b=RqAux/s5IA67EGpCP1Yu6KFYgSvQzk3lPxxvhkCUX4CUcjSMj9ZWAtRfoaXB59OTNp
         AUYnuOsbsaNeWQFYMHpl/2meDqovy4uwL6H019n1iudvyiI76kH6ArVYZBF4T9SR9dKu
         dbOwARN08z/0yiW2Kbu23Gip2IIGOPoBidLyROk0i2fm81vTRW0EROYySKb9WGfA/SoD
         8tqZp7BQ47mHj42aYzIFKlVvmNSCsYadA4fw6RSOd+SHEr2MeuBRDZoSgxU4h3p4PA6e
         BkF8JCpxq00URbr0mLTL6S2VOzfA7fL9wNZg61yPvuQ+tEkhL+Vo+BJ2IVBWTHR+bTSt
         jKDg==
X-Gm-Message-State: AOAM531mkET72RGwcl4yoineq/oWylaFzD0YCoCtaWXLbv3RvU7SwNm6
        zYnlm4PznuiG2x0R3HBPdhc9JEmFZVyadG45yjwPBBKtlwgPVw==
X-Google-Smtp-Source: ABdhPJzY1gzTubCrJEnKKDknU4+tKTnPmdZES/T9Vbbqe+g+pLWf5zvku4yzIq2Ql0KLtc5FFORo5FxiQWrVqTxl2BY=
X-Received: by 2002:a05:6512:33d1:: with SMTP id d17mr2405310lfg.13.1614361655232;
 Fri, 26 Feb 2021 09:47:35 -0800 (PST)
MIME-Version: 1.0
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Fri, 26 Feb 2021 17:47:24 +0000
Message-ID: <CACAyw9-XZ4XqNP1MZxC1i7+zntVAivopkgRgc4yXaNtD8QcADw@mail.gmail.com>
Subject: Enum relocations against zero values
To:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Andrii and Yonghong,

I'm playing around with enum CO-RE relocations, and hit the following snag:

    enum e { TWO };
    bpf_core_enum_value_exists(enum e, TWO);

Compiling this with clang-12
(12.0.0-++20210225092616+e0e6b1e39e7e-1~exp1~20210225083321.50) gives
me the following:

internal/btf/testdata/relocs.c:66:2: error:
__builtin_preserve_enum_value argument 1 invalid
        enum_value_exists(enum e, TWO);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
internal/btf/testdata/relocs.c:53:8: note: expanded from macro
'enum_value_exists'
                if (!bpf_core_enum_value_exists(t, v)) { \
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
internal/btf/testdata/bpf_core_read.h:168:32: note: expanded from
macro 'bpf_core_enum_value_exists'
        __builtin_preserve_enum_value(*(typeof(enum_type)
*)enum_value, BPF_ENUMVAL_EXISTS)
                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Changing the definition of the enum to

    enum e { TWO = 1 }

compiles successfully. I get the same result for any enum value that
is zero. Is this expected?

Best
Lorenz

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
