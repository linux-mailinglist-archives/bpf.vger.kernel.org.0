Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 714441EEEA6
	for <lists+bpf@lfdr.de>; Fri,  5 Jun 2020 02:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbgFEAIk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Jun 2020 20:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbgFEAIj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Jun 2020 20:08:39 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0BE0C08C5C0
        for <bpf@vger.kernel.org>; Thu,  4 Jun 2020 17:08:39 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id g3so7830789ilq.10
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2020 17:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3nsS425mZ4kAV1jJ2Ue+EXQKEhdGTmch0hxyar7fEqw=;
        b=aIp4AjO3APgHdGwcF5DYiza1QilZkcIZcBEP6XNkoWUtaQz+Eetwch3Xc05x1jBBdJ
         jgWB4kLAaMNJSDY1cKqXRaRdB5Xy7f42IT8TMtX+t8ALTelElG/IlA+9s/9fBwecSKHu
         GZUvkT3ol0qyY/wRg6SSwAENwg6hU0Wlsw+eW2I2mG4jvIWXmOevhf3O8t4KsRwdrfWE
         XTGdfAh35hO/6tUStfVXmTqnnprtCU74Y0YS7wBksiyxKJzVWGzMfBKcoSi4nUXVaKdY
         JaL3CtA+M7lhpsz3dXJMq2S2YPLa5/6cnQh4O5x7WnaP4azejalQIyOfkBifnIpUP/Tx
         we8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3nsS425mZ4kAV1jJ2Ue+EXQKEhdGTmch0hxyar7fEqw=;
        b=S8S9FS2COPZG8RA1X4YWqilsJqpBJ1Ezv/uEk/jUoyN/4Jwlo848AwI+6us+90a3Z9
         4+weS6TwiEr++GyV/8d5/knbpJuR1/90NQiQyl/rtttJ5x7ZVkoiItW5mDzYCj2vNwpH
         zW8WvojBh8BWBj5pu9e8OrkhLDNPPoJDFtMPViCE0h3M9lWd0Zwt0tYGFh6hLEGbGimI
         7P9ON9JDKpzEXIlMwijhDlF2p1aeBdbDzw4FaYmg2fELTqGdGAlWJPHysPhjNi2H2/RD
         iJMLbxzCz9jQ4mNaHJE3mSxjoiUTOeQtSXgbqTADntz5akxRNCIMR9M4vY6HFyImQftZ
         JbEA==
X-Gm-Message-State: AOAM533F9d1EffFlNZ4vS5Ipaq3QY2ILulewiE449UnTh2ZhWXs8AzVH
        vm4/o9bOCDMkR80tfCBT2tWyiJenglqn1Q==
X-Google-Smtp-Source: ABdhPJw0Tn4eGUtY/dCUojNdstuhCdJai2JIZhYTLAnePGM5QmvZRGcOHUkx1iHF9PTloKz5DviIpg==
X-Received: by 2002:a05:6e02:591:: with SMTP id c17mr5829781ils.155.1591315718779;
        Thu, 04 Jun 2020 17:08:38 -0700 (PDT)
Received: from localhost.localdomain (host-173-230-99-2.tnkngak.clients.pavlovmedia.com. [173.230.99.2])
        by smtp.gmail.com with ESMTPSA id y3sm557661ioy.40.2020.06.04.17.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 17:08:38 -0700 (PDT)
From:   YiFei Zhu <zhuyifei1999@gmail.com>
X-Google-Original-From: YiFei Zhu <zhuyifei@google.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        YiFei Zhu <zhuyifei@google.com>
Subject: [PATCH bpf 1/2] net/filter: Permit reading NET in load_bytes_relative when MAC not set
Date:   Thu,  4 Jun 2020 19:07:38 -0500
Message-Id: <4f13798ae41986f8fe8a6f8698c7cbeaefba93b0.1591315176.git.zhuyifei@google.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1591315176.git.zhuyifei@google.com>
References: <cover.1591315176.git.zhuyifei@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Added a check in the switch case on start_header that checks for
the existence of the header, and in the case that MAC is not set
and the caller requests for MAC, -EFAULT. If the caller requests
for NET then MAC's existence is completely ignored.

There is no function to check NET header's existence and as far
as cgroup_skb/egress is concerned it should always be set.

Removed for ptr >= the start of header, considering offset is
bounded unsigned and should always be true. ptr + len <= end is
overflow-unsafe and replaced with len <= end - ptr, and
len <= end - mac is redundant to this condition.

Fixes: 3eee1f75f2b9 ("bpf: fix bpf_skb_load_bytes_relative pkt length check")
Reviewed-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: YiFei Zhu <zhuyifei@google.com>
---
 net/core/filter.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index d01a244b5087..d3e8445b5494 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -1755,25 +1755,27 @@ BPF_CALL_5(bpf_skb_load_bytes_relative, const struct sk_buff *, skb,
 	   u32, offset, void *, to, u32, len, u32, start_header)
 {
 	u8 *end = skb_tail_pointer(skb);
-	u8 *net = skb_network_header(skb);
-	u8 *mac = skb_mac_header(skb);
-	u8 *ptr;
+	u8 *start, *ptr;
 
-	if (unlikely(offset > 0xffff || len > (end - mac)))
+	if (unlikely(offset > 0xffff))
 		goto err_clear;
 
 	switch (start_header) {
 	case BPF_HDR_START_MAC:
-		ptr = mac + offset;
+		if (unlikely(!skb_mac_header_was_set(skb)))
+			goto err_clear;
+		start = skb_mac_header(skb);
 		break;
 	case BPF_HDR_START_NET:
-		ptr = net + offset;
+		start = skb_network_header(skb);
 		break;
 	default:
 		goto err_clear;
 	}
 
-	if (likely(ptr >= mac && ptr + len <= end)) {
+	ptr = start + offset;
+
+	if (likely(len <= end - ptr)) {
 		memcpy(to, ptr, len);
 		return 0;
 	}
-- 
2.27.0

