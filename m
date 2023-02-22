Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF5F469EC81
	for <lists+bpf@lfdr.de>; Wed, 22 Feb 2023 02:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjBVBrL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Feb 2023 20:47:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjBVBrK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Feb 2023 20:47:10 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6429332E5F
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 17:47:08 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id q5so7127971plh.9
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 17:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZrmMexioGuwPjZT+tUM26QmTb0IQCm4pElgfaJMzHrk=;
        b=A84Zqp37pm8b6jRu9p5nF3vVt2UXVaOl0NgMyukc5ljZURP/8AK0TrYrR67vXOZKdz
         39Nq414nLddorQocHvdRmgc+8EWL+JfdgsmhsH/rKHaXZ1qpsQFak3f1MuAmxET0VMQw
         nOOcT73SS30cJ9EyUyoXEftzGBTDLsJBfmRv8Jqg2jQGzmWKQ1koSX5anoOnr318THKt
         3HZhSAN5lA8cPSa6qsB5bHdfxzT0eobxHeOdKiX1eg94qFtK9JHH2Ep93C4+jWs6MAmL
         m+9JsGzrbrPAU8uYl+RSFHeDY6wueOKEfJN0K2p/NG/QeNkXLmY9bdRiX6Crb2oblWWD
         tvMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZrmMexioGuwPjZT+tUM26QmTb0IQCm4pElgfaJMzHrk=;
        b=m26q+Nz3uK8iJ8Rex6ghJHn3RHezEj8HtEmDPI/UNy+UhfqYVlELJIch45rrflqfiW
         Smj4I8pBCrKmFMynGhByslbk95G+Fir6ink+fNP8Iyrlcz5a0LV0fqeMSKHCgpwHUQid
         ooTtrYCV218iF4pPsVeOxC3nh1xShE8pIza47qGIH6HGuIALEeYNnwWUOWt4WCX8phdI
         /tRRPD2TEhWbVVVCCyvdd5T8Re8N9h5HRWHPPFK6EDlqjjh1+aLLCw8FGJ5xRh3iqNGf
         pJOtrSdNMZWPuEMs2DX5Gi9CkugJDTG+zMAd6GKuX7XrYKQ0XF1cLpbi4isPIWC/dhXv
         VTgA==
X-Gm-Message-State: AO0yUKXvbd09jukvmGFFsl2GYwh15zbKRmbMCtuBqsemOH5FfczDUU2X
        m0RmvOtuuCZS/3sxRQHK+vk=
X-Google-Smtp-Source: AK7set8RgfanBbY6YzM9KHtYZGq0UxafYNqxUCaESWcRV7KVYn+pHqQuStL6dSSk+o8vLluF90/M/A==
X-Received: by 2002:a05:6a20:6a0e:b0:c7:6c6f:76f5 with SMTP id p14-20020a056a206a0e00b000c76c6f76f5mr7442723pzk.51.1677030427901;
        Tue, 21 Feb 2023 17:47:07 -0800 (PST)
Received: from vultr.guest ([2001:19f0:7001:5cd8:5400:4ff:fe4e:5fe5])
        by smtp.gmail.com with ESMTPSA id f15-20020aa78b0f000000b005ac419804d3sm3811509pfd.186.2023.02.21.17.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 17:47:07 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, horenc@vt.edu,
        xiyou.wangcong@gmail.com
Cc:     bpf@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next v2 13/18] bpf: local_storage memory usage
Date:   Wed, 22 Feb 2023 01:45:48 +0000
Message-Id: <20230222014553.47744-14-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230222014553.47744-1-laoar.shao@gmail.com>
References: <20230222014553.47744-1-laoar.shao@gmail.com>
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

