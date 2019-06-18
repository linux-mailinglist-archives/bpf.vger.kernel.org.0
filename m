Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6464A157
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2019 15:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725919AbfFRNA7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Jun 2019 09:00:59 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39376 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbfFRNA7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Jun 2019 09:00:59 -0400
Received: by mail-lj1-f195.google.com with SMTP id v18so13035040ljh.6
        for <bpf@vger.kernel.org>; Tue, 18 Jun 2019 06:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fyxRHAwiW1X+AdyTZC4hhjZjc3nc+3Iv3di3JvLFcQU=;
        b=vPXWGUAziHI6OmtFWH7I43Z2cnFeQ1tCM9JgWySko4/RP6bnWfxujQNZz3qHPIcPsu
         LOUylHkuUjqF+6f/DMvebK6+td7+ZQ9DVkh/fS4pHyBf66SMNoRueU7DoX7yiVXmJxyk
         ewQt1421rY/+1kGXiVgF8fn+9pEV9D1OD/N2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fyxRHAwiW1X+AdyTZC4hhjZjc3nc+3Iv3di3JvLFcQU=;
        b=tLQMjioq25JJnE6rEvKpqooVwTlmVoJB6XI7sNcO+zBczrkRR59KkTkU3+oXlfqoAl
         4li4Or05LOUnOoepmO9X+QElyKY/DdkOqz4oKm6/6HfdRZZe4ZrHr9/MZhJtGPTWxOPU
         tA7wHopv6OOghE/+wSMM5zvSbXGSfA5tZrKmr1bPm76+Vy/pL40774t09YtcEEOZZbuS
         pcPnckDF6AYSzckg0wTvjVKCf6JKsEilN0QiIYshECKf3CqgqHokwtWBhBlfdjjGmj2Z
         jZS9moA0QMh+P4g1ZEXhDThGsG8P6O/Wa2v1T5wK3lYDnnhPaP6cgNmV5vol+FnTRGqq
         +igw==
X-Gm-Message-State: APjAAAUWGFhgZnXG+prRfQrMWU07wZC56g9fCfbPQHIDSqKeAi+LQpuu
        vQBk7BhXoK+FPPi/LgEvRTohA2dQLEx0fg==
X-Google-Smtp-Source: APXvYqxHHc/J1lzFC6ni6K8Qnt0cLje9z/7OX1DkHv6EVQtmWbFzBu5ZZjw5C5IukhY2k2CADEfsaw==
X-Received: by 2002:a2e:760f:: with SMTP id r15mr46748015ljc.18.1560862857192;
        Tue, 18 Jun 2019 06:00:57 -0700 (PDT)
Received: from cloudflare.com ([176.221.114.230])
        by smtp.gmail.com with ESMTPSA id u22sm2880369ljd.18.2019.06.18.06.00.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 06:00:56 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     kernel-team@cloudflare.com
Subject: [RFC bpf-next 4/7] bpf: Sync linux/bpf.h to tools/
Date:   Tue, 18 Jun 2019 15:00:47 +0200
Message-Id: <20190618130050.8344-5-jakub@cloudflare.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190618130050.8344-1-jakub@cloudflare.com>
References: <20190618130050.8344-1-jakub@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Newly added program and context type is needed for tests in subsequent
patches.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 tools/include/uapi/linux/bpf.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index d0a23476f887..7776f36a43d1 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -170,6 +170,7 @@ enum bpf_prog_type {
 	BPF_PROG_TYPE_FLOW_DISSECTOR,
 	BPF_PROG_TYPE_CGROUP_SYSCTL,
 	BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE,
+	BPF_PROG_TYPE_INET_LOOKUP,
 };
 
 enum bpf_attach_type {
@@ -192,6 +193,7 @@ enum bpf_attach_type {
 	BPF_LIRC_MODE2,
 	BPF_FLOW_DISSECTOR,
 	BPF_CGROUP_SYSCTL,
+	BPF_INET_LOOKUP,
 	__MAX_BPF_ATTACH_TYPE
 };
 
@@ -3066,6 +3068,31 @@ struct bpf_tcp_sock {
 				 */
 };
 
+/* User accessible data for inet_lookup programs.
+ * New fields must be added at the end.
+ */
+struct bpf_inet_lookup {
+	__u32 family;
+	__u32 remote_ip4;	/* Allows 1,2,4-byte read but no write.
+				 * Stored in network byte order.
+				 */
+	__u32 local_ip4;	/* Allows 1,2,4-byte read and 4-byte write.
+				 * Stored in network byte order.
+				 */
+	__u32 remote_ip6[4];	/* Allows 1,2,4-byte read but no write.
+				 * Stored in network byte order.
+				 */
+	__u32 local_ip6[4];	/* Allows 1,2,4-byte read and 4-byte write.
+				 * Stored in network byte order.
+				 */
+	__u32 remote_port;	/* Allows 4-byte read but no write.
+				 * Stored in network byte order.
+				 */
+	__u32 local_port;	/* Allows 4-byte read and write.
+				 * Stored in host byte order.
+				 */
+};
+
 struct bpf_sock_tuple {
 	union {
 		struct {
-- 
2.20.1

