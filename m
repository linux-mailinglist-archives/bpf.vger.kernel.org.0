Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9E911F7B56
	for <lists+bpf@lfdr.de>; Fri, 12 Jun 2020 18:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbgFLQCB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Jun 2020 12:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgFLQCB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Jun 2020 12:02:01 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32EF7C08C5C2
        for <bpf@vger.kernel.org>; Fri, 12 Jun 2020 09:02:00 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id j10so10262117wrw.8
        for <bpf@vger.kernel.org>; Fri, 12 Jun 2020 09:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CFpEfyDCKd+ROB+iqmoyjwPMNPUKHkA0Y5oDot+dn0s=;
        b=qAABzAjm7oyQ4y1NqFm33ALKrsWUTBS3S09jG4BqvwbL0xCN56LMsAbtG51HFlJJAZ
         3lEuMT+JxCIBTR/jTJile+umYMucfLBAk2oSartCDjmFOPV8RlhVnJYKxMHsbyjWFfDw
         7eX9x99JBypZN8IsO8/xQR9TZ/5a98L1iUGqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CFpEfyDCKd+ROB+iqmoyjwPMNPUKHkA0Y5oDot+dn0s=;
        b=W33QpLB7QkD+ZeSznmd65hokG1eFwqPf3YXRfULkoklsAfNMinHyaMLPtz0fuRGP9S
         1x7CHrwfN2u5N4w/3MnZNEPQ3Mb2GJieFqobzJkkOnAOwA9No6iZ6JN8fCMka/Cl7nLn
         H96Qpuf6E65d828xNlswyfiUzr6teu9wuNnjeGzCYV/w7wK7QQJBK4IyG9Rh14DWZPjb
         gzat9PciFpgdtPhv03YJhf6S9N765yW+4tJXUQRPKmiaqr0rtoOYNZUBcuXHGDbj0dUV
         hFa8gFIM7vUyFgyHp9BCPunscXLrpOVehYTpa8co5G/DVqhHfUdW0PI0PWXLbQw3ogX4
         IKOg==
X-Gm-Message-State: AOAM532mv4M3+oIY56iOz64YgWRZgrKGuTg2x5fnDRfVmGg46oOBJOLJ
        0GyovvdgmFdcM8fYN2INyTLCNw==
X-Google-Smtp-Source: ABdhPJzJqYbDDGNdygvO/gn5chT5tfnHECzwSmpvROBRkZCI0/ho0BoMfKX6FdsDVl3UTVhkTu/MAQ==
X-Received: by 2002:a5d:498b:: with SMTP id r11mr14866701wrq.328.1591977718846;
        Fri, 12 Jun 2020 09:01:58 -0700 (PDT)
Received: from antares.lan (1.e.7.e.0.1.3.6.1.5.d.2.f.1.0.9.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:901f:2d51:6310:e7e1])
        by smtp.gmail.com with ESMTPSA id k16sm11169941wrp.66.2020.06.12.09.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 09:01:57 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Sitnicki <jakub@cloudflare.com>
Cc:     kernel-team@cloudflare.com, Lorenz Bauer <lmb@cloudflare.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf 1/2] flow_dissector: reject invalid attach_flags
Date:   Fri, 12 Jun 2020 17:01:40 +0100
Message-Id: <20200612160141.188370-1-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Using BPF_PROG_ATTACH on a flow dissector program supports neither flags
nor target_fd but accepts any value. Return EINVAL if either are non-zero.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
Fixes: b27f7bb590ba ("flow_dissector: Move out netns_bpf prog callbacks")
---
 kernel/bpf/net_namespace.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/net_namespace.c b/kernel/bpf/net_namespace.c
index 78cf061f8179..56133e78ae4f 100644
--- a/kernel/bpf/net_namespace.c
+++ b/kernel/bpf/net_namespace.c
@@ -192,6 +192,9 @@ int netns_bpf_prog_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 	struct net *net;
 	int ret;
 
+	if (attr->attach_flags || attr->target_fd)
+		return -EINVAL;
+
 	type = to_netns_bpf_attach_type(attr->attach_type);
 	if (type < 0)
 		return -EINVAL;
-- 
2.25.1

