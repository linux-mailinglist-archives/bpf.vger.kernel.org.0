Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1632951893
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2019 18:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbfFXQZF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Jun 2019 12:25:05 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:37228 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728530AbfFXQYl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Jun 2019 12:24:41 -0400
Received: by mail-pg1-f202.google.com with SMTP id e16so9689456pga.4
        for <bpf@vger.kernel.org>; Mon, 24 Jun 2019 09:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+NwZcf9Qug4AB3CHeUOviaC9ooYDCiQf1ZUN7j+uuFw=;
        b=lUQO0KmK9Ovm7MnPN8zdQohipaxoM0Sr8fVIUHaXhEpU4q/a/Oq/wPxme3rJCvqLZt
         8n7GRLmEjYbYVqzB+1InIosSM1XnEhEpRRGv3ZJ5swT7k5eZv38oPSzrpBErliRJNTJP
         H4kdLrYV5ZfZQ4Z+cUnXDKrOqzRDZDkpeO1JJwb2IC+V2hKhZqo8idR94JuQfyhyaaHv
         jP7QhDm2PspioAPf/KnOtKggG8ElQLBSApiujqgZfjJQKPh5LT9RU2x9N4mMctRcAdmS
         P7i7d+RrLlMmTYo9tMVQNeKBFx//H2OH2Xo4TA1C8ptj86dOdHc9xS84A5+91FaKE/Ox
         TpzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+NwZcf9Qug4AB3CHeUOviaC9ooYDCiQf1ZUN7j+uuFw=;
        b=VFvYPuA1yHC6xU3FRvJ7qaE8sKlsb4hY4BEgVv1uW7v1GMGkEKSYMjhr0yq7HhN78S
         p8prYu1B3lrWBuC2WmjN1Xsty1cd9CHFFbfOJKIozgqVc1hfpjrt8WxcFMUIhcQ6nh5w
         uD/Iu3Geo3gFB0ygEM2eMcUy4pesevUIipyVm7KZkzYT1xMJ4loCRf0ZUIPRoEYcZ1zJ
         n7RsMW5eN/InDie0HHZzuGGjsLoyUcG7DsVCftSoZpmZUznHORnLNuYuD5G9bi0PjqTX
         xdz2aTWfOzYk64O8L3l+b2WRVQWpqRff12ZfiqeFeDLLMhSRw0R3PspN9vj36YtwYcT0
         lk7A==
X-Gm-Message-State: APjAAAUDiLylzPQWhhskeRAO4BBbo9V8OUkGCWVSpNH419PjcGjchhu+
        ZtT9s9z8oGlhVhM29RAmZg82LO0=
X-Google-Smtp-Source: APXvYqwBaiy3L6Cfpe5S2uX9ddAgQ+wJk2LcXjvUPUb5lQ0hfkLFxR7h0HZcsKxrkiaNZbYdRbCJk4M=
X-Received: by 2002:a63:360d:: with SMTP id d13mr33778747pga.80.1561393480302;
 Mon, 24 Jun 2019 09:24:40 -0700 (PDT)
Date:   Mon, 24 Jun 2019 09:24:23 -0700
In-Reply-To: <20190624162429.16367-1-sdf@google.com>
Message-Id: <20190624162429.16367-4-sdf@google.com>
Mime-Version: 1.0
References: <20190624162429.16367-1-sdf@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH bpf-next v8 3/9] libbpf: support sockopt hooks
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
index 68f45a96769f..cacbd038ac79 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -2646,6 +2646,7 @@ static bool bpf_prog_type__needs_kver(enum bpf_prog_type type)
 	case BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE:
 	case BPF_PROG_TYPE_PERF_EVENT:
 	case BPF_PROG_TYPE_CGROUP_SYSCTL:
+	case BPF_PROG_TYPE_CGROUP_SOCKOPT:
 		return false;
 	case BPF_PROG_TYPE_KPROBE:
 	default:
@@ -3604,6 +3605,10 @@ static const struct {
 						BPF_CGROUP_UDP6_RECVMSG),
 	BPF_EAPROG_SEC("cgroup/sysctl",		BPF_PROG_TYPE_CGROUP_SYSCTL,
 						BPF_CGROUP_SYSCTL),
+	BPF_EAPROG_SEC("cgroup/getsockopt",	BPF_PROG_TYPE_CGROUP_SOCKOPT,
+						BPF_CGROUP_GETSOCKOPT),
+	BPF_EAPROG_SEC("cgroup/setsockopt",	BPF_PROG_TYPE_CGROUP_SOCKOPT,
+						BPF_CGROUP_SETSOCKOPT),
 };
 
 #undef BPF_PROG_SEC_IMPL
diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index 6635a31a7a16..ace1a0708d99 100644
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
2.22.0.410.gd8fdbe21b5-goog

