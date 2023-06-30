Return-Path: <bpf+bounces-3765-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2013743706
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 10:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DCD9280D30
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 08:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B91FC09;
	Fri, 30 Jun 2023 08:24:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BB5FBF0
	for <bpf@vger.kernel.org>; Fri, 30 Jun 2023 08:24:25 +0000 (UTC)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78836125
	for <bpf@vger.kernel.org>; Fri, 30 Jun 2023 01:24:24 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f973035d60so2589031e87.3
        for <bpf@vger.kernel.org>; Fri, 30 Jun 2023 01:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1688113463; x=1690705463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rx0VMyak3nyRLdbXQ2+B5IoThRJzYj7fu4JJH7XaqgQ=;
        b=WTWDCFwpXJLtWg/lTVgyMC0urhBT1j07/jsHagER3zsgKuUsBZW+u5iz0wCfAWK+eB
         0DMrffUJ6kxexBCy9Rw4WpwtaqQaibdwobJY6aWpbZ/flF0OqJovpE7T/1Evpv9ROMir
         MzZw9+Z+Rlm1uS2T1RcrHPFHcdDOh73Rt33fOs9Px5aDsXz1WnjLiFqT/goBO9683PGf
         Y1ct0BUQUsTAclwynoDOakBFbSvBiWdMQRDaPSdb10Up9hjyDdZlq2VY9Ncol29HbZSt
         nZbCZRf0KJuuaFAJLxVQQu4yPfoQilLtLh8PAYWP5cXT3fRxcyFlhg+AcwECBOUkjb7h
         QIIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688113463; x=1690705463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rx0VMyak3nyRLdbXQ2+B5IoThRJzYj7fu4JJH7XaqgQ=;
        b=Brd14tf+wJvYnPCc7XkRDrbic6WZpCWuxyv/k6imHIS4v0vaXWXsMGheF+aNUfcYd0
         aBpPe8+sBtTl/Jy6YGZArAnvemq6CMsgKpayvvMHrLDpiNNHXeL8ZYpOlMWvr4W8nCNq
         alKWcYe6HDFDVzuzeGVCRZ/8pc/yZwzB6T3jhRcaMcvmNjLox9RKjZ2AmY7kUl+cC8QJ
         /Hj07yxF4s0ooKH1X8A0gNexe7yEOdqzzuyLGfTpcM807mo7FHscEthhlgQzPBjL3u7u
         PxT4OP/2vb+r4H0A7RW5SDqds+WjhKcuHbvqt4X3oqDi7BRahFbWAA4LpJoYz64x5/TW
         owiQ==
X-Gm-Message-State: ABy/qLbSUhbdXr2Ms6JVTF3hpfnlCxflY0IIAAR2I5qUAeaeCG0L3D3E
	bm56v02AnfDhO7XGhv+CHL+plg==
X-Google-Smtp-Source: APBJJlFEraeKNCvDFcNTLKhqlus2qn8XQdhcpwN7HTJTskhOTiBQebEAejKL+5dwizJuj6cP2CAxVg==
X-Received: by 2002:a05:6512:472:b0:4f9:5a87:1028 with SMTP id x18-20020a056512047200b004f95a871028mr1419429lfd.30.1688113462800;
        Fri, 30 Jun 2023 01:24:22 -0700 (PDT)
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id h2-20020a1ccc02000000b003fa74bff02asm18189941wmb.26.2023.06.30.01.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 01:24:22 -0700 (PDT)
From: Anton Protopopov <aspsk@isovalent.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org
Cc: Anton Protopopov <aspsk@isovalent.com>
Subject: [v3 PATCH bpf-next 6/6] selftests/bpf: check that ->elem_count is non-zero for the hash map
Date: Fri, 30 Jun 2023 08:25:16 +0000
Message-Id: <20230630082516.16286-7-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230630082516.16286-1-aspsk@isovalent.com>
References: <20230630082516.16286-1-aspsk@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Previous commits populated the ->elem_count per-cpu pointer for hash maps.
Check that this pointer is non-NULL in an existing map.

Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
---
 tools/testing/selftests/bpf/progs/map_ptr_kern.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/map_ptr_kern.c b/tools/testing/selftests/bpf/progs/map_ptr_kern.c
index db388f593d0a..d6e234a37ccb 100644
--- a/tools/testing/selftests/bpf/progs/map_ptr_kern.c
+++ b/tools/testing/selftests/bpf/progs/map_ptr_kern.c
@@ -33,6 +33,7 @@ struct bpf_map {
 	__u32 value_size;
 	__u32 max_entries;
 	__u32 id;
+	__s64 *elem_count;
 } __attribute__((preserve_access_index));
 
 static inline int check_bpf_map_fields(struct bpf_map *map, __u32 key_size,
@@ -111,6 +112,8 @@ static inline int check_hash(void)
 
 	VERIFY(check_default_noinline(&hash->map, map));
 
+	VERIFY(map->elem_count != NULL);
+
 	VERIFY(hash->n_buckets == MAX_ENTRIES);
 	VERIFY(hash->elem_size == 64);
 
-- 
2.34.1


