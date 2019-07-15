Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E345469936
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2019 18:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731387AbfGOQkP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Jul 2019 12:40:15 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:57295 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731220AbfGOQkO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Jul 2019 12:40:14 -0400
Received: by mail-pl1-f202.google.com with SMTP id o6so8544128plk.23
        for <bpf@vger.kernel.org>; Mon, 15 Jul 2019 09:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=74ekQLUlOcUHWDfNU+9U1KuKKcCpv3glEkmfGQfN1Vg=;
        b=JoI8ajpXbNJnJzIZmkUjiwpxQGqLLpeyT3ezcjQds8Jbblz/2dYpYPx6iS60MdT8wF
         fjO0hY3v5hERwI3YY67gSJ3Wm8Ndlacf/Z3L704zCaFXz0obMni7xmR9hc+eMkLrVqqp
         Kko7/HDTg2hHEzjH1NSGWhdvrjFI0puwyhrr8uzfuPTBc3MQZtj9Nfw25vyELv2rzbG1
         ZuuREDY40nlp8FNY5BZG7LEmPiIamkiucM9AOTZhDnlvF8zN6+ncBO61hSV2h/g9hW9h
         8lqaIk2Hu1F+YlmNhASxIxa1YSFiIH97Zu4MlK3/JFdoszZPcqMKhBp3q6mcjtaN2FCC
         DA3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=74ekQLUlOcUHWDfNU+9U1KuKKcCpv3glEkmfGQfN1Vg=;
        b=lzMAaC6MyUdWr/Xwmzm0mJgj/pM1/u4KtL50vObHFtzGXLU1Z+OJsoLIdCWLee+LkN
         3tlx9JmzAjXRc3ypwB2B4aPK4WDc1+fzNwRwaqdv8xC9BIxl7MvgF0NXxoXKNIRHhr6E
         4aCfGbS24OSFRI8mWejUYOGSwvKI4oUQjVYdhJNnkFbL2MkwWCW2QFJRAaaWW4mJwQDX
         vjG93p+y+HmbiCg4QU4+jicdRykzC7gXWrIlL0We4nHVo+zrX3paxcZzdcdnBZb7NS/t
         iz5rfcq7rhL77oTeSSW3/eGZeOdSeBtxfMiEqYY3pX3t3tBxH4qyaefzO+7t4O2odtFt
         YvXg==
X-Gm-Message-State: APjAAAUXpTWd6z6zYjkI/ApJQIKyBlgGh+vS3DTYrcLn1HoT0IsOuhyy
        hLv/0PR+46aosiqY4aCYhvZiy40=
X-Google-Smtp-Source: APXvYqxSVsKsmpR36+lcf2MCEvIWuy1Ov0lc0DFVnJpwwpuEFGgum/0G7E+VJHWGd6QT3T75nVfZbt8=
X-Received: by 2002:a65:6288:: with SMTP id f8mr23574580pgv.292.1563208810662;
 Mon, 15 Jul 2019 09:40:10 -0700 (PDT)
Date:   Mon, 15 Jul 2019 09:39:56 -0700
In-Reply-To: <20190715163956.204061-1-sdf@google.com>
Message-Id: <20190715163956.204061-6-sdf@google.com>
Mime-Version: 1.0
References: <20190715163956.204061-1-sdf@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH bpf 5/5] bpf: sync bpf.h to tools/
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>, Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Update bpf_sock_addr comments to indicate support for 8-byte reads
from user_ip6 and msg_src_ip6.

Cc: Yonghong Song <yhs@fb.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/include/uapi/linux/bpf.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index f506c68b2612..1f61374fcf81 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -3245,7 +3245,7 @@ struct bpf_sock_addr {
 	__u32 user_ip4;		/* Allows 1,2,4-byte read and 4-byte write.
 				 * Stored in network byte order.
 				 */
-	__u32 user_ip6[4];	/* Allows 1,2,4-byte read and 4,8-byte write.
+	__u32 user_ip6[4];	/* Allows 1,2,4,8-byte read and 4,8-byte write.
 				 * Stored in network byte order.
 				 */
 	__u32 user_port;	/* Allows 4-byte read and write.
@@ -3257,7 +3257,7 @@ struct bpf_sock_addr {
 	__u32 msg_src_ip4;	/* Allows 1,2,4-byte read and 4-byte write.
 				 * Stored in network byte order.
 				 */
-	__u32 msg_src_ip6[4];	/* Allows 1,2,4-byte read and 4,8-byte write.
+	__u32 msg_src_ip6[4];	/* Allows 1,2,4,8-byte read and 4,8-byte write.
 				 * Stored in network byte order.
 				 */
 	__bpf_md_ptr(struct bpf_sock *, sk);
-- 
2.22.0.510.g264f2c817a-goog

