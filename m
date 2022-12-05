Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7353F64243B
	for <lists+bpf@lfdr.de>; Mon,  5 Dec 2022 09:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbiLEINj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 5 Dec 2022 03:13:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231947AbiLEINi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 5 Dec 2022 03:13:38 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4664514D15;
        Mon,  5 Dec 2022 00:13:37 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id 82so9881931pgc.0;
        Mon, 05 Dec 2022 00:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GK4jKzSG54RvyZ+KEwdYXduEIUelDiosExxd97OqALY=;
        b=GzEiHBvWfxb9iLcZDo76VVhe4LVU+PAq3Q10apUfIyG+gfqKIrCG5J77Tf/Lrg51rF
         NYy009DkwlcuWtYFyWiqmD+YecQKQ3K/8biUs3W/4Z2Tsf8QE7BJJoww/ulP7mj59DJn
         v2uvIMWWsYho1jFlD1ARb2HmXc4GaMjCzBifrPdvId8or3CxT7+kFJha+GjAIpUghyST
         HcMkyIfCV6Jbzhc/CIV2/3KyOMeKNz8kVqr6ifKvl+iJA46ZauyIl7Bj20BwP3sLjsEf
         AbD+By5Wi/a7YQCIHBpaYsq6uE/neU1n3w7eTOnADdlJGo5LJmPakMo/IEA23fwc/HE6
         RBPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GK4jKzSG54RvyZ+KEwdYXduEIUelDiosExxd97OqALY=;
        b=AVaroJ0sanKq2aFjc/1Ui51pelMJDk3emm+es/RCn/CNZV/O8Kpc0bq+MDDIESy9Po
         v0ypbQjWLWCGDHo1qXn8Gzt1HDofjWZ3IJ5I2De6cpqS4DurduDjJbmFco24gc2Y9HBV
         12za8PC/FHsx55kyNDmFkd3Bl9EC6Kldcrow1NIZEjZ+BbSRiCmfozuUAO80zPBECX2D
         gs8sbIxL6P3IO3sM9sldoldPiwdRfbDFYY1O/YNpqesmWnxtiDaHdNt3Elx9+3XEP/RV
         MBq7z4/cWBoCw+HM7qjCvOXntdUB30VeH8pOVTVCGEBBUpkVivO2sDEd7ftH/6Sriv3p
         1Dmw==
X-Gm-Message-State: ANoB5pnu0T3n8gpahEE42xr1z1w2qwF0v70dWGQc6QFndqxXgcUEbRdl
        onDRQTzweHX0QMP1mSEqfQw=
X-Google-Smtp-Source: AA0mqf7xjtw5uSPFh0atK5cZUscBp8iw+GZgmBOOQ4XMGt4GR48VE7r2MAtBdYddGmkrnko0rNc4/g==
X-Received: by 2002:a05:6a00:1303:b0:561:7dc7:510b with SMTP id j3-20020a056a00130300b005617dc7510bmr84700767pfu.3.1670228016724;
        Mon, 05 Dec 2022 00:13:36 -0800 (PST)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id x193-20020a6331ca000000b00412a708f38asm7827883pgx.35.2022.12.05.00.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 00:13:36 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Quentin Monnet <quentin@isovalent.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] bpftool: Fix memory leak in do_build_table_cb
Date:   Mon,  5 Dec 2022 12:13:00 +0400
Message-Id: <20221205081300.561974-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

strdup() allocates memory for path. We need to release the memory in
the following error paths. Add free() to avoid memory leak.

Fixes: 8f184732b60b ("bpftool: Switch to libbpf's hashmap for pinned paths of BPF objects")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 tools/bpf/bpftool/common.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
index 0cdb4f711510..8a820356525e 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -499,9 +499,11 @@ static int do_build_table_cb(const char *fpath, const struct stat *sb,
 	if (err) {
 		p_err("failed to append entry to hashmap for ID %u, path '%s': %s",
 		      pinned_info.id, path, strerror(errno));
-		goto out_close;
+		goto out_free;
 	}
 
+out_free:
+	free(path);
 out_close:
 	close(fd);
 out_ret:
-- 
2.25.1

