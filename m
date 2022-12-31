Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9CB65A573
	for <lists+bpf@lfdr.de>; Sat, 31 Dec 2022 16:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbiLaPPV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 31 Dec 2022 10:15:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbiLaPPT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 31 Dec 2022 10:15:19 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C924C310;
        Sat, 31 Dec 2022 07:15:18 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id a30so496320pfr.6;
        Sat, 31 Dec 2022 07:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z1dUhnKe7gxJ0QUpJzxtakKCkxVA8FGz20WPR9Jz1/A=;
        b=Pfsdy4keTpSvVmVxuLNg3r5OP9eykOkfltTBMdPNeiWVWNbSgdh68ebjMbbkbmA3rS
         Ym56ZntslJpWn+omQpg3lnWStnO5L6Kept6rCqyNP0RtfHjAaF+0P2quWeZtMziPkltA
         sBvlfEeFyhI+4B09Ht1iLsYQ4veFIxPYk/7t7uItzCgMT3HFc/WQIA7VT0TAYNDkkJGv
         VgqZGiUpSZCa9g7Lk+o1V7Ar8v1rjyT5fk+jtMbTy75ufNZRKl0u/tCl/9SPbL+7mrWO
         SaCpkuMSmEKk9l8pXvt8kA5tjWPnp5Z/0AyPvkKNUXckJJq9si3owYvJ9FiM28AK795x
         mYeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z1dUhnKe7gxJ0QUpJzxtakKCkxVA8FGz20WPR9Jz1/A=;
        b=j8Efpbm2WzfH4nCGfh2Li+aLew9v4XSjfLP3YhHRHS7PWyyypZu/gsZemrM95jZ3gb
         Dn0zDbhuyFEfBWiN1S3gKMRtD/mSMIIa2syrdap9mP9a85mpzDh/Eoo5gU4rL2DvnqqH
         R/qQwNgBcAH6uE0k7wQdbshR/0fAcLAezl0d+zaAmzC+m4qY3c6QIr8CytgHi3SPR45c
         1DFPjih3vRZkOFxBtmHAa3i15Saf/tIrRYWrSCaulWCBwIXcShOZCVz5paCnksENXCGe
         JMIYPnfssjmbii0tsHcwtXXxzBjinRJCzFqNPstQjLEgUjS63hPqjMy2sJhBxLbOLl8h
         h/dA==
X-Gm-Message-State: AFqh2ko8amsH4ybileQqVLA5KqQ3S3RsBioX3m6+CIQeKuFpxm8ayjAn
        6RrCimd+C1/kdvreGhLZ0Gk=
X-Google-Smtp-Source: AMrXdXs3YnXxZr6dG5JSm/x6WvFszUmSOBr+k+fIrvn/yzJzy3QICOwDWoWaupvMdkjeDVOWj7Ydtg==
X-Received: by 2002:aa7:9284:0:b0:581:6069:5c00 with SMTP id j4-20020aa79284000000b0058160695c00mr17152838pfa.28.1672499718315;
        Sat, 31 Dec 2022 07:15:18 -0800 (PST)
Received: from WRT-WX9.. ([103.135.103.220])
        by smtp.gmail.com with ESMTPSA id a8-20020aa78e88000000b005765a5ff1fasm385992pfr.213.2022.12.31.07.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Dec 2022 07:15:17 -0800 (PST)
From:   Changbin Du <changbin.du@gmail.com>
To:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>,
        Leo Yan <leo.yan@linaro.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: [PATCH] libbpf: Return -ENODATA for missing btf section
Date:   Sat, 31 Dec 2022 23:14:36 +0800
Message-Id: <20221231151436.6541-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.37.2
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

As discussed before, return -ENODATA (No data available) would be more
meaningful than ENOENT (No such file or directory).

Suggested-by: Leo Yan <leo.yan@linaro.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 tools/lib/bpf/btf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index dd2badf1a54e..2c89454c0136 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -991,7 +991,7 @@ static struct btf *btf_parse_elf(const char *path, struct btf *base_btf,
 
 	if (!btf_data) {
 		pr_warn("failed to find '%s' ELF section in %s\n", BTF_ELF_SEC, path);
-		err = -ENOENT;
+		err = -ENODATA;
 		goto done;
 	}
 	btf = btf_new(btf_data->d_buf, btf_data->d_size, base_btf);
-- 
2.37.2

