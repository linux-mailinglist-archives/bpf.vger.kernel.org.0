Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E094C3BE13
	for <lists+bpf@lfdr.de>; Mon, 10 Jun 2019 23:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389904AbfFJVIl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Jun 2019 17:08:41 -0400
Received: from mail-yb1-f201.google.com ([209.85.219.201]:40432 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389903AbfFJVIl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Jun 2019 17:08:41 -0400
Received: by mail-yb1-f201.google.com with SMTP id u3so4581361ybu.7
        for <bpf@vger.kernel.org>; Mon, 10 Jun 2019 14:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=s4cYkdfXLpURz/IJz9ubZSdFhBas+UHvrTOfo6AKN98=;
        b=hNSNc8tbLY97n37AsLcY0htkPvtoOJe3fsk05WJTnbXcveW/GbEkKBMx27lAJLQ0vy
         D8QD9Axa2QWnICltEFgsIz9fogXdN8jzIz2NRfVJn+Iw2vO3ocglyzTrvUy2jn6/6fh/
         E4mwj2jrkA5tohr1GZ20xsP0dkfZma59z07oaMDyo++hH1zi+oMlY5hh/O1JITQn33rC
         Tff4k2UEYgCUrN6dlfrf6PfrKxBhZoSBpL3lNEZEwh8HP+dD0I+QiZv/p82x2R+61Igs
         6/E5yFJgUJv4UTbHq1HlawtxK8T1q7iNKv5Kz6DQ/YjDNAqPSykaU5+Oy7BsazmNayx0
         ITFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=s4cYkdfXLpURz/IJz9ubZSdFhBas+UHvrTOfo6AKN98=;
        b=LTVqz5u+wppbBDDjrz3exzmVlfTT06yU3vQTJK8XEhaagElA7RKvMMwZGUHY7d/PP0
         K4Tq+ybOZ3fCI5oVF6l5Hqeny62wfvP/ZmcqRLuCApjoBdFdff5J/X2baX1gR+EDVAXN
         6h4yD7O/UajsvtPTYpLs2++H1Yeff6qquhmGIRDQUldmypFvnxZ84NEzaO0Y98reGbnj
         f33YO4zfZrH65vNnlw1TYVC+LeoBEXz0+Fnt97AUBKvXx/hDiIMOCZYpC/e1rG492Qt3
         HKVbITQ7E8FYO6lF7T5YMkfYaBepDY7yxoHTT2K34KHG7wJCOK6fBIEAlWQVf1toFPUr
         dHrQ==
X-Gm-Message-State: APjAAAV94XL27qNjFBhvbZPLH5tr6oQHJjPwSuR655dU2VHRjASDFOh5
        drvuY4Pwy+UpUepuCKKAHzSmONc=
X-Google-Smtp-Source: APXvYqx3UaFCxh33W1WshrGbcECb4oMYNrRnITdHqFeLpcf8xJodSUuFqcZzXG8p2SA2ytH5+NAA3po=
X-Received: by 2002:a25:458:: with SMTP id 85mr34818984ybe.167.1560200920359;
 Mon, 10 Jun 2019 14:08:40 -0700 (PDT)
Date:   Mon, 10 Jun 2019 14:08:25 -0700
In-Reply-To: <20190610210830.105694-1-sdf@google.com>
Message-Id: <20190610210830.105694-4-sdf@google.com>
Mime-Version: 1.0
References: <20190610210830.105694-1-sdf@google.com>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH bpf-next v5 3/8] libbpf: support sockopt hooks
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>, Martin Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Make libbpf aware of new sockopt hooks so it can derive prog type
and hook point from the section names.

Cc: Martin Lau <kafai@fb.com>
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
2.22.0.rc2.383.gf4fbbf30c2-goog

