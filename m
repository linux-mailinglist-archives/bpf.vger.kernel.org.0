Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E080C4A15D
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2019 15:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729115AbfFRNBE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Jun 2019 09:01:04 -0400
Received: from mail-lj1-f181.google.com ([209.85.208.181]:43469 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfFRNBB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Jun 2019 09:01:01 -0400
Received: by mail-lj1-f181.google.com with SMTP id 16so13008177ljv.10
        for <bpf@vger.kernel.org>; Tue, 18 Jun 2019 06:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OXRC7kUqjRaCwEb4wkf/WJQfsQbHmGkQk8MkzG7nDWg=;
        b=LWICZYMOa58ip98qcRYJT2pob7UHwwfa5yUOL041MY6lDljQKBV79BFAF2QWTkjXqY
         SyfBEpg0rcM0FFVLMC98CLIPAzFcrFbMWm6yfh1iVIPBwWvOTEdrKQBgTniyjbVnCPwW
         gv/DC278cwtlZdWfO2ulIe+3v+NlRawbh6UWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OXRC7kUqjRaCwEb4wkf/WJQfsQbHmGkQk8MkzG7nDWg=;
        b=krKSjh3RlRRhuaMck0unyBAUBXGvEU5U1NToIJR4UUAMJb8cwozwvACWIw8RrrAs35
         7kELZRfBfe23ziQFltiRoOcFIx50qSkPjS6FakziDiWzytFR2XGztTn2iP18cVdJQ5oX
         RS4X+2Ckng1iODAo+/dMI+JZRER5J5bBWugYQoBs7ud4IvneHJEixB4gg8n8C9xMQJD7
         4m67ZNoouIyoBxleakuFU3Ua6ke0BxZcKyWcn1XAzG6RYDEks//bSM26ucD2v3WDjnDf
         aE2ycnj+4abz/ZKf+YXbIc2WOl/C+4tZm/Uxih7X/M8T6E55CcIgNiqdmu16Whmz6d7H
         nzOQ==
X-Gm-Message-State: APjAAAX48tff9qJFrE0I/wDNcaCdsviHRTmi2TxnQF5qx9RYkr2xCtpa
        LyhTWwdE0lUMvUn0NF+jGWKrzg==
X-Google-Smtp-Source: APXvYqwRD9JWRuCdTkY07FyjPDf3gnbSDyZ54QyNNzy4Nusmygd6pBFXQgQREc3YzIB2ZHwUAeIZPQ==
X-Received: by 2002:a2e:50e:: with SMTP id 14mr44389112ljf.5.1560862858462;
        Tue, 18 Jun 2019 06:00:58 -0700 (PDT)
Received: from cloudflare.com ([176.221.114.230])
        by smtp.gmail.com with ESMTPSA id y62sm2581949lje.100.2019.06.18.06.00.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 06:00:57 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     kernel-team@cloudflare.com
Subject: [RFC bpf-next 5/7] libbpf: Add support for inet_lookup program type
Date:   Tue, 18 Jun 2019 15:00:48 +0200
Message-Id: <20190618130050.8344-6-jakub@cloudflare.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190618130050.8344-1-jakub@cloudflare.com>
References: <20190618130050.8344-1-jakub@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Make libbpf aware of the newly added program type. Reserve a section name
for it.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 tools/lib/bpf/libbpf.c        | 4 ++++
 tools/lib/bpf/libbpf.h        | 2 ++
 tools/lib/bpf/libbpf.map      | 2 ++
 tools/lib/bpf/libbpf_probes.c | 1 +
 4 files changed, 9 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index e725fa86b189..84dfdfc0a971 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -2244,6 +2244,7 @@ static bool bpf_prog_type__needs_kver(enum bpf_prog_type type)
 	case BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE:
 	case BPF_PROG_TYPE_PERF_EVENT:
 	case BPF_PROG_TYPE_CGROUP_SYSCTL:
+	case BPF_PROG_TYPE_INET_LOOKUP:
 		return false;
 	case BPF_PROG_TYPE_KPROBE:
 	default:
@@ -3110,6 +3111,7 @@ BPF_PROG_TYPE_FNS(tracepoint, BPF_PROG_TYPE_TRACEPOINT);
 BPF_PROG_TYPE_FNS(raw_tracepoint, BPF_PROG_TYPE_RAW_TRACEPOINT);
 BPF_PROG_TYPE_FNS(xdp, BPF_PROG_TYPE_XDP);
 BPF_PROG_TYPE_FNS(perf_event, BPF_PROG_TYPE_PERF_EVENT);
+BPF_PROG_TYPE_FNS(inet_lookup, BPF_PROG_TYPE_INET_LOOKUP);
 
 void bpf_program__set_expected_attach_type(struct bpf_program *prog,
 					   enum bpf_attach_type type)
@@ -3197,6 +3199,8 @@ static const struct {
 						BPF_CGROUP_UDP6_SENDMSG),
 	BPF_EAPROG_SEC("cgroup/sysctl",		BPF_PROG_TYPE_CGROUP_SYSCTL,
 						BPF_CGROUP_SYSCTL),
+	BPF_EAPROG_SEC("inet_lookup",		BPF_PROG_TYPE_INET_LOOKUP,
+						BPF_INET_LOOKUP),
 };
 
 #undef BPF_PROG_SEC_IMPL
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 2e594a0fa961..283dac0f6d13 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -240,6 +240,7 @@ LIBBPF_API int bpf_program__set_sched_cls(struct bpf_program *prog);
 LIBBPF_API int bpf_program__set_sched_act(struct bpf_program *prog);
 LIBBPF_API int bpf_program__set_xdp(struct bpf_program *prog);
 LIBBPF_API int bpf_program__set_perf_event(struct bpf_program *prog);
+LIBBPF_API int bpf_program__set_inet_lookup(struct bpf_program *prog);
 LIBBPF_API void bpf_program__set_type(struct bpf_program *prog,
 				      enum bpf_prog_type type);
 LIBBPF_API void
@@ -254,6 +255,7 @@ LIBBPF_API bool bpf_program__is_sched_cls(struct bpf_program *prog);
 LIBBPF_API bool bpf_program__is_sched_act(struct bpf_program *prog);
 LIBBPF_API bool bpf_program__is_xdp(struct bpf_program *prog);
 LIBBPF_API bool bpf_program__is_perf_event(struct bpf_program *prog);
+LIBBPF_API bool bpf_program__is_inet_lookup(struct bpf_program *prog);
 
 /*
  * No need for __attribute__((packed)), all members of 'bpf_map_def'
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 2c6d835620d2..e55d8e5d6fd4 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -67,6 +67,7 @@ LIBBPF_0.0.1 {
 		bpf_prog_test_run;
 		bpf_prog_test_run_xattr;
 		bpf_program__fd;
+		bpf_program__is_inet_lookup;
 		bpf_program__is_kprobe;
 		bpf_program__is_perf_event;
 		bpf_program__is_raw_tracepoint;
@@ -84,6 +85,7 @@ LIBBPF_0.0.1 {
 		bpf_program__priv;
 		bpf_program__set_expected_attach_type;
 		bpf_program__set_ifindex;
+		bpf_program__set_inet_lookup;
 		bpf_program__set_kprobe;
 		bpf_program__set_perf_event;
 		bpf_program__set_prep;
diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index 5e2aa83f637a..5094f32d33a7 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -101,6 +101,7 @@ probe_load(enum bpf_prog_type prog_type, const struct bpf_insn *insns,
 	case BPF_PROG_TYPE_SK_REUSEPORT:
 	case BPF_PROG_TYPE_FLOW_DISSECTOR:
 	case BPF_PROG_TYPE_CGROUP_SYSCTL:
+	case BPF_PROG_TYPE_INET_LOOKUP:
 	default:
 		break;
 	}
-- 
2.20.1

