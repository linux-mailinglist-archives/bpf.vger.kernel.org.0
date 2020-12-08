Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8196A2D336C
	for <lists+bpf@lfdr.de>; Tue,  8 Dec 2020 21:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbgLHUSp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Dec 2020 15:18:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726921AbgLHUSV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Dec 2020 15:18:21 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE94C06179C
        for <bpf@vger.kernel.org>; Tue,  8 Dec 2020 12:17:22 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id r3so17567092wrt.2
        for <bpf@vger.kernel.org>; Tue, 08 Dec 2020 12:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4DYUQu0RnUP+8Pjc8kSEgv+OIMP/f6lYTVbWVeSCUVU=;
        b=Ju1Iv18mwNFn5/Ae0cgOxV/JdmXy9QBSzTW0Oe9JMf0CzPCTshUepaM2gQws0xaoj2
         crwmzmb9/Y8RdPwiPxgfd1FYlPaz0VeNwQLo19pmQ0P6kPOvVHlZ5AQlTDima693lkbr
         bEVDG/fMt1zyyk+0CEmy3WthSYSmw3XY+b77o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4DYUQu0RnUP+8Pjc8kSEgv+OIMP/f6lYTVbWVeSCUVU=;
        b=H6kusVshDM0zKzJCGZiOMQvkDV8Jq4E7K5pk17sZ8FAO71TiTou8xqmXJu5owvhC/0
         ovhxdF0OhsD1ReWJFQtUcT2eGggoa4KzmOUOILGdzcnLxleaeh19r7UW1vIgvrMMSZJJ
         o+7db2ytw5Whnzo4JzNTfHciyZSWMv9mYHnEKGYRcsoIw5qANO8w4/rxtcHcXbTKCpfD
         9E+wlnKLieyGdribA0BeDuf9TfGMWMlp0Ryso7WqRUWolWvINJpR/6JFl9hJj3pxebms
         Yse6uwAIhkhaSUj3h4DGsyE0ea2iKCsaPNGw2OpL+LMBRC+erS9Ya/X/fQxRcQNj3EFx
         NcMg==
X-Gm-Message-State: AOAM531kvb7DZm2WTxoBBbb2bIp21VzhQWwtBOHBkyzv+YEIx2hmi6ne
        QhtM2lPgf0xH8EIEE8SrND7okodF8YT58A==
X-Google-Smtp-Source: ABdhPJzeLxBx1FYVODACXoFswCazznolernYwOLBDZOPw1S851jsulvLFFLQBPo5tBUg7WXXopPpcw==
X-Received: by 2002:a5d:4a44:: with SMTP id v4mr18817281wrs.106.1607458641069;
        Tue, 08 Dec 2020 12:17:21 -0800 (PST)
Received: from revest.zrh.corp.google.com ([2a00:79e0:42:204:f693:9fff:fef4:a569])
        by smtp.gmail.com with ESMTPSA id v189sm5312049wmg.14.2020.12.08.12.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 12:17:20 -0800 (PST)
From:   Florent Revest <revest@chromium.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kpsingh@chromium.org, kafai@fb.com, linux-kernel@vger.kernel.org,
        Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next v3 1/4] bpf: Be less specific about socket cookies guarantees
Date:   Tue,  8 Dec 2020 21:15:30 +0100
Message-Id: <20201208201533.1312057-1-revest@chromium.org>
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

