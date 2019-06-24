Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8CF951D84
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2019 23:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730312AbfFXV6c (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Jun 2019 17:58:32 -0400
Received: from mail-vs1-f74.google.com ([209.85.217.74]:54474 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730080AbfFXV6b (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Jun 2019 17:58:31 -0400
Received: by mail-vs1-f74.google.com with SMTP id 184so4315007vsm.21
        for <bpf@vger.kernel.org>; Mon, 24 Jun 2019 14:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=vljDviNdnBJvl0I2gRgeW5+fqicMSv8iMMvpNNvivIc=;
        b=uZydj3CHzinsBgmHVtzWKn5vODjGhCeYVbsoFmikUSlY/Ax/FB2JsPqEzxPCHX3zDE
         3GwxdzR+5pd9NxCki1F0p53wBWQglzQqO7ztSladwiJ9Dxfj1y6xvqZjjJ2jTXrhpym8
         0e1C2rl+PAo8SeaTOort/RDRYEPvgiGLrEnYqJYC/8i/UzLo6/AbqsdqGK29us5P6zBy
         fPHDiCnccYeGL9EOwv37TsUKXrLWQJoupDpZlMYFxmwfM5WSeyGVlt0/1QcpmUs0IWr5
         PhrpySCgSIqOymUn2P58CRYQn7+rhhdO6GXQtqPfaHooN/YaMiyU2SbTMqPWB+ZM5wMU
         Hjiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vljDviNdnBJvl0I2gRgeW5+fqicMSv8iMMvpNNvivIc=;
        b=pRlgLmQpuU5MZ1gmINKb5hZrhmH4fsPz9jmaxAehETdD735H9gDiIufm+l6leaRTm2
         i5k0AWsER2X3qvQmGtd23rJwqOaFt5pLTwHf1HjHzqRl3IlxPwA6he8ABHb087XSgLYu
         xNelNyv3CPUHVghPztVua7vNNz2ATvJt3mNcofijc6MSGLrIODMzt/CNiJC4wXeOnt9V
         Y9XbZsUFC2RQ1tg04wnAN0fImyAjQI3L/m9W0HaADw6K/1KbXeKo9u/xID2YuFps8wKY
         zvOuHgTfjTcNwMn+NtXJPXiDohPiGgurvMoFKbdmN9mKyNYrEBKjZrnxyAjD5qMurIMZ
         PIKg==
X-Gm-Message-State: APjAAAX1rof9k3auL4npq63xbYO9jZ5GG4gmaCqTnQnH2cBMA05+FXqS
        BzDe//YLpbPVpXzWL4REufHV7YexuXGyhKri
X-Google-Smtp-Source: APXvYqyGqFI7gewjmf94K55vV9Fppl0A27k3v9JRYJRr5EjU0nwgOXW8C5pNzVEI6Mcwgql0NRnI1GN6z/cpLh5f
X-Received: by 2002:ab0:c16:: with SMTP id a22mr13192833uak.73.1561413510536;
 Mon, 24 Jun 2019 14:58:30 -0700 (PDT)
Date:   Mon, 24 Jun 2019 14:58:23 -0700
In-Reply-To: <20190624215824.118783-1-allanzhang@google.com>
Message-Id: <20190624215824.118783-2-allanzhang@google.com>
Mime-Version: 1.0
References: <20190624215824.118783-1-allanzhang@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH] bpf: Allow bpf_skb_event_output for a few prog types
From:   allanzhang <allanzhang@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     allanzhang <allanzhang@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Software event output is only enabled by a few prog types right now (TC,
LWT out, XDP, sockops). Many other skb based prog types need
bpf_skb_event_output to produce software event.

Added socket_filter, cg_skb, sk_skb prog types to generate sw event.

Test bpf code is generated from code snippet:

struct TMP {
    uint64_t tmp;
} tt;
tt.tmp = 5;
bpf_perf_event_output(skb, &connection_tracking_event_map, 0,
                      &tt, sizeof(tt));
return 1;

the bpf assembly from llvm is:
       0:       b7 02 00 00 05 00 00 00         r2 = 5
       1:       7b 2a f8 ff 00 00 00 00         *(u64 *)(r10 - 8) = r2
       2:       bf a4 00 00 00 00 00 00         r4 = r10
       3:       07 04 00 00 f8 ff ff ff         r4 += -8
       4:       18 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00    r2 = 0ll
       6:       b7 03 00 00 00 00 00 00         r3 = 0
       7:       b7 05 00 00 08 00 00 00         r5 = 8
       8:       85 00 00 00 19 00 00 00         call 25
       9:       b7 00 00 00 01 00 00 00         r0 = 1
      10:       95 00 00 00 00 00 00 00         exit

Patch 1 is enabling code.
Patch 2 is fullly covered selftest code.

Signed-off-by: allanzhang <allanzhang@google.com>
---
 net/core/filter.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 2014d76e0d2a..b75fcf412628 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5958,6 +5958,8 @@ sk_filter_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_get_socket_cookie_proto;
 	case BPF_FUNC_get_socket_uid:
 		return &bpf_get_socket_uid_proto;
+	case BPF_FUNC_perf_event_output:
+		return &bpf_skb_event_output_proto;
 	default:
 		return bpf_base_func_proto(func_id);
 	}
@@ -5978,6 +5980,8 @@ cg_skb_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_sk_storage_get_proto;
 	case BPF_FUNC_sk_storage_delete:
 		return &bpf_sk_storage_delete_proto;
+	case BPF_FUNC_perf_event_output:
+		return &bpf_skb_event_output_proto;
 #ifdef CONFIG_SOCK_CGROUP_DATA
 	case BPF_FUNC_skb_cgroup_id:
 		return &bpf_skb_cgroup_id_proto;
@@ -6226,6 +6230,8 @@ sk_skb_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_sk_redirect_map_proto;
 	case BPF_FUNC_sk_redirect_hash:
 		return &bpf_sk_redirect_hash_proto;
+	case BPF_FUNC_perf_event_output:
+		return &bpf_skb_event_output_proto;
 #ifdef CONFIG_INET
 	case BPF_FUNC_sk_lookup_tcp:
 		return &bpf_sk_lookup_tcp_proto;
-- 
2.22.0.410.gd8fdbe21b5-goog

