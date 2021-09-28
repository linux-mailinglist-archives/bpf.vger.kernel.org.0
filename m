Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADD9041A594
	for <lists+bpf@lfdr.de>; Tue, 28 Sep 2021 04:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238564AbhI1CkG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Sep 2021 22:40:06 -0400
Received: from mail-ed1-f41.google.com ([209.85.208.41]:34311 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238594AbhI1CkG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Sep 2021 22:40:06 -0400
Received: by mail-ed1-f41.google.com with SMTP id g7so17733873edv.1;
        Mon, 27 Sep 2021 19:38:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cD/UYSHZ63JD3qjvCaBVJYGEIaKDyI789/WGWRdPfyA=;
        b=gjwDskgEf3kSThRfoLewbGzJOTqrphFETfiDMEX0ORaMgOSGEYfX/+J7uYJsx/QIBr
         AgFfmqKqUQpyG7kY99mtjnQMaZRShIsq7DMN3AG5E/Q4SIEzBffhGO4BtWgyDQK/n0bv
         V/+yGqgcbWfdCvRjWmisw4eyXwpLoBDpmmDez920pwaPn4iqIs3O9vLRRCxdr5RyuGTM
         sv9ucI1VHo+/t7K8b6Vb6YssGHiRxuesIFy3DpPCYYeVrgA1cjaDbOnwUDxFu/UMu1bl
         Yvt6L9XpciDPfRujQKFO3JmkTIzWiPWmalzQ1RZJykLThBvBNULqjYve297UbLBZNNZZ
         xLgA==
X-Gm-Message-State: AOAM531uXRB0S2FoKU3lpp/CTR1JRMx4gd5M4Ccxw7+8TdwetbFowAzj
        x7r6gkRMcd9tHFg5fHKKIqu6nGUzW4YFSyxX
X-Google-Smtp-Source: ABdhPJyIEairgM93wB1PNg91ByqlFoPuvltXZEuG/zwxXhT9h5XdPis9pKJvLE1OhEn/eJZPOquh/g==
X-Received: by 2002:a50:d80d:: with SMTP id o13mr4687250edj.204.1632796706648;
        Mon, 27 Sep 2021 19:38:26 -0700 (PDT)
Received: from msft-t490s.. (mob-31-159-85-51.net.vodafone.it. [31.159.85.51])
        by smtp.gmail.com with ESMTPSA id b13sm13004485ede.97.2021.09.27.19.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 19:38:26 -0700 (PDT)
From:   Matteo Croce <mcroce@linux.microsoft.com>
To:     bpf@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Yonghong Song <yhs@fb.com>
Subject: [PATCH bpf] samples: bpf: fix test_lru_dist
Date:   Tue, 28 Sep 2021 04:38:16 +0200
Message-Id: <20210928023816.14488-1-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Matteo Croce <mcroce@microsoft.com>

Fix this build error:

  CC  samples/bpf/test_lru_dist
samples/bpf/test_lru_dist.c:36:8: error: redefinition of ‘struct list_head’
   36 | struct list_head {
      |        ^~~~~~~~~

This happens even after running `make headers_install`

Signed-off-by: Matteo Croce <mcroce@microsoft.com>
---
 samples/bpf/xdp_redirect_map_multi.bpf.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/samples/bpf/xdp_redirect_map_multi.bpf.c b/samples/bpf/xdp_redirect_map_multi.bpf.c
index 8f59d430cb64..bb0a5a3bfcf0 100644
--- a/samples/bpf/xdp_redirect_map_multi.bpf.c
+++ b/samples/bpf/xdp_redirect_map_multi.bpf.c
@@ -5,11 +5,6 @@
 #include "xdp_sample.bpf.h"
 #include "xdp_sample_shared.h"
 
-enum {
-	BPF_F_BROADCAST		= (1ULL << 3),
-	BPF_F_EXCLUDE_INGRESS	= (1ULL << 4),
-};
-
 struct {
 	__uint(type, BPF_MAP_TYPE_DEVMAP_HASH);
 	__uint(key_size, sizeof(int));
-- 
2.31.1

