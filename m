Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87E6F6A45EC
	for <lists+bpf@lfdr.de>; Mon, 27 Feb 2023 16:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjB0PVV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 10:21:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjB0PVR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 10:21:17 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4EF2278B
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 07:21:12 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id a7so3722884pfx.10
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 07:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BoFsRKqLdKP02I7g694Qbh39KZF7kQZ2F0Pz2UqBWn0=;
        b=SzHZN6J2pneLONd0RoNUm+5p31mxowMaJKrZLOvnzgIHpZFxntY48EP4LBvuE6PusF
         p2AvIL32Qg6wgSvE3xbWlxvIW25q3Dre7MCUETTzGlS5cFRxymusIJFtbOpyw5AhhoQi
         bfQY2/dtTKjZ2BLO4MQbDXyAjlPFOGYM422loXfqmImFLihtcDRcW6xTH/SQnD2Ce74T
         x2etirvWQYBT7IngqsRtDzLwsT+irCqN2CIAOaaj+PrxtiG2xEE7ShotAgzP6R5EQ9Gt
         bk7iQhyftqwOqKkhrfd7sKMJbU7fMAWe6nDKtuvhEZ2+GgRhVBj/ahg6HCVSjMO4y9DR
         0qow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BoFsRKqLdKP02I7g694Qbh39KZF7kQZ2F0Pz2UqBWn0=;
        b=HzMPJqXL+pxXfvtcjjU4peX1up5V5BGNw7P8zMREYgA7PRqRAWX4seyc0mSXINmZCc
         fBq8zqKQql2CQV6sBDTv0gib/jVtuirRaBLZrEacYWVk6IKs1KcAP1CDYM4SXGUoOZNV
         0aIS1kv10fZLGgUcx3opu6bQiKUl711Xg5HE1fJInXVq3g+70EMibYmBwRYkCtIVAqNX
         zz+hjFBgUtf33gV72Th2i/BvWIut1IzZ+GkTNo+aBsIny26vA/rjNRFqxbDp5QiK5PYY
         28OXcGBBdjHTr7wkjbC2rZozoShs4X6ccAqj0pzOLw9PLQs27kr7acb1Xzfc9xglNV2P
         0lXw==
X-Gm-Message-State: AO0yUKVBVgwHy3URGvjNsFnJBfAQICLDcmFm+AImjJfgoJHXV6w8Nl5M
        ubwL1AHkBwSiU+7ppoUoAK8=
X-Google-Smtp-Source: AK7set/aO0xiePMsxOjDpq6FFYshpINkQPItrjluzOvhm9pOAX8NXQOLAZYRLfWR5sFOGnLltiJWRA==
X-Received: by 2002:aa7:978e:0:b0:5de:7ef1:d03a with SMTP id o14-20020aa7978e000000b005de7ef1d03amr13440938pfp.19.1677511272361;
        Mon, 27 Feb 2023 07:21:12 -0800 (PST)
Received: from vultr.guest ([2401:c080:1000:4a6a:5400:4ff:fe53:1982])
        by smtp.gmail.com with ESMTPSA id n2-20020a62e502000000b00589a7824703sm4326825pff.194.2023.02.27.07.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 07:21:11 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, horenc@vt.edu,
        xiyou.wangcong@gmail.com
Cc:     bpf@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next v3 08/18] bpf: bloom_filter memory usage
Date:   Mon, 27 Feb 2023 15:20:22 +0000
Message-Id: <20230227152032.12359-9-laoar.shao@gmail.com>
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

Introduce a new helper to calculate the bloom_filter memory usage.

The result as follows,
- before
16: bloom_filter  flags 0x0
        key 0B  value 8B  max_entries 65536  memlock 524288B

- after
16: bloom_filter  flags 0x0
        key 0B  value 8B  max_entries 65536  memlock 65856B

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/bpf/bloom_filter.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/bpf/bloom_filter.c b/kernel/bpf/bloom_filter.c
index 48ee750..6350c5d 100644
--- a/kernel/bpf/bloom_filter.c
+++ b/kernel/bpf/bloom_filter.c
@@ -193,6 +193,17 @@ static int bloom_map_check_btf(const struct bpf_map *map,
 	return btf_type_is_void(key_type) ? 0 : -EINVAL;
 }
 
+static u64 bloom_map_mem_usage(const struct bpf_map *map)
+{
+	struct bpf_bloom_filter *bloom;
+	u64 bitset_bytes;
+
+	bloom = container_of(map, struct bpf_bloom_filter, map);
+	bitset_bytes = BITS_TO_BYTES((u64)bloom->bitset_mask + 1);
+	bitset_bytes = roundup(bitset_bytes, sizeof(unsigned long));
+	return sizeof(*bloom) + bitset_bytes;
+}
+
 BTF_ID_LIST_SINGLE(bpf_bloom_map_btf_ids, struct, bpf_bloom_filter)
 const struct bpf_map_ops bloom_filter_map_ops = {
 	.map_meta_equal = bpf_map_meta_equal,
@@ -206,5 +217,6 @@ static int bloom_map_check_btf(const struct bpf_map *map,
 	.map_update_elem = bloom_map_update_elem,
 	.map_delete_elem = bloom_map_delete_elem,
 	.map_check_btf = bloom_map_check_btf,
+	.map_mem_usage = bloom_map_mem_usage,
 	.map_btf_id = &bpf_bloom_map_btf_ids[0],
 };
-- 
1.8.3.1

