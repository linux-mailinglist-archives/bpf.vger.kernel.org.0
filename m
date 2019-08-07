Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D419485036
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2019 17:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388764AbfHGPra (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Aug 2019 11:47:30 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:51100 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388756AbfHGPra (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Aug 2019 11:47:30 -0400
Received: by mail-pl1-f202.google.com with SMTP id d6so52611138pls.17
        for <bpf@vger.kernel.org>; Wed, 07 Aug 2019 08:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=nMwumqBUtfhadaTcl5VO/tiYxzoLDov3zoJs7ge+QtA=;
        b=Dqq6I6/nTh3TcUQf/3dZcjouFKQaCxudM0igTHHCJuel4qmAe/F6x31RPaPYcXOI1A
         UlwzWu5F3Li9rf56GinVr5jkbTUFv3Xz4BsFtzdok9NXHlrAcLPG4Ypiz+pe92XyaJcp
         mSFJDI0+bRrajQcpRUWqThfizY+AcFwInChpxVj1KKP13mTf3TMbQdBjnpPBourbetHg
         dpMSz2PC+Rl6HWCeTBKPSkBJba26MFc9qeODwWfNlnIyjRnznb41e7GJYaOfuMe6b+nF
         XEnrTG6FAgbnwgqR6OfSu0eOO2qrobCxtfZJEpf2NDsMbZuzQcS/JOdzZwXgHd/4HO+I
         vWBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nMwumqBUtfhadaTcl5VO/tiYxzoLDov3zoJs7ge+QtA=;
        b=OkYdBFlWXCb4PufMqLyjyX5K2hBw3zillXJQpCa0XZGqUDjzuhChcwpcgnDrFzau6j
         bF5mJJYhNzwBmkXloGkkc7mnGuR6iWWdHUhW5wVfkm4dKjpgPlR27mr8UIPJXyKDxT+c
         ajb3T0AaNyFp9ZmRIwhWt/ofZdnJeO1opsUyQo3SpJ0YDSngG8DDDnTI0fCV7BH0KykX
         +kRtVBWM+exAPQz32CxEr2ZUNZpu7nQAuyUTqQV/bPxTvFlp80+SGKxesUjym2HlGRio
         wVYNolVaRqobr7no7z6+Cq1RwVMVGQmQ+/wWxQmmHRaz5Tr/LlhtKV54M6Tu3xcQ1pfu
         jiFw==
X-Gm-Message-State: APjAAAUOK7uN2XWWYcOSogSX3uLFJgb03B7gO+vQdUwyLTI5CQgkIBYW
        tavo3TO2ar7bIcMGsrc6NT24s9w=
X-Google-Smtp-Source: APXvYqzj/D3Uf97Q+U2MwrTbnNh4nNebdwIy+tciQFKw/LFy69ZO9al9RNayBxl5qafgPRFf5tLZZLc=
X-Received: by 2002:a63:3006:: with SMTP id w6mr8357021pgw.440.1565192849378;
 Wed, 07 Aug 2019 08:47:29 -0700 (PDT)
Date:   Wed,  7 Aug 2019 08:47:19 -0700
In-Reply-To: <20190807154720.260577-1-sdf@google.com>
Message-Id: <20190807154720.260577-3-sdf@google.com>
Mime-Version: 1.0
References: <20190807154720.260577-1-sdf@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH bpf-next 2/3] bpf: sync bpf.h to tools/
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>,
        Martin KaFai Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Sync new sk storage clone flag.

Cc: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/include/uapi/linux/bpf.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 4393bd4b2419..00459ca4c8cf 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -2931,6 +2931,7 @@ enum bpf_func_id {
 
 /* BPF_FUNC_sk_storage_get flags */
 #define BPF_SK_STORAGE_GET_F_CREATE	(1ULL << 0)
+#define BPF_SK_STORAGE_GET_F_CLONE	(1ULL << 1)
 
 /* Mode for BPF_FUNC_skb_adjust_room helper. */
 enum bpf_adj_room_mode {
-- 
2.22.0.770.g0f2c4a37fd-goog

