Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2AD0451D7D
	for <lists+bpf@lfdr.de>; Tue, 16 Nov 2021 01:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348952AbhKPAai (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Nov 2021 19:30:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346138AbhKOT36 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Nov 2021 14:29:58 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0209AC061570
        for <bpf@vger.kernel.org>; Mon, 15 Nov 2021 11:18:44 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id x131so15886382pfc.12
        for <bpf@vger.kernel.org>; Mon, 15 Nov 2021 11:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yBFzl6AYztgpQ7yNnKIREuF5XmnmDZIa7O89wcChpQI=;
        b=IbrVY8y/0vKtqsfzaWMeyaRUOnt551g21vLj4mgeo7iUVDU8NL85wm09Vgai/kk/CB
         27US3KDKT3KHDZGRHTa0SCgZ6x9gED05gP+lwGWujoKPF1+Q+MbCeEtJ90dXXpRVxAV+
         VjE/UxTY37RUYmOEtNcTuvqDo3XanZuADr88Tbi+99eKseDsq0ctU61QvjepUwA/igk/
         VZooe3A6gNl3g/hjghJOvX/B2tqU4BObCWfSOpAVjTYI4vKJWBXMZQSAfPef9iKUhja9
         DEjOUVa6ursLC37ZmmA8S0cjeqTZRHR+UvaK5UzqmEQWVosQsJKFni4OxPx0GckawEFT
         WWzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yBFzl6AYztgpQ7yNnKIREuF5XmnmDZIa7O89wcChpQI=;
        b=LfBbDsQCJr0mH/SzBkXBoleeU8YJLpAruIkigdeL8kgjSq+PEDMwAuUhxJSdrd5Um/
         pY+SwUx9wXJSZuL/5yDB3Xgy9nJXUqkYsHv/sI/YHM4K0eA2E4RQimd9s41O99uSZfj7
         h7xfNsvoAoQUyc/c2DCEgS2ERy1x7rT93liXMpRxYRvvyEgf3UW5YQj0e9hN5vGkzUVf
         dcQ7kThRbSkYwRz1P6jJVBgegAt7II8UF3UYg6HvVgQbCImqVOVHU31MIFQF0iZhmOKK
         iw5pfaD8qsIavvQRrArgLtXs4fipL/FAqxCFYX5q2rBH9PK3RbNpyBRZoYJIOGNaXh8V
         Zfaw==
X-Gm-Message-State: AOAM5316og0SiCPVhC/XOUeIHvSOvASxYHwMF9JEGczFrwjJteiPp7B6
        Y/XQSTIQml9sOvuckYDRGgeHAiTASoo=
X-Google-Smtp-Source: ABdhPJxq+b3xghycKe5/ye8j/DO1Buv5TjxKR7uuADbVfDalbfLsOB5mzM1RTeEWJGaYUWKmNafwFw==
X-Received: by 2002:a05:6a00:158a:b0:49f:be86:c78f with SMTP id u10-20020a056a00158a00b0049fbe86c78fmr35282215pfk.56.1637003924122;
        Mon, 15 Nov 2021 11:18:44 -0800 (PST)
Received: from localhost ([2405:201:6014:d064:502e:73f4:8af1:9522])
        by smtp.gmail.com with ESMTPSA id h10sm17332967pfc.104.2021.11.15.11.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 11:18:43 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf v1 0/3] Fixes for kfunc-mod regressions and warnings
Date:   Tue, 16 Nov 2021 00:48:37 +0530
Message-Id: <20211115191840.496263-1-memxor@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=593; h=from:subject; bh=dc9nJwyOePmLUw12ws0w+1YMYhfWpS84yVjyQ6vNURY=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBhkrI2Q24lJ27Q+NxsgOr4mEU/q3WkHUmIsTuxZlXg pskWPQaJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYZKyNgAKCRBM4MiGSL8Ryv3wEA CVV8SW9oZDiWv1FMvgRCyzg1n0/wHesvTpjeq+Oyy2pjwEGochA67XSbffqtOzV+TLk6bTJuLYPXk0 1eVeDH5Y8/NspqpHEtqKomIqm3RohKhVIJ6Y3rlSAWhYjD8qJXLumr7Dmz/RjRBIaXq6Nd+o76hamb HGCMqlKOL5b5ORp4OiZadri/mX9ZPSfLGMvi6+yWYtzyJFJWwpzF/69vgGu5jd9tmv+vuaOvHYAKS4 GLSEiZEtTfL2A8iIqD7BgyKKRdR1r7Tl8BRQrxVkozzz3DeLbmPpiUAcbhgeuN+cBNk6oa1oFlaaaR xg9ZRrG3fc7Q2tzSWcb4PebjAZEX3R+cSSlulNAkw2ullp7WFDrDUAmYV6iuv9oweFTRSJp3n7sEtY q+mfB46wEB+1wnfc6mQBWzJYjRczBx+ISd9plEQBwkkBRwgvIlG0gPVQJXgu6F9Lq8Xk/mvUJQKro8 TvXu/zlW8hQAiVY9B7C655SQ5iFuFW5CofB1ZuOThox/E9ypzssDoRG2fhQao0m3Jx748olnRYqTQI 2DSXpAbPfJY1WAtUd01D72f/YPIShLWACiTWgy4fhTc+OMvhbutVCGvNCJa87xl/C/RAN2U0ugG0tX ElMVFuw/WvJh7ArjVqcHkbMxhuTa/Y9MiZ7J8Ifs40MPyu22HQbktusNg3MQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This set includes fixes for two regressions and one build warning introduced by
the kfunc for modules series.

Kumar Kartikeya Dwivedi (3):
  bpf: Make CONFIG_DEBUG_INFO_BTF depend upon CONFIG_BPF_SYSCALL
  bpf: Fix bpf_check_mod_kfunc_call for built-in modules
  tools/resolve_btfids: Demote unresolved symbol message to debug

 include/linux/btf.h             | 14 ++++++++++----
 kernel/bpf/btf.c                | 11 ++---------
 lib/Kconfig.debug               |  1 +
 tools/bpf/resolve_btfids/main.c |  2 +-
 4 files changed, 14 insertions(+), 14 deletions(-)

-- 
2.33.1

