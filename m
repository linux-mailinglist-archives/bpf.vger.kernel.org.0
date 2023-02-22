Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD0169EC7A
	for <lists+bpf@lfdr.de>; Wed, 22 Feb 2023 02:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjBVBqr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Feb 2023 20:46:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjBVBqp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Feb 2023 20:46:45 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F76C32E71
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 17:46:44 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id n20so3628987pfu.12
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 17:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uQuLzFY+KbTi70OVyTdLGmPLsVqTEok0qqP2ZiCsjVY=;
        b=NBuShNdxv+Vt0vrP05nOToADNlNp6uiAZb61nFgnidNQdVBax6k8/NZshT2lyUacBE
         3Am/Ox7IFaClRI2uYK7WxrXhZkdAvbv+ZjsJFGDY9Wc4NBzDYK8GjaKPK+4J1QIc1bp5
         FqkhvkAnCb6BPDWgFoPHFnc00KbCdID4SDNdF0I/QDC4uMSSSs09M2I0YAo6nVX3lIbv
         D34ghOYfLOClaZ/J/AEYvmUV7VUTbsf0i7gCDovDT6bddzsgZmMoaUGKdMT5/wZAd9mG
         OQ0IM5LQpggjHv6i/S5xztGk8H8tptgIOtAXSJkagaubLuPk5+BleCh+ngGOLlo+zKgQ
         RGNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uQuLzFY+KbTi70OVyTdLGmPLsVqTEok0qqP2ZiCsjVY=;
        b=PAqOQGlFVaksEpu0SS+LxmCBt98GissSaHrrjRRDqmBOiigBU/o17VdTTqg5debRYF
         2G60YKis1CtOwswB0vAG70HKwG1yHexjReyOPTJgoTcusBYPOB18+G/1LA3rKxCepotu
         iZbUM5Ir8oUqzZHLIms3vWuAf4i+WsIL1mvCp9neu8mWIgSvnsO3lSrE3TR13lP468it
         m98bxgj/sJ5Cv3QbP/YnG6ZeawGM9HM8Un6RPcHAxbmyKr7bkPpZbs+dIlPOPN5ard7/
         TXyB9BzhvMx2N6oiDFmTYCUTxAUqfoVfhpMfwm1NtDTCIEcjSN2GTZ3blCU2IwsTwGOG
         6Eng==
X-Gm-Message-State: AO0yUKUqlLHKVbQUSZBczSfD5I5FxozGoiUvp2CGVsKhYWUofbp5ldLH
        VeS1YibaGpXS+kdV2DFSnnM=
X-Google-Smtp-Source: AK7set9OSnThucTcbEeXDuOkeP1Te5VFeBoKQggoP71+L13bNlONOlRM30cx98vXTrq3aJgB+OFwDg==
X-Received: by 2002:a62:6185:0:b0:59c:3fd7:45de with SMTP id v127-20020a626185000000b0059c3fd745demr7815887pfb.30.1677030403894;
        Tue, 21 Feb 2023 17:46:43 -0800 (PST)
Received: from vultr.guest ([2001:19f0:7001:5cd8:5400:4ff:fe4e:5fe5])
        by smtp.gmail.com with ESMTPSA id f15-20020aa78b0f000000b005ac419804d3sm3811509pfd.186.2023.02.21.17.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 17:46:43 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, horenc@vt.edu,
        xiyou.wangcong@gmail.com
Cc:     bpf@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next v2 06/18] bpf: reuseport_array memory usage
Date:   Wed, 22 Feb 2023 01:45:41 +0000
Message-Id: <20230222014553.47744-7-laoar.shao@gmail.com>
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

A new helper is introduced to calculate reuseport_array memory usage.

The result as follows,
- before
14: reuseport_sockarray  name count_map  flags 0x0
        key 4B  value 8B  max_entries 65536  memlock 1048576B

- after
14: reuseport_sockarray  name count_map  flags 0x0
        key 4B  value 8B  max_entries 65536  memlock 524544B

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/bpf/reuseport_array.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/bpf/reuseport_array.c b/kernel/bpf/reuseport_array.c
index 82c6161..71cb72f 100644
--- a/kernel/bpf/reuseport_array.c
+++ b/kernel/bpf/reuseport_array.c
@@ -335,6 +335,13 @@ static int reuseport_array_get_next_key(struct bpf_map *map, void *key,
 	return 0;
 }
 
+static u64 reuseport_array_mem_usage(const struct bpf_map *map)
+{
+	struct reuseport_array *array;
+
+	return struct_size(array, ptrs, map->max_entries);
+}
+
 BTF_ID_LIST_SINGLE(reuseport_array_map_btf_ids, struct, reuseport_array)
 const struct bpf_map_ops reuseport_array_ops = {
 	.map_meta_equal = bpf_map_meta_equal,
@@ -344,5 +351,6 @@ static int reuseport_array_get_next_key(struct bpf_map *map, void *key,
 	.map_lookup_elem = reuseport_array_lookup_elem,
 	.map_get_next_key = reuseport_array_get_next_key,
 	.map_delete_elem = reuseport_array_delete_elem,
+	.map_mem_usage = reuseport_array_mem_usage,
 	.map_btf_id = &reuseport_array_map_btf_ids[0],
 };
-- 
1.8.3.1

