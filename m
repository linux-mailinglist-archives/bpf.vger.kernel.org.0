Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8BA155CF5
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2019 02:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbfFZAjA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Jun 2019 20:39:00 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:45065 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbfFZAi7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Jun 2019 20:38:59 -0400
Received: by mail-pf1-f202.google.com with SMTP id i27so433662pfk.12
        for <bpf@vger.kernel.org>; Tue, 25 Jun 2019 17:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=g15nGRFegqF9vTxmtNDH1TEJzKYjgH3Qiz5eOlA452w=;
        b=cv2ZwnGgehkSvkmOim2n7lMeztNq8eFl7jrp3grr7iNB+QttoT4o2HdiEov5BPTQ4V
         Q47ck3D7DXkTg/mV6MaxjU7Q8g4mvu4RixU+busJ3r07EpTh9INOg/fjX4H+nkXcsf+w
         F5GHnm8MkbrRDWQg04ZKa1oxtd1o8+2Rxo2LgpUcgRTM1va5t04qmPJfJzKxMHxiuKtf
         /sVHdObcfrZQ50lcQB8S1l2SwdJjZ2gFGU2xwC1VX/R8cnHK3AndX1hq1+UuitC9dE+M
         VdhNw7i3CSqB6iJ4RA/WhC/uT9EphwNGunz4rDOPfRdMhUAIYaevoH4K9jk4MFFJkllT
         bk1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=g15nGRFegqF9vTxmtNDH1TEJzKYjgH3Qiz5eOlA452w=;
        b=KjBHr7N8YCvpRtseh5YsxfRJ6SXVXd9Z9Zap/zxx8dBsPMkU0wB0LlgRPCyxGgJouc
         JD/sgSlIyBt8mjGEE0JlzwKqEXVbwo1E9QQ3DoI9gXksB+I8zomBmIjghKn6P2cWZQe0
         1gZDpAZqyhaMMzPLllw0cZD1J0GJwaP2MEI7fha1MPiBwl5dKrkG8zGCGl7faTE/4SpJ
         mZsZ4ohc2UlhEwDOy0peDdWMO2oh8ZZS1u4H6G0e9T0aIg9wmLvxKUH5pZvB4TXt/ulK
         Xslfpq9Z1IzpVvJDpZqn2omWFhaji0Qaq+6NiSPx2sTls3LvqbILfYHuyop2ZJVn5eze
         PUXg==
X-Gm-Message-State: APjAAAUutaTR8Znj2sGuVFxuaoz0FJI5beTHPLUH4U1lA9gVtJJeIKyZ
        zS6l9O0+nh0BP9Z6V1kRNt4SDJTIcAcr6QC2
X-Google-Smtp-Source: APXvYqz5ChaPKsKurIa8epxRev4U0HZ9vl32gSKlrAi+Lx1hoWOT+TV8SlDO0/U0lf6Lo6f1lxGCm4o0C5PjBBLG
X-Received: by 2002:a63:e015:: with SMTP id e21mr2590431pgh.172.1561509538791;
 Tue, 25 Jun 2019 17:38:58 -0700 (PDT)
Date:   Tue, 25 Jun 2019 17:38:51 -0700
In-Reply-To: <20190626003852.163986-1-allanzhang@google.com>
Message-Id: <20190626003852.163986-2-allanzhang@google.com>
Mime-Version: 1.0
References: <20190626003852.163986-1-allanzhang@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH bpf-next v6 1/2] bpf: Allow bpf_skb_event_output for a few
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

Signed-off-by: allan zhang <allanzhang@google.com>
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

