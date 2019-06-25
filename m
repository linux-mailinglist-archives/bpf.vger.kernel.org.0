Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A063E55B06
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2019 00:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbfFYWXv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Jun 2019 18:23:51 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:55942 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfFYWXh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Jun 2019 18:23:37 -0400
Received: by mail-pg1-f202.google.com with SMTP id b10so201236pgb.22
        for <bpf@vger.kernel.org>; Tue, 25 Jun 2019 15:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lTASmr8508yaqk28Yw8XQISa65o9AY9rEgUPJ2XrbLE=;
        b=iFuxSSu4w+qeEDrnY8eCvHpyEmzF/JGzC5jealGOACnmQUOxHsvXUrxbx5B6NbMf9r
         m0Ish2G+BzlT5I4xeMQ+olR/2b7upyAKmJvFDbKeXv9/C6crCP7GQX8iqRQieVK5hv/k
         PF+Em80VwxveytMkLWejhiJATX/wxPCQgP6uhd8sTiThHx+VCJbL5PqkG1TTg5/Uohp0
         EchVDYcu13G8obyU86sTZANEFEbTuqhOFg2Yt3HKAnFia4/dqzfG5m9HR35NUyK6iBFz
         ZGp+p0l2JHbEetVVoSj2YO+upcrYy6CVYDt7Wg3xjK6WZ3DXIBEYE8sxTCYM9jgWTIU6
         bMNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lTASmr8508yaqk28Yw8XQISa65o9AY9rEgUPJ2XrbLE=;
        b=mJnN/riByiI39p6HahDmBqCUMU1N8HG27Xe39kKjbxN0w4Ipo1WzrQeIdp8WN7pplv
         mo2hLORRTgQm/NGBuBTuidgOCx4UXIICyNVzNXykGBMYyf2PsGtt8N2GF2qwHldIi7lu
         IJ0mCJgj+MK7D/eNbrgzMUms+r8K+TRgjz+kNXeoxPmZFtvQXD+A4DG+rK/BvO8QFwJ5
         yE0Rndn101+OOVjRftRAtfaWNaDj0ShK0+baba2j8et2I77S9KGUZOrzRAHurRWaqqhJ
         3yGASLhI1gYo5rJmT4hGw7gGAoSJlR1VhkqvdFLwIBNhYhDrU9tuulFlSJSHBaL7zSdZ
         zBlA==
X-Gm-Message-State: APjAAAWENRkL1lSFEMqYihd0vwVYUyyLbeukaN8QBfDabT7oFHfXAjaq
        UQAesQOWvQhqNKHIXCfYzeYLlwr51nhi8b3+
X-Google-Smtp-Source: APXvYqzWflQoTTCY4koVcOoYwwtcf1JO0bMRrK4mtCaxSI3WP6xeQVhy1ZTe3jrivMVF+vUDuw642TCLpR9CHoyY
X-Received: by 2002:a63:490a:: with SMTP id w10mr40549380pga.6.1561501416111;
 Tue, 25 Jun 2019 15:23:36 -0700 (PDT)
Date:   Tue, 25 Jun 2019 15:23:28 -0700
In-Reply-To: <20190625222329.209732-1-allanzhang@google.com>
Message-Id: <20190625222329.209732-2-allanzhang@google.com>
Mime-Version: 1.0
References: <20190625222329.209732-1-allanzhang@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH bpf-next v5 1/2] bpf: Allow bpf_skb_event_output for a few
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

