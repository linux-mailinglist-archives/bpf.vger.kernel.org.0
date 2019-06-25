Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C00EA555D8
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2019 19:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731666AbfFYR11 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Jun 2019 13:27:27 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:47779 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731657AbfFYR10 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Jun 2019 13:27:26 -0400
Received: by mail-pl1-f202.google.com with SMTP id 59so9551102plb.14
        for <bpf@vger.kernel.org>; Tue, 25 Jun 2019 10:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=OrSuOd+WNpFgQwSR9WKVx5FNekFAq6HSf190FB+gMtQ=;
        b=lW8e8RryfQuAmv5fQ1SWrNfxFkkNyss+D6GlgfN04Vt0TaV58tp2d9Ad247IhL75FD
         qvmHxi8su2RCbQ6URj/1+0jkjis3urS9MJ+aL/veYgsmaj/7p4JKZfBJmKIlY1RmL1C+
         5s+xcGaUuZup0/tjZq1OINg8e4Mqcxp+z00WO/NJlTivQ6k3D+KyVlrGeN/NX4Brx7z3
         8AV/MDvXzBg9/sPy8IyJ7cf5JrLju/zVk149tBj+1LGYhIyzDy4gMgiRUTwzcyDEKt5b
         Pu4PS53yb8TYj2L5UxubPtq1a4g7yjIHgmhnKQsZNZc4T7ZHmmKBuDhLYv3ROggDviJU
         mMSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OrSuOd+WNpFgQwSR9WKVx5FNekFAq6HSf190FB+gMtQ=;
        b=EexbmpqG6ZXrj/whImYDwnMKZiK9hPK6PGxzZdZySnIKprYpyvwqSSSaatPc37eLVH
         WGpkys5RH3nniNo8vWOAP5pGz8zW3GdU1sh1R4EHWK9H1Yfre83xn8gArvOW9UtYHn/t
         acgQdyEt/V+osNGK+1y5/P+iCyx1Rj8cmLOV7R/kwkuCHMqWbuEPeJ9WkPQq9a883lgo
         o+qyUtQzfcYHWyfbz3Li1Q05p/0PuxQggKJd4hmmEjozw51KqR4VtNjv4iFN6y8WrrBk
         YtHeR12Lr19OJV2oATdo5X9FsbblVVkv0NA8DMtt5qUJQ9rrwaZp+fYGVCZUEG9TIPuy
         Bv2w==
X-Gm-Message-State: APjAAAVgmXKcIURrdHFAKIfBB0c3FgR+qm+JsKHpFrDbLvZiTQiXneEs
        zzBGghwZXYHYDn7rgtGNsybr0owopp4WfDkD
X-Google-Smtp-Source: APXvYqzkAJNtozWnpWnFJ7KHzNc75Bn/w4JPskPZ/6cfLKOAnpaQcU6iV/k6E0296LaeNSTbSTlq7bjipmGSx6k5
X-Received: by 2002:a63:52:: with SMTP id 79mr39594167pga.381.1561483645880;
 Tue, 25 Jun 2019 10:27:25 -0700 (PDT)
Date:   Tue, 25 Jun 2019 10:27:16 -0700
In-Reply-To: <20190625172717.158613-1-allanzhang@google.com>
Message-Id: <20190625172717.158613-2-allanzhang@google.com>
Mime-Version: 1.0
References: <20190625172717.158613-1-allanzhang@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH bpf-next v4 1/2] bpf: Allow bpf_skb_event_output for a few
 prog types
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

Signed-off-by: allanzhang <allanzhang@google.com>

v4:
* Reformating log message
v3:
* Reformating log message
v2:
* Reformating log message

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

