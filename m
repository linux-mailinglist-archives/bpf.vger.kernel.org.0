Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D35D69EC80
	for <lists+bpf@lfdr.de>; Wed, 22 Feb 2023 02:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjBVBrI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Feb 2023 20:47:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjBVBrH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Feb 2023 20:47:07 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A4B32E66
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 17:47:05 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 130so945033pgg.3
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 17:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X8bqcj+fQi+LPKTwP58l/gYDYaKLYdssShQrHrw6wI4=;
        b=RZtgrjFbj/qO4hAdXILOuF/v0FNCBCBrgYpBkHeDW+BX4n4CbVOvmrEkAzwL3PU/Xb
         GXOLaPrcjOyiddRXJuRIybeffa/1xWZ9XmqAUsSoMTA8uFKboaT6xV2xjT+Bme7bFLLD
         stHJM/Pa050uO8TroQddVYyIA8lrQINBFEGIwUo9qI6Y3xTbRysOyn/LhSVW2nI9dlmK
         Xj6sza/w9LFEXwVWDK7V/rcSybvd7Wv5TqZLgK++0OgkuHW1VcbuRiOVYAkQDQJ8mKd0
         TnL+pMsF1JWul4SipWlJm2bgd2hQLFAjDJSUFPJ3O5l2GmoL6BtolzN3ByX/FrPdZsWT
         s9uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X8bqcj+fQi+LPKTwP58l/gYDYaKLYdssShQrHrw6wI4=;
        b=0Yvi/jkUjyFa303yvUXsme6aFnHqN3CpJ8yFuJMvF5+sMkM+lyEEiGXAWitCj8U5bC
         7e7vI54jB6dUWg1tcn2nf9bFDdN1Q7i8NLyf5o5ptXXLSUGUVeuk/bkMR8rc0ukcf1QJ
         77bmiMTEybGCe33pwbyPpaYxll5RHdprwdsL8UNSQYiGIgUS1gJztIxqjo4rsJvB1wKS
         Y8fDH0x+qsH4zj5FujcK5PFsZ8lTvtIe02o9kD8y+i+epRMbAD74ysIsxji94ZWKiXgV
         XvFi4zpK0yCFp97tu+LDlNZva48j9WZRQYC+74XIkGoC4+N+wG8/1leQfCEhNSvllu1R
         oalw==
X-Gm-Message-State: AO0yUKWZKVMH/vR4CT4eX8MTq1kz33ULoPXEzhb3JZmOIl/afu1qyGbb
        DOUKh6NeJrxcie6NZZjenn8=
X-Google-Smtp-Source: AK7set/FboMQpCSCg3uI2cr7k8FYA1zdC8BAJC2CzJEwD+Bq6ezQPMoXSbCmZpu9gR6m/y9qencjKg==
X-Received: by 2002:a62:1e45:0:b0:5a9:e8dd:80ea with SMTP id e66-20020a621e45000000b005a9e8dd80eamr6052241pfe.17.1677030424498;
        Tue, 21 Feb 2023 17:47:04 -0800 (PST)
Received: from vultr.guest ([2001:19f0:7001:5cd8:5400:4ff:fe4e:5fe5])
        by smtp.gmail.com with ESMTPSA id f15-20020aa78b0f000000b005ac419804d3sm3811509pfd.186.2023.02.21.17.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 17:47:04 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, horenc@vt.edu,
        xiyou.wangcong@gmail.com
Cc:     bpf@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next v2 12/18] bpf: bpf_struct_ops memory usage
Date:   Wed, 22 Feb 2023 01:45:47 +0000
Message-Id: <20230222014553.47744-13-laoar.shao@gmail.com>
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

A new helper is introduced to calculate bpf_struct_ops memory usage.

The result as follows,

- before
1: struct_ops  name count_map  flags 0x0
        key 4B  value 256B  max_entries 1  memlock 4096B
        btf_id 73

- after
1: struct_ops  name count_map  flags 0x0
        key 4B  value 256B  max_entries 1  memlock 5016B
        btf_id 73

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/bpf/bpf_struct_ops.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index ece9870..38903fb 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -641,6 +641,21 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 	return map;
 }
 
+static u64 bpf_struct_ops_map_mem_usage(const struct bpf_map *map)
+{
+	struct bpf_struct_ops_map *st_map = (struct bpf_struct_ops_map *)map;
+	const struct bpf_struct_ops *st_ops = st_map->st_ops;
+	const struct btf_type *vt = st_ops->value_type;
+	u64 usage;
+
+	usage = sizeof(*st_map) +
+			vt->size - sizeof(struct bpf_struct_ops_value);
+	usage += vt->size;
+	usage += btf_type_vlen(vt) * sizeof(struct bpf_links *);
+	usage += PAGE_SIZE;
+	return usage;
+}
+
 BTF_ID_LIST_SINGLE(bpf_struct_ops_map_btf_ids, struct, bpf_struct_ops_map)
 const struct bpf_map_ops bpf_struct_ops_map_ops = {
 	.map_alloc_check = bpf_struct_ops_map_alloc_check,
@@ -651,6 +666,7 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 	.map_delete_elem = bpf_struct_ops_map_delete_elem,
 	.map_update_elem = bpf_struct_ops_map_update_elem,
 	.map_seq_show_elem = bpf_struct_ops_map_seq_show_elem,
+	.map_mem_usage = bpf_struct_ops_map_mem_usage,
 	.map_btf_id = &bpf_struct_ops_map_btf_ids[0],
 };
 
-- 
1.8.3.1

