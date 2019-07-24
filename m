Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41A6872340
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2019 02:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbfGXAHd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Jul 2019 20:07:33 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:56808 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbfGXAHd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Jul 2019 20:07:33 -0400
Received: by mail-qt1-f202.google.com with SMTP id x11so35459325qto.23
        for <bpf@vger.kernel.org>; Tue, 23 Jul 2019 17:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dvM0oMSPCj5UyjAMcKrkrGFrIFYWKvF2DUDR7yoEcJA=;
        b=FawtaYuxGKrAPTWB6bApVLEBtQfdjpvYNz6Dajd1VYSqxB/J3165GHUb53VJ3C5WxB
         rlJgNlOWx86Kagh+BuvCa1jYX8IhZM4c+lEWZ2CbzMvzrDjgnI2OHAHj35ZzOvnTt4iG
         05V9LscZpZnoyMxGjuThemZmqNb6eqn98DGpOqMleDzt2RqqgVyjP1ggGg6a3CvlN3IZ
         0iL51FXuIClXwZt1XjKNosYHzFl51anE1UqWA7VZ/z7AlxYaN68WtukOYmuQWr/fqDlH
         IqdRMozNaLVW7+DoQNNmOkyvTI6RzNtyQ6rCL3yxO/PRJMj/rFuFc+Z1mHFoxRSyx3r9
         XxHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dvM0oMSPCj5UyjAMcKrkrGFrIFYWKvF2DUDR7yoEcJA=;
        b=kPnzlDUUTFQmd2zdPgeIV405A4EqlKrXYDpnY2ALhVv+7yhCNGCuOocGRdcV8mIGEf
         Va0xFEOjuSJD8TfxR2skL3l5rTezNRAX4GCRMZYZAC/+Pa4KvJ+n1k1HxGnkwQh7gazd
         GFsfmNe6aBLZwz4vXUINGoJX2yG/Z18gekTe5CJj9r4q/Rhun04kYCP53tkxTa4xIQs+
         We6P8eVtK8Bp3d/AUNS01MXxVoc4gT/sbJ6l/D8NKrql2d8TGwPdithXLUasW5nwyZYY
         GaLoqUuS9lG8o5sSvFOfdb9psFK9uB2z526RYdwno4eK6G4cQ04QrVSGeGpgOfTwNKrx
         tCvw==
X-Gm-Message-State: APjAAAXy5h2JHtj40dianXyug38w2/h9H5S4N2sfMYiUvhLDomA2Hpws
        dgvv+v4RC/vOom0CSyW6kDXKx19huGtVLXN/
X-Google-Smtp-Source: APXvYqzzB8JH73VE761HLmAP7Yk9ptviUt4dTTiTjceQIvik/2HxitrwFp0k6FoRglGHwy2bDGRcpCE6GsSVKCh4
X-Received: by 2002:a37:b843:: with SMTP id i64mr49775055qkf.77.1563926852226;
 Tue, 23 Jul 2019 17:07:32 -0700 (PDT)
Date:   Tue, 23 Jul 2019 17:07:24 -0700
In-Reply-To: <20190724000725.15634-1-allanzhang@google.com>
Message-Id: <20190724000725.15634-2-allanzhang@google.com>
Mime-Version: 1.0
References: <20190724000725.15634-1-allanzhang@google.com>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
Subject: [PATCH bpf-next v10 1/2] bpf: Allow bpf_skb_event_output for a few
 prog types
From:   Allan Zhang <allanzhang@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org, songliubraving@fb.com,
        daniel@iogearbox.net, andrii.nakryiko@gmail.com
Cc:     ast@kernel.org, Allan Zhang <allanzhang@google.com>
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

Signed-off-by: Allan Zhang <allanzhang@google.com>
Acked-by: Song Liu <songliubraving@fb.com>
---
 net/core/filter.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 4e2a79b2fd77..3961437ccc50 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5999,6 +5999,8 @@ sk_filter_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_get_socket_cookie_proto;
 	case BPF_FUNC_get_socket_uid:
 		return &bpf_get_socket_uid_proto;
+	case BPF_FUNC_perf_event_output:
+		return &bpf_skb_event_output_proto;
 	default:
 		return bpf_base_func_proto(func_id);
 	}
@@ -6019,6 +6021,8 @@ cg_skb_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_sk_storage_get_proto;
 	case BPF_FUNC_sk_storage_delete:
 		return &bpf_sk_storage_delete_proto;
+	case BPF_FUNC_perf_event_output:
+		return &bpf_skb_event_output_proto;
 #ifdef CONFIG_SOCK_CGROUP_DATA
 	case BPF_FUNC_skb_cgroup_id:
 		return &bpf_skb_cgroup_id_proto;
@@ -6267,6 +6271,8 @@ sk_skb_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_sk_redirect_map_proto;
 	case BPF_FUNC_sk_redirect_hash:
 		return &bpf_sk_redirect_hash_proto;
+	case BPF_FUNC_perf_event_output:
+		return &bpf_skb_event_output_proto;
 #ifdef CONFIG_INET
 	case BPF_FUNC_sk_lookup_tcp:
 		return &bpf_sk_lookup_tcp_proto;
-- 
2.22.0.709.g102302147b-goog

