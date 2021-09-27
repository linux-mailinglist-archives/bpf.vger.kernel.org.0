Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D65BB419E38
	for <lists+bpf@lfdr.de>; Mon, 27 Sep 2021 20:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236143AbhI0S2m (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Sep 2021 14:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236005AbhI0S2m (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Sep 2021 14:28:42 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A7AC061740
        for <bpf@vger.kernel.org>; Mon, 27 Sep 2021 11:27:03 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id y5so9930118pll.3
        for <bpf@vger.kernel.org>; Mon, 27 Sep 2021 11:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cqZ/haXgFjIpSJHfI1VAsLg6naAL8kq0nI4pUX8OICI=;
        b=Ae/GnkZxx3AzOrnhpyQniuKHJ0wlNZWBFXL/PP1m5XyrATkGpzSqE3Uq9DuDZcHqBT
         3/7Pw6GZqWYV5lFyBe6YWzOm62BJxOQ1gbk2uXzktlBWHR6jSykmBSNWR3rHP9Q44Ws4
         uBBuE2m75g5Q8oX4OZxMmO0/NIOGZwIvpfmq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cqZ/haXgFjIpSJHfI1VAsLg6naAL8kq0nI4pUX8OICI=;
        b=bP17iPoyoaYkmyexnDBkgTQohY36Gr+6122AzhHuVls/goP5VFgqr6mD/+tTJaA+bp
         pKKsLkFFhwoZoBLI3fIzUKhEO7u76tT5cEGMDAWCkO7pZsI2n6UYAlJ05d+702EFnQxq
         hBMFi656xRnm1PRX9UxrGDEO4BlRQSSzuFVA2uET0YDvxGHJuQIt4ZuVAUxelT/UgsM2
         4Y6Lq0uD5w5z/7AQRhAFa1O0PmJiG1AdK9+5vk+8zPzQEpnxzQLoIUW6Zc9kRqiJnZpQ
         w7n48PXH7mtvhCuFwXft7d5bqj61A9UaFH+/jG8N6q0faksaKWABOzYnLKq0nCV6jopS
         ZY2Q==
X-Gm-Message-State: AOAM530g0DtyKvRwCD1Aw03934Ddnk6S81eY4LLgrHIsuzffKMAjsaNI
        QcK0h+/M1A6OSqDBZbdgD6DoUA==
X-Google-Smtp-Source: ABdhPJywmhpBzovEAGLAlFReddqtfL+7gRfxRwqhTffp+Of1COtfe+1K/C/r12SNHYB9tQ7E7aOY9Q==
X-Received: by 2002:a17:902:bd8d:b0:13a:8c8:a2b2 with SMTP id q13-20020a170902bd8d00b0013a08c8a2b2mr1103469pls.89.1632767223468;
        Mon, 27 Sep 2021 11:27:03 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p26sm16995621pfw.137.2021.09.27.11.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 11:27:02 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH 0/2] bpf: Build with -Wcast-function-type
Date:   Mon, 27 Sep 2021 11:26:58 -0700
Message-Id: <20210927182700.2980499-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=813; h=from:subject; bh=MnT3y2POoh9krBGr+oM0LKIH9K7M9hDNGXXQn9PnoRw=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhUgzzvGdW82BhK8YP1w6/r5Vk4Bo4qJhhkmiN8oKK zuSXBkqJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYVIM8wAKCRCJcvTf3G3AJhHyD/ 92lm82tkG/wPJiioqfs+Kxaa88GuCYKYWWP/IpncLQxmww37DgGOH/Wl/oJrhtTcw8GZZpOoNH3sse 7rn2JRT4QSEt5CzLLoD05pa6ceTWKIjkJ/d/VXCqNv+AfWepP3FacdWj60HKye/chGORzdj39B1tvC v62lA+y14QDzdx/r3AZ9MVzrnNaQFo4toGxCBRp7MnHFxL/mEv4cgPPAjFTfouI8vjnDy9GxHwlWnC xRONH7W48GvmgxCCtQg8Xmj380nJ/j3EImlyRlV0GulKQE8HUggfHnCp0BhmGL+RnuYJgfcpRkeO8F xI5c1r+1N6SZdUoRpQeXoaXu06lnFVybmVEa2qQwbq8zB0lCmpWH4moHHvk2EJ6lejNPCr8Tqbhyz7 2Sfh9Wzdb0IwASUho4vpo8yC3j3Z1EglOYMbTnM0yfx9K8vVmDNfJAi07mlFimGY/El21EE+vEb0Bb ZWJEP5ZsVJoI2H+wJXoNMM1rYE9WVWNJlCakhG7SJKxKbe85sJ6Z0/bPeukf+StZP+PhGG9uYGsygG kTPKuc45qiVI4IKKLnwhHm4B8BAg8WqCGUqePAvbi0tIopgbzqU37XmEc07HeCiwfr70U+YuVMs2wD x8/ZL4nbwMj00/sy7GZ/kgYZFPRtsLQ2djb0/g0c0gZAzlD9lQHeSbx4nrmA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

In order to keep ahead of cases in the kernel where Control Flow Integrity
(CFI) may trip over function call casts, enabling -Wcast-function-type
is helpful. To that end, replace BPF_CAST_CALL() as it triggers warnings
with this option and is now one of the last places in the kernel in need
of fixing.

Thanks,

-Kees

Kees Cook (2):
  bpf: Replace "want address" users of BPF_CAST_CALL with BPF_CALL_IMM
  bpf: Replace callers of BPF_CAST_CALL with proper function typedef

 include/linux/bpf.h    |  4 +++-
 include/linux/filter.h |  7 +++----
 kernel/bpf/arraymap.c  |  7 +++----
 kernel/bpf/hashtab.c   | 13 ++++++-------
 kernel/bpf/helpers.c   |  5 ++---
 kernel/bpf/verifier.c  | 26 +++++++++-----------------
 6 files changed, 26 insertions(+), 36 deletions(-)

-- 
2.30.2

