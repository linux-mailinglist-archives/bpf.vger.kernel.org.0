Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCC1C5D40E
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2019 18:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfGBQO2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Jul 2019 12:14:28 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:34397 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbfGBQO1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Jul 2019 12:14:27 -0400
Received: by mail-pf1-f202.google.com with SMTP id i2so11135088pfe.1
        for <bpf@vger.kernel.org>; Tue, 02 Jul 2019 09:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qE7suO2UFdUOl1bpnieLTUEEVsWprC362QKm2f24m1I=;
        b=XiQtO1DME3wcd5SCB4YdN1LYplzMNGMSuGLeXa2eYVb9gQ5OHo2Vi/R6oJr7RstZH+
         oq+fuQHJlGp6dowSzFHdU5ndkxOjHcH37fw2yJC+uQJjPr/1OKtYVdbdSryE8yhFqOKr
         HzJLgjEjekbpC9ghDnwJcJMxQm1LCyBak0cnXbYI/Znray5/Q4FyKtrAfg7wMyixW4PG
         qCgHPbDNXAA7WGF+LT1nJ/LSDF33vLsRxOAPPpUzG1TrPNi59SdEavxo+EZqV6IESgHx
         vQ8TWq9sQRyzGVeJCm5R/8n5fqlGg0ob9BlZAWDpbPltrmboYvdC7z3RxWrf+C+B8Vm+
         Vlyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qE7suO2UFdUOl1bpnieLTUEEVsWprC362QKm2f24m1I=;
        b=U3q/BAZGSiMSApbaI7vXMuYQXtqDedWHgPRo/GHy3RLHViiEWVn+lNIi5jDO3ckPxa
         r5FVBbofkUeoaMYFpCVr1lJvoypkBvrZ+GqLr1U1FnXXOsTdH70s2eG1lWWLJXryXX66
         ZZy66iAbWWpbDL0vNG8jjnqbqH1FK8on7XDpkCEXpPuNm1fpqZtJleVIwrV54cms/GHW
         4TiaH4zR1qqsA0Rlj2O2wiPX5oap1tIA1cg3AgXbP5OddvTyHWYEz8y0lSpIT2c5RmOS
         vqdS0+T/oprEb9Hlz4nfVNOqdgskdOoU61zAOHUGAVQCqCpDbhCin9gZFzRzcYQg1LEH
         9LQw==
X-Gm-Message-State: APjAAAUOVQbGWsNt3Ag2KyhLM1LPfVhl+2Gxhmo4S5mA9y9jcwlhEKck
        K0eV5/BUkzt2KA+nXQX4IgeCJww=
X-Google-Smtp-Source: APXvYqwznCVcMsVuucOGPPCknJOX6GBJT2rd+FNqfh4ENBG7v6QZ/GecD3M22ouChVCv0SvTVNexja8=
X-Received: by 2002:a63:490a:: with SMTP id w10mr30955818pga.6.1562084066857;
 Tue, 02 Jul 2019 09:14:26 -0700 (PDT)
Date:   Tue,  2 Jul 2019 09:14:03 -0700
In-Reply-To: <20190702161403.191066-1-sdf@google.com>
Message-Id: <20190702161403.191066-9-sdf@google.com>
Mime-Version: 1.0
References: <20190702161403.191066-1-sdf@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH bpf-next v2 8/8] samples/bpf: fix tcp_bpf.readme detach command
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        Yuchung Cheng <ycheng@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Copy-paste, should be detach, not attach.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
Acked-by: Yuchung Cheng <ycheng@google.com>
---
 samples/bpf/tcp_bpf.readme | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/bpf/tcp_bpf.readme b/samples/bpf/tcp_bpf.readme
index fee746621aec..78e247f62108 100644
--- a/samples/bpf/tcp_bpf.readme
+++ b/samples/bpf/tcp_bpf.readme
@@ -25,4 +25,4 @@ attached to the cgroupv2).
 
 To remove (unattach) a socket_ops BPF program from a cgroupv2:
 
-  bpftool cgroup attach /tmp/cgroupv2/foo sock_ops pinned /sys/fs/bpf/tcp_prog
+  bpftool cgroup detach /tmp/cgroupv2/foo sock_ops pinned /sys/fs/bpf/tcp_prog
-- 
2.22.0.410.gd8fdbe21b5-goog

