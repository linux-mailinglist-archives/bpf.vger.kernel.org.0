Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A25C0DFDF
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2019 11:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbfD2Jw4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Apr 2019 05:52:56 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40030 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727800AbfD2Jwr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Apr 2019 05:52:47 -0400
Received: by mail-wr1-f66.google.com with SMTP id h4so15061824wre.7
        for <bpf@vger.kernel.org>; Mon, 29 Apr 2019 02:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tv8ecTyhcL3Z+2NSBu2JHftiHPMgWFdUmca/m77pSlY=;
        b=hwpQ0zLyGrp8uf4LlGrgPAPjWUmuGeNWiPWk5/Pt6y5HOHMgb2Nrp0SUr6ShXIj1e4
         K8tF7bsGDSHX2IDgBtxJLB4/HTUu6mDBmEr+skfHvHl3IseR7UD7/xf/eWi94kurRDsg
         VNn6aBynG8ktmbuMqYro5pIS0TY3c8OE3lOkWJI0KWxoBCazG1apS3w1V6PmFVrRcxlT
         kmMf6E9viOhMl8TYe4fyhNnPhBvTCkyEMgYiWINIwa7sx3SEEgfEY//8xadETjwvWTgo
         clXjQL6ZJzszEUzacf/BV1K+0S2Wf/4iO1wFoxz3GBpQUDDjClXxdB62rI2wT/gpyxDA
         +vlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tv8ecTyhcL3Z+2NSBu2JHftiHPMgWFdUmca/m77pSlY=;
        b=ulI+2To5hkGTxTmyoeK5S7xlfZzAyBuoqgD2/k/wfZ5aG4WRwzROEEC1UoRJrAlGTn
         iclFX+p7pv68gR/SJLEW2AHfLf1daAm+lXKNZ460fX8sfvgNaOFD1bB9nIQwOC/+hL99
         mg12MG2C6NS2obeaDC77PwMNXHmhRkTuSMHXszvV0crCRdmun5BtPfVK6XggZ6WubTOk
         Fe+cvgvoJcAzBpu+a7Knia4Vo+G2+9ce6ksRvs8D6mhNQ4IuJyPcnmYJI9j7OTS91Xnh
         SQx4yoARsGkWrTKH/is8kLt6iI/Q1aj2J0BjNVWre9nNhMlxvkgJKMc7McgnRzeb0b/l
         GuZg==
X-Gm-Message-State: APjAAAV+WdaJ4/VwC5eWS1no1x2YU2FKztUnMN+dPAWMo+pcARsG5RlR
        DiZlwTX05Y1UqTkTh1tOE0XMglPeAmfo/w==
X-Google-Smtp-Source: APXvYqyCrk1XrgS8M4Cc3qBZpHbjjfEx5TjOqBvq1sQCMtbfg5vUv/h9zFy+GPXHSq09T8oEKYM4dA==
X-Received: by 2002:a05:6000:18b:: with SMTP id p11mr182875wrx.292.1556531565443;
        Mon, 29 Apr 2019 02:52:45 -0700 (PDT)
Received: from cbtest32.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id x20sm11241535wrg.29.2019.04.29.02.52.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 02:52:44 -0700 (PDT)
From:   Quentin Monnet <quentin.monnet@netronome.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com,
        Quentin Monnet <quentin.monnet@netronome.com>
Subject: [PATCH bpf-next 4/6] bpf: make BPF_LOG_* flags available in UAPI header
Date:   Mon, 29 Apr 2019 10:52:25 +0100
Message-Id: <20190429095227.9745-5-quentin.monnet@netronome.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190429095227.9745-1-quentin.monnet@netronome.com>
References: <20190429095227.9745-1-quentin.monnet@netronome.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The kernel verifier combines several flags to select what kind of logs
to print to the log buffer provided by users.

In order to make it easier to provide the relevant flags, move the
related #define-s to the UAPI header, so that applications can set for
example: attr->log_level = BPF_LOG_LEVEL1 | BPF_LOG_STATS.

Signed-off-by: Quentin Monnet <quentin.monnet@netronome.com>
Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
---
 include/linux/bpf_verifier.h | 3 ---
 include/uapi/linux/bpf.h     | 5 +++++
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 1305ccbd8fe6..8160a4bb7ad9 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -253,9 +253,6 @@ static inline bool bpf_verifier_log_full(const struct bpf_verifier_log *log)
 	return log->len_used >= log->len_total - 1;
 }
 
-#define BPF_LOG_LEVEL1	1
-#define BPF_LOG_LEVEL2	2
-#define BPF_LOG_STATS	4
 #define BPF_LOG_LEVEL	(BPF_LOG_LEVEL1 | BPF_LOG_LEVEL2)
 #define BPF_LOG_MASK	(BPF_LOG_LEVEL | BPF_LOG_STATS)
 
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 72336bac7573..f8e3e764aff4 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -335,6 +335,11 @@ struct bpf_stack_build_id {
 	};
 };
 
+/* verifier log_level values for loading programs, can be combined */
+#define BPF_LOG_LEVEL1	1
+#define BPF_LOG_LEVEL2	2
+#define BPF_LOG_STATS	4
+
 union bpf_attr {
 	struct { /* anonymous struct used by BPF_MAP_CREATE command */
 		__u32	map_type;	/* one of enum bpf_map_type */
-- 
2.17.1

