Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47D302D433D
	for <lists+bpf@lfdr.de>; Wed,  9 Dec 2020 14:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbgLIN3W (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Dec 2020 08:29:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732310AbgLIN1V (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Dec 2020 08:27:21 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E57C0613D6
        for <bpf@vger.kernel.org>; Wed,  9 Dec 2020 05:26:40 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id a3so1665328wmb.5
        for <bpf@vger.kernel.org>; Wed, 09 Dec 2020 05:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4DYUQu0RnUP+8Pjc8kSEgv+OIMP/f6lYTVbWVeSCUVU=;
        b=cUVqsj5LFdc+s2n2frLO3T8S38RQsoBLeYHX17kARTFQTCge3mWtrw2y4Fax8dMg4m
         xzZldvYLG8rhEQg+Ix+NJOhdwlSXZM/ngCJMgA5oEuWDYfqMW5nZPKFbX9ItrjzeBmpf
         OHBBK6ogpwYle2XEzAhaKeA3kXmwNkwURGvWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4DYUQu0RnUP+8Pjc8kSEgv+OIMP/f6lYTVbWVeSCUVU=;
        b=NFqzTHozy8/ZXTTpkA93dg69UQyN1XuiHlmFhQxttRQMQgeG3QYJtdp1zgjZqly+2T
         2fqhZxko1XmQLmmwY4fySjqApq2l71Z8MuEuQcLHghYx33cyrxTftG5TH8cTqXIBOEFm
         HG0rVnhQLiJ8vhhtH2Co0QaUER9XZerMcnYypf7ODyc04G4SuRHwndcaP32b1A0xJ76H
         /XTAVwCib4MjCd+uc/KYHa73QwvqeZRvVmNIglJS5ZvSqDBU6DCX9BTyywzElUn/6EDv
         uBwmbxDGZF4pAn0M8pl8XDic52JB8nzr0x5Umc6HsCxhAJ83bMTWFVb6i8Y6UTpknMTd
         7onA==
X-Gm-Message-State: AOAM533xX31TgT585NpKd0hy+5bRytWPk1lMlrk0oUOEKXvIby7VgR6o
        dSwktb+ScCIKAqUeEzXQkg1/e6dUvuIdGg==
X-Google-Smtp-Source: ABdhPJwLBziMD/Ljjjw3q8OIMyTD0saGfmpzb1kCQxNpJdFatuw4VS2TS2f98pqGUZQx1/zoYy6KHw==
X-Received: by 2002:a7b:c205:: with SMTP id x5mr2903826wmi.115.1607520399095;
        Wed, 09 Dec 2020 05:26:39 -0800 (PST)
Received: from revest.zrh.corp.google.com ([2a00:79e0:42:204:f693:9fff:fef4:a569])
        by smtp.gmail.com with ESMTPSA id t16sm3631490wri.42.2020.12.09.05.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 05:26:38 -0800 (PST)
From:   Florent Revest <revest@chromium.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kpsingh@chromium.org, kafai@fb.com, linux-kernel@vger.kernel.org,
        Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next v4 1/4] bpf: Be less specific about socket cookies guarantees
Date:   Wed,  9 Dec 2020 14:26:33 +0100
Message-Id: <20201209132636.1545761-1-revest@chromium.org>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Since "92acdc58ab11 bpf, net: Rework cookie generator as per-cpu one"
socket cookies are not guaranteed to be non-decreasing. The
bpf_get_socket_cookie helper descriptions are currently specifying that
cookies are non-decreasing but we don't want users to rely on that.

Reported-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Florent Revest <revest@chromium.org>
---
 include/uapi/linux/bpf.h       | 8 ++++----
 tools/include/uapi/linux/bpf.h | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 30b477a26482..ba59309f4d18 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1650,22 +1650,22 @@ union bpf_attr {
  * 		networking traffic statistics as it provides a global socket
  * 		identifier that can be assumed unique.
  * 	Return
- * 		A 8-byte long non-decreasing number on success, or 0 if the
- * 		socket field is missing inside *skb*.
+ * 		A 8-byte long unique number on success, or 0 if the socket
+ * 		field is missing inside *skb*.
  *
  * u64 bpf_get_socket_cookie(struct bpf_sock_addr *ctx)
  * 	Description
  * 		Equivalent to bpf_get_socket_cookie() helper that accepts
  * 		*skb*, but gets socket from **struct bpf_sock_addr** context.
  * 	Return
- * 		A 8-byte long non-decreasing number.
+ * 		A 8-byte long unique number.
  *
  * u64 bpf_get_socket_cookie(struct bpf_sock_ops *ctx)
  * 	Description
  * 		Equivalent to **bpf_get_socket_cookie**\ () helper that accepts
  * 		*skb*, but gets socket from **struct bpf_sock_ops** context.
  * 	Return
- * 		A 8-byte long non-decreasing number.
+ * 		A 8-byte long unique number.
  *
  * u32 bpf_get_socket_uid(struct sk_buff *skb)
  * 	Return
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 30b477a26482..ba59309f4d18 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1650,22 +1650,22 @@ union bpf_attr {
  * 		networking traffic statistics as it provides a global socket
  * 		identifier that can be assumed unique.
  * 	Return
- * 		A 8-byte long non-decreasing number on success, or 0 if the
- * 		socket field is missing inside *skb*.
+ * 		A 8-byte long unique number on success, or 0 if the socket
+ * 		field is missing inside *skb*.
  *
  * u64 bpf_get_socket_cookie(struct bpf_sock_addr *ctx)
  * 	Description
  * 		Equivalent to bpf_get_socket_cookie() helper that accepts
  * 		*skb*, but gets socket from **struct bpf_sock_addr** context.
  * 	Return
- * 		A 8-byte long non-decreasing number.
+ * 		A 8-byte long unique number.
  *
  * u64 bpf_get_socket_cookie(struct bpf_sock_ops *ctx)
  * 	Description
  * 		Equivalent to **bpf_get_socket_cookie**\ () helper that accepts
  * 		*skb*, but gets socket from **struct bpf_sock_ops** context.
  * 	Return
- * 		A 8-byte long non-decreasing number.
+ * 		A 8-byte long unique number.
  *
  * u32 bpf_get_socket_uid(struct sk_buff *skb)
  * 	Return
-- 
2.29.2.576.ga3fc446d84-goog

