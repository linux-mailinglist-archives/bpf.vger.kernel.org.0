Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA75A4F5508
	for <lists+bpf@lfdr.de>; Wed,  6 Apr 2022 07:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbiDFFZF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Apr 2022 01:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353301AbiDFElo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Apr 2022 00:41:44 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F9F1B84D3
        for <bpf@vger.kernel.org>; Tue,  5 Apr 2022 17:41:27 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id r66so829371pgr.3
        for <bpf@vger.kernel.org>; Tue, 05 Apr 2022 17:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9tJ020uVYQvGmJYcTU+A38rBo/Ldj0R2gj6Fu0oc+i4=;
        b=H5ArX6B0RB7jJi56/IjF61qVxF53Ept5ZvYeYU2FuCFGM5R9qfNjT46xiehbbEmn8V
         IFAYoUg+ZWDRMFrAj/Z6PvRZenK3lO9OUmCvIqQYaClwNtIQENFxBXjJBIO22Uw8sIGm
         xFVguv4d7xZTbpKJug1PrmqhbfjzxxtvpyMIjVfopBAh+5o+Egfd4t3fx7s47MJaohE8
         5/5wdx8gZjoA1oec4GIkyhVqJotpoqH9eORflRqw+7XrRaNKc9fwXqoulCyxL4ZE04S0
         EJAv/1KWyBmiN4O6qJ1vN8Q25yuGoY6B03sxAoWvhFLnDHFb0PKdQyOu/c9xOmhSxOtC
         7e3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9tJ020uVYQvGmJYcTU+A38rBo/Ldj0R2gj6Fu0oc+i4=;
        b=jlAXpq9777bD3Duzw/29LJ3/uardb6B0JjDB2AkurqCuXxpeNdoZPhz/pIGpmZ8f4l
         XexeA3wOg55rO6aqBpYcgSaxaQel2CmTm/rNPRGSgcvKPfSAG7KpgbxPOZ4oqAFzQSCw
         VvxOGPB2r6XNMx5u/LOZ364VAh7nWoxTuPKErKn4g2wzBMeIBnfM4epAAkRFqG2TCw8c
         xtWWhPy2JsIe7f3kDAyO96x7lZhFDPDKpiEc84gQqrZcESIXIEJbc3c2B6wgU10Ma4al
         /ZUjZYhGrtgIlIqInqpyc0W2usBlJmSUAqJWgisMy074nLyl+te1WsOsAFQTIcWIlvn/
         aPgA==
X-Gm-Message-State: AOAM532Bq60TFyVoTeYRjng59ImkeaWUlMziK0BsfHFidmswikVhaq1N
        SZogtxCKG4YIxDRI4oNWIzvObj+LerIFsQ==
X-Google-Smtp-Source: ABdhPJyyC26FFlgds9PnOY5h5HbSW9u/co/KCfsDr41xRRte1YdUkE324K+sFb183rLSlBAl4AdGTA==
X-Received: by 2002:a63:d14:0:b0:381:af18:8259 with SMTP id c20-20020a630d14000000b00381af188259mr5030925pgl.309.1649205686552;
        Tue, 05 Apr 2022 17:41:26 -0700 (PDT)
Received: from localhost ([112.79.140.207])
        by smtp.gmail.com with ESMTPSA id j9-20020a056a00130900b004f73df40914sm16716609pfu.82.2022.04.05.17.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 17:41:26 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next v1 0/2] Ensure type tags are always ordered first in BTF
Date:   Wed,  6 Apr 2022 06:11:19 +0530
Message-Id: <20220406004121.282699-1-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=689; h=from:subject; bh=RtpfE414DWryivQCrj4VzGMXD9Zkbwdps8B1KZlHQVU=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiTOGStq78ViiLd+kDh3xpFyeSYRs0zkd1m61Hebd4 ebjtykqJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYkzhkgAKCRBM4MiGSL8RyjtjD/ 4uNhTd+2dJadC9lLAcQP5x8tuFvxBDki413Vria/Sj0rq/eQ0cCbmrRNaIf6eHyVosLiPVB/7mKgbu cYAk1E5pscLf33UOSze09ALMNws2RVSu15sYQkuXSCalYVMsMtbk3WxDMHxmygrot+kSNWfQzLiaN3 Ow25HVG0UXEproG6vlhec29UMzR/SwkpwNSQ7HcOgGDC5QSyaOAk8hpU2jilrV8Sa9ID4jI8jiz3+9 Uk64QZv3bHu6sEDqPaG4Qy86gADecZV+BWcojRWXxo+OzuElHvjkJq28EO1phqEj+Kl8vUwKKyn+XR flINoed62PNqdLYYIPBmhzITydRki66r22oCkM9AOh5UR0KUHFWI5ynNH/gY+AvVcdgltKGzg/0Xas vVU1IPQHl0IfC2mQlrGHscRLxTZPWdHptUNc+RvADZ0my4S7oabwpPUHDYLLcbZMpTKXz1JoWpQ04/ ZKX0IN+CtHfiQ2DoaIWieIv6HVpBsVwTzTZl2tRNICHOdxS2tuI+M++6D8pu/C2Z7XcE6uroc3P0IJ IRr03nXUkUx+klEmCXJDUpBZ6BJxJrmfaGqpS5JHQV/VZcTUlhBtn26wBiqsUbQXfxxTs4venTdqzF hq0xr+LR08RRkKYgFxbFEJF1bi50j/9cMEoObLkXP8f1rJpda40I9CzETzQA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When iterating over modifiers, ensure that type tags can only occur at head of
the chain, and don't occur later, such that checking for them once in the start
tells us there are no more type tags in later modifiers. Clang already ensures
to emit such BTF, but user can craft their own BTF which violates such
assumptions if relied upon in the kernel.

Kumar Kartikeya Dwivedi (2):
  bpf: Ensure type tags precede modifiers in BTF
  selftests/bpf: Add tests for type tag order validation

 kernel/bpf/btf.c                             | 51 +++++++++++++
 tools/testing/selftests/bpf/prog_tests/btf.c | 77 ++++++++++++++++++++
 2 files changed, 128 insertions(+)

-- 
2.35.1

