Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 756B647FD39
	for <lists+bpf@lfdr.de>; Mon, 27 Dec 2021 14:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbhL0NHg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Dec 2021 08:07:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbhL0NHg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Dec 2021 08:07:36 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0162DC061757
        for <bpf@vger.kernel.org>; Mon, 27 Dec 2021 05:07:35 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id i8so5003644pgt.13
        for <bpf@vger.kernel.org>; Mon, 27 Dec 2021 05:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y24iSF3ID8CUJS4FrvPuWUAAeYS2AO0M/jvrLGgFbaw=;
        b=ZrIbG5bUpVdp4lZFLowZk4DxTKvkx1+CQ12zbAujnzKU/3o/oZliX8SF8mSeKscTIx
         wZlrh6q13r9Wh/coRRafQbspg07tbrhgIf1cHvEksbFr4cda2Nfc6ieTzTE+WNhjN6ie
         0+TPijORNIGlfxHSMgTKcQaLGSmp4HYeCzI0mL7XscBBVlSz5Pmqcw7mehJgFBy7wCUo
         w7CGuRLjHaiw5gzVYbB7+hNUgqfxHLVgZPdB3dPbTA9JLJSGBc5/PH2Ocq8rVmNnD8I8
         vXAwb7WM16/wmi1QohSiej50yB4nKc+99E3uxjEaRTYRPfbtXBvQajRKMV7JJJdg64Tf
         G79Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y24iSF3ID8CUJS4FrvPuWUAAeYS2AO0M/jvrLGgFbaw=;
        b=BzK4ZNsYwyNC4Bv8GFAEIEexICpkSbxAhnkb8ydYpIvAp3CdUxYFMqvDsdY5f88IOz
         XVMYrF9lQUpD3oHpU5r/VfvQOiWUc+g6zUe5xnnSn7oE0gjHJmq1KyxnvxRxB3yIrfjO
         ejNkRACC4xqXP7wcqVmkSLABImaB0g0ex/xuSDO6synSZwn7w6ZFH97aW+5WS3k3FSlE
         A7yQTasOMX2Lo88i1GXwCF9H9ZubkGVxbWQp72sl+X9kb6O0qw0HZeEjgBRkmFe9IlI+
         jgWGhGvaEVB37iqWr75njaB86kyvQlZTdtnmBDZbuJSZfzoILDt1uXeFVJnqK/sNxgT3
         TFXw==
X-Gm-Message-State: AOAM5303B4LiI7mEAbH6jdE7M1a8IFSBktWAcsX5QSkTIBE5bu76vWi4
        Vtr0tDKawHYHoL74wVIcy5+OMg==
X-Google-Smtp-Source: ABdhPJzKdxOFpsR/ezcVv2IbNLcTNk8WTaCUNsbNZ6DpCtojj8YifP//Qk2WQcO0cr4spwiYuZpXBA==
X-Received: by 2002:a63:3c0c:: with SMTP id j12mr6889915pga.305.1640610455270;
        Mon, 27 Dec 2021 05:07:35 -0800 (PST)
Received: from C02FJ0LUMD6V.bytedance.net ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id d21sm18060136pfv.45.2021.12.27.05.07.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Dec 2021 05:07:34 -0800 (PST)
From:   Qiang Wang <wangqiang.wq.frank@bytedance.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, hengqi.chen@gmail.com
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhouchengming@bytedance.com,
        songmuchun@bytedance.com, duanxiongchun@bytedance.com,
        shekairui@bytedance.com,
        Qiang Wang <wangqiang.wq.frank@bytedance.com>
Subject: [PATCH v2 1/2] libbpf: Use probe_name for legacy kprobe
Date:   Mon, 27 Dec 2021 21:07:12 +0800
Message-Id: <20211227130713.66933-1-wangqiang.wq.frank@bytedance.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix a bug in commit 46ed5fc33db9, which wrongly used the
func_name instead of probe_name to register legacy kprobe.

Fixes: 46ed5fc33db9 ("libbpf: Refactor and simplify legacy kprobe code")
Reviewed-by: Hengqi Chen <hengqi.chen@gmail.com>
Tested-by: Hengqi Chen <hengqi.chen@gmail.com>
Co-developed-by: Chengming Zhou <zhouchengming@bytedance.com>
Signed-off-by: Qiang Wang <wangqiang.wq.frank@bytedance.com>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 tools/lib/bpf/libbpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 7c74342bb668..b7d6c951fa09 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9735,7 +9735,7 @@ bpf_program__attach_kprobe_opts(const struct bpf_program *prog,
 		gen_kprobe_legacy_event_name(probe_name, sizeof(probe_name),
 					     func_name, offset);
 
-		legacy_probe = strdup(func_name);
+		legacy_probe = strdup(probe_name);
 		if (!legacy_probe)
 			return libbpf_err_ptr(-ENOMEM);
 
-- 
2.20.1

