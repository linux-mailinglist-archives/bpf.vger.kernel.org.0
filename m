Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83D505821D8
	for <lists+bpf@lfdr.de>; Wed, 27 Jul 2022 10:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbiG0IQE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 Jul 2022 04:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiG0IQD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Jul 2022 04:16:03 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20A35FB8
        for <bpf@vger.kernel.org>; Wed, 27 Jul 2022 01:16:02 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id l23so30203723ejr.5
        for <bpf@vger.kernel.org>; Wed, 27 Jul 2022 01:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c/Lljo9zbL/5r8D0rlatZOzV9Mh5P2xI1odgnavj7V4=;
        b=BFU3b0aK9OSn7qOuLveYRfqekzXwldFxboMJ3ArjZri9yURKBABzMkH4yxNnDxPczL
         0+C329WBL6LHAUCf+a1xfg6dLBxUqdh4VCvN/STNNkMNk1Nh4y6F787Fa8TqXCNCM4Sf
         2pxw8ZccpaEQBBGsCbQ4T15Z86FLzoJf355of8cLmfu28Gw3x+IrPkXTnGfE0hZ0hQMy
         ExlliaKMUEv3YzlG3HISqAQwwyzaZhDMwyZE6zsjx8KkNjJX7sz9Y7AF9UWxHRRiBFGX
         D1p8p+VteLWA5NqeY0OSz7vMp5bR54hxw+zzXNfEmIA/bp/2IutbkzFKRETVY9dG7ss7
         gmKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c/Lljo9zbL/5r8D0rlatZOzV9Mh5P2xI1odgnavj7V4=;
        b=l4r3saRrRJn6raOSOy9Sr7pyg/+mSWGtDTlqPzrAm0Zj7pcT71KHXxybrpyKGGho8d
         9k8XEkPNdjm5DG0lxGFZZxc4jQIAbDewcdXuuNNUr7GO0oB9mKf7Ku5rmOdkb8WEtr36
         dMI50dJpK2u1DZt+fs07KLRMEGJIywJA5t1YoOJGoYHQe5CRJRGpVuYd5wKXXhK4F1AC
         y+glwOU5rqqGsdCFfvgIsus/li7vG4J3kKROWpLER2dxsRfC7SyAjr79s6BuvVhdzMje
         SZMyJ2P8c9w35jbtc6SsHYF8poC7nr/XtUp3L4W+4YDchtGujTZOj9+hZEuNaXqfFEdq
         AK5Q==
X-Gm-Message-State: AJIora8hh2nK1TwZGf/BPgJwQbo28nYmrJ1mVi9fDBfLawCb2/yMRSQD
        nIdvngSMYltwcSZmz2218a5qGp14BTCfiw==
X-Google-Smtp-Source: AGRyM1tXbHuHNXafbE05l+iZ/usOXddVzJ/QcL/4DbAr71XygsccscVwZJWIZpEwP73XyTsCHXzYnQ==
X-Received: by 2002:a17:907:762f:b0:72b:3203:2f52 with SMTP id jy15-20020a170907762f00b0072b32032f52mr17126537ejc.395.1658909760803;
        Wed, 27 Jul 2022 01:16:00 -0700 (PDT)
Received: from localhost (icdhcp-1-189.epfl.ch. [128.178.116.189])
        by smtp.gmail.com with ESMTPSA id t5-20020aa7d4c5000000b0043cbb64a05asm511991edr.67.2022.07.27.01.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 01:16:00 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next v1 0/2] Add __ref annotation for kfuncs
Date:   Wed, 27 Jul 2022 10:15:57 +0200
Message-Id: <20220727081559.24571-1-memxor@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=719; i=memxor@gmail.com; h=from:subject; bh=OVU82KYos812uX/cPMx1ZLY6WyyjrZZrKuB3ZnotI7A=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBi4PP7K3+2SXM++lXvJRayA96Pn5FML6hiT2lDEE6c sUIZ3ACJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYuDz+wAKCRBM4MiGSL8RykZsD/ 98X/5QeV+iLS0y7Ag/WQL+5OhUaIKuWpHvNo8z5PhteB9Ti6ypRquLhSESY7tfr2vdtgte+V0UizTD baYaz2QjjlyyYwPlZMaRLYa8MkeIFco4soEe12bmuuo9uJkkcfcQhU1csjIYr7BRUz4NwYs22w4/XI ZoPKgv7Wa/gumsBYf7Mh4ZtnB3xgHZy5Y+aXkj1AKz6FRugSfIdlV1awXp9/MW7FhPaPPKnTHCopeJ optssBFjIBaHpzGYPuiDQ89f/4BQLNOJEYBMlJoXAdJ1QzxrT2qhMp9f8bqFgQkutWNT1E55WcZvyx 9iGwuhJ/WIDKiFHIGDI1sCHEyaOZoU4xoUTgj0IbuPku1Eim+p79KVaZoVkfr10FlVkIqmziwBSWwB akJTl5HiPiZ2WOaV4+HhR/lx3y1GIyOeJM6MJdg5j6ujJLDw1/EV8sxM/SjWC2XNkJYh09u2evJsg/ AynN7FqBH2QXiqJLmlEqSsgs5bbFr8upU49EJG1K6JBxsisreMW0wJFVk34DA40IVaUPqOAB09LsVH VbzZfq3LrIAFMCVZVxkztcRIruUvXyzOvUETeOAGDpSJIyBgb41vhD1fB2T8KdSQ9eZH5fELhm+N7z 6vYXrXIorN53iZGIajp0IOvOfV2HZv3ycB519UwQe3e1RqLZbYJqBeV8L1cg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

We decided to delay adding this until a usecase came up, and since now there is
one, instead of KF_TRUSTED_ARGS that applies to all arguments, add a __ref
suffix that has the same effect but only for the argument it is applied to.

Kumar Kartikeya Dwivedi (2):
  bpf: Add support for per-parameter trusted args
  selftests/bpf: Extend KF_TRUSTED_ARGS test for __ref annotation

 Documentation/bpf/kfuncs.rst                 | 18 +++++++++
 kernel/bpf/btf.c                             | 39 +++++++++++++-------
 net/bpf/test_run.c                           |  9 ++++-
 tools/testing/selftests/bpf/verifier/calls.c | 38 +++++++++++++++----
 4 files changed, 81 insertions(+), 23 deletions(-)

-- 
2.34.1

