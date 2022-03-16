Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47964DAAAA
	for <lists+bpf@lfdr.de>; Wed, 16 Mar 2022 07:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237386AbiCPGWG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Mar 2022 02:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237240AbiCPGWG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Mar 2022 02:22:06 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D8760D95
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 23:20:52 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id l18so1287578ioj.2
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 23:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=m/DftqeLhHUn16BrzEjWMNa+Fxgc7uuNrYwx40gkhnQ=;
        b=aRf59u+Uk29cYmoXJ0oHAIcHhpJC3PlqT1e0vbWu7uaDO+Qv9ew7Wc9HlC1yDPsguo
         eHXyBG1yBKglJsxQp3u0iQ58VOmg0rIRwYAlhtSEhawCd9jEmpNxsGaG+H6rvykJkubm
         +79Cqs8AtnN1NSVIrhSE1DJjZ8fKyvVrpRQJHojfdblPI4G15mJz18UHf5nWwZhrivjA
         OHHkZ/RF9Msd0NncM6c188vTyDACSkHo8t5P1hCkLPvjtrtWASDA35ZuzghSoI66ZaNt
         rQoYvVuEOi4Ond4wTusd5tF3DzkJlirVP1n1Om10U50KAl+IaGqZFThAAk3yQ031O0nd
         0u2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=m/DftqeLhHUn16BrzEjWMNa+Fxgc7uuNrYwx40gkhnQ=;
        b=VdaAaahWLUav+KbL5zFyZPd+696zul7Tfp1WL6F3QpilNJJd1AypNj+RR9E9uagQ2V
         58MMC3qbPZ6tva8MrzI+QasAdW90+0ZrTfvyHsjw1+ms2eAQiFVwWnD2tspIKYV26VWY
         Fm2PQNraa5/29L6I2CQQEhjOv+ryblNnzmVSFt8XMXM6lzhcKlOwq2ewzvSiCqK1xubD
         BvVyUU/zCHyuudDs212LIdDcgcIv7O7skoKi4/XdnHmJTmWh9/frzB6ESYfaKIx83fE0
         rFG/w2jjjlbhlIh5h3pH+8Oa30Xu2bb2/hurX3O3tpWV+sfevLAYBr/Z6zIW1bPYiqsb
         yYCw==
X-Gm-Message-State: AOAM532UucsSblffUhTkpI9Qevl68REWBgBf/8nEV2cLjOFRrGc/VtvZ
        58z8or/Jvf079WoWUZEsanI=
X-Google-Smtp-Source: ABdhPJx8U4PP6iMXGts1OSG/kzxPAARv0BSco87Z1WUqX9w8jY55ojEVvo+KlC0FxF4yS8c16EJQvA==
X-Received: by 2002:a05:6638:33a8:b0:319:cb5c:f6d9 with SMTP id h40-20020a05663833a800b00319cb5cf6d9mr20116796jav.93.1647411652142;
        Tue, 15 Mar 2022 23:20:52 -0700 (PDT)
Received: from localhost ([99.197.200.79])
        by smtp.gmail.com with ESMTPSA id e17-20020a5d8ad1000000b00644d51bbffcsm594067iot.36.2022.03.15.23.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 23:20:51 -0700 (PDT)
Date:   Tue, 15 Mar 2022 23:20:44 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Martin KaFai Lau <kafai@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
Message-ID: <623181bc1eb4f_18dc208a6@john.notmuch>
In-Reply-To: <20220316014841.2255248-1-kafai@fb.com>
References: <20220316014841.2255248-1-kafai@fb.com>
Subject: RE: [PATCH bpf-next 0/3] Remove libcap dependency from bpf selftests
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Martin KaFai Lau wrote:
> After upgrading to the newer libcap (>= 2.60),
> the libcap commit aca076443591 ("Make cap_t operations thread safe.")
> added a "__u8 mutex;" to the "struct _cap_struct".  It caused a few byte
> shift that breaks the assumption made in the "struct libcap" definition
> in test_verifier.c.
> 
> This set is to remove the libcap dependency from the bpf selftests.
> 
> Martin KaFai Lau (3):
>   bpf: selftests: Add helpers to directly use the capget and capset
>     syscall
>   bpf: selftests: Remove libcap usage from test_verifier
>   bpf: selftests: Remove libcap usage from test_progs
> 
>  tools/testing/selftests/bpf/Makefile          |  8 +-
>  tools/testing/selftests/bpf/cap_helpers.c     | 68 ++++++++++++++
>  tools/testing/selftests/bpf/cap_helpers.h     | 10 +++
>  .../selftests/bpf/prog_tests/bind_perm.c      | 45 ++--------
>  tools/testing/selftests/bpf/test_verifier.c   | 89 ++++++-------------
>  5 files changed, 118 insertions(+), 102 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/cap_helpers.c
>  create mode 100644 tools/testing/selftests/bpf/cap_helpers.h
> 
> -- 
> 2.30.2
> 

For the series,

Acked-by: John Fastabend <john.fastabend@gmail.com>
