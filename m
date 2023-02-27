Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 007C46A45F6
	for <lists+bpf@lfdr.de>; Mon, 27 Feb 2023 16:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjB0PVt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 10:21:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjB0PVt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 10:21:49 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D0621949
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 07:21:48 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id z10so3753453pgr.8
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 07:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C2WET1805ss0lLQGWaW2KlvdzMS5ESAXwecQVAlAkQw=;
        b=ZtTkQdamdKAtOOEYrLn8LYY6/2UIZqrLPtp9xLbiFGGJTDG1WpdmeDKA4AcGsOhULa
         suJcOz8MKjkz5WTSzuNUwwleDEmt304Avr+bAxX1AvSspONOJAQE/0k8B2u/E5F7TfXP
         lftkq+Hun7ZfhkyhhdWqYjctV+KhgEutRwGIuvVLddtM2T3Beb092+XvZ8HjqJ65Pbx2
         LIU2LYynwDY+2fTdSFMqN3LLYFFF+5TQKIG+wGuSeC5HtbseoqHvGp1ieQ1xgX19FBY+
         TzFL6KvA/B3Vlh1JUUHZ91NAmvElxY99SBen37yJ5rYbi1TLgDSmXJnXfzS/c2Aw26su
         tN2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C2WET1805ss0lLQGWaW2KlvdzMS5ESAXwecQVAlAkQw=;
        b=rCEwrPb7FQB6nEMs0L/rgLCaxf+jV8rDL4rQoHmjBVE9j+MLM8q2uGmvVojJMj589E
         s09jV1xo0eu5XkyJOs4gFlWA53KCuyT+Z1EAy0Q7++4qA+gtXiH4JHsJR1XU4IE500GI
         Hbmxy58TIXakT2A2eg/UsWiM/VP7/t/XVOHE7yvimH2VdUZbdPNACbkVgMFpz95rxWMg
         xXzxeQ7d9OPPFqEBHXoNSQehx5z9LRHiDDJHco2suiLsiPCIwsVErrzy23bod2bG1vrm
         KmFZVuAFILX2SSRDpbOeh9eWZH4qrgI+MNAMeU9VUTPUsR4FvTJA6Kf2Xc6WYBSt11Iq
         ZcmQ==
X-Gm-Message-State: AO0yUKVB9gu3rcpo4oQdjjzUhm9jfz2k2fdPNIErjqM7uzO/xXfHDkuQ
        cejd/pz7cjV50aK2vKvQTaQ=
X-Google-Smtp-Source: AK7set/vm/m8K9DddpbtBNwc8UvE5zlH1JQpWsoJ7w4jCTTK9uzPAKCwv+Y4z6mXk5FqGXEej6U/oA==
X-Received: by 2002:aa7:98de:0:b0:598:b178:a3a9 with SMTP id e30-20020aa798de000000b00598b178a3a9mr22878616pfm.6.1677511307669;
        Mon, 27 Feb 2023 07:21:47 -0800 (PST)
Received: from vultr.guest ([2401:c080:1000:4a6a:5400:4ff:fe53:1982])
        by smtp.gmail.com with ESMTPSA id n2-20020a62e502000000b00589a7824703sm4326825pff.194.2023.02.27.07.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 07:21:47 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, horenc@vt.edu,
        xiyou.wangcong@gmail.com
Cc:     bpf@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next v3 18/18] bpf: enforce all maps having memory usage callback
Date:   Mon, 27 Feb 2023 15:20:32 +0000
Message-Id: <20230227152032.12359-19-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230227152032.12359-1-laoar.shao@gmail.com>
References: <20230227152032.12359-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

We have implemented memory usage callback for all maps, and we enforce
any newly added map having a callback as well. We will check the
callback at map creation time. If a map doesn't have the callback, it
will return EINVAL.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/bpf/syscall.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index e12b03e..cbe7ff3 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -129,6 +129,8 @@ static struct bpf_map *find_and_alloc_map(union bpf_attr *attr)
 	}
 	if (attr->map_ifindex)
 		ops = &bpf_map_offload_ops;
+	if (!ops->map_mem_usage)
+		return ERR_PTR(-EINVAL);
 	map = ops->map_alloc(attr);
 	if (IS_ERR(map))
 		return map;
@@ -775,13 +777,7 @@ static fmode_t map_get_sys_perms(struct bpf_map *map, struct fd f)
 /* Show the memory usage of a bpf map */
 static u64 bpf_map_memory_usage(const struct bpf_map *map)
 {
-	unsigned long size;
-
-	if (map->ops->map_mem_usage)
-		return map->ops->map_mem_usage(map);
-
-	size = round_up(map->key_size + bpf_map_value_size(map), 8);
-	return round_up(map->max_entries * size, PAGE_SIZE);
+	return map->ops->map_mem_usage(map);
 }
 
 static void bpf_map_show_fdinfo(struct seq_file *m, struct file *filp)
-- 
1.8.3.1

