Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70B394811F4
	for <lists+bpf@lfdr.de>; Wed, 29 Dec 2021 12:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239898AbhL2LU7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Dec 2021 06:20:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235496AbhL2LU6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Dec 2021 06:20:58 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CF5C061574
        for <bpf@vger.kernel.org>; Wed, 29 Dec 2021 03:20:58 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id a11-20020a17090a854b00b001b11aae38d6so19655779pjw.2
        for <bpf@vger.kernel.org>; Wed, 29 Dec 2021 03:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=F8SCL4n4jA5uOW0bNl1jsRHB0DLyw7rTLWWqLp0hTUA=;
        b=UEX+E1m3UOb1c3MhR5BXOwcVycnjH/BjRFJ2OEytK1akl1TmuwcolI1j4Ao4N3q9Ob
         do5X+iOMNsokWFHmrUprFavp9YoLcj9Ql18dgAWZUC3udqFXLoPa3rX+LMsXedEnwbrF
         1/iaB5NmP1m5+fC7m7MHuU1HhKrfmTAb/SZDhVYQXxnzPU2WiXZPKH8lTnMJvhXxnQcP
         ZZ4sKkvBTl6ug1DLz5+O6KKMDYsVtOMccfH/MKrfSDJieDMGhdyiZSwByh9efvQ6EVSG
         tC/vZIjgHpEZ30DY+3vc8IU+y4/9f1P5PPl5YDHgIRrREUpCenzuHDBZYFMr+ps3j4aa
         y2Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=F8SCL4n4jA5uOW0bNl1jsRHB0DLyw7rTLWWqLp0hTUA=;
        b=OOvLLsurmqvd3v7GBXlBvSpvUCS1nx3hEN2VNUpbmL7iSm77/e1q1cbaLb5em4sapy
         bhjGgm4OPCGVZIKaE3vUasrhIC2v9lQhBp/mHhCCVADotAv7DlLRQNvMyRtfM90Sps/n
         H/E29w6K/UP1tzwGNu2iwuXZrTZpZntA0vQbd0ZG0sw94+dd/U6fBe6lqdr/MYh0F7bw
         enp/TMtf2lfVl9BfYmfVrl123727dhzc7n7fiRu/PD+/Zq4GtGydphARt6Q/9l7H85Nt
         BT/Eb16yq4TEKhNBkKlVrRdaiJUF24NwXFb4eTiije2hoMP45yx3PhcR7HdBB67hS2jN
         PPpg==
X-Gm-Message-State: AOAM532Yvu1Gvgjk2lUShq5WM1scdue9d49hHKj4M+yyLZJ7Vri4msKr
        amA1QcQ+ApIPp9FWnYIUSRc=
X-Google-Smtp-Source: ABdhPJz90f0j0Y+BoSZH7UKwhuspPrmYqjTPSqaG7FYYfvLSPGX1YFUYoeWjjHgPTEj/NbiYEM4KTg==
X-Received: by 2002:a17:902:8f8a:b0:149:8d21:9f44 with SMTP id z10-20020a1709028f8a00b001498d219f44mr9130735plo.15.1640776857820;
        Wed, 29 Dec 2021 03:20:57 -0800 (PST)
Received: from localhost.localdomain ([43.132.141.4])
        by smtp.gmail.com with ESMTPSA id g11sm19811932pgn.26.2021.12.29.03.20.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Dec 2021 03:20:57 -0800 (PST)
From:   tcs.kernel@gmail.com
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, joannekoong@fb.com,
        bpf@vger.kernel.org
Cc:     Haimin Zhang <tcs_kernel@tencent.com>
Subject: [PATCH v2] bpf: Add missing map_get_next_key method to bloom filter map
Date:   Wed, 29 Dec 2021 19:20:02 +0800
Message-Id: <1640776802-22421-1-git-send-email-tcs.kernel@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Haimin Zhang <tcs_kernel@tencent.com>

Without it, kernel crashes in map_get_next_key().

Fixes: 9330986c0300 ("bpf: Add bloom filter map implementation")

Reported-by: TCS Robot <tcs_robot@tencent.com>
Signed-off-by: Haimin Zhang <tcs_kernel@tencent.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 kernel/bpf/bloom_filter.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/bpf/bloom_filter.c b/kernel/bpf/bloom_filter.c
index 277a05e9c984..fa34dc871995 100644
--- a/kernel/bpf/bloom_filter.c
+++ b/kernel/bpf/bloom_filter.c
@@ -82,6 +82,11 @@ static int bloom_map_delete_elem(struct bpf_map *map, void *value)
 	return -EOPNOTSUPP;
 }
 
+static int bloom_map_get_next_key(struct bpf_map *map, void *key, void *next_key)
+{
+	return -EOPNOTSUPP;
+}
+
 static struct bpf_map *bloom_map_alloc(union bpf_attr *attr)
 {
 	u32 bitset_bytes, bitset_mask, nr_hash_funcs, nr_bits;
@@ -192,6 +197,7 @@ const struct bpf_map_ops bloom_filter_map_ops = {
 	.map_meta_equal = bpf_map_meta_equal,
 	.map_alloc = bloom_map_alloc,
 	.map_free = bloom_map_free,
+	.map_get_next_key = bloom_map_get_next_key,
 	.map_push_elem = bloom_map_push_elem,
 	.map_peek_elem = bloom_map_peek_elem,
 	.map_pop_elem = bloom_map_pop_elem,
-- 
2.27.0

