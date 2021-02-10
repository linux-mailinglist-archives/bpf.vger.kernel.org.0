Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 075D73164FA
	for <lists+bpf@lfdr.de>; Wed, 10 Feb 2021 12:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbhBJLSO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Feb 2021 06:18:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbhBJLQI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Feb 2021 06:16:08 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84CB8C061788
        for <bpf@vger.kernel.org>; Wed, 10 Feb 2021 03:14:35 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 190so1490458wmz.0
        for <bpf@vger.kernel.org>; Wed, 10 Feb 2021 03:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2HfhdmfvOgq9lw3xcT/xxXPNvZM03QWegWlJQ7ILwdM=;
        b=b1RVOifMLqgF+xPx8yG8p603Y6/Sz0aniLxmG2yNZcTZ/lDw4oXU6M3O0oWOey50+T
         FgtNrnzesZgorRpJv2DVtfOjJer7+4y76c/rhhZHq4lioA0ZuzcBUXFMf4020TKgD62S
         cnBvMMLaABgh4TFxINfut8f0P6Cu33eOB+A4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2HfhdmfvOgq9lw3xcT/xxXPNvZM03QWegWlJQ7ILwdM=;
        b=iJ33aGsxTmUOi6OBOXbGU3z6CSxvyw+Yv7lvuncjvEV5hY6bKwfRqddi/XMsQRRNlz
         9Isi9B3Dsf/8W8xfG0/xxgmN/IbAIpSZsnM62O4nWxRcqGVABX0eicJ102H8SMyUkuXB
         j9kypLw04Hnfvw+qOLakeY1EpLbKcdPMLYmp4MaqeFBRJtLG7mhXCkX6GlS4ASO6WFyP
         yQIeN5BR+IVHH7mo4kL+0ZiW+Q/iW9kdL7TMZg8SaxtAAhzi42i9tOZoTCjQ0EVO6/ni
         0KKlsATlecX10GxDz5WvU6S0NMUWzpiMK+gOksllCEL2uyxndLB+1nDUg50AL0Mnv06/
         /vuA==
X-Gm-Message-State: AOAM532HSUSJotdUfXjzxtOmp9+u7hGPuFqGnGXwWvo7lA/3Px+QBnK+
        zIVpIXKZCPvl8V1JLx0uz6rdErUD2sH8Rg==
X-Google-Smtp-Source: ABdhPJyVwY4QAXNshKF1OGziENeIbZjBlRza7h0RrU1LeBNb+XQANWcZS3c/jgs2bZF6FDWfZc6D9w==
X-Received: by 2002:a7b:c304:: with SMTP id k4mr2434360wmj.11.1612955673931;
        Wed, 10 Feb 2021 03:14:33 -0800 (PST)
Received: from revest.zrh.corp.google.com ([2a00:79e0:42:204:31ae:b3c8:8fe:5f4d])
        by smtp.gmail.com with ESMTPSA id u10sm1907633wmj.40.2021.02.10.03.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 03:14:33 -0800 (PST)
From:   Florent Revest <revest@chromium.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kpsingh@chromium.org, revest@google.com, jackmanb@chromium.org,
        linux-kernel@vger.kernel.org, Florent Revest <revest@chromium.org>,
        KP Singh <kpsingh@kernel.org>
Subject: [PATCH bpf-next v7 1/5] bpf: Be less specific about socket cookies guarantees
Date:   Wed, 10 Feb 2021 12:14:02 +0100
Message-Id: <20210210111406.785541-1-revest@chromium.org>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
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
Acked-by: KP Singh <kpsingh@kernel.org>
---
 include/uapi/linux/bpf.h       | 8 ++++----
 tools/include/uapi/linux/bpf.h | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index c001766adcbc..0b735c2729b2 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1656,22 +1656,22 @@ union bpf_attr {
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
index c001766adcbc..0b735c2729b2 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1656,22 +1656,22 @@ union bpf_attr {
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
2.30.0.478.g8a0d178c01-goog

