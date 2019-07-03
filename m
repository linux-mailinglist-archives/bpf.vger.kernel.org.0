Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E37175ED39
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2019 22:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfGCUJ4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Jul 2019 16:09:56 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:53739 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbfGCUJz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Jul 2019 16:09:55 -0400
Received: by mail-pf1-f201.google.com with SMTP id y5so2108933pfb.20
        for <bpf@vger.kernel.org>; Wed, 03 Jul 2019 13:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=BN89+k9094WqEXxXChOvHBZDOQJA6yhrhv3VMUQMnEM=;
        b=K8MRzRIBJbBaW47J3sMChiokQJ5Pbl6uK6L1v+1m6VjrDYU2D0BpHF1co/tBMTFBCE
         U0f/ZTBKtbSoqP8D3RULSdYg6l3f32kqusK1tV+qZYvyHw39EGoyj50GoInl7tqeuq0L
         50ZEVsdAMk/OER11a8EVu0s0cOVqzpMf6xawwuOg2fPpmpEonS626ZOWiobyKAe7Z8GL
         FPx+jCVgLIHhZEfTbLsLyaantLnMZhGVQ4kDl1P1bQoEA6Sa8BKq7lYAheQQsKFNQtVv
         7ZTqsFBJixUAm6/68fj86Afm643qMsSjna3xJZsEN3K3YVBWJX94GK0vjg+0u3PZlY9v
         UyyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=BN89+k9094WqEXxXChOvHBZDOQJA6yhrhv3VMUQMnEM=;
        b=GHeyo4XifsVF9wRkh0W+JNLsvKk45QTr+Mla+GW3bhSEiVLdQUfW0zlwgQ0I6lsPyA
         sq1iIIzlF1oZDILVJMqpE3Bn+5wOlUIVgy0zOIP8rcKfJr+GqbK2vV59FfvN0vfVrn6z
         TR20Yy0BQBrjG2iUrpPyVCWRbjOeEpvWxdEyW+nFAJs9bnIaL+HZ/Pq9whdau15B2LDJ
         /LxVgATs/Ki/3vkPr0hEscaz5Pks2QensXJvcc14gVAuywGiiKiljaeNAs9uaRnHGfay
         BgvKiKQ9nhkUVWxC2wy4uVl6bX07bBbN4/4wnBfDDSQsybo654QQj3eVzid5ROMqigst
         Ol8g==
X-Gm-Message-State: APjAAAXYiwLDZbkqJt6crmE81Kz0U7Mu7+jLVngAZFWjZDtOf3B50XyI
        AnbEJtTYCr/9E+DPVVqzr3nelJ4=
X-Google-Smtp-Source: APXvYqyzj3pNZUq0lUUOOru49jBq4TYaogDc0IKpUqW1iz6p8mOMJldp9NLgBKyIwQXi5rZ+90Jpkbw=
X-Received: by 2002:a65:6656:: with SMTP id z22mr37400171pgv.197.1562184594830;
 Wed, 03 Jul 2019 13:09:54 -0700 (PDT)
Date:   Wed,  3 Jul 2019 13:09:52 -0700
Message-Id: <20190703200952.159728-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH bpf-next] selftests/bpf: add test_tcp_rtt to .gitignore
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>,
        Andrii Nakryiko <andriin@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Forgot to add it in the original patch.

Fixes: b55873984dab ("selftests/bpf: test BPF_SOCK_OPS_RTT_CB")
Reported-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/testing/selftests/bpf/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
index a2f7f79c7908..90f70d2c7c22 100644
--- a/tools/testing/selftests/bpf/.gitignore
+++ b/tools/testing/selftests/bpf/.gitignore
@@ -42,3 +42,4 @@ xdping
 test_sockopt
 test_sockopt_sk
 test_sockopt_multi
+test_tcp_rtt
-- 
2.22.0.410.gd8fdbe21b5-goog

