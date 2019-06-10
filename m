Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31BF93B98A
	for <lists+bpf@lfdr.de>; Mon, 10 Jun 2019 18:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbfFJQed (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Jun 2019 12:34:33 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:54069 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728234AbfFJQec (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Jun 2019 12:34:32 -0400
Received: by mail-qt1-f202.google.com with SMTP id h47so3723442qtc.20
        for <bpf@vger.kernel.org>; Mon, 10 Jun 2019 09:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=s4cYkdfXLpURz/IJz9ubZSdFhBas+UHvrTOfo6AKN98=;
        b=iNS8pKI7aB/fDcMfqTyfKDEZb9RBbVW72Rw89As56p3RX6P9AzvwWGYmZkJ2DguzT7
         NEEAug3LoydctvCfvHa0l/1+nFu+wyF23gbocX+PdFnqN3sLpKuf9Rvlq5UgL3MUD3MJ
         up6Y6gPbjVdyZQKGhrGGmVWpGzlFzcYxA8IUZeLu44Bs5kcEWNJZ1bBVVsKtHOEUI8TS
         0eQKkgubjhvHhoK4Enby5zsPYTDT6XuiXP+FZZEV+5y3gIyJD+ykAwGpIcXRMXx8NNS9
         OLHdKtAh5Hv2djzVTA+PDkopxldxsSSPbmOwENQauzZTVeohd80cNxkgsTOegFUSE2gY
         qfUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=s4cYkdfXLpURz/IJz9ubZSdFhBas+UHvrTOfo6AKN98=;
        b=eOmmEI8d6MbLQmWZk0Kpro7UvKRltzXqJHercesAliYhs5m0QSD8BGoz1DpiNMUDmK
         hjpgjczQOwLGyNh2a7YdWxT5VZatN43UPjaOBnkwk2DZghZLzK9DKZa6FFajk7pLtYaE
         U0Se2AXrK1lSvXdB48XuQCDWd5D8zHr/PIcPTx3ovSeo3yD4/IsgAIPLQcWMt69zbF8y
         tbexQ+FWnYUPHBhpcBHrZHuejaebV6JIC/46EBqM9szUSUj0+FhRdFWCGxgWn0FqsjWK
         0T16jdNKDj6GX37NtzcdxzxhGxNCxSmfT+PrzwpRhK+AswOScM2+6SiD895Q6aHKZnLS
         cfvw==
X-Gm-Message-State: APjAAAUWrd8ra6SGoFamYtNKYdr5fcORZZqEM4V4pN+k5F75uhlpmd7H
        8+BQ3YBL3/FLzA22hiSssoBoCXs=
X-Google-Smtp-Source: APXvYqy74BDGRYhn8mprar56bd6oWsZM7x1h1U9BDwg6CMnZIe0I+929gZnVR2Ue7fEQlr5vxsQTcPo=
X-Received: by 2002:a0c:871d:: with SMTP id 29mr43441382qvh.28.1560184471662;
 Mon, 10 Jun 2019 09:34:31 -0700 (PDT)
Date:   Mon, 10 Jun 2019 09:34:16 -0700
In-Reply-To: <20190610163421.208126-1-sdf@google.com>
Message-Id: <20190610163421.208126-4-sdf@google.com>
Mime-Version: 1.0
References: <20190610163421.208126-1-sdf@google.com>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH bpf-next v4 3/8] libbpf: support sockopt hooks
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

