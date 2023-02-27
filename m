Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0586A45F1
	for <lists+bpf@lfdr.de>; Mon, 27 Feb 2023 16:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjB0PVi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 10:21:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbjB0PVc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 10:21:32 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED3FF22A37
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 07:21:30 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id i5so5373216pla.2
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 07:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZrmMexioGuwPjZT+tUM26QmTb0IQCm4pElgfaJMzHrk=;
        b=INSzJ9kVnP6faYNpbGeh/sY8O0xTC5SlYha3vUD0FMZ26AeKORusNYliSTCXpu7W7g
         3tEFlaTjyJuNCJRKuco2f6UddquR8Qk8BRiF2K0ktMe+fZGaFt98Z6uEtKMFLmuimizT
         ZenFt6xK60U0LjtPO8PRXbwKgdhHG/07oPEEEOz7S4bEwzuUZBuhnOisG+HqqJFriafb
         1h+OSakifDrs9+TFRuO1zlxQ95ZDwEFEsIMOWiDhcskNzSFq00abTP4JOfJIcw5rV4HV
         mFds4JNyC3JISaCG3A0iXtwuoZIC52XHMhpPBfZyY8AUDxfThbl0xJ4b7Me2AxoNbHGM
         GoKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZrmMexioGuwPjZT+tUM26QmTb0IQCm4pElgfaJMzHrk=;
        b=BFPhmMiJy6qpBw6gRu5u5P2iwcEjMXfB/lSgJMoGG2GnW4diX1IQjUASXkkUxOgvY6
         vp36pgekRTFu5/8G6NNGT3JgYXegwJHtpmqp+wJKMY0iJCUurqKYiBjNb3JTq7jXRRe6
         1wRjUjgi6IZMktBT4aSScZTbrtak8KucWXoQNEtlffdr3yHC5w/5Qmk1O0HEDlqGbMrk
         11QOmnha9thiaQl2nFPA/hZN3WGtbyMedOMDmKqfP6S6NKzyyKMu52MS1Pipe9Qq7imt
         VY7jW1PFtWN9mc+ZfUPt4LwTY5/956hclAwf7UZEBv4yNoy1MMg/GgWzjPmIgoPJfWA8
         URww==
X-Gm-Message-State: AO0yUKUK2FTuCkQxp2MpnlBsrBr9DaMqu/7NKRKJxTdLzlHC/MHD40yM
        YYGYRZKkiZiOE6vOPvWtSwg=
X-Google-Smtp-Source: AK7set9W+DE40EBzgn9kt+oxG6wIhXZNVip0zYH7/4jxdDHxqU3iAMKb1T0KH722GxNWJ6kdlx2eOw==
X-Received: by 2002:a05:6a20:1610:b0:be:22c5:92df with SMTP id l16-20020a056a20161000b000be22c592dfmr23119061pzj.16.1677511290448;
        Mon, 27 Feb 2023 07:21:30 -0800 (PST)
Received: from vultr.guest ([2401:c080:1000:4a6a:5400:4ff:fe53:1982])
        by smtp.gmail.com with ESMTPSA id n2-20020a62e502000000b00589a7824703sm4326825pff.194.2023.02.27.07.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 07:21:29 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, horenc@vt.edu,
        xiyou.wangcong@gmail.com
Cc:     bpf@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next v3 13/18] bpf: local_storage memory usage
Date:   Mon, 27 Feb 2023 15:20:27 +0000
Message-Id: <20230227152032.12359-14-laoar.shao@gmail.com>
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

A new helper is introduced to calculate local_storage map memory usage.
Currently the dynamically allocated elements are not counted, since it
will take runtime overhead in the element update or delete path. So
let's put it aside currently, and implement it in the future if the user
really needs it.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/bpf/local_storage.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
index e90d9f6..a993560 100644
--- a/kernel/bpf/local_storage.c
+++ b/kernel/bpf/local_storage.c
@@ -446,6 +446,12 @@ static void cgroup_storage_seq_show_elem(struct bpf_map *map, void *key,
 	rcu_read_unlock();
 }
 
+static u64 cgroup_storage_map_usage(const struct bpf_map *map)
+{
+	/* Currently the dynamically allocated elements are not counted. */
+	return sizeof(struct bpf_cgroup_storage_map);
+}
+
 BTF_ID_LIST_SINGLE(cgroup_storage_map_btf_ids, struct,
 		   bpf_cgroup_storage_map)
 const struct bpf_map_ops cgroup_storage_map_ops = {
@@ -457,6 +463,7 @@ static void cgroup_storage_seq_show_elem(struct bpf_map *map, void *key,
 	.map_delete_elem = cgroup_storage_delete_elem,
 	.map_check_btf = cgroup_storage_check_btf,
 	.map_seq_show_elem = cgroup_storage_seq_show_elem,
+	.map_mem_usage = cgroup_storage_map_usage,
 	.map_btf_id = &cgroup_storage_map_btf_ids[0],
 };
 
-- 
1.8.3.1

