Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 387641EA7CB
	for <lists+bpf@lfdr.de>; Mon,  1 Jun 2020 18:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgFAQ23 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Jun 2020 12:28:29 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45273 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgFAQ23 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Jun 2020 12:28:29 -0400
Received: by mail-lj1-f196.google.com with SMTP id z18so8844915lji.12;
        Mon, 01 Jun 2020 09:28:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wA7BfujTPj1qembVtD2LciwQ5JvA3WupaYltj/e17PM=;
        b=LefSgdmZ9pcH3ZjUIbneCndRe/HwLDeyUUFO5p68pF606N61Kj6gHx8kDq62IZ0Fg2
         YiUwJGS1l/fRHqTzqw2pp8IwsTBQsZVU+tJy9+5AVlOCj0c1BoRhmo5TZsaXMjUDSyOn
         n3NWFChcQ+gL+gSrIWq2zcv0CAzSXluChT8wVaDubhfYx0ElQW+JwWPFwEdddQ44yVW4
         K41IVQVY+/MO0xEOAM9hfyLyirMIcE0VbpTDLK26I4NpQExkHKVsDGPQZ9jTAXstwp+I
         o8/asxXPOhn4t8nwmpfS+HvKu46wF3rajkLndHZdjgh6eZ4F8O7akOBRT/4wJ9drkqVy
         DAXg==
X-Gm-Message-State: AOAM533egwsOtepingpyn7+U1wosanQSVqbHwv9I14yWlAeBX6S1YVY7
        E5idKitZMedvHFFVn4JCsPY=
X-Google-Smtp-Source: ABdhPJzNbJ7fb1vwvku/f6zE5giXztzWd/NuoN8ATJ21ABiySmrFmGgF0WU9m5f1iw/dToi+dh8vlA==
X-Received: by 2002:a2e:9b09:: with SMTP id u9mr2745294lji.207.1591028906891;
        Mon, 01 Jun 2020 09:28:26 -0700 (PDT)
Received: from localhost.localdomain (broadband-37-110-38-130.ip.moscow.rt.ru. [37.110.38.130])
        by smtp.googlemail.com with ESMTPSA id y1sm4595ljh.1.2020.06.01.09.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 09:28:25 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>
Cc:     Denis Efremov <efremov@linux.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] bpf: Change kvfree to kfree in generic_map_lookup_batch()
Date:   Mon,  1 Jun 2020 19:28:14 +0300
Message-Id: <20200601162814.17426-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

buf_prevkey in generic_map_lookup_batch() is allocated with
kmalloc(). It's safe to free it with kfree().

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 kernel/bpf/syscall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 4e6dee19a668..10bb622be5b6 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1383,7 +1383,7 @@ int generic_map_lookup_batch(struct bpf_map *map,
 
 	buf = kmalloc(map->key_size + value_size, GFP_USER | __GFP_NOWARN);
 	if (!buf) {
-		kvfree(buf_prevkey);
+		kfree(buf_prevkey);
 		return -ENOMEM;
 	}
 
-- 
2.26.2

