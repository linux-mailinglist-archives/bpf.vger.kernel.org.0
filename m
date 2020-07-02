Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50B5B211FCC
	for <lists+bpf@lfdr.de>; Thu,  2 Jul 2020 11:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbgGBJYs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Jul 2020 05:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728313AbgGBJYl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Jul 2020 05:24:41 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC109C08C5DE
        for <bpf@vger.kernel.org>; Thu,  2 Jul 2020 02:24:40 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id n2so13847956edr.5
        for <bpf@vger.kernel.org>; Thu, 02 Jul 2020 02:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p/51Q5x6FwRWCqHWwTaOTUhLzB+c8lWRnGMWqtdURWw=;
        b=iEv+eJJcbUWeiSoPV7z6Aw37s9yVSds8kZMcXb/iP+5KK2Q4jsqsi6pr2A+sAp0w5l
         FjkLetc3TCuaDvO6re7N9DZSFgi3dkO0pd/DqaqfXa8iW7x9QQAHTapaI/QA2vZsr8wP
         Rx4U+U8rexSdFQTfzkIl/FbiTGBRtOy91di9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p/51Q5x6FwRWCqHWwTaOTUhLzB+c8lWRnGMWqtdURWw=;
        b=TXRc9PLqVPvE/CK0d48f35YlKda2ImuxbGlZ7CTRziEXSwM4a1XGhly9KOJuKc4TAj
         MqlFKu2vKz9XaqSKvi7CAuzmSrsuQnMj7ScfbSM7JVMx+rK40tQ6nKmcVwkDI23SEeuj
         8yRZzqCvMU1HWh0iPJ0gIPDHEsm8aSkOME1Uh+D1lvRSOpdyWzJCBE2pvEjAOjVRpo/M
         Zk/Afw51jf35JsODF9HyYA8elpaZ9UtIGWmU8nkiFLZHn3Mv9b3hpJFGBrMscVim133W
         GQKrnDRvZgnQz7XmUTi+CmB7WoWppl7SICZWEUcHCmTGtaGPTx4UDU+cPi8fiRsEpgUE
         ZU8g==
X-Gm-Message-State: AOAM532FNt/23vsLLIGF/VT5H4ZlrSdUxqZsgatkrOWeJ1lG5TUOAbRI
        0Wso0ohAWQEC2wd/eTMF5rPTm4AcjxKQpg==
X-Google-Smtp-Source: ABdhPJzvPA/TYs9hMtgI0l+GG/+b3KI0fKMo4yy0bzGkT1oR4htr2rOvp1BZa3CLarDJ0OO8tzTjtg==
X-Received: by 2002:aa7:d2d2:: with SMTP id k18mr32693270edr.16.1593681879257;
        Thu, 02 Jul 2020 02:24:39 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id a8sm6409682ejp.51.2020.07.02.02.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 02:24:38 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH bpf-next v3 12/16] libbpf: Add support for SK_LOOKUP program type
Date:   Thu,  2 Jul 2020 11:24:12 +0200
Message-Id: <20200702092416.11961-13-jakub@cloudflare.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200702092416.11961-1-jakub@cloudflare.com>
References: <20200702092416.11961-1-jakub@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Make libbpf aware of the newly added program type, and assign it a
section name.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---

Notes:
    v3:
    - Move new libbpf symbols to version 0.1.0.
    - Set expected_attach_type in probe_load for new prog type.
    
    v2:
    - Add new libbpf symbols to version 0.0.9. (Andrii)

 tools/lib/bpf/libbpf.c        | 3 +++
 tools/lib/bpf/libbpf.h        | 2 ++
 tools/lib/bpf/libbpf.map      | 2 ++
 tools/lib/bpf/libbpf_probes.c | 3 +++
 4 files changed, 10 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 4ea7f4f1a691..ddcbb5dd78df 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -6793,6 +6793,7 @@ BPF_PROG_TYPE_FNS(perf_event, BPF_PROG_TYPE_PERF_EVENT);
 BPF_PROG_TYPE_FNS(tracing, BPF_PROG_TYPE_TRACING);
 BPF_PROG_TYPE_FNS(struct_ops, BPF_PROG_TYPE_STRUCT_OPS);
 BPF_PROG_TYPE_FNS(extension, BPF_PROG_TYPE_EXT);
+BPF_PROG_TYPE_FNS(sk_lookup, BPF_PROG_TYPE_SK_LOOKUP);
 
 enum bpf_attach_type
 bpf_program__get_expected_attach_type(struct bpf_program *prog)
@@ -6969,6 +6970,8 @@ static const struct bpf_sec_def section_defs[] = {
 	BPF_EAPROG_SEC("cgroup/setsockopt",	BPF_PROG_TYPE_CGROUP_SOCKOPT,
 						BPF_CGROUP_SETSOCKOPT),
 	BPF_PROG_SEC("struct_ops",		BPF_PROG_TYPE_STRUCT_OPS),
+	BPF_EAPROG_SEC("sk_lookup",		BPF_PROG_TYPE_SK_LOOKUP,
+						BPF_SK_LOOKUP),
 };
 
 #undef BPF_PROG_SEC_IMPL
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 2335971ed0bd..c2272132e929 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -350,6 +350,7 @@ LIBBPF_API int bpf_program__set_perf_event(struct bpf_program *prog);
 LIBBPF_API int bpf_program__set_tracing(struct bpf_program *prog);
 LIBBPF_API int bpf_program__set_struct_ops(struct bpf_program *prog);
 LIBBPF_API int bpf_program__set_extension(struct bpf_program *prog);
+LIBBPF_API int bpf_program__set_sk_lookup(struct bpf_program *prog);
 
 LIBBPF_API enum bpf_prog_type bpf_program__get_type(struct bpf_program *prog);
 LIBBPF_API void bpf_program__set_type(struct bpf_program *prog,
@@ -377,6 +378,7 @@ LIBBPF_API bool bpf_program__is_perf_event(const struct bpf_program *prog);
 LIBBPF_API bool bpf_program__is_tracing(const struct bpf_program *prog);
 LIBBPF_API bool bpf_program__is_struct_ops(const struct bpf_program *prog);
 LIBBPF_API bool bpf_program__is_extension(const struct bpf_program *prog);
+LIBBPF_API bool bpf_program__is_sk_lookup(const struct bpf_program *prog);
 
 /*
  * No need for __attribute__((packed)), all members of 'bpf_map_def'
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 6544d2cd1ed6..04b99f63a45c 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -287,5 +287,7 @@ LIBBPF_0.1.0 {
 		bpf_map__type;
 		bpf_map__value_size;
 		bpf_program__autoload;
+		bpf_program__is_sk_lookup;
 		bpf_program__set_autoload;
+		bpf_program__set_sk_lookup;
 } LIBBPF_0.0.9;
diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index 10cd8d1891f5..5a3d3f078408 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -78,6 +78,9 @@ probe_load(enum bpf_prog_type prog_type, const struct bpf_insn *insns,
 	case BPF_PROG_TYPE_CGROUP_SOCK_ADDR:
 		xattr.expected_attach_type = BPF_CGROUP_INET4_CONNECT;
 		break;
+	case BPF_PROG_TYPE_SK_LOOKUP:
+		xattr.expected_attach_type = BPF_SK_LOOKUP;
+		break;
 	case BPF_PROG_TYPE_KPROBE:
 		xattr.kern_version = get_kernel_version();
 		break;
-- 
2.25.4

