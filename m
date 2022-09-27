Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8DC5ECC1A
	for <lists+bpf@lfdr.de>; Tue, 27 Sep 2022 20:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbiI0SYN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Sep 2022 14:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbiI0SYL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Sep 2022 14:24:11 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B22103FFD
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 11:24:11 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-3529d05e592so11346517b3.0
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 11:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=XTqH961Fvd1rUnG/PDpnY8xibT6zV/TBgIKOhPTL8fs=;
        b=Wkv0KU0fDcEiJX8zZPhXvO6LkTsbl31ppGg9s4nD9j5gF9QZBMr9rstFzcPjRCQ43M
         /FRZ9B8j03WROOrBy4/3N355QBZIbjYXYAIT9jWu66PscNgU/WrOGiF5ftkf1cKhb25j
         qmqn0eQrmIhMi2SAqDzY6709PEdAd+tckHaKsFVwCtodZllpecmYgtjc3zIYhxzL3t77
         Y7YS5zktSkRMpF4sOLfJr2aqpHH0zxrb2vDyDOytH2XrRV8jyDLjdjIa3kJQzewdPTqn
         nPQVBZzZteNGiaVctsuisKl82pQ8LJyf+q+9zods37U/whyI59GiPbCP0+cXqZhXNS06
         HXMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=XTqH961Fvd1rUnG/PDpnY8xibT6zV/TBgIKOhPTL8fs=;
        b=Amq3/QR5rVBWwqhJqjj253YjGXr6FOE4aJTKxau/yI4IvuYFgTpfutxD3NcC0j/Y4V
         6DEAq9k5UjWEw1a97qVQfjJSMIbK+MIPbGuiIVww710sRF33Dfbt1XmG3z9kxoYLBDGy
         6L190pcdxfI/EkrvF+UkBOx6tuSCrJx/htmIRq6MnWW6STrCXIzXR+wQXEN2Wrz/krax
         v+gvNk+/4ijD2VzFjPEjEudhSKLPNx7whAfUDRm/llhshEvQ/t1RtghOoT7GaqW9vEHl
         bXtJjtvSkmv3/FC7ugmlu11spbvIVTcxoJOWlay6NxU+fO66EjzBAuP+5kINMUYrOGOt
         0INg==
X-Gm-Message-State: ACrzQf0CegO4xrWxe7XU61Mi3Nc9P3l29mL1EPvJL+KeTvAheIRuCk38
        sgodVn1HnihA3oDdPoIGsi6rFKigeAXiWBDPeRu+cmK0u+mecfsbXDncf6UFyRsKEembmFV4jfb
        a4IdWJmRMvhLEUcj7F8zwBXavx9Fzy+Xv0ElwATU9c51XizWXaGN6rRws0oCiRIegMGZN
X-Google-Smtp-Source: AMsMyM7xLUlGZtH2mJzz2XGVTL3j9ZVBx2zlHfTMYf7+EBOzsewDGo3hZaFwLo9QXuzB2nFKgm9vQrFMyibMzwco
X-Received: from pnaduthota.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:4e5])
 (user=pnaduthota job=sendgmr) by 2002:a0d:e692:0:b0:349:729f:c74a with SMTP
 id p140-20020a0de692000000b00349729fc74amr26143109ywe.310.1664303050513; Tue,
 27 Sep 2022 11:24:10 -0700 (PDT)
Date:   Tue, 27 Sep 2022 18:23:44 +0000
In-Reply-To: <20220927182345.149171-1-pnaduthota@google.com>
Mime-Version: 1.0
References: <20220927182345.149171-1-pnaduthota@google.com>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
Message-ID: <20220927182345.149171-2-pnaduthota@google.com>
Subject: [PATCH bpf 1/2] Ignore RDONLY_PROG for devmaps in libbpf to allow
 re-loading of pinned devmaps
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
index 50d41815f4..a3dae26d82 100644
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
+	    map->def.type == BPF_MAP_TYPE_DEVMAP_HASH)
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

