Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBA964BF9
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2019 20:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbfGJSST (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Jul 2019 14:18:19 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:34583 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbfGJSSS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Jul 2019 14:18:18 -0400
Received: by mail-pl1-f202.google.com with SMTP id 71so1730489pld.1
        for <bpf@vger.kernel.org>; Wed, 10 Jul 2019 11:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=CoB9liE3EbOvg+QhUkmIi9lXsQFgqf0bkDVpuEXwtJY=;
        b=gwh+NYaJzQ+2xBLucBxpPwkNsciOhEmM3V6OY7UwVr6/Cv34uDgQdnMcfqqeYek89X
         /SZk9LY+3T/cyPMI8JbBHw+HKGX5QvCjwmINEE+TRuM1LpBf6OjpqzHLpQW2uCLiqsvS
         T5K7KuFaDg2NbuOae27XtVaj/6IfrJqMtYgPAEYjGIWn3J27vR+4ZB2a2fFafVe7uXUh
         OofyU4WOSbQcm6WBnQQWOAKuwgU/Bf2/8uS5It9xaOYOhBIwSwbgwPZCuH48VSvrCv+6
         L4XaEvv3+6IK/3DxcsbuQwtX2GZQgraLIsmTyCpIfI12Mq9W86KGGJGyi5Rf5xLuNSR+
         MTLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CoB9liE3EbOvg+QhUkmIi9lXsQFgqf0bkDVpuEXwtJY=;
        b=lhcKyAAhuwcRY4VSx/sJ2INC6a7i2FGh5e9CjLuGh1NoHlClXJddn8ukch3O4oibMJ
         MAjOb/74m9fpV5lvpF10BIEFXLNtahlrYIg9067iWgSHI3NImS4awesI8iVLXx2BjbZR
         N2uvSOU6MkHycvv7r73iF/wQW17RP+qwj2Qa5FE1IxQ7rjDzB7cIRTTDHgHdJVlxpruJ
         Du3JR3P4h5+N4ZtIByHdBIqLCnR7dGr2pG7ba8KZfkqBknoobO1+1zj/vwK3vF+/Fk/K
         XgJgLEkUbqhQehaRizA5vTKARXWWCGUXdqUH2YCzp7KFDWspJesV9+BX/lQXpEgbuJI7
         A0tQ==
X-Gm-Message-State: APjAAAVOQbeJB3NJ2deln8MWCF0kPx6gi3LaqI1LA5WEGov39K4lTvTA
        a4YCnptN64n5aJcyNy8o9hYYRsyOReaOil1H
X-Google-Smtp-Source: APXvYqz48ZYwhnpuG0hZC5LF81vRRaawzpki7vhQPvCjDkIgKgd8/4ungpaGlfrEpKO/bi8JWkuAzBL0ysmRomW9
X-Received: by 2002:a63:e907:: with SMTP id i7mr3904359pgh.84.1562782697620;
 Wed, 10 Jul 2019 11:18:17 -0700 (PDT)
Date:   Wed, 10 Jul 2019 11:18:10 -0700
In-Reply-To: <20190710181811.127374-1-allanzhang@google.com>
Message-Id: <20190710181811.127374-2-allanzhang@google.com>
Mime-Version: 1.0
References: <20190710181811.127374-1-allanzhang@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH bpf-next v9 1/2] bpf: Allow bpf_skb_event_output for a few
 prog types
From:   Allan Zhang <allanzhang@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org, songliubraving@fb.com,
        daniel@iogearbox.net, andrii.nakryiko@gmail.com
Cc:     ast@kernel.org, allanzhang <allanzhang@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: allanzhang <allanzhang@google.com>

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

Signed-off-by: Allan Zhang <allanzhang@google.com>
Acked-by: Song Liu <songliubraving@fb.com>
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

