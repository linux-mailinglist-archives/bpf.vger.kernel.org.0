Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0211237B82
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2019 19:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730317AbfFFRv5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Jun 2019 13:51:57 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:54747 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728869AbfFFRv5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Jun 2019 13:51:57 -0400
Received: by mail-pl1-f201.google.com with SMTP id u10so1918347plq.21
        for <bpf@vger.kernel.org>; Thu, 06 Jun 2019 10:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=CU+Wum/bihwDTWLVJmYTACBXxoMM3npiy+H9eNDd5/8=;
        b=EMnYSgL2CVBspRhxpclGUGp0Bcpv3krk39rAIx2fyNB+pTDGL4tdCS4uGrWcc6pR+i
         0TZPTpOOaZ2HV4XSETW3slyxZ6ak9eb9PM5HWGbFSVqIL8Yj/kcbvh2IX5sT0xezZITp
         rk91EBJvea1jW5sUVft/ZBvDh+KLYHxFED/sHRDZNMRXTwIqbfhBcVe/ddCZ4CfTBXZ9
         WZUETFpcYLvBlO461P7Sd/0b6iNw6qbFwW84NXjkQZdz8hFKDNgaXq1Kr/tzydGVgrEs
         E8jRkqrq08Ziw7KJ5rVpcPNLadYphQuXmqzZC32BCXyA5Poh2zh5RGamFKgR0ZYQykpF
         ZHIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CU+Wum/bihwDTWLVJmYTACBXxoMM3npiy+H9eNDd5/8=;
        b=Hyj0zOM4MqkjnwF4fdPiZ9vsO/xZcLviw+g0PcHpQir/MWOyRhUdjUO4z9bGLRteyZ
         qJFTTc5w+KxcJTLCFsH4tU71Ax9v4LzA9ZRTAnLQd8UP2Hy15MmUsDn1/qoDNNQKcMu5
         Me8he6mBa+w33cA6NmBtncWW78i9Tif4kwbHlgubLHQZcG2sGYdepU6ifmD5tYQZyDLD
         4hqZPaCK0NbXkQGdR4gSQpTOy8fBUIfsM2vqKr7e06r+AAc2nE5SYCyB90o7+ZxbWSKk
         /53WubZ0SjebjMwF1ImJF3PA5ZPg2xJ2CTlU/Cb97N+dpxkUwArZr8dTgl+GLDfWzcAy
         Rr8w==
X-Gm-Message-State: APjAAAVPrmHcvWMgTWjp94+3PAEjx2O+fFv6lkHoJ1wO8929iK4HZGPn
        cTKVm1N3Rt/bVgVI9JMt20/5UoA=
X-Google-Smtp-Source: APXvYqySdMHiCAhAKKjBRnzAnzxqDjR8ZaquGJqakXjQTj5Ws9tiJPKh+pcRjq0zUPZXm42AIzen9vg=
X-Received: by 2002:a63:87c8:: with SMTP id i191mr4451575pge.131.1559843515877;
 Thu, 06 Jun 2019 10:51:55 -0700 (PDT)
Date:   Thu,  6 Jun 2019 10:51:41 -0700
In-Reply-To: <20190606175146.205269-1-sdf@google.com>
Message-Id: <20190606175146.205269-4-sdf@google.com>
Mime-Version: 1.0
References: <20190606175146.205269-1-sdf@google.com>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
Subject: [PATCH bpf-next v2 3/8] libbpf: support sockopt hooks
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

