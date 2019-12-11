Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05A8711BAAF
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2019 18:53:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730431AbfLKRxw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Dec 2019 12:53:52 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:55875 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730174AbfLKRxw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Dec 2019 12:53:52 -0500
Received: by mail-pf1-f202.google.com with SMTP id o71so2518287pfg.22
        for <bpf@vger.kernel.org>; Wed, 11 Dec 2019 09:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ZJ1oDyTzeXeW7N9+MWcw6Erx6CiN4LkWGkKMDboif64=;
        b=UEJDUel8+0mbaKzZkv5PN5vaSzLDpVZyCmC9O4Kr9JA44Q1Vf0cVw1Ksa/qoerfutZ
         oYFMs1CY+K8GlNR8+MaQJ6ew63QpIr61vK3GPfZEZHpwevAyDBb2URMbL4Z51Znd5NQu
         XC9DgrsZlmqYfLbt6ceiMjj0iolNVbAp2/0WW8ml38ehYA/0K9zQK2ikqxTvwAYGLD4A
         V2G1Ek1GxZPJOA3ZN1ZtBdyUw2FRV0qPeSI6qjmx/gYuLRGcag/AdEvM/w7kI4SdBh+Z
         5/Srm1oGpjXhKnjcQzYpk/Ze1rs2zDhOv+/tbRMRF4OLMDXtZOHvXYgNCZpQ6bmii0AN
         jCFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ZJ1oDyTzeXeW7N9+MWcw6Erx6CiN4LkWGkKMDboif64=;
        b=s9D5neP1byxuJtznUAZqO8x+LfQnLi31PNUcTmKcTRRXqCVEt/kYivkSPyRpDVmIA7
         RBheoDN5udgrnwhrY3m32pZ1Ckfg0lbvyK0K6GxgQCIfoK+BlD9ZL3Dhsz2R4U6BmpRf
         7ucO6d+KV5Tk1L5EENOIHRxcgZcC5AILSTbhdIY1cIErLyLBEJDkfSLmEVlljfEmdDFi
         n/LByUnMfPyw771Dq9GD2yTMRhPf8I2SjIN3kEMT1RBapDcn4p4T3p8Qy3zFO/1u4JRA
         z49SGl60C5yaI3D2DTuxmqyITKpfAOOafDPBTV79VMOlxNd+bTT5eO07ffHKYfdi+8qz
         c48g==
X-Gm-Message-State: APjAAAVwbFgJa/Uswt4cxya6Zj4C4TfjULJ6Uc79F9y+zgEjIQonD5+W
        ivGRkgg9z0HFZ5NLFv/NJfBKy48=
X-Google-Smtp-Source: APXvYqyK6BjDE2BnAYzWgZj9ST91PypaNH+s76eIB4XplW47dYQSCT8BstG2UT0rErnRTFHE4rShTZc=
X-Received: by 2002:a63:d543:: with SMTP id v3mr5389333pgi.285.1576086831333;
 Wed, 11 Dec 2019 09:53:51 -0800 (PST)
Date:   Wed, 11 Dec 2019 09:53:48 -0800
Message-Id: <20191211175349.245622-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.525.g8f36a354ae-goog
Subject: [PATCH bpf-next 1/2] bpf: expose __sk_buff wire_len/gso_segs to BPF_PROG_TEST_RUN
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

wire_len should not be less than real len and is capped by GSO_MAX_SIZE.
gso_segs is capped by GSO_MAX_SEGS.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 net/bpf/test_run.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 85c8cbbada92..06cadba2e3b9 100644
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
 
@@ -272,6 +274,14 @@ static int convert___skb_to_skb(struct sk_buff *skb, struct __sk_buff *__skb)
 	skb->tstamp = __skb->tstamp;
 	memcpy(&cb->data, __skb->cb, QDISC_CB_PRIV_LEN);
 
+	if (__skb->wire_len < skb->len || __skb->wire_len > GSO_MAX_SIZE)
+		return -EINVAL;
+	cb->pkt_len = __skb->wire_len;
+
+	if (__skb->gso_segs > GSO_MAX_SEGS)
+		return -EINVAL;
+	skb_shinfo(skb)->gso_segs = __skb->gso_segs;
+
 	return 0;
 }
 
@@ -285,6 +295,8 @@ static void convert_skb_to___skb(struct sk_buff *skb, struct __sk_buff *__skb)
 	__skb->priority = skb->priority;
 	__skb->tstamp = skb->tstamp;
 	memcpy(__skb->cb, &cb->data, QDISC_CB_PRIV_LEN);
+	__skb->wire_len = cb->pkt_len;
+	__skb->gso_segs = skb_shinfo(skb)->gso_segs;
 }
 
 int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
-- 
2.24.0.525.g8f36a354ae-goog

