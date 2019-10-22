Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51A0CE0310
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2019 13:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731936AbfJVLhj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Oct 2019 07:37:39 -0400
Received: from mail-lf1-f52.google.com ([209.85.167.52]:41563 "EHLO
        mail-lf1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387474AbfJVLhh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Oct 2019 07:37:37 -0400
Received: by mail-lf1-f52.google.com with SMTP id x4so6510169lfn.8
        for <bpf@vger.kernel.org>; Tue, 22 Oct 2019 04:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xo1fyKX+7Sd9n19IL2v+0Ngzo9bK986LfFjLpFdWIA4=;
        b=lPDEhgGnKjHK3JW9+lHXUDMa6GUyisSi0HMCl/m8GZdiVQWJDQqB4hFGtdlwF0kDwI
         DhywtEV+1sRCbeIK7pfjc2d+lWqFLCb0U5WOtAIBGrsYuF2BQXOxaGIaYzPItZN03vJV
         a+AtyMHSciua3aLgwwRec2zSrq/mTFve4GJT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xo1fyKX+7Sd9n19IL2v+0Ngzo9bK986LfFjLpFdWIA4=;
        b=W15V8rNJvQuFj4pXWPZIiBUHrkpxHRaSpIR29hl3MXMsQuJC5CjGpbrIALBxTbTouw
         AkQwmw7zwiU0KCPR8EYNljSZzYhWZpOMaqwYBcJ3bwNQm+ZSCde+9wO4zDSyAZgV//7U
         Zhv93X6KgQaa3ozicX0nBRotYLpi4awj+OjV9ZopPZT8b97oZt7taIGd6YC3ZQSBDf8h
         zauSQiowhT35p8pzFlZBbKPfPOWjvnOYATtopr+wewjxTa02+cVX9jKDNV1MIfxGwbIy
         TWdO+QnjNFFF/MANawmQxw0UZiWc6kQ/+B3A8iqHEXRGHTU6B5DfW+20FPB9SiBnfm/5
         3a4A==
X-Gm-Message-State: APjAAAVFoL+VlaoXWNZ3FhfLOhln8GnTI7gkCf1qhSCojZGa+iRto1Qo
        BOWPboxgxixP/6TmMX8RHBXpBeNKlcJz1Q==
X-Google-Smtp-Source: APXvYqxf5RtsP3+8l0+YbiaCq2NOPMWDoMe5AdFeLHwy2MXfNM8EU0LhQhGp2+Ugml2geRnRvpcsMQ==
X-Received: by 2002:ac2:5108:: with SMTP id q8mr14029087lfb.150.1571744254892;
        Tue, 22 Oct 2019 04:37:34 -0700 (PDT)
Received: from cloudflare.com ([176.221.114.230])
        by smtp.gmail.com with ESMTPSA id i190sm14857960lfi.45.2019.10.22.04.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 04:37:34 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>, netdev@vger.kernel.org,
        kernel-team@cloudflare.com
Subject: [RFC bpf-next 2/5] bpf, sockmap: Allow inserting listening TCP sockets into SOCKMAP
Date:   Tue, 22 Oct 2019 13:37:27 +0200
Message-Id: <20191022113730.29303-3-jakub@cloudflare.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191022113730.29303-1-jakub@cloudflare.com>
References: <20191022113730.29303-1-jakub@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In order for SOCKMAP type to become a generic collection for storing socket
references we need to loosen the checks in update callback.

Currently SOCKMAP requires the TCP socket to be in established state, which
prevents us from using it to keep references to listening sockets.

Change the update pre-checks so that it is sufficient for socket to be in a
hash table, i.e. have a local address/port, to be inserted.

Return -EINVAL if the condition is not met to be consistent with
REUSEPORT_SOCKARRY map type.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/core/sock_map.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index facacc296e6c..222036393b90 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -415,11 +415,14 @@ static int sock_map_update_elem(struct bpf_map *map, void *key,
 		ret = -EINVAL;
 		goto out;
 	}
-	if (!sock_map_sk_is_suitable(sk) ||
-	    sk->sk_state != TCP_ESTABLISHED) {
+	if (!sock_map_sk_is_suitable(sk)) {
 		ret = -EOPNOTSUPP;
 		goto out;
 	}
+	if (!sk_hashed(sk)) {
+		ret = -EINVAL;
+		goto out;
+	}
 
 	sock_map_sk_acquire(sk);
 	ret = sock_map_update_common(map, idx, sk, flags);
-- 
2.20.1

