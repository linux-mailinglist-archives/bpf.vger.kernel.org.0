Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EACE45FC6F
	for <lists+bpf@lfdr.de>; Sat, 27 Nov 2021 04:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352357AbhK0DsO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Nov 2021 22:48:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234255AbhK0DqN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Nov 2021 22:46:13 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB40C0613F9
        for <bpf@vger.kernel.org>; Fri, 26 Nov 2021 18:43:46 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id u80so10531450pfc.9
        for <bpf@vger.kernel.org>; Fri, 26 Nov 2021 18:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hq6ZgMeGA34P1LXNrLLQ25FTZC96w6SlAoRtc3NTqRs=;
        b=hGzkxYhO1NfD7gtndMSJXe4m1ym6vFkPwU7JzzN7dVKMzUD9Iz1d+sYvVg+EOy1iTa
         RiIN/AsBRJnt0zDTRxSIjb7KBukw9RvAzn2XjCGlMNLgrmtL/N1OtYjpmm93x7BUgidu
         RDHE1pdkNLUAPgZcD1N057E+92R3WLhFu2f3S6yWbgL8PegQs4JtCX4GUgAV7a1TfJ30
         KzqhqZJYk3QGrZkd9tSuDKLPbWqgm70PijgKlIBY5GIhSG8gy4BqOHmQG5bdpDEXuaNq
         NX6tXho621FlnNKgQXWZs32yp6fpLu49F7vbX+gW3kE3w1uxiaqtsfZ187j1PrVoZ3SO
         +6mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hq6ZgMeGA34P1LXNrLLQ25FTZC96w6SlAoRtc3NTqRs=;
        b=ntfYcf9JXuNEu6MXNWB22m6vnofcB6Cptp1MbWK7wtDm7q8kqlzNjP1UDhA/moqVSx
         N7tVQd/YHNKEY/R9ORc5f7l58QLJulBt+y0dytLjjd4923gVbUeVeCG49LNJEcn2nNuA
         o+LK17KOohgZVznX2ZfawCLG7DOcsjgivCyXzdiZs4YKdHu2NI6yKbwVsBmxQGxq7veB
         Js7NoomYgLJ49leeNPUtfyLJEIkDsUv7z1Cj6TMW2mhQnzxdfE0X9q/8/Ox8AcDb7nJn
         zo7YPGHpnskUjP1BbyPXVjNWr993qJ4wx5kdJuN7BZI3GghxRwCZo5Or2Zp+Zg2aUutz
         Fr8g==
X-Gm-Message-State: AOAM530d0LAlCkxMR6D8TroM07Vam4sQTtQM1lk4LwfO5kdzv5IdBRtq
        G/J201kzDEHFxFCSiuau1Vdb7BGoVHY=
X-Google-Smtp-Source: ABdhPJxh9DFV8Louckv2dmFWB7GrdWAWqfUffvv2gwxM5vBw0sjJqu237qbWSLooKt7HPKjgCGEaNA==
X-Received: by 2002:a63:ce54:: with SMTP id r20mr24272594pgi.95.1637981025551;
        Fri, 26 Nov 2021 18:43:45 -0800 (PST)
Received: from localhost.localdomain ([68.170.74.242])
        by smtp.gmail.com with ESMTPSA id h3sm9208492pfc.204.2021.11.26.18.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 18:43:44 -0800 (PST)
From:   Mehrdad Arshad Rad <arshad.rad@gmail.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, Mehrdad Arshad Rad <arshad.rad@gmail.com>
Subject: [PATCH] libbpf: Remove duplicate assignments
Date:   Fri, 26 Nov 2021 18:43:25 -0800
Message-Id: <20211127024325.10949-1-arshad.rad@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

There is a same action when load_attr.attach_btf_id is initialized.

Signed-off-by: Mehrdad Arshad Rad <arshad.rad@gmail.com>
---
 tools/lib/bpf/libbpf.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 7c74342bb668..561bb97f25d6 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -6445,7 +6445,6 @@ load_program(struct bpf_program *prog, struct bpf_insn *insns, int insns_cnt,
 	load_attr.attach_btf_id = prog->attach_btf_id;
 	load_attr.attach_prog_fd = prog->attach_prog_fd;
 	load_attr.attach_btf_obj_fd = prog->attach_btf_obj_fd;
-	load_attr.attach_btf_id = prog->attach_btf_id;
 	load_attr.kern_version = kern_version;
 	load_attr.prog_ifindex = prog->prog_ifindex;
 
-- 
2.33.1

