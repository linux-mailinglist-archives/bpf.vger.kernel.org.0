Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC6CC1542D9
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2020 12:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbgBFLRB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Feb 2020 06:17:01 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36399 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727711AbgBFLRB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Feb 2020 06:17:01 -0500
Received: by mail-wm1-f68.google.com with SMTP id p17so6586666wma.1
        for <bpf@vger.kernel.org>; Thu, 06 Feb 2020 03:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nIlzmnuGbQ2s9OOF5KBjiszKfyvFG7EgReUilYMF170=;
        b=CL1Z3Xv+QKCxkFq0NnohuC58jj5Qxj1TTqUyoPs1QgWHRXdTSl6mjkxQUBQ00tMUsd
         cHuA/yxZd8fy9dTFJbGXb+S/wJ954oB8/XpBhbDvp0zJMLqD8eZL+kZdi2MV9FvBWFp6
         4ETn/kFdZggRb4dwyzt5Af8G23EKgbpE+Yw7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nIlzmnuGbQ2s9OOF5KBjiszKfyvFG7EgReUilYMF170=;
        b=I31ncgvIOXSmYzSRefx2RwIml0oDukth3Ymm6D88EbKEeqyh8P86tsTGhWx6y7HZNf
         QFvtcsuNNqq0u3yWrokkhnVbC6X+zzokeUV0GHjzYi+zjNEaBPlmHUV4M+2PG7I4ECNN
         bZ3XLWqhUkHco5GIxKPaqc1//Ca7X+aILCP63itM4m0iPppaTsXSk8uXvd/9eYnX04z/
         xPC+uTJHmrtsXU+ISWNI6BLgDMuMN/Tf4e3nBI0P/f0R+jdLaQpGxLf36kpwWjKVwDTb
         UNh2NxXqbj6MDVHAfj5Fe+/SAoEru//s0QC7aqgxa+jUOnsqAvd/oTKKgWnJFz1C1uLc
         Grhg==
X-Gm-Message-State: APjAAAU+xr0vUMgFDsPYwx1YmIx2CjNYZ/TkXgWCAfUDhlmrrXS/DNwO
        nEd8BXxkzFQt63Iii8aqpFyd0WB4KJfYIg==
X-Google-Smtp-Source: APXvYqxhqYVjHUfuM592EPJrzi2sRweB6kMS6bjGdxSL+q179bAdsGIKoGC8KkTU2kVJNJaFpzNM9w==
X-Received: by 2002:a1c:8086:: with SMTP id b128mr3831020wmd.80.1580987818575;
        Thu, 06 Feb 2020 03:16:58 -0800 (PST)
Received: from cloudflare.com ([176.221.114.230])
        by smtp.gmail.com with ESMTPSA id c4sm3238687wml.7.2020.02.06.03.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 03:16:57 -0800 (PST)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com,
        John Fastabend <john.fastabend@gmail.com>
Subject: [PATCH bpf 2/3] bpf, sockhash: synchronize_rcu before free'ing map
Date:   Thu,  6 Feb 2020 12:16:51 +0100
Message-Id: <20200206111652.694507-3-jakub@cloudflare.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200206111652.694507-1-jakub@cloudflare.com>
References: <20200206111652.694507-1-jakub@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

We need to have a synchronize_rcu before free'ing the sockhash because any
outstanding psock references will have a pointer to the map and when they
use it, this could trigger a use after free.

This is a sister fix for sockhash, following commit 2bb90e5cc90e ("bpf:
sockmap, synchronize_rcu before free'ing map") which addressed sockmap,
which comes from a manual audit.

Fixes: 604326b41a6fb ("bpf, sockmap: convert to generic sk_msg interface")
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/core/sock_map.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index fd8b426dbdf3..f36e13e577a3 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -250,6 +250,7 @@ static void sock_map_free(struct bpf_map *map)
 	}
 	raw_spin_unlock_bh(&stab->lock);
 
+	/* wait for psock readers accessing its map link */
 	synchronize_rcu();
 
 	bpf_map_area_free(stab->sks);
@@ -873,6 +874,9 @@ static void sock_hash_free(struct bpf_map *map)
 		raw_spin_unlock_bh(&bucket->lock);
 	}
 
+	/* wait for psock readers accessing its map link */
+	synchronize_rcu();
+
 	bpf_map_area_free(htab->buckets);
 	kfree(htab);
 }
-- 
2.24.1

