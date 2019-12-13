Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50EA511EDC1
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2019 23:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfLMWab (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Dec 2019 17:30:31 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:41569 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfLMWab (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Dec 2019 17:30:31 -0500
Received: by mail-pf1-f201.google.com with SMTP id x6so2390657pfx.8
        for <bpf@vger.kernel.org>; Fri, 13 Dec 2019 14:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=xs6hmuczS0hO51qmaqI8L7AH60C1Pdqap+3M8jD3QsU=;
        b=WQ7ACeq8I2h1w6V4Kbp8cwMZfcHg6tDYc5FDRG6a8wnt+rNyf+c2spMGzQFoHdMlDe
         u8QoM6lMvz4nr3ihZcs6NC2Bmm9ymqtMjmULKDuDCVfXRIhqsp2xII7uVXPmGTZYTDKo
         L8XgHdLR4By6QyTxRP6f8SjlzUv9c3193XDaVlS0IDhPOCUsvhEAIFIMEsyO/rRQ7Dzm
         WcV1cRKjhpPeiF6SLI0gBw6kUFV6NOT/b9hstU+ifuw5K7iWbx1TfA1LSo0Id4iHAevM
         zCwxz9uru2nR3uvtTJQCoM0arqPoGNaksGftrWNGgj6EuUgm8hmnHsE2rCG4430MHaD5
         t8Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=xs6hmuczS0hO51qmaqI8L7AH60C1Pdqap+3M8jD3QsU=;
        b=ggqRZyqu45q4BIuSijrJ0tN45MEPfk80zWjE01o82nPam6FmObJGjE4VgnI5DZcOzH
         e/Y7azvleDMRkUq2B2+5AGVrTzX+a/29CYz6tIjvm+/YDI3DRuKEnbl4J6t5UI/X/iVT
         +nJoreujrOskepBoV19z/Cl4Hn3M180AzILGU0A4Q9BeeRKe8ag7724/acSKQMnOmo+T
         MlpdSYAOC1alAAPFeibHX02D6RQqSNeY/nxvCZRzeRlC29R16sl/4sLhrWqk64Oi0l/a
         cxJv+eizXwhQUkPIp3WCesdzCZ/fqSSlpmIJ3Y4dV3VOkwup8GnUoJsYrg6R8sdhodZ/
         TJhw==
X-Gm-Message-State: APjAAAVC/+vGjVVx5iTSeai3cjie/WOGpgrUtRv6D/h23FxzpSfTUE8V
        TZxDU2y0FpfbNjNNXwlOH6pT/NU=
X-Google-Smtp-Source: APXvYqwuGcwSVWOpdkI3+6IUij0d5thCkrFKFEm+ovRGF/lh8lxC4ucQX05HnZDKV1UrTwbcKMBSONc=
X-Received: by 2002:a63:fb05:: with SMTP id o5mr2071216pgh.355.1576276230884;
 Fri, 13 Dec 2019 14:30:30 -0800 (PST)
Date:   Fri, 13 Dec 2019 14:30:27 -0800
Message-Id: <20191213223028.161282-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH bpf-next v2 1/2] bpf: expose __sk_buff wire_len/gso_segs to BPF_PROG_TEST_RUN
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>,
        Martin KaFai Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

wire_len should not be less than real len and is capped by GSO_MAX_SIZE.
gso_segs is capped by GSO_MAX_SEGS.

v2:
* set wire_len to skb->len when passed wire_len is 0 (Alexei Starovoitov)

Cc: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 net/bpf/test_run.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 85c8cbbada92..f23707075f26 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -263,8 +263,10 @@ static int convert___skb_to_skb(struct sk_buff *skb, struct __sk_buff *__skb)
 		return -EINVAL;
 
 	/* tstamp is allowed */
+	/* wire_len is allowed */
+	/* gso_segs is allowed */
 
-	if (!range_is_zero(__skb, offsetofend(struct __sk_buff, tstamp),
+	if (!range_is_zero(__skb, offsetofend(struct __sk_buff, gso_segs),
 			   sizeof(struct __sk_buff)))
 		return -EINVAL;
 
@@ -272,6 +274,19 @@ static int convert___skb_to_skb(struct sk_buff *skb, struct __sk_buff *__skb)
 	skb->tstamp = __skb->tstamp;
 	memcpy(&cb->data, __skb->cb, QDISC_CB_PRIV_LEN);
 
+	if (__skb->wire_len == 0) {
+		cb->pkt_len = skb->len;
+	} else {
+		if (__skb->wire_len < skb->len ||
+		    __skb->wire_len > GSO_MAX_SIZE)
+			return -EINVAL;
+		cb->pkt_len = __skb->wire_len;
+	}
+
+	if (__skb->gso_segs > GSO_MAX_SEGS)
+		return -EINVAL;
+	skb_shinfo(skb)->gso_segs = __skb->gso_segs;
+
 	return 0;
 }
 
@@ -285,6 +300,8 @@ static void convert_skb_to___skb(struct sk_buff *skb, struct __sk_buff *__skb)
 	__skb->priority = skb->priority;
 	__skb->tstamp = skb->tstamp;
 	memcpy(__skb->cb, &cb->data, QDISC_CB_PRIV_LEN);
+	__skb->wire_len = cb->pkt_len;
+	__skb->gso_segs = skb_shinfo(skb)->gso_segs;
 }
 
 int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
-- 
2.24.1.735.g03f4e72817-goog

