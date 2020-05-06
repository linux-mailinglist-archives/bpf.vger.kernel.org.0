Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 042FF1C70FF
	for <lists+bpf@lfdr.de>; Wed,  6 May 2020 14:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728770AbgEFMzj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 May 2020 08:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728769AbgEFMzi (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 6 May 2020 08:55:38 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB248C061A41
        for <bpf@vger.kernel.org>; Wed,  6 May 2020 05:55:37 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id k12so2464421wmj.3
        for <bpf@vger.kernel.org>; Wed, 06 May 2020 05:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8MMXgY0TXvd+/8Bf5r+9pGjHTsnA2fHOT0fRA7c4wXg=;
        b=VTDDjKm0TNiaYyKf9a7lvt3iTreBuPSQUKI4jsKuA2L3Pa0Z71HqJyZ0jfeBaTMAqa
         +i9s+C7LQQe/+SzedTjjFVxxRSYIouSnwFIF2gpyVwqh9jjkG2Ks/Q+tZn6jA9dalZoz
         gW9T4TqUhcWsYWYBDi941/KCSF7UrXVJjP8NY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8MMXgY0TXvd+/8Bf5r+9pGjHTsnA2fHOT0fRA7c4wXg=;
        b=p8IWlgdtS/WJZk10L4EJCkRKUxaTEksJ//oZ14w/YB1DYtTF+F5YUQDoKxVx8NGjZW
         3JV+1zVX8huAK0+W+TwMwisi3uerTg0lToSBN8nkZAxL235oxPFQ7sRJBKPJ43sBI9sL
         7u3MviqWMcHwKIENJZkdxB+1pnaxdyiLoYUanDIRnVr8v0ygodxI8rVx6x/ayBcUM9vt
         7yKPkXYWjkfjbRGZo0zHHp546YnG4DL7R0iysm7A7G+FW+Er1zL1vfJAM04QiIlReveG
         kPGzZIfxNC/A8XAQAexNI2c43dn5Or/d6GqnLgIw6eF3skMunZgVidGIr5gnkSbkhIPh
         v07Q==
X-Gm-Message-State: AGi0PuavVJVaTrRlJ+4HmzpBY6X7TAH50jOxzmAQVngJBoLQLN6kjdwa
        uw9lT3fwiUEfvPPZlaU8eXZwvA==
X-Google-Smtp-Source: APiQypIBZTUzwyZq0r81vrVDEDqOQr7MdwHx8+Rw0PY51qr+jvbJbKi9RyKjx6xy4f28h/W0tfEzhA==
X-Received: by 2002:a7b:c190:: with SMTP id y16mr4694417wmi.50.1588769736672;
        Wed, 06 May 2020 05:55:36 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id a15sm2700717wrw.56.2020.05.06.05.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 05:55:36 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     dccp@vger.kernel.org, kernel-team@cloudflare.com,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Gerrit Renker <gerrit@erg.abdn.ac.uk>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH bpf-next 14/17] libbpf: Add support for SK_LOOKUP program type
Date:   Wed,  6 May 2020 14:55:10 +0200
Message-Id: <20200506125514.1020829-15-jakub@cloudflare.com>
X-Mailer: git-send-email 2.25.3
In-Reply-To: <20200506125514.1020829-1-jakub@cloudflare.com>
References: <20200506125514.1020829-1-jakub@cloudflare.com>
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
 tools/lib/bpf/libbpf.c        | 3 +++
 tools/lib/bpf/libbpf.h        | 2 ++
 tools/lib/bpf/libbpf.map      | 2 ++
 tools/lib/bpf/libbpf_probes.c | 1 +
 4 files changed, 8 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 977add1b73e2..74f4a15dc19e 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -6524,6 +6524,7 @@ BPF_PROG_TYPE_FNS(perf_event, BPF_PROG_TYPE_PERF_EVENT);
 BPF_PROG_TYPE_FNS(tracing, BPF_PROG_TYPE_TRACING);
 BPF_PROG_TYPE_FNS(struct_ops, BPF_PROG_TYPE_STRUCT_OPS);
 BPF_PROG_TYPE_FNS(extension, BPF_PROG_TYPE_EXT);
+BPF_PROG_TYPE_FNS(sk_lookup, BPF_PROG_TYPE_SK_LOOKUP);
 
 enum bpf_attach_type
 bpf_program__get_expected_attach_type(struct bpf_program *prog)
@@ -6684,6 +6685,8 @@ static const struct bpf_sec_def section_defs[] = {
 	BPF_EAPROG_SEC("cgroup/setsockopt",	BPF_PROG_TYPE_CGROUP_SOCKOPT,
 						BPF_CGROUP_SETSOCKOPT),
 	BPF_PROG_SEC("struct_ops",		BPF_PROG_TYPE_STRUCT_OPS),
+	BPF_EAPROG_SEC("sk_lookup",		BPF_PROG_TYPE_SK_LOOKUP,
+						BPF_SK_LOOKUP),
 };
 
 #undef BPF_PROG_SEC_IMPL
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index f1dacecb1619..8373fbacbba3 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -337,6 +337,7 @@ LIBBPF_API int bpf_program__set_perf_event(struct bpf_program *prog);
 LIBBPF_API int bpf_program__set_tracing(struct bpf_program *prog);
 LIBBPF_API int bpf_program__set_struct_ops(struct bpf_program *prog);
 LIBBPF_API int bpf_program__set_extension(struct bpf_program *prog);
+LIBBPF_API int bpf_program__set_sk_lookup(struct bpf_program *prog);
 
 LIBBPF_API enum bpf_prog_type bpf_program__get_type(struct bpf_program *prog);
 LIBBPF_API void bpf_program__set_type(struct bpf_program *prog,
@@ -364,6 +365,7 @@ LIBBPF_API bool bpf_program__is_perf_event(const struct bpf_program *prog);
 LIBBPF_API bool bpf_program__is_tracing(const struct bpf_program *prog);
 LIBBPF_API bool bpf_program__is_struct_ops(const struct bpf_program *prog);
 LIBBPF_API bool bpf_program__is_extension(const struct bpf_program *prog);
+LIBBPF_API bool bpf_program__is_sk_lookup(const struct bpf_program *prog);
 
 /*
  * No need for __attribute__((packed)), all members of 'bpf_map_def'
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index e03bd4db827e..113ac0a669c2 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -253,6 +253,8 @@ LIBBPF_0.0.8 {
 		bpf_program__set_attach_target;
 		bpf_program__set_lsm;
 		bpf_set_link_xdp_fd_opts;
+		bpf_program__is_sk_lookup;
+		bpf_program__set_sk_lookup;
 } LIBBPF_0.0.7;
 
 LIBBPF_0.0.9 {
diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index 2c92059c0c90..5c6d3e49f254 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -109,6 +109,7 @@ probe_load(enum bpf_prog_type prog_type, const struct bpf_insn *insns,
 	case BPF_PROG_TYPE_STRUCT_OPS:
 	case BPF_PROG_TYPE_EXT:
 	case BPF_PROG_TYPE_LSM:
+	case BPF_PROG_TYPE_SK_LOOKUP:
 	default:
 		break;
 	}
-- 
2.25.3

