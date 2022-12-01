Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5835763E6F1
	for <lists+bpf@lfdr.de>; Thu,  1 Dec 2022 02:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiLABLx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Nov 2022 20:11:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiLABLw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Nov 2022 20:11:52 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C073D89312
        for <bpf@vger.kernel.org>; Wed, 30 Nov 2022 17:11:51 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-3b5da1b3130so2379337b3.5
        for <bpf@vger.kernel.org>; Wed, 30 Nov 2022 17:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y3fJc9TKulHWMBNbVAiUgZeFm6RMMVoPZ7UAn1Qm6Jg=;
        b=i9G07n7bN7uXCT5koczjUAlMV/9nrAMTJUvx8kz7lUjDUFtte2hsJQURqy5D0H3diz
         SR9u1+pBg9GG9s5LM3jCqtbzZROWcufJRjUoCuyrGCHtT5S3yaNwYvtdkke8T0C793i+
         ijp4naqIFMrNLfSxmnNVjenlTMgi608uNwdEKncIPJshsQV/gQ+zbF2pzOhNAvILZQ6j
         s3bULlwUQam9fiL8qcTrxhscrTRlO83H2kQ9bGwUxEsR4qT1hXTkDNJkD7LAdCw/1YWS
         sYrExGcN9gaPLdUWVDGas9iU2oDy4ffs3TBba/dv03zKbtMv6Q90u+g1sMc4ramKYtji
         Qw8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y3fJc9TKulHWMBNbVAiUgZeFm6RMMVoPZ7UAn1Qm6Jg=;
        b=rxU0OOP0uDljUrr49i+/W3TIV5Z85tCjvSaR/8LAnTxtRS1X8vK1GnMGnRQQcRkiam
         2rajZXURjF9UQQnlsvJe2RT9hdvCeXxu9pep5HQglz4S5nqnVwTDd6T85QWgqgpNgIXm
         w0FdbZAskvxe+C/Dv6PpjCjnJZQQZhUCf/LGYqssspf40ALg72gNuYeXspb7HbFNeGdC
         SxThiijPKZLlNqb74o9zo62sVyDS2qyZFIk3PUpd0NLSbNazoxWRhcKmMEkq8Ybii+4e
         /5KaWkYl68+DHf6NJgGTqv3GGM7ody1EOh4dqbxZlTDra0cEBhw0ZfrswCTq3Ps8QxMK
         xpZA==
X-Gm-Message-State: ANoB5pkVnjaLBXOoBXPbFiTtOfsWDe9qtFpaERdVZeS2M6U745nUUp1J
        vnx/Ev2N7nnQZ0BAu7vrJKrgKGmkOkBj9DNzKTLuZcn9PxBDNI5uMxeCz2kOQVWl8ZpazjxzB8v
        kqEtYDqXlUmxnX4QFuV7d5BMxRJQxx0PuUiT6uo9eYFDPmWePM/7guCXmaSteW5pMbtfn
X-Google-Smtp-Source: AA0mqf7vOIWz6RLET7YI53wD6w1BnDXtG/oOfR33J/LHP2YP9qS8hC26SVgePVfCbzHZ39JwSDN3jorQc8Thu+1B
X-Received: from pnaduthota.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:4e5])
 (user=pnaduthota job=sendgmr) by 2002:a81:6c93:0:b0:3c8:f270:70bb with SMTP
 id h141-20020a816c93000000b003c8f27070bbmr16601869ywc.79.1669857110999; Wed,
 30 Nov 2022 17:11:50 -0800 (PST)
Date:   Thu,  1 Dec 2022 01:11:34 +0000
In-Reply-To: <20221201011135.1589838-1-pnaduthota@google.com>
Mime-Version: 1.0
References: <20221201011135.1589838-1-pnaduthota@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221201011135.1589838-2-pnaduthota@google.com>
Subject: [PATCH net-next v2 1/2] Ignore RDONLY_PROG for devmaps in libbpf to
 allow re-loading of pinned devmaps
From:   Pramukh Naduthota <pnaduthota@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org,
        Pramukh Naduthota <pnaduthota@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Ignore BPF_F_RDONLY_PROG when checking for compatibility for devmaps. The
kernel adds the flag to all devmap creates, and this breaks pinning
behavior, as libbpf will then check the actual vs user supplied flags and
see this difference. Work around this by adding RDONLY_PROG to the
users's flags when testing against the pinned map

Fixes: 57a00f41644f ("libbpf: Add auto-pinning of maps when loading BPF objects")
Signed-off-by: Pramukh Naduthota <pnaduthota@google.com>
---
 tools/lib/bpf/libbpf.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 50d41815f431..a3dae26d82d6 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -4818,6 +4818,7 @@ static bool map_is_reuse_compat(const struct bpf_map *map, int map_fd)
 	char msg[STRERR_BUFSIZE];
 	__u32 map_info_len;
 	int err;
+	unsigned int effective_flags = map->def.map_flags;
 
 	map_info_len = sizeof(map_info);
 
@@ -4830,11 +4831,16 @@ static bool map_is_reuse_compat(const struct bpf_map *map, int map_fd)
 		return false;
 	}
 
+	/* The kernel adds RDONLY_PROG to devmaps */
+	if (map->def.type == BPF_MAP_TYPE_DEVMAP ||
+	   map->def.type == BPF_MAP_TYPE_DEVMAP_HASH)
+		effective_flags |= BPF_F_RDONLY_PROG;
+
 	return (map_info.type == map->def.type &&
 		map_info.key_size == map->def.key_size &&
 		map_info.value_size == map->def.value_size &&
 		map_info.max_entries == map->def.max_entries &&
-		map_info.map_flags == map->def.map_flags &&
+		map_info.map_flags == effective_flags &&
 		map_info.map_extra == map->map_extra);
 }
 
-- 
2.30.2

