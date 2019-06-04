Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 631EB351F1
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2019 23:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbfFDVfh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Jun 2019 17:35:37 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:51605 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbfFDVfh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Jun 2019 17:35:37 -0400
Received: by mail-qt1-f201.google.com with SMTP id a18so9728069qtj.18
        for <bpf@vger.kernel.org>; Tue, 04 Jun 2019 14:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=CU+Wum/bihwDTWLVJmYTACBXxoMM3npiy+H9eNDd5/8=;
        b=F2t57f54iSXWHC/EjZN3TgEeBmskXCQNFDhkzDhmokN0pgxPrJCWospSq5AUcjMtKR
         ErXG1tTxaB7rijLCOoM11zJNRYLLZ5evUIOLKuwgRmvDd7xPciQqUoQZkxC0xIp37+v+
         fQ1rhkDeHgTFChKcguKwETYvFdlw5nz4j3wuq/scBOrZGJT+y8D6DruIflG9z7VRilwA
         /iXmEBMjorfz/60jFF4FhN5GUmu3+FPt06wRGvMbLEAJ2y8t4OW0DmnCCH7suuCUfvpq
         El4OvpBqLLFZg7ZaavzTujnS1JWeRwZN22402af6diVaNThu4n5mgFb7VHF/2KJE5L3L
         k88Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CU+Wum/bihwDTWLVJmYTACBXxoMM3npiy+H9eNDd5/8=;
        b=jRvsL8zhfOkJHIyjiUwWaPgYJ2syfLCvKGjqJbxNg9cjq9XzMI9XxQZTwA6v8/++yU
         CruI6Kaorz3GQPRzuYVOIwUpap38ca+30Wk3C6OZpQ7WShhDSQ26iuEukTT519NFs6V0
         r7gdLoFTF/O7a/2pdgvEVvka8ED1/N1G8CBZ//bzKqguQXc4G712B8agM0m0mErfUlPk
         2pFc51+Vh+uiEWTzl4bh9f9DHycOhQ8fDmIhAMVCQ9hIsHEPnbEMNI4WLxr4+dEI/E++
         jUaBl48AIx1juqNEjAlPe1UBQWXOB2x+VmVrDBokYF0uu5240z53C/42drR83k0Ay3Rs
         5rMw==
X-Gm-Message-State: APjAAAVTHwKbFl9aYLXHBTbBo3Bun4yn4oRHAsT2CqXm+f62qn2LxK+y
        OSBXLefq1NeOUiuzL1RAP1GE5Q8=
X-Google-Smtp-Source: APXvYqz3oLXvATMspIEGMwlYkZ+GpsToFbo5NMC1KzRwRFCAjdBbLSt18/fuEIPMCIL4yWXhmM7K2u0=
X-Received: by 2002:a0c:d003:: with SMTP id u3mr15942129qvg.112.1559684136458;
 Tue, 04 Jun 2019 14:35:36 -0700 (PDT)
Date:   Tue,  4 Jun 2019 14:35:20 -0700
In-Reply-To: <20190604213524.76347-1-sdf@google.com>
Message-Id: <20190604213524.76347-4-sdf@google.com>
Mime-Version: 1.0
References: <20190604213524.76347-1-sdf@google.com>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
Subject: [PATCH bpf-next 3/7] libbpf: support sockopt hooks
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Make libbpf aware of new sockopt hooks so it can derive prog type
and hook point from the section names.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/lib/bpf/libbpf.c        | 5 +++++
 tools/lib/bpf/libbpf_probes.c | 1 +
 2 files changed, 6 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index ba89d9727137..cd3c692a8b5d 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -2243,6 +2243,7 @@ static bool bpf_prog_type__needs_kver(enum bpf_prog_type type)
 	case BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE:
 	case BPF_PROG_TYPE_PERF_EVENT:
 	case BPF_PROG_TYPE_CGROUP_SYSCTL:
+	case BPF_PROG_TYPE_CGROUP_SOCKOPT:
 		return false;
 	case BPF_PROG_TYPE_KPROBE:
 	default:
@@ -3196,6 +3197,10 @@ static const struct {
 						BPF_CGROUP_UDP6_SENDMSG),
 	BPF_EAPROG_SEC("cgroup/sysctl",		BPF_PROG_TYPE_CGROUP_SYSCTL,
 						BPF_CGROUP_SYSCTL),
+	BPF_EAPROG_SEC("cgroup/getsockopt",	BPF_PROG_TYPE_CGROUP_SOCKOPT,
+						BPF_CGROUP_GETSOCKOPT),
+	BPF_EAPROG_SEC("cgroup/setsockopt",	BPF_PROG_TYPE_CGROUP_SOCKOPT,
+						BPF_CGROUP_SETSOCKOPT),
 };
 
 #undef BPF_PROG_SEC_IMPL
diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index 5e2aa83f637a..7e21db11dde8 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -101,6 +101,7 @@ probe_load(enum bpf_prog_type prog_type, const struct bpf_insn *insns,
 	case BPF_PROG_TYPE_SK_REUSEPORT:
 	case BPF_PROG_TYPE_FLOW_DISSECTOR:
 	case BPF_PROG_TYPE_CGROUP_SYSCTL:
+	case BPF_PROG_TYPE_CGROUP_SOCKOPT:
 	default:
 		break;
 	}
-- 
2.22.0.rc1.311.g5d7573a151-goog

