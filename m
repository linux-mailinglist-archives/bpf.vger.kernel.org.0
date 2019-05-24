Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65AA729BAA
	for <lists+bpf@lfdr.de>; Fri, 24 May 2019 18:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389706AbfEXQAL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 May 2019 12:00:11 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51308 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390411AbfEXP7r (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 May 2019 11:59:47 -0400
Received: by mail-wm1-f65.google.com with SMTP id f10so2490096wmb.1
        for <bpf@vger.kernel.org>; Fri, 24 May 2019 08:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iVMrVxqp5uNYAADGtcNFRrXM8D0V8rtijn49YKBWYRk=;
        b=L6PogmLHo0jNT0q3SHbieEK5uu8kWXU7Q5Gg/0ku3q1S9k/Ebjee+cG+WjBE+RPq9v
         Y/H8nfILdWj6v/AHbTPrwPz/QybwEzejPfwbeYBRevpYccpVndlyiXhyMbbe9PJW5Vps
         /rIUeTukoIRPxkSOpnwPUkh+bkJ+/i0xpbCKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iVMrVxqp5uNYAADGtcNFRrXM8D0V8rtijn49YKBWYRk=;
        b=mZJHTI6bXMSu1TuFtE6D6TqACTy8XOJdmtIQtKS0ZFPBERddGmJQfMAOGg6y36H3/G
         Cr+WQVb6+SywB1M579sSCiP6B3yP7Z/+bevx1wbCf7sVPBnvqxsBvReXTjsY2D0yJm6C
         2WPYuFXpdiSQamzpm2thCJZCFbZATmXRGisiVZhS/vYZhaXOjIKB8ZK7WJzNlUtgfYrO
         hY0yhJWQ9JRhRSP0NrRyCtiCMAk14dTPc11Oasx7EzB4Xe8nODKMJe8XPoAC1blMi9sF
         yJJ6mVwZCeJhFIL1AEGWzrZPsnwvvlDm3hwBB8K7Tl0S0LmdViVGYUi74Xp1usi6jniy
         ekng==
X-Gm-Message-State: APjAAAXjwQKTTZTLDgdLE4q6E/fgPIYM6OIfgSbusanfij22fOodbDpW
        Kg2T6+12sN+7tJhi2S5tKYJ9VA==
X-Google-Smtp-Source: APXvYqyNJlQWHmGB5EFzivM0mI9t1uikYdxRz758//QRkWMrdEHQuMeg1tQxrCEA1ilrzYv6Ie9YYA==
X-Received: by 2002:a1c:eb0c:: with SMTP id j12mr15995872wmh.55.1558713586104;
        Fri, 24 May 2019 08:59:46 -0700 (PDT)
Received: from locke-xps13.localdomain (69.pool85-58-237.dynamic.orange.es. [85.58.237.69])
        by smtp.gmail.com with ESMTPSA id i185sm4535054wmg.32.2019.05.24.08.59.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 08:59:45 -0700 (PDT)
From:   =?UTF-8?q?Iago=20L=C3=B3pez=20Galeiras?= <iago@kinvolk.io>
To:     john.fastabend@gmail.com, ast@kernel.org, daniel@iogearbox.net
Cc:     alban@kinvolk.io, krzesimir@kinvolk.io, bpf@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v4 2/4] bpf: sync bpf.h to tools/ for bpf_sock_ops->netns*
Date:   Fri, 24 May 2019 17:59:29 +0200
Message-Id: <20190524155931.7946-3-iago@kinvolk.io>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190524155931.7946-1-iago@kinvolk.io>
References: <20190524155931.7946-1-iago@kinvolk.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alban Crequy <alban@kinvolk.io>

The change in struct bpf_sock_ops is synchronised
from: include/uapi/linux/bpf.h
to: tools/include/uapi/linux/bpf.h

Signed-off-by: Alban Crequy <alban@kinvolk.io>

---

Changes since v2:
- standalone patch for the sync (requested by Y Song)
---
 tools/include/uapi/linux/bpf.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 63e0cf66f01a..e64066a09a5f 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -3261,6 +3261,8 @@ struct bpf_sock_ops {
 	__u32 sk_txhash;
 	__u64 bytes_received;
 	__u64 bytes_acked;
+	__u64 netns_dev;
+	__u64 netns_ino;
 };
 
 /* Definitions for bpf_sock_ops_cb_flags */
-- 
2.21.0

