Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF4D304CB3
	for <lists+bpf@lfdr.de>; Tue, 26 Jan 2021 23:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbhAZWxT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Jan 2021 17:53:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389662AbhAZSiW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Jan 2021 13:38:22 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9863CC0617AA
        for <bpf@vger.kernel.org>; Tue, 26 Jan 2021 10:36:08 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id c12so17579477wrc.7
        for <bpf@vger.kernel.org>; Tue, 26 Jan 2021 10:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NmVEUkooFz5Tfz1+fj+rLfrC74ZA/wXoG61R5qDLmbU=;
        b=DVbwGC8thxi+LMqdMJaD5FDz+72wUPoAX9YrH2g8z65x+Y/7wxfxy+7jVJZ0LnlQfl
         6TGvJhHAZtPCuzaw9l1U4g2fTEkckLxTLtMIG5qLTq8pL3p66gRZwfPzdrsrYTP6o4bp
         9C2ZIZVOzaoNja8akpTcC9Rt20vjoG1A512BA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NmVEUkooFz5Tfz1+fj+rLfrC74ZA/wXoG61R5qDLmbU=;
        b=h7lU4Z2c3+2M3rir4DHw25Crz5vz0gY5gGAgnKu2f3QxGY4Re6lca8fdXYzVcCW0M5
         JQnAdJ7rojE+AsdNht5LnA1g0ZvK8hIsKaFMu3eCceb+KujHkv1VtsleeNNFmgwSpG5C
         t3wv0zkFiyBBrT2dpfE4nghOlQq8mEPNIENJAePY/K4N5HkvxQ0dtig30Kztnoqv1rmg
         EKjSD9a6iYqsPQU4NsaYOz4MbJ5izGNYq3yOINiBVIU5bUbacs71iPqcbs5QPYfJG4dl
         bGEeoHQlogTDmtvgq9cQ/98+zXpa2exgOgQL04v1xAJ1chCdYlFFyEiMZfO/8BwJT94w
         QWyA==
X-Gm-Message-State: AOAM531ducqZojBNHm+l1Jqnr8gfeTdmdUx2kAL3cvjvQn+ZRw3KNnyK
        t7mE0FOnvfHV9L+5VEWUzREvkjxsEbKoOA==
X-Google-Smtp-Source: ABdhPJzXdwv/c9GLOmKOtZ+ecBeub/zi4Knq2tTYbBTvcCvgxl0qC5VJ3WgT2IULsq08r4A6ADxHQg==
X-Received: by 2002:a5d:47a2:: with SMTP id 2mr7499442wrb.393.1611686167020;
        Tue, 26 Jan 2021 10:36:07 -0800 (PST)
Received: from revest.zrh.corp.google.com ([2a00:79e0:42:204:deb:d0ec:3143:2380])
        by smtp.gmail.com with ESMTPSA id d13sm28339354wrx.93.2021.01.26.10.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 10:36:06 -0800 (PST)
From:   Florent Revest <revest@chromium.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kpsingh@chromium.org, linux-kernel@vger.kernel.org,
        Florent Revest <revest@chromium.org>,
        KP Singh <kpsingh@kernel.org>
Subject: [PATCH bpf-next v6 1/5] bpf: Be less specific about socket cookies guarantees
Date:   Tue, 26 Jan 2021 19:35:55 +0100
Message-Id: <20210126183559.1302406-1-revest@chromium.org>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
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
2.30.0.280.ga3ce27912f-goog

