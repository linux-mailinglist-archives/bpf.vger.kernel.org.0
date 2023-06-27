Return-Path: <bpf+bounces-3600-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD8A7405C0
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 23:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C814A1C20A6F
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 21:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B167498;
	Tue, 27 Jun 2023 21:39:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABDD7473
	for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 21:39:19 +0000 (UTC)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8445F213F
	for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 14:39:17 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-262d33fa37cso1904941a91.3
        for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 14:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1687901956; x=1690493956;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zZ9y6QRdu6OKqSRcId44hSNEZdSQokxImaizAMqnnzI=;
        b=ciUhEUEh/fgucB23VxRKLV1NC22GCX6+ff4NC2K1rkG9+pevOiXlEnSmnchNBAJNNM
         YNgttOuAMH8povK7lkCpU8Wr0+YqBui4rnkAvaEtwJb5AmbQUG7Kb+iX/KMg4RH1o7zs
         lD6M1IpvHfLTcbDPSXSKt5X8suHpljLzPOB0mtSiD1OzVBl5tmXQFkKXYtWx1ypiLDQj
         PIXYRwKJxesV1CgpEUKBpSSQGSbt5mb+zKIO1VUl0C2ARH+M/0pYvyyQi0SeKWZgjDZE
         wBHa2nYh114uI7gvhpLeH/3zI9o3TEJ3u30qbVJ+p/A71a3ZpF9ZvtKROjIK3xeLBNMB
         CK7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687901956; x=1690493956;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zZ9y6QRdu6OKqSRcId44hSNEZdSQokxImaizAMqnnzI=;
        b=ZN1BDs+7nNvSczEFtSmSfDh5zQZCkcODE7Kqe3D1Xf808FA4e0cE8YLzKcfFfX/ziK
         kpPLLjJT3ibEnY8/a5rc4thfQN3fVs8Ohgse384kUOvkxbP/YtLCnwhWXreEQMz2GVkB
         1XvLYGL7WHaWtXALuMllGgZBNFlEICh4dyIPLTTQ86KCaBS2XCGitpmQC210NYk3q739
         TJwn0WzRlFICsNgk5xNKeIy8F2NuzABW5/A7ywoE8JODsns9fVvziE17wdTovY9nI7QT
         xIGQqNuOABcA9bcNP1RJLK3X1DrytdqeXA5j8qGlmBdStqJhPdkS8/dnDZlEce5dZbNX
         rdiA==
X-Gm-Message-State: AC+VfDyIuxFjicHUo9Ry/Ly3OtWHmEFSPRluF17iYbPnmHj2yUAxHUfQ
	yWmdrxNSCMfNHTMyl6A6bMv4ofkvm2k=
X-Google-Smtp-Source: ACHHUZ7PHwh1JD5aoBDpi0RLH0WnbNgHMPjyzfz+jYm5rMBJ+5rYpskko1BcZmOiT4jhlGt9JRHHEg==
X-Received: by 2002:a17:90a:a789:b0:263:b62:4472 with SMTP id f9-20020a17090aa78900b002630b624472mr3253770pjq.48.1687901956607;
        Tue, 27 Jun 2023 14:39:16 -0700 (PDT)
Received: from mariner-vm.. (c-71-197-160-159.hsd1.wa.comcast.net. [71.197.160.159])
        by smtp.gmail.com with ESMTPSA id sj18-20020a17090b2d9200b00262ec29ef90sm4631122pjb.21.2023.06.27.14.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 14:39:16 -0700 (PDT)
From: Dave Thaler <dthaler1968@googlemail.com>
To: bpf@vger.kernel.org
Cc: bpf@ietf.org,
	Dave Thaler <dthaler@microsoft.com>
Subject: [PATCH bpf-next] Fix definition of BPF_NEG operation
Date: Tue, 27 Jun 2023 21:39:12 +0000
Message-Id: <20230627213912.951-1-dthaler1968@googlemail.com>
X-Mailer: git-send-email 2.33.4
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Dave Thaler <dthaler@microsoft.com>

Instruction is an arithmetic negative, not a bitwise inverse.

Signed-off-by: Dave Thaler <dthaler@microsoft.com>
---
 Documentation/bpf/instruction-set.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
index 6644842cd3e..751e657973f 100644
--- a/Documentation/bpf/instruction-set.rst
+++ b/Documentation/bpf/instruction-set.rst
@@ -165,7 +165,7 @@ BPF_OR    0x40   dst \|= src
 BPF_AND   0x50   dst &= src
 BPF_LSH   0x60   dst <<= (src & mask)
 BPF_RSH   0x70   dst >>= (src & mask)
-BPF_NEG   0x80   dst = ~src
+BPF_NEG   0x80   dst = -src
 BPF_MOD   0x90   dst = (src != 0) ? (dst % src) : dst
 BPF_XOR   0xa0   dst ^= src
 BPF_MOV   0xb0   dst = src
-- 
2.33.4


