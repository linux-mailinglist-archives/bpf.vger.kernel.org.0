Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A598C3B7817
	for <lists+bpf@lfdr.de>; Tue, 29 Jun 2021 20:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234139AbhF2S6z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Jun 2021 14:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234462AbhF2S6y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Jun 2021 14:58:54 -0400
Received: from mail-oi1-x261.google.com (mail-oi1-x261.google.com [IPv6:2607:f8b0:4864:20::261])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2903BC061760
        for <bpf@vger.kernel.org>; Tue, 29 Jun 2021 11:56:26 -0700 (PDT)
Received: by mail-oi1-x261.google.com with SMTP id 11so19248099oid.3
        for <bpf@vger.kernel.org>; Tue, 29 Jun 2021 11:56:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:dkim-signature:from:to:cc:subject:date
         :message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=f4RAwyWTbhg/JBouKyV5cQzSEVBMedBjqRtcEsYMTJA=;
        b=p/5KwrcAoPEpCQ0SvojbK610iKHf0EkqtHuUgnf4kPjRs4PgyEuykbQupJuMRnNLSm
         TqMKF2vup7n2TTIYHYjZUNkENWxjjEe3ER0gbtakEXcTXIsdY4bRwluUCErV8Kms/1tq
         3P1xjzrJy56pbGsY5W1QFprdPiZZG/0XtDb+i6aQudDqmiTNV0T9Pl2cj9Xk1ZnqSkdr
         izCpZ/l7nIzJHRuL5bs7vvfkpTFUE9w5oEVrhjH+Hdz/VgkVoDJdvZnZGB9n8JY1Ael4
         5I3CkRF6xVcd7Y+AQP5OtTZHkNwFjvTBKPEG9U3peErHjpc3y2UXeImxS85F1YPD39gz
         UIBQ==
X-Gm-Message-State: AOAM533LsgyMyIQMTwNTbxa9lazz5OtiP9Qmqq6QvvLPakob7pLmSOS5
        erhtIOC4lkSkCv4lNVyfS8zFCYBgPUNXkOkGCfJf7v9UgDImjQ==
X-Google-Smtp-Source: ABdhPJyxEW4hgMX1Rt0d77GBEOxHSFpSK+zEXE0Elwf1J0YTSPwFt8u6NP4fB7pqnpuCPl7qi90HN2typsA5
X-Received: by 2002:aca:4b10:: with SMTP id y16mr249067oia.98.1624992985593;
        Tue, 29 Jun 2021 11:56:25 -0700 (PDT)
Received: from restore.menlosecurity.com ([13.56.32.60])
        by smtp-relay.gmail.com with ESMTPS id e22sm6927256oop.4.2021.06.29.11.56.24
        for <bpf@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jun 2021 11:56:25 -0700 (PDT)
X-Relaying-Domain: menlosecurity.com
Received: from safemail-prod-02790022cr-re.menlosecurity.com (13.56.32.61)
    by restore.menlosecurity.com (13.56.32.60)
    with SMTP id b3c98c10-d90b-11eb-8d46-f1832bde6be8;
    Tue, 29 Jun 2021 18:56:25 GMT
Received: from mail-pj1-f70.google.com (209.85.216.70)
    by safemail-prod-02790022cr-re.menlosecurity.com (13.56.32.61)
    with SMTP id b3c98c10-d90b-11eb-8d46-f1832bde6be8;
    Tue, 29 Jun 2021 18:56:25 GMT
Received: by mail-pj1-f70.google.com with SMTP id g1-20020a17090a6401b029016fc0723657so124246pjj.4
        for <bpf@vger.kernel.org>; Tue, 29 Jun 2021 11:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=menlosecurity.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f4RAwyWTbhg/JBouKyV5cQzSEVBMedBjqRtcEsYMTJA=;
        b=c5wZYLXXzHT9R2rhr0Lv0BwG3VRwOGZrQ1b49H0g9doLX3o24TFupvt7dFGH6p1OMs
         NnLDIaqwxvlFbqhLaGc6ZRREop8ps4HkvJgQK0LFR+ZMPtRutGsu25aEw71Eic77nSDC
         VrsKuVVsumFpUsKYIn0PnRAz9S/QFD2Z1jpXQ=
X-Received: by 2002:a63:5a56:: with SMTP id k22mr29931061pgm.169.1624992984204;
        Tue, 29 Jun 2021 11:56:24 -0700 (PDT)
X-Received: by 2002:a63:5a56:: with SMTP id k22mr29931041pgm.169.1624992984006;
        Tue, 29 Jun 2021 11:56:24 -0700 (PDT)
Received: from localhost.localdomain ([12.219.129.130])
        by smtp.googlemail.com with ESMTPSA id t14sm19641260pfe.45.2021.06.29.11.56.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jun 2021 11:56:23 -0700 (PDT)
From:   Rumen Telbizov <rumen.telbizov@menlosecurity.com>
To:     bpf@vger.kernel.org
Cc:     dsahern@gmail.com, David Ahern <dsahern@kernel.org>,
        Rumen Telbizov <rumen.telbizov@menlosecurity.com>
Subject: [PATCH 2/3] tools: Update bpf header
Date:   Tue, 29 Jun 2021 11:55:36 -0700
Message-Id: <20210629185537.78008-3-rumen.telbizov@menlosecurity.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210629185537.78008-1-rumen.telbizov@menlosecurity.com>
References: <20210629185537.78008-1-rumen.telbizov@menlosecurity.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: David Ahern <dsahern@kernel.org>

Update bpf header under tools to bring in the bpf_fib_lookup
struct changes.

Signed-off-by: Rumen Telbizov <rumen.telbizov@menlosecurity.com>
---
 tools/include/uapi/linux/bpf.h | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index ec6d85a81744..6c78cc9c3c75 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5925,8 +5925,20 @@ struct bpf_fib_lookup {
 	/* output */
 	__be16	h_vlan_proto;
 	__be16	h_vlan_TCI;
-	__u8	smac[6];     /* ETH_ALEN */
-	__u8	dmac[6];     /* ETH_ALEN */
+
+	union {
+		/* input */
+		struct {
+			__u32	mark;   /* fwmark for policy routing */
+			/* 2 4-byte holes for input */
+		};
+
+		/* output: source and dest mac */
+		struct {
+			__u8	smac[6];	/* ETH_ALEN */
+			__u8	dmac[6];	/* ETH_ALEN */
+		};
+	};
 };
 
 struct bpf_redir_neigh {
-- 
2.30.1 (Apple Git-130)

